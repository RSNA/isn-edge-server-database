UPDATE schema_version SET version='5.0.0', modified_date=now();

ALTER TABLE job_sets ADD COLUMN phone_number character varying(20);

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

INSERT INTO sms_configurations VALUES('enable_sms','false',now());
INSERT INTO sms_configurations VALUES('account_id','',now());
INSERT INTO sms_configurations VALUES('token','',now());
INSERT INTO sms_configurations VALUES('sender','',now());
INSERT INTO sms_configurations VALUES('body','Your imaging results are ready to be accessed. Your Access Code is $accesscode$. Instructions available at http://www.rsna.org/image_share.aspx.',now());

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
WHERE key = patient_email_body;

--Add status code
INSERT INTO status_codes (status_code,description) VALUES (-1,'No devices found');
