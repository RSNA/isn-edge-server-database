--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: rsnadb; Type: DATABASE; Schema: -; Owner: edge
--

CREATE DATABASE rsnadb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE rsnadb OWNER TO edge;

\connect rsnadb

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: rsnadb; Type: COMMENT; Schema: -; Owner: edge
--

COMMENT ON DATABASE rsnadb IS 'RSNA2 Edge Device Database
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

SELECT pg_catalog.setval('exams_exam_id_seq', 91, true);


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

SELECT pg_catalog.setval('hipaa_audit_accession_numbers_id_seq', 331, true);


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

SELECT pg_catalog.setval('hipaa_audit_mrns_id_seq', 2073, true);


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

SELECT pg_catalog.setval('hipaa_audit_views_id_seq', 1440, true);


--
-- Name: job_sets; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE job_sets (
    job_set_id integer NOT NULL,
    patient_id integer NOT NULL,
    user_id integer NOT NULL,
    email_address character varying(255),
    modified_date timestamp with time zone DEFAULT now(),
    delay_in_hrs integer DEFAULT 0,
    single_use_patient_id character varying(64) NOT NULL
);


ALTER TABLE public.job_sets OWNER TO edge;

--
-- Name: TABLE job_sets; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE job_sets IS 'This is one of a pair of tables that bind a patient to a edge device job, consisting of one or more exam accessions descrbing DICOM exams to send to the CH. The other table is JOBS
';


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

SELECT pg_catalog.setval('job_sets_job_set_id_seq', 94, true);


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

SELECT pg_catalog.setval('jobs_job_id_seq', 95, true);


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
    modified_date timestamp with time zone DEFAULT now(),
    consent_timestamp timestamp with time zone
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

SELECT pg_catalog.setval('patients_patient_id_seq', 87, true);


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

SELECT pg_catalog.setval('reports_report_id_seq', 166, true);


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

SELECT pg_catalog.setval('transactions_transaction_id_seq', 15192, true);


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
    SELECT j.job_id, j.exam_id, js.delay_in_hrs, t.status, t.status_message, t.modified_date AS last_transaction_timestamp, js.single_use_patient_id, t.comments FROM ((jobs j JOIN job_sets js ON ((j.job_set_id = js.job_set_id))) JOIN (SELECT t1.job_id, t1.status_code AS status, sc.description AS status_message, t1.comments, t1.modified_date FROM (transactions t1 JOIN status_codes sc ON ((t1.status_code = sc.status_code))) WHERE (t1.modified_date = (SELECT max(t2.modified_date) AS max FROM transactions t2 WHERE (t2.job_id = t1.job_id)))) t ON ((j.job_id = t.job_id)));


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
tmp-dir-path	/rsna/tmp	2010-11-02 09:33:17.413413-05
iti41-source-id	1.3.6.1.4.1.19376.2.840.1.1.2.1	2010-12-20 13:17:12.478876-06
scp-ae-title	RSNA-NIBIB-4	2011-01-10 18:35:16.668828-06
scu-ae-title	RSNA-NIBIB-4	2011-01-10 18:43:13.369949-06
consent-expired-days	90	2011-01-13 12:38:28.356374-06
iti8-pix-uri	mllps://173.35.208.226:8888	2011-01-18 17:28:11.313511-06
iti8-reg-uri	mllps://173.35.208.226:8890	2011-01-18 17:28:41.684491-06
iti41-endpoint-uri-test	http://localhost:8888/	2011-02-03 19:10:33.864317-06
iti41-endpoint-uri	https://173.35.208.226/services/xdsrepositoryb	2011-02-14 11:50:51.109287-06
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
84	IHE759956.1	80	MR Knee	2010-12-20 13:22:34.051404-06
85	IHE759956.2	81	MR Knee	2010-12-20 13:23:17.012515-06
86	IHE722914.6	82	DTI-002	2011-01-10 18:46:55.077574-06
87	IHE722914.7	83	DTI-002	2011-01-10 19:04:12.636615-06
88	IHE722914.8	84	DTI-002	2011-01-11 16:01:44.008232-06
89	IHE502600.0	85	MR Head	2011-01-27 09:07:07.047349-06
90	IHE502600.1	86	MR Head	2011-01-27 09:35:42.268635-06
91	IHE502600.2	87	MR Head	2011-01-27 09:41:01.30479-06
\.


--
-- Data for Name: hipaa_audit_accession_numbers; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY hipaa_audit_accession_numbers (id, view_id, accession_number, modified_date) FROM stdin;
198	846	IHE759956.2	\N
199	848	IHE759956.2	\N
200	851	IHE759956.2	\N
201	866	IHE759956.2	\N
202	875	IHE722914.7	\N
203	879	IHE722914.7	\N
204	883	IHE722914.7	\N
205	884	IHE722914.7	\N
206	885	IHE722914.7	\N
207	889	IHE759956.1	\N
208	891	IHE759956.1	\N
209	895	IHE759956.2	\N
210	899	IHE759956.2	\N
211	903	IHE759956.2	\N
212	905	IHE759956.2	\N
213	914	IHE722914.8	\N
214	916	IHE722914.8	\N
215	922	IHE722914.8	\N
216	926	IHE722914.8	\N
217	928	IHE722914.8	\N
218	947	IHE759956.2	\N
219	949	IHE759956.2	\N
220	952	IHE759956.2	\N
221	958	IHE759956.1	\N
222	960	IHE759956.1	\N
223	963	IHE759956.1	\N
224	975	IHE759956.1	\N
225	977	IHE759956.1	\N
226	980	IHE759956.1	\N
227	987	IHE759956.2	\N
228	989	IHE759956.2	\N
229	992	IHE759956.2	\N
230	995	IHE759956.2	\N
231	1000	IHE759956.2	\N
232	1002	IHE759956.2	\N
233	1005	IHE759956.2	\N
234	1013	IHE759956.1	\N
235	1015	IHE759956.1	\N
236	1018	IHE759956.1	\N
237	1021	IHE759956.1	\N
238	1024	IHE759956.1	\N
239	1027	IHE759956.1	\N
240	1030	IHE759956.1	\N
241	1041	IHE722914.7	\N
242	1042	IHE722914.7	\N
243	1047	IHE722914.8	\N
244	1049	IHE722914.8	\N
245	1052	IHE722914.8	\N
246	1056	IHE722914.8	\N
247	1058	IHE722914.8	\N
248	1061	IHE722914.8	\N
249	1065	IHE722914.8	\N
250	1067	IHE722914.8	\N
251	1071	IHE722914.8	\N
252	1075	IHE759956.1	\N
253	1079	IHE759956.1	\N
254	1081	IHE759956.1	\N
255	1084	IHE759956.1	\N
256	1089	IHE722914.6	\N
257	1091	IHE722914.6	\N
258	1094	IHE722914.6	\N
259	1098	IHE759956.1	\N
260	1102	IHE722914.7	\N
261	1106	IHE722914.6	\N
262	1110	IHE759956.2	\N
263	1117	IHE759956.2	\N
264	1119	IHE759956.2	\N
265	1120	IHE759956.2	\N
266	1122	IHE759956.2	\N
267	1124	IHE759956.2	\N
268	1127	IHE759956.2	\N
269	1132	IHE759956.2	\N
270	1134	IHE759956.2	\N
271	1135	IHE759956.2	\N
272	1140	IHE759956.1	\N
273	1142	IHE759956.1	\N
274	1145	IHE759956.1	\N
275	1147	IHE759956.1	\N
276	1152	IHE722914.7	\N
277	1154	IHE722914.7	\N
278	1157	IHE722914.7	\N
279	1178	IHE759956.1	\N
280	1180	IHE759956.1	\N
281	1183	IHE759956.1	\N
282	1192	IHE722914.6	\N
283	1194	IHE722914.6	\N
284	1197	IHE722914.6	\N
285	1201	IHE759956.1	\N
286	1203	IHE759956.1	\N
287	1209	IHE759956.1	\N
288	1211	IHE759956.1	\N
289	1214	IHE759956.1	\N
290	1220	IHE722914.6	\N
291	1222	IHE722914.6	\N
292	1225	IHE722914.6	\N
293	1230	IHE502600.1	\N
294	1232	IHE502600.1	\N
295	1235	IHE502600.1	\N
296	1241	IHE502600.2	\N
297	1243	IHE502600.2	\N
298	1246	IHE502600.2	\N
299	1251	IHE502600.1	\N
300	1255	IHE759956.1	\N
301	1259	IHE502600.2	\N
302	1266	IHE759956.1	\N
303	1270	IHE759956.1	\N
304	1272	IHE759956.1	\N
305	1275	IHE759956.1	\N
306	1280	IHE759956.1	\N
307	1282	IHE759956.1	\N
308	1285	IHE759956.1	\N
309	1295	IHE502600.2	\N
310	1297	IHE502600.2	\N
311	1300	IHE502600.2	\N
312	1305	IHE502600.2	\N
313	1307	IHE502600.2	\N
314	1310	IHE502600.2	\N
315	1318	IHE502600.1	\N
316	1320	IHE502600.1	\N
317	1323	IHE502600.1	\N
318	1342	IHE502600.1	\N
319	1344	IHE502600.1	\N
320	1347	IHE502600.1	\N
321	1372	IHE502600.1	\N
322	1374	IHE502600.1	\N
323	1396	IHE722914.6	\N
324	1398	IHE722914.6	\N
325	1401	IHE722914.6	\N
326	1412	IHE722914.7	\N
327	1414	IHE722914.7	\N
328	1417	IHE722914.7	\N
329	1424	IHE722914.8	\N
330	1426	IHE722914.8	\N
331	1429	IHE722914.8	\N
\.


