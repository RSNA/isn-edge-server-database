
ALTER TABLE job_sets ADD COLUMN send_on_complete Boolean DEFAULT false NOT NULL;
ALTER TABLE jobs ADD COLUMN remaining_retries integer;
UPDATE jobs SET remaining_retries = 0;
ALTER TABLE jobs ALTER COLUMN remaining_retries SET NOT NULL;
ALTER TABLE patients ADD COLUMN email_address character varying(255);
ALTER TABLE patients ADD COLUMN encrypted_password text;
ALTER TABLE job_sets DROP COLUMN email_address;

UPDATE job_sets SET send_on_complete=false;
UPDATE schema_version SET version='3.1.0', modified_date=now();
INSERT INTO configurations VALUES('max-retries','10',now());
INSERT INTO configurations VALUES('retry-delay-in-mins','10',now());
INSERT INTO configurations VALUES('fail-on-incomplete-study', false, now());
INSERT INTO configurations VALUES('retrieve-timeout-in-secs', '600', now());
INSERT INTO status_codes VALUES(24, 'Waiting for exam completion',now());

CREATE OR REPLACE VIEW v_job_status AS 
 SELECT js.job_set_id, j.job_id, j.exam_id, js.delay_in_hrs, t.status, t.status_message, t.modified_date AS last_transaction_timestamp, 
		js.single_use_patient_id, t.comments, js.send_on_complete, j.remaining_retries
   FROM jobs j
   JOIN job_sets js ON j.job_set_id = js.job_set_id
   JOIN ( SELECT t1.job_id, t1.status_code AS status, sc.description AS status_message, t1.comments, t1.modified_date
      FROM transactions t1
   JOIN status_codes sc ON t1.status_code = sc.status_code
  WHERE t1.modified_date = (( SELECT max(t2.modified_date) AS max
         FROM transactions t2
        WHERE t2.job_id = t1.job_id))) t ON j.job_id = t.job_id;

ALTER TABLE v_job_status OWNER TO edge;
