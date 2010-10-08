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
ALTER TABLE ONLY public.roles DROP CONSTRAINT pk_role_id;
ALTER TABLE ONLY public.reports DROP CONSTRAINT pk_report_id;
ALTER TABLE ONLY public.patients DROP CONSTRAINT pk_patient_id;
ALTER TABLE ONLY public.patient_rsna_ids DROP CONSTRAINT pk_map_id;
ALTER TABLE ONLY public.configurations DROP CONSTRAINT pk_key;
ALTER TABLE ONLY public.job_sets DROP CONSTRAINT pk_job_set_id;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT pk_job_id;
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
-- Name: rsnadb; Type: COMMENT; Schema: -; Owner: edge
--

COMMENT ON DATABASE rsnadb IS 'RSNA NIBIB Edge Device Database';


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

COMMENT ON TABLE configurations IS 'This table is used to store applications specific config data;
a) paths to key things (ie dicom studies)
b) site prefix for generating RSNA ID''s
c) site delay for applying to report finalize before available to send to CH
d) etc';


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

COMMENT ON TABLE devices IS 'Used to store
a) the DICOM triplet (for remote DICOM study sources)
b) the HL7 feed infor (reports, orders)
c) the connect info for the Clearing House
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

SELECT pg_catalog.setval('exams_exam_id_seq', 35, true);


--
-- Name: hipaa_audit_accession_numbers; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE hipaa_audit_accession_numbers (
    id integer NOT NULL,
    view_id integer,
    accession_number character varying(100),
    modified_date timestamp with time zone
);


ALTER TABLE public.hipaa_audit_accession_numbers OWNER TO edge;

--
-- Name: TABLE hipaa_audit_accession_numbers; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE hipaa_audit_accession_numbers IS 'Part of the HIPAA tracking for edge device auditing
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

SELECT pg_catalog.setval('hipaa_audit_accession_numbers_id_seq', 52, true);


--
-- Name: hipaa_audit_mrns; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE hipaa_audit_mrns (
    id integer NOT NULL,
    view_id integer,
    mrn character varying(100),
    modified_date timestamp with time zone
);


ALTER TABLE public.hipaa_audit_mrns OWNER TO edge;

--
-- Name: TABLE hipaa_audit_mrns; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE hipaa_audit_mrns IS 'Part of the HIPAA tracking for edge device auditing';


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

SELECT pg_catalog.setval('hipaa_audit_mrns_id_seq', 443, true);


--
-- Name: hipaa_audit_views; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE hipaa_audit_views (
    id integer NOT NULL,
    requesting_ip character varying(15),
    requesting_username character varying(100),
    requesting_uri text,
    modified_date timestamp with time zone
);


ALTER TABLE public.hipaa_audit_views OWNER TO edge;

--
-- Name: TABLE hipaa_audit_views; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE hipaa_audit_views IS 'Part of the HIPAA tracking for edge device auditing. This is the top level table that tracks who asked for what from where';


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

SELECT pg_catalog.setval('hipaa_audit_views_id_seq', 204, true);


--
-- Name: job_sets; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE job_sets (
    job_set_id integer NOT NULL,
    patient_id integer NOT NULL,
    user_id integer NOT NULL,
    security_pin character varying(10),
    email_address character varying,
    modified_date timestamp with time zone DEFAULT now(),
    delay_in_hrs integer DEFAULT 72
);


ALTER TABLE public.job_sets OWNER TO edge;

--
-- Name: TABLE job_sets; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE job_sets IS 'This is one of a pair of tables that bind a patient to a edge device job, consisting of one or more exam accessions descrbing DICOM exams to send to the CH. The other table is JOBS
';


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

SELECT pg_catalog.setval('job_sets_job_set_id_seq', 20, true);


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

SELECT pg_catalog.setval('jobs_job_id_seq', 18, true);


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
    registered boolean DEFAULT false NOT NULL
);


ALTER TABLE public.patient_rsna_ids OWNER TO edge;

--
-- Name: TABLE patient_rsna_ids; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE patient_rsna_ids IS 'Map a patients local medical center ID (ie MRN) to the MPI like RSNAID
';


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

SELECT pg_catalog.setval('patient_rsna_ids_map_id_seq', 10, true);


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

SELECT pg_catalog.setval('patients_patient_id_seq', 35, true);


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

SELECT pg_catalog.setval('reports_report_id_seq', 54, true);


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

COMMENT ON TABLE roles IS 'Combined with table Users, this table defined a user role and privelages
';


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