--
-- Data for Name: hipaa_audit_mrns; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY hipaa_audit_mrns (id, view_id, mrn, modified_date) FROM stdin;
1719	843	128235611	\N
1720	844	128235611	\N
1721	845	212763672	\N
1722	846	212763672	\N
1723	847	212763672	\N
1724	848	212763672	\N
1725	849	212763672	\N
1726	850	212763672	\N
1727	851	212763672	\N
1728	852	212763672	\N
1729	856	212763672	\N
1730	865	212763672	\N
1731	866	212763672	\N
1732	867	212763672	\N
1733	874	105283367	\N
1734	875	105283367	\N
1735	876	105283367	\N
1736	879	105283367	\N
1737	880	105283367	\N
1738	883	105283367	\N
1739	884	105283367	\N
1740	885	105283367	\N
1741	888	128235611	\N
1742	889	128235611	\N
1743	890	128235611	\N
1744	891	128235611	\N
1745	893	128235611	\N
1746	894	128235611	\N
1747	895	212763672	\N
1748	896	212763672	\N
1749	899	212763672	\N
1750	900	212763672	\N
1751	901	212763672	\N
1752	902	212763672	\N
1753	903	212763672	\N
1754	904	212763672	\N
1755	905	212763672	\N
1756	913	231444323	\N
1757	914	231444323	\N
1758	915	231444323	\N
1759	916	231444323	\N
1760	917	231444323	\N
1761	918	231444323	\N
1762	919	231444323	\N
1763	920	231444323	\N
1764	921	231444323	\N
1765	922	231444323	\N
1766	923	231444323	\N
1767	926	231444323	\N
1768	927	231444323	\N
1769	928	231444323	\N
1770	929	231444323	\N
1771	930	231444323	\N
1772	931	231444323	\N
1773	932	231444323	\N
1774	933	231444323	\N
1775	947	212763672	\N
1776	948	212763672	\N
1777	949	212763672	\N
1778	950	212763672	\N
1779	951	212763672	\N
1780	952	212763672	\N
1781	953	212763672	\N
1782	958	128235611	\N
1783	959	128235611	\N
1784	960	128235611	\N
1785	961	128235611	\N
1786	962	128235611	\N
1787	963	128235611	\N
1788	964	128235611	\N
1789	972	128235611	\N
1790	975	128235611	\N
1791	976	128235611	\N
1792	977	128235611	\N
1793	978	128235611	\N
1794	979	128235611	\N
1795	980	128235611	\N
1796	981	128235611	\N
1797	984	128235611	\N
1798	987	212763672	\N
1799	988	212763672	\N
1800	989	212763672	\N
1801	990	212763672	\N
1802	991	212763672	\N
1803	992	212763672	\N
1804	993	212763672	\N
1805	994	212763672	\N
1806	995	212763672	\N
1807	997	212763672	\N
1808	1000	212763672	\N
1809	1001	212763672	\N
1810	1002	212763672	\N
1811	1003	212763672	\N
1812	1004	212763672	\N
1813	1005	212763672	\N
1814	1006	212763672	\N
1815	1013	128235611	\N
1816	1014	128235611	\N
1817	1015	128235611	\N
1818	1016	128235611	\N
1819	1017	128235611	\N
1820	1018	128235611	\N
1821	1019	128235611	\N
1822	1020	128235611	\N
1823	1021	128235611	\N
1824	1022	128235611	\N
1825	1023	128235611	\N
1826	1024	128235611	\N
1827	1025	128235611	\N
1828	1026	128235611	\N
1829	1027	128235611	\N
1830	1028	128235611	\N
1831	1029	128235611	\N
1832	1030	128235611	\N
1833	1031	128235611	\N
1834	1033	212763672	\N
1835	1041	105283367	\N
1836	1042	105283367	\N
1837	1047	231444323	\N
1838	1048	231444323	\N
1839	1049	231444323	\N
1840	1050	231444323	\N
1841	1051	231444323	\N
1842	1052	231444323	\N
1843	1053	231444323	\N
1844	1056	231444323	\N
1845	1057	231444323	\N
1846	1058	231444323	\N
1847	1059	231444323	\N
1848	1060	231444323	\N
1849	1061	231444323	\N
1850	1062	231444323	\N
1851	1063	231444323	\N
1852	1064	231444323	\N
1853	1065	231444323	\N
1854	1066	231444323	\N
1855	1067	231444323	\N
1856	1068	231444323	\N
1857	1069	231444323	\N
1858	1070	231444323	\N
1859	1071	231444323	\N
1860	1072	231444323	\N
1861	1075	128235611	\N
1862	1076	128235611	\N
1863	1079	128235611	\N
1864	1080	128235611	\N
1865	1081	128235611	\N
1866	1082	128235611	\N
1867	1083	128235611	\N
1868	1084	128235611	\N
1869	1085	128235611	\N
1870	1088	618203196	\N
1871	1089	618203196	\N
1872	1090	618203196	\N
1873	1091	618203196	\N
1874	1092	618203196	\N
1875	1093	618203196	\N
1876	1094	618203196	\N
1877	1095	618203196	\N
1878	1098	128235611	\N
1879	1099	128235611	\N
1880	1102	105283367	\N
1881	1103	105283367	\N
1882	1106	618203196	\N
1883	1107	618203196	\N
1884	1110	212763672	\N
1885	1111	212763672	\N
1886	1116	212763672	\N
1887	1117	212763672	\N
1888	1118	212763672	\N
1889	1119	212763672	\N
1890	1120	212763672	\N
1891	1121	212763672	\N
1892	1122	212763672	\N
1893	1123	212763672	\N
1894	1124	212763672	\N
1895	1125	212763672	\N
1896	1126	212763672	\N
1897	1127	212763672	\N
1898	1128	212763672	\N
1899	1129	212763672	\N
1900	1132	212763672	\N
1901	1133	212763672	\N
1902	1134	212763672	\N
1903	1135	212763672	\N
1904	1136	212763672	\N
1905	1139	128235611	\N
1906	1140	128235611	\N
1907	1141	128235611	\N
1908	1142	128235611	\N
1909	1143	128235611	\N
1910	1144	128235611	\N
1911	1145	128235611	\N
1912	1146	128235611	\N
1913	1147	128235611	\N
1914	1148	128235611	\N
1915	1149	212763672	\N
1916	1150	212763672	\N
1917	1151	105283367	\N
1918	1152	105283367	\N
1919	1153	105283367	\N
1920	1154	105283367	\N
1921	1155	105283367	\N
1922	1156	105283367	\N
1923	1157	105283367	\N
1924	1158	105283367	\N
1925	1177	128235611	\N
1926	1178	128235611	\N
1927	1179	128235611	\N
1928	1180	128235611	\N
1929	1181	128235611	\N
1930	1182	128235611	\N
1931	1183	128235611	\N
1932	1184	128235611	\N
1933	1185	128235611	\N
1934	1191	618203196	\N
1935	1192	618203196	\N
1936	1193	618203196	\N
1937	1194	618203196	\N
1938	1195	618203196	\N
1939	1196	618203196	\N
1940	1197	618203196	\N
1941	1198	618203196	\N
1942	1199	128235611	\N
1943	1200	128235611	\N
1944	1201	128235611	\N
1945	1202	128235611	\N
1946	1203	128235611	\N
1947	1204	128235611	\N
1948	1205	128235611	\N
1949	1206	128235611	\N
1950	1207	128235611	\N
1951	1208	128235611	\N
1952	1209	128235611	\N
1953	1210	128235611	\N
1954	1211	128235611	\N
1955	1212	128235611	\N
1956	1213	128235611	\N
1957	1214	128235611	\N
1958	1215	128235611	\N
1959	1216	128235611	\N
1960	1219	618203196	\N
1961	1220	618203196	\N
1962	1221	618203196	\N
1963	1222	618203196	\N
1964	1223	618203196	\N
1965	1224	618203196	\N
1966	1225	618203196	\N
1967	1226	618203196	\N
1968	1229	399608982	\N
1969	1230	399608982	\N
1970	1231	399608982	\N
1971	1232	399608982	\N
1972	1233	399608982	\N
1973	1234	399608982	\N
1974	1235	399608982	\N
1975	1236	399608982	\N
1976	1237	399608982	\N
1977	1240	380428614	\N
1978	1241	380428614	\N
1979	1242	380428614	\N
1980	1243	380428614	\N
1981	1244	380428614	\N
1982	1245	380428614	\N
1983	1246	380428614	\N
1984	1247	380428614	\N
1985	1248	618203196	\N
1986	1251	399608982	\N
1987	1252	399608982	\N
1988	1255	128235611	\N
1989	1256	128235611	\N
1990	1259	380428614	\N
1991	1260	380428614	\N
1992	1265	128235611	\N
1993	1266	128235611	\N
1994	1267	128235611	\N
1995	1270	128235611	\N
1996	1271	128235611	\N
1997	1272	128235611	\N
1998	1273	128235611	\N
1999	1274	128235611	\N
2000	1275	128235611	\N
2001	1276	128235611	\N
2002	1277	128235611	\N
2003	1280	128235611	\N
2004	1281	128235611	\N
2005	1282	128235611	\N
2006	1283	128235611	\N
2007	1284	128235611	\N
2008	1285	128235611	\N
2009	1286	128235611	\N
2010	1294	380428614	\N
2011	1295	380428614	\N
2012	1296	380428614	\N
2013	1297	380428614	\N
2014	1298	380428614	\N
2015	1299	380428614	\N
2016	1300	380428614	\N
2017	1301	380428614	\N
2018	1302	380428614	\N
2019	1305	380428614	\N
2020	1306	380428614	\N
2021	1307	380428614	\N
2022	1308	380428614	\N
2023	1309	380428614	\N
2024	1310	380428614	\N
2025	1311	380428614	\N
2026	1317	399608982	\N
2027	1318	399608982	\N
2028	1319	399608982	\N
2029	1320	399608982	\N
2030	1321	399608982	\N
2031	1322	399608982	\N
2032	1323	399608982	\N
2033	1324	399608982	\N
2034	1325	399608982	\N
2035	1341	399608982	\N
2036	1342	399608982	\N
2037	1343	399608982	\N
2038	1344	399608982	\N
2039	1345	399608982	\N
2040	1346	399608982	\N
2041	1347	399608982	\N
2042	1348	399608982	\N
2043	1349	399608982	\N
2044	1372	399608982	\N
2045	1373	399608982	\N
2046	1374	399608982	\N
2047	1375	399608982	\N
2048	1376	399608982	\N
2049	1395	618203196	\N
2050	1396	618203196	\N
2051	1397	618203196	\N
2052	1398	618203196	\N
2053	1399	618203196	\N
2054	1400	618203196	\N
2055	1401	618203196	\N
2056	1402	618203196	\N
2057	1411	105283367	\N
2058	1412	105283367	\N
2059	1413	105283367	\N
2060	1414	105283367	\N
2061	1415	105283367	\N
2062	1416	105283367	\N
2063	1417	105283367	\N
2064	1418	105283367	\N
2065	1420	105283367	\N
2066	1423	231444323	\N
2067	1424	231444323	\N
2068	1425	231444323	\N
2069	1426	231444323	\N
2070	1427	231444323	\N
2071	1428	231444323	\N
2072	1429	231444323	\N
2073	1430	231444323	\N
\.


