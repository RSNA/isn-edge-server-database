-- Record date time of when patient signs the consent
ALTER TABLE patients ADD COLUMN consent_timestamp timestamp with time zone;