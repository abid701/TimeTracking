--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-31 20:10:35 CET

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 857 (class 1247 OID 16409)
-- Name: employee_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.employee_role AS ENUM (
    'developer',
    'manager',
    'admin',
    'hr',
    'other'
);


ALTER TYPE public.employee_role OWNER TO postgres;

--
-- TOC entry 881 (class 1247 OID 16516)
-- Name: leave_reason_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.leave_reason_type AS ENUM (
    'sick',
    'vacation',
    'personal',
    'other'
);


ALTER TYPE public.leave_reason_type OWNER TO postgres;

--
-- TOC entry 878 (class 1247 OID 16509)
-- Name: leave_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.leave_status_type AS ENUM (
    'pending',
    'approved',
    'denied'
);


ALTER TYPE public.leave_status_type OWNER TO postgres;

--
-- TOC entry 863 (class 1247 OID 16433)
-- Name: status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status AS ENUM (
    'ongoing',
    'completed',
    'paused'
);


ALTER TYPE public.status OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 16456)
-- Name: task_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.task_status_type AS ENUM (
    'todo',
    'in progress',
    'completed'
);


ALTER TYPE public.task_status_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16542)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact_email character varying(255),
    phone character varying(20),
    company_name character varying(255),
    address text
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16541)
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 227
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- TOC entry 218 (class 1259 OID 16420)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    role public.employee_role DEFAULT 'other'::public.employee_role,
    hourly_rate numeric(10,2) DEFAULT 0.00,
    date_hired date DEFAULT CURRENT_DATE,
    is_active boolean DEFAULT true
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16419)
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_id_seq OWNER TO postgres;

--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 217
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- TOC entry 226 (class 1259 OID 16526)
-- Name: leaves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leaves (
    id integer NOT NULL,
    employee_id integer,
    leave_type public.leave_reason_type DEFAULT 'other'::public.leave_reason_type,
    leave_status public.leave_status_type DEFAULT 'pending'::public.leave_status_type,
    reason text
);


ALTER TABLE public.leaves OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16525)
-- Name: leaves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leaves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leaves_id_seq OWNER TO postgres;

--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 225
-- Name: leaves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leaves_id_seq OWNED BY public.leaves.id;


--
-- TOC entry 220 (class 1259 OID 16440)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    client_name character varying(255),
    start_date date DEFAULT CURRENT_DATE,
    end_date date,
    project_status public.status DEFAULT 'ongoing'::public.status,
    description text
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16439)
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO postgres;

--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 219
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- TOC entry 222 (class 1259 OID 16464)
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.tasks OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16463)
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO postgres;

--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 221
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- TOC entry 224 (class 1259 OID 16489)
-- Name: working_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.working_logs (
    id integer NOT NULL,
    employee_id integer,
    project_id integer,
    work_date date DEFAULT CURRENT_DATE,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    total_hours numeric(5,2),
    description text
);


ALTER TABLE public.working_logs OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16488)
-- Name: working_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.working_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.working_logs_id_seq OWNER TO postgres;

--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 223
-- Name: working_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.working_logs_id_seq OWNED BY public.working_logs.id;


--
-- TOC entry 3311 (class 2604 OID 16545)
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 16423)
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- TOC entry 3308 (class 2604 OID 16529)
-- Name: leaves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaves ALTER COLUMN id SET DEFAULT nextval('public.leaves_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16443)
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16467)
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16492)
-- Name: working_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_logs ALTER COLUMN id SET DEFAULT nextval('public.working_logs_id_seq'::regclass);


--
-- TOC entry 3487 (class 0 OID 16542)
-- Dependencies: 228
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clients VALUES (1, 'TechCorp', 'contact@techcorp.com', '123-456-7890', 'TechCorp Inc.', '123 Tech Street, Silicon Valley');
INSERT INTO public.clients VALUES (2, 'EduSoft', 'support@edusoft.com', '987-654-3210', 'EduSoft Solutions', '456 Learning Ave, New York');
INSERT INTO public.clients VALUES (3, 'MediCare', 'info@medicare.com', '555-123-4567', 'MediCare Systems', '789 Health Blvd, Boston');


--
-- TOC entry 3477 (class 0 OID 16420)
-- Dependencies: 218
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employees VALUES (1, 'Alice', 'Johnson', 'alice.johnson@example.com', 'developer', 35.50, '2023-06-15', true);
INSERT INTO public.employees VALUES (2, 'Bob', 'Smith', 'bob.smith@example.com', 'manager', 50.00, '2022-08-20', true);
INSERT INTO public.employees VALUES (3, 'Charlie', 'Brown', 'charlie.brown@example.com', 'admin', 45.00, '2021-05-12', false);
INSERT INTO public.employees VALUES (4, 'David', 'Williams', 'david.williams@example.com', 'hr', 30.00, '2023-01-05', true);
INSERT INTO public.employees VALUES (5, 'Emma', 'Davis', 'emma.davis@example.com', 'developer', 38.75, '2022-11-10', true);
INSERT INTO public.employees VALUES (6, 'Frank', 'Miller', 'frank.miller@example.com', 'other', 25.00, '2023-07-01', true);
INSERT INTO public.employees VALUES (7, 'Grace', 'Wilson', 'grace.wilson@example.com', 'manager', 55.00, '2020-12-30', false);
INSERT INTO public.employees VALUES (8, 'Henry', 'Moore', 'henry.moore@example.com', 'developer', 40.00, '2021-09-17', true);
INSERT INTO public.employees VALUES (9, 'Isabella', 'Taylor', 'isabella.taylor@example.com', 'hr', 32.50, '2023-02-14', true);
INSERT INTO public.employees VALUES (10, 'Jack', 'Anderson', 'jack.anderson@example.com', 'admin', 47.00, '2022-03-23', true);


