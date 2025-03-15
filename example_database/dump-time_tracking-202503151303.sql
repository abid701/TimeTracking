--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-15 13:03:26 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE time_tracking;
--
-- TOC entry 3512 (class 1262 OID 16388)
-- Name: time_tracking; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE time_tracking WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


\connect time_tracking

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 859 (class 1247 OID 16409)
-- Name: employee_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.employee_role AS ENUM (
    'developer',
    'manager',
    'admin',
    'hr',
    'other'
);


--
-- TOC entry 883 (class 1247 OID 16516)
-- Name: leave_reason_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.leave_reason_type AS ENUM (
    'sick',
    'vacation',
    'personal',
    'other'
);


--
-- TOC entry 880 (class 1247 OID 16509)
-- Name: leave_status_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.leave_status_type AS ENUM (
    'pending',
    'approved',
    'denied'
);


--
-- TOC entry 865 (class 1247 OID 16433)
-- Name: status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.status AS ENUM (
    'ongoing',
    'completed',
    'paused'
);


--
-- TOC entry 871 (class 1247 OID 16456)
-- Name: task_status_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_status_type AS ENUM (
    'todo',
    'in progress',
    'completed'
);


--
-- TOC entry 892 (class 1247 OID 16551)
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'ROLE_ADMIN',
    'ROLE_USER'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16542)
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact_email character varying(255),
    phone character varying(20),
    company_name character varying(255),
    address text
);


--
-- TOC entry 227 (class 1259 OID 16541)
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 227
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- TOC entry 218 (class 1259 OID 16420)
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    employee_position character varying(255) DEFAULT 'other'::public.employee_role,
    hourly_rate real DEFAULT 0.00,
    date_hired date DEFAULT CURRENT_DATE,
    is_active boolean DEFAULT true,
    card_id character varying(400)
);


--
-- TOC entry 217 (class 1259 OID 16419)
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 217
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- TOC entry 226 (class 1259 OID 16526)
-- Name: leaves; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leaves (
    id integer NOT NULL,
    employee_id integer,
    leave_type public.leave_reason_type DEFAULT 'other'::public.leave_reason_type,
    leave_status public.leave_status_type DEFAULT 'pending'::public.leave_status_type,
    reason text
);


--
-- TOC entry 225 (class 1259 OID 16525)
-- Name: leaves_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leaves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 225
-- Name: leaves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leaves_id_seq OWNED BY public.leaves.id;


--
-- TOC entry 220 (class 1259 OID 16440)
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    client_name character varying(255),
    start_date date DEFAULT CURRENT_DATE,
    end_date date,
    project_status character varying(255) DEFAULT 'ongoing'::public.status,
    description character varying(255)
);


--
-- TOC entry 219 (class 1259 OID 16439)
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 219
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- TOC entry 222 (class 1259 OID 16464)
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    project_id integer,
    name character varying(255) NOT NULL,
    description text,
    assigned_to integer,
    task_status public.task_status_type DEFAULT 'todo'::public.task_status_type,
    deadline date
);


--
-- TOC entry 221 (class 1259 OID 16463)
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 221
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- TOC entry 230 (class 1259 OID 16556)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255) DEFAULT 'ROLE_USER'::public.user_role,
    employee_id integer
);


--
-- TOC entry 229 (class 1259 OID 16555)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 224 (class 1259 OID 16489)
-- Name: working_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.working_logs (
    id integer NOT NULL,
    employee_id integer,
    project_id integer,
    work_date date DEFAULT CURRENT_DATE,
    start_time time without time zone,
    end_time time without time zone,
    total_hours real,
    description character varying(255),
    break_started time without time zone,
    break_ended time without time zone,
    break_total character varying(255),
    card_id character varying(400)
);


--
-- TOC entry 223 (class 1259 OID 16488)
-- Name: working_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.working_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 223
-- Name: working_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.working_logs_id_seq OWNED BY public.working_logs.id;


