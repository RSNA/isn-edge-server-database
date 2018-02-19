DO language plpgsql $$
BEGIN

IF (select count(*) from schema_version) > 0 THEN
  UPDATE schema_version SET version='5.0.0', modified_date=now();
ELSE
  INSERT INTO schema_version(version, modified_date) values('5.0.0', now());
END IF;

-- v4.0: latest exam status decided by report_id which is the order of when the event was inserted
-- instead of status_timestamp to handle rescheduled exams
DROP VIEW v_exam_status;
CREATE OR REPLACE VIEW v_exam_status AS 
SELECT p.patient_id, p.mrn, p.patient_name, p.dob, p.sex, p.street, p.city, p.state, p.zip_code, 
p.email_address, e.exam_id, e.accession_number, e.exam_description, r.report_id, r.status, 
r.status_timestamp, r.report_text, r.dictator, r.transcriber, r.signer
   FROM patients p
   JOIN exams e ON p.patient_id = e.patient_id
   JOIN ( SELECT r1.report_id, r1.exam_id, r1.proc_code, r1.status, r1.status_timestamp, r1.report_text, r1.signer, r1.dictator, r1.transcriber, r1.modified_date
      FROM reports r1
      WHERE r1.report_id = (SELECT r2.report_id FROM reports r2 WHERE r2.exam_id = r1.exam_id ORDER BY r2.report_id DESC LIMIT 1)
) r ON e.exam_id = r.exam_id;

ALTER TABLE v_exam_status OWNER TO edge;

ALTER TABLE job_sets ADD COLUMN phone_number character varying(20);
ALTER TABLE job_sets ADD COLUMN global_id character varying(64);
ALTER TABLE job_sets ADD COLUMN global_aa character varying(64);
ALTER TABLE patients ADD COLUMN autosend boolean DEFAULT false;

--Update configurations
UPDATE configurations SET value='TBD' WHERE key='iti41-source-id';
-- These next 4 lines are for the test Clearinghouse.
INSERT INTO configurations (key,value,modified_date) VALUES ('iti41-doc-endpoint-uri','https://64.28.70.198:8443/XDImgService/services/xdrreceiver', '2018-01-12 11:00:00.000+00');
INSERT INTO configurations (key,value,modified_date) VALUES ('iti41-img-endpoint-uri','https://64.28.70.198:8443/XDImgService/services/xdrreceiver', '2018-01-12 11:00:00.000+00');
UPDATE configurations SET value='mllps://64.28.70.198:8444' WHERE key='iti8-reg-uri';
INSERT INTO configurations (key,value,modified_date) VALUES ('iti9-pix-uri','mllps://64.28.70.198:8444', '2018-01-12 11:00:00.000+00');
-- End of entries for test Clearinghouse
DELETE FROM configurations WHERE key='iti8-pix-uri';

INSERT INTO configurations (key,value,modified_date) VALUES ('pdf-template','false', '2018-01-12 11:00:00.000+00');INSERT INTO configurations (key,value,modified_date) VALUES ('rsna-assigning-authority','1.3.6.1.4.1.19376.3.840.1.1.1', '2018-01-12 11:00:00.000+00');
INSERT INTO configurations (key,value,modified_date) VALUES ('site-assigning-authority','TBD', '2018-01-12 11:00:00.000+00');
DELETE FROM configurations WHERE key='iti41-endpoint-uri-test';
DELETE FROM configurations WHERE key='iti41-endpoint-uri';
DELETE FROM configurations WHERE key='tmp-dir-path';

--INSERT INTO configurations (key,value) VALUES ('scp-max-send-pdu-length','16364');
--INSERT INTO configurations (key,value) VALUES ('scp-max-receive-pdu-length','16364');

INSERT INTO public.users (user_login, user_name,role_id)
SELECT 'AUTOSEND','System AutoSend',0
WHERE NOT EXISTS (SELECT user_id FROM public.users WHERE user_login='AUTOSEND');

