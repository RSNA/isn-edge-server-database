UPDATE schema_version SET version='4.0.0', modified_date=now();
-- latest exam status decided by report_id which is the order of when the event was inserted
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
