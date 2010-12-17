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

