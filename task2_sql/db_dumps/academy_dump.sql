--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    c_no integer NOT NULL,
    title character varying(100) NOT NULL,
    hours integer,
    CONSTRAINT courses_hours_check CHECK ((hours > 0))
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_c_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_c_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_c_no_seq OWNER TO postgres;

--
-- Name: courses_c_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_c_no_seq OWNED BY public.courses.c_no;


--
-- Name: exams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exams (
    s_id integer NOT NULL,
    c_no integer NOT NULL,
    score integer,
    CONSTRAINT exams_score_check CHECK (((score >= 0) AND (score <= 100)))
);


ALTER TABLE public.exams OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    s_id integer NOT NULL,
    name character varying(100) NOT NULL,
    start_year integer,
    CONSTRAINT students_start_year_check CHECK (((start_year >= 1900) AND ((start_year)::numeric <= EXTRACT(year FROM CURRENT_DATE))))
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_s_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_s_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_s_id_seq OWNER TO postgres;

--
-- Name: students_s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_s_id_seq OWNED BY public.students.s_id;


--
-- Name: courses c_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN c_no SET DEFAULT nextval('public.courses_c_no_seq'::regclass);


--
-- Name: students s_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN s_id SET DEFAULT nextval('public.students_s_id_seq'::regclass);


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (c_no, title, hours) FROM stdin;
1	Mathematics	100
2	History	80
3	Biology	60
\.


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exams (s_id, c_no, score) FROM stdin;
1	1	85
1	2	90
2	1	75
3	3	88
4	2	79
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (s_id, name, start_year) FROM stdin;
1	Alice	2020
2	Bob	2021
3	Charlie	2022
4	Diana	2023
5	Eve	2021
\.


--
-- Name: courses_c_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_c_no_seq', 3, true);


--
-- Name: students_s_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_s_id_seq', 5, true);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (c_no);


--
-- Name: exams exams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (s_id, c_no);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (s_id);


--
-- Name: exams exams_c_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_c_no_fkey FOREIGN KEY (c_no) REFERENCES public.courses(c_no);


--
-- Name: exams exams_s_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_s_id_fkey FOREIGN KEY (s_id) REFERENCES public.students(s_id);


--
-- PostgreSQL database dump complete
--

