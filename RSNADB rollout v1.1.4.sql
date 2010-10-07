-- Add a flag to indicate if the patient has been registered or not
ALTER TABLE patient_rsna_ids ADD COLUMN registered boolean DEFAULT false;  