--
-- Data for Name: hipaa_audit_views; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY hipaa_audit_views (id, requesting_ip, requesting_username, requesting_uri, modified_date) FROM stdin;
843	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-11 14:24:41-06
844	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-11 14:24:49-06
845	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=81&commit=Yes	2011-01-11 14:24:55-06
846	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81	2011-01-11 14:24:55-06
847	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=85	2011-01-11 14:24:59-06
848	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-11 14:25:01-06
849	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=QqtTiA6z8tC4oohRFn1fF%2BJWpMGioD31ItBKsUhGh3s%3D&exam_ids%5B%5D=85&patient_password=asdf&patient_password_confirmation=asdf&email=mwarnock%40umm.edu	2011-01-11 14:25:20-06
850	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=QqtTiA6z8tC4oohRFn1fF%2BJWpMGioD31ItBKsUhGh3s%3D&exam_ids%5B%5D=85&patient_password=asdf&patient_password_confirmation=asdf&email=mwarnock%40umm.edu	2011-01-11 14:25:20-06
851	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81&token=bogus	2011-01-11 14:25:29-06
852	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=bogus	2011-01-11 14:25:30-06
853	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-01-11 14:28:51-06
854	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14787	2011-01-11 14:30:57-06
855	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14798	2011-01-11 14:31:10-06
856	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-11 14:32:10-06
857	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-11 14:32:10-06
858	0:0:0:0:0:0:0:1	wtellis	/	2011-01-11 16:02:08-06
859	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-11 16:02:32-06
860	0:0:0:0:0:0:0:1	wtellis	/patients/new/	2011-01-11 16:02:35-06
861	0:0:0:0:0:0:0:1	wtellis	/	2011-01-11 16:02:35-06
862	0:0:0:0:0:0:0:1	wtellis	/patients/new/	2011-01-11 16:02:36-06
863	0:0:0:0:0:0:0:1	wtellis	/	2011-01-11 16:02:37-06
864	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-11 16:02:37-06
865	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=81&commit=Yes	2011-01-11 16:02:44-06
866	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-11 16:02:45-06
867	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-11 16:02:48-06
868	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-11 16:02:49-06
869	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=two&search_type=simple	2011-01-11 16:03:41-06
870	0:0:0:0:0:0:0:1	wtellis	/	2011-01-11 16:03:57-06
871	0:0:0:0:0:0:0:1	sglanger	/	2011-01-12 09:03:32-06
872	0:0:0:0:0:0:0:1	sglanger	/patients/search?search=&search_type=simple	2011-01-12 09:03:58-06
873	0:0:0:0:0:0:0:1	sglanger	/patients/search?search=a&search_type=simple	2011-01-12 09:04:06-06
874	0:0:0:0:0:0:0:1	sglanger	/patients/record_consent?patient_id=83&commit=Yes	2011-01-12 09:04:57-06
875	0:0:0:0:0:0:0:1	sglanger	/exams	2011-01-12 09:04:58-06
876	0:0:0:0:0:0:0:1	sglanger	/patients/new	2011-01-12 09:05:12-06
877	0:0:0:0:0:0:0:1	sglanger	/	2011-01-12 09:05:12-06
878	0:0:0:0:0:0:0:1	sglanger	/patients/search?search=a&search_type=simple	2011-01-12 09:05:17-06
879	0:0:0:0:0:0:0:1	sglanger	/exams?patient_id=83	2011-01-12 09:05:44-06
880	0:0:0:0:0:0:0:1	sglanger	/patients/new	2011-01-12 09:05:52-06
881	0:0:0:0:0:0:0:1	sglanger	/	2011-01-12 09:05:53-06
882	0:0:0:0:0:0:0:1	sglanger	/patients/search?search=a&search_type=simple	2011-01-12 09:05:59-06
883	0:0:0:0:0:0:0:1	sglanger	/exams?patient_id=83	2011-01-12 09:06:05-06
884	0:0:0:0:0:0:0:1	sglanger	/exams	2011-01-12 09:06:16-06
885	0:0:0:0:0:0:0:1	sglanger	/exams	2011-01-12 09:06:25-06
886	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-12 11:26:18-06
887	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-12 11:26:22-06
888	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=80&commit=Yes	2011-01-12 11:26:51-06
889	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-12 11:26:52-06
890	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=84	2011-01-12 11:26:55-06
891	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-12 11:26:57-06
892	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-01-12 11:27:06-06
893	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-12 11:45:32-06
894	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-12 11:45:52-06
895	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81	2011-01-12 11:46:05-06
896	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-12 11:46:20-06
897	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-12 11:46:21-06
898	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-12 11:46:25-06
899	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81	2011-01-12 11:46:27-06
900	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-12 12:07:13-06
901	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-12 12:07:13-06
902	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-12 12:07:19-06
903	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81	2011-01-12 12:07:27-06
904	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=85	2011-01-12 12:07:31-06
905	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-12 12:07:34-06
906	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-01-12 12:07:41-06
907	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14801	2011-01-12 12:07:45-06
908	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14802	2011-01-12 12:07:51-06
909	0:0:0:0:0:0:0:1	mwarnock	/admin/audit_details?id=14789	2011-01-12 12:07:55-06
910	0:0:0:0:0:0:0:1	wtellis	/	2011-01-12 12:49:25-06
911	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=&search_type=simple	2011-01-12 12:49:30-06
912	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-12 12:49:33-06
913	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=84&commit=Yes	2011-01-12 12:49:39-06
914	0:0:0:0:0:0:0:1	wtellis	/exams	2011-01-12 12:49:40-06
915	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=88	2011-01-12 12:49:44-06
916	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-12 12:49:50-06
917	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=N8ZNSzm4Qe6VbKFdfyRPZPEQ6wnp21GCME%2BIz2d8CRU%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 12:50:11-06
918	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=N8ZNSzm4Qe6VbKFdfyRPZPEQ6wnp21GCME%2BIz2d8CRU%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 12:50:28-06
919	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=N8ZNSzm4Qe6VbKFdfyRPZPEQ6wnp21GCME%2BIz2d8CRU%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 12:50:38-06
920	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=N8ZNSzm4Qe6VbKFdfyRPZPEQ6wnp21GCME%2BIz2d8CRU%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 12:52:26-06
989	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-14 18:18:04-06
1058	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-21 10:19:44-06
921	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=N8ZNSzm4Qe6VbKFdfyRPZPEQ6wnp21GCME%2BIz2d8CRU%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 12:52:27-06
922	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84&token=bogus	2011-01-12 12:52:49-06
923	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=bogus	2011-01-12 12:52:51-06
924	0:0:0:0:0:0:0:1	wtellis	/	2011-01-12 17:43:36-06
925	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-12 17:43:41-06
926	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84	2011-01-12 17:43:44-06
927	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=88	2011-01-12 17:43:47-06
928	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-12 17:43:49-06
929	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=Z1uCIzBRG7%2Bl5nFEq%2BgfRTapp4TJtuOh9OAlj8Dqqg0%3D&exam_ids%5B%5D=88&patient_password=wtellis1234&patient_password_confirmation=wtellis1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 17:44:04-06
930	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=Z1uCIzBRG7%2Bl5nFEq%2BgfRTapp4TJtuOh9OAlj8Dqqg0%3D&exam_ids%5B%5D=88&patient_password=wtellis1234&patient_password_confirmation=wtellis1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 17:45:23-06
931	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=Z1uCIzBRG7%2Bl5nFEq%2BgfRTapp4TJtuOh9OAlj8Dqqg0%3D&exam_ids%5B%5D=88&patient_password=wtellis1234&patient_password_confirmation=wtellis1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 17:45:43-06
932	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=Z1uCIzBRG7%2Bl5nFEq%2BgfRTapp4TJtuOh9OAlj8Dqqg0%3D&exam_ids%5B%5D=88&patient_password=wtellis1234&patient_password_confirmation=wtellis1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 17:47:40-06
933	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=Z1uCIzBRG7%2Bl5nFEq%2BgfRTapp4TJtuOh9OAlj8Dqqg0%3D&exam_ids%5B%5D=88&patient_password=wtellis1234&patient_password_confirmation=wtellis1234&email=wyatt.tellis%40ucsf.edu	2011-01-12 17:47:41-06
934	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-13 16:53:49-06
935	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-13 16:53:54-06
936	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-01-13 16:53:57-06
937	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-01-13 16:53:59-06
938	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-13 16:55:03-06
939	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-13 16:55:04-06
940	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-01-13 17:12:37-06
941	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-01-13 17:12:40-06
942	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-01-13 17:15:34-06
943	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-01-13 17:16:09-06
944	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-01-13 17:16:56-06
945	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-13 17:45:25-06
946	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-13 17:45:36-06
947	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81	2011-01-13 17:45:40-06
948	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=85	2011-01-13 17:45:42-06
949	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-13 17:45:44-06
950	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=eHXMlUdn5aakwWYRuLiYpz3iTQY78EQhNaNppobyo8I%3D&exam_ids%5B%5D=85&patient_password=testit&patient_password_confirmation=testit&email=mwarnock%40umm.edu	2011-01-13 17:46:03-06
951	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=eHXMlUdn5aakwWYRuLiYpz3iTQY78EQhNaNppobyo8I%3D&exam_ids%5B%5D=85&patient_password=testit&patient_password_confirmation=testit&email=mwarnock%40umm.edu	2011-01-13 17:46:04-06
952	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81&token=bqx6kj7z	2011-01-13 17:46:08-06
953	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=bqx6kj7z	2011-01-13 17:46:10-06
954	0:0:0:0:0:0:0:1	wtellis	/	2011-01-14 17:47:24-06
955	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=&search_type=simple	2011-01-14 17:47:28-06
956	0:0:0:0:0:0:0:1	wtellis	/	2011-01-14 17:48:22-06
957	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-14 17:49:05-06
958	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80	2011-01-14 17:49:12-06
959	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=84	2011-01-14 17:49:16-06
960	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-14 17:49:23-06
961	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 17:49:38-06
962	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 17:49:39-06
963	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80&token=u4ppkwbc	2011-01-14 17:49:42-06
964	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=u4ppkwbc	2011-01-14 17:49:44-06
965	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-14 17:50:32-06
966	0:0:0:0:0:0:0:1	wtellis	/tail	2011-01-14 17:51:25-06
967	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-14 17:54:14-06
968	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=14838	2011-01-14 17:54:25-06
969	0:0:0:0:0:0:0:1	wtellis	/tail	2011-01-14 18:11:36-06
970	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-14 18:11:40-06
971	0:0:0:0:0:0:0:1	wtellis	/tail	2011-01-14 18:11:49-06
972	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-14 18:12:15-06
973	0:0:0:0:0:0:0:1	wtellis	/	2011-01-14 18:12:15-06
974	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-14 18:12:21-06
975	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80	2011-01-14 18:12:25-06
976	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=84	2011-01-14 18:12:32-06
977	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-14 18:12:34-06
978	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 18:12:50-06
979	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 18:12:50-06
980	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80&token=wwr68rcs	2011-01-14 18:12:55-06
981	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=wwr68rcs	2011-01-14 18:12:57-06
982	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-14 18:13:06-06
983	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-14 18:14:47-06
984	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-14 18:17:49-06
985	0:0:0:0:0:0:0:1	wtellis	/	2011-01-14 18:17:50-06
986	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=two&search_type=simple	2011-01-14 18:17:55-06
987	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=81	2011-01-14 18:17:58-06
988	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=85	2011-01-14 18:18:02-06
990	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=85&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 18:18:20-06
991	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=85&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 18:18:20-06
992	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=81&token=fy78xihc	2011-01-14 18:18:23-06
993	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=fy78xihc	2011-01-14 18:18:24-06
994	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=85	2011-01-14 18:19:09-06
995	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-14 18:19:13-06
996	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-14 18:19:19-06
997	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-14 18:26:30-06
998	0:0:0:0:0:0:0:1	wtellis	/	2011-01-14 18:26:30-06
999	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=212763672&search_type=simple	2011-01-14 18:26:33-06
1000	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=81	2011-01-14 18:26:36-06
1001	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=85	2011-01-14 18:26:38-06
1002	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-14 18:26:42-06
1003	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=85&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 18:26:55-06
1004	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=VYqp9wQN7qQaE0s1xahfhkPIel08WJELpQuIK3BMWE8%3D&exam_ids%5B%5D=85&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-14 18:26:55-06
1005	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=81&token=yswe6ohf	2011-01-14 18:26:57-06
1006	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=yswe6ohf	2011-01-14 18:26:59-06
1007	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-14 18:27:06-06
1008	0:0:0:0:0:0:0:1	wtellis	/	2011-01-18 12:39:04-06
1009	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-18 12:39:18-06
1010	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-18 12:42:26-06
1011	0:0:0:0:0:0:0:1	wtellis	/	2011-01-18 12:42:27-06
1012	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-18 12:42:32-06
1013	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80	2011-01-18 12:42:33-06
1014	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=84	2011-01-18 12:42:38-06
1015	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-18 12:42:39-06
1016	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=5KeeBlWuVCQQV0vw5ccImuDdy8voM3r1x8kIvAnp6fE%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-18 12:42:52-06
1017	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=5KeeBlWuVCQQV0vw5ccImuDdy8voM3r1x8kIvAnp6fE%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-18 12:42:52-06
1018	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80&token=tqxk7rxd	2011-01-18 13:01:58-06
1019	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=tqxk7rxd	2011-01-18 13:01:59-06
1020	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=84	2011-01-18 14:00:40-06
1021	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-18 14:00:42-06
1022	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=5KeeBlWuVCQQV0vw5ccImuDdy8voM3r1x8kIvAnp6fE%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-01-18 14:00:53-06
1023	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=5KeeBlWuVCQQV0vw5ccImuDdy8voM3r1x8kIvAnp6fE%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-01-18 14:00:53-06
1024	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80&token=jmz3qry7	2011-01-18 14:00:55-06
1025	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=jmz3qry7	2011-01-18 14:00:57-06
1026	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=84	2011-01-18 18:16:59-06
1027	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-18 18:17:01-06
1028	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=5KeeBlWuVCQQV0vw5ccImuDdy8voM3r1x8kIvAnp6fE%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-18 18:17:13-06
1029	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=5KeeBlWuVCQQV0vw5ccImuDdy8voM3r1x8kIvAnp6fE%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-18 18:17:14-06
1030	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80&token=oaiyootc	2011-01-18 18:17:16-06
1031	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=oaiyootc	2011-01-18 18:17:18-06
1032	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-18 18:20:02-06
1033	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-19 09:01:56-06
1034	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-01-19 09:02:01-06
1035	0:0:0:0:0:0:0:1	wtellis	/	2011-01-19 20:32:40-06
1036	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-20 09:16:53-06
1037	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-20 09:17:03-06
1038	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-20 09:17:04-06
1039	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-20 09:17:36-06
1040	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-20 09:17:41-06
1041	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=83	2011-01-20 09:17:44-06
1042	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-20 09:17:49-06
1043	0:0:0:0:0:0:0:1	wtellis	/	2011-01-20 09:42:31-06
1044	0:0:0:0:0:0:0:1	wtellis	/	2011-01-20 09:42:38-06
1045	0:0:0:0:0:0:0:1	wtellis	/	2011-01-20 10:28:44-06
1046	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-20 10:28:50-06
1047	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84	2011-01-20 10:28:54-06
1048	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=88	2011-01-20 10:28:57-06
1049	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-20 10:28:58-06
1050	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=g%2FWL%2FlH%2BLJFV1pHoNmU3ICR1xsjoueZYu91TV%2BJ0JeA%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-20 10:29:12-06
1051	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=g%2FWL%2FlH%2BLJFV1pHoNmU3ICR1xsjoueZYu91TV%2BJ0JeA%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-20 10:29:13-06
1052	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84&token=pacjpjj6	2011-01-20 10:31:39-06
1053	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=pacjpjj6	2011-01-20 10:31:40-06
1054	0:0:0:0:0:0:0:1	wtellis	/	2011-01-21 10:18:24-06
1055	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-21 10:18:30-06
1056	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84	2011-01-21 10:18:33-06
1057	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=88	2011-01-21 10:18:36-06
1059	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=%2FVDRFePuPw4lY9MHZ3uhYvchywukq8k7Q1AQ64wknGQ%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-21 10:19:58-06
1060	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=%2FVDRFePuPw4lY9MHZ3uhYvchywukq8k7Q1AQ64wknGQ%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-21 10:19:58-06
1061	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84&token=1sjnjrea	2011-01-21 10:20:08-06
1062	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=1sjnjrea	2011-01-21 10:20:09-06
1063	0:0:0:0:0:0:0:1	wtellis	/	2011-01-21 10:44:42-06
1064	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-21 10:44:48-06
1065	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84	2011-01-21 10:44:51-06
1066	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=88	2011-01-21 10:44:55-06
1067	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-21 10:44:57-06
1068	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=%2FVDRFePuPw4lY9MHZ3uhYvchywukq8k7Q1AQ64wknGQ%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=%E2%97%8F%E2%97%8F%E2%97%8F%E2%97%8F%E2%97%8F%E2%97%8F%E2%97%8F%E2%97%8F&email=wyatt.tellis%40ucsf.edu	2011-01-21 10:45:11-06
1069	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=%2FVDRFePuPw4lY9MHZ3uhYvchywukq8k7Q1AQ64wknGQ%3D&exam_ids%5B%5D=88&patient_password=cal4ever&patient_password_confirmation=cal4ever&email=wyatt.tellis%40ucsf.edu	2011-01-21 10:45:22-06
1070	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=%2FVDRFePuPw4lY9MHZ3uhYvchywukq8k7Q1AQ64wknGQ%3D&exam_ids%5B%5D=88&patient_password=cal4ever&patient_password_confirmation=cal4ever&email=wyatt.tellis%40ucsf.edu	2011-01-21 10:45:23-06
1071	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84&token=if5kpth7	2011-01-21 10:45:25-06
1072	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=if5kpth7	2011-01-21 10:45:27-06
1073	0:0:0:0:0:0:0:1	wtellis	/	2011-01-22 09:22:23-06
1074	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-22 09:22:29-06
1075	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80	2011-01-22 09:22:32-06
1076	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-22 09:22:45-06
1077	0:0:0:0:0:0:0:1	wtellis	/	2011-01-22 09:22:46-06
1078	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-22 09:22:54-06
1079	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80	2011-01-22 09:22:56-06
1080	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=84	2011-01-22 09:22:58-06
1081	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-22 09:23:04-06
1082	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=HLm0UNmCjmGOHWB78t6sNR4%2Bd32bRBdgLI4bwQLXddk%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-22 09:23:18-06
1083	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=HLm0UNmCjmGOHWB78t6sNR4%2Bd32bRBdgLI4bwQLXddk%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-22 09:23:19-06
1084	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80&token=mzz3zf5x	2011-01-22 09:23:21-06
1085	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=mzz3zf5x	2011-01-22 09:23:22-06
1086	0:0:0:0:0:0:0:1	wtellis	/	2011-01-24 11:53:29-06
1087	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-24 11:53:41-06
1088	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=82&commit=Yes	2011-01-24 11:54:16-06
1089	0:0:0:0:0:0:0:1	wtellis	/exams	2011-01-24 11:54:17-06
1090	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=86	2011-01-24 11:54:20-06
1091	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-24 11:54:21-06
1092	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=Vo7S6QPXdvpt2UnEJfcU1aROSePOUoFbBV4OKAEy7cc%3D&exam_ids%5B%5D=86&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-24 11:54:34-06
1093	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=Vo7S6QPXdvpt2UnEJfcU1aROSePOUoFbBV4OKAEy7cc%3D&exam_ids%5B%5D=86&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-24 11:54:35-06
1094	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=82&token=nyf9xf3a	2011-01-24 11:54:41-06
1095	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=nyf9xf3a	2011-01-24 11:54:42-06
1096	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:19:05-06
1097	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:19:17-06
1098	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80	2011-01-25 13:19:28-06
1099	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-25 13:19:31-06
1100	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:19:32-06
1101	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:19:39-06
1102	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=83	2011-01-25 13:19:41-06
1103	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-25 13:19:43-06
1104	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:19:43-06
1105	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:19:48-06
1106	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=82	2011-01-25 13:19:51-06
1107	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-25 13:19:53-06
1108	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:19:53-06
1109	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:19:56-06
1110	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81	2011-01-25 13:20:11-06
1111	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-25 13:20:14-06
1112	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:20:14-06
1113	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:20:21-06
1114	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:21:20-06
1115	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:21:23-06
1116	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=81&commit=Yes	2011-01-25 13:21:34-06
1117	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-25 13:21:34-06
1118	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=85	2011-01-25 13:21:40-06
1119	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-25 13:21:44-06
1120	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-25 13:21:47-06
1121	0:0:0:0:0:0:0:1	mwarnock	/exams/delete_from_cart?id=85	2011-01-25 13:21:49-06
1122	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-25 13:21:51-06
1123	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=85	2011-01-25 13:23:51-06
1124	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-25 13:23:53-06
1125	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=85&patient_password=asdf&patient_password_confirmation=asdf&email=mwarnock%40umm.edu	2011-01-25 13:24:29-06
1126	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=85&patient_password=asdf&patient_password_confirmation=asdf&email=mwarnock%40umm.edu	2011-01-25 13:24:30-06
1127	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81&token=xfp4ks59	2011-01-25 13:24:36-06
1128	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=xfp4ks59	2011-01-25 13:24:36-06
1129	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-25 13:25:07-06
1130	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:25:08-06
1131	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:25:20-06
1132	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=81	2011-01-25 13:25:22-06
1133	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=85	2011-01-25 13:25:47-06
1134	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-25 13:26:11-06
1135	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-25 13:27:33-06
1136	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-25 13:34:33-06
1137	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-25 13:34:33-06
1138	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-25 13:36:18-06
1139	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=80&commit=Yes	2011-01-25 13:36:21-06
1140	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-25 13:36:22-06
1141	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=84	2011-01-25 13:36:24-06
1142	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-25 13:36:25-06
1143	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-25 13:36:29-06
1144	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-25 13:36:30-06
1145	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80&token=89u3yfz8	2011-01-25 13:36:31-06
1146	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=89u3yfz8	2011-01-25 13:36:32-06
1147	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80&token=89u3yfz8	2011-01-25 13:37:06-06
1148	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=89u3yfz8	2011-01-25 13:37:08-06
1149	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-26 13:46:11-06
1150	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-26 13:46:16-06
1151	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=83&commit=Yes	2011-01-26 13:46:18-06
1152	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-26 13:46:19-06
1153	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=87	2011-01-26 13:46:23-06
1154	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-26 13:46:25-06
1155	0:0:0:0:0:0:0:1	mwarnock	/exams/delete_from_cart?id=87	2011-01-26 13:46:32-06
1156	0:0:0:0:0:0:0:1	mwarnock	/exams/empty_cart	2011-01-26 13:46:34-06
1157	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-26 13:46:35-06
1158	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-26 13:46:37-06
1159	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-26 13:46:38-06
1160	0:0:0:0:0:0:0:1	mwarnock	/patients/search?mrn=0&rsna_id=&patient_name=&search_type=advanced	2011-01-26 13:46:45-06
1161	0:0:0:0:0:0:0:1	mwarnock	/patients/search?mrn=&rsna_id=asdf&patient_name=&search_type=advanced	2011-01-26 13:47:31-06
1162	0:0:0:0:0:0:0:1	mwarnock	/patients/search?mrn=asdf&rsna_id=&patient_name=&search_type=advanced	2011-01-26 13:47:42-06
1163	0:0:0:0:0:0:0:1	mwarnock	/patients/search?mrn=&rsna_id=&patient_name=a&search_type=advanced	2011-01-26 13:47:48-06
1164	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-26 13:47:57-06
1165	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-26 13:51:20-06
1166	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-26 13:51:40-06
1167	0:0:0:0:0:0:0:1	mwarnock	/patients/search?mrn=12&patient_name=&search_type=advanced	2011-01-26 13:52:06-06
1168	0:0:0:0:0:0:0:1	mwarnock	/patients/search?mrn=&patient_name=one&search_type=advanced	2011-01-26 13:52:16-06
1169	0:0:0:0:0:0:0:1	wtellis	/	2011-01-26 21:58:28-06
1170	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-26 21:58:34-06
1171	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-26 22:02:52-06
1172	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-01-26 22:04:16-06
1173	0:0:0:0:0:0:0:1	wtellis	/admin/audit_filter?filter=test	2011-01-26 22:05:08-06
1174	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-26 22:05:18-06
1175	0:0:0:0:0:0:0:1	wtellis	/	2011-01-26 22:05:18-06
1176	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-26 22:05:22-06
1177	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=80&commit=Yes	2011-01-26 22:05:29-06
1178	0:0:0:0:0:0:0:1	wtellis	/exams	2011-01-26 22:05:29-06
1179	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=84	2011-01-26 22:05:38-06
1180	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-26 22:05:41-06
1181	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=Tx%2F2opSQ6arfCtPF1l8%2BxdJlB%2FZqe57aAKET3XEOxE0%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-26 22:06:03-06
1182	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=Tx%2F2opSQ6arfCtPF1l8%2BxdJlB%2FZqe57aAKET3XEOxE0%3D&exam_ids%5B%5D=84&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-26 22:06:04-06
1183	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=80&token=5jgpurr4	2011-01-26 22:06:06-06
1184	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=5jgpurr4	2011-01-26 22:06:07-06
1185	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-26 22:07:39-06
1186	0:0:0:0:0:0:0:1	wtellis	/	2011-01-26 22:07:40-06
1187	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-26 22:07:45-06
1188	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-26 22:07:51-06
1189	0:0:0:0:0:0:0:1	wtellis	/	2011-01-26 22:10:49-06
1190	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-01-26 22:10:55-06
1191	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=82&commit=Yes	2011-01-26 22:10:59-06
1192	0:0:0:0:0:0:0:1	wtellis	/exams	2011-01-26 22:11:00-06
1193	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=86	2011-01-26 22:11:03-06
1194	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-26 22:11:05-06
1195	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=Tx%2F2opSQ6arfCtPF1l8%2BxdJlB%2FZqe57aAKET3XEOxE0%3D&exam_ids%5B%5D=86&patient_password=test4567&patient_password_confirmation=test4567&email=wyatt.tellis%40ucsf.edu	2011-01-26 22:11:32-06
1196	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=Tx%2F2opSQ6arfCtPF1l8%2BxdJlB%2FZqe57aAKET3XEOxE0%3D&exam_ids%5B%5D=86&patient_password=test4567&patient_password_confirmation=test4567&email=wyatt.tellis%40ucsf.edu	2011-01-26 22:11:34-06
1197	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=82&token=u9nx8oj3	2011-01-26 22:11:36-06
1198	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=u9nx8oj3	2011-01-26 22:11:38-06
1199	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-27 08:20:17-06
1200	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-27 08:20:21-06
1201	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80	2011-01-27 08:20:32-06
1202	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=84	2011-01-27 08:20:37-06
1203	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-27 08:20:38-06
1204	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-27 08:20:47-06
1205	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-27 08:20:48-06
1206	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-27 08:50:13-06
1207	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=one&search_type=simple	2011-01-27 08:50:18-06
1208	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=80&commit=Yes	2011-01-27 08:50:23-06
1209	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-27 08:50:24-06
1210	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=84	2011-01-27 08:50:26-06
1211	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-27 08:50:27-06
1212	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-27 08:50:40-06
1213	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-27 08:50:41-06
1214	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80&token=az8xj31c	2011-01-27 08:52:03-06
1215	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=az8xj31c	2011-01-27 08:52:04-06
1216	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-27 08:52:10-06
1217	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-27 08:52:11-06
1218	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=large&search_type=simple	2011-01-27 08:52:14-06
1219	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=82&commit=Yes	2011-01-27 08:52:20-06
1220	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-27 08:52:20-06
1221	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=86	2011-01-27 08:52:22-06
1222	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-27 08:52:24-06
1223	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=86&patient_password=password&patient_password_confirmation=password&email=	2011-01-27 08:52:34-06
1224	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=rZg%2F0t31kYwYthCwfGp5sD69GCwVxF1t704ZcA5NYgw%3D&exam_ids%5B%5D=86&patient_password=password&patient_password_confirmation=password&email=	2011-01-27 08:52:35-06
1225	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=82&token=fqzht8ue	2011-01-27 08:54:38-06
1226	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=fqzht8ue	2011-01-27 08:54:39-06
1227	0:0:0:0:0:0:0:1	wtellis	/	2011-01-27 09:35:59-06
1228	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=MRI&search_type=simple	2011-01-27 09:36:04-06
1229	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=86&commit=Yes	2011-01-27 09:36:10-06
1230	0:0:0:0:0:0:0:1	wtellis	/exams	2011-01-27 09:36:11-06
1231	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=90	2011-01-27 09:38:28-06
1232	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-27 09:38:30-06
1233	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=0DS7AbXrdl%2B02B0eUFY8KSgbdsD4HSkZSHMHQVt1ZOQ%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-27 09:38:45-06
1234	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=0DS7AbXrdl%2B02B0eUFY8KSgbdsD4HSkZSHMHQVt1ZOQ%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-27 09:38:46-06
1235	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=86&token=83u7ri5y	2011-01-27 09:38:49-06
1236	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=83u7ri5y	2011-01-27 09:38:51-06
1237	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-01-27 09:41:16-06
1238	0:0:0:0:0:0:0:1	wtellis	/	2011-01-27 09:41:17-06
1239	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-01-27 09:41:21-06
1240	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=87&commit=Yes	2011-01-27 09:41:36-06
1241	0:0:0:0:0:0:0:1	wtellis	/exams	2011-01-27 09:41:37-06
1242	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=91	2011-01-27 09:41:43-06
1243	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-01-27 09:41:45-06
1244	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=0DS7AbXrdl%2B02B0eUFY8KSgbdsD4HSkZSHMHQVt1ZOQ%3D&exam_ids%5B%5D=91&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-27 09:42:01-06
1245	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=0DS7AbXrdl%2B02B0eUFY8KSgbdsD4HSkZSHMHQVt1ZOQ%3D&exam_ids%5B%5D=91&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-01-27 09:42:02-06
1246	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=87&token=cu9mafj1	2011-01-27 09:42:04-06
1247	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=cu9mafj1	2011-01-27 09:42:06-06
1248	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-27 12:11:56-06
1249	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-27 12:11:57-06
1250	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=test&search_type=simple	2011-01-27 12:12:07-06
1251	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=86	2011-01-27 12:12:13-06
1252	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-27 12:12:18-06
1253	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-27 12:12:18-06
1254	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-27 12:12:21-06
1255	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80	2011-01-27 12:12:36-06
1256	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-27 12:12:38-06
1257	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-27 12:12:39-06
1258	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-27 12:12:41-06
1259	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=87	2011-01-27 12:12:43-06
1260	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-27 12:12:46-06
1261	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-27 12:12:46-06
1262	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-27 12:12:49-06
1263	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-28 12:40:30-06
1264	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-28 12:40:43-06
1265	0:0:0:0:0:0:0:1	mwarnock	/patients/record_consent?patient_id=80&commit=Yes	2011-01-28 12:41:09-06
1266	0:0:0:0:0:0:0:1	mwarnock	/exams	2011-01-28 12:41:10-06
1267	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-28 12:41:32-06
1268	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-28 12:41:33-06
1269	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-28 12:41:36-06
1270	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80	2011-01-28 12:41:41-06
1271	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=84	2011-01-28 12:42:01-06
1272	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-28 12:42:11-06
1426	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-15 08:24:36-06
1273	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=K0Izzah4cQ7PTKk9BzqOudML%2BsaWEHkdiM%2FnYfL0w4k%3D&exam_ids%5B%5D=84&patient_password=monkey&patient_password_confirmation=monkey&email=mwarnock%40umm.edu	2011-01-28 12:42:50-06
1274	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=K0Izzah4cQ7PTKk9BzqOudML%2BsaWEHkdiM%2FnYfL0w4k%3D&exam_ids%5B%5D=84&patient_password=monkey&patient_password_confirmation=monkey&email=mwarnock%40umm.edu	2011-01-28 12:42:50-06
1275	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80&token=77us6ohq	2011-01-28 12:43:06-06
1276	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=77us6ohq	2011-01-28 12:43:07-06
1277	0:0:0:0:0:0:0:1	mwarnock	/patients/new	2011-01-28 12:43:51-06
1278	0:0:0:0:0:0:0:1	mwarnock	/	2011-01-28 12:43:52-06
1279	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-01-28 12:44:05-06
1280	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80	2011-01-28 12:44:08-06
1281	0:0:0:0:0:0:0:1	mwarnock	/exams/add_to_cart?id=84	2011-01-28 12:44:10-06
1282	0:0:0:0:0:0:0:1	mwarnock	/exams/show_cart	2011-01-28 12:44:11-06
1283	0:0:0:0:0:0:0:1	mwarnock	/exams/validate_cart?authenticity_token=K0Izzah4cQ7PTKk9BzqOudML%2BsaWEHkdiM%2FnYfL0w4k%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-28 12:44:16-06
1284	0:0:0:0:0:0:0:1	mwarnock	/exams/send_cart?authenticity_token=K0Izzah4cQ7PTKk9BzqOudML%2BsaWEHkdiM%2FnYfL0w4k%3D&exam_ids%5B%5D=84&patient_password=asdf&patient_password_confirmation=asdf&email=	2011-01-28 12:44:16-06
1285	0:0:0:0:0:0:0:1	mwarnock	/exams?patient_id=80&token=8bi6k4m1	2011-01-28 12:44:17-06
1286	0:0:0:0:0:0:0:1	mwarnock	/exams/print_patient_info?token=8bi6k4m1	2011-01-28 12:44:18-06
1287	0:0:0:0:0:0:0:1	sglanger	/	2011-02-01 09:06:54-06
1288	0:0:0:0:0:0:0:1	sglanger	/patients/new	2011-02-01 09:06:58-06
1289	0:0:0:0:0:0:0:1	sglanger	/	2011-02-01 09:06:59-06
1290	0:0:0:0:0:0:0:1	mwarnock	/	2011-02-02 12:13:49-06
1291	0:0:0:0:0:0:0:1	mwarnock	/patients/search?search=t&search_type=simple	2011-02-02 12:13:52-06
1292	0:0:0:0:0:0:0:1	wtellis	/	2011-02-03 18:33:03-06
1293	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-02-03 18:33:10-06
1294	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=87&commit=Yes	2011-02-03 18:33:15-06
1295	0:0:0:0:0:0:0:1	wtellis	/exams	2011-02-03 18:33:16-06
1296	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=91	2011-02-03 18:33:19-06
1297	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-03 18:33:21-06
1298	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=CDwYao9lGpKSkB1UDxjJi0%2B6Ne32S9oId3VW5D16czQ%3D&exam_ids%5B%5D=91&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-03 18:33:32-06
1299	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=CDwYao9lGpKSkB1UDxjJi0%2B6Ne32S9oId3VW5D16czQ%3D&exam_ids%5B%5D=91&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-03 18:33:33-06
1300	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=87&token=y5pgg8pk	2011-02-03 18:33:36-06
1301	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=y5pgg8pk	2011-02-03 18:33:38-06
1302	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-02-03 18:42:01-06
1303	0:0:0:0:0:0:0:1	wtellis	/	2011-02-03 18:42:02-06
1304	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-02-03 18:42:07-06
1305	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=87	2011-02-03 18:42:12-06
1306	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=91	2011-02-03 18:42:15-06
1307	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-03 18:42:17-06
1308	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=CDwYao9lGpKSkB1UDxjJi0%2B6Ne32S9oId3VW5D16czQ%3D&exam_ids%5B%5D=91&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-03 18:42:30-06
1309	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=CDwYao9lGpKSkB1UDxjJi0%2B6Ne32S9oId3VW5D16czQ%3D&exam_ids%5B%5D=91&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-03 18:42:30-06
1310	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=87&token=67bpspoh	2011-02-03 18:42:32-06
1311	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=67bpspoh	2011-02-03 18:42:34-06
1312	0:0:0:0:0:0:0:1	mwarnock	/	2011-02-08 11:44:21-06
1313	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-02-08 11:45:10-06
1314	0:0:0:0:0:0:0:1	wtellis	/	2011-02-08 11:51:38-06
1315	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-02-08 13:17:46-06
1316	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-02-08 13:26:49-06
1317	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=86&commit=Yes	2011-02-08 13:27:05-06
1318	0:0:0:0:0:0:0:1	wtellis	/exams	2011-02-08 13:27:07-06
1319	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=90	2011-02-08 13:27:11-06
1320	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-08 13:27:14-06
1321	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=vHMe%2Finlr%2BwhjXVTUZVRZrFFUK0sDbT1V4Wr2JCX3Ao%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-08 13:27:27-06
1322	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=vHMe%2Finlr%2BwhjXVTUZVRZrFFUK0sDbT1V4Wr2JCX3Ao%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-08 13:27:29-06
1323	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=86&token=3hb459rn	2011-02-08 13:28:11-06
1324	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=3hb459rn	2011-02-08 13:28:13-06
1325	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-02-08 13:35:19-06
1326	0:0:0:0:0:0:0:1	wtellis	/	2011-02-08 13:35:20-06
1327	172.20.175.67	sglanger	/	2011-02-08 13:36:48-06
1328	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-08 13:43:55-06
1329	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-08 13:44:05-06
1330	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-02-08 13:45:42-06
1331	0:0:0:0:0:0:0:1	wtellis	/	2011-02-08 13:45:42-06
1332	0:0:0:0:0:0:0:1	wtellis	/	2011-02-08 13:53:50-06
1333	0:0:0:0:0:0:0:1	sglanger	/	2011-02-08 13:59:24-06
1334	0:0:0:0:0:0:0:1	sglanger	/patients/new	2011-02-08 13:59:33-06
1335	0:0:0:0:0:0:0:1	sglanger	/	2011-02-08 13:59:33-06
1336	0:0:0:0:0:0:0:1	sglanger	/admin/audit	2011-02-08 13:59:37-06
1337	0:0:0:0:0:0:0:1	sglanger	/admin/audit	2011-02-08 13:59:52-06
1338	0:0:0:0:0:0:0:1	wtellis	/	2011-02-08 14:00:05-06
1339	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-02-08 14:00:24-06
1340	0:0:0:0:0:0:0:1	sglanger	/tail	2011-02-08 14:01:28-06
1341	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=86&commit=Yes	2011-02-08 14:02:09-06
1342	0:0:0:0:0:0:0:1	wtellis	/exams	2011-02-08 14:02:10-06
1343	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=90	2011-02-08 14:02:46-06
1344	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-08 14:02:56-06
1345	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=E4AHJVKFaZlYwLrW4yJwT3RTShJ8YqFP%2B5OIrhC2zJk%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-08 14:07:17-06
1346	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=E4AHJVKFaZlYwLrW4yJwT3RTShJ8YqFP%2B5OIrhC2zJk%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=wyatt.tellis%40ucsf.edu	2011-02-08 14:07:18-06
1347	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=86&token=buc1bco1	2011-02-08 14:07:33-06
1348	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=buc1bco1	2011-02-08 14:07:35-06
1349	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-02-08 14:08:35-06
1350	0:0:0:0:0:0:0:1	wtellis	/	2011-02-08 14:08:36-06
1351	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-08 14:14:41-06
1352	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-08 14:14:46-06
1353	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=15125	2011-02-08 14:15:04-06
1354	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-08 14:15:56-06
1355	0:0:0:0:0:0:0:1	sglanger	/tail	2011-02-08 14:20:11-06
1356	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-02-08 14:25:11-06
1357	134.192.134.129	mwarnock	/	2011-02-08 14:26:45-06
1358	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-02-08 14:26:49-06
1359	134.192.134.129	mwarnock	/tail	2011-02-08 14:27:00-06
1360	134.192.134.129	mwarnock	/tail	2011-02-08 14:27:43-06
1361	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-02-08 14:29:50-06
1362	0:0:0:0:0:0:0:1	mwarnock	/	2011-02-08 14:32:48-06
1363	0:0:0:0:0:0:0:1	mwarnock	/admin/audit	2011-02-08 14:33:09-06
1364	134.192.135.254	mwarnock	/tail	2011-02-08 14:33:11-06
1365	134.192.134.129	mwarnock	/patients/new	2011-02-08 14:35:53-06
1366	0:0:0:0:0:0:0:1	mwarnock	/	2011-02-08 14:35:54-06
1367	0:0:0:0:0:0:0:1	mwarnock	/	2011-02-10 09:48:50-06
1368	134.192.134.76	mwarnock	/admin/audit	2011-02-10 09:50:31-06
1369	134.192.134.76	mwarnock	/tail	2011-02-10 09:50:58-06
1370	0:0:0:0:0:0:0:1	wtellis	/	2011-02-11 15:58:57-06
1371	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=test&search_type=simple	2011-02-11 15:59:02-06
1372	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=86	2011-02-11 15:59:06-06
1373	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=90	2011-02-11 15:59:10-06
1374	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-11 15:59:12-06
1375	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=4%2Fs2AwxVbbayS%2B%2F5Aj9zB%2FQKvIrHUxjmD6eqd5VJgM8%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-11 15:59:26-06
1376	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=4%2Fs2AwxVbbayS%2B%2F5Aj9zB%2FQKvIrHUxjmD6eqd5VJgM8%3D&exam_ids%5B%5D=90&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-11 15:59:27-06
1377	0:0:0:0:0:0:0:1	sglanger	/admin/audit	2011-02-14 08:58:24-06
1378	0:0:0:0:0:0:0:1	sglanger	/tail	2011-02-14 08:58:45-06
1379	0:0:0:0:0:0:0:1	sglanger	/tail	2011-02-14 08:59:50-06
1380	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-02-14 15:12:56-06
1381	0:0:0:0:0:0:0:1	mwarnock	/tail?log=transfer-content	2011-02-14 15:13:10-06
1382	0:0:0:0:0:0:0:1	mwarnock	/tail?log=prepare-content	2011-02-14 15:13:13-06
1383	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-02-14 15:16:07-06
1384	0:0:0:0:0:0:0:1	mwarnock	/tail	2011-02-14 15:17:51-06
1385	0:0:0:0:0:0:0:1	mwarnock	/tail?log=prepare-content	2011-02-14 15:18:09-06
1386	0:0:0:0:0:0:0:1	wtellis	/	2011-02-14 23:53:37-06
1387	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-14 23:53:41-06
1388	0:0:0:0:0:0:0:1	wtellis	/tail	2011-02-14 23:53:47-06
1389	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-14 23:54:59-06
1390	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-14 23:55:19-06
1391	0:0:0:0:0:0:0:1	wtellis	/tail	2011-02-14 23:55:22-06
1392	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-02-14 23:55:25-06
1393	0:0:0:0:0:0:0:1	wtellis	/	2011-02-14 23:55:26-06
1394	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-02-14 23:55:32-06
1395	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=82&commit=Yes	2011-02-14 23:55:41-06
1396	0:0:0:0:0:0:0:1	wtellis	/exams	2011-02-14 23:55:42-06
1397	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=86	2011-02-14 23:55:46-06
1398	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-14 23:55:49-06
1399	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=r2Gi6ZSQC8wuOP6gizpk%2FF45CmFYaBf7MvgxsHRxP8Q%3D&exam_ids%5B%5D=86&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-14 23:56:01-06
1400	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=r2Gi6ZSQC8wuOP6gizpk%2FF45CmFYaBf7MvgxsHRxP8Q%3D&exam_ids%5B%5D=86&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-14 23:56:02-06
1401	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=82&token=jz576uap	2011-02-14 23:56:06-06
1402	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=jz576uap	2011-02-14 23:56:08-06
1403	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-14 23:56:40-06
1404	0:0:0:0:0:0:0:1	wtellis	/	2011-02-15 08:15:19-06
1405	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-15 08:15:24-06
1406	0:0:0:0:0:0:0:1	wtellis	/admin/audit_details?id=15169	2011-02-15 08:17:30-06
1407	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-15 08:23:04-06
1408	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-02-15 08:23:08-06
1409	0:0:0:0:0:0:0:1	wtellis	/	2011-02-15 08:23:08-06
1410	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-02-15 08:23:15-06
1411	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=83&commit=Yes	2011-02-15 08:23:20-06
1412	0:0:0:0:0:0:0:1	wtellis	/exams	2011-02-15 08:23:21-06
1413	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=87	2011-02-15 08:23:24-06
1414	0:0:0:0:0:0:0:1	wtellis	/exams/show_cart	2011-02-15 08:23:28-06
1415	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=X9cew6KbN7e6fKUu2KQMmjtCZ2MUqPdgnV18cfcALd8%3D&exam_ids%5B%5D=87&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-15 08:23:42-06
1416	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=X9cew6KbN7e6fKUu2KQMmjtCZ2MUqPdgnV18cfcALd8%3D&exam_ids%5B%5D=87&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-15 08:23:42-06
1417	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=83&token=9mhdwwcm	2011-02-15 08:23:44-06
1418	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=9mhdwwcm	2011-02-15 08:23:46-06
1419	0:0:0:0:0:0:0:1	wtellis	/admin/audit	2011-02-15 08:24:12-06
1420	0:0:0:0:0:0:0:1	wtellis	/patients/new	2011-02-15 08:24:18-06
1421	0:0:0:0:0:0:0:1	wtellis	/	2011-02-15 08:24:19-06
1422	0:0:0:0:0:0:0:1	wtellis	/patients/search?search=large&search_type=simple	2011-02-15 08:24:25-06
1423	0:0:0:0:0:0:0:1	wtellis	/patients/record_consent?patient_id=84&commit=Yes	2011-02-15 08:24:30-06
1424	0:0:0:0:0:0:0:1	wtellis	/exams	2011-02-15 08:24:31-06
1425	0:0:0:0:0:0:0:1	wtellis	/exams/add_to_cart?id=88	2011-02-15 08:24:34-06
1427	0:0:0:0:0:0:0:1	wtellis	/exams/validate_cart?authenticity_token=X9cew6KbN7e6fKUu2KQMmjtCZ2MUqPdgnV18cfcALd8%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-15 08:24:46-06
1428	0:0:0:0:0:0:0:1	wtellis	/exams/send_cart?authenticity_token=X9cew6KbN7e6fKUu2KQMmjtCZ2MUqPdgnV18cfcALd8%3D&exam_ids%5B%5D=88&patient_password=test1234&patient_password_confirmation=test1234&email=	2011-02-15 08:24:47-06
1429	0:0:0:0:0:0:0:1	wtellis	/exams?patient_id=84&token=hwp6u73s	2011-02-15 08:24:49-06
1430	0:0:0:0:0:0:0:1	wtellis	/exams/print_patient_info?token=hwp6u73s	2011-02-15 08:24:50-06
1431	0:0:0:0:0:0:0:1	sglanger	/tail	2011-02-15 08:28:20-06
1432	0:0:0:0:0:0:0:1	sglanger	/tail	2011-02-15 08:58:23-06
1433	0:0:0:0:0:0:0:1	sglanger	/tail?log=prepare-content	2011-02-15 08:58:51-06
1434	0:0:0:0:0:0:0:1	sglanger	/admin/audit	2011-02-15 09:06:26-06
1435	0:0:0:0:0:0:0:1	sglanger	/tail	2011-02-15 09:10:56-06
1436	0:0:0:0:0:0:0:1	sglanger	/tail?log=prepare-content	2011-02-15 09:15:50-06
1437	0:0:0:0:0:0:0:1	sglanger	/admin/audit	2011-02-16 08:00:29-06
1438	0:0:0:0:0:0:0:1	sglanger	/admin/audit_details?id=15185	2011-02-16 08:01:19-06
1439	0:0:0:0:0:0:0:1	sglanger	/	2011-02-16 13:11:49-06
1440	0:0:0:0:0:0:0:1	sglanger	/admin/audit	2011-02-16 13:11:55-06
\.


