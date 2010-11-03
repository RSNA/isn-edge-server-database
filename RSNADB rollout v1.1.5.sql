CREATE TABLE status_codes
(
  status_code integer NOT NULL,
  description character varying(255),
  modified_date timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_status_code PRIMARY KEY (status_code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE status_codes OWNER TO edge;

ALTER TABLE transactions
 RENAME COLUMN status TO status_code;

ALTER TABLE transactions
 RENAME COLUMN status_message TO comments;

ALTER TABLE job_sets
  ALTER COLUMN email_address TYPE character varying(255);
  
ALTER TABLE patient_rsna_ids
 ADD COLUMN email_address character varying(255);
 
ALTER TABLE patient_rsna_ids
 ADD COLUMN security_pin character varying(10);

ALTER TABLE hipaa_audit_accession_numbers
 ALTER COLUMN modified_date SET DEFAULT now();

ALTER TABLE hipaa_audit_accession_numbers
 ADD CONSTRAINT pk_hipaa_audit_accession_number_id PRIMARY KEY (id);

ALTER TABLE hipaa_audit_mrns
 ALTER COLUMN modified_date SET DEFAULT now();

ALTER TABLE hipaa_audit_mrns
 ADD CONSTRAINT pk_hipaa_audit_mrn_id PRIMARY KEY (id);

ALTER TABLE hipaa_audit_views
 ALTER COLUMN modified_date SET DEFAULT now();

ALTER TABLE hipaa_audit_views
 ADD CONSTRAINT pk_hipaa_audit_view_id PRIMARY KEY (id);