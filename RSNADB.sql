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

CREATE DATABASE rsnadb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


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

COMMENT ON DATABASE rsnadb IS 'RSNA NIBIB Edge Device Database';


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

SELECT pg_catalog.setval('devices_device_id_seq', 1, false);


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

SELECT pg_catalog.setval('exams_exam_id_seq', 1, false);


--
-- Name: job_sets; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE job_sets (
    job_set_id integer NOT NULL,
    patient_id integer NOT NULL,
    user_id integer NOT NULL,
    security_pin character varying(10),
    email_address character varying,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.job_sets OWNER TO edge;

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

SELECT pg_catalog.setval('job_sets_job_set_id_seq', 1, false);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: edge; Tablespace: 
--

CREATE TABLE jobs (
    job_id integer NOT NULL,
    job_set_id integer NOT NULL,
    exam_id integer NOT NULL,
    report_id integer,
    delay_in_hrs integer DEFAULT 72,
    document_id character varying(100),
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.jobs OWNER TO edge;

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

SELECT pg_catalog.setval('jobs_job_id_seq', 1, false);


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
    rsna_id character varying(15) NOT NULL,
    patient_id integer NOT NULL,
    modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE public.patient_rsna_ids OWNER TO edge;

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

SELECT pg_catalog.setval('patient_rsna_ids_map_id_seq', 1, false);


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

SELECT pg_catalog.setval('patients_patient_id_seq', 1, false);


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

COMMENT ON TABLE reports IS 'This table contains exam report and exam status.';


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

SELECT pg_catalog.setval('reports_report_id_seq', 1, false);


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

SELECT pg_catalog.setval('studies_study_id_seq', 1, false);


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

SELECT pg_catalog.setval('transactions_transaction_id_seq', 1, false);


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

SELECT pg_catalog.setval('users_user_id_seq', 1, false);


--
-- Name: v_exam_status; Type: VIEW; Schema: public; Owner: edge
--

CREATE VIEW v_exam_status AS
    SELECT p.patient_id, p.mrn, p.patient_name, p.dob, p.sex, p.street, p.city, p.state, p.zip_code, e.exam_id, e.accession_number, e.exam_description, r.report_id, r.status, r.status_timestamp, r.report_text, r.dictator, r.transcriber, r.signer FROM ((patients p JOIN exams e ON ((p.patient_id = e.patient_id))) JOIN (SELECT r1.report_id, r1.exam_id, r1.proc_code, r1.status, r1.status_timestamp, r1.report_text, r1.signer, r1.dictator, r1.transcriber, r1.modified_date FROM reports r1 WHERE (r1.status_timestamp = (SELECT max(r2.status_timestamp) AS max FROM reports r2 WHERE (r2.exam_id = r1.exam_id)))) r ON ((e.exam_id = r.exam_id)));


ALTER TABLE public.v_exam_status OWNER TO edge;

--
-- Name: v_job_status; Type: VIEW; Schema: public; Owner: edge
--

CREATE VIEW v_job_status AS
    SELECT j.job_id, j.exam_id, j.delay_in_hrs, t.status, t.status_message, t.modified_date AS last_transaction_timestamp FROM (jobs j JOIN (SELECT t1.job_id, t1.status, t1.status_message, t1.modified_date FROM transactions t1 WHERE (t1.modified_date = (SELECT max(t2.modified_date) AS max FROM transactions t2 WHERE (t2.job_id = t1.job_id)))) t ON ((j.job_id = t.job_id)));


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
\.


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY exams (exam_id, accession_number, patient_id, exam_description, modified_date) FROM stdin;
\.


--
-- Data for Name: job_sets; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY job_sets (job_set_id, patient_id, user_id, security_pin, email_address, modified_date) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY jobs (job_id, job_set_id, exam_id, report_id, delay_in_hrs, document_id, modified_date) FROM stdin;
\.


--
-- Data for Name: patient_merge_events; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patient_merge_events (event_id, old_mrn, new_mrn, old_patient_id, new_patient_id, status, modified_date) FROM stdin;
\.


--
-- Data for Name: patient_rsna_ids; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patient_rsna_ids (map_id, rsna_id, patient_id, modified_date) FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY patients (patient_id, mrn, patient_name, dob, sex, street, city, state, zip_code, modified_date) FROM stdin;
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY reports (report_id, exam_id, proc_code, status, status_timestamp, report_text, signer, dictator, transcriber, modified_date) FROM stdin;
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
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY transactions (transaction_id, job_id, status, status_message, modified_date) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: edge
--

COPY users (user_id, user_login, user_name, email, crypted_password, salt, created_at, updated_at, remember_token, remember_token_expires_at, role_id, modified_date) FROM stdin;
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

