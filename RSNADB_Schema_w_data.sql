--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.job_sets DROP CONSTRAINT fk_user_id;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT fk_report_id;
ALTER TABLE ONLY public.patient_rsna_ids DROP CONSTRAINT fk_patient_id;
ALTER TABLE ONLY public.exams DROP CONSTRAINT fk_patient_id;
ALTER TABLE ONLY public.job_sets DROP CONSTRAINT fk_patient_id;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT fk_job_set_id;
ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_job_id;
ALTER TABLE ONLY public.reports DROP CONSTRAINT fk_exam_id;
ALTER TABLE ONLY public.studies DROP CONSTRAINT fk_exam_id;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT fk_exam_id;
DROP TRIGGER tr_users_modified_date ON public.users;
DROP TRIGGER tr_transactions_modified_date ON public.transactions;
DROP TRIGGER tr_studies_modified_date ON public.studies;
DROP TRIGGER tr_roles_modified_date ON public.roles;
DROP TRIGGER tr_reports_modified_date ON public.reports;
DROP TRIGGER tr_patients_modified_date ON public.patients;
DROP TRIGGER tr_patient_rsna_ids_modified_date ON public.patient_rsna_ids;
DROP TRIGGER tr_patient_merge_events_modified_date ON public.patient_merge_events;
DROP TRIGGER tr_jobs_modified_date ON public.jobs;
DROP TRIGGER tr_job_sets_modified_date ON public.job_sets;
DROP TRIGGER tr_exams_modified_date ON public.exams;
DROP TRIGGER tr_devices_modified_date ON public.devices;
DROP TRIGGER tr_configurations_modified_date ON public.configurations;
ALTER TABLE ONLY public.users DROP CONSTRAINT uq_login;
ALTER TABLE ONLY public.exams DROP CONSTRAINT uq_exam;
ALTER TABLE ONLY public.users DROP CONSTRAINT pk_user_id;
ALTER TABLE ONLY public.transactions DROP CONSTRAINT pk_transaction_id;
ALTER TABLE ONLY public.studies DROP CONSTRAINT pk_study_id;
ALTER TABLE ONLY public.status_codes DROP CONSTRAINT pk_status_code;
ALTER TABLE ONLY public.roles DROP CONSTRAINT pk_role_id;
ALTER TABLE ONLY public.reports DROP CONSTRAINT pk_report_id;
ALTER TABLE ONLY public.patients DROP CONSTRAINT pk_patient_id;
ALTER TABLE ONLY public.patient_rsna_ids DROP CONSTRAINT pk_map_id;
ALTER TABLE ONLY public.configurations DROP CONSTRAINT pk_key;
ALTER TABLE ONLY public.job_sets DROP CONSTRAINT pk_job_set_id;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT pk_job_id;
ALTER TABLE ONLY public.hipaa_audit_views DROP CONSTRAINT pk_hipaa_audit_view_id;
ALTER TABLE ONLY public.hipaa_audit_mrns DROP CONSTRAINT pk_hipaa_audit_mrn_id;
ALTER TABLE ONLY public.hipaa_audit_accession_numbers DROP CONSTRAINT pk_hipaa_audit_accession_number_id;
ALTER TABLE ONLY public.exams DROP CONSTRAINT pk_exam_id;
ALTER TABLE ONLY public.patient_merge_events DROP CONSTRAINT pk_event_id;
ALTER TABLE ONLY public.devices DROP CONSTRAINT pk_device_id;
ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE public.transactions ALTER COLUMN transaction_id DROP DEFAULT;
ALTER TABLE public.studies ALTER COLUMN study_id DROP DEFAULT;
ALTER TABLE public.reports ALTER COLUMN report_id DROP DEFAULT;
ALTER TABLE public.patients ALTER COLUMN patient_id DROP DEFAULT;
ALTER TABLE public.patient_rsna_ids ALTER COLUMN map_id DROP DEFAULT;
ALTER TABLE public.patient_merge_events ALTER COLUMN event_id DROP DEFAULT;
ALTER TABLE public.jobs ALTER COLUMN job_id DROP DEFAULT;
ALTER TABLE public.job_sets ALTER COLUMN job_set_id DROP DEFAULT;
ALTER TABLE public.hipaa_audit_views ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.hipaa_audit_mrns ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.hipaa_audit_accession_numbers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.exams ALTER COLUMN exam_id DROP DEFAULT;
ALTER TABLE public.devices ALTER COLUMN device_id DROP DEFAULT;
DROP VIEW public.v_job_status;
DROP VIEW public.v_exam_status;
DROP SEQUENCE public.users_user_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.transactions_transaction_id_seq;
DROP TABLE public.transactions;
DROP SEQUENCE public.studies_study_id_seq;
DROP TABLE public.studies;
DROP TABLE public.status_codes;
DROP TABLE public.roles;
DROP SEQUENCE public.reports_report_id_seq;
DROP TABLE public.reports;
DROP SEQUENCE public.patients_patient_id_seq;
DROP TABLE public.patients;
DROP SEQUENCE public.patient_rsna_ids_map_id_seq;
DROP TABLE public.patient_rsna_ids;
DROP SEQUENCE public.patient_merge_events_event_id_seq;
DROP TABLE public.patient_merge_events;
DROP SEQUENCE public.jobs_job_id_seq;
DROP TABLE public.jobs;
DROP SEQUENCE public.job_sets_job_set_id_seq;
DROP TABLE public.job_sets;
DROP SEQUENCE public.hipaa_audit_views_id_seq;
DROP TABLE public.hipaa_audit_views;
DROP SEQUENCE public.hipaa_audit_mrns_id_seq;
DROP TABLE public.hipaa_audit_mrns;
DROP SEQUENCE public.hipaa_audit_accession_numbers_id_seq;
DROP TABLE public.hipaa_audit_accession_numbers;
DROP SEQUENCE public.exams_exam_id_seq;
DROP TABLE public.exams;
DROP SEQUENCE public.devices_device_id_seq;
DROP TABLE public.devices;
DROP TABLE public.configurations;
DROP FUNCTION public.usp_update_modified_date();
DROP PROCEDURAL LANGUAGE plpgsql;
DROP SCHEMA public;
--
-- Name: rsnadb2; Type: COMMENT; Schema: -; Owner: edge
--

COMMENT ON DATABASE rsnadb2 IS 'RSNA2 Edge Device Database
Authors: Wendy Zhu (Univ of Chicago) and Steve G Langer (Mayo Clinic)

Copyright (c) <2010>, <Radiological Society of North America>
  All rights reserved.
  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
  Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
  Neither the name of the <RSNA> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
  CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
  OF SUCH DAMAGE.';


--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: usp_update_modified_date(); Type: FUNCTION; Schema: public; Owner: edge
--

CREATE FUNCTION usp_update_modified_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

new. modified_date=CURRENT_TIMESTAMP;

RETURN new;

END;$$;


ALTER FUNCTION public.usp_update_modified_date() OWNER TO edge;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: configurations; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE configurations (
    key character varying NOT NULL,
    value character varying NOT NULL,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.configurations OWNER TO edge;

--
-- Name: TABLE configurations; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE configurations IS 'This table is used to store applications specific config data as key/value pairs and takes the place of java properties files (rather then having it all aly about in plain text files);

a) paths to key things (ie dicom studies)
b) site prefix for generating RSNA ID''s
c) site delay for applying to report finalize before available to send to CH
d) Clearing House connection data
e) etc';


--
-- Name: devices; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE devices (
    device_id integer NOT NULL,
    ae_title character varying(256) NOT NULL,
    host character varying(256) NOT NULL,
    port_number character varying(10) NOT NULL,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.devices OWNER TO edge;

--
-- Name: TABLE devices; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE devices IS 'Used to store DICOM connection info for mage sources, and possibly others

a) the DICOM triplet (for remote DICOM study sources)
b) ?

';


--
-- Name: devices_device_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE devices_device_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.devices_device_id_seq OWNER TO edge;

--
-- Name: devices_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE devices_device_id_seq OWNED BY devices.device_id;


--
-- Name: devices_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('devices_device_id_seq', 1, true);


