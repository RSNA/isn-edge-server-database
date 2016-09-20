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
INSERT INTO sms_configurations VALUES('body', 'Your RSNA Image Share Access Code is $accesscode$.',now());

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