--
-- TOC entry 3319 (class 2604 OID 16545)
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16423)
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- TOC entry 3316 (class 2604 OID 16529)
-- Name: leaves id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leaves ALTER COLUMN id SET DEFAULT nextval('public.leaves_id_seq'::regclass);


--
-- TOC entry 3309 (class 2604 OID 16443)
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 16467)
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- TOC entry 3320 (class 2604 OID 16559)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3314 (class 2604 OID 16492)
-- Name: working_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.working_logs ALTER COLUMN id SET DEFAULT nextval('public.working_logs_id_seq'::regclass);


--
-- TOC entry 3504 (class 0 OID 16542)
-- Dependencies: 228
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.clients VALUES (1, 'TechCorp', 'contact@techcorp.com', '123-456-7890', 'TechCorp Inc.', '123 Tech Street, Silicon Valley');
INSERT INTO public.clients VALUES (2, 'EduSoft', 'support@edusoft.com', '987-654-3210', 'EduSoft Solutions', '456 Learning Ave, New York');
INSERT INTO public.clients VALUES (3, 'MediCare', 'info@medicare.com', '555-123-4567', 'MediCare Systems', '789 Health Blvd, Boston');


--
-- TOC entry 3494 (class 0 OID 16420)
-- Dependencies: 218
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.employees VALUES (11, 'juli', 'bully', 'july.bully@gmail.com', 'developer', 35.5, '2023-06-15', true, '0004297769');
INSERT INTO public.employees VALUES (4, 'David', 'Williams', 'david.williams@example.com', 'hr', 30, '2023-01-05', true, '567568769');
INSERT INTO public.employees VALUES (5, 'Emma', 'Davis', 'emma.davis@example.com', 'developer', 38.75, '2022-11-10', true, '567568769');
INSERT INTO public.employees VALUES (6, 'Frank', 'Miller', 'frank.miller@example.com', 'other', 25, '2023-07-01', true, '567568769');
INSERT INTO public.employees VALUES (10, 'Jack', 'Anderson', 'jack.anderson@example.com', 'admin', 47, '2022-03-23', true, '567568769');
INSERT INTO public.employees VALUES (2, 'Bob', 'Smith', 'bob.smith@example.com', 'manager', 50, '2022-08-20', true, '567568768');
INSERT INTO public.employees VALUES (3, 'Charlie', 'Brown', 'charlie.brown@example.com', 'admin', 45, '2021-05-12', false, '567568768');
INSERT INTO public.employees VALUES (7, 'Grace', 'Wilson', 'grace.wilson@example.com', 'manager', 55, '2020-12-30', false, '122355632');
INSERT INTO public.employees VALUES (1, 'Alice', 'Johnson', 'alice.johnson@example.com', 'developer', 35.5, '2023-06-15', true, '567568766');
INSERT INTO public.employees VALUES (8, 'Henry', 'Moore', 'henry.moore@example.com', 'developer', 40, '2021-09-17', true, '567568765');
INSERT INTO public.employees VALUES (9, 'Isabella', 'Taylor', 'isabella.taylor@example.com', 'hr', 32.5, '2023-02-14', true, '567568764');
INSERT INTO public.employees VALUES (13, 'Abid', 'Erfan', 'abid.erfan@gmail.com', 'developer', 12, '2025-03-10', true, '12345676');


--
-- TOC entry 3502 (class 0 OID 16526)
-- Dependencies: 226
-- Data for Name: leaves; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.leaves VALUES (1, 2, 'vacation', 'approved', 'Family vacation to Hawaii');
INSERT INTO public.leaves VALUES (2, 5, 'sick', 'pending', 'Flu and fever, need a few days off');
INSERT INTO public.leaves VALUES (3, 9, 'personal', 'denied', 'Personal matters');
INSERT INTO public.leaves VALUES (4, 3, 'other', 'approved', 'Attending an IT conference');
INSERT INTO public.leaves VALUES (5, 8, 'vacation', 'approved', 'Trip to Europe');
INSERT INTO public.leaves VALUES (6, 6, 'sick', 'pending', 'Recovering from surgery');