-- On each new incoming exam, create job if patient marked for autosend
CREATE OR REPLACE FUNCTION fn_exam_autosend() RETURNS trigger AS $exam_autosend$
DECLARE
	v_email_address character varying(255);
	v_single_use_patient_id character varying(64);
	v_access_code character varying(64);
	v_max_retries integer;
	v_user_id integer;
	v_job_set_id integer;
	v_job_id integer;
BEGIN
	-- the exam belongs to patient with autosend flag is true
	IF (SELECT autosend FROM patients WHERE patient_id=NEW.patient_id) THEN
		SELECT email_address,single_use_patient_id,access_code
		INTO v_email_address,v_single_use_patient_id,v_access_code
		FROM job_sets
		WHERE patient_id = NEW.patient_id
		ORDER BY modified_date DESC
		FETCH FIRST 1 ROW ONLY;

		IF v_single_use_patient_id IS NOT NULL THEN
			SELECT value INTO v_max_retries FROM configurations WHERE key='max-retries';
			SELECT user_id INTO v_user_id FROM users WHERE user_login='AUTOSEND';

			INSERT INTO job_sets (patient_id,user_id,email_address,single_use_patient_id,access_code)
			VALUES (NEW.patient_id,v_user_id,v_email_address,v_single_use_patient_id,v_access_code)
			RETURNING job_set_id INTO v_job_set_id;

			INSERT INTO jobs (job_set_id,exam_id,remaining_retries)
			VALUES (v_job_set_id,NEW.exam_id,v_max_retries)
			RETURNING job_id INTO v_job_id;

			INSERT INTO transactions (job_id,status_code,comments)
			VALUES (v_job_id,1,'Queued');
		END IF;
	END IF;
	RETURN NEW;
END;
$exam_autosend$ LANGUAGE plpgsql;
ALTER FUNCTION fn_exam_autosend() OWNER TO edge;

CREATE TRIGGER trigger_exam_autosend AFTER INSERT ON exams
	FOR EACH ROW EXECUTE PROCEDURE fn_exam_autosend();

-- v_job_status update to include access_code, phone_number
DROP VIEW v_job_status;
CREATE OR REPLACE VIEW v_job_status AS
 SELECT js.job_set_id,
    j.job_id,
    j.exam_id,
    js.delay_in_hrs,
    t.status,
    t.status_message,
    t.modified_date AS last_transaction_timestamp,
    js.single_use_patient_id,
    js.email_address,
	js.phone_number,
    t.comments,
    js.send_on_complete,
	js.access_code,
    j.remaining_retries,
    js.send_to_site
   FROM jobs j
     JOIN job_sets js ON j.job_set_id = js.job_set_id
     JOIN ( SELECT t1.job_id,
            t1.status_code AS status,
            sc.description AS status_message,
            t1.comments,
            t1.modified_date
           FROM transactions t1
             JOIN status_codes sc ON t1.status_code = sc.status_code
          WHERE t1.modified_date = (( SELECT max(t2.modified_date) AS max
                   FROM transactions t2
                  WHERE t2.job_id = t1.job_id))) t ON j.job_id = t.job_id;

ALTER TABLE v_job_status OWNER TO edge;

