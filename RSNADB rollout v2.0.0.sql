ALTER TABLE job_sets ADD COLUMN single_use_patient_id character varying(64) NOT NULL;
ALTER TABLE job_sets ADD CONSTRAINT uq_single_use_patient_id UNIQUE (single_use_patient_id);
ALTER TABLE job_sets DROP COLUMN security_pin;

ALTER TABLE transactions ADD
  CONSTRAINT fk_status_code FOREIGN KEY (status_code)
      REFERENCES status_codes (status_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

DROP TABLE patient_rsna_ids;  

CREATE OR REPLACE VIEW v_job_status AS 
 SELECT j.job_id, j.exam_id, js.delay_in_hrs, t.status, t.status_message, 
 t.modified_date AS last_transaction_timestamp, js.single_use_patient_id, t.comments
   FROM jobs j
   JOIN job_sets js ON j.job_set_id = js.job_set_id
   JOIN ( SELECT t1.job_id, t1.status_code AS status, sc.description AS status_message, t1.comments, t1.modified_date
      FROM transactions t1
   JOIN status_codes sc ON t1.status_code = sc.status_code
  WHERE t1.modified_date = (( SELECT max(t2.modified_date) AS max
         FROM transactions t2
        WHERE t2.job_id = t1.job_id))) t ON j.job_id = t.job_id;