--
-- TOC entry 3496 (class 0 OID 16440)
-- Dependencies: 220
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.projects VALUES (1, 'Website Redesign', 'TechCorp', '2024-01-01', '2024-06-30', 'ongoing', 'Redesigning the corporate website');
INSERT INTO public.projects VALUES (2, 'E-learning Platform', 'EduSoft', '2023-11-01', '2024-07-15', 'ongoing', 'Developing an e-learning platform');
INSERT INTO public.projects VALUES (3, 'Healthcare App', 'MediCare', '2024-02-10', '2024-12-20', 'ongoing', 'Building a telemedicine application');
INSERT INTO public.projects VALUES (4, 'App development', 'Grassau', '2025-02-10', '2025-03-11', 'completed', 'Grassau Time App development');
INSERT INTO public.projects VALUES (5, 'Robot Development', 'Myself', '2025-01-04', NULL, 'paused', 'Autonomous robot');


--
-- TOC entry 3498 (class 0 OID 16464)
-- Dependencies: 222
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tasks VALUES (1, 1, 'UI Design', 'Create the homepage and landing page designs', 1, 'in progress', '2024-02-28');
INSERT INTO public.tasks VALUES (2, 1, 'Backend API', 'Develop authentication and user management API', 3, 'todo', '2024-03-15');
INSERT INTO public.tasks VALUES (3, 2, 'Course Content Upload', 'Implement video content upload feature', 5, 'in progress', '2024-04-10');
INSERT INTO public.tasks VALUES (4, 2, 'Testing Phase', 'Conduct QA and user testing', 7, 'todo', '2024-05-20');
INSERT INTO public.tasks VALUES (5, 3, 'Database Setup', 'Design and implement database schema', 8, 'completed', '2024-03-01');
INSERT INTO public.tasks VALUES (6, 3, 'UI Improvements', 'Improve UX/UI based on feedback', 1, 'todo', '2024-06-10');


--
-- TOC entry 3506 (class 0 OID 16556)
-- Dependencies: 230
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'test', '$2a$10$zgR3UQ5fOMKd0eu46CrVZeuoayTfDMuI.n6Z8E.ETAFXB5uytAIAO', 'USER', 4);
INSERT INTO public.users VALUES (6, 'abid', '$2a$10$4fXjpGtiqr8.N2gw5EVRGODxjYyGIcaG1aEKQXiUWoIOZt0eS2ErK', 'USER', NULL);
INSERT INTO public.users VALUES (2, 'administrator', '$2a$10$QfnhSLQRp92OFWuOzuga1O6PBlddNNM3M/k7ZteIvR2FF.x4folVq', 'ADMIN', 1);
INSERT INTO public.users VALUES (8, 'test2', '$2a$10$DQzgsTALp4aMOKLilfQT3u9aHRrVzLxacnIZ7DI1Kpr209V7o20RO', 'ADMIN', NULL);
INSERT INTO public.users VALUES (16, 'test5', '$2a$10$yjQ4cBte/tfioC/RUK1T/OtwgWl3UaM83hxMHJgtNKHHVrHqENRhK', 'USER', NULL);