-- Table: sms_configurations
CREATE TABLE sms_configurations
(
  "key" character varying NOT NULL,
  "value" character varying NOT NULL,
  modified_date timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_sms_configuration_key PRIMARY KEY (key)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sms_configurations OWNER TO edge;
COMMENT ON TABLE sms_configurations IS 'This table is used to store SMS configuration as key/value pairs';

INSERT INTO sms_configurations VALUES ('enable_sms','false',now());
INSERT INTO sms_configurations VALUES ('account_id','',now());
INSERT INTO sms_configurations VALUES ('token','',now());
INSERT INTO sms_configurations VALUES ('sender','',now());
INSERT INTO sms_configurations VALUES ('body','Your imaging results are ready to be accessed. Your Access Code is $accesscode$. Instructions available at http://www.rsna.org/image_share.aspx.',now());
INSERT INTO sms_configurations VALUES ('proxy_host','192.203.117.40',now());
INSERT INTO sms_configurations VALUES ('proxy_port','3128',now());
INSERT INTO sms_configurations VALUES ('proxy_set','false',now());

-- Table: sms_jobs
CREATE TABLE sms_jobs
(
  sms_job_id serial NOT NULL,
  recipient character varying NOT NULL,
  message	text,
  sent		boolean NOT NULL DEFAULT false,
  failed	boolean NOT NULL DEFAULT false,
  comments	character varying,
  created_date	timestamp with time zone NOT NULL,
  modified_date timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_sms_job_id PRIMARY KEY (sms_job_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sms_jobs OWNER TO edge;
COMMENT ON TABLE sms_jobs IS 'This table is used to store queued SMS messages. Jobs within the queue will be handled by a worker thread which is responsible for handling any send failures and retrying failed jobs';

--Update email content
UPDATE email_configurations
SET value = '<b><font size="24">RSNA Image Share</font></b><br><b><i><font size="5">Take Control of Your Medical Images</font></i></b></h2><br><br><br>Dear $patientname$,<br><br>Welcome to Image Share, a network designed to enable patients to access and control their medical imaging results. Image Share was developed by the Radiological Society of North America (RSNA) and its partners, with funding from the National Institute of Biomedical Imaging and Bioengineering.<br><br>You are receiving this message because the radiology staff at $site_id$ have sent your imaging results to a secure online data repository so you can access them.<br><br>To access your images:<br><br><ol><li><b>Create a personal health record (PHR) account on one of the participating image-enabled PHR systems.</b> If you created an account following an earlier visit, simply log in. You can create an account on one of the following participating sites:<br><br><ul><li>DICOM Grid:<a href="http://imageshare.dicomgrid.com">http://imageshare.dicomgrid.com</a></li><li>lifeIMAGE: <a href="https://cloud.lifeimage.com/rsna/phr">https://cloud.lifeimage.com/rsna/phr</a></li></ul><br><br>Each of these sites provides detailed instructions on creating an account and using it to retrieve your imaging results. Be careful to record your PHR account log in information (PHR provider, user name and password) and keep it secure, as you do with all your valuable online information.</li><br><br><li><b>Use your PHR account to access and take control of your imaging results.</b> Once you’ve created an account, you’ll just need to log in and provide two pieces of information to access your images and reports:<br><br>Your Access Code: <b>$accesscode$</b><br>Your date of birth<br><br>That’s all you need to retrieve the images and report into your PHR account. You can then use your PHR account to share information with others you trust, including care providers. They can view the images and the report anywhere Internet access is available. Some PHRs enable you to email a link to your images, so a provider can view your examinations without you needing to be present.</li></ol><br><br>User support is available during business hours at <a href="mailto:helpdesk@imsharing.org">helpdesk@imsharing.org</a> | Toll-free: 1-855-IM-SHARING (467-4274).'
, modified_date = now()
WHERE key = 'patient_email_body';

--Update status codes
INSERT INTO status_codes (status_code,description,modified_date) VALUES (-1,'No devices found',now());
UPDATE status_codes set description = 'Started patient registration', modified_date = now() WHERE status_code = 32;
UPDATE status_codes set description = 'Retrieving global id', modified_date = now() WHERE status_code = 33;
UPDATE status_codes set description = 'Failed to register patient with clearinghouse', modified_date = now() WHERE status_code = -32;
UPDATE status_codes set description = 'Failed to retrieve global id', modified_date = now() WHERE status_code = -33;

--Add Pateint search index
create index patient_search_idx on patients using gin(to_tsvector('simple', trim(leading '0' from mrn) || ' ' || coalesce(patient_name,'') || ' ' || coalesce(extract(year from dob)::text,'') || ' ' || coalesce(email_address, '')));

END;
$$
