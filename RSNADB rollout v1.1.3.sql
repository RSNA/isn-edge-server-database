-- RSNA steering committee wants the delay to apply to the entire job, so add delay_in_hrs in job_sets table
-- modify view v_job_status to use it, then drop column delay_in_hrs from jobs table
ALTER TABLE job_sets ADD COLUMN delay_in_hrs integer DEFAULT 72;

CREATE OR REPLACE VIEW v_job_status AS 
 SELECT j.job_id, j.exam_id, js.delay_in_hrs, t.status, t.status_message, t.modified_date AS last_transaction_timestamp
   FROM jobs j
   JOIN job_sets js ON j.job_set_id = js.job_set_id
   JOIN ( SELECT t1.job_id, t1.status, t1.status_message, t1.modified_date
           FROM transactions t1
          WHERE t1.modified_date = (( SELECT max(t2.modified_date) AS max
                   FROM transactions t2
                  WHERE t2.job_id = t1.job_id))) t ON j.job_id = t.job_id;

ALTER TABLE v_job_status OWNER TO edge;

ALTER TABLE jobs DROP COLUMN delay_in_hrs;

-- Below change to handle two entries with same status_timestamp, can be distinct by modified_date
CREATE OR REPLACE VIEW v_exam_status AS 
SELECT p.patient_id, p.mrn, p.patient_name, p.dob, p.sex, p.street, p.city, p.state, p.zip_code, e.exam_id, e.accession_number, e.exam_description, r.report_id, r.status, r.status_timestamp, r.report_text, r.dictator, r.transcriber, r.signer
   FROM patients p
   JOIN exams e ON p.patient_id = e.patient_id
   JOIN ( SELECT r1.report_id, r1.exam_id, r1.proc_code, r1.status, r1.status_timestamp, r1.report_text, r1.signer, r1.dictator, r1.transcriber, r1.modified_date
      FROM reports r1
      WHERE r1.report_id = (SELECT report_id FROM reports r2 WHERE r2.exam_id = r1.exam_id ORDER BY status_timestamp DESC, modified_date DESC LIMIT 1)
) r ON e.exam_id = r.exam_id;

ALTER TABLE v_exam_status OWNER TO edge;      