--
-- TOC entry 3485 (class 0 OID 16526)
-- Dependencies: 226
-- Data for Name: leaves; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.leaves VALUES (1, 2, 'vacation', 'approved', 'Family vacation to Hawaii');
INSERT INTO public.leaves VALUES (2, 5, 'sick', 'pending', 'Flu and fever, need a few days off');
INSERT INTO public.leaves VALUES (3, 9, 'personal', 'denied', 'Personal matters');
INSERT INTO public.leaves VALUES (4, 3, 'other', 'approved', 'Attending an IT conference');
INSERT INTO public.leaves VALUES (5, 8, 'vacation', 'approved', 'Trip to Europe');
INSERT INTO public.leaves VALUES (6, 6, 'sick', 'pending', 'Recovering from surgery');


--
-- TOC entry 3479 (class 0 OID 16440)
-- Dependencies: 220
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.projects VALUES (1, 'Website Redesign', 'TechCorp', '2024-01-01', '2024-06-30', 'ongoing', 'Redesigning the corporate website');
INSERT INTO public.projects VALUES (2, 'E-learning Platform', 'EduSoft', '2023-11-01', '2024-07-15', 'ongoing', 'Developing an e-learning platform');
INSERT INTO public.projects VALUES (3, 'Healthcare App', 'MediCare', '2024-02-10', '2024-12-20', 'ongoing', 'Building a telemedicine application');


--
-- TOC entry 3481 (class 0 OID 16464)
-- Dependencies: 222
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tasks VALUES (1, 1, 'UI Design', 'Create the homepage and landing page designs', 1, 'in progress', '2024-02-28');
INSERT INTO public.tasks VALUES (2, 1, 'Backend API', 'Develop authentication and user management API', 3, 'todo', '2024-03-15');
INSERT INTO public.tasks VALUES (3, 2, 'Course Content Upload', 'Implement video content upload feature', 5, 'in progress', '2024-04-10');
INSERT INTO public.tasks VALUES (4, 2, 'Testing Phase', 'Conduct QA and user testing', 7, 'todo', '2024-05-20');
INSERT INTO public.tasks VALUES (5, 3, 'Database Setup', 'Design and implement database schema', 8, 'completed', '2024-03-01');
INSERT INTO public.tasks VALUES (6, 3, 'UI Improvements', 'Improve UX/UI based on feedback', 1, 'todo', '2024-06-10');


--
-- TOC entry 3483 (class 0 OID 16489)
-- Dependencies: 224
-- Data for Name: working_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.working_logs VALUES (1, 1, 1, '2024-01-25', '09:00:00', '17:00:00', 8.00, 'Worked on UI design for homepage');
INSERT INTO public.working_logs VALUES (2, 3, 1, '2024-01-25', '10:00:00', '18:00:00', 8.00, 'Developed authentication API');
INSERT INTO public.working_logs VALUES (3, 5, 2, '2024-01-26', '08:30:00', '16:30:00', 8.00, 'Implemented video upload feature');
INSERT INTO public.working_logs VALUES (4, 7, 2, '2024-01-27', '09:00:00', '15:00:00', 6.00, 'Conducted QA testing');
INSERT INTO public.working_logs VALUES (5, 8, 3, '2024-01-28', '10:00:00', '18:30:00', 8.50, 'Designed and implemented database');
INSERT INTO public.working_logs VALUES (6, 1, 3, '2024-01-29', '11:00:00', '17:30:00', 6.50, 'Made UI improvements based on feedback');


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 227
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 3, true);


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 217
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_id_seq', 10, true);


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 225
-- Name: leaves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leaves_id_seq', 6, true);


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 219
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 3, true);


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 221
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 6, true);


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 223
-- Name: working_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.working_logs_id_seq', 6, true);


--
-- TOC entry 3325 (class 2606 OID 16549)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- TOC entry 3313 (class 2606 OID 16431)
-- Name: employees employees_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);


--
-- TOC entry 3315 (class 2606 OID 16429)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 16535)
-- Name: leaves leaves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 16449)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- TOC entry 3319 (class 2606 OID 16472)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 3321 (class 2606 OID 16497)
-- Name: working_logs working_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 16536)
-- Name: leaves leaves_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- TOC entry 3326 (class 2606 OID 16478)
-- Name: tasks tasks_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.employees(id) ON DELETE SET NULL;


--
-- TOC entry 3327 (class 2606 OID 16473)
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- TOC entry 3328 (class 2606 OID 16498)
-- Name: working_logs working_logs_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- TOC entry 3329 (class 2606 OID 16503)
-- Name: working_logs working_logs_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


-- Completed on 2025-01-31 20:10:35 CET

--
-- PostgreSQL database dump complete
--