--
-- Data for Name: job_sets; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY job_sets (job_set_id, patient_id, user_id, email_address, modified_date, delay_in_hrs, single_use_patient_id) FROM stdin;
90	86	4	wyatt.tellis@ucsf.edu	2011-02-08 14:07:18.121-06	0	435307d2b6a07d37a1281310750b497b7dd2ef1b87812638cf99c69ac5371146
91	86	4		2011-02-11 15:59:26.889-06	0	9356f1e9843f58eab5f6cbfcf863243f71d35edff6b70a343d50c8de173204a8
92	82	4		2011-02-14 23:56:01.882-06	0	a18239492e00fb7f3fd4738205ac71876358671078f3c391a398d34eeec67242
93	83	4		2011-02-15 08:23:42.805-06	0	523d842e47978f90f286ec84ee500694e65166aece9c2db9dc7ae5bcbb13974e
94	84	4		2011-02-15 08:24:47.419-06	0	bf9d6c8bae4d2fe91f041f93e8bf8e8626c7904f2bc347879e971ba43bd65742
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY jobs (job_id, job_set_id, exam_id, report_id, document_id, modified_date) FROM stdin;
91	90	90	\N	\N	2011-02-08 14:07:18.195-06
92	91	90	\N	\N	2011-02-11 15:59:27.001-06
93	92	86	\N	\N	2011-02-14 23:56:01.963-06
94	93	87	\N	\N	2011-02-15 08:23:42.884-06
95	94	88	\N	\N	2011-02-15 08:24:47.546-06
\.


