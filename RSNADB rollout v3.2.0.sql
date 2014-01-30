UPDATE schema_version SET version='3.2.0', modified_date=now();
-- If true, then token app will do search in the first portion of the name field delimited by ^. 
INSERT INTO configurations VALUES('search-patient-lastname','false',now());
-- Add send_alert column to table
ALTER TABLE status_codes ADD COLUMN send_alert Boolean DEFAULT false NOT NULL;

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
		js.single_use_patient_id, js.email_address, t.comments, js.send_on_complete, j.remaining_retries
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