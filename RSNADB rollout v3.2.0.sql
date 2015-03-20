UPDATE schema_version SET version='3.2.0', modified_date=now();

ALTER TABLE status_codes ADD COLUMN send_alert Boolean DEFAULT false NOT NULL;
ALTER TABLE job_sets ADD COLUMN access_code character varying(64);
ALTER TABLE job_sets ADD COLUMN send_to_site Boolean DEFAULT false NOT NULL;

-- If true, then token app will do search in the first portion of the name field delimited by ^. 
INSERT INTO configurations VALUES('search-patient-lastname','false',now());
INSERT INTO configurations VALUES('secondary-capture-report-enabled','true',now());
INSERT INTO configurations VALUES('scp-idle-timeout','60000',now());
INSERT INTO configurations VALUES('attach-dicom-report','true',now());
INSERT INTO configurations VALUES('submit-stats','false',now());
INSERT INTO configurations VALUES('scp-max-send-pdu-length','16364',now());
INSERT INTO configurations VALUES('scp-max-receive-pdu-length','16364',now());
INSERT INTO status_codes (status_code, description, send_alert) VALUES (-24,'Exam has been canceled',FALSE);

-- Table: email_configurations
CREATE TABLE email_configurations
(
  "key" character varying NOT NULL,
  "value" character varying NOT NULL,
  modified_date timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_email_configuration_key PRIMARY KEY (key)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE email_configurations OWNER TO edge;
COMMENT ON TABLE email_configurations IS 'This table is used to store email configuration as key/value pairs';

-- Table: email_jobs
CREATE TABLE email_jobs
(
  email_job_id serial NOT NULL,
  recipient character varying NOT NULL,
  subject	character varying,
  body		text,
  sent		boolean NOT NULL DEFAULT false,
  failed	boolean NOT NULL DEFAULT false,
  comments	character varying,
  created_date	timestamp with time zone NOT NULL,
  modified_date timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_email_job_id PRIMARY KEY (email_job_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE email_jobs OWNER TO edge;
COMMENT ON TABLE email_jobs IS 'This table is used to store queued emails. Jobs within the queue will be handled by a worker thread which is responsible for handling any send failures and retrying failed jobs';

INSERT INTO email_configurations VALUES('mail.smtp.from','',now());
INSERT INTO email_configurations VALUES('mail.smtp.host','',now());
INSERT INTO email_configurations VALUES('enable_error_email','false',now());
INSERT INTO email_configurations VALUES('enable_patient_email','false',now());
INSERT INTO email_configurations VALUES('error_email_recipients','',now());
INSERT INTO email_configurations VALUES('username','',now());
INSERT INTO email_configurations VALUES('password','',now());
INSERT INTO email_configurations VALUES('bounce_email','',now());
INSERT INTO email_configurations VALUES('reply_to_email','',now());
insert into email_configurations values('patient_email_subject','Your imaging records are ready for viewing');
insert into email_configurations values('patient_email_body','Dear $patientname$,<br><br>Your imaging records from $siteid$ are ready for you to pick up online.<br><br> You will need to move them into your Personal Health Record (PHR) account to access your results. If you have not already done so, you can create a PHR account for this purpose using any of the services linked below.<br><br>DICOM Grid: <a href="http://imageshare.dicomgrid.com">http://imageshare.dicomgrid.com</a><br>itMD: <a href="http://share.itMD.net/claim">http://share.itMD.net/claim</a><br>lifeIMAGE: <a href="https://cloud.lifeimage.com/rsna/phr">https://cloud.lifeimage.com/rsna/phr</a><br><br>These PHR systems provide more detailed instructions about how to set up an account and access your images.  If you wish you can choose to try more than one- they’re free.<br><br>General instructions and further information about the Image Share network are available at <a href="http://www.rsna.org/Image_Share.aspx">http://www.rsna.org/Image_Share.aspx</a>. Help and technical support are available during business hours at  <a href="mailto:helpdesk@imsharing.org">helpdesk@imsharing.org</a> | Toll-free: 1-855-IM-SHARING (467-4274).<br><br>We hope you find this service helpful and convenient.<br><br>RSNA Image Share was developed by RSNA and its partners with funding from the National Institute of Biomedical Imaging and Bioengineering.<br><br>Thank you for using RSNA Image Share!');
insert into email_configurations values('error_email_body',E'The following job failed to send to the clearinghouse:\r\n\r\nName: $patientname$\r\nAccession: $accession$\r\nJob ID: $jobid$\r\nStatus: $jobstatus$ ($jobstatuscode$)\r\nError Detail:\r\n\r\n$errormsg$');

-- Add email address to view
DROP VIEW v_exam_status;
CREATE OR REPLACE VIEW v_exam_status AS 
SELECT p.patient_id, p.mrn, p.patient_name, p.dob, p.sex, p.street, p.city, p.state, p.zip_code, 
p.email_address, e.exam_id, e.accession_number, e.exam_description, r.report_id, r.status, 
r.status_timestamp, r.report_text, r.dictator, r.transcriber, r.signer
   FROM patients p
   JOIN exams e ON p.patient_id = e.patient_id
   JOIN ( SELECT r1.report_id, r1.exam_id, r1.proc_code, r1.status, r1.status_timestamp, r1.report_text, r1.signer, r1.dictator, r1.transcriber, r1.modified_date
      FROM reports r1
      WHERE r1.report_id = (SELECT report_id FROM reports r2 WHERE r2.exam_id = r1.exam_id ORDER BY status_timestamp DESC, modified_date DESC LIMIT 1)
) r ON e.exam_id = r.exam_id;

ALTER TABLE v_exam_status OWNER TO edge;

-- Add email address to view
DROP VIEW v_job_status;
CREATE OR REPLACE VIEW v_job_status AS 
 SELECT js.job_set_id, j.job_id, j.exam_id, js.delay_in_hrs, t.status, t.status_message, 
 t.modified_date AS last_transaction_timestamp, 
		js.single_use_patient_id, js.email_address, t.comments, js.send_on_complete, j.remaining_retries, js.send_to_site
   FROM jobs j
   JOIN job_sets js ON j.job_set_id = js.job_set_id
   JOIN ( SELECT t1.job_id, t1.status_code AS status, sc.description AS status_message, t1.comments, t1.modified_date
      FROM transactions t1
   JOIN status_codes sc ON t1.status_code = sc.status_code
  WHERE t1.modified_date = (( SELECT max(t2.modified_date) AS max
         FROM transactions t2
        WHERE t2.job_id = t1.job_id))) t ON j.job_id = t.job_id;

ALTER TABLE v_job_status OWNER TO edge;

-- Add unique index on patient mrn to avoid duplicate mrn
DROP INDEX patients_mrn_idx;
CREATE UNIQUE INDEX patients_mrn_ix
  ON patients
  USING btree
  (mrn);

CREATE INDEX jobs_job_set_id ON jobs USING btree (job_set_id);

CREATE INDEX transactions_status_code_idx ON transactions USING btree (status_code);

CREATE INDEX transactions_job_id ON transactions USING btree (job_id);

CREATE INDEX transactions_modified_date ON transactions USING btree (modified_date);

CREATE OR REPLACE VIEW v_consented AS 
select * from patients where consent_timestamp is not null;

ALTER TABLE v_consented OWNER TO edge;

CREATE OR REPLACE VIEW v_patients_sent AS 
select DISTINCT job_sets.patient_id
from transactions ,jobs,job_sets
where
  (transactions.status_code = 40) AND
  (transactions.job_id = jobs.job_id) AND
  (jobs.job_set_id = job_sets.job_set_id);

ALTER TABLE v_patients_sent OWNER TO edge;

CREATE OR REPLACE VIEW v_exams_sent AS 
select * from transactions where status_code = 40;

ALTER TABLE v_exams_sent OWNER TO edge;
