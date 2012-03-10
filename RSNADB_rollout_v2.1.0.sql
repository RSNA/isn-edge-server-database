--
-- V2.1.0: Create db index to improve HL7 feed performance
--	
CREATE INDEX patients_dob_idx
  ON patients
  USING btree
  (dob );
 
CREATE INDEX patients_mrn_idx
  ON patients
  USING btree
  (mrn );
 
CREATE INDEX patients_patient_name_idx
  ON patients
  USING btree
  (patient_name );
 
CREATE INDEX exams_accession_number_idx
  ON exams
  USING btree
  (accession_number );

CREATE INDEX reports_status_timestamp_idx  
  ON reports  
  USING btree  
  (status_timestamp );
 
CREATE UNIQUE INDEX reports_unique_status_idx
  ON reports
  USING btree
  (exam_id , status , status_timestamp );
  
--
-- V2.1.0: insert database schema version
--
insert into schema_version values(0, '2.1.0', now());
INSERT INTO configurations VALUES('scp-port','4104',now());
INSERT INTO configurations VALUES('scp-release-timeout','5000',now());
INSERT INTO configurations VALUES('scp-request-timeout','5000',now());