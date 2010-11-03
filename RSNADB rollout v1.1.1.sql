CREATE TABLE hipaa_audit_views
(
  id serial NOT NULL,
  requesting_ip character varying(15),
  requesting_username character varying(100),
  requesting_uri text,
  modified_date timestamp with time zone
)
WITH (
  OIDS=FALSE
);

CREATE TABLE hipaa_audit_mrns
(
  id serial NOT NULL,
  view_id integer,
  mrn character varying(100),
  modified_date timestamp with time zone
)
WITH (
  OIDS=FALSE
);

CREATE TABLE hipaa_audit_accession_numbers (
  id serial NOT NULL,
  view_id integer,
  accession_number character varying(100),
  modified_date timestamp with time zone
)
WITH (
  OIDS=FALSE
);

ALTER TABLE patient_rsna_ids
 ALTER COLUMN rsna_id TYPE character varying(30);