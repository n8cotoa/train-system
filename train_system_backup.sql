--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: administrators; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE administrators (
    id integer NOT NULL,
    email character varying,
    password character varying
);


ALTER TABLE administrators OWNER TO "Guest";

--
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE administrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrators_id_seq OWNER TO "Guest";

--
-- Name: administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE administrators_id_seq OWNED BY administrators.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE cities (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE cities OWNER TO "Guest";

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cities_id_seq OWNER TO "Guest";

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE cities_id_seq OWNED BY cities.id;


--
-- Name: stops; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE stops (
    id integer NOT NULL,
    city_id integer,
    train_id integer,
    "time" timestamp without time zone
);


ALTER TABLE stops OWNER TO "Guest";

--
-- Name: stops_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE stops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stops_id_seq OWNER TO "Guest";

--
-- Name: stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE stops_id_seq OWNED BY stops.id;


--
-- Name: trains; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE trains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE trains OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE trains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trains_id_seq OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE trains_id_seq OWNED BY trains.id;


--
-- Name: administrators id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY administrators ALTER COLUMN id SET DEFAULT nextval('administrators_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY cities ALTER COLUMN id SET DEFAULT nextval('cities_id_seq'::regclass);


--
-- Name: stops id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY stops ALTER COLUMN id SET DEFAULT nextval('stops_id_seq'::regclass);


--
-- Name: trains id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY trains ALTER COLUMN id SET DEFAULT nextval('trains_id_seq'::regclass);


--
-- Data for Name: administrators; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY administrators (id, email, password) FROM stdin;
1	tacobell@gmail.com	tacobellrules
\.


--
-- Name: administrators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('administrators_id_seq', 1, true);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY cities (id, name) FROM stdin;
\.


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('cities_id_seq', 1, false);


--
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY stops (id, city_id, train_id, "time") FROM stdin;
\.


--
-- Name: stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('stops_id_seq', 1, false);


--
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY trains (id, name) FROM stdin;
\.


--
-- Name: trains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('trains_id_seq', 1, false);


--
-- Name: administrators administrators_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY administrators
    ADD CONSTRAINT administrators_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: stops stops_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (id);


--
-- Name: trains trains_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY trains
    ADD CONSTRAINT trains_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