SELECT pg_catalog.setval('studies_study_id_seq', 105, true);


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE transactions (
    transaction_id integer NOT NULL,
    job_id integer NOT NULL,
    status integer NOT NULL,
    status_message character varying,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.transactions OWNER TO edge;

--
-- Name: TABLE transactions; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON TABLE transactions IS 'status logging/auditing for jobs defined in table Jobs. The java apps come here to determine their work by looking at the value status';


--
-- Name: COLUMN transactions.status; Type: COMMENT; Schema: public; Owner: edge
--

COMMENT ON COLUMN transactions.status IS 'WHen a job is created by the GUI Token app, the row is created with value 1

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

SELECT pg_catalog.setval('transactions_transaction_id_seq', 14464, true);


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

COMMENT ON TABLE users IS 'Combined with table Rows, this table defeins who can do what on the Edge appliacne Web GUI';


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

SELECT pg_catalog.setval('users_user_id_seq', 6, true);


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
    SELECT j.job_id, j.exam_id, js.delay_in_hrs, t.status, t.status_message, t.modified_date AS last_transaction_timestamp FROM ((jobs j JOIN job_sets js ON ((j.job_set_id = js.job_set_id))) JOIN (SELECT t1.job_id, t1.status, t1.status_message, t1.modified_date FROM transactions t1 WHERE (t1.modified_date = (SELECT max(t2.modified_date) AS max FROM transactions t2 WHERE (t2.job_id = t1.job_id)))) t ON ((j.job_id = t.job_id)));


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
16	IHE203981.2	16	Head MR	2010-09-21 18:18:33.335371-05
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
202	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:52:08-05
203	0:0:0:0:0:0:0:1	mwarnock	/patients/search	2010-10-06 09:54:01-05
204	0:0:0:0:0:0:0:1	admin	/	2010-10-06 11:24:35-05
\.


--
-- Data for Name: job_sets; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY job_sets (job_set_id, patient_id, user_id, security_pin, email_address, modified_date, delay_in_hrs) FROM stdin;
18	22	4	\N	wyatt.tellis@ucsf.edu	2010-09-28 13:33:18.509-05	72
19	22	4	\N	wyatt.tellis@ucsf.edu	2010-10-04 17:16:52.477-05	72
20	31	4	\N	wyatt.tellis@ucsf.edu	2010-10-04 17:17:52.218-05	72
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY jobs (job_id, job_set_id, exam_id, report_id, document_id, modified_date) FROM stdin;
16	18	22	\N	6e3894f5-326b-444f-b4af-38c07efae125	2010-10-08 10:33:14.29199-05
17	19	22	\N	6e3894f5-326b-444f-b4af-38c07efae125	2010-10-08 10:33:14.29199-05
18	20	31	\N	14cffe58-6b00-4abe-93a4-ae2bdb2b14c5	2010-10-08 11:56:05.148944-05
\.


--
-- Data for Name: patient_merge_events; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patient_merge_events (event_id, old_mrn, new_mrn, old_patient_id, new_patient_id, status, modified_date) FROM stdin;
\.


--
-- Data for Name: patient_rsna_ids; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patient_rsna_ids (map_id, rsna_id, patient_id, modified_date, patient_alias_lastname, patient_alias_firstname, registered) FROM stdin;
5	0001-00016-123456	16	2010-10-08 08:40:30.530843-05	last	first	f
7	0001-00020-asdfad	20	2010-10-08 08:40:30.530843-05	last	first	f
8	0001-00019-kjhlkj	19	2010-10-08 08:40:30.530843-05	last	first	f
2	0001-00007-123456	7	2010-10-08 08:40:30.530843-05	last	first	f
9	0001-00022-123456	22	2010-10-08 09:32:52.418788-05	last	first	t
10	0001-00031-123456	31	2010-10-08 11:05:39.917927-05	last	first	t
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patients (patient_id, mrn, patient_name, dob, sex, street, city, state, zip_code, modified_date) FROM stdin;
7	678188495	Doe^John	1963-02-08	M	BOX 0824 - MCB 300	San Francisco	CA	94143	2010-09-24 11:59:47.624073-05
16	852215460	TEST^THREE^	1972-02-21	F	951 Cleveland Ave	Atlanta	GA	30317	2010-09-24 11:59:59.829309-05
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
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY reports (report_id, exam_id, proc_code, status, status_timestamp, report_text, signer, dictator, transcriber, modified_date) FROM stdin;
4	7	\N	FINALIZED	2010-06-02 10:56:00-05	1) Create report in Radhwere.\r\n2) Sign/Finalize report in Radwhere\r\n\r\n	PA0001^Avrin^David^^^			2010-09-16 14:13:55.667721-05
15	16	\N	FINALIZED	2010-09-21 17:03:00-05	Report Text\r\n	^SIGNER^K^^^		^TRANSCRIBER^L^^^	2010-09-21 17:03:45.35519-05
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
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY roles (role_id, role_description, modified_date) FROM stdin;
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
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY transactions (transaction_id, job_id, status, status_message, modified_date) FROM stdin;
14419	16	1	Queued	2010-09-28 13:33:18.555-05
14420	16	2000	Started prepare content	2010-09-28 13:33:19.284616-05
14421	16	2	Ready to transfer to clearinghouse.	2010-09-28 13:33:36.380203-05
14424	16	2	Ready to transfer to Clearinghouse	2010-09-29 09:59:55.393819-05
14425	16	2	Ready to transfer to clearinghouse	2010-10-04 14:11:04.219847-05
14426	16	2	Ready to transfer to clearinghouse	2010-10-04 14:19:49.489162-05
14427	16	2	Ready to transfer to clearinghouse	2010-10-04 14:34:06.300528-05
14428	16	2	Ready to transfer to clearinghouse	2010-10-04 15:07:29.74469-05
14429	16	2	Ready to transfer to clearinghouse	2010-10-04 16:11:47.949786-05
14430	17	1	Queued	2010-10-04 17:16:52.517-05
14431	17	2000	Started prepare content	2010-10-04 17:16:53.016984-05
14432	17	2	Ready to transfer to clearinghouse.	2010-10-04 17:17:03.944639-05
14433	18	1	Queued	2010-10-04 17:17:52.262-05
14434	18	2000	Started prepare content	2010-10-04 17:17:52.79899-05
14435	18	2	Ready to transfer to clearinghouse.	2010-10-04 17:18:00.044471-05
14436	18	2	Ready to transfer to clearinghouse	2010-10-05 18:37:34.230776-05
14437	18	2	Ready to transfer to clearinghouse	2010-10-06 09:29:45.059336-05
14439	17	3	Transferred to clearinghouse	2010-10-06 09:33:28.301-05
14440	16	2	Ready to transfer to clearinghouse	2010-10-06 17:34:57.196082-05
14441	16	2	Ready to transfer to clearinghouse	2010-10-06 18:31:23.244645-05
14442	16	2	Ready to transfer to clearinghouse	2010-10-06 18:35:17.072333-05
14443	16	2	Ready to transfer to clearinghouse	2010-10-06 18:41:35.704041-05
14444	16	2	Ready to transfer to clearinghouse	2010-10-07 10:01:19.824638-05
14445	16	2	Ready to transfer to clearinghouse	2010-10-07 13:25:04.322051-05
14446	16	2	Ready to transfer to clearinghouse	2010-10-07 13:42:32.467116-05
14447	16	2	Ready to transfer to clearinghouse	2010-10-07 13:58:27.777353-05
14448	16	2	Ready to transfer to clearinghouse	2010-10-07 16:47:28.475443-05
14449	16	2	Ready to transfer to clearinghouse	2010-10-07 18:14:49.715313-05
14450	16	2	Ready to transfer to clearinghouse	2010-10-07 18:17:13.259983-05
14451	16	2	Ready to transfer to clearinghous	2010-10-07 18:32:55.286336-05
14452	16	2	Ready to transfer to clearinghouse	2010-10-07 18:42:49.837502-05
14453	16	2	Ready to transfer to clearinghouse	2010-10-07 19:21:11.68506-05
14454	16	2	Ready to transfer to clearinghouse	2010-10-07 19:28:01.313531-05
14455	16	2	Ready to transfer to clearinghouse	2010-10-07 19:41:46.662943-05
14456	16	2	Ready to transfer to clearinghouse	2010-10-07 19:53:47.36953-05
14457	16	2	Ready to transfer to clearinghouse	2010-10-07 19:56:19.706731-05
14458	16	2	Ready to transfer to clearinghouse	2010-10-08 08:59:42.683203-05
14459	16	2	Ready to transfer to clearinghouse	2010-10-08 09:33:59.848078-05
14460	16	2	Ready to transfer to clearinghouse	2010-10-08 10:21:19.122797-05
14461	16	4	Transferred to clearinghouse	2010-10-08 10:33:14.304-05
14438	18	2	Ready to transfer to clearinghouse	2010-10-08 10:38:34.923068-05
14462	18	2	Ready to transfer to clearinghouse	2010-10-08 11:17:27.345241-05
14463	18	2	Ready to transfer to clearinghouse	2010-10-08 11:51:26.69518-05
14464	18	4	Transferred to clearinghouse	2010-10-08 11:56:05.177-05
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