--
-- Data for Name: patient_merge_events; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patient_merge_events (event_id, old_mrn, new_mrn, old_patient_id, new_patient_id, status, modified_date) FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patients (patient_id, mrn, patient_name, dob, sex, street, city, state, zip_code, modified_date, consent_timestamp) FROM stdin;
82	618203196	LARGE^STUDYONE^	1910-08-09	M	459 Jefferson Ave	Atlanta	GA	30322	2011-02-14 23:55:41.615598-06	2011-02-14 23:55:41.601-06
83	105283367	LARGE^STUDYTWO^	1972-08-22	F	901 Birch Ave	Atlanta	GA	30317	2011-02-15 08:23:20.954263-06	2011-02-15 08:23:20.948-06
84	231444323	LARGE^STUDYTHREE^	1960-10-22	M	213 Jefferson Ave	Atlanta	GA	30322	2011-02-15 08:24:30.651405-06	2011-02-15 08:24:30.639-06
81	212763672	TWO^ONE^	1977-02-08	F	2 Oak St	Atlanta	GA	30317	2011-01-27 22:58:59.331036-06	\N
85	101898188	Moorex^S^	1946-02-01	M	321 Oak St	Atlanta	GA	30317	2011-01-27 22:58:59.331036-06	\N
80	128235611	TEST^ONE^	1942-12-01	M	734 Chestnut St	Atlanta	GA	30317	2011-02-08 13:27:59.276179-06	\N
87	380428614	MRI^TESTTWO^	1910-08-09	F	535 Madison Ave	Atlanta	GA	30317	2011-02-08 13:28:03.699923-06	\N
86	399608982	MRI^TESTONE^	1976-11-01	M	477 Rooselvelt Ave	Atlanta	GA	30317	2011-02-08 14:02:09.634235-06	2011-02-08 14:02:09.622-06
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY reports (report_id, exam_id, proc_code, status, status_timestamp, report_text, signer, dictator, transcriber, modified_date) FROM stdin;
151	84	\N	ORDERED	2010-12-20 13:22:00-06					2010-12-20 13:22:30.946856-06
152	84	\N	FINALIZED	2010-12-20 23:23:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-12-20 13:22:34.075268-06
153	85	\N	ORDERED	2010-12-20 13:23:00-06					2010-12-20 13:23:13.889372-06
154	85	\N	FINALIZED	2010-12-20 23:23:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-12-20 13:23:17.036358-06
155	86	\N	ORDERED	2011-01-10 18:45:00-06					2011-01-10 18:46:51.961269-06
156	86	\N	FINALIZED	2011-01-11 04:45:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2011-01-10 18:46:55.101761-06
157	87	\N	ORDERED	2011-01-10 19:02:00-06					2011-01-10 19:04:09.552187-06
158	87	\N	FINALIZED	2011-01-11 05:02:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2011-01-10 19:04:12.658427-06
159	88	\N	ORDERED	2011-01-11 15:59:00-06					2011-01-11 16:01:40.913252-06
160	88	\N	FINALIZED	2011-01-12 01:59:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2011-01-11 16:01:44.039016-06
161	89	\N	ORDERED	2011-01-27 09:03:00-06					2011-01-27 09:07:03.965455-06
162	89	\N	FINALIZED	2011-01-27 19:03:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2011-01-27 09:07:07.071101-06
163	90	\N	ORDERED	2011-01-27 09:32:00-06					2011-01-27 09:35:39.161978-06
164	90	\N	FINALIZED	2011-01-27 19:32:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2011-01-27 09:35:42.296624-06
165	91	\N	ORDERED	2011-01-27 09:37:00-06					2011-01-27 09:40:58.221306-06
166	91	\N	FINALIZED	2011-01-27 19:37:00-06	MR RIGHT KNEE:  \\.br\\.brCLINICAL INDICATION:  Tear of medial meniscus.\\.br\\.brTECHNIQUE:  Axial, sagittal and coronal sequences were performed.\\.br\\.brOBSERVATIONS:  The lateral meniscus is unremarkable.  Medial meniscus\\.brdemonstrates some degenerative signals which do not touch the inferior\\.brarticular surface of knee joint, for example series 4, images 5-6.  However, on\\.brimage 7, a small, globular focus abuts the inferior articular surface\\.brnear the free edge; this is compatible with a tear.\\.br\\.brQuadriceps tendon and patellar tendon are intact.  Anterior cruciate ligament and posterior cruciate ligament are intact.  Medial collateral ligament and fibular collateral ligaments are intact.\\.br\\.brAs far as can be seen, the articular cartilage is unremarkable.\\.br\\.brModerate amount of suprapatellar fluid is identified.\\.br\\.brIMPRESSION:\\.br\\.br DEGENERATIVE CHANGES AND TEAR, POSTERIOR HORN OF MEDIAL MENISCUS;\\.br\\.br MODERATE AMOUNT OF SUPRAPATELLAR FLUID\\.br\\.br COMMENT:  THERE IS SUGGESTION OF A MEDIAL PATELLAR PLICA\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2011-01-27 09:41:01.329823-06
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
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY transactions (transaction_id, job_id, status_code, comments, modified_date) FROM stdin;
15125	91	1	Queued	2011-02-08 14:07:18.195-06
15126	91	23		2011-02-11 14:54:47.881473-06
15127	91	30		2011-02-11 14:55:14.035652-06
15132	92	1	Queued	2011-02-11 15:59:27.001-06
15133	92	23		2011-02-11 15:59:27.957192-06
15134	92	30		2011-02-11 15:59:49.258482-06
15142	92	31		2011-02-12 09:11:00.425749-06
15143	92	32		2011-02-12 09:11:00.435612-06
15144	92	33		2011-02-12 09:11:00.566729-06
15146	92	-33	org.openhealthtools.ihe.pix.source.PixSourceException: org.openhealthtools.ihe.common.hl7v2.mllpclient.ClientException: Message delivery failed \n\tat org.openhealthtools.ihe.pix.source.PixSource.sendPixFeed(PixSource.java:903)\n\tat org.openhealthtools.ihe.pix.source.PixSource.sendRegistration(PixSource.java:379)\n\tat org.rsna.isn.transfercontent.ihe.Iti8.sendIti8Message(Iti8.java:134)\n\tat org.rsna.isn.transfercontent.ihe.Iti8.registerPatient(Iti8.java:112)\n\tat org.rsna.isn.transfercontent.Worker.run(Worker.java:116)\nCaused by: org.openhealthtools.ihe.common.hl7v2.mllpclient.ClientException: Message delivery failed \n\tat org.openhealthtools.ihe.common.hl7v2.mllpclient.Client.send(Client.java:679)\n\tat org.openhealthtools.ihe.common.hl7v2.mllpclient.Client.sendMsg(Client.java:485)\n\tat org.openhealthtools.ihe.pix.source.PixSource.sendPixFeed(PixSource.java:900)\n\t... 4 more\nCaused by: org.openhealthtools.ihe.common.mllp.MLLPException: Unexpected error \n\tat org.openhealthtools.ihe.common.mllp.MLLPDestination.sendMessage(MLLPDestination.java:319)\n\tat org.openhealthtools.ihe.common.hl7v2.mllpclient.Client.send(Client.java:675)\n\t... 6 more\nCaused by: java.net.ConnectException: Secure socket retries exhausted\n\tat org.openhealthtools.ihe.atna.nodeauth.handlers.TLSEnabledSocketHandler.createSecureSocket(TLSEnabledSocketHandler.java:286)\n\tat org.openhealthtools.ihe.atna.nodeauth.handlers.TLSEnabledSocketHandler.createSecureSocket(TLSEnabledSocketHandler.java:1)\n\tat org.openhealthtools.ihe.atna.nodeauth.handlers.AbstractSecureSocketHandler.getSocket(AbstractSecureSocketHandler.java:141)\n\tat org.openhealthtools.ihe.atna.nodeauth.handlers.AbstractSecureSocketHandler.getSocket(AbstractSecureSocketHandler.java:125)\n\tat org.openhealthtools.ihe.atna.nodeauth.handlers.AbstractSecureSocketHandler.getSocket(AbstractSecureSocketHandler.java:101)\n\tat org.openhealthtools.ihe.atna.nodeauth.handlers.AbstractSecureSocketHandler.getSocket(AbstractSecureSocketHandler.java:85)\n\tat org.openhealthtools.ihe.common.mllp.MLLPDestination.sendMessage(MLLPDestination.java:293)\n\t... 7 more\n	2011-02-12 09:14:07.2299-06
15157	91	31		2011-02-14 23:48:04.696625-06
15158	91	32		2011-02-14 23:48:04.715411-06
15159	91	33		2011-02-14 23:48:05.077738-06
15160	91	34		2011-02-14 23:48:07.943905-06
15161	91	40		2011-02-14 23:49:16.582291-06
15162	93	1	Queued	2011-02-14 23:56:01.963-06
15170	94	1	Queued	2011-02-15 08:23:42.884-06
15171	94	23		2011-02-15 08:23:43.519989-06
15172	94	-21	Unable to retrive study from any remote device.	2011-02-15 08:23:43.593172-06
15173	95	1	Queued	2011-02-15 08:24:47.546-06
15174	95	23		2011-02-15 08:24:47.859511-06
15175	95	30		2011-02-15 08:53:21.089211-06
15181	95	31		2011-02-15 09:39:42.20658-06
15182	95	32		2011-02-15 09:39:42.212244-06
15183	95	33		2011-02-15 09:40:47.769088-06
15184	95	34		2011-02-15 09:40:49.772642-06
15185	95	-34	org.openhealthtools.ihe.common.ws.IHESOAPException: Error Sending SOAP Message  [Caused by org.apache.axiom.om.OMException: Error while writing to the OutputStream.]\n\tat org.openhealthtools.ihe.common.ws.AbstractIHESOAPSender.executeSend(AbstractIHESOAPSender.java:356)\n\tat org.openhealthtools.ihe.common.ws.AbstractIHESOAPSender.send(AbstractIHESOAPSender.java:484)\n\tat org.openhealthtools.ihe.xds.soap.AbstractXDSSoapClient.send(AbstractXDSSoapClient.java:219)\n\tat org.openhealthtools.ihe.xds.source.AbstractSource.submit(AbstractSource.java:191)\n\tat org.openhealthtools.ihe.xds.source.B_Source.submit(B_Source.java:93)\n\tat org.openhealthtools.ihe.xds.source.B_Source.submit(B_Source.java:82)\n\tat org.rsna.isn.transfercontent.ihe.Iti41.submitDocuments(Iti41.java:317)\n\tat org.rsna.isn.transfercontent.Worker.run(Worker.java:146)\nCaused by: org.apache.axiom.om.OMException: Error while writing to the OutputStream.\n\tat org.apache.axiom.om.impl.MIMEOutputUtils.complete(MIMEOutputUtils.java:165)\n\tat org.apache.axiom.om.impl.MTOMXMLStreamWriter.flush(MTOMXMLStreamWriter.java:159)\n\tat org.apache.axiom.om.impl.llom.OMNodeImpl.serializeAndConsume(OMNodeImpl.java:472)\n\tat org.apache.axis2.transport.http.SOAPMessageFormatter.writeTo(SOAPMessageFormatter.java:79)\n\tat org.apache.axis2.transport.http.AxisRequestEntity.writeRequest(AxisRequestEntity.java:84)\n\tat org.apache.commons.httpclient.methods.EntityEnclosingMethod.writeRequestBody(EntityEnclosingMethod.java:499)\n\tat org.apache.commons.httpclient.HttpMethodBase.writeRequest(HttpMethodBase.java:2114)\n\tat org.apache.commons.httpclient.HttpMethodBase.execute(HttpMethodBase.java:1096)\n\tat org.apache.commons.httpclient.HttpMethodDirector.executeWithRetry(HttpMethodDirector.java:398)\n\tat org.apache.commons.httpclient.HttpMethodDirector.executeMethod(HttpMethodDirector.java:171)\n\tat org.apache.commons.httpclient.HttpClient.executeMethod(HttpClient.java:397)\n\tat org.apache.commons.httpclient.HttpClient.executeMethod(HttpClient.java:346)\n\tat org.apache.axis2.transport.http.AbstractHTTPSender.executeMethod(AbstractHTTPSender.java:542)\n\tat org.apache.axis2.transport.http.HTTPSender.sendViaPost(HTTPSender.java:189)\n\tat org.apache.axis2.transport.http.HTTPSender.send(HTTPSender.java:75)\n\tat org.apache.axis2.transport.http.CommonsHTTPTransportSender.writeMessageWithCommons(CommonsHTTPTransportSender.java:371)\n\tat org.apache.axis2.transport.http.CommonsHTTPTransportSender.invoke(CommonsHTTPTransportSender.java:209)\n\tat org.apache.axis2.engine.AxisEngine.send(AxisEngine.java:448)\n\tat org.apache.axis2.description.OutInAxisOperationClient.send(OutInAxisOperation.java:401)\n\tat org.apache.axis2.description.OutInAxisOperationClient.executeImpl(OutInAxisOperation.java:228)\n\tat org.apache.axis2.client.OperationClient.execute(OperationClient.java:163)\n\tat org.openhealthtools.ihe.common.ws.AbstractIHESOAPSender.executeSend(AbstractIHESOAPSender.java:348)\n\t... 7 more\nCaused by: java.net.SocketException: Broken pipe\n\tat java.net.SocketOutputStream.socketWrite0(Native Method)\n\tat java.net.SocketOutputStream.socketWrite(SocketOutputStream.java:92)\n\tat java.net.SocketOutputStream.write(SocketOutputStream.java:136)\n\tat com.sun.net.ssl.internal.ssl.OutputRecord.writeBuffer(OutputRecord.java:295)\n\tat com.sun.net.ssl.internal.ssl.OutputRecord.write(OutputRecord.java:284)\n\tat com.sun.net.ssl.internal.ssl.SSLSocketImpl.writeRecordInternal(SSLSocketImpl.java:734)\n\tat com.sun.net.ssl.internal.ssl.SSLSocketImpl.writeRecord(SSLSocketImpl.java:722)\n\tat com.sun.net.ssl.internal.ssl.AppOutputStream.write(AppOutputStream.java:59)\n\tat java.io.BufferedOutputStream.write(BufferedOutputStream.java:105)\n\tat org.apache.commons.httpclient.ChunkedOutputStream.flushCacheWithAppend(ChunkedOutputStream.java:121)\n\tat org.apache.commons.httpclient.ChunkedOutputStream.write(ChunkedOutputStream.java:179)\n\tat javax.activation.DataHandler.writeTo(DataHandler.java:294)\n\tat javax.mail.internet.MimeBodyPart.writeTo(MimeBodyPart.java:452)\n\tat org.apache.axiom.om.impl.MIMEOutputUtils.writeBodyPart(MIMEOutputUtils.java:245)\n\tat org.apache.axiom.om.impl.MIMEOutputUtils.complete(MIMEOutputUtils.java:151)\n\t... 28 more\n	2011-02-15 09:43:56.17922-06
15186	93	23		2011-02-15 12:40:43.653091-06
15187	93	30		2011-02-15 12:44:56.736689-06
15188	93	31		2011-02-15 12:44:56.783104-06
15189	93	32		2011-02-15 12:44:56.789926-06
15190	93	33		2011-02-15 12:44:58.779839-06
15191	93	34		2011-02-15 12:45:00.189664-06
15192	93	40		2011-02-15 12:54:07.32021-06
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY users (user_id, user_login, user_name, email, crypted_password, salt, created_at, updated_at, remember_token, remember_token_expires_at, role_id, modified_date) FROM stdin;
2	mwarnock	Max Warnock	mwarnock@umm.edu	a047ae44b02d035279c9ceea96bf423025ed992a	6c2e285bc6568a104281f833b0c3ad3aa67c319f	2010-09-14 13:44:57.442-05	2010-09-14 13:54:41.213-05	\N	\N	2	2010-09-14 08:54:41.186345-05
3	admin	admin	fake@fakey.com	ee4f514bc9e99c110745eb7cd8f4bebdf561d296	57e3276199a2f4d26de6ad4a9a894cd7b7e4d6f1	2010-09-16 18:18:54.645-05	2010-09-16 18:18:54.645-05	\N	\N	2	\N
6	femi	Femi Oyesanya	oyesanyf@gmail.com	7847ad71ff43885836c5a4d0cf7df138572f3f12	7fda4f63215675ccc0c192e43214f1f1345248d4	2010-09-16 20:31:42.147-05	2010-09-16 20:31:42.147-05	\N	\N	1	\N
4	wtellis	Wyatt Tellis	wyatt.tellis@ucsf.edu	e7e12ac655784d9910cb6354161a4cf4d21999d7	4539f3ad4ff395479c95755e5f0e90dcea37c98e	2010-09-16 18:24:11.356-05	2010-09-28 13:43:18.389-05	\N	\N	2	2010-09-28 13:43:18.382073-05
7	mdaly	Daly, Mark	mdaly@umm.edu	d1c7af1359d856baf55bbd717b3b232777caa85c	1b598317c926d775e9e00b537971b3283f06ea64	2010-10-13 09:38:49.245-05	2010-10-13 09:39:33.089-05	\N	\N	2	2010-10-13 11:38:12.721709-05
8	wzhu	Zhu, Wendy	wzhu@radiology.bsd.uchicago.edu	06f1a1a07f094e9d689efde53a0e809cdf82f67b	ddf446d9114c24dbf3d0beb7256c074a3fe3bd2d	2010-10-14 15:40:31.157-05	2010-10-14 15:40:31.157-05	\N	\N	2	\N
9	smoore	steve moore	smoore@wustl.edu	6dcc9a4a647120ac75dc0ae39ffe6888fcef8285	2f2dfbd295c07272f5580da43cb059d400d30188	2010-10-14 16:01:19.875-05	2010-10-14 16:01:19.875-05	\N	\N	2	\N
5	sglanger	steve 	sglanger@nibib-2.wustl.edu	8a786f2a6223980d6622029ef81ac92321272658	ad10d719ccdb56b48672cedce3f911c689b76652	2010-09-16 18:58:29.457-05	2011-02-08 13:44:31.052-06	\N	\N	2	2011-02-08 13:44:31.044349-06
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
-- Name: uq_single_use_patient_id; Type: CONSTRAINT; Schema: public; Owner: edge; Tablespace: 
--

ALTER TABLE ONLY job_sets
    ADD CONSTRAINT uq_single_use_patient_id UNIQUE (single_use_patient_id);


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
-- Name: fk_report_id; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT fk_report_id FOREIGN KEY (report_id) REFERENCES reports(report_id);


--
-- Name: fk_status_code; Type: FK CONSTRAINT; Schema: public; Owner: edge
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT fk_status_code FOREIGN KEY (status_code) REFERENCES status_codes(status_code);


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