--
-- Name: exams; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE exams (
    exam_id integer NOT NULL,
    accession_number character varying(50) NOT NULL,
    patient_id integer NOT NULL,
    exam_description character varying(256),
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.exams OWNER TO edge;

--
-- Name: TABLE exams; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE exams IS 'A listing of all ordered DICOM exams the system knows about. The report status is not stored here';


--
-- Name: exams_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE exams_exam_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.exams_exam_id_seq OWNER TO edge;

--
-- Name: exams_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE exams_exam_id_seq OWNED BY exams.exam_id;


--
-- Name: exams_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('exams_exam_id_seq', 83, true);


--
-- Name: hipaa_audit_accession_numbers; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE hipaa_audit_accession_numbers (
    id integer NOT NULL,
    view_id integer,
    accession_number character varying(100),
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.hipaa_audit_accession_numbers OWNER TO edge;

--
-- Name: TABLE hipaa_audit_accession_numbers; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE hipaa_audit_accession_numbers IS 'Part of the HIPAA tracking for edge device auditing. This table and  "audit_mrns" report up to table HIPAA_views
';


--
-- Name: hipaa_audit_accession_numbers_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE hipaa_audit_accession_numbers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.hipaa_audit_accession_numbers_id_seq OWNER TO edge;

--
-- Name: hipaa_audit_accession_numbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE hipaa_audit_accession_numbers_id_seq OWNED BY hipaa_audit_accession_numbers.id;


--
-- Name: hipaa_audit_accession_numbers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('hipaa_audit_accession_numbers_id_seq', 197, true);


--
-- Name: hipaa_audit_mrns; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE hipaa_audit_mrns (
    id integer NOT NULL,
    view_id integer,
    mrn character varying(100),
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.hipaa_audit_mrns OWNER TO edge;

--
-- Name: TABLE hipaa_audit_mrns; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE hipaa_audit_mrns IS 'Part of the HIPAA tracking for edge device auditing. This table and  "audit_acessions" report up to table HIPAA_views
';


--
-- Name: hipaa_audit_mrns_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE hipaa_audit_mrns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.hipaa_audit_mrns_id_seq OWNER TO edge;

--
-- Name: hipaa_audit_mrns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE hipaa_audit_mrns_id_seq OWNED BY hipaa_audit_mrns.id;


--
-- Name: hipaa_audit_mrns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('hipaa_audit_mrns_id_seq', 1718, true);


--
-- Name: hipaa_audit_views; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE hipaa_audit_views (
    id integer NOT NULL,
    requesting_ip character varying(15),
    requesting_username character varying(100),
    requesting_uri text,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.hipaa_audit_views OWNER TO edge;

--
-- Name: TABLE hipaa_audit_views; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE hipaa_audit_views IS 'Part of the HIPAA tracking for edge device auditing. This is the top level table that tracks who asked for what from where. The HIPAA tables "audfit_accession" and "audit_mrns" report up to this table';


--
-- Name: hipaa_audit_views_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE hipaa_audit_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.hipaa_audit_views_id_seq OWNER TO edge;

--
-- Name: hipaa_audit_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE hipaa_audit_views_id_seq OWNED BY hipaa_audit_views.id;


--
-- Name: hipaa_audit_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('hipaa_audit_views_id_seq', 842, true);


--
-- Name: job_sets; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE job_sets (
    job_set_id integer NOT NULL,
    patient_id integer NOT NULL,
    user_id integer NOT NULL,
    security_pin character varying(10),
    email_address character varying(255),
    modified_date timestamp with time zone DEFAULT now(),
    delay_in_hrs integer DEFAULT 72,
    single_use_patient_id character varying(64)
);


ALTER TABLE public.job_sets OWNER TO edge;

--
-- Name: TABLE job_sets; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE job_sets IS 'This is one of a pair of tables that bind a patient to a edge device job, consisting of one or more exam accessions descrbing DICOM exams to send to the CH. The other table is JOBS
';


--
-- Name: COLUMN job_sets.security_pin; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN job_sets.security_pin IS 'the PIN the patient used for the submission of this job set';


--
-- Name: COLUMN job_sets.email_address; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN job_sets.email_address IS 'the email address the patient claimed at the time this job was submitted to the Clearing House';


--
-- Name: job_sets_job_set_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE job_sets_job_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.job_sets_job_set_id_seq OWNER TO edge;

--
-- Name: job_sets_job_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE job_sets_job_set_id_seq OWNED BY job_sets.job_set_id;


--
-- Name: job_sets_job_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('job_sets_job_set_id_seq', 57, true);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE jobs (
    job_id integer NOT NULL,
    job_set_id integer NOT NULL,
    exam_id integer NOT NULL,
    report_id integer,
    document_id character varying(100),
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.jobs OWNER TO edge;

--
-- Name: TABLE jobs; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE jobs IS 'This is one of a pair of tables that bind a patient to a edge device job, consisting of one or more exam accessions descrbing DICOM exams to send to the CH. The other table is JOB_SETS
';


--
-- Name: jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.jobs_job_id_seq OWNER TO edge;

--
-- Name: jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE jobs_job_id_seq OWNED BY jobs.job_id;


--
-- Name: jobs_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('jobs_job_id_seq', 58, true);


--
-- Name: patient_merge_events; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE patient_merge_events (
    event_id integer NOT NULL,
    old_mrn character varying(50) NOT NULL,
    new_mrn character varying(50) NOT NULL,
    old_patient_id integer NOT NULL,
    new_patient_id integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.patient_merge_events OWNER TO edge;

--
-- Name: TABLE patient_merge_events; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE patient_merge_events IS 'When it''s required to swap a patient to a new ID (say a john doe) this tracks the old and new MRN for rollback/auditing
';


--
-- Name: patient_merge_events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE patient_merge_events_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.patient_merge_events_event_id_seq OWNER TO edge;

--
-- Name: patient_merge_events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE patient_merge_events_event_id_seq OWNED BY patient_merge_events.event_id;


--
-- Name: patient_merge_events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('patient_merge_events_event_id_seq', 1, false);


--
-- Name: patient_rsna_ids; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE patient_rsna_ids (
    map_id integer NOT NULL,
    rsna_id character varying(30) NOT NULL,
    patient_id integer NOT NULL,
    modified_date timestamp with time zone DEFAULT now(),
    patient_alias_lastname character varying(100),
    patient_alias_firstname character varying(100),
    registered boolean DEFAULT false NOT NULL,
    email_address character varying(255),
    security_pin character varying(10)
);


ALTER TABLE public.patient_rsna_ids OWNER TO edge;

--
-- Name: TABLE patient_rsna_ids; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE patient_rsna_ids IS 'Map a patients local medical center ID (ie MRN) to the MPI like RSNAID
';


--
-- Name: COLUMN patient_rsna_ids.rsna_id; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN patient_rsna_ids.rsna_id IS 'the ID the patient shall be known by on the  Clearing House';


--
-- Name: COLUMN patient_rsna_ids.patient_id; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN patient_rsna_ids.patient_id IS 'the patient ID used at the sending medical center';


--
-- Name: COLUMN patient_rsna_ids.email_address; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN patient_rsna_ids.email_address IS 'the patient''s current email address. This is copied into the Job-set table, since there is no guarantee that the same email address will be used over all Job-sets';


--
-- Name: COLUMN patient_rsna_ids.security_pin; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN patient_rsna_ids.security_pin IS 'the PIN currently used by the patient. Since this cannot be assumed to be constant over time, the one claimed at the moment of Job-set creation is copied ot that table';


--
-- Name: patient_rsna_ids_map_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE patient_rsna_ids_map_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.patient_rsna_ids_map_id_seq OWNER TO edge;

--
-- Name: patient_rsna_ids_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE patient_rsna_ids_map_id_seq OWNED BY patient_rsna_ids.map_id;


--
-- Name: patient_rsna_ids_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('patient_rsna_ids_map_id_seq', 49, true);


--
-- Name: patients; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE patients (
    patient_id integer NOT NULL,
    mrn character varying(50) NOT NULL,
    patient_name character varying,
    dob date,
    sex character(1),
    street character varying,
    city character varying(50),
    state character varying(30),
    zip_code character varying(30),
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.patients OWNER TO edge;

--
-- Name: TABLE patients; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE patients IS 'a list of all patient demog sent via the HL7 MIRTH channel';


--
-- Name: COLUMN patients.patient_id; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN patients.patient_id IS 'just teh dbase created primary key';


--
-- Name: COLUMN patients.mrn; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN patients.mrn IS 'the actual medical recrod number from the medical center';


--
-- Name: patients_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE patients_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.patients_patient_id_seq OWNER TO edge;

--
-- Name: patients_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE patients_patient_id_seq OWNED BY patients.patient_id;


--
-- Name: patients_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('patients_patient_id_seq', 79, true);


--
-- Name: reports; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE reports (
    report_id integer NOT NULL,
    exam_id integer NOT NULL,
    proc_code character varying,
    status character varying NOT NULL,
    status_timestamp timestamp with time zone NOT NULL,
    report_text text,
    signer character varying,
    dictator character varying,
    transcriber character varying,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.reports OWNER TO edge;

--
-- Name: TABLE reports; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE reports IS 'This table contains exam report and exam status as sent from teh MIRTH HL7 channel. Combined with the Exams table, this provides all info needed to determine exam staus and location to create a job to send to the CH';


--
-- Name: reports_report_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE reports_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.reports_report_id_seq OWNER TO edge;

--
-- Name: reports_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE reports_report_id_seq OWNED BY reports.report_id;


--
-- Name: reports_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('reports_report_id_seq', 150, true);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE roles (
    role_id integer NOT NULL,
    role_description character varying(50) NOT NULL,
    modified_date time with time zone DEFAULT now()
);


ALTER TABLE public.roles OWNER TO edge;

--
-- Name: TABLE roles; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE roles IS 'Combined with table Users, this table defines a user''s privelages
';


--
-- Name: status_codes; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE status_codes (
    status_code integer NOT NULL,
    description character varying(255),
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.status_codes OWNER TO edge;

--
-- Name: TABLE status_codes; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE status_codes IS 'Maps a job status number to a human readable format. 

Values in the 20s are owned by the COntent-prep app

Values in the 30s are owned by the Content-send app';


--
-- Name: studies; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE studies (
    study_id integer NOT NULL,
    study_uid character varying(255) NOT NULL,
    exam_id integer NOT NULL,
    study_description character varying(255),
    study_date timestamp without time zone,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.studies OWNER TO edge;

--
-- Name: TABLE studies; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE studies IS 'DICOM uid info for exams listed by accession in table Exams';


--
-- Name: studies_study_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE studies_study_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.studies_study_id_seq OWNER TO edge;

--
-- Name: studies_study_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE studies_study_id_seq OWNED BY studies.study_id;


--
-- Name: studies_study_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('studies_study_id_seq', 236, true);


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE transactions (
    transaction_id integer NOT NULL,
    job_id integer NOT NULL,
    status_code integer NOT NULL,
    comments character varying,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.transactions OWNER TO edge;

--
-- Name: TABLE transactions; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE transactions IS 'status logging/auditing for jobs defined in table Jobs. The java apps come here to determine their work by looking at the value status';


--
-- Name: COLUMN transactions.status_code; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN transactions.status_code IS 'WHen a job is created by the GUI Token app, the row is created with value 1

Prepare Content looks for value of one and promites status to 2 on exit

Content transfer looks for status 2 and promotes to 3 on exit

 ';


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE transactions_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.transactions_transaction_id_seq OWNER TO edge;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE transactions_transaction_id_seq OWNED BY transactions.transaction_id;


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('transactions_transaction_id_seq', 14774, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    user_login character varying(40) DEFAULT NULL::character varying,
    user_name character varying(100) DEFAULT ''::character varying,
    email character varying(100) DEFAULT NULL::character varying,
    crypted_password character varying(40) DEFAULT NULL::character varying,
    salt character varying(40) DEFAULT NULL::character varying,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    remember_token character varying(40) DEFAULT NULL::character varying,
    remember_token_expires_at timestamp with time zone,
    role_id integer NOT NULL,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO edge;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE users IS 'Combined with table Roles, this table defines who can do what on the Edge appliacne Web GUI';


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: edge
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO edge;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edge
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edge
--

SELECT pg_catalog.setval('users_user_id_seq', 9, true);


--
-- Name: v_exam_status; Type: VIEW; Schema: public; Owner: edge
--

CREATE VIEW v_exam_status AS
    SELECT p.patient_id, p.mrn, p.patient_name, p.dob, p.sex, p.street, p.city, p.state, p.zip_code, e.exam_id, e.accession_number, e.exam_description, r.report_id, r.status, r.status_timestamp, r.report_text, r.dictator, r.transcriber, r.signer FROM ((patients p JOIN exams e ON ((p.patient_id = e.patient_id))) JOIN (SELECT r1.report_id, r1.exam_id, r1.proc_code, r1.status, r1.status_timestamp, r1.report_text, r1.signer, r1.dictator, r1.transcriber, r1.modified_date FROM reports r1 WHERE (r1.report_id = (SELECT r2.report_id FROM reports r2 WHERE (r2.exam_id = r1.exam_id) ORDER BY r2.status_timestamp DESC, r2.modified_date DESC LIMIT 1))) r ON ((e.exam_id = r.exam_id)));


ALTER TABLE public.v_exam_status OWNER TO edge;

--
-- Name: v_job_status; Type: VIEW; Schema: public; Owner: edge
--

CREATE VIEW v_job_status AS
    SELECT j.job_id, j.exam_id, js.delay_in_hrs, t.status, t.status_message, t.modified_date AS last_transaction_timestamp FROM ((jobs j JOIN job_sets js ON ((j.job_set_id = js.job_set_id))) JOIN (SELECT t1.job_id, t1.status_code AS status, sc.description AS status_message, t1.comments, t1.modified_date FROM (transactions t1 JOIN status_codes sc ON ((t1.status_code = sc.status_code))) WHERE (t1.modified_date = (SELECT max(t2.modified_date) AS max FROM transactions t2 WHERE (t2.job_id = t1.job_id)))) t ON ((j.job_id = t.job_id)));


ALTER TABLE public.v_job_status OWNER TO edge;

--
-- Name: device_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE devices ALTER COLUMN device_id SET DEFAULT nextval('devices_device_id_seq'::regclass);


--
-- Name: exam_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE exams ALTER COLUMN exam_id SET DEFAULT nextval('exams_exam_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE hipaa_audit_accession_numbers ALTER COLUMN id SET DEFAULT nextval('hipaa_audit_accession_numbers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE hipaa_audit_mrns ALTER COLUMN id SET DEFAULT nextval('hipaa_audit_mrns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE hipaa_audit_views ALTER COLUMN id SET DEFAULT nextval('hipaa_audit_views_id_seq'::regclass);


--
-- Name: job_set_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE job_sets ALTER COLUMN job_set_id SET DEFAULT nextval('job_sets_job_set_id_seq'::regclass);


--
-- Name: job_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE jobs ALTER COLUMN job_id SET DEFAULT nextval('jobs_job_id_seq'::regclass);


--
-- Name: event_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE patient_merge_events ALTER COLUMN event_id SET DEFAULT nextval('patient_merge_events_event_id_seq'::regclass);


--
-- Name: map_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE patient_rsna_ids ALTER COLUMN map_id SET DEFAULT nextval('patient_rsna_ids_map_id_seq'::regclass);


--
-- Name: patient_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE patients ALTER COLUMN patient_id SET DEFAULT nextval('patients_patient_id_seq'::regclass);


--
-- Name: report_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE reports ALTER COLUMN report_id SET DEFAULT nextval('reports_report_id_seq'::regclass);


--
-- Name: study_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE studies ALTER COLUMN study_id SET DEFAULT nextval('studies_study_id_seq'::regclass);


--
-- Name: transaction_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE transactions ALTER COLUMN transaction_id SET DEFAULT nextval('transactions_transaction_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: edge
--

ALTER TABLE users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: configurations; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY configurations (key, value, modified_date) FROM stdin;
dcm-dir-path	/rsna/dcm/	2010-11-02 09:27:06.248449-05
iti41-repository-unique-id	2.25.1367695025465247913241234123423	2010-11-02 09:31:18.514267-05
iti41-source-id	2.25.136769502546524791439413804093552525696	2010-11-02 09:31:42.884924-05
iti8-pix-host	216.185.79.26	2010-11-02 09:32:06.721941-05
iti8-pix-port	8888	2010-11-02 09:32:25.853192-05
iti8-reg-host	216.185.79.26	2010-11-02 09:32:45.857296-05
iti8-reg-port	8890	2010-11-02 09:33:01.407082-05
tmp-dir-path	/rsna/tmp	2010-11-02 09:33:17.413413-05
iti41-endpoint-url	http://rsnaclearinghouse.com:9090/services/xdsrepositoryb	2010-11-03 09:14:51.592363-05
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY devices (device_id, ae_title, host, port_number, modified_date) FROM stdin;
1	DCM4CHEE	172.20.175.63	11112	2010-09-17 11:51:23.42469-05
\.


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY exams (exam_id, accession_number, patient_id, exam_description, modified_date) FROM stdin;
7	IHE383143.3	7	FINGER,LEFT	2010-09-16 14:36:59.445109-05
60	IHE2541.25	56	Abdomen CT	2010-10-14 15:35:09.192044-05
61	IHE2541.26	57	Abdomen CT	2010-10-14 16:56:34.765844-05
62	IHE2541.27	58	Abdomen CT	2010-10-14 17:04:05.502752-05
63	IHE2541.28	59	Abdomen CT	2010-10-14 17:22:33.163895-05
64	IHE2541.29	60	Abdomen CT	2010-10-15 16:33:26.303215-05
65	IHE2541.30	61	Abdomen CT	2010-10-15 16:35:06.841609-05
66	IHE288621.0	62	Abdomen CT (2 images)	2010-10-19 13:37:02.970806-05
16	IHE203981.2	16	Head MR	2010-09-21 18:18:33.335371-05
67	IHE64729.0	63	Abdomen CT (1 image)	2010-10-20 08:59:47.048174-05
19	IHE824357.1	19	Head MR	2010-09-24 12:38:17.939907-05
20	IHE824357.3	20	Head MR	2010-09-24 12:53:47.280339-05
21	IHE824357.4	21	Head MR	2010-09-24 15:03:34.297681-05
22	IHE484882.0	22	Head MR	2010-09-28 13:28:29.395166-05
23	IHE316111.0	23	Head MR	2010-09-30 10:07:33.584058-05
24	IHE355299.1	24	Head MR	2010-09-30 10:26:00.505566-05
25	IHE355299.4	25	Head MR	2010-09-30 10:34:03.567277-05
26	IHE355299.7	26	Head MR	2010-09-30 10:34:49.788756-05
27	IHE355299.10	27	Head MR	2010-09-30 10:37:05.109735-05
28	IHE639821.1	28	Head MR	2010-09-30 10:46:32.173463-05
29	IHE941111.0	29	Head MR	2010-10-01 15:11:50.891358-05
30	IHE862899.1	30	Head MR	2010-10-01 16:00:48.146698-05
31	IHE862899.3	31	Head MR	2010-10-01 16:04:59.118416-05
32	IHE862899.7	32	Head MR	2010-10-01 16:09:04.720667-05
33	IHE862899.9	33	Head MR	2010-10-01 16:10:45.914714-05
34	IHE862899.12	34	Head MR	2010-10-01 16:27:57.22828-05
35	IHE862899.16	35	Head MR	2010-10-01 16:47:31.205514-05
36	IHE484882.3	36	Head MR	2010-10-11 13:19:16.342478-05
37	IHE484882.5	37	Head MR	2010-10-11 13:20:41.116054-05
38	IHE484882.7	38	Head MR	2010-10-11 13:28:26.499306-05
39	IHE323383.2	39	Head MR	2010-10-11 14:52:30.706886-05
40	IHE809846.8	40	Abdomen CT	2010-10-12 21:32:04.239531-05
41	IHE9357.9	41	Abdomen CT	2010-10-12 21:51:13.702044-05
42	IHE9357.10	42	Abdomen CT	2010-10-13 09:34:40.445665-05
43	IHE9357.11	43	Abdomen CT	2010-10-13 12:40:11.410151-05
44	IHE112174.2	44	Head MR	2010-10-13 13:11:26.402552-05
45	IHE112174.4	45	Head MR	2010-10-13 13:13:45.86606-05
46	IHE112174.8	46	Head MR	2010-10-13 13:23:30.025996-05
47	IHE9357.12	47	Abdomen CT	2010-10-13 13:40:57.565182-05
48	IHE9357.13	48	Abdomen CT	2010-10-13 14:03:06.047533-05
49	IHE9357.14	48	Abdomen CT	2010-10-13 14:03:11.18687-05
50	IHE9357.15	49	Abdomen CT	2010-10-13 15:17:41.626474-05
51	IHE9357.16	49	Abdomen CT	2010-10-13 15:17:47.163042-05
52	IHE9357.17	50	Abdomen CT	2010-10-13 18:47:50.749819-05
53	IHE9357.18	50	Abdomen CT	2010-10-13 18:47:56.294831-05
54	IHE9357.19	51	Abdomen CT	2010-10-13 18:57:53.685576-05
55	IHE9357.20	51	Abdomen CT	2010-10-13 18:57:58.991772-05
56	IHE2541.21	52	Abdomen CT	2010-10-14 10:45:56.292832-05
57	IHE2541.22	53	Abdomen CT	2010-10-14 13:10:12.141708-05
58	IHE2541.23	54	Abdomen CT	2010-10-14 13:21:05.107787-05
59	IHE2541.24	55	Abdomen CT	2010-10-14 14:53:25.11096-05
68	IHE64729.1	64	Abdomen CT (1 image)	2010-10-20 09:13:17.996675-05
69	IHE64729.2	65	Abdomen CT (1 image)	2010-10-20 09:31:34.045772-05
70	IHE64729.3	66	Abdomen CT (1 image)	2010-10-20 10:08:11.438104-05
71	IHE64729.4	67	Abdomen CT (1 image)	2010-10-20 22:12:11.708267-05
72	IHE64729.5	68	Abdomen CT (1 image)	2010-10-20 22:26:47.351823-05
73	IHE64729.6	69	Abdomen CT (1 image)	2010-10-20 23:04:57.368899-05
74	IHE64729.7	70	Abdomen CT (1 image)	2010-10-20 23:12:52.063851-05
75	IHE64729.8	71	Abdomen CT (1 image)	2010-10-20 23:32:21.932322-05
76	IHE64729.9	72	Abdomen CT (1 image)	2010-10-20 23:48:19.578397-05
77	IHE64729.10	73	Abdomen CT (1 image)	2010-10-21 16:41:13.485362-05
78	IHE64729.11	74	Abdomen CT (1 image)	2010-10-21 16:52:59.707255-05
79	IHE64729.12	75	Abdomen CT (1 image)	2010-10-21 21:08:19.025841-05
80	IHE64729.13	76	Abdomen CT (1 image)	2010-10-21 21:54:52.214797-05
81	IHE64729.14	77	Abdomen CT (1 image)	2010-10-21 22:15:47.082129-05
82	IHE64729.15	78	Abdomen CT (1 image)	2010-10-21 23:02:16.401034-05
83	IHE759956.0	79	MR Knee	2010-12-17 13:50:01.222665-06
\.


--
-- Data for Name: hipaa_audit_accession_numbers; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY hipaa_audit_accession_numbers (id, view_id, accession_number, modified_date) FROM stdin;
1	6	IHE383143.3	\N
2	8	IHE383143.3	\N
3	10	IHE383143.3	\N
4	11	IHE383143.3	\N
5	17	FN14	\N
6	25	IHE383143.3	\N
7	28	IHE383143.3	\N
8	30	IHE383143.3	\N
9	35	FN15	\N
10	38	FN15	\N
11	40	FN15	\N
12	47	IHE383143.3	\N
13	48	IHE383143.3	\N
14	53	IHE383143.3	\N
15	55	IHE383143.3	\N
16	58	IHE383143.3	\N
17	64	FN12	\N
18	67	FN12	\N
19	69	FN12	\N
20	74	IHE824357.3	\N
21	77	IHE824357.3	\N
22	79	IHE824357.3	\N
23	81	IHE824357.3	\N
24	87	IHE824357.1	\N
25	90	IHE824357.1	\N
26	92	IHE824357.1	\N
27	94	IHE824357.1	\N
28	99	IHE383143.3	\N
29	101	IHE383143.3	\N
30	103	IHE383143.3	\N
31	104	IHE383143.3	\N
32	108	IHE383143.3	\N
33	110	IHE383143.3	\N
34	112	IHE383143.3	\N
35	113	IHE383143.3	\N
36	114	IHE383143.3	\N
37	115	IHE383143.3	\N
38	122	IHE383143.3	\N
39	130	IHE383143.3	\N
40	132	IHE383143.3	\N
41	134	IHE383143.3	\N
42	142	IHE484882.0	\N
43	145	IHE484882.0	\N
44	147	IHE484882.0	\N
45	148	IHE484882.0	\N
46	161	IHE484882.0	\N
47	166	IHE484882.0	\N
48	168	IHE484882.0	\N
49	170	IHE484882.0	\N
50	176	IHE862899.3	\N
51	178	IHE862899.3	\N
52	180	IHE862899.3	\N
53	210	IHE355299.7	\N
54	213	IHE355299.7	\N
55	215	IHE355299.7	\N
56	221	IHE824357.3	\N
57	223	IHE824357.3	\N
58	226	IHE824357.3	\N
59	243	IHE316111.0	\N
60	269	IHE484882.5	\N
61	272	IHE484882.5	\N
62	283	IHE9357.10	\N
63	286	IHE9357.10	\N
64	288	IHE9357.10	\N
65	300	IHE9357.10	\N
66	306	IHE9357.10	\N
67	308	IHE9357.10	\N
68	310	IHE9357.10	\N
69	331	IHE9357.11	\N
70	334	IHE9357.11	\N
71	336	IHE9357.11	\N
72	346	IHE9357.12	\N
73	351	IHE9357.12	\N
74	353	IHE9357.12	\N
75	378	IHE9357.11	\N
76	380	IHE9357.11	\N
77	382	IHE9357.11	\N
78	398	IHE112174.2	\N
79	406	IHE9357.13	\N
80	406	IHE9357.14	\N
81	414	IHE9357.12	\N
82	415	IHE9357.13	\N
83	415	IHE9357.14	\N
84	418	IHE9357.13	\N
85	418	IHE9357.14	\N
86	421	IHE9357.12	\N
87	423	IHE9357.12	\N
88	434	IHE9357.15	\N
89	434	IHE9357.16	\N
90	441	IHE9357.15	\N
91	441	IHE9357.16	\N
92	444	IHE9357.15	\N
93	444	IHE9357.16	\N
94	446	IHE9357.15	\N
95	446	IHE9357.16	\N
96	453	IHE9357.17	\N
97	453	IHE9357.18	\N
98	457	IHE9357.18	\N
99	459	IHE9357.17	\N
100	459	IHE9357.18	\N
101	465	IHE9357.19	\N
102	465	IHE9357.20	\N
103	469	IHE9357.20	\N
104	471	IHE9357.19	\N
105	471	IHE9357.20	\N
106	474	IHE9357.19	\N
107	474	IHE9357.20	\N
108	476	IHE9357.19	\N
109	476	IHE9357.20	\N
110	483	IHE2541.21	\N
111	486	IHE2541.21	\N
112	488	IHE2541.21	\N
113	500	IHE2541.22	\N
114	503	IHE2541.22	\N
115	505	IHE2541.22	\N
116	506	IHE2541.22	\N
117	516	IHE2541.23	\N
118	519	IHE2541.23	\N
119	521	IHE2541.23	\N
120	528	IHE2541.24	\N
121	531	IHE2541.24	\N
122	533	IHE2541.24	\N
123	542	IHE2541.25	\N
124	545	IHE2541.25	\N
125	547	IHE2541.25	\N
126	553	IHE9357.11	\N
127	557	IHE112174.4	\N
128	561	IHE112174.4	\N
129	563	IHE112174.4	\N
130	577	IHE2541.25	\N
131	582	IHE2541.26	\N
132	585	IHE2541.26	\N
133	587	IHE2541.26	\N
134	594	IHE2541.27	\N
135	597	IHE2541.27	\N
136	599	IHE2541.27	\N
137	605	IHE2541.28	\N
138	608	IHE2541.28	\N
139	610	IHE2541.28	\N
140	615	IHE2541.29	\N
141	618	IHE2541.29	\N
142	620	IHE2541.29	\N
143	631	IHE2541.30	\N
144	634	IHE2541.30	\N
145	636	IHE2541.30	\N
146	643	IHE288621.0	\N
147	646	IHE288621.0	\N
148	648	IHE288621.0	\N
149	667	IHE64729.0	\N
150	670	IHE64729.0	\N
151	673	IHE64729.0	\N
152	679	IHE64729.1	\N
153	682	IHE64729.1	\N
154	684	IHE64729.1	\N
155	690	IHE64729.2	\N
156	693	IHE64729.2	\N
157	695	IHE64729.2	\N
158	703	IHE64729.3	\N
159	706	IHE64729.3	\N
160	708	IHE64729.3	\N
161	714	IHE64729.4	\N
162	717	IHE64729.4	\N
163	719	IHE64729.4	\N
164	726	IHE64729.5	\N
165	729	IHE64729.4	\N
166	729	IHE64729.5	\N
167	731	IHE64729.5	\N
168	737	IHE64729.6	\N
169	740	IHE64729.6	\N
170	742	IHE64729.6	\N
171	748	IHE64729.7	\N
172	751	IHE64729.7	\N
173	753	IHE64729.7	\N
174	759	IHE64729.8	\N
175	762	IHE64729.8	\N
176	764	IHE64729.8	\N
177	770	IHE64729.9	\N
178	773	IHE64729.9	\N
179	775	IHE64729.9	\N
180	781	IHE64729.10	\N
181	784	IHE64729.10	\N
182	786	IHE64729.10	\N
183	792	IHE64729.11	\N
184	796	IHE64729.11	\N
185	798	IHE64729.11	\N
186	804	IHE64729.12	\N
187	807	IHE64729.12	\N
188	809	IHE64729.12	\N
189	815	IHE64729.13	\N
190	818	IHE64729.13	\N
191	820	IHE64729.13	\N
192	826	IHE64729.14	\N
193	829	IHE64729.14	\N
194	831	IHE64729.14	\N
195	837	IHE64729.15	\N
196	840	IHE64729.15	\N
197	842	IHE64729.15	\N
\.


--
-- Data for Name: hipaa_audit_mrns; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY hipaa_audit_mrns (id, view_id, mrn, modified_date) FROM stdin;
1	3	678188495	\N
2	4	678188495	\N
3	4	478684182	\N
4	4	757590308	\N
5	4	211907445	\N
6	4	01234561	\N
7	5	678188495	\N
8	6	678188495	\N
9	7	678188495	\N
10	8	678188495	\N
11	9	678188495	\N
12	10	678188495	\N
13	11	678188495	\N
14	12	678188495	\N
15	14	678188495	\N
16	14	478684182	\N
17	14	757590308	\N
18	14	211907445	\N
19	14	01234561	\N
20	15	211907445	\N
21	16	211907445	\N
22	17	211907445	\N
23	18	211907445	\N
24	20	211907445	\N
25	23	678188495	\N
26	23	478684182	\N
27	23	757590308	\N
28	23	211907445	\N
29	23	01234561	\N
30	24	678188495	\N
31	25	678188495	\N
32	26	678188495	\N
33	28	678188495	\N
34	29	678188495	\N
35	30	678188495	\N
36	31	678188495	\N
37	32	678188495	\N
38	32	478684182	\N
39	32	757590308	\N
40	32	211907445	\N
41	32	01234561	\N
42	32	478129521	\N
43	32	444933559	\N
44	32	440056642	\N
45	32	550895459	\N
46	32	852215460	\N
47	33	852215460	\N
48	34	852215460	\N
49	35	852215460	\N
50	36	852215460	\N
51	37	852215460	\N
52	38	852215460	\N
53	39	852215460	\N
54	40	852215460	\N
55	42	678188495	\N
56	42	550895459	\N
57	42	852215460	\N
58	45	678188495	\N
59	45	550895459	\N
60	45	852215460	\N
61	46	678188495	\N
62	47	678188495	\N
63	48	678188495	\N
64	49	678188495	\N
65	51	678188495	\N
66	51	550895459	\N
67	51	852215460	\N
68	52	678188495	\N
69	53	678188495	\N
70	54	678188495	\N
71	55	678188495	\N
72	56	678188495	\N
73	57	678188495	\N
74	58	678188495	\N
75	60	678188495	\N
76	60	550895459	\N
77	60	852215460	\N
78	60	288875450	\N
79	61	288875450	\N
80	62	288875450	\N
81	63	288875450	\N
82	64	288875450	\N
83	65	288875450	\N
84	66	288875450	\N
85	67	288875450	\N
86	68	288875450	\N
87	69	288875450	\N
88	71	288875450	\N
89	71	678188495	\N
90	71	550895459	\N
91	71	852215460	\N
92	71	389321721	\N
93	71	199710663	\N
94	72	199710663	\N
95	73	199710663	\N
96	74	199710663	\N
97	75	199710663	\N
98	76	199710663	\N
99	77	199710663	\N
100	78	199710663	\N
101	79	199710663	\N
102	80	199710663	\N
103	81	199710663	\N
104	82	199710663	\N
105	84	288875450	\N
106	84	678188495	\N
107	84	550895459	\N
108	84	852215460	\N
109	84	389321721	\N
110	84	199710663	\N
111	85	389321721	\N
112	86	389321721	\N
113	87	389321721	\N
114	88	389321721	\N
115	89	389321721	\N
116	90	389321721	\N
117	91	389321721	\N
118	92	389321721	\N
119	93	389321721	\N
120	94	389321721	\N
121	95	389321721	\N
122	97	288875450	\N
123	97	678188495	\N
124	97	550895459	\N
125	97	852215460	\N
126	97	389321721	\N
127	97	199710663	\N
128	98	678188495	\N
129	99	678188495	\N
130	100	678188495	\N
131	101	678188495	\N
132	102	678188495	\N
133	103	678188495	\N
134	104	678188495	\N
135	106	678188495	\N
136	106	852215460	\N
137	106	389321721	\N
138	106	199710663	\N
139	106	577900744	\N
140	107	678188495	\N
141	108	678188495	\N
142	109	678188495	\N
143	110	678188495	\N
144	111	678188495	\N
145	112	678188495	\N
146	113	678188495	\N
147	114	678188495	\N
148	115	678188495	\N
149	116	678188495	\N
150	118	678188495	\N
151	118	852215460	\N
152	118	389321721	\N
153	118	199710663	\N
154	118	577900744	\N
155	120	678188495	\N
156	120	852215460	\N
157	120	577900744	\N
158	120	389321721	\N
159	120	199710663	\N
160	121	678188495	\N
161	122	678188495	\N
162	128	678188495	\N
163	128	852215460	\N
164	128	577900744	\N
165	128	389321721	\N
166	128	199710663	\N
167	129	678188495	\N
168	130	678188495	\N
169	131	678188495	\N
170	132	678188495	\N
171	133	678188495	\N
172	134	678188495	\N
173	135	678188495	\N
174	138	678188495	\N
175	138	852215460	\N
176	138	577900744	\N
177	138	389321721	\N
178	138	199710663	\N
179	138	683319969	\N
180	139	683319969	\N
181	140	683319969	\N
182	141	683319969	\N
183	142	683319969	\N
184	143	683319969	\N
185	144	683319969	\N
186	145	683319969	\N
187	146	683319969	\N
188	147	683319969	\N
189	148	683319969	\N
190	154	678188495	\N
191	156	678188495	\N
192	156	852215460	\N
193	156	577900744	\N
194	156	389321721	\N
195	156	199710663	\N
196	156	683319969	\N
197	159	678188495	\N
198	159	852215460	\N
199	159	577900744	\N
200	159	389321721	\N
201	159	199710663	\N
202	159	683319969	\N
203	159	818163599	\N
204	159	313922369	\N
205	159	900340334	\N
206	159	169998861	\N
207	159	319384274	\N
208	159	941543187	\N
209	159	154451252	\N
210	159	196921969	\N
211	159	188602961	\N
212	159	650856216	\N
213	159	603406323	\N
214	159	613859951	\N
215	159	393594062	\N
216	160	683319969	\N
217	161	683319969	\N
218	162	683319969	\N
219	163	683319969	\N
220	164	683319969	\N
221	165	683319969	\N
222	166	683319969	\N
223	167	683319969	\N
224	168	683319969	\N
225	169	683319969	\N
226	170	683319969	\N
227	171	683319969	\N
228	173	678188495	\N
229	173	852215460	\N
230	173	577900744	\N
231	173	389321721	\N
232	173	199710663	\N
233	173	683319969	\N
234	173	818163599	\N
235	173	313922369	\N
236	173	900340334	\N
237	173	169998861	\N
238	173	319384274	\N
239	173	941543187	\N
240	173	154451252	\N
241	173	196921969	\N
242	173	188602961	\N
243	173	650856216	\N
244	173	603406323	\N
245	173	613859951	\N
246	173	393594062	\N
247	174	188602961	\N
248	175	188602961	\N
249	176	188602961	\N
250	177	188602961	\N
251	178	188602961	\N
252	179	188602961	\N
253	180	188602961	\N
254	183	678188495	\N
255	183	852215460	\N
256	183	577900744	\N
257	183	389321721	\N
258	183	199710663	\N
259	183	683319969	\N
260	183	818163599	\N
261	183	313922369	\N
262	183	900340334	\N
263	183	169998861	\N
264	183	319384274	\N
265	183	941543187	\N
266	183	154451252	\N
267	183	196921969	\N
268	183	188602961	\N
269	183	650856216	\N
270	183	603406323	\N
271	183	613859951	\N
272	183	393594062	\N
273	184	678188495	\N
274	184	852215460	\N
275	184	577900744	\N
276	184	389321721	\N
277	184	199710663	\N
278	184	683319969	\N
279	184	818163599	\N
280	184	313922369	\N
281	184	900340334	\N
282	184	169998861	\N
283	184	319384274	\N
284	184	941543187	\N
285	184	154451252	\N
286	184	196921969	\N
287	184	188602961	\N
288	184	650856216	\N
289	184	603406323	\N
290	184	613859951	\N
291	184	393594062	\N
292	186	678188495	\N
293	186	852215460	\N
294	186	577900744	\N
295	186	389321721	\N
296	186	199710663	\N
297	186	683319969	\N
298	186	818163599	\N
299	186	313922369	\N
300	186	900340334	\N
301	186	169998861	\N
302	186	319384274	\N
303	186	941543187	\N
304	186	154451252	\N
305	186	196921969	\N
306	186	188602961	\N
307	186	650856216	\N
308	186	603406323	\N
309	186	613859951	\N
310	186	393594062	\N
311	188	678188495	\N
312	188	852215460	\N
313	188	577900744	\N
314	188	389321721	\N
315	188	199710663	\N
316	188	683319969	\N
317	188	818163599	\N
318	188	313922369	\N
319	188	900340334	\N
320	188	169998861	\N
321	188	319384274	\N
322	188	941543187	\N
323	188	154451252	\N
324	188	196921969	\N
325	188	188602961	\N
326	188	650856216	\N
327	188	603406323	\N
328	188	613859951	\N
329	188	393594062	\N
330	190	678188495	\N
331	190	852215460	\N
332	190	577900744	\N
333	190	389321721	\N
334	190	199710663	\N
335	190	683319969	\N
336	190	818163599	\N
337	190	313922369	\N
338	190	900340334	\N
339	190	169998861	\N
340	190	319384274	\N
341	190	941543187	\N
342	190	154451252	\N
343	190	196921969	\N
344	190	188602961	\N
345	190	650856216	\N
346	190	603406323	\N
347	190	613859951	\N
348	190	393594062	\N
349	192	678188495	\N
350	192	852215460	\N
351	192	577900744	\N
352	192	389321721	\N
353	192	199710663	\N
354	192	683319969	\N
355	192	818163599	\N
356	192	313922369	\N
357	192	900340334	\N
358	192	169998861	\N
359	192	319384274	\N
360	192	941543187	\N
361	192	154451252	\N
362	192	196921969	\N
363	192	188602961	\N
364	192	650856216	\N
365	192	603406323	\N
366	192	613859951	\N
367	192	393594062	\N
368	196	678188495	\N
369	196	852215460	\N
370	196	577900744	\N
371	196	389321721	\N
372	196	199710663	\N
373	196	683319969	\N
374	196	818163599	\N
375	196	313922369	\N
376	196	900340334	\N
377	196	169998861	\N
378	196	319384274	\N
379	196	941543187	\N
380	196	154451252	\N
381	196	196921969	\N
382	196	188602961	\N
383	196	650856216	\N
384	196	603406323	\N
385	196	613859951	\N
386	196	393594062	\N
387	198	678188495	\N
388	198	852215460	\N
389	198	577900744	\N
390	198	389321721	\N
391	198	199710663	\N
392	198	683319969	\N
393	198	818163599	\N
394	198	313922369	\N
395	198	900340334	\N
396	198	169998861	\N
397	198	319384274	\N
398	198	941543187	\N
399	198	154451252	\N
400	198	196921969	\N
401	198	188602961	\N
402	198	650856216	\N
403	198	603406323	\N
404	198	613859951	\N
405	198	393594062	\N
406	200	678188495	\N
407	200	852215460	\N
408	200	577900744	\N
409	200	389321721	\N
410	200	199710663	\N
411	200	683319969	\N
412	200	818163599	\N
413	200	313922369	\N
414	200	900340334	\N
415	200	169998861	\N
416	200	319384274	\N
417	200	941543187	\N
418	200	154451252	\N
419	200	196921969	\N
420	200	188602961	\N
421	200	650856216	\N
422	200	603406323	\N
423	200	613859951	\N
424	200	393594062	\N
425	202	678188495	\N
426	202	852215460	\N
427	202	577900744	\N
428	202	389321721	\N
429	202	199710663	\N
430	202	683319969	\N
431	202	818163599	\N
432	202	313922369	\N
433	202	900340334	\N
434	202	169998861	\N
435	202	319384274	\N
436	202	941543187	\N
437	202	154451252	\N
438	202	196921969	\N
439	202	188602961	\N
440	202	650856216	\N
441	202	603406323	\N
442	202	613859951	\N
443	202	393594062	\N
444	206	678188495	\N
445	206	852215460	\N
446	206	577900744	\N
447	206	389321721	\N
448	206	199710663	\N
449	206	683319969	\N
450	206	818163599	\N
451	206	313922369	\N
452	206	900340334	\N
453	206	169998861	\N
454	206	319384274	\N
455	206	941543187	\N
456	206	154451252	\N
457	206	196921969	\N
458	206	188602961	\N
459	206	650856216	\N
460	206	603406323	\N
461	206	613859951	\N
462	206	393594062	\N
463	207	169998861	\N
464	208	169998861	\N
465	209	169998861	\N
466	210	169998861	\N
467	211	169998861	\N
468	212	169998861	\N
469	213	169998861	\N
470	214	169998861	\N
471	215	169998861	\N
472	219	678188495	\N
473	219	852215460	\N
474	219	577900744	\N
475	219	389321721	\N
476	219	199710663	\N
477	219	683319969	\N
478	219	818163599	\N
479	219	313922369	\N
480	219	900340334	\N
481	219	169998861	\N
482	219	319384274	\N
483	219	941543187	\N
484	219	154451252	\N
485	219	196921969	\N
486	219	188602961	\N
487	219	650856216	\N
488	219	603406323	\N
489	219	613859951	\N
490	219	393594062	\N
491	220	199710663	\N
492	221	199710663	\N
493	222	199710663	\N
494	223	199710663	\N
495	224	199710663	\N
496	225	199710663	\N
497	226	199710663	\N
498	230	199710663	\N
499	232	678188495	\N
500	232	852215460	\N
501	232	577900744	\N
502	232	389321721	\N
503	232	199710663	\N
504	232	683319969	\N
505	232	818163599	\N
506	232	313922369	\N
507	232	900340334	\N
508	232	169998861	\N
509	232	319384274	\N
510	232	941543187	\N
511	232	154451252	\N
512	232	196921969	\N
513	232	188602961	\N
514	232	650856216	\N
515	232	603406323	\N
516	232	613859951	\N
517	232	393594062	\N
518	239	678188495	\N
519	239	852215460	\N
520	239	577900744	\N
521	239	389321721	\N
522	239	199710663	\N
523	239	683319969	\N
524	239	818163599	\N
525	239	313922369	\N
526	239	900340334	\N
527	239	169998861	\N
528	239	319384274	\N
529	239	941543187	\N
530	239	154451252	\N
531	239	196921969	\N
532	239	188602961	\N
533	239	650856216	\N
534	239	603406323	\N
535	239	613859951	\N
536	239	393594062	\N
537	240	818163599	\N
538	241	818163599	\N
539	242	818163599	\N
540	243	818163599	\N
541	244	818163599	\N
542	250	818163599	\N
543	261	678188495	\N
544	261	852215460	\N
545	261	577900744	\N
546	261	389321721	\N
547	261	199710663	\N
548	261	683319969	\N
549	261	818163599	\N
550	261	313922369	\N
551	261	900340334	\N
552	261	169998861	\N
553	261	319384274	\N
554	261	941543187	\N
555	261	154451252	\N
556	261	196921969	\N
557	261	188602961	\N
558	261	650856216	\N
559	261	603406323	\N
560	261	613859951	\N
561	261	393594062	\N
562	264	852215460	\N
563	264	577900744	\N
564	264	199710663	\N
565	264	683319969	\N
566	264	288128487	\N
567	266	852215460	\N
568	266	577900744	\N
569	266	199710663	\N
570	266	683319969	\N
571	266	288128487	\N
572	266	123998648	\N
573	267	123998648	\N
574	268	123998648	\N
575	269	123998648	\N
576	270	123998648	\N
577	271	123998648	\N
578	272	123998648	\N
579	274	678188495	\N
580	274	852215460	\N
581	274	577900744	\N
582	274	389321721	\N
583	274	199710663	\N
584	274	683319969	\N
585	274	818163599	\N
586	274	313922369	\N
587	274	900340334	\N
588	274	169998861	\N
589	274	319384274	\N
590	274	941543187	\N
591	274	154451252	\N
592	274	196921969	\N
593	274	188602961	\N
594	274	650856216	\N
595	274	603406323	\N
596	274	613859951	\N
597	274	393594062	\N
598	274	288128487	\N
599	274	123998648	\N
600	274	939894620	\N
601	274	147563401	\N
602	274	903496451	\N
603	274	251566329	\N
604	274	283348176	\N
605	280	283348176	\N
606	281	283348176	\N
607	282	283348176	\N
608	283	283348176	\N
609	284	283348176	\N
610	285	283348176	\N
611	286	283348176	\N
612	287	283348176	\N
613	288	283348176	\N
614	296	283348176	\N
615	298	283348176	\N
616	299	283348176	\N
617	300	283348176	\N
618	302	283348176	\N
619	304	283348176	\N
620	305	283348176	\N
621	306	283348176	\N
622	307	283348176	\N
623	308	283348176	\N
624	309	283348176	\N
625	310	283348176	\N
626	311	283348176	\N
627	325	283348176	\N
628	328	764467765	\N
629	328	678188495	\N
630	328	852215460	\N
631	328	577900744	\N
632	328	389321721	\N
633	328	199710663	\N
634	328	683319969	\N
635	328	818163599	\N
636	328	313922369	\N
637	328	900340334	\N
638	328	169998861	\N
639	328	319384274	\N
640	328	941543187	\N
641	328	154451252	\N
642	328	196921969	\N
643	328	188602961	\N
644	328	650856216	\N
645	328	603406323	\N
646	328	613859951	\N
647	328	393594062	\N
648	328	288128487	\N
649	328	123998648	\N
650	328	939894620	\N
651	328	147563401	\N
652	328	903496451	\N
653	328	251566329	\N
654	328	283348176	\N
655	329	764467765	\N
656	330	764467765	\N
657	331	764467765	\N
658	332	764467765	\N
659	333	764467765	\N
660	334	764467765	\N
661	335	764467765	\N
662	336	764467765	\N
663	339	764467765	\N
664	341	764467765	\N
665	341	731880094	\N
666	341	632406555	\N
667	341	678188495	\N
668	341	981912619	\N
669	341	852215460	\N
670	341	130224392	\N
671	341	577900744	\N
672	341	389321721	\N
673	341	199710663	\N
674	341	683319969	\N
675	341	818163599	\N
676	341	313922369	\N
677	341	900340334	\N
678	341	169998861	\N
679	341	319384274	\N
680	341	941543187	\N
681	341	154451252	\N
682	341	196921969	\N
683	341	188602961	\N
684	341	650856216	\N
685	341	603406323	\N
686	341	613859951	\N
687	341	393594062	\N
688	341	288128487	\N
689	341	123998648	\N
690	341	939894620	\N
691	341	147563401	\N
692	341	903496451	\N
693	341	251566329	\N
694	341	283348176	\N
695	343	130224392	\N
696	344	130224392	\N
697	345	130224392	\N
698	346	130224392	\N
699	347	130224392	\N
700	349	764467765	\N
701	349	731880094	\N
702	349	632406555	\N
703	349	678188495	\N
704	349	981912619	\N
705	349	852215460	\N
706	349	130224392	\N
707	349	577900744	\N
708	349	389321721	\N
709	349	199710663	\N
710	349	683319969	\N
711	349	818163599	\N
712	349	313922369	\N
713	349	900340334	\N
714	349	169998861	\N
715	349	319384274	\N
716	349	941543187	\N
717	349	154451252	\N
718	349	196921969	\N
719	349	188602961	\N
720	349	650856216	\N
721	349	603406323	\N
722	349	613859951	\N
723	349	393594062	\N
724	349	288128487	\N
725	349	123998648	\N
726	349	939894620	\N
727	349	147563401	\N
728	349	903496451	\N
729	349	251566329	\N
730	349	283348176	\N
731	350	130224392	\N
732	351	130224392	\N
733	352	130224392	\N
734	353	130224392	\N
735	360	130224392	\N
736	362	731880094	\N
737	375	764467765	\N
738	375	731880094	\N
739	375	632406555	\N
740	375	678188495	\N
741	375	981912619	\N
742	375	852215460	\N
743	375	130224392	\N
744	375	577900744	\N
745	375	389321721	\N
746	375	199710663	\N
747	375	683319969	\N
748	375	818163599	\N
749	375	313922369	\N
750	375	900340334	\N
751	375	169998861	\N
752	375	319384274	\N
753	375	941543187	\N
754	375	154451252	\N
755	375	196921969	\N
756	375	188602961	\N
757	375	650856216	\N
758	375	603406323	\N
759	375	613859951	\N
760	375	393594062	\N
761	375	288128487	\N
762	375	123998648	\N
763	375	939894620	\N
764	375	147563401	\N
765	375	903496451	\N
766	375	251566329	\N
767	375	283348176	\N
768	376	764467765	\N
769	377	764467765	\N
770	378	764467765	\N
771	379	764467765	\N
772	380	764467765	\N
773	381	764467765	\N
774	382	764467765	\N
775	385	764467765	\N
776	389	764467765	\N
777	389	731880094	\N
778	389	632406555	\N
779	389	678188495	\N
780	389	981912619	\N
781	389	852215460	\N
782	389	130224392	\N
783	389	577900744	\N
784	389	389321721	\N
785	389	199710663	\N
786	389	683319969	\N
787	389	818163599	\N
788	389	313922369	\N
789	389	900340334	\N
790	389	169998861	\N
791	389	319384274	\N
792	389	941543187	\N
793	389	154451252	\N
794	389	196921969	\N
795	389	188602961	\N
796	389	650856216	\N
797	389	603406323	\N
798	389	613859951	\N
799	389	393594062	\N
800	389	288128487	\N
801	389	123998648	\N
802	389	939894620	\N
803	389	147563401	\N
804	389	903496451	\N
805	389	251566329	\N
806	389	283348176	\N
807	391	731880094	\N
808	391	632406555	\N
809	391	188602961	\N
810	391	613859951	\N
811	394	731880094	\N
812	394	632406555	\N
813	394	613859951	\N
814	395	731880094	\N
815	395	632406555	\N
816	395	188602961	\N
817	395	613859951	\N
818	396	731880094	\N
819	397	731880094	\N
820	398	731880094	\N
821	399	731880094	\N
822	400	731880094	\N
823	403	317082933	\N
824	404	317082933	\N
825	405	317082933	\N
826	406	317082933	\N
827	407	317082933	\N
828	408	317082933	\N
829	409	317082933	\N
830	412	130224392	\N
831	412	283348176	\N
832	412	317082933	\N
833	413	130224392	\N
834	414	130224392	\N
835	415	317082933	\N
836	416	130224392	\N
837	417	317082933	\N
838	418	317082933	\N
839	421	130224392	\N
840	422	130224392	\N
841	423	130224392	\N
842	424	130224392	\N
843	427	764467765	\N
844	427	731880094	\N
845	427	632406555	\N
846	427	678188495	\N
847	427	981912619	\N
848	427	852215460	\N
849	427	130224392	\N
850	427	577900744	\N
851	427	389321721	\N
852	427	199710663	\N
853	427	683319969	\N
854	427	818163599	\N
855	427	313922369	\N
856	427	900340334	\N
857	427	169998861	\N
858	427	319384274	\N
859	427	941543187	\N
860	427	154451252	\N
861	427	196921969	\N
862	427	188602961	\N
863	427	650856216	\N
864	427	603406323	\N
865	427	613859951	\N
866	427	393594062	\N
867	427	288128487	\N
868	427	123998648	\N
869	427	939894620	\N
870	427	147563401	\N
871	427	903496451	\N
872	427	251566329	\N
873	427	283348176	\N
874	427	317082933	\N
875	429	317082933	\N
876	431	764467765	\N
877	431	102335231	\N
878	431	731880094	\N
879	431	632406555	\N
880	431	678188495	\N
881	431	981912619	\N
882	431	852215460	\N
883	431	130224392	\N
884	431	577900744	\N
885	431	389321721	\N
886	431	199710663	\N
887	431	683319969	\N
888	431	818163599	\N
889	431	313922369	\N
890	431	900340334	\N
891	431	169998861	\N
892	431	319384274	\N
893	431	941543187	\N
894	431	154451252	\N
895	431	196921969	\N
896	431	188602961	\N
897	431	650856216	\N
898	431	603406323	\N
899	431	613859951	\N
900	431	393594062	\N
901	431	288128487	\N
902	431	123998648	\N
903	431	939894620	\N
904	431	147563401	\N
905	431	903496451	\N
906	431	251566329	\N
907	431	283348176	\N
908	431	317082933	\N
909	432	102335231	\N
910	433	102335231	\N
911	434	102335231	\N
912	435	102335231	\N
913	437	102335231	\N
914	439	764467765	\N
915	439	102335231	\N
916	439	731880094	\N
917	439	632406555	\N
918	439	678188495	\N
919	439	981912619	\N
920	439	852215460	\N
921	439	130224392	\N
922	439	577900744	\N
923	439	389321721	\N
924	439	199710663	\N
925	439	683319969	\N
926	439	818163599	\N
927	439	313922369	\N
928	439	900340334	\N
929	439	169998861	\N
930	439	319384274	\N
931	439	941543187	\N
932	439	154451252	\N
933	439	196921969	\N
934	439	188602961	\N
935	439	650856216	\N
936	439	603406323	\N
937	439	613859951	\N
938	439	393594062	\N
939	439	288128487	\N
940	439	123998648	\N
941	439	939894620	\N
942	439	147563401	\N
943	439	903496451	\N
944	439	251566329	\N
945	439	283348176	\N
946	439	317082933	\N
947	440	102335231	\N
948	441	102335231	\N
949	442	102335231	\N
950	443	102335231	\N
951	444	102335231	\N
952	445	102335231	\N
953	446	102335231	\N
954	448	102335231	\N
955	450	764467765	\N
956	450	102335231	\N
957	450	818731508	\N
958	450	731880094	\N
959	450	632406555	\N
960	450	678188495	\N
961	450	981912619	\N
962	450	852215460	\N
963	450	130224392	\N
964	450	577900744	\N
965	450	389321721	\N
966	450	199710663	\N
967	450	683319969	\N
968	450	818163599	\N
969	450	313922369	\N
970	450	900340334	\N
971	450	169998861	\N
972	450	319384274	\N
973	450	941543187	\N
974	450	154451252	\N
975	450	196921969	\N
976	450	188602961	\N
977	450	650856216	\N
978	450	603406323	\N
979	450	613859951	\N
980	450	393594062	\N
981	450	288128487	\N
982	450	123998648	\N
983	450	939894620	\N
984	450	147563401	\N
985	450	903496451	\N
986	450	251566329	\N
987	450	283348176	\N
988	450	317082933	\N
989	451	818731508	\N
990	452	818731508	\N
991	453	818731508	\N
992	454	818731508	\N
993	455	818731508	\N
994	456	818731508	\N
995	457	818731508	\N
996	458	818731508	\N
997	459	818731508	\N
998	460	818731508	\N
999	462	764467765	\N
1000	462	102335231	\N
1001	462	818731508	\N
1002	462	731880094	\N
1003	462	632406555	\N
1004	462	678188495	\N
1005	462	981912619	\N
1006	462	852215460	\N
1007	462	130224392	\N
1008	462	577900744	\N
1009	462	389321721	\N
1010	462	199710663	\N
1011	462	683319969	\N
1012	462	818163599	\N
1013	462	313922369	\N
1014	462	900340334	\N
1015	462	169998861	\N
1016	462	319384274	\N
1017	462	941543187	\N
1018	462	154451252	\N
1019	462	196921969	\N
1020	462	188602961	\N
1021	462	650856216	\N
1022	462	603406323	\N
1023	462	613859951	\N
1024	462	393594062	\N
1025	462	288128487	\N
1026	462	123998648	\N
1027	462	939894620	\N
1028	462	147563401	\N
1029	462	903496451	\N
1030	462	251566329	\N
1031	462	283348176	\N
1032	462	357656050	\N
1033	462	317082933	\N
1034	463	357656050	\N
1035	464	357656050	\N
1036	465	357656050	\N
1037	466	357656050	\N
1038	467	357656050	\N
1039	468	357656050	\N
1040	469	357656050	\N
1041	470	357656050	\N
1042	471	357656050	\N
1043	472	357656050	\N
1044	473	357656050	\N
1045	474	357656050	\N
1046	475	357656050	\N
1047	476	357656050	\N
1048	480	764467765	\N
1049	480	102335231	\N
1050	480	818731508	\N
1051	480	731880094	\N
1052	480	632406555	\N
1053	480	678188495	\N
1054	480	981912619	\N
1055	480	852215460	\N
1056	480	130224392	\N
1057	480	577900744	\N
1058	480	389321721	\N
1059	480	199710663	\N
1060	480	683319969	\N
1061	480	818163599	\N
1062	480	313922369	\N
1063	480	900340334	\N
1064	480	169998861	\N
1065	480	319384274	\N
1066	480	941543187	\N
1067	480	154451252	\N
1068	480	196921969	\N
1069	480	188602961	\N
1070	480	650856216	\N
1071	480	603406323	\N
1072	480	613859951	\N
1073	480	393594062	\N
1074	480	288128487	\N
1075	480	123998648	\N
1076	480	939894620	\N
1077	480	147563401	\N
1078	480	903496451	\N
1079	480	251566329	\N
1080	480	283348176	\N
1081	480	357656050	\N
1082	480	317082933	\N
1083	480	430754812	\N
1084	481	430754812	\N
1085	482	430754812	\N
1086	483	430754812	\N
1087	484	430754812	\N
1088	485	430754812	\N
1089	486	430754812	\N
1090	487	430754812	\N
1091	488	430754812	\N
1092	496	764467765	\N
1093	496	102335231	\N
1094	496	818731508	\N
1095	496	731880094	\N
1096	496	632406555	\N
1097	496	678188495	\N
1098	496	981912619	\N
1099	496	852215460	\N
1100	496	130224392	\N
1101	496	577900744	\N
1102	496	389321721	\N
1103	496	199710663	\N
1104	496	683319969	\N
1105	496	818163599	\N
1106	496	313922369	\N
1107	496	900340334	\N
1108	496	169998861	\N
1109	496	319384274	\N
1110	496	941543187	\N
1111	496	154451252	\N
1112	496	196921969	\N
1113	496	188602961	\N
1114	496	650856216	\N
1115	496	603406323	\N
1116	496	613859951	\N
1117	496	393594062	\N
1118	496	288128487	\N
1119	496	123998648	\N
1120	496	939894620	\N
1121	496	147563401	\N
1122	496	903496451	\N
1123	496	251566329	\N
1124	496	283348176	\N
1125	496	357656050	\N
1126	496	317082933	\N
1127	496	430754812	\N
1128	496	619438774	\N
1129	497	430754812	\N
1130	497	619438774	\N
1131	498	619438774	\N
1132	499	619438774	\N
1133	500	619438774	\N
1134	501	619438774	\N
1135	502	619438774	\N
1136	503	619438774	\N
1137	504	619438774	\N
1138	505	619438774	\N
1139	506	619438774	\N
1140	507	619438774	\N
1141	509	430754812	\N
1142	509	619438774	\N
1143	510	430754812	\N
1144	510	619438774	\N
1145	511	430754812	\N
1146	511	619438774	\N
1147	512	430754812	\N
1148	512	619438774	\N
1149	513	764467765	\N
1150	513	102335231	\N
1151	513	818731508	\N
1152	513	731880094	\N
1153	513	632406555	\N
1154	513	678188495	\N
1155	513	981912619	\N
1156	513	852215460	\N
1157	513	130224392	\N
1158	513	577900744	\N
1159	513	389321721	\N
1160	513	199710663	\N
1161	513	683319969	\N
1162	513	818163599	\N
1163	513	313922369	\N
1164	513	900340334	\N
1165	513	169998861	\N
1166	513	319384274	\N
1167	513	941543187	\N
1168	513	154451252	\N
1169	513	196921969	\N
1170	513	188602961	\N
1171	513	650856216	\N
1172	513	603406323	\N
1173	513	613859951	\N
1174	513	393594062	\N
1175	513	288128487	\N
1176	513	123998648	\N
1177	513	939894620	\N
1178	513	147563401	\N
1179	513	903496451	\N
1180	513	251566329	\N
1181	513	283348176	\N
1182	513	357656050	\N
1183	513	317082933	\N
1184	513	430754812	\N
1185	513	619438774	\N
1186	513	709222489	\N
1187	514	709222489	\N
1188	515	709222489	\N
1189	516	709222489	\N
1190	517	709222489	\N
1191	518	709222489	\N
1192	519	709222489	\N
1193	520	709222489	\N
1194	521	709222489	\N
1195	523	709222489	\N
1196	525	842999018	\N
1197	526	842999018	\N
1198	527	842999018	\N
1199	528	842999018	\N
1200	529	842999018	\N
1201	530	842999018	\N
1202	531	842999018	\N
1203	532	842999018	\N
1204	533	842999018	\N
1205	535	842999018	\N
1206	537	764467765	\N
1207	537	102335231	\N
1208	537	818731508	\N
1209	537	731880094	\N
1210	537	632406555	\N
1211	537	678188495	\N
1212	537	981912619	\N
1213	537	852215460	\N
1214	537	130224392	\N
1215	537	577900744	\N
1216	537	389321721	\N
1217	537	199710663	\N
1218	537	683319969	\N
1219	537	818163599	\N
1220	537	313922369	\N
1221	537	900340334	\N
1222	537	169998861	\N
1223	537	319384274	\N
1224	537	941543187	\N
1225	537	154451252	\N
1226	537	196921969	\N
1227	537	188602961	\N
1228	537	650856216	\N
1229	537	603406323	\N
1230	537	613859951	\N
1231	537	393594062	\N
1232	537	288128487	\N
1233	537	123998648	\N
1234	537	939894620	\N
1235	537	147563401	\N
1236	537	903496451	\N
1237	537	251566329	\N
1238	537	283348176	\N
1239	537	357656050	\N
1240	537	317082933	\N
1241	537	430754812	\N
1242	537	619438774	\N
1243	537	709222489	\N
1244	537	842999018	\N
1245	537	717091616	\N
1246	539	764467765	\N
1247	539	102335231	\N
1248	539	818731508	\N
1249	539	731880094	\N
1250	539	632406555	\N
1251	539	678188495	\N
1252	539	981912619	\N
1253	539	852215460	\N
1254	539	130224392	\N
1255	539	577900744	\N
1256	539	389321721	\N
1257	539	199710663	\N
1258	539	683319969	\N
1259	539	818163599	\N
1260	539	313922369	\N
1261	539	900340334	\N
1262	539	169998861	\N
1263	539	319384274	\N
1264	539	941543187	\N
1265	539	154451252	\N
1266	539	196921969	\N
1267	539	188602961	\N
1268	539	650856216	\N
1269	539	603406323	\N
1270	539	613859951	\N
1271	539	393594062	\N
1272	539	288128487	\N
1273	539	123998648	\N
1274	539	939894620	\N
1275	539	147563401	\N
1276	539	903496451	\N
1277	539	251566329	\N
1278	539	283348176	\N
1279	539	357656050	\N
1280	539	317082933	\N
1281	539	430754812	\N
1282	539	619438774	\N
1283	539	709222489	\N
1284	539	842999018	\N
1285	539	717091616	\N
1286	540	717091616	\N
1287	541	717091616	\N
1288	542	717091616	\N
1289	543	717091616	\N
1290	544	717091616	\N
1291	545	717091616	\N
1292	546	717091616	\N
1293	547	717091616	\N
1294	550	764467765	\N
1295	550	102335231	\N
1296	550	818731508	\N
1297	550	731880094	\N
1298	550	632406555	\N
1299	550	678188495	\N
1300	550	981912619	\N
1301	550	852215460	\N
1302	550	130224392	\N
1303	550	577900744	\N
1304	550	389321721	\N
1305	550	199710663	\N
1306	550	683319969	\N
1307	550	818163599	\N
1308	550	313922369	\N
1309	550	900340334	\N
1310	550	169998861	\N
1311	550	319384274	\N
1312	550	941543187	\N
1313	550	154451252	\N
1314	550	196921969	\N
1315	550	188602961	\N
1316	550	650856216	\N
1317	550	603406323	\N
1318	550	613859951	\N
1319	550	393594062	\N
1320	550	288128487	\N
1321	550	123998648	\N
1322	550	939894620	\N
1323	550	147563401	\N
1324	550	903496451	\N
1325	550	251566329	\N
1326	550	283348176	\N
1327	550	357656050	\N
1328	550	317082933	\N
1329	550	430754812	\N
1330	550	619438774	\N
1331	550	709222489	\N
1332	550	842999018	\N
1333	550	717091616	\N
1334	551	764467765	\N
1335	551	102335231	\N
1336	551	818731508	\N
1337	551	852215460	\N
1338	551	577900744	\N
1339	551	199710663	\N
1340	551	683319969	\N
1341	551	288128487	\N
1342	551	123998648	\N
1343	551	939894620	\N
1344	551	357656050	\N
1345	551	842999018	\N
1346	552	764467765	\N
1347	553	764467765	\N
1348	554	764467765	\N
1349	554	731880094	\N
1350	554	632406555	\N
1351	554	188602961	\N
1352	554	613859951	\N
1353	555	632406555	\N
1354	556	632406555	\N
1355	557	632406555	\N
1356	558	632406555	\N
1357	560	632406555	\N
1358	561	632406555	\N
1359	562	632406555	\N
1360	563	632406555	\N
1361	573	764467765	\N
1362	573	102335231	\N
1363	573	818731508	\N
1364	573	731880094	\N
1365	573	632406555	\N
1366	573	678188495	\N
1367	573	981912619	\N
1368	573	852215460	\N
1369	573	130224392	\N
1370	573	577900744	\N
1371	573	389321721	\N
1372	573	199710663	\N
1373	573	683319969	\N
1374	573	818163599	\N
1375	573	313922369	\N
1376	573	900340334	\N
1377	573	169998861	\N
1378	573	319384274	\N
1379	573	941543187	\N
1380	573	154451252	\N
1381	573	196921969	\N
1382	573	188602961	\N
1383	573	650856216	\N
1384	573	603406323	\N
1385	573	613859951	\N
1386	573	393594062	\N
1387	573	288128487	\N
1388	573	123998648	\N
1389	573	939894620	\N
1390	573	147563401	\N
1391	573	903496451	\N
1392	573	251566329	\N
1393	573	283348176	\N
1394	573	357656050	\N
1395	573	317082933	\N
1396	573	430754812	\N
1397	573	619438774	\N
1398	573	709222489	\N
1399	573	842999018	\N
1400	573	717091616	\N
1401	575	130224392	\N
1402	575	283348176	\N
1403	575	317082933	\N
1404	576	717091616	\N
1405	577	717091616	\N
1406	579	198210769	\N
1407	580	198210769	\N
1408	581	198210769	\N
1409	582	198210769	\N
1410	583	198210769	\N
1411	584	198210769	\N
1412	585	198210769	\N
1413	586	198210769	\N
1414	587	198210769	\N
1415	588	198210769	\N
1416	590	222421165	\N
1417	591	222421165	\N
1418	592	222421165	\N
1419	593	222421165	\N
1420	594	222421165	\N
1421	595	222421165	\N
1422	596	222421165	\N
1423	597	222421165	\N
1424	598	222421165	\N
1425	599	222421165	\N
1426	600	222421165	\N
1427	602	532194382	\N
1428	603	532194382	\N
1429	604	532194382	\N
1430	605	532194382	\N
1431	606	532194382	\N
1432	607	532194382	\N
1433	608	532194382	\N
1434	609	532194382	\N
1435	610	532194382	\N
1436	612	842999018	\N
1437	612	249629085	\N
1438	613	249629085	\N
1439	614	249629085	\N
1440	615	249629085	\N
1441	616	249629085	\N
1442	617	249629085	\N
1443	618	249629085	\N
1444	619	249629085	\N
1445	620	249629085	\N
1446	626	249629085	\N
1447	628	411146676	\N
1448	629	411146676	\N
1449	630	411146676	\N
1450	631	411146676	\N
1451	632	411146676	\N
1452	633	411146676	\N
1453	634	411146676	\N
1454	635	411146676	\N
1455	636	411146676	\N
1456	640	172615160	\N
1457	641	172615160	\N
1458	642	172615160	\N
1459	643	172615160	\N
1460	644	172615160	\N
1461	645	172615160	\N
1462	646	172615160	\N
1463	647	172615160	\N
1464	648	172615160	\N
1465	656	764467765	\N
1466	656	102335231	\N
1467	656	818731508	\N
1468	656	731880094	\N
1469	656	632406555	\N
1470	656	678188495	\N
1471	656	981912619	\N
1472	656	852215460	\N
1473	656	130224392	\N
1474	656	577900744	\N
1475	656	389321721	\N
1476	656	199710663	\N
1477	656	683319969	\N
1478	656	818163599	\N
1479	656	313922369	\N
1480	656	900340334	\N
1481	656	169998861	\N
1482	656	319384274	\N
1483	656	941543187	\N
1484	656	154451252	\N
1485	656	196921969	\N
1486	656	188602961	\N
1487	656	650856216	\N
1488	656	603406323	\N
1489	656	613859951	\N
1490	656	393594062	\N
1491	656	288128487	\N
1492	656	123998648	\N
1493	656	939894620	\N
1494	656	147563401	\N
1495	656	903496451	\N
1496	656	251566329	\N
1497	656	283348176	\N
1498	656	357656050	\N
1499	656	317082933	\N
1500	656	430754812	\N
1501	656	619438774	\N
1502	656	709222489	\N
1503	656	842999018	\N
1504	656	717091616	\N
1505	656	198210769	\N
1506	656	222421165	\N
1507	656	532194382	\N
1508	656	249629085	\N
1509	656	411146676	\N
1510	656	172615160	\N
1511	662	764467765	\N
1512	662	102335231	\N
1513	662	818731508	\N
1514	662	731880094	\N
1515	662	632406555	\N
1516	662	678188495	\N
1517	662	981912619	\N
1518	662	852215460	\N
1519	662	130224392	\N
1520	662	577900744	\N
1521	662	389321721	\N
1522	662	199710663	\N
1523	662	683319969	\N
1524	662	818163599	\N
1525	662	313922369	\N
1526	662	900340334	\N
1527	662	169998861	\N
1528	662	319384274	\N
1529	662	941543187	\N
1530	662	154451252	\N
1531	662	196921969	\N
1532	662	188602961	\N
1533	662	650856216	\N
1534	662	603406323	\N
1535	662	613859951	\N
1536	662	393594062	\N
1537	662	288128487	\N
1538	662	123998648	\N
1539	662	939894620	\N
1540	662	147563401	\N
1541	662	903496451	\N
1542	662	251566329	\N
1543	662	283348176	\N
1544	662	357656050	\N
1545	662	317082933	\N
1546	662	430754812	\N
1547	662	619438774	\N
1548	662	709222489	\N
1549	662	842999018	\N
1550	662	717091616	\N
1551	662	198210769	\N
1552	662	222421165	\N
1553	662	532194382	\N
1554	662	249629085	\N
1555	662	411146676	\N
1556	662	172615160	\N
1557	664	100621249	\N
1558	665	100621249	\N
1559	666	100621249	\N
1560	667	100621249	\N
1561	668	100621249	\N
1562	669	100621249	\N
1563	670	100621249	\N
1564	671	100621249	\N
1565	672	100621249	\N
1566	673	100621249	\N
1567	674	100621249	\N
1568	676	878012805	\N
1569	677	878012805	\N
1570	678	878012805	\N
1571	679	878012805	\N
1572	680	878012805	\N
1573	681	878012805	\N
1574	682	878012805	\N
1575	683	878012805	\N
1576	684	878012805	\N
1577	685	878012805	\N
1578	687	225829605	\N
1579	688	225829605	\N
1580	689	225829605	\N
1581	690	225829605	\N
1582	691	225829605	\N
1583	692	225829605	\N
1584	693	225829605	\N
1585	694	225829605	\N
1586	695	225829605	\N
1587	696	225829605	\N
1588	700	258122542	\N
1589	701	258122542	\N
1590	702	258122542	\N
1591	703	258122542	\N
1592	704	258122542	\N
1593	705	258122542	\N
1594	706	258122542	\N
1595	707	258122542	\N
1596	708	258122542	\N
1597	709	258122542	\N
1598	711	448520587	\N
1599	712	448520587	\N
1600	713	448520587	\N
1601	714	448520587	\N
1602	715	448520587	\N
1603	716	448520587	\N
1604	717	448520587	\N
1605	718	448520587	\N
1606	719	448520587	\N
1607	720	448520587	\N
1608	721	448520587	\N
1609	723	194783596	\N
1610	724	194783596	\N
1611	725	194783596	\N
1612	726	194783596	\N
1613	727	194783596	\N
1614	728	194783596	\N
1615	729	194783596	\N
1616	730	194783596	\N
1617	731	194783596	\N
1618	732	194783596	\N
1619	734	277621360	\N
1620	735	277621360	\N
1621	736	277621360	\N
1622	737	277621360	\N
1623	738	277621360	\N
1624	739	277621360	\N
1625	740	277621360	\N
1626	741	277621360	\N
1627	742	277621360	\N
1628	743	277621360	\N
1629	745	110069930	\N
1630	746	110069930	\N
1631	747	110069930	\N
1632	748	110069930	\N
1633	749	110069930	\N
1634	750	110069930	\N
1635	751	110069930	\N
1636	752	110069930	\N
1637	753	110069930	\N
1638	754	110069930	\N
1639	756	291816949	\N
1640	757	291816949	\N
1641	758	291816949	\N
1642	759	291816949	\N
1643	760	291816949	\N
1644	761	291816949	\N
1645	762	291816949	\N
1646	763	291816949	\N
1647	764	291816949	\N
1648	765	291816949	\N
1649	767	915914130	\N
1650	768	915914130	\N
1651	769	915914130	\N
1652	770	915914130	\N
1653	771	915914130	\N
1654	772	915914130	\N
1655	773	915914130	\N
1656	774	915914130	\N
1657	775	915914130	\N
1658	776	915914130	\N
1659	778	138546187	\N
1660	779	138546187	\N
1661	780	138546187	\N
1662	781	138546187	\N
1663	782	138546187	\N
1664	783	138546187	\N
1665	784	138546187	\N
1666	785	138546187	\N
1667	786	138546187	\N
1668	787	138546187	\N
1669	789	700193747	\N
1670	790	700193747	\N
1671	791	700193747	\N
1672	792	700193747	\N
1673	793	700193747	\N
1674	794	700193747	\N
1675	795	700193747	\N
1676	796	700193747	\N
1677	797	700193747	\N
1678	798	700193747	\N
1679	799	700193747	\N
1680	801	426729010	\N
1681	802	426729010	\N
1682	803	426729010	\N
1683	804	426729010	\N
1684	805	426729010	\N
1685	806	426729010	\N
1686	807	426729010	\N
1687	808	426729010	\N
1688	809	426729010	\N
1689	810	426729010	\N
1690	812	554468902	\N
1691	813	554468902	\N
1692	814	554468902	\N
1693	815	554468902	\N
1694	816	554468902	\N
1695	817	554468902	\N
1696	818	554468902	\N
1697	819	554468902	\N
1698	820	554468902	\N
1699	821	554468902	\N
1700	823	764181133	\N
1701	824	764181133	\N
1702	825	764181133	\N
1703	826	764181133	\N
1704	827	764181133	\N
1705	828	764181133	\N
1706	829	764181133	\N
1707	830	764181133	\N
1708	831	764181133	\N
1709	832	764181133	\N
1710	834	276730794	\N
1711	835	276730794	\N
1712	836	276730794	\N
1713	837	276730794	\N
1714	838	276730794	\N
1715	839	276730794	\N
1716	840	276730794	\N
1717	841	276730794	\N
1718	842	276730794	\N
\.


--
-- Data for Name: hipaa_audit_views; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY hipaa_audit_views (id, requesting_ip, requesting_username, requesting_uri, modified_date) FROM stdin;
1	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-21 09:54:50-05
2	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-21 09:54:51-05
3	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-21 09:57:13-05
4	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-09-21 09:57:20-05
5	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id?patient_id=7	2010-09-21 09:57:24-05
6	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-09-21 09:57:25-05
7	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart	2010-09-21 09:57:33-05
8	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2010-09-21 09:57:35-05
9	0:0:0:0:0:0:0:1	mwarnock	/exams/empty_cart	2010-09-21 09:57:39-05
10	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-09-21 09:57:40-05
11	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-09-21 09:58:53-05
12	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-09-21 13:18:03-05
13	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-21 13:18:04-05
14	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-09-21 13:18:07-05
15	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id?patient_id=10	2010-09-21 13:18:11-05
16	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id	2010-09-21 13:18:17-05
17	0:0:0:0:0:0:0:1	mwarnock	/exams?print_id=true	2010-09-21 13:18:18-05
18	0:0:0:0:0:0:0:1	mwarnock	/patients/print_rsna_id	2010-09-21 13:18:20-05
19	0:0:0:0:0:0:0:1	wtellis	/	2010-09-21 13:29:28-05
20	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-09-21 13:30:28-05
21	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-21 13:30:28-05
22	0:0:0:0:0:0:0:1	wtellis	/	2010-09-21 13:51:36-05
23	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-21 13:51:40-05
24	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=7	2010-09-21 13:51:45-05
25	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-21 13:51:46-05
26	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-21 13:51:51-05
27	0:0:0:0:0:0:0:1	admin	/	2010-09-21 14:00:35-05
28	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-21 14:25:43-05
29	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-21 14:25:47-05
30	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-21 14:25:48-05
31	0:0:0:0:0:0:0:1	wtellis	/	2010-09-21 17:29:09-05
32	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-21 17:29:14-05
33	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=16	2010-09-21 17:29:20-05
34	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-09-21 17:29:42-05
35	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-09-21 17:29:42-05
36	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-09-21 17:29:44-05
37	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-21 17:33:44-05
38	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-21 17:33:47-05
39	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-21 17:33:51-05
40	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-21 17:33:52-05
41	0:0:0:0:0:0:0:1	wtellis	/	2010-09-23 11:21:48-05
42	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-23 11:21:55-05
43	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-09-23 11:22:12-05
44	0:0:0:0:0:0:0:1	wtellis	/	2010-09-23 11:22:12-05
45	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-23 11:22:22-05
46	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=7	2010-09-23 11:22:34-05
47	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-23 11:22:35-05
48	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-23 11:33:54-05
49	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-09-23 11:33:59-05
50	0:0:0:0:0:0:0:1	wtellis	/	2010-09-23 11:34:00-05
51	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-23 11:34:04-05
52	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=7	2010-09-23 11:34:25-05
53	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-23 11:34:26-05
54	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-23 11:34:44-05
55	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-23 11:34:48-05
56	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-09-23 11:35:12-05
57	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-23 11:35:35-05
58	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-23 11:35:35-05
59	0:0:0:0:0:0:0:1	wtellis	/	2010-09-24 11:17:00-05
60	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-24 11:17:04-05
61	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=18	2010-09-24 11:17:10-05
62	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-09-24 11:17:22-05
63	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-09-24 11:17:35-05
64	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-09-24 11:17:36-05
65	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-09-24 11:17:37-05
66	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-24 11:20:46-05
67	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-24 11:20:48-05
68	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-24 11:20:55-05
69	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 11:20:56-05
70	0:0:0:0:0:0:0:1	wtellis	/	2010-09-24 12:56:15-05
71	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-24 12:56:19-05
72	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=20	2010-09-24 12:56:24-05
73	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-09-24 12:56:31-05
74	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-09-24 12:56:32-05
75	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-09-24 12:56:34-05
76	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-24 12:56:40-05
77	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-24 12:56:44-05
78	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-24 12:56:50-05
79	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 12:56:51-05
80	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-24 13:02:17-05
81	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 13:02:23-05
82	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-09-24 13:02:28-05
83	0:0:0:0:0:0:0:1	wtellis	/	2010-09-24 13:02:29-05
84	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-24 13:02:32-05
85	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=19	2010-09-24 13:02:37-05
86	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-09-24 13:02:46-05
87	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-09-24 13:02:47-05
88	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-09-24 13:02:49-05
89	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-24 13:02:56-05
90	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-24 13:02:58-05
91	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-24 13:03:03-05
92	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 13:03:03-05
93	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-24 13:03:57-05
94	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 13:04:01-05
95	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-09-24 13:05:12-05
96	0:0:0:0:0:0:0:1	wtellis	/	2010-09-24 13:05:12-05
97	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-24 13:05:17-05
98	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=7	2010-09-24 13:05:32-05
99	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 13:05:32-05
100	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-24 13:05:37-05
101	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-24 13:05:40-05
102	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-24 13:05:45-05
103	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 13:05:46-05
104	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-24 13:06:05-05
105	0:0:0:0:0:0:0:1	wtellis	/	2010-09-28 08:45:07-05
106	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-28 08:45:12-05
107	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=7	2010-09-28 08:45:33-05
108	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-28 08:45:35-05
109	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-28 08:45:39-05
110	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-28 08:45:42-05
111	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-28 08:45:47-05
112	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-28 08:45:48-05
113	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-28 08:46:01-05
114	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-28 12:33:05-05
115	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-28 12:33:39-05
116	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-09-28 12:33:43-05
117	0:0:0:0:0:0:0:1	wtellis	/	2010-09-28 12:33:44-05
118	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-28 12:33:50-05
119	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-28 13:12:35-05
120	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-09-28 13:12:40-05
121	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id?patient_id=7	2010-09-28 13:12:44-05
122	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-09-28 13:12:44-05
123	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-09-28 13:12:50-05
124	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-28 13:14:13-05
125	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-09-28 13:14:21-05
126	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-09-28 13:14:35-05
127	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-28 13:14:36-05
128	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-09-28 13:14:43-05
129	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id?patient_id=7	2010-09-28 13:14:46-05
130	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-09-28 13:14:47-05
131	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart	2010-09-28 13:14:51-05
132	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2010-09-28 13:14:53-05
133	0:0:0:0:0:0:0:1	mwarnock	/exams/empty_cart	2010-09-28 13:14:56-05
134	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-09-28 13:14:57-05
135	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-09-28 13:15:07-05
136	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-28 13:15:07-05
137	0:0:0:0:0:0:0:1	wtellis	/	2010-09-28 13:28:53-05
138	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-28 13:28:58-05
139	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-09-28 13:29:39-05
140	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=22	2010-09-28 13:31:50-05
141	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-09-28 13:32:06-05
142	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-09-28 13:32:07-05
143	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-09-28 13:32:10-05
144	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-09-28 13:33:05-05
145	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-09-28 13:33:11-05
146	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-09-28 13:33:18-05
147	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-28 13:33:21-05
148	0:0:0:0:0:0:0:1	wtellis	/exams	2010-09-28 13:34:21-05
149	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-09-28 13:35:36-05
150	0:0:0:0:0:0:0:1	wtellis	/	2010-09-28 13:43:37-05
151	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-09-28 13:45:30-05
152	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-09-28 13:45:49-05
153	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-09-28 13:46:43-05
154	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-09-28 14:36:29-05
155	0:0:0:0:0:0:0:1	mwarnock	/	2010-09-28 14:36:29-05
156	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-09-28 14:36:42-05
157	0:0:0:0:0:0:0:1	admin	/	2010-09-30 14:04:06-05
158	0:0:0:0:0:0:0:1	wtellis	/	2010-10-04 17:13:40-05
159	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-10-04 17:15:21-05
160	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=22	2010-10-04 17:15:33-05
161	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-04 17:15:34-05
162	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-10-04 17:16:08-05
163	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-10-04 17:16:29-05
164	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-10-04 17:16:29-05
165	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-04 17:16:30-05
166	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-04 17:16:39-05
167	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-10-04 17:16:44-05
168	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-04 17:16:48-05
169	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-04 17:16:52-05
170	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-04 17:16:53-05
171	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-04 17:17:00-05
172	0:0:0:0:0:0:0:1	wtellis	/	2010-10-04 17:17:01-05
173	0:0:0:0:0:0:0:1	wtellis	/patients/search	2010-10-04 17:17:08-05
174	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=31	2010-10-04 17:17:18-05
175	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-04 17:17:25-05
176	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-04 17:17:26-05
177	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart	2010-10-04 17:17:43-05
178	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-04 17:17:46-05
179	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-04 17:17:52-05
180	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-04 17:17:53-05
181	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:05:33-05
182	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:29:03-05
183	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:29:09-05
184	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:30:33-05
185	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:30:45-05
186	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:30:50-05
187	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:33:24-05
188	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:33:29-05
189	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:33:57-05
190	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:34:01-05
191	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:44:08-05
192	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:44:13-05
193	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:45:54-05
194	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:46:06-05
195	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:46:25-05
196	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:46:30-05
197	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:48:48-05
198	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:48:52-05
199	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:50:00-05
200	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:50:05-05
201	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-06 09:52:04-05
491	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 12:14:07-05
202	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:52:08-05
203	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:54:01-05
204	0:0:0:0:0:0:0:1	admin	/	2010-10-06 11:24:35-05
205	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 01:23:36-05
206	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=	2010-10-11 01:23:44-05
207	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id?patient_id=26&commit=Yes	2010-10-11 01:23:54-05
208	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id	2010-10-11 01:24:03-05
209	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id	2010-10-11 01:24:10-05
210	0:0:0:0:0:0:0:1	mwarnock	/exams?print_id=true	2010-10-11 01:24:11-05
211	0:0:0:0:0:0:0:1	mwarnock	/patients/print_rsna_id	2010-10-11 01:24:12-05
212	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=26	2010-10-11 01:24:22-05
213	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2010-10-11 01:24:25-05
214	0:0:0:0:0:0:0:1	mwarnock	/exams/empty_cart	2010-10-11 01:24:52-05
215	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-10-11 01:24:53-05
216	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-10-11 01:25:13-05
217	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14496	2010-10-11 01:25:19-05
218	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 01:42:27-05
219	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=	2010-10-11 01:42:54-05
220	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id?patient_id=20&commit=Yes	2010-10-11 01:43:29-05
221	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-10-11 01:43:30-05
222	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=20	2010-10-11 01:43:34-05
223	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2010-10-11 01:43:35-05
224	0:0:0:0:0:0:0:1	mwarnock	/exams/delete_from_cart?id=20	2010-10-11 01:43:38-05
225	0:0:0:0:0:0:0:1	mwarnock	/exams/empty_cart	2010-10-11 01:43:41-05
226	0:0:0:0:0:0:0:1	mwarnock	/exams	2010-10-11 01:43:42-05
227	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-10-11 01:43:48-05
228	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14498	2010-10-11 01:43:50-05
229	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-10-11 01:44:24-05
230	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-10-11 01:44:40-05
231	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 01:44:40-05
232	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=	2010-10-11 01:44:42-05
233	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:07:59-05
234	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-10-11 10:08:09-05
235	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14498	2010-10-11 10:08:12-05
236	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14497	2010-10-11 10:08:45-05
237	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-10-11 10:09:04-05
238	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:09:05-05
239	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=	2010-10-11 10:09:07-05
240	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id?patient_id=23&commit=Yes	2010-10-11 10:09:17-05
241	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id	2010-10-11 10:09:43-05
242	0:0:0:0:0:0:0:1	mwarnock	/patients/create_rsna_id	2010-10-11 10:09:57-05
243	0:0:0:0:0:0:0:1	mwarnock	/exams?print_id=true	2010-10-11 10:09:58-05
244	0:0:0:0:0:0:0:1	mwarnock	/patients/print_rsna_id	2010-10-11 10:09:59-05
245	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-10-11 10:11:24-05
246	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14498	2010-10-11 10:11:27-05
247	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14419	2010-10-11 10:11:57-05
248	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14421	2010-10-11 10:12:11-05
249	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14498	2010-10-11 10:12:21-05
250	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-10-11 10:12:59-05
251	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:12:59-05
252	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-10-11 10:14:32-05
253	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:19:26-05
254	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-10-11 10:19:40-05
255	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:19:40-05
256	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-10-11 10:19:43-05
257	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:19:43-05
258	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-10-11 10:19:49-05
259	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:19:50-05
260	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-11 10:21:10-05
261	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=	2010-10-11 10:21:15-05
262	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14498	2010-10-11 10:32:23-05
263	0:0:0:0:0:0:0:1	wtellis	/	2010-10-11 13:19:44-05
264	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test	2010-10-11 13:19:51-05
265	0:0:0:0:0:0:0:1	wtellis	/	2010-10-11 13:20:41-05
266	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test	2010-10-11 13:20:45-05
267	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=37&commit=Yes	2010-10-11 13:21:14-05
268	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-11 13:21:32-05
269	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-11 13:21:33-05
270	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-11 13:21:34-05
271	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=37	2010-10-11 13:21:48-05
272	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-11 13:21:52-05
273	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 09:36:10-05
274	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 09:36:25-05
275	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 09:38:49-05
276	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 09:39:18-05
277	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 09:41:31-05
278	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 09:41:32-05
279	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 09:55:25-05
280	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=wed	2010-10-13 09:55:52-05
281	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id?patient_id=42&commit=Yes	2010-10-13 09:56:21-05
282	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id	2010-10-13 09:57:22-05
283	0:0:0:0:0:0:0:1	mdaly	/exams?print_id=true	2010-10-13 09:57:22-05
284	0:0:0:0:0:0:0:1	mdaly	/patients/print_rsna_id	2010-10-13 09:57:24-05
285	0:0:0:0:0:0:0:1	mdaly	/exams/add_to_cart?id=42	2010-10-13 10:13:42-05
286	0:0:0:0:0:0:0:1	mdaly	/exams/show_cart	2010-10-13 10:14:47-05
287	0:0:0:0:0:0:0:1	mdaly	/exams/send_cart	2010-10-13 10:14:51-05
288	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-13 10:14:53-05
289	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 10:21:33-05
290	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14509	2010-10-13 10:21:48-05
291	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14511	2010-10-13 10:22:06-05
292	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 10:27:03-05
293	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14512	2010-10-13 10:27:07-05
294	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14512	2010-10-13 10:44:03-05
295	0:0:0:0:0:0:0:1	mdaly	/admin/audit_filter?filter=IHE9357.10	2010-10-13 10:49:18-05
296	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 10:49:30-05
297	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 10:49:30-05
298	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=wed	2010-10-13 10:49:35-05
299	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id?patient_id=42&commit=Yes	2010-10-13 10:49:50-05
300	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-13 10:49:50-05
301	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 10:49:57-05
302	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 11:31:52-05
303	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 11:31:53-05
304	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=wed	2010-10-13 11:31:56-05
305	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id?patient_id=42&commit=Yes	2010-10-13 11:32:34-05
306	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-13 11:32:34-05
307	0:0:0:0:0:0:0:1	mdaly	/exams/add_to_cart?id=42	2010-10-13 11:32:39-05
308	0:0:0:0:0:0:0:1	mdaly	/exams/show_cart	2010-10-13 11:32:43-05
309	0:0:0:0:0:0:0:1	mdaly	/exams/empty_cart	2010-10-13 11:32:51-05
310	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-13 11:32:51-05
311	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 11:33:05-05
312	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 11:33:05-05
313	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 11:33:31-05
314	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14512	2010-10-13 11:33:37-05
315	0:0:0:0:0:0:0:1	mdaly	/admin/audit_filter?filter=283348176	2010-10-13 11:33:49-05
316	0:0:0:0:0:0:0:1	mdaly	/admin/audit_filter?filter=	2010-10-13 11:33:55-05
317	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 11:36:41-05
318	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 11:38:24-05
319	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 11:42:25-05
320	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 11:42:45-05
321	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 11:42:51-05
322	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 11:42:51-05
323	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 11:45:04-05
324	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 11:45:04-05
325	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=wed	2010-10-13 11:45:06-05
326	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 11:45:54-05
327	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14512	2010-10-13 11:46:19-05
328	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 12:40:14-05
329	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=43&commit=Yes	2010-10-13 12:40:20-05
330	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-13 12:40:30-05
331	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-13 12:40:31-05
332	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-13 12:40:35-05
333	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=43	2010-10-13 12:40:46-05
334	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 12:40:49-05
335	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-13 12:40:54-05
336	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 12:40:56-05
337	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 13:14:41-05
338	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 13:14:42-05
339	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 13:42:59-05
340	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 13:42:59-05
341	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 13:43:08-05
342	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 13:43:35-05
343	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=4392	2010-10-13 13:45:20-05
344	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=47&commit=Yes	2010-10-13 13:45:46-05
345	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-13 13:46:51-05
346	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-13 13:46:52-05
347	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-13 13:46:53-05
348	0:0:0:0:0:0:0:1	admin	/	2010-10-13 13:47:34-05
349	0:0:0:0:0:0:0:1	admin	/patients/search?search=	2010-10-13 13:47:49-05
350	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=47	2010-10-13 13:52:06-05
351	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 13:52:10-05
352	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-13 13:52:20-05
353	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 13:52:21-05
354	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 13:52:46-05
355	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 13:52:54-05
356	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14519	2010-10-13 13:53:01-05
357	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 13:54:28-05
358	0:0:0:0:0:0:0:1	wtellis	/admin/audit_filter?filter=4392	2010-10-13 13:56:20-05
359	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14519	2010-10-13 13:56:29-05
360	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 13:57:10-05
361	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 13:57:11-05
362	0:0:0:0:0:0:0:1	admin	/patients/create_rsna_id?patient_id=44&commit=Yes	2010-10-13 13:57:18-05
363	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 13:57:30-05
364	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 13:57:30-05
365	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 13:57:55-05
366	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 13:57:56-05
367	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 13:58:09-05
368	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 13:58:16-05
369	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 13:58:30-05
370	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 13:58:30-05
371	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 13:58:30-05
372	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 13:58:31-05
373	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 13:58:38-05
374	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 13:58:39-05
375	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 13:59:02-05
376	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=764467765	2010-10-13 13:59:25-05
377	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=43&commit=Yes	2010-10-13 13:59:33-05
378	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 13:59:34-05
379	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=43	2010-10-13 13:59:41-05
380	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 13:59:43-05
381	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-13 14:00:01-05
382	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 14:00:02-05
383	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-13 14:00:21-05
384	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 14:00:23-05
385	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 14:02:01-05
386	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 14:02:02-05
387	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 14:02:02-05
388	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 14:02:03-05
389	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 14:02:06-05
390	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=Dean%2C+Jimmy	2010-10-13 14:02:15-05
391	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=Dean	2010-10-13 14:02:20-05
392	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=Dean%2C+Jimmy	2010-10-13 14:02:31-05
393	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=Dean+Jimmy	2010-10-13 14:02:40-05
394	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=Jimmy	2010-10-13 14:02:44-05
395	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=dean	2010-10-13 14:02:49-05
396	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=44&commit=Yes	2010-10-13 14:03:59-05
397	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-13 14:05:01-05
398	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-13 14:05:01-05
399	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-13 14:05:03-05
400	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 14:05:42-05
401	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 14:05:42-05
402	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=IHE112174.2	2010-10-13 14:05:47-05
403	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=caa	2010-10-13 14:08:13-05
404	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=48&commit=Yes	2010-10-13 14:08:22-05
405	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-13 14:08:33-05
406	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-13 14:08:34-05
407	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-13 14:08:36-05
408	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=48	2010-10-13 14:08:46-05
409	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=49	2010-10-13 14:08:48-05
410	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 14:10:31-05
411	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 14:10:31-05
412	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=wed	2010-10-13 14:10:35-05
413	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id?patient_id=47&commit=Yes	2010-10-13 14:10:46-05
414	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-13 14:10:47-05
415	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 14:11:33-05
416	0:0:0:0:0:0:0:1	mdaly	/exams/add_to_cart?id=47	2010-10-13 14:11:34-05
417	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-13 14:11:49-05
418	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 14:11:52-05
419	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 14:12:21-05
420	0:0:0:0:0:0:0:1	wtellis	/admin/audit_filter?filter=	2010-10-13 14:12:50-05
421	0:0:0:0:0:0:0:1	mdaly	/exams/show_cart	2010-10-13 14:13:21-05
422	0:0:0:0:0:0:0:1	mdaly	/exams/empty_cart	2010-10-13 14:13:23-05
423	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-13 14:13:23-05
424	0:0:0:0:0:0:0:1	mdaly	/patients/new	2010-10-13 14:13:27-05
425	0:0:0:0:0:0:0:1	mdaly	/	2010-10-13 14:13:28-05
426	0:0:0:0:0:0:0:1	wtellis	/admin/audit_filter?filter=	2010-10-13 14:13:51-05
427	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=	2010-10-13 14:19:52-05
428	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 15:17:53-05
429	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 15:17:53-05
430	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 15:17:54-05
431	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 15:17:57-05
432	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=49&commit=Yes	2010-10-13 15:18:02-05
433	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-13 15:18:14-05
434	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-13 15:18:15-05
435	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-13 15:18:17-05
436	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 15:18:26-05
437	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 15:19:34-05
438	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 15:19:34-05
439	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 15:19:38-05
440	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=49&commit=Yes	2010-10-13 15:19:42-05
441	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 15:19:43-05
442	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=50	2010-10-13 15:19:46-05
443	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=51	2010-10-13 15:19:47-05
444	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 15:19:48-05
445	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-13 15:19:51-05
446	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 15:19:52-05
447	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 15:20:07-05
448	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 18:47:51-05
449	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 18:47:52-05
450	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 18:47:58-05
451	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=50&commit=Yes	2010-10-13 18:48:08-05
452	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-13 18:48:17-05
453	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-13 18:48:18-05
454	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-13 18:48:20-05
455	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=52	2010-10-13 18:48:25-05
456	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=53	2010-10-13 18:48:25-05
457	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 18:48:28-05
458	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-13 18:48:30-05
459	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 18:48:31-05
460	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-13 18:57:56-05
461	0:0:0:0:0:0:0:1	wtellis	/	2010-10-13 18:57:56-05
462	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-13 18:58:01-05
463	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=51&commit=Yes	2010-10-13 18:58:13-05
464	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-13 18:58:21-05
465	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-13 18:58:21-05
466	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-13 18:58:23-05
467	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=54	2010-10-13 18:58:30-05
468	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=55	2010-10-13 18:58:31-05
469	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 18:58:36-05
470	0:0:0:0:0:0:0:1	wtellis	/exams/empty_cart	2010-10-13 18:58:41-05
471	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 18:58:42-05
472	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=54	2010-10-13 18:58:45-05
473	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=55	2010-10-13 18:58:47-05
474	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-13 18:58:49-05
475	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-13 18:59:08-05
476	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-13 18:59:08-05
477	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-13 19:02:10-05
478	0:0:0:0:0:0:0:1	mdaly	/	2010-10-14 08:23:13-05
479	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 10:47:25-05
480	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-14 10:47:30-05
481	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=52&commit=Yes	2010-10-14 10:47:49-05
482	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-14 10:47:58-05
483	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-14 10:47:58-05
484	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-14 10:48:00-05
485	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=56	2010-10-14 10:48:06-05
486	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-14 10:48:09-05
487	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-14 10:48:12-05
488	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-14 10:48:13-05
489	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 11:52:48-05
490	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-14 11:52:53-05
492	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-14 12:14:18-05
493	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14576	2010-10-14 12:18:11-05
494	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-14 13:10:17-05
495	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 13:10:17-05
496	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-14 13:10:21-05
497	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=day	2010-10-14 13:10:26-05
498	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=53&commit=Yes	2010-10-14 13:10:29-05
499	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-14 13:10:38-05
500	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-14 13:10:39-05
501	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-14 13:10:40-05
502	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=57	2010-10-14 13:10:48-05
503	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-14 13:10:49-05
504	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-14 13:11:30-05
505	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-14 13:11:31-05
506	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-14 13:11:53-05
507	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-14 13:21:12-05
508	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 13:21:12-05
509	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=day	2010-10-14 13:21:19-05
510	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=day	2010-10-14 13:21:21-05
511	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=day	2010-10-14 13:21:23-05
512	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=day	2010-10-14 13:21:29-05
513	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-14 13:21:33-05
514	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=54&commit=Yes	2010-10-14 13:21:49-05
515	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-14 13:21:59-05
516	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-14 13:22:00-05
517	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-14 13:22:01-05
518	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=58	2010-10-14 13:22:26-05
519	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-14 13:22:28-05
520	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-14 13:22:31-05
521	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-14 13:22:33-05
522	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-14 13:22:40-05
523	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-14 14:53:28-05
524	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 14:53:29-05
525	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=sixty	2010-10-14 14:53:38-05
526	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=55&commit=Yes	2010-10-14 14:53:42-05
527	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-14 14:53:51-05
528	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-14 14:53:51-05
529	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-14 14:53:53-05
530	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=59	2010-10-14 14:54:01-05
531	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-14 14:54:02-05
532	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-14 14:54:05-05
533	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-14 14:54:05-05
534	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-14 14:54:17-05
535	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 15:40:31-05
536	0:0:0:0:0:0:0:1	wzhu	/	2010-10-14 15:40:42-05
537	0:0:0:0:0:0:0:1	wzhu	/patients/search?search=	2010-10-14 15:40:52-05
538	0:0:0:0:0:0:0:1	wtellis	/	2010-10-14 15:42:17-05
539	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=	2010-10-14 15:42:20-05
540	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=56&commit=Yes	2010-10-14 15:42:29-05
541	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-14 15:42:40-05
542	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-14 15:42:41-05
543	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-14 15:42:42-05
544	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=60	2010-10-14 15:42:52-05
545	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-14 15:42:58-05
546	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-14 15:43:03-05
547	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-14 15:43:03-05
548	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-14 15:43:13-05
549	0:0:0:0:0:0:0:1	mdaly	/	2010-10-14 15:43:30-05
550	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=	2010-10-14 15:43:50-05
551	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=test	2010-10-14 15:44:00-05
552	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id?patient_id=43&commit=Yes	2010-10-14 15:44:32-05
553	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-14 15:44:32-05
554	0:0:0:0:0:0:0:1	mdaly	/patients/search?search=Dean	2010-10-14 15:48:41-05
555	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id?patient_id=45&commit=Yes	2010-10-14 15:50:12-05
556	0:0:0:0:0:0:0:1	mdaly	/patients/create_rsna_id	2010-10-14 15:50:32-05
557	0:0:0:0:0:0:0:1	mdaly	/exams?print_id=true	2010-10-14 15:50:32-05
558	0:0:0:0:0:0:0:1	mdaly	/patients/print_rsna_id	2010-10-14 15:50:34-05
559	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-14 15:50:37-05
560	0:0:0:0:0:0:0:1	mdaly	/exams/add_to_cart?id=45	2010-10-14 15:51:28-05
561	0:0:0:0:0:0:0:1	mdaly	/exams/show_cart	2010-10-14 15:51:42-05
562	0:0:0:0:0:0:0:1	mdaly	/exams/empty_cart	2010-10-14 15:52:23-05
563	0:0:0:0:0:0:0:1	mdaly	/exams	2010-10-14 15:52:23-05
564	0:0:0:0:0:0:0:1	mdaly	/admin/audit	2010-10-14 15:52:38-05
565	0:0:0:0:0:0:0:1	mdaly	/admin/audit_filter?filter=717091616	2010-10-14 15:52:46-05
566	0:0:0:0:0:0:0:1	mdaly	/admin/audit_details?id=14597	2010-10-14 15:53:01-05
567	0:0:0:0:0:0:0:1	mdaly	/	2010-10-14 16:00:45-05
568	0:0:0:0:0:0:0:1	mdaly	/	2010-10-14 16:01:20-05
569	0:0:0:0:0:0:0:1	wzhu	/	2010-10-14 16:01:40-05
570	0:0:0:0:0:0:0:1	wzhu	/admin/audit	2010-10-14 16:01:51-05
571	0:0:0:0:0:0:0:1	wzhu	/patients/new	2010-10-14 16:02:19-05
572	0:0:0:0:0:0:0:1	wzhu	/	2010-10-14 16:02:20-05
573	0:0:0:0:0:0:0:1	wzhu	/patients/search?search=	2010-10-14 16:02:28-05
574	0:0:0:0:0:0:0:1	smoore	/	2010-10-14 16:03:01-05
575	0:0:0:0:0:0:0:1	smoore	/patients/search?search=wed	2010-10-14 16:05:02-05
576	0:0:0:0:0:0:0:1	wzhu	/patients/create_rsna_id?patient_id=56&commit=Yes	2010-10-14 16:05:59-05
577	0:0:0:0:0:0:0:1	wzhu	/exams	2010-10-14 16:05:59-05
578	0:0:0:0:0:0:0:1	smoore	/	2010-10-14 16:58:37-05
579	0:0:0:0:0:0:0:1	smoore	/patients/search?search=198210769	2010-10-14 16:58:57-05
580	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=57&commit=Yes	2010-10-14 16:59:07-05
581	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-14 16:59:28-05
582	172.20.175.242	smoore	/exams?print_id=true	2010-10-14 16:59:29-05
583	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-14 16:59:40-05
584	172.20.175.242	smoore	/exams/add_to_cart?id=61	2010-10-14 17:00:10-05
585	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-14 17:00:13-05
586	172.20.175.242	smoore	/exams/send_cart	2010-10-14 17:00:16-05
587	172.20.175.242	smoore	/exams	2010-10-14 17:00:17-05
588	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-14 17:04:40-05
589	0:0:0:0:0:0:0:1	smoore	/	2010-10-14 17:04:41-05
590	0:0:0:0:0:0:0:1	smoore	/patients/search?search=222421165	2010-10-14 17:04:54-05
591	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=58&commit=Yes	2010-10-14 17:05:05-05
592	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-14 17:05:19-05
593	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-14 17:05:30-05
594	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-14 17:05:31-05
595	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-14 17:05:42-05
596	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=62	2010-10-14 17:05:52-05
597	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-14 17:06:24-05
598	0:0:0:0:0:0:0:1	smoore	/exams/send_cart	2010-10-14 17:06:26-05
599	0:0:0:0:0:0:0:1	smoore	/exams	2010-10-14 17:06:27-05
600	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-14 17:23:00-05
601	0:0:0:0:0:0:0:1	smoore	/	2010-10-14 17:23:00-05
602	0:0:0:0:0:0:0:1	smoore	/patients/search?search=532194	2010-10-14 17:23:10-05
603	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=59&commit=Yes	2010-10-14 17:23:17-05
604	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-14 17:23:25-05
605	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-14 17:23:26-05
606	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-14 17:23:37-05
607	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=63	2010-10-14 17:23:43-05
608	172.20.175.242	smoore	/exams/show_cart	2010-10-14 17:23:45-05
609	172.20.175.242	smoore	/exams/send_cart	2010-10-14 17:23:48-05
610	0:0:0:0:0:0:0:1	smoore	/exams	2010-10-14 17:23:49-05
611	0:0:0:0:0:0:0:1	wtellis	/	2010-10-15 16:33:36-05
612	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=sixty	2010-10-15 16:33:41-05
613	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=60&commit=Yes	2010-10-15 16:33:48-05
614	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-15 16:33:57-05
615	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-15 16:33:58-05
616	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-15 16:33:59-05
617	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=64	2010-10-15 16:34:11-05
618	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-15 16:34:12-05
619	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-15 16:34:16-05
620	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-15 16:34:17-05
621	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-15 16:34:31-05
622	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14622	2010-10-15 16:34:37-05
623	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-15 16:35:13-05
624	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14622	2010-10-15 16:35:18-05
625	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14622	2010-10-15 16:40:17-05
626	0:0:0:0:0:0:0:1	wtellis	/patients/new	2010-10-15 16:41:07-05
627	0:0:0:0:0:0:0:1	wtellis	/	2010-10-15 16:41:08-05
628	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=seventy	2010-10-15 16:41:15-05
629	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=61&commit=Yes	2010-10-15 16:41:35-05
630	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-15 16:41:44-05
631	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-15 16:41:44-05
632	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-15 16:41:46-05
633	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=65	2010-10-15 16:41:51-05
634	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-15 16:41:58-05
635	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-15 16:42:02-05
636	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-15 16:42:03-05
637	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-15 16:46:22-05
638	0:0:0:0:0:0:0:1	wtellis	/	2010-10-19 13:38:20-05
639	0:0:0:0:0:0:0:1	admin	/	2010-10-19 13:38:24-05
640	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=ctwoaa	2010-10-19 13:38:45-05
641	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id?patient_id=62&commit=Yes	2010-10-19 13:39:55-05
642	0:0:0:0:0:0:0:1	wtellis	/patients/create_rsna_id	2010-10-19 13:40:07-05
643	0:0:0:0:0:0:0:1	wtellis	/exams?print_id=true	2010-10-19 13:40:10-05
644	0:0:0:0:0:0:0:1	wtellis	/patients/print_rsna_id	2010-10-19 13:40:12-05
645	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=66	2010-10-19 13:40:18-05
646	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2010-10-19 13:40:21-05
647	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart	2010-10-19 13:40:26-05
648	0:0:0:0:0:0:0:1	wtellis	/exams	2010-10-19 13:40:27-05
649	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2010-10-19 13:40:39-05
650	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14658	2010-10-19 13:41:07-05
651	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14658	2010-10-19 13:41:44-05
652	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14658	2010-10-19 13:42:59-05
653	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14658	2010-10-19 13:43:09-05
654	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14658	2010-10-19 13:55:42-05
655	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-19 15:14:31-05
656	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=	2010-10-19 15:14:55-05
657	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2010-10-19 15:15:42-05
658	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14577	2010-10-19 15:15:53-05
659	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14665	2010-10-19 15:16:10-05
660	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2010-10-19 15:16:20-05
661	0:0:0:0:0:0:0:1	mwarnock	/	2010-10-19 15:16:21-05
662	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=	2010-10-19 15:16:24-05
663	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 09:03:56-05
664	0:0:0:0:0:0:0:1	smoore	/patients/search?search=100621249	2010-10-20 09:04:26-05
665	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=63&commit=Yes	2010-10-20 09:04:33-05
666	172.20.175.242	smoore	/patients/create_rsna_id	2010-10-20 09:04:45-05
667	172.20.175.242	smoore	/exams?print_id=true	2010-10-20 09:04:46-05
668	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-20 09:05:02-05
669	172.20.175.242	smoore	/exams/add_to_cart?id=67	2010-10-20 09:05:32-05
670	172.20.175.242	smoore	/exams/show_cart	2010-10-20 09:05:34-05
671	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=67	2010-10-20 09:05:35-05
672	0:0:0:0:0:0:0:1	smoore	/exams/send_cart	2010-10-20 09:05:39-05
673	172.20.175.242	smoore	/exams	2010-10-20 09:05:39-05
674	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 09:13:31-05
675	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 09:13:33-05
676	0:0:0:0:0:0:0:1	smoore	/patients/search?search=878012805	2010-10-20 09:13:38-05
677	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=64&commit=Yes	2010-10-20 09:13:43-05
678	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 09:13:53-05
679	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 09:13:54-05
680	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-20 09:14:10-05
681	172.20.175.242	smoore	/exams/add_to_cart?id=68	2010-10-20 09:14:18-05
682	172.20.175.242	smoore	/exams/show_cart	2010-10-20 09:14:22-05
683	172.20.175.242	smoore	/exams/send_cart	2010-10-20 09:14:25-05
684	0:0:0:0:0:0:0:1	smoore	/exams	2010-10-20 09:14:26-05
685	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 09:31:43-05
686	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 09:31:44-05
687	0:0:0:0:0:0:0:1	smoore	/patients/search?search=225829605	2010-10-20 09:31:51-05
688	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=65&commit=Yes	2010-10-20 09:32:01-05
689	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 09:32:14-05
690	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 09:32:15-05
691	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-20 09:32:41-05
692	172.20.175.242	smoore	/exams/add_to_cart?id=69	2010-10-20 09:32:59-05
693	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-20 09:33:02-05
694	172.20.175.242	smoore	/exams/send_cart	2010-10-20 09:33:05-05
695	0:0:0:0:0:0:0:1	smoore	/exams	2010-10-20 09:33:07-05
696	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 10:08:24-05
697	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 10:08:25-05
698	0:0:0:0:0:0:0:1	smoore	/patients/search?search=258122542+	2010-10-20 10:08:30-05
699	0:0:0:0:0:0:0:1	smoore	/patients/search?search=258122542+	2010-10-20 10:08:39-05
700	0:0:0:0:0:0:0:1	smoore	/patients/search?search=258122542	2010-10-20 10:08:53-05
701	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=66&commit=Yes	2010-10-20 10:08:58-05
702	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 10:09:06-05
703	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 10:09:06-05
704	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-20 10:09:43-05
705	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=70	2010-10-20 10:09:48-05
706	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-20 10:09:50-05
707	172.20.175.242	smoore	/exams/send_cart	2010-10-20 10:09:53-05
708	172.20.175.242	smoore	/exams	2010-10-20 10:09:54-05
709	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 22:12:34-05
710	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 22:12:35-05
711	0:0:0:0:0:0:0:1	smoore	/patients/search?search=448520587	2010-10-20 22:13:08-05
712	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=67&commit=Yes	2010-10-20 22:13:23-05
713	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 22:13:56-05
714	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 22:13:57-05
715	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-20 22:14:14-05
716	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=71	2010-10-20 22:14:42-05
717	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-20 22:14:45-05
718	172.20.175.242	smoore	/exams/send_cart	2010-10-20 22:14:51-05
719	172.20.175.242	smoore	/exams	2010-10-20 22:14:52-05
720	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=71	2010-10-20 22:27:01-05
721	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 22:27:07-05
722	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 22:27:08-05
723	0:0:0:0:0:0:0:1	smoore	/patients/search?search=194783596	2010-10-20 22:27:15-05
724	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=68&commit=Yes	2010-10-20 22:27:23-05
725	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 22:27:35-05
726	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 22:27:36-05
727	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-20 22:27:52-05
728	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=72	2010-10-20 22:28:06-05
729	172.20.175.242	smoore	/exams/show_cart	2010-10-20 22:28:16-05
730	172.20.175.242	smoore	/exams/send_cart	2010-10-20 22:28:20-05
731	172.20.175.242	smoore	/exams	2010-10-20 22:28:22-05
732	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 23:05:17-05
733	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 23:05:18-05
734	0:0:0:0:0:0:0:1	smoore	/patients/search?search=277621360	2010-10-20 23:05:26-05
735	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=69&commit=Yes	2010-10-20 23:05:36-05
736	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 23:05:47-05
737	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 23:05:48-05
738	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-20 23:06:14-05
739	172.20.175.242	smoore	/exams/add_to_cart?id=73	2010-10-20 23:06:30-05
740	172.20.175.242	smoore	/exams/show_cart	2010-10-20 23:06:35-05
741	172.20.175.242	smoore	/exams/send_cart	2010-10-20 23:06:44-05
742	172.20.175.242	smoore	/exams	2010-10-20 23:06:45-05
743	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 23:13:13-05
744	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 23:13:14-05
745	0:0:0:0:0:0:0:1	smoore	/patients/search?search=110069930	2010-10-20 23:13:22-05
746	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=70&commit=Yes	2010-10-20 23:13:32-05
747	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 23:13:43-05
748	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 23:13:44-05
749	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-20 23:14:00-05
750	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=74	2010-10-20 23:14:10-05
751	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-20 23:14:17-05
752	172.20.175.242	smoore	/exams/send_cart	2010-10-20 23:14:26-05
753	172.20.175.242	smoore	/exams	2010-10-20 23:14:27-05
754	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 23:32:38-05
755	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 23:32:39-05
756	0:0:0:0:0:0:0:1	smoore	/patients/search?search=291816949	2010-10-20 23:32:46-05
757	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=71&commit=Yes	2010-10-20 23:32:59-05
758	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 23:33:12-05
759	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 23:33:13-05
760	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-20 23:33:39-05
761	172.20.175.242	smoore	/exams/add_to_cart?id=75	2010-10-20 23:33:50-05
762	172.20.175.242	smoore	/exams/show_cart	2010-10-20 23:33:55-05
763	0:0:0:0:0:0:0:1	smoore	/exams/send_cart	2010-10-20 23:34:04-05
764	172.20.175.242	smoore	/exams	2010-10-20 23:34:05-05
765	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-20 23:48:52-05
766	0:0:0:0:0:0:0:1	smoore	/	2010-10-20 23:48:53-05
767	0:0:0:0:0:0:0:1	smoore	/patients/search?search=915914130	2010-10-20 23:49:01-05
768	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=72&commit=Yes	2010-10-20 23:49:11-05
769	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-20 23:49:23-05
770	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-20 23:49:24-05
771	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-20 23:49:41-05
772	172.20.175.242	smoore	/exams/add_to_cart?id=76	2010-10-20 23:49:53-05
773	172.20.175.242	smoore	/exams/show_cart	2010-10-20 23:50:01-05
774	0:0:0:0:0:0:0:1	smoore	/exams/send_cart	2010-10-20 23:50:04-05
775	172.20.175.242	smoore	/exams	2010-10-20 23:50:05-05
776	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-21 16:41:27-05
777	0:0:0:0:0:0:0:1	smoore	/	2010-10-21 16:41:27-05
778	0:0:0:0:0:0:0:1	smoore	/patients/search?search=138546187	2010-10-21 16:41:35-05
779	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=73&commit=Yes	2010-10-21 16:41:40-05
780	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-21 16:41:48-05
781	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-21 16:41:48-05
782	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-21 16:42:05-05
783	172.20.175.242	smoore	/exams/add_to_cart?id=77	2010-10-21 16:42:20-05
784	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-21 16:42:24-05
785	0:0:0:0:0:0:0:1	smoore	/exams/send_cart	2010-10-21 16:42:26-05
786	172.20.175.242	smoore	/exams	2010-10-21 16:42:27-05
787	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-21 16:53:15-05
788	0:0:0:0:0:0:0:1	smoore	/	2010-10-21 16:53:16-05
789	0:0:0:0:0:0:0:1	smoore	/patients/search?search=700193747	2010-10-21 16:53:21-05
790	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=74&commit=Yes	2010-10-21 16:53:27-05
791	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-21 16:53:36-05
792	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-21 16:53:37-05
793	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-21 16:54:03-05
794	172.20.175.242	smoore	/exams/add_to_cart?id=78	2010-10-21 16:54:19-05
795	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=78	2010-10-21 16:54:19-05
796	172.20.175.242	smoore	/exams/show_cart	2010-10-21 16:54:21-05
797	172.20.175.242	smoore	/exams/send_cart	2010-10-21 16:54:25-05
798	172.20.175.242	smoore	/exams	2010-10-21 16:54:26-05
799	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-21 21:08:32-05
800	0:0:0:0:0:0:0:1	smoore	/	2010-10-21 21:08:32-05
801	0:0:0:0:0:0:0:1	smoore	/patients/search?search=426729010	2010-10-21 21:08:39-05
802	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=75&commit=Yes	2010-10-21 21:08:45-05
803	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-21 21:08:55-05
804	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-21 21:08:56-05
805	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-21 21:09:19-05
806	172.20.175.242	smoore	/exams/add_to_cart?id=79	2010-10-21 21:09:25-05
807	172.20.175.242	smoore	/exams/show_cart	2010-10-21 21:09:32-05
808	172.20.175.242	smoore	/exams/send_cart	2010-10-21 21:09:36-05
809	172.20.175.242	smoore	/exams	2010-10-21 21:09:37-05
810	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-21 21:55:13-05
811	0:0:0:0:0:0:0:1	smoore	/	2010-10-21 21:55:14-05
812	0:0:0:0:0:0:0:1	smoore	/patients/search?search=554468902	2010-10-21 21:55:20-05
813	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=76&commit=Yes	2010-10-21 21:55:33-05
814	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-21 21:55:43-05
815	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-21 21:55:44-05
816	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-21 21:56:01-05
817	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=80	2010-10-21 21:56:09-05
818	172.20.175.242	smoore	/exams/show_cart	2010-10-21 21:56:24-05
819	0:0:0:0:0:0:0:1	smoore	/exams/send_cart	2010-10-21 21:56:34-05
820	172.20.175.242	smoore	/exams	2010-10-21 21:56:35-05
821	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-21 22:16:10-05
822	0:0:0:0:0:0:0:1	smoore	/	2010-10-21 22:16:10-05
823	0:0:0:0:0:0:0:1	smoore	/patients/search?search=764181133	2010-10-21 22:16:38-05
824	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=77&commit=Yes	2010-10-21 22:16:50-05
825	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-21 22:17:01-05
826	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-21 22:17:02-05
827	172.20.175.242	smoore	/patients/print_rsna_id	2010-10-21 22:17:31-05
828	172.20.175.242	smoore	/exams/add_to_cart?id=81	2010-10-21 22:17:46-05
829	172.20.175.242	smoore	/exams/show_cart	2010-10-21 22:17:53-05
830	172.20.175.242	smoore	/exams/send_cart	2010-10-21 22:18:09-05
831	172.20.175.242	smoore	/exams	2010-10-21 22:18:10-05
832	0:0:0:0:0:0:0:1	smoore	/patients/new	2010-10-21 23:02:40-05
833	0:0:0:0:0:0:0:1	smoore	/	2010-10-21 23:02:40-05
834	0:0:0:0:0:0:0:1	smoore	/patients/search?search=276730794	2010-10-21 23:02:47-05
835	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id?patient_id=78&commit=Yes	2010-10-21 23:03:13-05
836	0:0:0:0:0:0:0:1	smoore	/patients/create_rsna_id	2010-10-21 23:03:45-05
837	0:0:0:0:0:0:0:1	smoore	/exams?print_id=true	2010-10-21 23:03:48-05
838	0:0:0:0:0:0:0:1	smoore	/patients/print_rsna_id	2010-10-21 23:04:07-05
839	0:0:0:0:0:0:0:1	smoore	/exams/add_to_cart?id=82	2010-10-21 23:04:47-05
840	0:0:0:0:0:0:0:1	smoore	/exams/show_cart	2010-10-21 23:04:48-05
841	172.20.175.242	smoore	/exams/send_cart	2010-10-21 23:05:04-05
842	0:0:0:0:0:0:0:1	smoore	/exams	2010-10-21 23:05:08-05
\.


--
-- Data for Name: job_sets; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY job_sets (job_set_id, patient_id, user_id, security_pin, email_address, modified_date, delay_in_hrs, single_use_patient_id) FROM stdin;
18	22	4	\N	wyatt.tellis@ucsf.edu	2010-09-28 13:33:18.509-05	72	\N
19	22	4	\N	wyatt.tellis@ucsf.edu	2010-10-04 17:16:52.477-05	72	\N
20	31	4	\N	wyatt.tellis@ucsf.edu	2010-10-04 17:17:52.218-05	72	\N
21	19	4	\N	\N	2010-10-08 18:35:11.189297-05	72	\N
22	37	4	\N	wyatt.tellis@ucsf.edu	2010-10-11 13:21:56.357-05	72	\N
23	42	7	\N	mdaly@umm.edu	2010-10-13 10:14:51.061-05	72	\N
24	43	4	\N	wyatt.tellis@ucsf.edu	2010-10-13 12:40:54.463-05	72	\N
25	47	4	\N	wyatt.tellis@ucsf.edu	2010-10-13 13:52:20.428-05	72	\N
26	43	4	\N	wyatt.tellis@ucsf.edu	2010-10-13 14:00:01.121-05	72	\N
27	48	4	\N	wyatt.tellis@ucsf.edu	2010-10-13 14:11:49.571-05	72	\N
28	49	4	\N	wyatt.tellis@ucsf.edu	2010-10-13 15:19:51.487-05	72	\N
29	50	4	\N	wyatt.tellis@ucsf.edu	2010-10-13 18:48:30.689-05	72	\N
30	51	4	\N	wyatt.tellis@ucsf.edu	2010-10-13 18:59:07.916-05	72	\N
31	52	4	\N	wyatt.tellis@ucsf.edu	2010-10-14 10:48:12.36-05	72	\N
32	53	4	\N	wyatt.tellis@ucsf.edu	2010-10-14 13:11:30.597-05	72	\N
33	54	4	\N	wyatt.tellis@ucsf.edu	2010-10-14 13:22:31.718-05	72	\N
34	55	4	\N	wyatt.tellis@ucsf.edu	2010-10-14 14:54:05.182-05	72	\N
35	56	4	\N	wyatt.tellis@ucsf.edu	2010-10-14 15:43:03.094-05	72	\N
36	57	9	\N	smoore@wustl.edu	2010-10-14 17:00:16.367-05	72	\N
37	58	9	\N	smoore@wustl.edu	2010-10-14 17:06:26.78-05	72	\N
38	59	9	\N	smoore@wustl.edu	2010-10-14 17:23:48.224-05	72	\N
39	60	4	\N	wyatt.tellis@ucsf.edu	2010-10-15 16:34:15.916-05	72	\N
40	61	4	\N	wyatt.tellis@ucsf.edu	2010-10-15 16:42:01.862-05	72	\N
41	62	4	\N	wyatt.tellis@ucsf.edu	2010-10-19 13:40:25.65-05	72	\N
42	63	9	\N	smoore@wustl.edu	2010-10-20 09:05:39.038-05	72	\N
43	64	9	\N	smoore@wustl.edu	2010-10-20 09:14:25.248-05	72	\N
44	65	9	\N	smoore@wustl.edu	2010-10-20 09:33:05.617-05	72	\N
45	66	9	\N	smoore@wustl.edu	2010-10-20 10:09:53.406-05	72	\N
46	67	9	\N	smoore@wustl.edu	2010-10-20 22:14:51.002-05	72	\N
47	68	9	\N	smoore@wustl.edu	2010-10-20 22:28:20.517-05	72	\N
48	69	9	\N	smoore@wustl.edu	2010-10-20 23:06:43.881-05	72	\N
49	70	9	\N	smoore@wustl.edu	2010-10-20 23:14:26.015-05	72	\N
50	71	9	\N	smoore@wustl.edu	2010-10-20 23:34:03.854-05	72	\N
51	72	9	\N	smoore@wustl.edu	2010-10-20 23:50:04.246-05	72	\N
52	73	9	\N	smoore@wustl.edu	2010-10-21 16:42:26.281-05	72	\N
53	74	9	\N	smoore@wustl.edu	2010-10-21 16:54:25.291-05	72	\N
54	75	9	\N	smoore@wustl.edu	2010-10-21 21:09:36.516-05	72	\N
55	76	9	\N	smoore@wustl.edu	2010-10-21 21:56:34.44-05	72	\N
56	77	9	\N	smoore@wustl.edu	2010-10-21 22:18:06.901-05	72	\N
57	78	9	\N	smoore@wustl.edu	2010-10-21 23:05:03.876-05	72	\N
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY jobs (job_id, job_set_id, exam_id, report_id, document_id, modified_date) FROM stdin;
41	41	66	\N	null	2010-10-19 13:55:33.225635-05
19	21	19	\N	b830a013-04b1-44f1-86fd-c7e11f94ecbe	2010-10-11 17:20:12.747766-05
25	27	49	\N	1.3.6.1.4.1.21367.100.168004102010224113.1286998206509	2010-10-13 14:30:08.727576-05
23	26	43	\N	1.3.6.1.4.1.21367.100.106004174007169075.1286996965633	2010-10-13 14:09:28.701769-05
24	27	48	\N	\N	2010-10-13 14:11:49.614-05
33	33	58	\N	null	2010-10-19 17:01:32.234773-05
28	29	53	\N	urn:uuid:53448240-933e-7490-6d76-0027522b5ef4	2010-10-13 20:21:17.478431-05
16	18	22	\N	6e3894f5-326b-444f-b4af-38c07efae125	2010-10-08 10:33:14.29199-05
17	19	22	\N	6e3894f5-326b-444f-b4af-38c07efae125	2010-10-08 10:33:14.29199-05
18	20	31	\N	14cffe58-6b00-4abe-93a4-ae2bdb2b14c5	2010-10-08 11:56:05.148944-05
30	30	55	\N	urn:uuid:52fd9f38-92f8-7490-dfcd-c227176569ea	2010-10-13 20:13:32.942254-05
29	30	54	\N	urn:uuid:52b723aa-92b2-7490-d41d-9a84e0172c68	2010-10-13 20:05:51.003367-05
31	31	56	\N	null	2010-10-14 13:05:13.567132-05
32	32	57	\N	null	2010-10-14 13:12:18.340275-05
39	39	64	\N	null	2010-10-19 19:23:52.502768-05
20	23	42	\N	1.3.6.1.4.1.21367.100.160006072003081020.1286983430979	2010-10-13 10:23:53.382482-05
40	40	65	\N	null	2010-10-19 19:26:42.89078-05
42	42	67	\N	\N	2010-10-20 09:05:39.071-05
22	25	47	\N	1.3.6.1.4.1.21367.100.115004093008108017.1286999655330	2010-10-13 14:54:17.610215-05
43	43	68	\N	null	2010-10-20 09:19:39.61282-05
34	34	59	\N	null	2010-10-14 15:26:44.060343-05
26	28	50	\N	1.3.6.1.4.1.21367.100.101011182006325126.1287001470589	2010-10-13 15:24:32.916806-05
27	28	51	\N	1.3.6.1.4.1.21367.100.147017189004182044.1287001470768	2010-10-13 15:24:33.352788-05
44	44	69	\N	null	2010-10-20 09:35:21.45225-05
45	45	70	\N	null	2010-10-20 10:11:37.78326-05
46	46	71	\N	\N	2010-10-20 22:14:51.045-05
47	47	71	\N	\N	2010-10-20 22:28:20.563-05
48	47	72	\N	\N	2010-10-20 22:28:20.701-05
49	48	73	\N	\N	2010-10-20 23:06:43.943-05
50	49	74	\N	\N	2010-10-20 23:14:26.063-05
51	50	75	\N	\N	2010-10-20 23:34:03.898-05
52	51	76	\N	\N	2010-10-20 23:50:04.357-05
35	35	60	\N	null	2010-10-14 16:52:02.176671-05
36	36	61	\N	null	2010-10-14 17:01:33.111456-05
21	24	43	\N	1.3.6.1.4.1.21367.100.174005056011278103.1287000880244	2010-10-13 15:14:43.68099-05
37	37	62	\N	null	2010-10-14 17:17:17.528828-05
53	52	77	\N	\N	2010-10-21 16:42:26.324-05
54	53	78	\N	null	2010-10-21 16:54:47.902069-05
38	38	63	\N	null	2010-10-15 12:18:07.710484-05
55	54	79	\N	null	2010-10-21 21:44:09.875062-05
56	55	80	\N	null	2010-10-21 21:57:27.207344-05
57	56	81	\N	null	2010-10-21 22:19:09.664071-05
58	57	82	\N	null	2010-10-21 23:06:07.332468-05
\.


--
-- Data for Name: patient_merge_events; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patient_merge_events (event_id, old_mrn, new_mrn, old_patient_id, new_patient_id, status, modified_date) FROM stdin;
\.


--
-- Data for Name: patient_rsna_ids; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patient_rsna_ids (map_id, rsna_id, patient_id, modified_date, patient_alias_lastname, patient_alias_firstname, registered, email_address, security_pin) FROM stdin;
40	0001-00069-123456	69	2010-10-20 23:07:04.996458-05	last	first	t	\N	\N
42	0001-00071-123456	71	2010-10-20 23:35:12.878796-05	last	first	t	\N	\N
43	0001-00072-123456	72	2010-10-20 23:51:28.536726-05	last	first	t	\N	\N
44	0001-00073-123456	73	2010-10-21 16:41:47.996-05	last	first	f	\N	\N
45	0001-00074-123456	74	2010-10-21 16:54:44.298632-05	last	first	t	\N	\N
46	0001-00075-123456	75	2010-10-21 21:44:06.485628-05	last	first	t	\N	\N
5	0001-00016-123456	16	2010-10-08 08:40:30.530843-05	last	first	f	\N	\N
7	0001-00020-asdfad	20	2010-10-08 08:40:30.530843-05	last	first	f	\N	\N
47	0001-00076-123456	76	2010-10-21 21:57:23.912483-05	last	first	t	\N	\N
2	0001-00007-123456	7	2010-10-08 08:40:30.530843-05	last	first	f	\N	\N
48	0001-00077-123456	77	2010-10-21 22:19:06.370174-05	last	first	t	\N	\N
9	0001-00022-123456	22	2010-10-08 09:32:52.418788-05	last	first	t	\N	\N
10	0001-00031-123456	31	2010-10-08 11:05:39.917927-05	last	first	t	\N	\N
49	0001-00078-123456	78	2010-10-21 23:06:04.051559-05	last	first	t	\N	\N
8	0001-00019-kjhlkj	19	2010-10-08 19:50:33.765973-05	last	first	t	\N	\N
11	0001-00026-222222	26	2010-10-11 01:24:10.287-05	last	first	f	\N	\N
12	0001-00023-123456	23	2010-10-11 10:09:57.723-05	last	first	f	\N	\N
13	0001-00037-123456	37	2010-10-11 13:21:32.78-05	last	first	f	\N	\N
14	0001-00042-123456	42	2010-10-13 10:20:21.31631-05	last	first	t	\N	\N
15	0001-00043-123456	43	2010-10-13 13:20:29.139621-05	last	first	t	\N	\N
17	0001-00044-123456	44	2010-10-13 14:05:01.116-05	last	first	f	\N	\N
18	0001-00048-123456	48	2010-10-13 14:22:16.3613-05	last	first	t	\N	\N
16	0001-00047-123456	47	2010-10-13 14:50:51.814238-05	last	first	t	\N	\N
19	0001-00049-123456	49	2010-10-13 15:21:06.452098-05	last	first	t	\N	\N
20	0001-00050-123456	50	2010-10-13 19:02:42.080275-05	last	first	t	\N	\N
21	0001-00051-123456	51	2010-10-13 19:20:54.598033-05	last	first	t	\N	\N
22	0001-00052-123456	52	2010-10-14 11:46:14.69329-05	last	first	t	\N	\N
23	0001-00053-123456	53	2010-10-14 13:12:08.547994-05	last	first	t	\N	\N
24	0001-00054-123456	54	2010-10-14 13:25:19.117921-05	last	first	t	\N	\N
25	0001-00055-123456	55	2010-10-14 15:26:33.965238-05	last	first	t	\N	\N
27	0001-00045-123456	45	2010-10-14 15:50:32.095-05	last	first	f	\N	\N
26	0001-00056-123456	56	2010-10-14 15:56:15.018532-05	last	first	t	\N	\N
28	0001-00057-123456	57	2010-10-14 17:01:22.982063-05	last	first	t	\N	\N
29	0001-00058-123456	58	2010-10-14 17:17:07.241892-05	last	first	t	\N	\N
30	0001-00059-123456	59	2010-10-14 17:27:14.185964-05	last	first	t	\N	\N
31	0001-00060-123456	60	2010-10-15 16:53:29.772848-05	last	first	t	\N	\N
32	0001-00061-123456	61	2010-10-15 17:17:25.055448-05	last	first	t	\N	\N
33	0001-00062-123456	62	2010-10-19 13:55:29.179392-05	last	first	t	\N	\N
34	0001-00063-123456	63	2010-10-20 09:07:24.585528-05	last	first	t	\N	\N
35	0001-00064-123456	64	2010-10-20 09:19:36.027599-05	last	first	t	\N	\N
36	0001-00065-123456	65	2010-10-20 09:35:18.050534-05	last	first	t	\N	\N
37	0001-00066-123456	66	2010-10-20 10:11:34.318164-05	last	first	t	\N	\N
38	0001-00067-123456	67	2010-10-20 22:17:32.366721-05	last	first	t	\N	\N
39	0001-00068-123456	68	2010-10-20 22:45:44.461065-05	last	first	t	\N	\N
41	1234-5678-1234-5678-1234-5678	70	2010-12-14 13:04:07.617048-06	last	first	t	\N	\N
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patients (patient_id, mrn, patient_name, dob, sex, street, city, state, zip_code, modified_date) FROM stdin;
43	764467765	TEST^TWENTY^	1900-01-01	M	534 Adams Lane	Atlanta	GA	30322	2010-10-13 12:40:11.115011-05
65	225829605	Tue^Coneac^	1903-12-01	M	305 Madison Ave	Atlanta	GA	30319	2010-10-20 09:31:33.930709-05
49	102335231	TEST^THIRTY^	1910-01-01	M	445 Maple Ave	Atlanta	GA	30329	2010-10-13 15:17:47.102842-05
66	258122542	Tue^Conead^	1904-12-01	M	47 Oak St	Atlanta	GA	30319	2010-10-20 10:08:11.377089-05
50	818731508	TEST^FORTY^	1920-01-01	M	287 Oak St	Atlanta	GA	30329	2010-10-13 18:47:56.218344-05
44	731880094	Dean^Jimmy^	0101-12-31	M	764 Woodland Ave	Atlanta	GA	30317	2010-10-13 13:11:26.206926-05
45	632406555	Dean^Jimmy^	1975-01-01	M	366 Chestnut St	Atlanta	GA	30317	2010-10-13 13:13:45.787163-05
7	678188495	Doe^John	1963-02-08	M	BOX 0824 - MCB 300	San Francisco	CA	94143	2010-09-24 11:59:47.624073-05
46	981912619	Doe^John^	0101-12-31	M	747 Elm St	Atlanta	GA	30319	2010-10-13 13:23:29.817733-05
16	852215460	TEST^THREE^	1972-02-21	F	951 Cleveland Ave	Atlanta	GA	30317	2010-09-24 11:59:59.829309-05
47	130224392	Wed^Ctwentyab^	1920-12-12	M	880 Birch Ave	Atlanta	GA	30322	2010-10-13 13:40:57.344826-05
21	577900744	TEST^SIX^	1910-08-09	M	178 Madison Ave	Atlanta	GA	30317	2010-09-24 15:03:34.183316-05
19	389321721	Moore^Ac^	1940-12-12	M	196 Rooselvelt Ave	Atlanta	GA	30317	2010-09-28 12:48:51.301545-05
20	199710663	TEST^FIVE^	1977-02-08	F	903 Maple Ave	Atlanta	GA	30317	2010-09-28 12:48:59.052191-05
22	683319969	TEST^SEVEN^	1976-11-08	M	114 Jefferson Ave	Atlanta	GA	30317	2010-09-28 13:28:29.154043-05
23	818163599	Moore^C^	1901-12-12	M	141 Cleveland Ave	Atlanta	GA	30317	2010-09-30 10:07:33.378013-05
24	313922369	Matt^Kelsey^	1940-01-01	M	385 Cleveland Ave	Atlanta	GA	30317	2010-09-30 10:26:00.373045-05
25	900340334	Matt^Kelsey^	1940-01-01	M	549 Jefferson Ave	Atlanta	GA	30317	2010-09-30 10:34:03.427265-05
26	169998861	Matt^Kelsey^	1940-01-01	M	594 Jefferson Ave	Atlanta	GA	30319	2010-09-30 10:34:49.668529-05
27	319384274	Matt^Kelsey^	1940-01-01	M	518 Washington Ave	Atlanta	GA	30319	2010-09-30 10:37:04.933475-05
28	941543187	m^m^	0202-12-31	F	741 Main St	Atlanta	GA	30317	2010-09-30 10:46:31.938738-05
29	154451252	Moore^D^	1902-12-12	M	828 Cleveland Ave	Atlanta	GA	30317	2010-10-01 15:11:50.8262-05
30	196921969	K^M^	0101-12-31	M	703 Central Ave	Atlanta	GA	30317	2010-10-01 16:00:48.07983-05
31	188602961	Martin^Dean^	1914-01-01	M	626 Birch Ave	Atlanta	GA	30317	2010-10-01 16:04:59.051595-05
32	650856216	Simon^Simple^	1901-01-01	M	897 Jefferson Ave	Atlanta	GA	30319	2010-10-01 16:09:04.639672-05
33	603406323	Rather^Dan^	1941-01-01	M	54 Adams Lane	Atlanta	GA	30319	2010-10-01 16:10:45.809768-05
34	613859951	Dean^Jimmy^	1900-01-01	M	993 Madison Ave	Atlanta	GA	30319	2010-10-01 16:27:57.159799-05
35	393594062	Shagnasty^Boliver^	0101-12-31	M	519 Oak St	Atlanta	GA	30322	2010-10-01 16:47:31.141125-05
36	288128487	TEST^^	1980-12-25	F	349 Elm St	Atlanta	GA	30317	2010-10-11 13:19:16.135587-05
37	123998648	TEST^ELEVEN^	1942-12-01	M	118 Washington Ave	Atlanta	GA	30317	2010-10-11 13:20:40.940425-05
38	939894620	TEST^TWELVE^	1972-08-22	M	818 Washington Ave	Atlanta	GA	30319	2010-10-11 13:28:26.420589-05
39	147563401	Matt^Kelsey^	1911-01-01	M	867 Adams Lane	Atlanta	GA	30317	2010-10-11 14:52:30.579113-05
40	903496451	Moore^C^	1900-12-12	M	625 Rooselvelt Ave	Atlanta	GA	30319	2010-10-12 21:32:04.026557-05
41	251566329	Moore^CFiftyA^	1950-12-12	M	16 Hill St	Atlanta	GA	30319	2010-10-12 21:51:13.638931-05
42	283348176	Wed^Ctwentyaa^	1920-12-12	M	170 Main St	Atlanta	GA	30322	2010-10-13 09:34:40.386705-05
67	448520587	Wed^Coneae^	1905-12-01	M	767 Adams Lane	Atlanta	GA	30319	2010-10-20 22:12:11.646229-05
51	357656050	TEST^FIFTY^	1930-01-01	M	825 Washington Ave	Atlanta	GA	30333	2010-10-13 18:57:58.948805-05
48	317082933	Wed^Caa^	1970-12-12	M	780 Jefferson Ave	Atlanta	GA	30329	2010-10-13 14:03:11.108451-05
52	430754812	DAY^TWO^	1940-01-01	M	224 Rooselvelt Ave	Atlanta	GA	30333	2010-10-14 10:45:56.22533-05
53	619438774	DAY^THREE^	1950-01-01	M	118 Adams Lane	Atlanta	GA	30333	2010-10-14 13:10:12.0684-05
54	709222489	FOUR^THREE^	1960-01-01	M	619 Main St	Atlanta	GA	30338	2010-10-14 13:21:05.034317-05
55	842999018	TEST^SIXTY^	1960-01-01	M	68 Jefferson Ave	Atlanta	GA	30338	2010-10-14 14:53:25.048286-05
56	717091616	Doe^Jone^	1998-09-10	M	587 Madison Ave	Atlanta	GA	30338	2010-10-14 15:35:09.090517-05
57	198210769	Wed^Cfiveaa^	1905-12-12	M	855 Elm St	Atlanta	GA	30338	2010-10-14 16:56:34.73007-05
58	222421165	Thu^Cfiftyba^	1946-02-01	M	474 Chestnut St	Atlanta	GA	30340	2010-10-14 17:04:05.402721-05
59	532194382	Thu^Chundreda^	2000-12-12	M	269 Oak St	Atlanta	GA	30340	2010-10-14 17:22:33.09905-05
60	249629085	TEST^SIXTY^	1942-12-01	M	271 Oak St	Atlanta	GA	30340	2010-10-15 16:33:26.126818-05
61	411146676	TEST^SEVENTY^	1976-11-01	F	669 Cleveland Ave	Atlanta	GA	30317	2010-10-15 16:35:06.64385-05
62	172615160	Tue^Ctwoaa^	1910-12-12	M	20 Maple Ave	Atlanta	GA	30317	2010-10-19 13:37:02.618494-05
63	100621249	Tue^Coneaa^	1901-12-12	M	553 Maple Ave	Atlanta	GA	30317	2010-10-20 08:59:46.913925-05
64	878012805	Tue^Coneab^	1901-12-01	M	430 Adams Lane	Atlanta	GA	30317	2010-10-20 09:13:17.915816-05
68	194783596	Wed^Coneaf^	1905-12-01	M	165 Madison Ave	Atlanta	GA	30322	2010-10-20 22:26:47.288353-05
69	277621360	Wed^Coneag^	1906-12-01	M	296 Jefferson Ave	Atlanta	GA	30322	2010-10-20 23:04:57.316832-05
70	110069930	Wed^Coneah^	1908-12-01	M	31 Rooselvelt Ave	Atlanta	GA	30322	2010-10-20 23:12:51.98814-05
71	291816949	Wed^Coneai^	1909-12-01	M	869 Birch Ave	Atlanta	GA	30329	2010-10-20 23:32:21.865094-05
72	915914130	Wed^Conej^	1910-12-01	M	704 Main St	Atlanta	GA	30329	2010-10-20 23:48:19.51666-05
73	138546187	Thu^Coneb^	1911-12-01	M	262 Main St	Atlanta	GA	30329	2010-10-21 16:41:13.040031-05
74	700193747	Thu^Conebb^	1912-12-01	M	983 Adams Lane	Atlanta	GA	30333	2010-10-21 16:52:59.647264-05
75	426729010	Thu^Conebc^	1913-12-01	M	160 Madison Ave	Atlanta	GA	30333	2010-10-21 21:08:18.962563-05
76	554468902	Thu^Conebd^	1914-12-01	M	436 Adams Lane	Atlanta	GA	30333	2010-10-21 21:54:52.153677-05
77	764181133	Thu^Conebe^	1915-12-01	M	720 Woodland Ave	Atlanta	GA	30338	2010-10-21 22:15:47.018459-05
78	276730794	Thu^Conebf^	1916-12-01	M	858 Elm St	Atlanta	GA	30338	2010-10-21 23:02:16.338895-05
79	144443352	Wyatt^Tellis^	1980-12-25	M	528 Jefferson Ave	Atlanta	GA	30317	2010-12-17 13:50:01.187707-06
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY reports (report_id, exam_id, proc_code, status, status_timestamp, report_text, signer, dictator, transcriber, modified_date) FROM stdin;
4	7	\N	FINALIZED	2010-06-02 10:56:00-05	1) Create report in Radhwere.\r\n2) Sign/Finalize report in Radwhere\r\n\r\n	PA0001^Avrin^David^^^			2010-09-16 14:13:55.667721-05
15	16	\N	FINALIZED	2010-09-21 17:03:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-21 17:03:45.35519-05
84	50	\N	FINALIZED	2010-10-14 01:14:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 15:17:41.659075-05
21	19	\N	ORDERED	2010-09-24 12:38:00-05					2010-09-24 12:38:14.766935-05
22	19	\N	FINALIZED	2010-09-24 22:38:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-24 12:38:17.997799-05
23	20	\N	ORDERED	2010-09-24 12:54:00-05					2010-09-24 12:53:44.02802-05
24	20	\N	FINALIZED	2010-09-24 22:54:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-24 12:53:47.353021-05
25	21	\N	ORDERED	2010-09-24 15:04:00-05					2010-09-24 15:03:31.085127-05
26	21	\N	FINALIZED	2010-09-25 01:04:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-24 15:03:34.375295-05
27	22	\N	ORDERED	2010-09-28 13:29:00-05					2010-09-28 13:28:25.959154-05
28	22	\N	FINALIZED	2010-09-28 23:29:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-28 13:28:29.500032-05
29	23	\N	ORDERED	2010-09-30 10:08:00-05					2010-09-30 10:07:30.282475-05
30	23	\N	FINALIZED	2010-09-30 20:09:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-30 10:07:33.730646-05
31	24	\N	ORDERED	2010-09-30 10:27:00-05					2010-09-30 10:25:57.248087-05
32	24	\N	FINALIZED	2010-09-30 20:27:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-30 10:26:00.674051-05
33	25	\N	ORDERED	2010-09-30 10:35:00-05					2010-09-30 10:34:00.313237-05
34	25	\N	FINALIZED	2010-09-30 20:35:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-30 10:34:03.702226-05
35	26	\N	ORDERED	2010-09-30 10:36:00-05					2010-09-30 10:34:46.520928-05
36	26	\N	FINALIZED	2010-09-30 20:36:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-30 10:34:49.963304-05
37	27	\N	ORDERED	2010-09-30 10:38:00-05					2010-09-30 10:37:01.832961-05
38	27	\N	FINALIZED	2010-09-30 20:38:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-30 10:37:05.290494-05
39	28	\N	ORDERED	2010-09-30 10:47:00-05					2010-09-30 10:46:28.724042-05
40	28	\N	FINALIZED	2010-09-30 20:48:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-30 10:46:32.289642-05
41	29	\N	ORDERED	2010-10-01 15:13:00-05					2010-10-01 15:11:47.733983-05
42	29	\N	FINALIZED	2010-10-02 01:13:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-01 15:11:50.952769-05
43	30	\N	ORDERED	2010-10-01 16:02:00-05					2010-10-01 16:00:44.994986-05
44	30	\N	FINALIZED	2010-10-02 02:02:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-01 16:00:48.212182-05
45	31	\N	ORDERED	2010-10-01 16:06:00-05					2010-10-01 16:04:55.944517-05
46	31	\N	FINALIZED	2010-10-02 02:06:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-01 16:04:59.209375-05
47	32	\N	ORDERED	2010-10-01 16:10:00-05					2010-10-01 16:09:01.4735-05
48	32	\N	FINALIZED	2010-10-02 02:10:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-01 16:09:04.781957-05
49	33	\N	ORDERED	2010-10-01 16:12:00-05					2010-10-01 16:10:42.72045-05
50	33	\N	FINALIZED	2010-10-02 02:12:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-01 16:10:45.975904-05
51	34	\N	ORDERED	2010-10-01 16:29:00-05					2010-10-01 16:27:54.08272-05
52	34	\N	FINALIZED	2010-10-02 02:29:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-01 16:27:57.296217-05
53	35	\N	ORDERED	2010-10-01 16:49:00-05					2010-10-01 16:47:28.073337-05
54	35	\N	FINALIZED	2010-10-02 02:49:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-01 16:47:31.263582-05
55	36	\N	ORDERED	2010-10-11 13:15:00-05					2010-10-11 13:19:12.90432-05
56	36	\N	FINALIZED	2010-10-11 23:15:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-11 13:19:16.394744-05
57	37	\N	ORDERED	2010-10-11 13:17:00-05					2010-10-11 13:20:37.75772-05
58	37	\N	FINALIZED	2010-10-11 23:17:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-11 13:20:41.367517-05
59	38	\N	ORDERED	2010-10-11 13:24:00-05					2010-10-11 13:28:23.316437-05
60	38	\N	FINALIZED	2010-10-11 23:24:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-11 13:28:26.571649-05
61	39	\N	ORDERED	2010-10-11 14:48:00-05					2010-10-11 14:52:27.473765-05
62	39	\N	FINALIZED	2010-10-12 00:48:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-11 14:52:30.810583-05
63	40	\N	ORDERED	2010-10-12 21:28:00-05					2010-10-12 21:32:00.910962-05
64	40	\N	FINALIZED	2010-10-13 07:28:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-12 21:32:04.294371-05
65	41	\N	ORDERED	2010-10-12 21:47:00-05					2010-10-12 21:51:10.534733-05
66	41	\N	FINALIZED	2010-10-13 07:47:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-12 21:51:13.765706-05
67	42	\N	ORDERED	2010-10-13 09:31:00-05					2010-10-13 09:34:36.98192-05
68	42	\N	FINALIZED	2010-10-13 19:31:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 09:34:40.506974-05
69	43	\N	ORDERED	2010-10-13 12:36:00-05					2010-10-13 12:40:07.853564-05
70	43	\N	FINALIZED	2010-10-13 22:36:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 12:40:11.546105-05
71	44	\N	ORDERED	2010-10-13 13:08:00-05					2010-10-13 13:11:22.87361-05
72	44	\N	FINALIZED	2010-10-13 23:08:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 13:11:26.453814-05
73	45	\N	ORDERED	2010-10-13 13:10:00-05					2010-10-13 13:13:42.708566-05
74	45	\N	FINALIZED	2010-10-13 23:10:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 13:13:45.926303-05
75	46	\N	ORDERED	2010-10-13 13:20:00-05					2010-10-13 13:23:26.343173-05
76	46	\N	FINALIZED	2010-10-13 23:20:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 13:23:30.200803-05
77	47	\N	ORDERED	2010-10-13 13:37:00-05					2010-10-13 13:40:54.176834-05
78	47	\N	FINALIZED	2010-10-13 23:37:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 13:40:57.643522-05
79	48	\N	ORDERED	2010-10-13 13:59:00-05					2010-10-13 14:03:02.927658-05
80	48	\N	FINALIZED	2010-10-13 23:59:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 14:03:06.073167-05
81	49	\N	ORDERED	2010-10-13 13:59:00-05					2010-10-13 14:03:08.012129-05
82	49	\N	FINALIZED	2010-10-13 23:59:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 14:03:11.222374-05
83	50	\N	ORDERED	2010-10-13 15:14:00-05					2010-10-13 15:17:38.357826-05
85	51	\N	ORDERED	2010-10-13 15:14:00-05					2010-10-13 15:17:44.036378-05
86	51	\N	FINALIZED	2010-10-14 01:14:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 15:17:47.19073-05
87	52	\N	ORDERED	2010-10-13 18:44:00-05					2010-10-13 18:47:45.956288-05
88	52	\N	FINALIZED	2010-10-14 04:44:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 18:47:50.899816-05
89	53	\N	ORDERED	2010-10-13 18:44:00-05					2010-10-13 18:47:53.067348-05
90	53	\N	FINALIZED	2010-10-14 04:44:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 18:47:56.358851-05
91	54	\N	ORDERED	2010-10-13 18:54:00-05					2010-10-13 18:57:50.549068-05
92	54	\N	FINALIZED	2010-10-14 04:54:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 18:57:53.752635-05
93	55	\N	ORDERED	2010-10-13 18:54:00-05					2010-10-13 18:57:55.846708-05
94	55	\N	FINALIZED	2010-10-14 04:54:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-13 18:57:59.053237-05
95	56	\N	ORDERED	2010-10-14 10:42:00-05					2010-10-14 10:45:53.141095-05
96	56	\N	FINALIZED	2010-10-14 20:42:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 10:45:56.35012-05
97	57	\N	ORDERED	2010-10-14 13:06:00-05					2010-10-14 13:10:08.961671-05
98	57	\N	FINALIZED	2010-10-14 23:06:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 13:10:12.197873-05
99	58	\N	ORDERED	2010-10-14 13:17:00-05					2010-10-14 13:21:01.971452-05
100	58	\N	FINALIZED	2010-10-14 23:17:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 13:21:05.225659-05
101	59	\N	ORDERED	2010-10-14 14:50:00-05					2010-10-14 14:53:21.969922-05
102	59	\N	FINALIZED	2010-10-15 00:50:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 14:53:25.165023-05
103	60	\N	ORDERED	2010-10-14 15:31:00-05					2010-10-14 15:35:06.001129-05
104	60	\N	FINALIZED	2010-10-15 01:31:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 15:35:09.28124-05
105	61	\N	ORDERED	2010-10-14 16:53:00-05					2010-10-14 16:56:31.664972-05
106	61	\N	FINALIZED	2010-10-15 02:53:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 16:56:34.815163-05
107	62	\N	ORDERED	2010-10-14 17:00:00-05					2010-10-14 17:04:02.329714-05
108	62	\N	FINALIZED	2010-10-15 03:00:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 17:04:05.535753-05
109	63	\N	ORDERED	2010-10-14 17:19:00-05					2010-10-14 17:22:30.034348-05
110	63	\N	FINALIZED	2010-10-15 03:19:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-14 17:22:33.214258-05
111	64	\N	ORDERED	2010-10-15 16:30:00-05					2010-10-15 16:33:23.042985-05
112	64	\N	FINALIZED	2010-10-16 02:30:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-15 16:33:26.346003-05
113	65	\N	ORDERED	2010-10-15 16:31:00-05					2010-10-15 16:35:03.466623-05
114	65	\N	FINALIZED	2010-10-16 02:32:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-15 16:35:07.070923-05
115	66	\N	ORDERED	2010-10-19 13:34:00-05					2010-10-19 13:36:58.61666-05
116	66	\N	FINALIZED	2010-10-19 23:34:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-19 13:37:03.221584-05
117	67	\N	ORDERED	2010-10-20 08:57:00-05					2010-10-20 08:59:43.843911-05
118	67	\N	FINALIZED	2010-10-20 18:57:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 08:59:47.147352-05
119	68	\N	ORDERED	2010-10-20 09:10:00-05					2010-10-20 09:13:14.616174-05
120	68	\N	FINALIZED	2010-10-20 19:10:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 09:13:18.08472-05
121	69	\N	ORDERED	2010-10-20 09:29:00-05					2010-10-20 09:31:30.850888-05
122	69	\N	FINALIZED	2010-10-20 19:29:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 09:31:34.102163-05
123	70	\N	ORDERED	2010-10-20 10:05:00-05					2010-10-20 10:08:08.314086-05
124	70	\N	FINALIZED	2010-10-20 20:05:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 10:08:11.509368-05
125	71	\N	ORDERED	2010-10-20 22:09:00-05					2010-10-20 22:12:08.585295-05
126	71	\N	FINALIZED	2010-10-21 08:09:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 22:12:11.763503-05
127	72	\N	ORDERED	2010-10-20 22:24:00-05					2010-10-20 22:26:44.226922-05
128	72	\N	FINALIZED	2010-10-21 08:24:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 22:26:47.409519-05
129	73	\N	ORDERED	2010-10-20 23:02:00-05					2010-10-20 23:04:54.240195-05
130	73	\N	FINALIZED	2010-10-21 09:02:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 23:04:57.422145-05
131	74	\N	ORDERED	2010-10-20 23:10:00-05					2010-10-20 23:12:48.922832-05
132	74	\N	FINALIZED	2010-10-21 09:10:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 23:12:52.148122-05
133	75	\N	ORDERED	2010-10-20 23:29:00-05					2010-10-20 23:32:18.80737-05
134	75	\N	FINALIZED	2010-10-21 09:29:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 23:32:21.990981-05
135	76	\N	ORDERED	2010-10-20 23:45:00-05					2010-10-20 23:48:16.438391-05
136	76	\N	FINALIZED	2010-10-21 09:45:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-20 23:48:19.633153-05
137	77	\N	ORDERED	2010-10-21 16:38:00-05					2010-10-21 16:41:09.970245-05
138	77	\N	FINALIZED	2010-10-22 02:38:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-21 16:41:13.573449-05
139	78	\N	ORDERED	2010-10-21 16:50:00-05					2010-10-21 16:52:56.586375-05
140	78	\N	FINALIZED	2010-10-22 02:50:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-21 16:52:59.764087-05
141	79	\N	ORDERED	2010-10-21 21:05:00-05					2010-10-21 21:08:15.888204-05
142	79	\N	FINALIZED	2010-10-22 07:06:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-21 21:08:19.097024-05
143	80	\N	ORDERED	2010-10-21 21:52:00-05					2010-10-21 21:54:49.092017-05
144	80	\N	FINALIZED	2010-10-22 07:52:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-21 21:54:52.267397-05
145	81	\N	ORDERED	2010-10-21 22:13:00-05					2010-10-21 22:15:43.962022-05
146	81	\N	FINALIZED	2010-10-22 08:13:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-21 22:15:47.139135-05
147	82	\N	ORDERED	2010-10-21 22:59:00-05					2010-10-21 23:02:13.258522-05
148	82	\N	FINALIZED	2010-10-22 08:59:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-10-21 23:02:16.455285-05
149	83	\N	ORDERED	2010-12-17 13:50:00-06					2010-12-17 13:49:58.04392-06
150	83	\N	FINALIZED	2010-12-17 23:50:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-12-17 13:50:01.246184-06
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY roles (role_id, role_description, modified_date) FROM stdin;
\.


--
-- Data for Name: status_codes; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY status_codes (status_code, description, modified_date) FROM stdin;
31	Started processing input data	2010-10-22 09:58:07.496506-05
21	Waiting for report finalization	2010-10-22 11:59:15.243445-05
23	Started DICOM C-MOVE	2010-10-22 11:59:15.243445-05
30	Waiting to start transfer to clearinghouse	2010-10-22 11:59:15.243445-05
22	Waiting for job delay to expire	2010-10-22 11:59:15.243445-05
32	Started KOS generation	2010-10-22 09:58:07.496506-05
33	Stared patient registration	2010-10-22 09:58:07.496506-05
34	Started document submission	2010-10-22 09:58:07.496506-05
40	Completed transfer to clearinghouse	2010-10-22 09:58:07.496506-05
1	Waiting to retrieve images and report	2010-10-22 09:58:07.496506-05
-23	DICOM C-MOVE failed	2010-10-22 11:59:15.243445-05
-21	Unable to find images	2010-10-22 11:59:15.243445-05
-32	Failed to generate KOS	2010-11-02 09:39:45.53873-05
-30	Failed to transfer to clearinghouse	2010-11-02 09:39:24.901369-05
-20	Failed to prepare content	2010-10-22 09:58:07.496506-05
-33	Failed to register patient with clearinghouse	2010-11-02 09:40:11.789371-05
-34	Failed to submit documents to clearinghouse	2010-11-02 09:40:28.488821-05
\.


--
-- Data for Name: studies; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY studies (study_id, study_uid, exam_id, study_description, study_date, modified_date) FROM stdin;
34	1.2.3.4.5.6.7.383143.39	7	Description	2010-09-13 14:38:45	2010-09-27 17:01:06.43-05
35	1.2.3.4.5.6.7.383143.39	7	Description	2010-09-13 14:38:45	2010-09-27 17:22:39.57-05
36	1.2.3.4.5.6.7.824357.1	19	Description	2010-09-24 12:38:55	2010-09-27 17:25:19.484-05
37	1.2.3.4.5.6.7.824357.27	20	Description	2010-09-24 12:54:24	2010-09-27 17:26:19.488-05
38	1.2.3.4.5.6.7.383143.39	7	Description	2010-09-13 14:38:45	2010-09-28 12:54:35.346-05
39	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-09-28 13:54:00.85-05
40	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-09-28 13:56:49.821-05
41	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-09-28 14:06:00.414-05
42	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-09-28 14:09:55.619-05
43	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-09-28 15:00:48.779-05
44	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-09-29 10:00:35.376-05
45	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 14:13:28.385-05
46	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 14:20:08.909-05
47	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 14:23:54.057-05
48	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 14:35:42.934-05
49	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 15:22:24.299-05
50	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 16:12:47.889-05
51	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 16:34:10.841-05
52	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 16:45:26.93-05
53	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-04 16:48:13.466-05
54	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 14:38:16.892-05
55	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 15:13:26.253-05
56	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 15:14:56.729-05
57	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 18:22:45.333-05
58	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 18:31:06.881-05
59	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 18:38:13.277-05
60	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 18:53:20.21-05
61	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-05 19:05:41.312-05
62	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-06 09:31:09.989-05
63	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 13:38:52.104-05
64	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 17:37:09.872-05
65	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 17:43:33.997-05
66	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 17:46:45.272-05
67	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 17:53:22.278-05
68	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 18:06:12.512-05
69	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 18:18:24.243-05
70	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 18:28:18.514-05
71	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 18:32:04.784-05
72	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 18:36:47.516-05
73	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-06 18:42:56.325-05
74	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 10:01:59.746-05
75	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 13:25:22.743-05
76	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 13:43:40.185-05
77	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 13:59:08.41-05
78	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 16:47:45.654-05
79	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 16:58:00.564-05
80	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 17:41:31.999-05
81	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 18:09:56.265-05
82	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 18:15:04.639-05
83	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 18:19:04.754-05
84	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 18:37:53.506-05
85	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 18:39:15.567-05
86	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 18:45:24.578-05
87	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 19:02:15.662-05
88	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 19:22:18.327-05
89	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 19:28:20.941-05
90	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 19:39:50.914-05
91	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 19:42:13.664-05
92	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 19:54:18.749-05
93	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-07 20:03:31.788-05
94	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 09:00:51.165-05
95	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 09:32:52.845-05
96	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 09:47:58.088-05
97	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 09:57:40.727-05
98	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 10:04:52.752-05
99	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 10:13:18.796-05
100	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 10:21:40.54-05
101	1.2.3.4.5.6.7.484882.0	22	Description	2010-09-28 13:29:42	2010-10-08 10:29:51.556-05
102	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-08 10:41:06.805-05
103	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-08 11:05:40.354-05
104	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-08 11:19:27.629-05
105	1.2.3.4.5.6.7.862899.30	31	Description	2010-10-01 16:06:39	2010-10-08 11:52:38.618-05
106	1.2.3.4.5.6.7.824357.1	19	Description	2010-09-24 12:38:55	2010-10-08 18:45:01.094-05
107	1.2.3.4.5.6.7.824357.1	19	Description	2010-09-24 12:38:55	2010-10-08 19:11:05.431-05
108	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 20:17:04.709-05
109	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 20:24:11.475-05
110	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 21:25:44.171-05
111	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:25:31.296-05
112	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:27:31.105-05
113	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:29:30.838-05
114	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:33:30.952-05
115	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:37:42.91-05
116	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:42:30.987-05
117	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:45:18.667-05
118	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:45:30.872-05
119	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:49:30.898-05
120	2.16.840.1.114151.4.231.40336.4545.5232641	19	XR HIP 2 VIEW, RT	2010-06-09 10:56:06	2010-10-08 23:51:17.786-05
121	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-10 20:47:57.152-05
122	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 11:10:31.419-05
123	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 11:12:46.877-05
124	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 11:14:03.94-05
125	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 11:17:43.634-05
126	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 11:21:18.658-05
127	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 11:29:39.114-05
128	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 12:11:01.717-05
129	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 13:11:18.614-05
130	2.16.840.1.114151.4.231.39225.4060.3055543	19	R GMI HAND 3 V MIN	2007-05-25 09:50:14	2010-10-11 17:18:31.918-05
131	1.2.3.4.5.6.7.9357.182	42	Abdomen-20	2010-10-13 09:31:19	2010-10-13 10:20:21.927-05
132	1.2.3.4.5.6.7.9357.206	43	Abdomen-20	2010-10-13 12:36:51	2010-10-13 13:21:37.894-05
133	1.2.3.4.5.6.7.9357.206	43	Abdomen-20	2010-10-13 12:36:51	2010-10-13 13:30:20.485-05
134	1.2.3.4.5.6.7.9357.206	43	Abdomen-20	2010-10-13 12:36:51	2010-10-13 13:36:46.353-05
135	1.2.3.4.5.6.7.9357.206	43	Abdomen-20	2010-10-13 12:36:51	2010-10-13 14:05:40.519-05
136	1.2.3.4.5.6.7.9357.278	49	Abdomen-50	2010-10-13 13:59:51	2010-10-13 14:22:16.836-05
137	1.2.3.4.5.6.7.9357.230	47	Abdomen-20	2010-10-13 13:37:38	2010-10-13 14:50:52.33-05
138	1.2.3.4.5.6.7.9357.206	43	Abdomen-20	2010-10-13 12:36:51	2010-10-13 15:11:12.169-05
139	1.2.3.4.5.6.7.9357.332	50	Abdomen-20	2010-10-13 15:14:22	2010-10-13 15:21:06.93-05
140	1.2.3.4.5.6.7.9357.356	51	Abdomen-50	2010-10-13 15:14:28	2010-10-13 15:21:29.715-05
141	1.2.3.4.5.6.7.9357.434	53	Abdomen-50	2010-10-13 18:44:38	2010-10-13 19:02:42.745-05
142	1.2.3.4.5.6.7.9357.488	54	Abdomen-20	2010-10-13 18:54:35	2010-10-13 19:20:55.152-05
143	1.2.3.4.5.6.7.9357.512	55	Abdomen-50	2010-10-13 18:54:41	2010-10-13 19:33:03.877-05
144	1.2.3.4.5.6.7.9357.488	54	Abdomen-20	2010-10-13 18:54:35	2010-10-13 20:02:35.433-05
145	1.2.3.4.5.6.7.9357.512	55	Abdomen-50	2010-10-13 18:54:41	2010-10-13 20:05:58.21-05
146	1.2.3.4.5.6.7.9357.434	53	Abdomen-50	2010-10-13 18:44:38	2010-10-13 20:13:40.761-05
147	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 11:46:15.175-05
148	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 11:48:15.891-05
149	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 11:54:55.892-05
150	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 12:00:57.214-05
151	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 12:46:58.04-05
152	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 12:52:51.804-05
153	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 12:59:26.461-05
154	1.2.3.4.5.6.7.2541.566	56	Abdomen-05	2010-10-14 10:42:43	2010-10-14 13:05:03.882-05
155	1.2.3.4.5.6.7.2541.575	57	Abdomen-05	2010-10-14 13:07:00	2010-10-14 13:12:08.874-05
156	1.2.3.4.5.6.7.2541.584	58	Abdomen-05	2010-10-14 13:17:53	2010-10-14 13:25:19.563-05
157	1.2.3.4.5.6.7.2541.584	58	Abdomen-05	2010-10-14 13:17:53	2010-10-14 13:41:25.218-05
158	1.2.3.4.5.6.7.2541.584	58	Abdomen-05	2010-10-14 13:17:53	2010-10-14 14:26:26.756-05
159	1.2.3.4.5.6.7.2541.584	58	Abdomen-05	2010-10-14 13:17:53	2010-10-14 14:50:38.416-05
160	1.2.3.4.5.6.7.2541.593	59	Abdomen-05	2010-10-14 14:50:13	2010-10-14 14:55:07.348-05
161	1.2.3.4.5.6.7.2541.593	59	Abdomen-05	2010-10-14 14:50:13	2010-10-14 15:04:02.591-05
162	1.2.3.4.5.6.7.2541.593	59	Abdomen-05	2010-10-14 14:50:13	2010-10-14 15:16:23.986-05
163	1.2.3.4.5.6.7.2541.593	59	Abdomen-05	2010-10-14 14:50:13	2010-10-14 15:18:47.538-05
164	1.2.3.4.5.6.7.2541.593	59	Abdomen-05	2010-10-14 14:50:13	2010-10-14 15:22:58.102-05
165	1.2.3.4.5.6.7.2541.593	59	Abdomen-05	2010-10-14 14:50:13	2010-10-14 15:26:34.374-05
166	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 15:56:15.433-05
167	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:05:40.044-05
168	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:12:22.237-05
169	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:13:51.346-05
170	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:16:56.643-05
171	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:20:31.269-05
172	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:25:04.166-05
173	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:28:53.422-05
174	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:39:52.523-05
175	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:46:17.613-05
176	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:47:25.683-05
177	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:50:27.641-05
178	1.2.3.4.5.6.7.2541.602	60	Abdomen-05	2010-10-14 15:31:57	2010-10-14 16:51:52.415-05
179	1.2.3.4.5.6.7.2541.611	61	Abdomen-05	2010-10-14 16:53:23	2010-10-14 17:01:23.457-05
180	1.2.3.4.5.6.7.2541.620	62	Abdomen-50	2010-10-14 17:00:54	2010-10-14 17:17:07.666-05
181	1.2.3.4.5.6.7.2541.674	63	Abdomen-100	2010-10-14 17:19:22	2010-10-14 17:40:02.098-05
182	1.2.3.4.5.6.7.2541.674	63	Abdomen-100	2010-10-14 17:19:22	2010-10-15 11:43:34.022-05
183	1.2.3.4.5.6.7.2541.674	63	Abdomen-100	2010-10-14 17:19:22	2010-10-15 11:53:03.447-05
184	1.2.3.4.5.6.7.2541.674	63	Abdomen-100	2010-10-14 17:19:22	2010-10-15 11:56:42.628-05
185	1.2.3.4.5.6.7.2541.674	63	Abdomen-100	2010-10-14 17:19:22	2010-10-15 12:04:48.682-05
186	1.2.3.4.5.6.7.2541.674	63	Abdomen-100	2010-10-14 17:19:22	2010-10-15 12:18:04.359-05
187	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 16:53:30.771-05
188	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 17:17:21.085-05
189	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-15 17:17:25.777-05
190	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-15 17:21:13.948-05
191	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 17:24:27.303-05
192	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 18:35:17.407-05
193	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-15 18:40:04.147-05
194	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 18:42:59.157-05
195	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 18:54:00.559-05
196	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-15 19:47:26.283-05
197	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 19:51:24.387-05
198	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 19:54:23.012-05
199	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-15 19:59:13.963-05
200	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-15 20:10:53.877-05
201	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-15 20:13:53.347-05
202	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-16 22:28:27.907-05
203	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-17 17:40:47.391-05
204	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-18 14:36:28.801-05
205	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-18 14:41:49.701-05
206	1.2.3.4.5.6.7.288621.0	66	Abdomen-02	2010-10-19 13:34:28	2010-10-19 13:55:30.294-05
207	1.2.3.4.5.6.7.288621.0	66	Abdomen-02	2010-10-19 13:34:28	2010-10-19 13:55:30.484-05
208	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-19 14:07:51.77-05
209	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-19 14:07:51.774-05
210	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-19 14:11:43.984-05
211	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-19 14:14:27.648-05
212	1.2.3.4.5.6.7.2541.584	58	Abdomen-05	2010-10-14 13:17:53	2010-10-19 17:01:29.178-05
213	1.2.3.4.5.6.7.2541.584	58	Abdomen-05	2010-10-14 13:17:53	2010-10-19 17:01:29.89-05
214	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-19 17:25:55.028-05
215	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-19 17:26:29.546-05
216	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-19 17:43:38.444-05
217	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-19 17:44:20.894-05
218	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-19 19:06:24.029-05
219	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-19 19:09:22.064-05
220	1.2.3.4.5.6.7.2541.778	64	Abdomen-100	2010-10-15 16:30:22	2010-10-19 19:23:49.72-05
221	1.2.3.4.5.6.7.2541.882	65	Abdomen-100	2010-10-15 16:32:04	2010-10-19 19:26:39.623-05
222	1.2.3.4.5.6.7.64729.5	68	Abdomen-01	2010-10-20 09:10:48	2010-10-20 09:19:36.81-05
223	1.2.3.4.5.6.7.64729.10	69	Abdomen-01	2010-10-20 09:29:05	2010-10-20 09:35:18.874-05
224	1.2.3.4.5.6.7.64729.15	70	Abdomen-01	2010-10-20 10:05:42	2010-10-20 10:11:35.077-05
225	1.2.3.4.5.6.7.64729.20	71	Abdomen-01	2010-10-20 22:09:46	2010-10-20 22:17:32.778-05
226	1.2.3.4.5.6.7.64729.25	72	Abdomen-01	2010-10-20 22:24:22	2010-10-20 22:45:44.856-05
227	1.2.3.4.5.6.7.64729.20	71	Abdomen-01	2010-10-20 22:09:46	2010-10-20 22:46:39.62-05
228	1.2.3.4.5.6.7.64729.30	73	Abdomen-01	2010-10-20 23:02:32	2010-10-20 23:07:05.397-05
229	1.2.3.4.5.6.7.64729.35	74	Abdomen-01	2010-10-20 23:10:27	2010-10-20 23:15:07.402-05
230	1.2.3.4.5.6.7.64729.40	75	Abdomen-01	2010-10-20 23:29:57	2010-10-20 23:35:13.32-05
231	1.2.3.4.5.6.7.64729.45	76	Abdomen-01	2010-10-20 23:45:55	2010-10-20 23:51:28.931-05
232	1.2.3.4.5.6.7.64729.55	78	Abdomen-01	2010-10-21 16:50:40	2010-10-21 16:54:45.119-05
233	1.2.3.4.5.6.7.64729.60	79	Abdomen-01	2010-10-21 21:06:01	2010-10-21 21:44:07.259-05
234	1.2.3.4.5.6.7.64729.65	80	Abdomen-01	2010-10-21 21:52:34	2010-10-21 21:57:24.678-05
235	1.2.3.4.5.6.7.64729.70	81	Abdomen-01	2010-10-21 22:13:29	2010-10-21 22:19:07.112-05
236	1.2.3.4.5.6.7.64729.75	82	Abdomen-01	2010-10-21 22:59:59	2010-10-21 23:06:04.794-05
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY transactions (transaction_id, job_id, status_code, comments, modified_date) FROM stdin;
14419	16	1	Queued	2010-09-28 13:33:18.555-05
14493	19	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14509	20	1	Queued	2010-10-13 10:14:51.1-05
14494	19	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14495	19	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14496	19	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14497	19	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14430	17	1	Queued	2010-10-04 17:16:52.517-05
14464	18	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14461	16	37	Ready to transfer to clearinghouse	2010-10-22 12:05:44.499269-05
14433	18	1	Queued	2010-10-04 17:17:52.262-05
14466	17	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14508	19	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14513	20	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14512	20	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14689	42	23	Started prepare content	2010-10-22 12:53:32.492078-05
14693	43	23	Started prepare content	2010-10-22 12:53:32.492078-05
14698	44	23	Started prepare content	2010-10-22 12:53:32.492078-05
14702	45	23	Started prepare content	2010-10-22 12:53:32.492078-05
14707	46	23	Started prepare content	2010-10-22 12:53:32.492078-05
14712	47	23	Started prepare content	2010-10-22 12:53:32.492078-05
14713	48	23	Started prepare content	2010-10-22 12:53:32.492078-05
14721	49	23	Started prepare content	2010-10-22 12:53:32.492078-05
14604	36	23	Started prepare content	2010-10-22 12:53:32.492078-05
14525	24	23	Started prepare content	2010-10-22 12:53:32.492078-05
14526	25	23	Started prepare content	2010-10-22 12:53:32.492078-05
14539	23	23	Started prepare content	2010-10-22 12:53:32.492078-05
14545	26	23	Started prepare content	2010-10-22 12:53:32.492078-05
14546	27	23	Started prepare content	2010-10-22 12:53:32.492078-05
14608	37	23	Started prepare content	2010-10-22 12:53:32.492078-05
14612	38	23	Started prepare content	2010-10-22 12:53:32.492078-05
14564	29	23	Started prepare content	2010-10-22 12:53:32.492078-05
14566	30	23	Started prepare content	2010-10-22 12:53:32.492078-05
14567	28	23	Started prepare content	2010-10-22 12:53:32.492078-05
14574	31	23	Started prepare content	2010-10-22 12:53:32.492078-05
14580	32	23	Started prepare content	2010-10-22 12:53:32.492078-05
14585	33	23	Started prepare content	2010-10-22 12:53:32.492078-05
14622	39	23	Started prepare content	2010-10-22 12:53:32.492078-05
14592	34	23	Started prepare content	2010-10-22 12:53:32.492078-05
14598	35	23	Started prepare content	2010-10-22 12:53:32.492078-05
14731	51	23	Started prepare content	2010-10-22 12:53:32.492078-05
14736	52	23	Started prepare content	2010-10-22 12:53:32.492078-05
14741	53	23	Started prepare content	2010-10-22 12:53:32.492078-05
14745	54	23	Started prepare content	2010-10-22 12:53:32.492078-05
14750	55	23	Started prepare content	2010-10-22 12:53:32.492078-05
14755	56	23	Started prepare content	2010-10-22 12:53:32.492078-05
14760	57	23	Started prepare content	2010-10-22 12:53:32.492078-05
14765	58	23	Started prepare content	2010-10-22 12:53:32.492078-05
14514	21	1	Queued	2010-10-13 12:40:54.676-05
14517	22	1	Queued	2010-10-13 13:52:20.467-05
14421	16	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14470	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14424	16	30	Ready to transfer to Clearinghouse	2010-10-22 12:03:25.828982-05
14425	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14426	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14603	36	1	Queued	2010-10-14 17:00:16.413-05
14607	37	1	Queued	2010-10-14 17:06:26.823-05
14611	38	1	Queued	2010-10-14 17:23:48.265-05
14621	39	1	Queued	2010-10-15 16:34:15.965-05
14619	38	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14633	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14635	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14639	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14645	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14647	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14649	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14651	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14659	41	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14668	33	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14669	33	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14670	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14692	43	1	Queued	2010-10-20 09:14:25.289-05
14691	42	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14673	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14674	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14675	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14680	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14682	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14684	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14686	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14688	42	1	Queued	2010-10-20 09:05:39.071-05
14695	43	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14700	44	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14704	45	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14697	44	1	Queued	2010-10-20 09:33:05.657-05
14709	46	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14716	48	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14701	45	1	Queued	2010-10-20 10:09:53.463-05
14717	47	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14723	49	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14706	46	1	Queued	2010-10-20 22:14:51.045-05
14661	41	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14685	39	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14710	47	1	Queued	2010-10-20 22:28:20.563-05
14711	48	1	Queued	2010-10-20 22:28:20.701-05
14687	40	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14696	43	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14705	45	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14718	47	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14720	49	1	Queued	2010-10-20 23:06:43.943-05
14719	48	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14724	49	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14725	50	1	Queued	2010-10-20 23:14:26.063-05
14602	35	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14520	23	1	Queued	2010-10-13 14:00:01.169-05
14523	24	1	Queued	2010-10-13 14:11:49.614-05
14524	25	1	Queued	2010-10-13 14:11:49.691-05
14601	35	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14605	36	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14609	37	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14613	38	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14615	38	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14617	38	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14623	39	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14627	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14629	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14631	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14570	29	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14571	30	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14543	26	1	Queued	2010-10-13 15:19:51.531-05
14544	27	1	Queued	2010-10-13 15:19:51.624-05
14572	28	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14578	31	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14552	28	1	Queued	2010-10-13 18:48:30.74-05
14596	34	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14555	29	1	Queued	2010-10-13 18:59:08.01-05
14556	30	1	Queued	2010-10-13 18:59:08.093-05
14630	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14642	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14654	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14660	41	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14573	31	1	Queued	2010-10-14 10:48:12.408-05
14662	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14579	32	1	Queued	2010-10-14 13:11:30.651-05
14664	40	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14666	39	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14733	51	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14584	33	1	Queued	2010-10-14 13:22:31.756-05
14529	25	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14530	25	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14531	25	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14532	25	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14533	25	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14591	34	1	Queued	2010-10-14 14:54:05.242-05
14534	24	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14535	24	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14536	24	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14537	24	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14597	35	1	Queued	2010-10-14 15:43:03.127-05
14538	22	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14541	21	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14542	23	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14624	40	1	Queued	2010-10-15 16:42:01.917-05
14549	26	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14550	27	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14551	27	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14606	36	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14610	37	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14587	32	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14583	32	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14620	38	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14734	51	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14656	41	1	Queued	2010-10-19 13:40:25.867-05
14730	51	1	Queued	2010-10-20 23:34:03.898-05
14527	24	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14528	25	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14540	23	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14547	26	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14548	27	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14614	38	30	Ready to transfer	2010-10-22 12:03:25.828982-05
14616	38	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14565	29	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14568	30	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14569	28	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14575	31	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14576	31	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14577	31	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14735	52	1	Queued	2010-10-20 23:50:04.357-05
14740	53	1	Queued	2010-10-21 16:42:26.324-05
14744	54	1	Queued	2010-10-21 16:54:25.366-05
14749	55	1	Queued	2010-10-21 21:09:36.553-05
14754	56	1	Queued	2010-10-21 21:56:34.489-05
14759	57	1	Queued	2010-10-21 22:18:06.949-05
14738	52	36	Document prepared for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14764	58	1	Queued	2010-10-21 23:05:03.935-05
14747	54	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14427	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14428	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14429	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14432	17	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14435	18	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14436	18	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14437	18	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14440	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14441	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14442	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14443	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14444	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14445	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14446	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14447	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14448	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14449	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14450	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14451	16	30	Ready to transfer to clearinghous	2010-10-22 12:03:25.828982-05
14452	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14453	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14454	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14455	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14456	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14457	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14458	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14459	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14460	16	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14438	18	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14462	18	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14463	18	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14737	52	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14742	53	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14746	54	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14751	55	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14756	56	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14752	55	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14757	56	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14762	57	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14767	58	36	Preparing content for transfer to clearinghouse	2010-10-22 12:05:36.14765-05
14739	52	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14743	53	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14748	54	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14753	55	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14758	56	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14763	57	37	Transferred to clearinghouse	2010-10-22 12:05:44.499269-05
14420	16	23	Started prepare content	2010-10-22 12:53:32.492078-05
14510	20	23	Started prepare content	2010-10-22 12:53:32.492078-05
14431	17	23	Started prepare content	2010-10-22 12:53:32.492078-05
14434	18	23	Started prepare content	2010-10-22 12:53:32.492078-05
14515	21	23	Started prepare content	2010-10-22 12:53:32.492078-05
14518	22	23	Started prepare content	2010-10-22 12:53:32.492078-05
14625	40	23	Started prepare content	2010-10-22 12:53:32.492078-05
14657	41	23	Started prepare content	2010-10-22 12:53:32.492078-05
14439	17	30	Transferred to clearinghouse	2010-10-22 12:03:25.828982-05
14465	17	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14467	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14511	20	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14468	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14469	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14471	19	30	Ready to tranfer to clearinghouse	2010-10-22 12:03:25.828982-05
14472	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14473	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14474	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14475	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14476	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14477	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14478	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14479	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14480	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14481	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14482	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14483	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14484	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14485	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14486	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14487	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14488	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14499	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14489	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14490	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14491	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14492	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14498	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14500	19	30	Ready to transfer to clearninghouse	2010-10-22 12:03:25.828982-05
14501	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14502	19	30	Transferred to clearinghouse	2010-10-22 12:03:25.828982-05
14503	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14504	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14505	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14506	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14507	19	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14516	21	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14519	22	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14637	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14641	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14643	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14653	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14690	42	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14655	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14663	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14590	33	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14665	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14667	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14671	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14672	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14676	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14677	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14678	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14679	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14681	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14683	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14694	43	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14699	44	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14703	45	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14708	46	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14714	47	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14715	48	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14722	49	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14581	32	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14582	32	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14618	38	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14586	33	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14588	33	30	Ready to transfer to	2010-10-22 12:03:25.828982-05
14589	33	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14593	34	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14594	34	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14595	34	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14599	35	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14600	35	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14626	40	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14628	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14632	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14634	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14636	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14638	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14640	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14644	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14646	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14650	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14652	39	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14658	41	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14648	40	30	Ready to transfer to clearinghouse	2010-10-22 12:03:25.828982-05
14732	51	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14761	57	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14766	58	30	Ready to transfer to clearinghouse.	2010-10-22 12:03:25.828982-05
14773	50	23		2010-12-14 13:28:07.69159-06
14774	50	-21	Unable to retrive study from any remote device.	2010-12-14 13:28:09.088928-06
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY users (user_id, user_login, user_name, email, crypted_password, salt, created_at, updated_at, remember_token, remember_token_expires_at, role_id, modified_date) FROM stdin;
2	mwarnock	Max Warnock	mwarnock@umm.edu	a047ae44b02d035279c9ceea96bf423025ed992a	6c2e285bc6568a104281f833b0c3ad3aa67c319f	2010-09-14 13:44:57.442-05	2010-09-14 13:54:41.213-05	\N	\N	2	2010-09-14 08:54:41.186345-05
3	admin	admin	fake@fakey.com	ee4f514bc9e99c110745eb7cd8f4bebdf561d296	57e3276199a2f4d26de6ad4a9a894cd7b7e4d6f1	2010-09-16 18:18:54.645-05	2010-09-16 18:18:54.645-05	\N	\N	2	\N
5	sglanger	steve 	sglanger@nibib-2.wustl.edu	8a786f2a6223980d6622029ef81ac92321272658	ad10d719ccdb56b48672cedce3f911c689b76652	2010-09-16 18:58:29.457-05	2010-09-16 19:00:20.05-05	\N	\N	0	2010-09-16 14:00:20.043517-05
6	femi	Femi Oyesanya	oyesanyf@gmail.com	7847ad71ff43885836c5a4d0cf7df138572f3f12	7fda4f63215675ccc0c192e43214f1f1345248d4	2010-09-16 20:31:42.147-05	2010-09-16 20:31:42.147-05	\N	\N	1	\N
4	wtellis	Wyatt Tellis	wyatt.tellis@ucsf.edu	e7e12ac655784d9910cb6354161a4cf4d21999d7	4539f3ad4ff395479c95755e5f0e90dcea37c98e	2010-09-16 18:24:11.356-05	2010-09-28 13:43:18.389-05	\N	\N	2	2010-09-28 13:43:18.382073-05
7	mdaly	Daly, Mark	mdaly@umm.edu	d1c7af1359d856baf55bbd717b3b232777caa85c	1b598317c926d775e9e00b537971b3283f06ea64	2010-10-13 09:38:49.245-05	2010-10-13 09:39:33.089-05	\N	\N	2	2010-10-13 11:38:12.721709-05
8	wzhu	Zhu, Wendy	wzhu@radiology.bsd.uchicago.edu	06f1a1a07f094e9d689efde53a0e809cdf82f67b	ddf446d9114c24dbf3d0beb7256c074a3fe3bd2d	2010-10-14 15:40:31.157-05	2010-10-14 15:40:31.157-05	\N	\N	2	\N
9	smoore	steve moore	smoore@wustl.edu	6dcc9a4a647120ac75dc0ae39ffe6888fcef8285	2f2dfbd295c07272f5580da43cb059d400d30188	2010-10-14 16:01:19.875-05	2010-10-14 16:01:19.875-05	\N	\N	2	\N
\.


--
-- Name: pk_device_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT pk_device_id PRIMARY KEY (device_id);


--
-- Name: pk_event_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY patient_merge_events
    ADD CONSTRAINT pk_event_id PRIMARY KEY (event_id);


--
-- Name: pk_exam_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT pk_exam_id PRIMARY KEY (exam_id);


--
-- Name: pk_hipaa_audit_accession_number_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY hipaa_audit_accession_numbers
    ADD CONSTRAINT pk_hipaa_audit_accession_number_id PRIMARY KEY (id);


--
-- Name: pk_hipaa_audit_mrn_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY hipaa_audit_mrns
    ADD CONSTRAINT pk_hipaa_audit_mrn_id PRIMARY KEY (id);


--
-- Name: pk_hipaa_audit_view_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY hipaa_audit_views
    ADD CONSTRAINT pk_hipaa_audit_view_id PRIMARY KEY (id);


--
-- Name: pk_job_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT pk_job_id PRIMARY KEY (job_id);


--
-- Name: pk_job_set_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY job_sets
    ADD CONSTRAINT pk_job_set_id PRIMARY KEY (job_set_id);


--
-- Name: pk_key; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY configurations
    ADD CONSTRAINT pk_key PRIMARY KEY (key);


--
-- Name: pk_map_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY patient_rsna_ids
    ADD CONSTRAINT pk_map_id PRIMARY KEY (map_id);


--
-- Name: pk_patient_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT pk_patient_id PRIMARY KEY (patient_id);


--
-- Name: pk_report_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT pk_report_id PRIMARY KEY (report_id);


--
-- Name: pk_role_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT pk_role_id PRIMARY KEY (role_id);


--
-- Name: pk_status_code; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY status_codes
    ADD CONSTRAINT pk_status_code PRIMARY KEY (status_code);


--
-- Name: pk_study_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT pk_study_id PRIMARY KEY (study_id);


--
-- Name: pk_transaction_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT pk_transaction_id PRIMARY KEY (transaction_id);


--
-- Name: pk_user_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT pk_user_id PRIMARY KEY (user_id);


--
-- Name: uq_exam; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT uq_exam UNIQUE (accession_number, patient_id);


--
-- Name: uq_login; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT uq_login UNIQUE (user_login);


--
-- Name: tr_configurations_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_configurations_modified_date
    BEFORE UPDATE ON configurations
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_devices_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_devices_modified_date
    BEFORE UPDATE ON devices
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_exams_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_exams_modified_date
    BEFORE UPDATE ON exams
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_job_sets_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_job_sets_modified_date
    BEFORE UPDATE ON job_sets
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_jobs_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_jobs_modified_date
    BEFORE UPDATE ON jobs
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_patient_merge_events_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_patient_merge_events_modified_date
    BEFORE UPDATE ON patient_merge_events
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_patient_rsna_ids_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_patient_rsna_ids_modified_date
    BEFORE UPDATE ON patient_rsna_ids
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_patients_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_patients_modified_date
    BEFORE UPDATE ON patients
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_reports_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_reports_modified_date
    BEFORE UPDATE ON reports
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_roles_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_roles_modified_date
    BEFORE UPDATE ON roles
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_studies_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_studies_modified_date
    BEFORE UPDATE ON studies
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_transactions_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_transactions_modified_date
    BEFORE UPDATE ON transactions
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: tr_users_modified_date; Type: TRIGGER; Schema: public; Owner: edge
--

CREATE TRIGGER tr_users_modified_date
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE PROCEDURE usp_update_modified_date();


--
-- Name: fk_exam_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT fk_exam_id FOREIGN KEY (exam_id) REFERENCES exams(exam_id);


--
-- Name: fk_exam_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT fk_exam_id FOREIGN KEY (exam_id) REFERENCES exams(exam_id);


--
-- Name: fk_exam_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT fk_exam_id FOREIGN KEY (exam_id) REFERENCES exams(exam_id);


--
-- Name: fk_job_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id);


--
-- Name: fk_job_set_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT fk_job_set_id FOREIGN KEY (job_set_id) REFERENCES job_sets(job_set_id);


--
-- Name: fk_patient_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY job_sets
    ADD CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(patient_id);


--
-- Name: fk_patient_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(patient_id);


--
-- Name: fk_patient_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY patient_rsna_ids
    ADD CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(patient_id);


--
-- Name: fk_report_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT fk_report_id FOREIGN KEY (report_id) REFERENCES reports(report_id);


--
-- Name: fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY job_sets
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