--
-- TOC entry 3500 (class 0 OID 16489)
-- Dependencies: 224
-- Data for Name: working_logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.working_logs VALUES (1, 1, 1, '2024-01-25', '09:00:00', '17:00:00', 8, 'Worked on UI design for homepage', NULL, NULL, NULL, NULL);
INSERT INTO public.working_logs VALUES (2, 3, 1, '2024-01-25', '10:00:00', '18:00:00', 8, 'Developed authentication API', NULL, NULL, NULL, NULL);
INSERT INTO public.working_logs VALUES (3, 5, 2, '2024-01-26', '08:30:00', '16:30:00', 8, 'Implemented video upload feature', NULL, NULL, NULL, NULL);
INSERT INTO public.working_logs VALUES (4, 7, 2, '2024-01-27', '09:00:00', '15:00:00', 6, 'Conducted QA testing', NULL, NULL, NULL, NULL);
INSERT INTO public.working_logs VALUES (5, 8, 3, '2024-01-28', '10:00:00', '18:30:00', 8.5, 'Designed and implemented database', NULL, NULL, NULL, NULL);
INSERT INTO public.working_logs VALUES (6, 1, 3, '2024-01-29', '11:00:00', '17:30:00', 6.5, 'Made UI improvements based on feedback', NULL, NULL, NULL, NULL);
INSERT INTO public.working_logs VALUES (7, 6, 1, '2024-01-25', '09:00:00', '17:00:00', 6, 'Worked on UI design for Home Page', '12:00:00', '13:00:00', '1', NULL);
INSERT INTO public.working_logs VALUES (9, 11, NULL, '2025-02-22', '13:34:01.138', '17:39:06.675', 0, NULL, '17:38:05.989', '17:39:01.694', NULL, '0004297769');
INSERT INTO public.working_logs VALUES (8, 11, NULL, '2025-02-21', '09:09:03.401', '12:57:54.236', 0, NULL, '12:57:35.216', '12:57:45.531', NULL, '0004297769');
INSERT INTO public.working_logs VALUES (10, 1, NULL, '2025-02-22', '18:09:06.42', NULL, 0, NULL, NULL, NULL, NULL, '567568766');
INSERT INTO public.working_logs VALUES (12, 1, NULL, '2025-02-23', '14:34:20.518', '16:33:53.51', 0, NULL, '14:38:20.019', '16:32:24.784', NULL, '567568766');
INSERT INTO public.working_logs VALUES (13, 8, NULL, '2025-02-23', '16:41:57.82', '16:42:49.817', 0, NULL, '16:42:18.885', '16:42:36.938', NULL, '567568765');
INSERT INTO public.working_logs VALUES (26, 9, NULL, '2025-02-23', '23:25:06.779', '23:41:01.209', 0, NULL, '23:40:45.493', '23:40:51.975', NULL, '567568764');
INSERT INTO public.working_logs VALUES (27, 9, NULL, '2025-02-26', '08:14:07.008', '08:16:33.95', 0, NULL, '08:14:57.96', '08:15:03.944', NULL, '567568764');
INSERT INTO public.working_logs VALUES (28, 9, NULL, '2025-03-02', '17:57:11.422', '17:57:36.501', 0, NULL, '17:57:27.048', '17:57:32.417', NULL, '567568764');
INSERT INTO public.working_logs VALUES (31, 13, NULL, '2025-03-10', '22:03:58.91', '22:04:27.318', 0, NULL, '22:04:08.608', '22:04:19.674', NULL, '12345676');


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 227
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clients_id_seq', 3, true);


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 217
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employees_id_seq', 14, true);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 225
-- Name: leaves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.leaves_id_seq', 6, true);


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 219
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.projects_id_seq', 7, true);


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 221
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tasks_id_seq', 6, true);


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 223
-- Name: working_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.working_logs_id_seq', 32, true);


--
-- TOC entry 3335 (class 2606 OID 16549)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 16431)
-- Name: employees employees_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);


--
-- TOC entry 3325 (class 2606 OID 16429)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 16535)
-- Name: leaves leaves_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_pkey PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 16449)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 16472)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 16568)
-- Name: users users_password_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_password_key UNIQUE (password);


--
-- TOC entry 3339 (class 2606 OID 16564)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3341 (class 2606 OID 16566)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3331 (class 2606 OID 16497)
-- Name: working_logs working_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 3347 (class 2606 OID 16569)
-- Name: users fk_users_employees; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_employees FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- TOC entry 3346 (class 2606 OID 16536)
-- Name: leaves leaves_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- TOC entry 3342 (class 2606 OID 16478)
-- Name: tasks tasks_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.employees(id) ON DELETE SET NULL;


--
-- TOC entry 3343 (class 2606 OID 16473)
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- TOC entry 3344 (class 2606 OID 16498)
-- Name: working_logs working_logs_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- TOC entry 3345 (class 2606 OID 16503)
-- Name: working_logs working_logs_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


-- Completed on 2025-03-15 13:03:26 CET

--
-- PostgreSQL database dump complete
--

