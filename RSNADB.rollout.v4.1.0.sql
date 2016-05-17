UPDATE schema_version SET version='4.1.0', modified_date=now();
-- v_job_status update to include access_code
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
