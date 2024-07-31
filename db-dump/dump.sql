--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-07-31 13:02:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4986 (class 1262 OID 16394)
-- Name: isotope-studio; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "isotope-studio" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';


\connect -reuse-previous=on "dbname='isotope-studio'"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16395)
-- Name: administrators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.administrators (
    id bigint NOT NULL,
    account character varying(32) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100),
    key character varying(100),
    expiration information_schema.time_stamp DEFAULT NULL::timestamp with time zone
);


--
-- TOC entry 216 (class 1259 OID 16399)
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.administrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 216
-- Name: administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.administrators_id_seq OWNED BY public.administrators.id;


--
-- TOC entry 217 (class 1259 OID 16400)
-- Name: authors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authors (
    id bigint NOT NULL,
    surname character varying(36) NOT NULL,
    name character varying(36) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16403)
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 218
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- TOC entry 219 (class 1259 OID 16404)
-- Name: chem_elements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chem_elements (
    id bigint NOT NULL,
    element character varying(100) NOT NULL,
    isotope boolean DEFAULT false NOT NULL,
    "group" character varying(100)
);


--
-- TOC entry 220 (class 1259 OID 16408)
-- Name: chem_elements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chem_elements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 220
-- Name: chem_elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chem_elements_id_seq OWNED BY public.chem_elements.id;


--
-- TOC entry 221 (class 1259 OID 16409)
-- Name: coordinates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coordinates (
    sample_id bigint NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16412)
-- Name: coord; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.coord AS
 SELECT DISTINCT sample_id,
    latitude,
    longitude
   FROM public.coordinates;


--
-- TOC entry 223 (class 1259 OID 16416)
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    country_code character varying(3) NOT NULL,
    country_name character varying(36) NOT NULL,
    old_name character varying(36)
);


--
-- TOC entry 224 (class 1259 OID 16419)
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 224
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- TOC entry 225 (class 1259 OID 16420)
-- Name: dataset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset (
    id bigint NOT NULL,
    file_name character varying(128) NOT NULL,
    metadata text NOT NULL,
    processed boolean DEFAULT false NOT NULL,
    year numeric(4,0),
    link character varying(256),
    authors text
);


--
-- TOC entry 226 (class 1259 OID 16426)
-- Name: dataset_authors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_authors (
    dataset_id bigint NOT NULL,
    author_id bigint NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16429)
-- Name: dataset_authors_author_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_authors_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 227
-- Name: dataset_authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_authors_author_id_seq OWNED BY public.dataset_authors.author_id;


--
-- TOC entry 228 (class 1259 OID 16430)
-- Name: dataset_authors_dataset_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_authors_dataset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 228
-- Name: dataset_authors_dataset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_authors_dataset_id_seq OWNED BY public.dataset_authors.dataset_id;


--
-- TOC entry 229 (class 1259 OID 16431)
-- Name: dataset_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 229
-- Name: dataset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_id_seq OWNED BY public.dataset.id;


--
-- TOC entry 239 (class 1259 OID 73898)
-- Name: keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keywords (
    key character varying(100) NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 73889)
-- Name: matrix; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matrix (
    matrix text NOT NULL,
    level smallint NOT NULL,
    id integer NOT NULL,
    parent_id integer
);


--
-- TOC entry 237 (class 1259 OID 73888)
-- Name: matrix_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matrix_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 237
-- Name: matrix_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matrix_id_seq OWNED BY public.matrix.id;


--
-- TOC entry 240 (class 1259 OID 82079)
-- Name: measure_unit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.measure_unit (
    um character varying(16) NOT NULL,
    to_ppm double precision NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 16523)
-- Name: reservoir; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reservoir (
    id bigint NOT NULL,
    reservoir character varying(36) NOT NULL,
    z smallint,
    element character varying(36) NOT NULL,
    value double precision,
    median double precision,
    sd double precision,
    low double precision,
    high double precision,
    n double precision,
    unit character varying(12),
    info text,
    reference text,
    source text,
    doi character varying(256),
    error double precision,
    error_type character varying(32)
);


--
-- TOC entry 235 (class 1259 OID 16522)
-- Name: reservoir_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reservoir_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 235
-- Name: reservoir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reservoir_id_seq OWNED BY public.reservoir.id;


--
-- TOC entry 230 (class 1259 OID 16432)
-- Name: sample_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sample_attribute (
    sample_id bigint NOT NULL,
    type character(1) NOT NULL,
    name character varying(32) NOT NULL,
    svalue character varying(256),
    nvalue double precision,
    jvalue jsonb,
    um character varying(16)
);


--
-- TOC entry 231 (class 1259 OID 16437)
-- Name: sample_index; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sample_index (
    sample_id bigint NOT NULL,
    ts timestamp with time zone,
    dataset_id bigint
);


--
-- TOC entry 232 (class 1259 OID 16440)
-- Name: sample_index2_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sample_index2_sample_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 232
-- Name: sample_index2_sample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sample_index2_sample_id_seq OWNED BY public.sample_index.sample_id;


--
-- TOC entry 233 (class 1259 OID 16441)
-- Name: spider_normalization; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spider_normalization (
    method character varying(60) NOT NULL,
    norm jsonb,
    ord jsonb
);


--
-- TOC entry 234 (class 1259 OID 16446)
-- Name: synonyms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.synonyms (
    name character varying(60),
    synonym character varying(60)
);


--
-- TOC entry 4757 (class 2604 OID 16449)
-- Name: administrators id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administrators ALTER COLUMN id SET DEFAULT nextval('public.administrators_id_seq'::regclass);


--
-- TOC entry 4759 (class 2604 OID 16450)
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- TOC entry 4760 (class 2604 OID 16451)
-- Name: chem_elements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chem_elements ALTER COLUMN id SET DEFAULT nextval('public.chem_elements_id_seq'::regclass);


--
-- TOC entry 4762 (class 2604 OID 16452)
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- TOC entry 4763 (class 2604 OID 16453)
-- Name: dataset id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset ALTER COLUMN id SET DEFAULT nextval('public.dataset_id_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 16454)
-- Name: dataset_authors dataset_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_authors ALTER COLUMN dataset_id SET DEFAULT nextval('public.dataset_authors_dataset_id_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 16455)
-- Name: dataset_authors author_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_authors ALTER COLUMN author_id SET DEFAULT nextval('public.dataset_authors_author_id_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 73892)
-- Name: matrix id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matrix ALTER COLUMN id SET DEFAULT nextval('public.matrix_id_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 16526)
-- Name: reservoir id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservoir ALTER COLUMN id SET DEFAULT nextval('public.reservoir_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 16456)
-- Name: sample_index sample_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_index ALTER COLUMN sample_id SET DEFAULT nextval('public.sample_index2_sample_id_seq'::regclass);


--
-- TOC entry 4956 (class 0 OID 16395)
-- Dependencies: 215
-- Data for Name: administrators; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.administrators VALUES (13, 'paolo.digiuseppe', 'e87d425e8fc2739c5f98694eb7107675228bb30898381f1ec6fef2351be36d28', 'paolo.digiuseppe@igg.cnr.it', NULL, NULL);
INSERT INTO public.administrators VALUES (12, 'eric.perrone', 'e87d425e8fc2739c5f98694eb7107675228bb30898381f1ec6fef2351be36d28', 'erico.perrone@igg.cnr.it', '4eba7829cc949a03f8363d27e7564826122563ecc478e057409d848239710faf', NULL);
INSERT INTO public.administrators VALUES (11, 'admin', 'e87d425e8fc2739c5f98694eb7107675228bb30898381f1ec6fef2351be36d28', 'perroneeric@gmail.com', '4eac13df2924e2c4dd1dd788a338dba96b0b6668b458794857fc45c39b6a5f86', NULL);
INSERT INTO public.administrators VALUES (14, 'pippo', 'e87d425e8fc2739c5f98694eb7107675228bb30898381f1ec6fef2351be36d28', 'pippo@nomail.com', '36e955cad02f65ca5bc01f18168545882a9322c38257b78db7b6406715d5b245', '2024-04-04 15:18:12.02+02');


--
-- TOC entry 4958 (class 0 OID 16400)
-- Dependencies: 217
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4960 (class 0 OID 16404)
-- Dependencies: 219
-- Data for Name: chem_elements; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.chem_elements VALUES (1, 'Ac', false, NULL);
INSERT INTO public.chem_elements VALUES (2, 'Ag', false, NULL);
INSERT INTO public.chem_elements VALUES (3, 'Al', false, NULL);
INSERT INTO public.chem_elements VALUES (4, 'Am', false, NULL);
INSERT INTO public.chem_elements VALUES (5, 'Ar', false, NULL);
INSERT INTO public.chem_elements VALUES (6, 'As', false, NULL);
INSERT INTO public.chem_elements VALUES (7, 'At', false, NULL);
INSERT INTO public.chem_elements VALUES (8, 'Au', false, NULL);
INSERT INTO public.chem_elements VALUES (9, 'B', false, NULL);
INSERT INTO public.chem_elements VALUES (10, 'Ba', false, NULL);
INSERT INTO public.chem_elements VALUES (11, 'Be', false, NULL);
INSERT INTO public.chem_elements VALUES (12, 'Bh', false, NULL);
INSERT INTO public.chem_elements VALUES (13, 'Bi', false, NULL);
INSERT INTO public.chem_elements VALUES (14, 'Bk', false, NULL);
INSERT INTO public.chem_elements VALUES (15, 'Br', false, NULL);
INSERT INTO public.chem_elements VALUES (16, 'C', false, NULL);
INSERT INTO public.chem_elements VALUES (17, 'Ca', false, NULL);
INSERT INTO public.chem_elements VALUES (18, 'Cd', false, NULL);
INSERT INTO public.chem_elements VALUES (19, 'Ce', false, NULL);
INSERT INTO public.chem_elements VALUES (20, 'Cf', false, NULL);
INSERT INTO public.chem_elements VALUES (21, 'Cl', false, NULL);
INSERT INTO public.chem_elements VALUES (22, 'Cm', false, NULL);
INSERT INTO public.chem_elements VALUES (23, 'Co', false, NULL);
INSERT INTO public.chem_elements VALUES (24, 'Cr', false, NULL);
INSERT INTO public.chem_elements VALUES (25, 'Cs', false, NULL);
INSERT INTO public.chem_elements VALUES (26, 'Cu', false, NULL);
INSERT INTO public.chem_elements VALUES (27, 'Db', false, NULL);
INSERT INTO public.chem_elements VALUES (28, 'Ds', false, NULL);
INSERT INTO public.chem_elements VALUES (29, 'Dy', false, NULL);
INSERT INTO public.chem_elements VALUES (30, 'Er', false, NULL);
INSERT INTO public.chem_elements VALUES (31, 'Es', false, NULL);
INSERT INTO public.chem_elements VALUES (32, 'Eu', false, NULL);
INSERT INTO public.chem_elements VALUES (33, 'F', false, NULL);
INSERT INTO public.chem_elements VALUES (34, 'Fe', false, NULL);
INSERT INTO public.chem_elements VALUES (35, 'Fm', false, NULL);
INSERT INTO public.chem_elements VALUES (36, 'Fr', false, NULL);
INSERT INTO public.chem_elements VALUES (37, 'Ga', false, NULL);
INSERT INTO public.chem_elements VALUES (38, 'Gd', false, NULL);
INSERT INTO public.chem_elements VALUES (39, 'Ge', false, NULL);
INSERT INTO public.chem_elements VALUES (40, 'H', false, NULL);
INSERT INTO public.chem_elements VALUES (41, 'He', false, NULL);
INSERT INTO public.chem_elements VALUES (42, 'Hf', false, NULL);
INSERT INTO public.chem_elements VALUES (43, 'Hg', false, NULL);
INSERT INTO public.chem_elements VALUES (44, 'Ho', false, NULL);
INSERT INTO public.chem_elements VALUES (45, 'Hs', false, NULL);
INSERT INTO public.chem_elements VALUES (46, 'I', false, NULL);
INSERT INTO public.chem_elements VALUES (47, 'In', false, NULL);
INSERT INTO public.chem_elements VALUES (48, 'Ir', false, NULL);
INSERT INTO public.chem_elements VALUES (49, 'K', false, NULL);
INSERT INTO public.chem_elements VALUES (50, 'Kr', false, NULL);
INSERT INTO public.chem_elements VALUES (51, 'La', false, NULL);
INSERT INTO public.chem_elements VALUES (52, 'Li', false, NULL);
INSERT INTO public.chem_elements VALUES (53, 'Lr', false, NULL);
INSERT INTO public.chem_elements VALUES (54, 'Lu', false, NULL);
INSERT INTO public.chem_elements VALUES (55, 'Md', false, NULL);
INSERT INTO public.chem_elements VALUES (56, 'Mg', false, NULL);
INSERT INTO public.chem_elements VALUES (57, 'Mn', false, NULL);
INSERT INTO public.chem_elements VALUES (58, 'Mo', false, NULL);
INSERT INTO public.chem_elements VALUES (59, 'Mt', false, NULL);
INSERT INTO public.chem_elements VALUES (60, 'N', false, NULL);
INSERT INTO public.chem_elements VALUES (61, 'Na', false, NULL);
INSERT INTO public.chem_elements VALUES (62, 'Nb', false, NULL);
INSERT INTO public.chem_elements VALUES (63, 'Nd', false, NULL);
INSERT INTO public.chem_elements VALUES (64, 'Ne', false, NULL);
INSERT INTO public.chem_elements VALUES (65, 'Ni', false, NULL);
INSERT INTO public.chem_elements VALUES (66, 'No', false, NULL);
INSERT INTO public.chem_elements VALUES (67, 'Np', false, NULL);
INSERT INTO public.chem_elements VALUES (68, 'O', false, NULL);
INSERT INTO public.chem_elements VALUES (69, 'Os', false, NULL);
INSERT INTO public.chem_elements VALUES (70, 'P', false, NULL);
INSERT INTO public.chem_elements VALUES (71, 'Pa', false, NULL);
INSERT INTO public.chem_elements VALUES (72, 'Pb', false, NULL);
INSERT INTO public.chem_elements VALUES (73, 'Pd', false, NULL);
INSERT INTO public.chem_elements VALUES (74, 'Pm', false, NULL);
INSERT INTO public.chem_elements VALUES (75, 'Po', false, NULL);
INSERT INTO public.chem_elements VALUES (76, 'Pr', false, NULL);
INSERT INTO public.chem_elements VALUES (77, 'Pt', false, NULL);
INSERT INTO public.chem_elements VALUES (78, 'Pu', false, NULL);
INSERT INTO public.chem_elements VALUES (79, 'Ra', false, NULL);
INSERT INTO public.chem_elements VALUES (80, 'Rb', false, NULL);
INSERT INTO public.chem_elements VALUES (81, 'Re', false, NULL);
INSERT INTO public.chem_elements VALUES (82, 'Rf', false, NULL);
INSERT INTO public.chem_elements VALUES (83, 'Rg', false, NULL);
INSERT INTO public.chem_elements VALUES (84, 'Rh', false, NULL);
INSERT INTO public.chem_elements VALUES (85, 'Rn', false, NULL);
INSERT INTO public.chem_elements VALUES (86, 'Ru', false, NULL);
INSERT INTO public.chem_elements VALUES (87, 'S', false, NULL);
INSERT INTO public.chem_elements VALUES (88, 'Sb', false, NULL);
INSERT INTO public.chem_elements VALUES (89, 'Sc', false, NULL);
INSERT INTO public.chem_elements VALUES (90, 'Se', false, NULL);
INSERT INTO public.chem_elements VALUES (91, 'Sg', false, NULL);
INSERT INTO public.chem_elements VALUES (92, 'Si', false, NULL);
INSERT INTO public.chem_elements VALUES (93, 'Sm', false, NULL);
INSERT INTO public.chem_elements VALUES (94, 'Sn', false, NULL);
INSERT INTO public.chem_elements VALUES (95, 'Sr', false, NULL);
INSERT INTO public.chem_elements VALUES (96, 'Ta', false, NULL);
INSERT INTO public.chem_elements VALUES (97, 'Tb', false, NULL);
INSERT INTO public.chem_elements VALUES (98, 'Tc', false, NULL);
INSERT INTO public.chem_elements VALUES (99, 'Te', false, NULL);
INSERT INTO public.chem_elements VALUES (100, 'Th', false, NULL);
INSERT INTO public.chem_elements VALUES (101, 'Ti', false, NULL);
INSERT INTO public.chem_elements VALUES (102, 'Tl', false, NULL);
INSERT INTO public.chem_elements VALUES (103, 'Tm', false, NULL);
INSERT INTO public.chem_elements VALUES (104, 'U', false, NULL);
INSERT INTO public.chem_elements VALUES (105, 'Cn', false, NULL);
INSERT INTO public.chem_elements VALUES (106, 'Lv', false, NULL);
INSERT INTO public.chem_elements VALUES (107, 'Og', false, NULL);
INSERT INTO public.chem_elements VALUES (108, 'Mc', false, NULL);
INSERT INTO public.chem_elements VALUES (109, 'Fl', false, NULL);
INSERT INTO public.chem_elements VALUES (110, 'Ts', false, NULL);
INSERT INTO public.chem_elements VALUES (111, 'Nh', false, NULL);
INSERT INTO public.chem_elements VALUES (112, 'V', false, NULL);
INSERT INTO public.chem_elements VALUES (113, 'W', false, NULL);
INSERT INTO public.chem_elements VALUES (114, 'Xe', false, NULL);
INSERT INTO public.chem_elements VALUES (115, 'Y', false, NULL);
INSERT INTO public.chem_elements VALUES (116, 'Yb', false, NULL);
INSERT INTO public.chem_elements VALUES (117, 'Zn', false, NULL);
INSERT INTO public.chem_elements VALUES (118, 'Zr', false, NULL);
INSERT INTO public.chem_elements VALUES (119, 'SiO2', false, NULL);
INSERT INTO public.chem_elements VALUES (120, 'TiO2', false, NULL);
INSERT INTO public.chem_elements VALUES (121, 'Al2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (122, 'Fe2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (123, 'Fe2O3 (Tot)', false, NULL);
INSERT INTO public.chem_elements VALUES (124, 'FeO', false, NULL);
INSERT INTO public.chem_elements VALUES (125, 'FeO (Tot)', false, NULL);
INSERT INTO public.chem_elements VALUES (126, 'MgO', false, NULL);
INSERT INTO public.chem_elements VALUES (127, 'CaO', false, NULL);
INSERT INTO public.chem_elements VALUES (128, 'Na2O', false, NULL);
INSERT INTO public.chem_elements VALUES (129, 'K2O', false, NULL);
INSERT INTO public.chem_elements VALUES (130, 'P2O5', false, NULL);
INSERT INTO public.chem_elements VALUES (131, 'MnO', false, NULL);
INSERT INTO public.chem_elements VALUES (132, 'Cr2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (133, 'NiO', false, NULL);
INSERT INTO public.chem_elements VALUES (134, 'CaCO3', false, NULL);
INSERT INTO public.chem_elements VALUES (135, 'LOI', false, NULL);
INSERT INTO public.chem_elements VALUES (136, 'H2O+', false, NULL);
INSERT INTO public.chem_elements VALUES (137, 'H2O-', false, NULL);
INSERT INTO public.chem_elements VALUES (138, 'H2O', false, NULL);
INSERT INTO public.chem_elements VALUES (139, 'H2O (Tot)', false, NULL);
INSERT INTO public.chem_elements VALUES (140, 'CO2', false, NULL);
INSERT INTO public.chem_elements VALUES (141, 'F', false, NULL);
INSERT INTO public.chem_elements VALUES (142, 'Cl', false, NULL);
INSERT INTO public.chem_elements VALUES (143, '1H', true, NULL);
INSERT INTO public.chem_elements VALUES (144, 'H1', true, NULL);
INSERT INTO public.chem_elements VALUES (145, '2H', true, NULL);
INSERT INTO public.chem_elements VALUES (146, 'H2', true, NULL);
INSERT INTO public.chem_elements VALUES (147, '3H', true, NULL);
INSERT INTO public.chem_elements VALUES (148, 'H3', true, NULL);
INSERT INTO public.chem_elements VALUES (149, '4H', true, NULL);
INSERT INTO public.chem_elements VALUES (150, 'H4', true, NULL);
INSERT INTO public.chem_elements VALUES (151, '6Li', true, NULL);
INSERT INTO public.chem_elements VALUES (152, 'Li6', true, NULL);
INSERT INTO public.chem_elements VALUES (153, '7Li', true, NULL);
INSERT INTO public.chem_elements VALUES (154, 'Li7', true, NULL);
INSERT INTO public.chem_elements VALUES (155, '10B', true, NULL);
INSERT INTO public.chem_elements VALUES (156, 'B10', true, NULL);
INSERT INTO public.chem_elements VALUES (157, '11B', true, NULL);
INSERT INTO public.chem_elements VALUES (158, 'B11', true, NULL);
INSERT INTO public.chem_elements VALUES (159, '12C', true, NULL);
INSERT INTO public.chem_elements VALUES (160, 'C12', true, NULL);
INSERT INTO public.chem_elements VALUES (161, '13C', true, NULL);
INSERT INTO public.chem_elements VALUES (162, 'C13', true, NULL);
INSERT INTO public.chem_elements VALUES (163, '14C', true, NULL);
INSERT INTO public.chem_elements VALUES (164, 'C14', true, NULL);
INSERT INTO public.chem_elements VALUES (165, '14N', true, NULL);
INSERT INTO public.chem_elements VALUES (166, 'N14', true, NULL);
INSERT INTO public.chem_elements VALUES (167, '15N', true, NULL);
INSERT INTO public.chem_elements VALUES (168, 'N15', true, NULL);
INSERT INTO public.chem_elements VALUES (169, '16O', true, NULL);
INSERT INTO public.chem_elements VALUES (170, 'O16', true, NULL);
INSERT INTO public.chem_elements VALUES (171, '17O', true, NULL);
INSERT INTO public.chem_elements VALUES (172, 'O17', true, NULL);
INSERT INTO public.chem_elements VALUES (173, '18O', true, NULL);
INSERT INTO public.chem_elements VALUES (174, 'O18', true, NULL);
INSERT INTO public.chem_elements VALUES (175, '20Ne', true, NULL);
INSERT INTO public.chem_elements VALUES (176, 'Ne20', true, NULL);
INSERT INTO public.chem_elements VALUES (177, '21Ne', true, NULL);
INSERT INTO public.chem_elements VALUES (178, 'Ne21', true, NULL);
INSERT INTO public.chem_elements VALUES (179, '22Ne', true, NULL);
INSERT INTO public.chem_elements VALUES (180, 'Ne22', true, NULL);
INSERT INTO public.chem_elements VALUES (181, '24Mg', true, NULL);
INSERT INTO public.chem_elements VALUES (182, 'Mg24', true, NULL);
INSERT INTO public.chem_elements VALUES (183, '25Mg', true, NULL);
INSERT INTO public.chem_elements VALUES (184, 'Mg25', true, NULL);
INSERT INTO public.chem_elements VALUES (185, '26Mg', true, NULL);
INSERT INTO public.chem_elements VALUES (186, 'Mg26', true, NULL);
INSERT INTO public.chem_elements VALUES (187, '28Si', true, NULL);
INSERT INTO public.chem_elements VALUES (188, 'Si28', true, NULL);
INSERT INTO public.chem_elements VALUES (189, '29Si', true, NULL);
INSERT INTO public.chem_elements VALUES (190, 'Si29', true, NULL);
INSERT INTO public.chem_elements VALUES (191, '30Si', true, NULL);
INSERT INTO public.chem_elements VALUES (192, 'Si30', true, NULL);
INSERT INTO public.chem_elements VALUES (193, '32S', true, NULL);
INSERT INTO public.chem_elements VALUES (194, 'S32', true, NULL);
INSERT INTO public.chem_elements VALUES (195, '33S', true, NULL);
INSERT INTO public.chem_elements VALUES (196, 'S33', true, NULL);
INSERT INTO public.chem_elements VALUES (197, '34S', true, NULL);
INSERT INTO public.chem_elements VALUES (198, 'S34', true, NULL);
INSERT INTO public.chem_elements VALUES (199, '36S', true, NULL);
INSERT INTO public.chem_elements VALUES (200, 'S36', true, NULL);
INSERT INTO public.chem_elements VALUES (201, '36Cl', true, NULL);
INSERT INTO public.chem_elements VALUES (202, 'Cl36', true, NULL);
INSERT INTO public.chem_elements VALUES (203, '37Cl', true, NULL);
INSERT INTO public.chem_elements VALUES (204, 'Cl37', true, NULL);
INSERT INTO public.chem_elements VALUES (205, '36Ar', true, NULL);
INSERT INTO public.chem_elements VALUES (206, 'Ar36', true, NULL);
INSERT INTO public.chem_elements VALUES (207, '38Ar', true, NULL);
INSERT INTO public.chem_elements VALUES (208, 'Ar38', true, NULL);
INSERT INTO public.chem_elements VALUES (209, '40Ar', true, NULL);
INSERT INTO public.chem_elements VALUES (210, 'Ar40', true, NULL);
INSERT INTO public.chem_elements VALUES (211, '39K', true, NULL);
INSERT INTO public.chem_elements VALUES (212, 'K39', true, NULL);
INSERT INTO public.chem_elements VALUES (213, '40K', true, NULL);
INSERT INTO public.chem_elements VALUES (214, 'K40', true, NULL);
INSERT INTO public.chem_elements VALUES (215, '41K', true, NULL);
INSERT INTO public.chem_elements VALUES (216, 'K41', true, NULL);
INSERT INTO public.chem_elements VALUES (217, '40Ca', true, NULL);
INSERT INTO public.chem_elements VALUES (218, 'Ca40', true, NULL);
INSERT INTO public.chem_elements VALUES (219, '42Ca', true, NULL);
INSERT INTO public.chem_elements VALUES (220, 'Ca42', true, NULL);
INSERT INTO public.chem_elements VALUES (221, '43Ca', true, NULL);
INSERT INTO public.chem_elements VALUES (222, 'Ca43', true, NULL);
INSERT INTO public.chem_elements VALUES (223, '44Ca', true, NULL);
INSERT INTO public.chem_elements VALUES (224, 'Ca44', true, NULL);
INSERT INTO public.chem_elements VALUES (225, '46Ca', true, NULL);
INSERT INTO public.chem_elements VALUES (226, 'Ca46', true, NULL);
INSERT INTO public.chem_elements VALUES (227, '48Ca', true, NULL);
INSERT INTO public.chem_elements VALUES (228, 'Ca48', true, NULL);
INSERT INTO public.chem_elements VALUES (229, '50Cr', true, NULL);
INSERT INTO public.chem_elements VALUES (230, 'Cr50', true, NULL);
INSERT INTO public.chem_elements VALUES (231, '52Cr', true, NULL);
INSERT INTO public.chem_elements VALUES (232, 'Cr52', true, NULL);
INSERT INTO public.chem_elements VALUES (233, '53Cr', true, NULL);
INSERT INTO public.chem_elements VALUES (234, 'Cr53', true, NULL);
INSERT INTO public.chem_elements VALUES (235, '54Cr', true, NULL);
INSERT INTO public.chem_elements VALUES (236, 'Cr54', true, NULL);
INSERT INTO public.chem_elements VALUES (237, '54Fe', true, NULL);
INSERT INTO public.chem_elements VALUES (238, 'Fe54', true, NULL);
INSERT INTO public.chem_elements VALUES (239, '56Fe', true, NULL);
INSERT INTO public.chem_elements VALUES (240, 'Fe56', true, NULL);
INSERT INTO public.chem_elements VALUES (241, '57Fe', true, NULL);
INSERT INTO public.chem_elements VALUES (242, 'Fe57', true, NULL);
INSERT INTO public.chem_elements VALUES (243, '58Fe', true, NULL);
INSERT INTO public.chem_elements VALUES (244, 'Fe58', true, NULL);
INSERT INTO public.chem_elements VALUES (245, '58Ni', true, NULL);
INSERT INTO public.chem_elements VALUES (246, 'Ni58', true, NULL);
INSERT INTO public.chem_elements VALUES (247, '60Ni', true, NULL);
INSERT INTO public.chem_elements VALUES (248, 'Ni60', true, NULL);
INSERT INTO public.chem_elements VALUES (249, '61Ni', true, NULL);
INSERT INTO public.chem_elements VALUES (250, 'Ni61', true, NULL);
INSERT INTO public.chem_elements VALUES (251, '62Ni', true, NULL);
INSERT INTO public.chem_elements VALUES (252, 'Ni62', true, NULL);
INSERT INTO public.chem_elements VALUES (253, '64Ni', true, NULL);
INSERT INTO public.chem_elements VALUES (254, 'Ni64', true, NULL);
INSERT INTO public.chem_elements VALUES (255, '63Cu', true, NULL);
INSERT INTO public.chem_elements VALUES (256, 'Cu63', true, NULL);
INSERT INTO public.chem_elements VALUES (257, '65Cu', true, NULL);
INSERT INTO public.chem_elements VALUES (258, 'Cu65', true, NULL);
INSERT INTO public.chem_elements VALUES (259, '64Zn', true, NULL);
INSERT INTO public.chem_elements VALUES (260, 'Zn64', true, NULL);
INSERT INTO public.chem_elements VALUES (261, '66Zn', true, NULL);
INSERT INTO public.chem_elements VALUES (262, 'Zn66', true, NULL);
INSERT INTO public.chem_elements VALUES (263, '67Zn', true, NULL);
INSERT INTO public.chem_elements VALUES (264, 'Zn67', true, NULL);
INSERT INTO public.chem_elements VALUES (265, '68Zn', true, NULL);
INSERT INTO public.chem_elements VALUES (266, 'Zn68', true, NULL);
INSERT INTO public.chem_elements VALUES (267, '70Zn', true, NULL);
INSERT INTO public.chem_elements VALUES (268, 'Zn70', true, NULL);
INSERT INTO public.chem_elements VALUES (269, '78Kr', true, NULL);
INSERT INTO public.chem_elements VALUES (270, 'Kr78', true, NULL);
INSERT INTO public.chem_elements VALUES (271, '80Kr', true, NULL);
INSERT INTO public.chem_elements VALUES (272, 'Kr80', true, NULL);
INSERT INTO public.chem_elements VALUES (273, '82Kr', true, NULL);
INSERT INTO public.chem_elements VALUES (274, 'Kr82', true, NULL);
INSERT INTO public.chem_elements VALUES (275, '83Kr', true, NULL);
INSERT INTO public.chem_elements VALUES (276, 'Kr83', true, NULL);
INSERT INTO public.chem_elements VALUES (277, '84Kr', true, NULL);
INSERT INTO public.chem_elements VALUES (278, 'K384', true, NULL);
INSERT INTO public.chem_elements VALUES (279, '86Kr', true, NULL);
INSERT INTO public.chem_elements VALUES (280, 'Kr86', true, NULL);
INSERT INTO public.chem_elements VALUES (281, '85Rb', true, NULL);
INSERT INTO public.chem_elements VALUES (282, 'Rb85', true, NULL);
INSERT INTO public.chem_elements VALUES (283, '87Rb', true, NULL);
INSERT INTO public.chem_elements VALUES (284, 'Rb87', true, NULL);
INSERT INTO public.chem_elements VALUES (285, '84Sr', true, NULL);
INSERT INTO public.chem_elements VALUES (286, 'Sr84', true, NULL);
INSERT INTO public.chem_elements VALUES (287, '86Sr', true, NULL);
INSERT INTO public.chem_elements VALUES (288, 'Sr86', true, NULL);
INSERT INTO public.chem_elements VALUES (289, '87Sr', true, NULL);
INSERT INTO public.chem_elements VALUES (290, 'Sr87', true, NULL);
INSERT INTO public.chem_elements VALUES (291, '88Sr', true, NULL);
INSERT INTO public.chem_elements VALUES (292, 'Sr88', true, NULL);
INSERT INTO public.chem_elements VALUES (293, '92Mo', true, NULL);
INSERT INTO public.chem_elements VALUES (294, 'Mo92', true, NULL);
INSERT INTO public.chem_elements VALUES (295, '94Mo', true, NULL);
INSERT INTO public.chem_elements VALUES (296, 'Mo94', true, NULL);
INSERT INTO public.chem_elements VALUES (297, '95Mo', true, NULL);
INSERT INTO public.chem_elements VALUES (298, 'Mo95', true, NULL);
INSERT INTO public.chem_elements VALUES (299, '96Mo', true, NULL);
INSERT INTO public.chem_elements VALUES (300, 'Mo96', true, NULL);
INSERT INTO public.chem_elements VALUES (301, '97Mo', true, NULL);
INSERT INTO public.chem_elements VALUES (302, 'Mo97', true, NULL);
INSERT INTO public.chem_elements VALUES (303, '98Mo', true, NULL);
INSERT INTO public.chem_elements VALUES (304, 'Mo98', true, NULL);
INSERT INTO public.chem_elements VALUES (305, '100Mo', true, NULL);
INSERT INTO public.chem_elements VALUES (306, 'Mo100', true, NULL);
INSERT INTO public.chem_elements VALUES (307, '124Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (308, 'Xe124', true, NULL);
INSERT INTO public.chem_elements VALUES (309, '126Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (310, 'Xe126', true, NULL);
INSERT INTO public.chem_elements VALUES (311, '128Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (312, 'Xe128', true, NULL);
INSERT INTO public.chem_elements VALUES (313, '129Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (314, 'Xe129', true, NULL);
INSERT INTO public.chem_elements VALUES (315, '130Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (316, 'Xe130', true, NULL);
INSERT INTO public.chem_elements VALUES (317, '131Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (318, 'Xe131', true, NULL);
INSERT INTO public.chem_elements VALUES (319, '132Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (320, 'Xe132', true, NULL);
INSERT INTO public.chem_elements VALUES (321, '134Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (322, 'Xe134', true, NULL);
INSERT INTO public.chem_elements VALUES (323, '136Xe', true, NULL);
INSERT INTO public.chem_elements VALUES (324, 'Xe136', true, NULL);
INSERT INTO public.chem_elements VALUES (325, '142Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (326, 'Nd142', true, NULL);
INSERT INTO public.chem_elements VALUES (327, '143Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (328, 'Nd143', true, NULL);
INSERT INTO public.chem_elements VALUES (329, '144Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (330, 'Nd144', true, NULL);
INSERT INTO public.chem_elements VALUES (331, '145Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (332, 'Nd145', true, NULL);
INSERT INTO public.chem_elements VALUES (333, '146Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (334, 'Nd146', true, NULL);
INSERT INTO public.chem_elements VALUES (335, '148Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (336, 'Nd148', true, NULL);
INSERT INTO public.chem_elements VALUES (337, '150Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (338, 'Nd150', true, NULL);
INSERT INTO public.chem_elements VALUES (339, '174Hf', true, NULL);
INSERT INTO public.chem_elements VALUES (340, 'Hf174', true, NULL);
INSERT INTO public.chem_elements VALUES (341, '175Hf', true, NULL);
INSERT INTO public.chem_elements VALUES (342, 'Hf175', true, NULL);
INSERT INTO public.chem_elements VALUES (343, '177Hf', true, NULL);
INSERT INTO public.chem_elements VALUES (344, 'Hf177', true, NULL);
INSERT INTO public.chem_elements VALUES (345, '178Hf', true, NULL);
INSERT INTO public.chem_elements VALUES (346, 'Hf178', true, NULL);
INSERT INTO public.chem_elements VALUES (347, '179Hf', true, NULL);
INSERT INTO public.chem_elements VALUES (348, 'Hf179', true, NULL);
INSERT INTO public.chem_elements VALUES (349, '180Hf', true, NULL);
INSERT INTO public.chem_elements VALUES (350, 'Hf180', true, NULL);
INSERT INTO public.chem_elements VALUES (351, '203Tl', true, NULL);
INSERT INTO public.chem_elements VALUES (352, 'Tl203', true, NULL);
INSERT INTO public.chem_elements VALUES (353, '205Tl', true, NULL);
INSERT INTO public.chem_elements VALUES (354, 'Tl205', true, NULL);
INSERT INTO public.chem_elements VALUES (355, '204Pb', true, NULL);
INSERT INTO public.chem_elements VALUES (356, 'Pb204', true, NULL);
INSERT INTO public.chem_elements VALUES (357, '206Pb', true, NULL);
INSERT INTO public.chem_elements VALUES (358, 'Pb206', true, NULL);
INSERT INTO public.chem_elements VALUES (359, '207Pb', true, NULL);
INSERT INTO public.chem_elements VALUES (360, 'Pb207', true, NULL);
INSERT INTO public.chem_elements VALUES (361, '208Pb', true, NULL);
INSERT INTO public.chem_elements VALUES (362, 'Pb208', true, NULL);
INSERT INTO public.chem_elements VALUES (364, 'FEOT', false, NULL);
INSERT INTO public.chem_elements VALUES (365, 'δ88Sr', true, NULL);
INSERT INTO public.chem_elements VALUES (366, '87Sr/86Sr', true, NULL);
INSERT INTO public.chem_elements VALUES (367, '207Pb/204Pb', true, NULL);
INSERT INTO public.chem_elements VALUES (368, '206Pb/204Pb', true, NULL);
INSERT INTO public.chem_elements VALUES (369, '208Pb/204Pb', true, NULL);
INSERT INTO public.chem_elements VALUES (370, '143Nd/144Nd', true, NULL);
INSERT INTO public.chem_elements VALUES (371, 'FE2O3T', false, NULL);
INSERT INTO public.chem_elements VALUES (372, 'AGE', false, NULL);
INSERT INTO public.chem_elements VALUES (373, 'U238', true, NULL);
INSERT INTO public.chem_elements VALUES (374, 'U235', true, NULL);
INSERT INTO public.chem_elements VALUES (375, 'WO', false, NULL);
INSERT INTO public.chem_elements VALUES (376, 'EN', false, NULL);
INSERT INTO public.chem_elements VALUES (377, 'SPESS', false, NULL);
INSERT INTO public.chem_elements VALUES (378, 'GROSS', false, NULL);
INSERT INTO public.chem_elements VALUES (379, 'OR', false, NULL);
INSERT INTO public.chem_elements VALUES (380, 'FS', false, NULL);
INSERT INTO public.chem_elements VALUES (381, 'ALM', false, NULL);
INSERT INTO public.chem_elements VALUES (382, 'AN', false, NULL);
INSERT INTO public.chem_elements VALUES (383, 'PP', false, NULL);
INSERT INTO public.chem_elements VALUES (384, 'AB', false, NULL);
INSERT INTO public.chem_elements VALUES (385, 'HF176', true, NULL);
INSERT INTO public.chem_elements VALUES (386, 'D49TI', false, NULL);
INSERT INTO public.chem_elements VALUES (387, 'H2OM', true, NULL);
INSERT INTO public.chem_elements VALUES (388, 'H2OP', true, NULL);
INSERT INTO public.chem_elements VALUES (389, 'FE3O4', false, NULL);
INSERT INTO public.chem_elements VALUES (390, 'SM147', true, NULL);
INSERT INTO public.chem_elements VALUES (391, 'INI', true, NULL);
INSERT INTO public.chem_elements VALUES (392, 'EPSILON', false, NULL);
INSERT INTO public.chem_elements VALUES (393, 'TH232', true, NULL);
INSERT INTO public.chem_elements VALUES (394, 'D18O', true, NULL);
INSERT INTO public.chem_elements VALUES (395, 'CE2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (396, 'LA2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (397, 'HFO2', false, NULL);
INSERT INTO public.chem_elements VALUES (398, 'ER2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (399, 'THO2', false, NULL);
INSERT INTO public.chem_elements VALUES (400, 'UO2', false, NULL);
INSERT INTO public.chem_elements VALUES (401, 'GD2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (402, 'DY2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (403, 'Y2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (404, 'YB2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (405, 'ZRO2', false, NULL);
INSERT INTO public.chem_elements VALUES (406, 'FO', false, NULL);
INSERT INTO public.chem_elements VALUES (407, 'BAO', false, NULL);
INSERT INTO public.chem_elements VALUES (408, 'FA', false, NULL);
INSERT INTO public.chem_elements VALUES (409, 'LAR', false, NULL);
INSERT INTO public.chem_elements VALUES (410, 'V2O5', false, NULL);
INSERT INTO public.chem_elements VALUES (411, 'SO3', false, NULL);
INSERT INTO public.chem_elements VALUES (412, 'SRO', false, NULL);
INSERT INTO public.chem_elements VALUES (413, 'NB2O5', false, NULL);
INSERT INTO public.chem_elements VALUES (414, 'DD', false, NULL);
INSERT INTO public.chem_elements VALUES (415, 'CL35', true, NULL);
INSERT INTO public.chem_elements VALUES (416, 'RA226', false, NULL);
INSERT INTO public.chem_elements VALUES (417, 'ACT', false, NULL);
INSERT INTO public.chem_elements VALUES (418, 'TH230', true, NULL);
INSERT INTO public.chem_elements VALUES (419, 'HE4', false, NULL);
INSERT INTO public.chem_elements VALUES (420, 'HE3', false, NULL);
INSERT INTO public.chem_elements VALUES (422, 'BE10', false, NULL);
INSERT INTO public.chem_elements VALUES (423, 'YB176', true, NULL);
INSERT INTO public.chem_elements VALUES (424, 'PB210', false, NULL);
INSERT INTO public.chem_elements VALUES (425, 'RA228', true, NULL);
INSERT INTO public.chem_elements VALUES (426, 'TH228', true, NULL);
INSERT INTO public.chem_elements VALUES (427, 'D11B', true, NULL);
INSERT INTO public.chem_elements VALUES (428, 'U234', false, NULL);
INSERT INTO public.chem_elements VALUES (429, 'ULV', false, NULL);
INSERT INTO public.chem_elements VALUES (430, 'V2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (431, 'ZNO', false, NULL);
INSERT INTO public.chem_elements VALUES (432, 'HEM', false, NULL);
INSERT INTO public.chem_elements VALUES (433, 'TEPH', false, NULL);
INSERT INTO public.chem_elements VALUES (434, 'FET', false, NULL);
INSERT INTO public.chem_elements VALUES (435, 'AS2O5', false, NULL);
INSERT INTO public.chem_elements VALUES (436, 'D66ZN', true, NULL);
INSERT INTO public.chem_elements VALUES (437, 'D68ZN', true, NULL);
INSERT INTO public.chem_elements VALUES (438, 'MY', false, NULL);
INSERT INTO public.chem_elements VALUES (439, 'W183', false, NULL);
INSERT INTO public.chem_elements VALUES (440, 'W184', false, NULL);
INSERT INTO public.chem_elements VALUES (441, 'W182', false, NULL);
INSERT INTO public.chem_elements VALUES (442, 'CUO', false, NULL);
INSERT INTO public.chem_elements VALUES (443, 'ILM', false, NULL);
INSERT INTO public.chem_elements VALUES (444, 'SO4', false, NULL);
INSERT INTO public.chem_elements VALUES (445, 'CH4', true, NULL);
INSERT INTO public.chem_elements VALUES (446, 'AEG', false, NULL);
INSERT INTO public.chem_elements VALUES (447, 'SO2', false, NULL);
INSERT INTO public.chem_elements VALUES (448, 'PYP', false, NULL);
INSERT INTO public.chem_elements VALUES (449, 'GEIK', false, NULL);
INSERT INTO public.chem_elements VALUES (450, 'SM2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (451, 'ND2O3', false, NULL);
INSERT INTO public.chem_elements VALUES (500, 'NO3', false, NULL);
INSERT INTO public.chem_elements VALUES (501, 'HCO3', false, NULL);
INSERT INTO public.chem_elements VALUES (504, 'δ18O(‰)(RSD)', true, NULL);
INSERT INTO public.chem_elements VALUES (505, 'δ18O
(‰)(w.
m.v.)', true, NULL);
INSERT INTO public.chem_elements VALUES (506, 'δ18O(‰)
(m.v.)', true, NULL);
INSERT INTO public.chem_elements VALUES (507, 'δ2H(‰)
(m.v.)', true, NULL);
INSERT INTO public.chem_elements VALUES (508, 'δ2H
(‰)
(w.m.
v.)', true, NULL);
INSERT INTO public.chem_elements VALUES (509, 'δ2H(‰)(RSD)', true, NULL);
INSERT INTO public.chem_elements VALUES (510, 'δ18O-H2O', true, NULL);
INSERT INTO public.chem_elements VALUES (511, 'δD-H2O', true, NULL);
INSERT INTO public.chem_elements VALUES (512, 'SO₄²⁻mg/l', false, NULL);
INSERT INTO public.chem_elements VALUES (513, 'K⁺', false, NULL);
INSERT INTO public.chem_elements VALUES (514, 'Ca²⁺mg/l', false, NULL);
INSERT INTO public.chem_elements VALUES (515, 'Na⁺mg/l', false, NULL);
INSERT INTO public.chem_elements VALUES (516, 'Cl⁻mg/l', false, NULL);
INSERT INTO public.chem_elements VALUES (517, 'Br⁻', false, NULL);
INSERT INTO public.chem_elements VALUES (518, 'F⁻mg/l', false, NULL);
INSERT INTO public.chem_elements VALUES (519, 'NO₃⁻', false, NULL);
INSERT INTO public.chem_elements VALUES (520, 'Mg²⁺mg/l', false, NULL);
INSERT INTO public.chem_elements VALUES (521, 'K+', false, NULL);
INSERT INTO public.chem_elements VALUES (522, 'Mg2+', false, NULL);
INSERT INTO public.chem_elements VALUES (523, 'Cl-', false, NULL);
INSERT INTO public.chem_elements VALUES (524, 'HCO3-', false, NULL);
INSERT INTO public.chem_elements VALUES (525, 'd34S(SO4)', true, NULL);
INSERT INTO public.chem_elements VALUES (526, 'd18O(SO4)', true, NULL);
INSERT INTO public.chem_elements VALUES (527, 'd13C(DIC)', true, NULL);
INSERT INTO public.chem_elements VALUES (528, 'SO42-', false, NULL);
INSERT INTO public.chem_elements VALUES (529, 'Na+', false, NULL);
INSERT INTO public.chem_elements VALUES (530, 'Ca2+', false, NULL);
INSERT INTO public.chem_elements VALUES (531, 'd2H', true, NULL);
INSERT INTO public.chem_elements VALUES (532, 'δ2H', true, NULL);
INSERT INTO public.chem_elements VALUES (533, 'NO3-', false, NULL);
INSERT INTO public.chem_elements VALUES (534, 'δ18O', true, NULL);
INSERT INTO public.chem_elements VALUES (535, 'B/Cl', false, NULL);
INSERT INTO public.chem_elements VALUES (536, '2Hexc', true, NULL);
INSERT INTO public.chem_elements VALUES (537, 'd34SO4', true, NULL);
INSERT INTO public.chem_elements VALUES (538, '207Pb/204Pb(i)', true, NULL);
INSERT INTO public.chem_elements VALUES (539, 'Fe2O3(Tot)', false, NULL);
INSERT INTO public.chem_elements VALUES (540, '87Sr/86Sr(i)', true, NULL);
INSERT INTO public.chem_elements VALUES (541, '208Pb/204Pb(i)', true, NULL);
INSERT INTO public.chem_elements VALUES (542, '143Nd/144Nd(i)', true, NULL);
INSERT INTO public.chem_elements VALUES (543, '206Pb/204Pb(i)', true, NULL);
INSERT INTO public.chem_elements VALUES (544, 'NB(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (545, 'CO(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (546, 'FEOT(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (547, 'Y(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (548, 'CR(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (549, 'AL2O3(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (550, 'SR(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (551, 'MNO(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (552, 'P2O5(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (553, 'CAO(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (554, 'LA(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (555, 'TB(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (556, 'U(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (557, 'MGO(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (558, 'TH(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (559, 'ZR(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (560, 'CE(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (561, 'K2O(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (562, 'LU(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (563, 'YB(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (564, 'SC(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (565, 'EU(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (566, 'BA(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (567, 'ND(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (568, 'TA(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (569, 'HF(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (570, 'SIO2(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (363, 'LU176', true, NULL);
INSERT INTO public.chem_elements VALUES (571, 'RB(PPM)', false, NULL);
INSERT INTO public.chem_elements VALUES (572, 'TIO2(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (573, 'NA2O(WT%)', false, NULL);
INSERT INTO public.chem_elements VALUES (574, 'SM(PPM)', false, NULL);


--
-- TOC entry 4962 (class 0 OID 16409)
-- Dependencies: 221
-- Data for Name: coordinates; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4963 (class 0 OID 16416)
-- Dependencies: 223
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.countries VALUES (1, 'AL', 'Albania', NULL);
INSERT INTO public.countries VALUES (2, 'AD', 'Andorra', NULL);
INSERT INTO public.countries VALUES (3, 'AT', 'Austria', NULL);
INSERT INTO public.countries VALUES (5, 'BG', 'Bulgaria', NULL);
INSERT INTO public.countries VALUES (17, 'LI', 'Liechtenstein', NULL);
INSERT INTO public.countries VALUES (19, 'MT', 'Malta', NULL);
INSERT INTO public.countries VALUES (21, 'MC', 'Monaco', NULL);
INSERT INTO public.countries VALUES (26, 'RO', 'Romania', NULL);
INSERT INTO public.countries VALUES (27, 'SM', 'San Marino', NULL);
INSERT INTO public.countries VALUES (34, 'MD', 'Moldova', NULL);
INSERT INTO public.countries VALUES (35, 'EE', 'Estonia', NULL);
INSERT INTO public.countries VALUES (40, 'SI', 'Slovenia', NULL);
INSERT INTO public.countries VALUES (41, 'BA', 'Bosnia-Erzegovina', NULL);
INSERT INTO public.countries VALUES (45, 'RS', 'Serbia', NULL);
INSERT INTO public.countries VALUES (46, 'ME', 'Montenegro', NULL);
INSERT INTO public.countries VALUES (47, '-', 'Kosovo', NULL);
INSERT INTO public.countries VALUES (49, 'AF', 'Afghanistan', NULL);
INSERT INTO public.countries VALUES (51, 'BH', 'Bahrein', NULL);
INSERT INTO public.countries VALUES (52, 'BT', 'Bhutan', NULL);
INSERT INTO public.countries VALUES (54, 'BN', 'Brunei Darussalam', NULL);
INSERT INTO public.countries VALUES (56, 'LK', 'Sri Lanka', NULL);
INSERT INTO public.countries VALUES (59, 'KR', 'Corea del Sud', NULL);
INSERT INTO public.countries VALUES (63, 'TW', 'Taiwan', NULL);
INSERT INTO public.countries VALUES (66, 'IN', 'India', NULL);
INSERT INTO public.countries VALUES (67, 'ID', 'Indonesia', NULL);
INSERT INTO public.countries VALUES (68, 'IR', 'Iran', NULL);
INSERT INTO public.countries VALUES (69, 'IQ', 'Iraq', NULL);
INSERT INTO public.countries VALUES (71, 'KW', 'Kuwait', NULL);
INSERT INTO public.countries VALUES (72, 'LA', 'Laos', NULL);
INSERT INTO public.countries VALUES (75, 'MN', 'Mongolia', NULL);
INSERT INTO public.countries VALUES (76, 'NP', 'Nepal', NULL);
INSERT INTO public.countries VALUES (77, 'OM', 'Oman', NULL);
INSERT INTO public.countries VALUES (78, 'PK', 'Pakistan', NULL);
INSERT INTO public.countries VALUES (79, 'QA', 'Qatar', NULL);
INSERT INTO public.countries VALUES (84, 'YE', 'Yemen', NULL);
INSERT INTO public.countries VALUES (85, 'MY', 'Malaysia', NULL);
INSERT INTO public.countries VALUES (86, 'SG', 'Singapore', NULL);
INSERT INTO public.countries VALUES (87, 'BD', 'Bangladesh', NULL);
INSERT INTO public.countries VALUES (88, 'VN', 'Vietnam', NULL);
INSERT INTO public.countries VALUES (89, 'AM', 'Armenia', NULL);
INSERT INTO public.countries VALUES (90, 'AZ', 'Azerbaigian', NULL);
INSERT INTO public.countries VALUES (91, 'GE', 'Georgia', NULL);
INSERT INTO public.countries VALUES (92, 'KZ', 'Kazakhstan', NULL);
INSERT INTO public.countries VALUES (93, 'KG', 'Kirghizistan', NULL);
INSERT INTO public.countries VALUES (94, 'TJ', 'Tagikistan', NULL);
INSERT INTO public.countries VALUES (95, 'TM', 'Turkmenistan', NULL);
INSERT INTO public.countries VALUES (96, 'UZ', 'Uzbekistan', NULL);
INSERT INTO public.countries VALUES (97, 'NA', 'Namibia', NULL);
INSERT INTO public.countries VALUES (98, 'DZ', 'Algeria', NULL);
INSERT INTO public.countries VALUES (99, 'AO', 'Angola', NULL);
INSERT INTO public.countries VALUES (100, 'BI', 'Burundi', NULL);
INSERT INTO public.countries VALUES (101, 'CM', 'Camerun', NULL);
INSERT INTO public.countries VALUES (102, 'CV', 'Capo Verde', NULL);
INSERT INTO public.countries VALUES (106, 'CG', 'Congo', NULL);
INSERT INTO public.countries VALUES (109, 'BJ', 'Benin', NULL);
INSERT INTO public.countries VALUES (111, 'GA', 'Gabon', NULL);
INSERT INTO public.countries VALUES (112, 'GM', 'Gambia', NULL);
INSERT INTO public.countries VALUES (113, 'GH', 'Ghana', NULL);
INSERT INTO public.countries VALUES (114, 'GN', 'Guinea', NULL);
INSERT INTO public.countries VALUES (115, 'GW', 'Guinea-Bissau', NULL);
INSERT INTO public.countries VALUES (117, 'KE', 'Kenya', NULL);
INSERT INTO public.countries VALUES (118, 'LR', 'Liberia', NULL);
INSERT INTO public.countries VALUES (120, 'MG', 'Madagascar', NULL);
INSERT INTO public.countries VALUES (121, 'MW', 'Malawi', NULL);
INSERT INTO public.countries VALUES (122, 'ML', 'Mali', NULL);
INSERT INTO public.countries VALUES (124, 'MR', 'Mauritania', NULL);
INSERT INTO public.countries VALUES (127, 'NE', 'Niger', NULL);
INSERT INTO public.countries VALUES (128, 'NG', 'Nigeria', NULL);
INSERT INTO public.countries VALUES (135, 'SC', 'Seychelles', NULL);
INSERT INTO public.countries VALUES (136, 'SN', 'Senegal', NULL);
INSERT INTO public.countries VALUES (137, 'SL', 'Sierra Leone', NULL);
INSERT INTO public.countries VALUES (138, 'SO', 'Somalia', NULL);
INSERT INTO public.countries VALUES (140, 'SD', 'Sudan', NULL);
INSERT INTO public.countries VALUES (141, 'SZ', 'Eswatini', NULL);
INSERT INTO public.countries VALUES (142, 'TG', 'Togo', NULL);
INSERT INTO public.countries VALUES (143, 'TN', 'Tunisia', NULL);
INSERT INTO public.countries VALUES (144, 'UG', 'Uganda', NULL);
INSERT INTO public.countries VALUES (145, 'BF', 'Burkina Faso', NULL);
INSERT INTO public.countries VALUES (146, 'ZM', 'Zambia', NULL);
INSERT INTO public.countries VALUES (147, 'TZ', 'Tanzania', NULL);
INSERT INTO public.countries VALUES (148, 'BW', 'Botswana', NULL);
INSERT INTO public.countries VALUES (149, 'LS', 'Lesotho', NULL);
INSERT INTO public.countries VALUES (150, 'DJ', 'Gibuti', NULL);
INSERT INTO public.countries VALUES (151, 'ER', 'Eritrea', NULL);
INSERT INTO public.countries VALUES (152, 'BM', 'Bermuda', NULL);
INSERT INTO public.countries VALUES (153, 'CA', 'Canada', NULL);
INSERT INTO public.countries VALUES (155, 'PM', 'Saint Pierre e Miquelon', NULL);
INSERT INTO public.countries VALUES (157, 'AW', 'Aruba', NULL);
INSERT INTO public.countries VALUES (158, 'BS', 'Bahamas', NULL);
INSERT INTO public.countries VALUES (159, 'CR', 'Costa Rica', NULL);
INSERT INTO public.countries VALUES (160, 'CU', 'Cuba', NULL);
INSERT INTO public.countries VALUES (162, 'SV', 'El Salvador', NULL);
INSERT INTO public.countries VALUES (164, 'GT', 'Guatemala', NULL);
INSERT INTO public.countries VALUES (165, 'HT', 'Haiti', NULL);
INSERT INTO public.countries VALUES (166, 'HN', 'Honduras', NULL);
INSERT INTO public.countries VALUES (167, 'BZ', 'Belize', NULL);
INSERT INTO public.countries VALUES (169, 'NI', 'Nicaragua', NULL);
INSERT INTO public.countries VALUES (170, 'PA', 'Panama', NULL);
INSERT INTO public.countries VALUES (4, 'BE', 'Belgium', NULL);
INSERT INTO public.countries VALUES (6, 'VA', 'Vatican City', NULL);
INSERT INTO public.countries VALUES (7, 'DK', 'Denmark', NULL);
INSERT INTO public.countries VALUES (8, 'FO', 'Far Oer Islands', NULL);
INSERT INTO public.countries VALUES (9, 'FI', 'Finland', NULL);
INSERT INTO public.countries VALUES (10, 'FR', 'France', NULL);
INSERT INTO public.countries VALUES (11, 'DE', 'Germany', NULL);
INSERT INTO public.countries VALUES (12, 'GI', 'Gibraltar', NULL);
INSERT INTO public.countries VALUES (13, 'UK', 'United Kingdom', NULL);
INSERT INTO public.countries VALUES (14, 'GR', 'Greece', NULL);
INSERT INTO public.countries VALUES (15, 'IE', 'Ireland', NULL);
INSERT INTO public.countries VALUES (16, 'IS', 'Iceland', NULL);
INSERT INTO public.countries VALUES (18, 'LU', 'Luxembourg', NULL);
INSERT INTO public.countries VALUES (20, 'IM', 'Man Island', NULL);
INSERT INTO public.countries VALUES (22, 'NO', 'Norway', NULL);
INSERT INTO public.countries VALUES (23, 'NL', 'Netherlands', NULL);
INSERT INTO public.countries VALUES (24, 'PL', 'Poland', NULL);
INSERT INTO public.countries VALUES (25, 'PT', 'Portugal', NULL);
INSERT INTO public.countries VALUES (28, 'ES', 'Spain', NULL);
INSERT INTO public.countries VALUES (29, 'SE', 'Sweden', NULL);
INSERT INTO public.countries VALUES (31, 'HU', 'Hungary', NULL);
INSERT INTO public.countries VALUES (32, 'UA', 'Ukraine', NULL);
INSERT INTO public.countries VALUES (33, 'BY', 'Belarus', NULL);
INSERT INTO public.countries VALUES (36, 'LV', 'Latvia', NULL);
INSERT INTO public.countries VALUES (37, 'LT', 'Lithuania', NULL);
INSERT INTO public.countries VALUES (38, 'MK', 'North Macedonia', NULL);
INSERT INTO public.countries VALUES (39, 'HR', 'Croatia', NULL);
INSERT INTO public.countries VALUES (42, 'RU', 'Russian Federation', NULL);
INSERT INTO public.countries VALUES (43, 'SK', 'Slovakia', NULL);
INSERT INTO public.countries VALUES (44, 'CZ', 'Czech Republic', NULL);
INSERT INTO public.countries VALUES (48, 'PS', 'Palestine', NULL);
INSERT INTO public.countries VALUES (50, 'SA', 'Saudi Arabia', NULL);
INSERT INTO public.countries VALUES (53, 'MM', 'Myanmar', NULL);
INSERT INTO public.countries VALUES (55, 'KH', 'Cambodia', NULL);
INSERT INTO public.countries VALUES (57, 'CN', 'China', NULL);
INSERT INTO public.countries VALUES (58, 'CY', 'Cyprus', NULL);
INSERT INTO public.countries VALUES (61, 'AE', 'United Arab Emirates', NULL);
INSERT INTO public.countries VALUES (62, 'PH', 'Philippines', NULL);
INSERT INTO public.countries VALUES (64, 'JP', 'Japan', NULL);
INSERT INTO public.countries VALUES (65, 'JO', 'Jordan', NULL);
INSERT INTO public.countries VALUES (70, 'IL', 'Israel', NULL);
INSERT INTO public.countries VALUES (73, 'LB', 'Lebanon', NULL);
INSERT INTO public.countries VALUES (74, 'MV', 'Maldives', NULL);
INSERT INTO public.countries VALUES (80, 'SY', 'Syria', NULL);
INSERT INTO public.countries VALUES (81, 'TH', 'Thailand', NULL);
INSERT INTO public.countries VALUES (82, 'TL', 'East Timor', NULL);
INSERT INTO public.countries VALUES (83, 'TR', 'Türkiye', NULL);
INSERT INTO public.countries VALUES (103, 'CF', 'Central African Republic', NULL);
INSERT INTO public.countries VALUES (104, 'TD', 'Chad', NULL);
INSERT INTO public.countries VALUES (105, 'KM', 'Comoros', NULL);
INSERT INTO public.countries VALUES (108, 'CI', 'Ivory Coast', NULL);
INSERT INTO public.countries VALUES (110, 'ET', 'Ethiopia', NULL);
INSERT INTO public.countries VALUES (116, 'GQ', 'Guinea eq.', NULL);
INSERT INTO public.countries VALUES (119, 'LY', 'Libya', NULL);
INSERT INTO public.countries VALUES (123, 'MA', 'Morocco', NULL);
INSERT INTO public.countries VALUES (125, 'MU', 'Mauritius', NULL);
INSERT INTO public.countries VALUES (126, 'MZ', 'Mozambique', NULL);
INSERT INTO public.countries VALUES (129, 'EG', 'Egypt', NULL);
INSERT INTO public.countries VALUES (131, 'RW', 'Rwanda', NULL);
INSERT INTO public.countries VALUES (132, 'EH', 'Western Sahara', NULL);
INSERT INTO public.countries VALUES (133, 'SH', 'St. Elena', NULL);
INSERT INTO public.countries VALUES (134, 'ST', 'Sao Tomé and Principe', NULL);
INSERT INTO public.countries VALUES (139, 'ZA', 'South Africa', NULL);
INSERT INTO public.countries VALUES (154, 'GL', 'Greenland', NULL);
INSERT INTO public.countries VALUES (156, 'US', 'United States', NULL);
INSERT INTO public.countries VALUES (161, 'DO', 'Dominican Republic', NULL);
INSERT INTO public.countries VALUES (163, 'JM', 'Jamaica', NULL);
INSERT INTO public.countries VALUES (168, 'MX', 'Mexico', NULL);
INSERT INTO public.countries VALUES (172, 'BB', 'Barbados', NULL);
INSERT INTO public.countries VALUES (173, 'GD', 'Grenada', NULL);
INSERT INTO public.countries VALUES (175, 'DM', 'Dominica', NULL);
INSERT INTO public.countries VALUES (177, 'VC', 'Saint Vincent e Grenadine', NULL);
INSERT INTO public.countries VALUES (178, 'AI', 'Anguilla', NULL);
INSERT INTO public.countries VALUES (180, 'MS', 'Montserrat', NULL);
INSERT INTO public.countries VALUES (182, 'KN', 'Saint Kitts e Nevis', NULL);
INSERT INTO public.countries VALUES (183, 'AR', 'Argentina', NULL);
INSERT INTO public.countries VALUES (184, 'BO', 'Bolivia', NULL);
INSERT INTO public.countries VALUES (187, 'CO', 'Colombia', NULL);
INSERT INTO public.countries VALUES (188, 'EC', 'Ecuador', NULL);
INSERT INTO public.countries VALUES (189, 'GY', 'Guyana', NULL);
INSERT INTO public.countries VALUES (190, 'SR', 'Suriname', NULL);
INSERT INTO public.countries VALUES (192, 'PY', 'Paraguay', NULL);
INSERT INTO public.countries VALUES (193, 'PE', 'Perù', NULL);
INSERT INTO public.countries VALUES (195, 'UY', 'Uruguay', NULL);
INSERT INTO public.countries VALUES (196, 'VE', 'Venezuela', NULL);
INSERT INTO public.countries VALUES (197, 'AU', 'Australia', NULL);
INSERT INTO public.countries VALUES (201, 'NR', 'Nauru', NULL);
INSERT INTO public.countries VALUES (207, 'WS', 'Samoa', NULL);
INSERT INTO public.countries VALUES (208, 'TO', 'Tonga', NULL);
INSERT INTO public.countries VALUES (211, 'KI', 'Kiribati', NULL);
INSERT INTO public.countries VALUES (212, 'TV', 'Tuvalu', NULL);
INSERT INTO public.countries VALUES (213, 'VU', 'Vanuatu', NULL);
INSERT INTO public.countries VALUES (214, 'PW', 'Palau', NULL);
INSERT INTO public.countries VALUES (130, 'ZW', 'Zimbabwe', 'Rhodesia');
INSERT INTO public.countries VALUES (220, 'IT', 'Italy', NULL);
INSERT INTO public.countries VALUES (30, 'CH', 'Swiss', NULL);
INSERT INTO public.countries VALUES (60, 'KP', 'North Korea', NULL);
INSERT INTO public.countries VALUES (107, 'CD', 'Democratic Republic of Congo', NULL);
INSERT INTO public.countries VALUES (171, 'TC', 'Turks and Caicos islands', NULL);
INSERT INTO public.countries VALUES (174, 'VG', 'British Virgin Islands', NULL);
INSERT INTO public.countries VALUES (176, 'LC', 'Saint Lucia', NULL);
INSERT INTO public.countries VALUES (179, 'KY', 'Cayman Islands', NULL);
INSERT INTO public.countries VALUES (181, 'AG', 'Antigua and Barbuda', NULL);
INSERT INTO public.countries VALUES (185, 'BR', 'Brazil', NULL);
INSERT INTO public.countries VALUES (186, 'CL', 'Chile', NULL);
INSERT INTO public.countries VALUES (191, 'FK', 'Falkland Islands (Malvine)', NULL);
INSERT INTO public.countries VALUES (194, 'TT', 'Trinidad and Tobago', NULL);
INSERT INTO public.countries VALUES (198, 'CK', 'Cook Islands (NZ)', NULL);
INSERT INTO public.countries VALUES (199, 'FJ', 'Fiji', NULL);
INSERT INTO public.countries VALUES (200, 'MH', 'Marshall Islands', NULL);
INSERT INTO public.countries VALUES (202, 'NC', 'New Caledonia', NULL);
INSERT INTO public.countries VALUES (203, 'NZ', 'New Zealand', NULL);
INSERT INTO public.countries VALUES (204, 'PN', 'Pitcairn Islands', NULL);
INSERT INTO public.countries VALUES (205, 'PF', 'French Polynesia', NULL);
INSERT INTO public.countries VALUES (206, 'SB', 'Solomon Islands', NULL);
INSERT INTO public.countries VALUES (209, 'WF', 'Wallis and Futuna', NULL);
INSERT INTO public.countries VALUES (210, 'PG', 'Papua New Guinea', NULL);
INSERT INTO public.countries VALUES (215, 'FM', 'Federated States of Micronesia', NULL);
INSERT INTO public.countries VALUES (216, 'SS', 'South Sudan', NULL);


--
-- TOC entry 4965 (class 0 OID 16420)
-- Dependencies: 225
-- Data for Name: dataset; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4966 (class 0 OID 16426)
-- Dependencies: 226
-- Data for Name: dataset_authors; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4979 (class 0 OID 73898)
-- Dependencies: 239
-- Data for Name: keywords; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4978 (class 0 OID 73889)
-- Dependencies: 238
-- Data for Name: matrix; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4980 (class 0 OID 82079)
-- Dependencies: 240
-- Data for Name: measure_unit; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.measure_unit VALUES ('‰', 0.001);
INSERT INTO public.measure_unit VALUES ('μg/mg', 0.001);
INSERT INTO public.measure_unit VALUES ('μL/mL', 0.001);
INSERT INTO public.measure_unit VALUES ('ppm', 1);
INSERT INTO public.measure_unit VALUES ('mg/dm3', 1);
INSERT INTO public.measure_unit VALUES ('mg/L', 1);
INSERT INTO public.measure_unit VALUES ('g/m3', 1);
INSERT INTO public.measure_unit VALUES ('Kg/m3', 1);
INSERT INTO public.measure_unit VALUES ('nL/mL', 1);
INSERT INTO public.measure_unit VALUES ('mL/m3', 1);
INSERT INTO public.measure_unit VALUES ('mg/Kg', 1);
INSERT INTO public.measure_unit VALUES ('ng/mg', 1);
INSERT INTO public.measure_unit VALUES ('ppb', 1000);
INSERT INTO public.measure_unit VALUES ('mg/cm3', 1000);
INSERT INTO public.measure_unit VALUES ('nL/L', 1000);
INSERT INTO public.measure_unit VALUES ('pL/mL', 1000);
INSERT INTO public.measure_unit VALUES ('ng/mL', 1000);
INSERT INTO public.measure_unit VALUES ('mg/m3', 1000);
INSERT INTO public.measure_unit VALUES ('ng/g', 1000);
INSERT INTO public.measure_unit VALUES ('pg/mg', 1000);
INSERT INTO public.measure_unit VALUES ('ng/Kg', 1000000);
INSERT INTO public.measure_unit VALUES ('pg/g', 1000000);
INSERT INTO public.measure_unit VALUES ('ppt', 1000000);
INSERT INTO public.measure_unit VALUES ('ng/cm3', 1000000);
INSERT INTO public.measure_unit VALUES ('ng/L', 1000000);
INSERT INTO public.measure_unit VALUES ('pg/mL', 1000000);
INSERT INTO public.measure_unit VALUES ('pg/cm3', 1000000);
INSERT INTO public.measure_unit VALUES ('pL/L', 1000000);
INSERT INTO public.measure_unit VALUES ('nL/m3', 1000000);
INSERT INTO public.measure_unit VALUES ('mg/dL', 0.1);
INSERT INTO public.measure_unit VALUES ('g/dL', 0.001);
INSERT INTO public.measure_unit VALUES ('g/L', 0.001);
INSERT INTO public.measure_unit VALUES ('mg/mL', 0.001);
INSERT INTO public.measure_unit VALUES ('kg/m3', 0.001);
INSERT INTO public.measure_unit VALUES ('mL/L', 0.001);
INSERT INTO public.measure_unit VALUES ('L/m3', 0.001);
INSERT INTO public.measure_unit VALUES ('g/Kg', 0.001);
INSERT INTO public.measure_unit VALUES ('mg/g', 0.001);
INSERT INTO public.measure_unit VALUES ('%', 0.0001);
INSERT INTO public.measure_unit VALUES ('wt%', 10000);
INSERT INTO public.measure_unit VALUES ('g/cm3', 1e-06);
INSERT INTO public.measure_unit VALUES ('μg/mL', 1);
INSERT INTO public.measure_unit VALUES ('μL/L', 1);
INSERT INTO public.measure_unit VALUES ('μg/g', 1);
INSERT INTO public.measure_unit VALUES ('μg/cm3', 1000);
INSERT INTO public.measure_unit VALUES ('μg/L', 1000);
INSERT INTO public.measure_unit VALUES ('μg/Kg', 1000);
INSERT INTO public.measure_unit VALUES ('μg/m3', 1000000);


--
-- TOC entry 4976 (class 0 OID 16523)
-- Dependencies: 236
-- Data for Name: reservoir; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.reservoir VALUES (1283, 'Aldan River', 72, 'Hf', 19.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Godfrey et al. 1996', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1284, 'Aldan River', NULL, 'Ti/Gd', 69.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Godfrey et al. 1996', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1285, 'Aldan River', 40, 'Zr', 1330, NULL, NULL, NULL, NULL, NULL, '', '', 'Godfrey et al. 1996', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (2, 'Amour River Particulates', 29, 'Cu', 79, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (3, 'Amour River Particulates', 28, 'Ni', 82, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (4, 'Amour River Particulates', 82, 'Pb', 307, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (5, 'Amour River Particulates', 23, 'V', 81, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (6, 'Amour River Particulates', 30, 'Zn', 511, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (7, 'Atmosphere', NULL, '10Be', 260, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (12, 'Atmosphere', NULL, '12C', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (13, 'Atmosphere', NULL, '130Xe', 100, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (18, 'Atmosphere', NULL, '13C', 0.0113, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (19, 'Atmosphere', NULL, '14C', 75, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (20, 'Atmosphere', NULL, '14N', 0.0037, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (21, 'Atmosphere', NULL, '15N', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (22, 'Atmosphere', NULL, '1H', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (24, 'Atmosphere', NULL, '20Ne/22Ne', 9.8, NULL, NULL, NULL, NULL, NULL, '', '', 'Hilton & Porcelli 2004', 'McDougall & Honda 1998', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (26, 'Atmosphere', NULL, '21Ne/22Ne', 0.029, NULL, NULL, NULL, NULL, NULL, '', '', 'Hilton & Porcelli 2004', 'McDougall & Honda 1998', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (27, 'Atmosphere', NULL, '22Na', 1.9, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (28, 'Atmosphere', NULL, '22Ne', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (29, 'Atmosphere', NULL, '26Al', 1.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (30, 'Atmosphere', NULL, '2H', 0.0002, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1286, 'Kenya', NULL, '87Sr/86Sr', 0.7114, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1287, 'Kenya', 38, 'Sr', 1.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1288, 'Mozambique', NULL, '87Sr/86Sr', 0.716, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1289, 'Mozambique', 38, 'Sr', 1.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (149, 'Rivers', 42, 'Mo', 0.6, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (150, 'Rivers', 7, 'N', 375, NULL, NULL, NULL, NULL, NULL, '', '', 'Meybeck 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (151, 'Rivers', 11, 'Na', 6300, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (152, 'Rivers', 60, 'Nd', 0.04, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (153, 'Rivers', 28, 'Ni', 0.3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1290, 'Niger River', NULL, '87Sr/86Sr', 0.714, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1291, 'Niger River', 38, 'Sr', 0.25, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (231, 'Seawater', 83, 'Bi', 10, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Brooks 1960', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (232, 'Seawater', 83, 'Bi', NULL, NULL, NULL, 0.015, 0.24, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1292, 'Orange River', NULL, '87Sr/86Sr', 0.7146, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1293, 'Orange River', 38, 'Sr', 1.851, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1294, 'Tanzania', NULL, '87Sr/86Sr', 0.7219, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1295, 'Tanzania', 38, 'Sr', 0.492, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (389, 'Seawater', 57, 'La', 3e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1296, 'Victoria Nile River', NULL, '87Sr/86Sr', 0.7114, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1297, 'Victoria Nile River', 38, 'Sr', 1.102, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (469, 'Seawater', 59, 'Pr', 4, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (470, 'Seawater', 59, 'Pr', 0.87, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1298, 'Zambezi River', NULL, '87Sr/86Sr', 0.716, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1299, 'Zambezi River', 38, 'Sr', 1.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1300, 'Brahmaputra River', NULL, '87Sr/86Sr', 0.721, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1301, 'Brahmaputra River', 3, 'd6Li', -19.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1302, 'Brahmaputra River', 3, 'Li', 436, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1303, 'Brahmaputra River', 38, 'Sr', 0.93, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1304, 'Dvina River', NULL, '87Sr/86Sr', 0.7084, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1305, 'Dvina River', 38, 'Sr', 2.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (705, 'Core', 9, 'F', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (706, 'Core', 26, 'Fe', 85, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (707, 'Core', 26, 'Fe', NULL, NULL, NULL, 78, 87.5, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1306, 'Ganges River', NULL, '87Sr/86Sr', 0.7257, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1307, 'Ganges River', 3, 'd6Li', -22.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1308, 'Ganges River', 3, 'Li', 579, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1309, 'Ganges River', 88, 'Ra', 2000, NULL, NULL, NULL, NULL, NULL, '', '', 'Moore & Scott 1986', 'Bhat & Krishnasawami 1969', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1310, 'Ganges River', 38, 'Sr', 1.581, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (791, 'Core', 16, 'S', 1.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (792, 'Core', 16, 'S', 1.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (797, 'Core', 16, 'S', 1.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1311, 'Indus River', NULL, '87Sr/86Sr', 0.7112, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', 'Goldstein & Jacobsen 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1312, 'Indus River', 38, 'Sr', 3.33, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', 'Goldstein & Jacobsen 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (871, 'Silicate Earth', 5, 'B', 0.3, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (872, 'Silicate Earth', 5, 'B', 0.3, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (873, 'Silicate Earth', 5, 'B', 0.3, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (874, 'Silicate Earth', 56, 'Ba', 6.049, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (875, 'Silicate Earth', 56, 'Ba', 5.1, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (877, 'Silicate Earth', 56, 'Ba', 6.6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (878, 'Silicate Earth', 56, 'Ba', 6.99, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (879, 'Silicate Earth', 56, 'Ba', 5.6, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (880, 'Silicate Earth', 56, 'Ba', 6.6, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (882, 'Silicate Earth', 4, 'Be', 0.07, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (883, 'Silicate Earth', 4, 'Be', 0.07, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (885, 'Silicate Earth', 83, 'Bi', 0.003, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1313, 'Irrawady River', NULL, '87Sr/86Sr', 0.7102, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1314, 'Irrawady River', 38, 'Sr', 3.393, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (944, 'Silicate Earth', 66, 'Dy', 0.737, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (945, 'Silicate Earth', 66, 'Dy', 0.67, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (946, 'Silicate Earth', 66, 'Dy', 0.766, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (947, 'Silicate Earth', NULL, 'e182W', -0.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (948, 'Silicate Earth', NULL, 'e182W', -0.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (949, 'Silicate Earth', NULL, 'e182W', -0.9, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (950, 'Silicate Earth', NULL, 'e182W', -1.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1315, 'Lena River', 3, 'd6Li', -21, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1316, 'Lena River', 72, 'Hf', 25.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Godfrey et al. 1996', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1317, 'Lena River', 3, 'Li', 221, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1318, 'Lena River', NULL, 'Ti/Gd', 72.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Godfrey et al. 1996', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1319, 'Lena River', 40, 'Zr', 1834, NULL, NULL, NULL, NULL, NULL, '', '', 'Godfrey et al. 1996', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1016, 'Silicate Earth', 72, 'Hf', 0.27, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1017, 'Silicate Earth', 72, 'Hf', 0.28, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1018, 'Silicate Earth', 80, 'Hg', 0.01, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1019, 'Silicate Earth', 80, 'Hg', 10, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1020, 'Silicate Earth', 80, 'Hg', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1021, 'Silicate Earth', 67, 'Ho', 0.181, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1022, 'Silicate Earth', 67, 'Ho', 0.1423, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1023, 'Silicate Earth', 67, 'Ho', 0.128, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1024, 'Silicate Earth', 67, 'Ho', 0.15, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1025, 'Silicate Earth', 67, 'Ho', 0.163, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1320, 'Mekong River', NULL, '87Sr/86Sr', 0.7102, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1321, 'Mekong River', 38, 'Sr', 3.393, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1089, 'Silicate Earth', 11, 'Na', 0.34, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1090, 'Silicate Earth', 11, 'Na', 0.4, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1091, 'Silicate Earth', 11, 'Na', 0.33, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1092, 'Silicate Earth', 11, 'Na', 0.27, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1093, 'Silicate Earth', 11, 'Na', 0.36, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1095, 'Silicate Earth', 41, 'Nb', 0.66, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1097, 'Silicate Earth', 41, 'Nb', 0.66, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1098, 'Silicate Earth', 41, 'Nb', 0.713, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1099, 'Silicate Earth', 41, 'Nb', 0.6175, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1100, 'Silicate Earth', 41, 'Nb', 0.56, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1101, 'Silicate Earth', 60, 'Nd', 1.25, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1102, 'Silicate Earth', 60, 'Nd', 1.1892, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1103, 'Silicate Earth', 60, 'Nd', 1.43, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1104, 'Silicate Earth', 60, 'Nd', 1.366, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (107, 'Rivers', 56, 'Ba', 20, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (108, 'Rivers', 56, 'Ba', 0.35, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (109, 'Rivers', 4, 'Be', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Measures & Edmond 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (110, 'Rivers', 35, 'Br', 20, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (111, 'Rivers', 6, 'C', 15900, NULL, NULL, NULL, NULL, NULL, '', '', 'Meybeck 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (112, 'Rivers', 20, 'Ca', 150000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (113, 'Rivers', 20, 'Ca', 375, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (114, 'Rivers', 48, 'Cd', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Boyle et al. 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (115, 'Rivers', 58, 'Ce', 0.08, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (116, 'Rivers', 17, 'Cl', 220, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (117, 'Rivers', 17, 'Cl', 7800, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Turekian & Wedepohl 1961', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (118, 'Rivers', 27, 'Co', 0.1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (119, 'Rivers', 24, 'Cr', 1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (120, 'Rivers', 55, 'Cs', 0.02, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (121, 'Rivers', 55, 'Cs', 0.02, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1234, 'Silicate Earth', 22, 'Ti', 0.16, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1235, 'Silicate Earth', 22, 'Ti', 1085, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1236, 'Silicate Earth', 22, 'Ti', 960, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1237, 'Silicate Earth', 22, 'Ti', 0.217, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1238, 'Silicate Earth', 22, 'Ti', 0.17, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1239, 'Silicate Earth', 81, 'Tl', 0.004, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1241, 'Silicate Earth', 69, 'Tm', 0.068, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1242, 'Silicate Earth', 69, 'Tm', 0.054, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (31, 'Atmosphere', NULL, '31Kr', 8.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (32, 'Atmosphere', NULL, '32P', 0.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (33, 'Atmosphere', NULL, '32Si', 0.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (34, 'Atmosphere', NULL, '33P', 0.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (35, 'Atmosphere', NULL, '36Ar', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (36, 'Atmosphere', NULL, '36Cl', 15, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (37, 'Atmosphere', NULL, '36S', 4.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (38, 'Atmosphere', NULL, '37Ar', 1.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (40, 'Atmosphere', NULL, '38Ar/36Ar', 0.188, NULL, NULL, NULL, NULL, NULL, '', '', 'Hilton & Porcelli 2004', 'McDougall & Honda 1998', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (41, 'Atmosphere', NULL, '39Ar', 52, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (42, 'Atmosphere', NULL, '3H', 3.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (44, 'Atmosphere', NULL, '3He', 3200, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (45, 'Atmosphere', NULL, '3He/4He', 1.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Hilton & Porcelli 2004', 'McDougall & Honda 1998', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (47, 'Atmosphere', NULL, '40Ar/36Ar', 295.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Hilton & Porcelli 2004', 'McDougall & Honda 1998', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (48, 'Atmosphere', NULL, '4He', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (50, 'Atmosphere', NULL, '7Be', 3.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Turekian & Graustein 2004', 'Lal & Peters 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (54, 'Atmosphere', NULL, '84Kr', 100, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (56, 'Atmosphere', 18, 'Ar', 1.65e+18, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2006', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (57, 'Atmosphere', 18, 'Ar', 0.934, NULL, NULL, NULL, NULL, NULL, '', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (58, 'Atmosphere', 5, 'B', 2.5e-10, NULL, NULL, NULL, NULL, NULL, '', '', 'Smith et al. 1995', 'Spivack 1986', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (59, 'Atmosphere', 6, 'C', 5.57e+16, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2007', 'Keeling & Whorf 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (60, 'Atmosphere', 6, 'C', 360, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (61, 'Atmosphere', 6, 'C', NULL, NULL, NULL, 5, 20, NULL, 'ppb', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (62, 'Atmosphere', 6, 'C', 540, NULL, NULL, NULL, NULL, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (63, 'Atmosphere', 6, 'C', 265, NULL, NULL, NULL, NULL, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (64, 'Atmosphere', 6, 'C', 65, NULL, NULL, NULL, NULL, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (65, 'Atmosphere', 6, 'C', NULL, NULL, NULL, 0.1, 1, NULL, 'ppb', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (66, 'Atmosphere', 6, 'C', 1.7, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (67, 'Atmosphere', 17, 'Cl', 98, NULL, NULL, NULL, NULL, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (68, 'Atmosphere', 27, 'Co', NULL, NULL, NULL, 50, 200, NULL, 'ppb', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (69, 'Atmosphere', 1, 'H', 0.55, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (70, 'Atmosphere', 1, 'H', 2, NULL, NULL, NULL, NULL, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (71, 'Atmosphere', 1, 'H', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (72, 'Atmosphere', 2, 'He', 926000000000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2009', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (73, 'Atmosphere', 2, 'He', 5.24, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (74, 'Atmosphere', 36, 'Kr', 202000000000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2010', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (75, 'Atmosphere', 7, 'N', NULL, NULL, NULL, 0.001, 10000, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (76, 'Atmosphere', 7, 'N', NULL, NULL, NULL, 1, 10000, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (77, 'Atmosphere', 7, 'N', 0.31, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (78, 'Atmosphere', 7, 'N', 2.76e+20, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2004', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (79, 'Atmosphere', 7, 'N', 78.084, NULL, NULL, NULL, NULL, NULL, '', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (80, 'Atmosphere', 10, 'Ne', 3.21e+15, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2008', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (81, 'Atmosphere', 10, 'Ne', 18.18, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (82, 'Atmosphere', 8, 'O', 3.7e+19, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2005', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (83, 'Atmosphere', 8, 'O', NULL, NULL, NULL, 10, 500, NULL, 'ppb', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (84, 'Atmosphere', 8, 'O', NULL, NULL, NULL, 0.5, 10, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (85, 'Atmosphere', 8, 'O', 20.948, NULL, NULL, NULL, NULL, NULL, '', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (86, 'Atmosphere', 16, 'S', NULL, NULL, NULL, 0.001, 10000, NULL, 'ppm', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (87, 'Atmosphere', 16, 'S', NULL, NULL, NULL, 10, 100, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (88, 'Atmosphere', 16, 'S', NULL, NULL, NULL, 1, 300, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (89, 'Atmosphere', 16, 'S', NULL, NULL, NULL, 0.1, 10, NULL, 'ppb', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (90, 'Atmosphere', 16, 'S', NULL, NULL, NULL, 5, 500, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (91, 'Atmosphere', 16, 'S', 500, NULL, NULL, NULL, NULL, NULL, 'ppt', '', 'Prinn 2004', 'Brasseur et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (92, 'Atmosphere', 54, 'Xe', 15400000000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2011', 'Ozima & Podosek 2001', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (93, 'Lake Baikal', NULL, 'd6Li', NULL, NULL, NULL, -27.9, -32.2, NULL, '', '', 'Huh et al. 1998', 'Falkner et al. 1997', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (94, 'Lake Baikal', 3, 'Li', 294, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', 'Falkner et al. 1997', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (95, 'Blue Nile River', NULL, '87Sr/86Sr', 0.7056, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (96, 'Blue Nile River', 38, 'Sr', 1.55, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (97, 'Caspian Sea', NULL, 'd6Li', -31.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', 'Chan & Edmond 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (98, 'Caspian Sea', 3, 'Li', 41.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', 'Chan & Edmond 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (99, 'Dead Sea', NULL, 'd6Li', -33.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', 'Chan & Edmond 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (100, 'Dead Sea', 3, 'Li', 1969, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', 'Chan & Edmond 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (101, 'Rivers', NULL, '87Sr/86Sr', 0.7119, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (102, 'Rivers', 47, 'Ag', 0.3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (103, 'Rivers', 13, 'Al', 50, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (104, 'Rivers', 33, 'As', 2, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (105, 'Rivers', 79, 'Au', 0.002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (106, 'Rivers', 5, 'B', 10, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (122, 'Rivers', 29, 'Cu', 7, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (123, 'Rivers', 29, 'Cu', 1.6, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Boyle et al. 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (124, 'Rivers', NULL, 'd6Li', -19, NULL, NULL, -25, -14, NULL, '', '', 'Chan et al. 1992', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (125, 'Rivers', 68, 'Er', 0.004, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (126, 'Rivers', 63, 'Eu', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (127, 'Rivers', 9, 'F', 5.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (128, 'Rivers', 9, 'F', 100, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (129, 'Rivers', 26, 'Fe', 40, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (130, 'Rivers', 31, 'Ga', 0.09, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (131, 'Rivers', 64, 'Gd', 0.008, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (132, 'Rivers', 32, 'Ge', 140, NULL, NULL, NULL, NULL, 122, '', '', 'Froehlich et al. 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (133, 'Rivers', 32, 'Ge', 0.005, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Froelich & Andreae 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (134, 'Rivers', NULL, 'Ge/Si', 7e-07, NULL, NULL, NULL, NULL, 122, '', '', 'Froehlich et al. 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (135, 'Rivers', 80, 'Hg', 0.07, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (136, 'Rivers', 67, 'Ho', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (137, 'Rivers', 53, 'I', 7, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (138, 'Rivers', 19, 'K', 2300, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (139, 'Rivers', 19, 'K', 2.4, NULL, NULL, NULL, NULL, NULL, '', '', 'MacDougall 1977', 'Livingstone 1973', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (140, 'Rivers', 19, 'K', 2.3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (141, 'Rivers', 19, 'K', 59, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (142, 'Rivers', 57, 'La', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (143, 'Rivers', 3, 'Li', 3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (144, 'Rivers', 3, 'Li', 0.43, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (145, 'Rivers', 71, 'Lu', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (146, 'Rivers', 12, 'Mg', 4100, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (147, 'Rivers', 12, 'Mg', 170, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (148, 'Rivers', 25, 'Mn', 7, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (154, 'Rivers', 15, 'P', 25, NULL, NULL, NULL, NULL, NULL, '', '', 'Meybeck 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (155, 'Rivers', 15, 'P', 20, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (156, 'Rivers', 82, 'Pb', 1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (157, 'Rivers', 59, 'Pr', 0.007, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (158, 'Rivers', 37, 'Rb', 0.012, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (159, 'Rivers', 37, 'Rb', 1.1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (160, 'Rivers', 37, 'Rb', 1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (161, 'Rivers', 16, 'S', 3700, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Livingstone 1973', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (162, 'Rivers', 16, 'S', 117, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (163, 'Rivers', 51, 'Sb', 0.07, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Andreae et al. 1981', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (164, 'Rivers', 21, 'Sc', 0.004, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (165, 'Rivers', 34, 'Se', 0.06, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Measures & Burton 1978', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (166, 'Rivers', 14, 'Si', 6500, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (167, 'Rivers', 14, 'Si', 205, NULL, NULL, NULL, NULL, NULL, '', '', 'Edmond et al. 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (168, 'Rivers', 62, 'Sm', 0.008, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (169, 'Rivers', 50, 'Sn', 0.04, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Livingstone 1973', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (170, 'Rivers', 38, 'Sr', 70, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (171, 'Rivers', 38, 'Sr', 0.89, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (172, 'Rivers', 65, 'Tb', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (173, 'Rivers', 90, 'Th', NULL, NULL, NULL, NULL, 0.1, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (174, 'Rivers', 22, 'Ti', 3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (175, 'Rivers', 69, 'Tm', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (176, 'Rivers', 92, 'U', 0.3, NULL, NULL, NULL, NULL, NULL, '', '', 'MacDougall 1977', 'Livingstone 1973', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (177, 'Rivers', 92, 'U', 0.03, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (178, 'Rivers', 92, 'U', 0.04, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (179, 'Rivers', 23, 'V', 0.9, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (180, 'Rivers', 74, 'W', 0.03, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (181, 'Rivers', 70, 'Yb', 0.004, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Martin & Meybeck 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (182, 'Rivers', 30, 'Zn', 20, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (186, 'Seawater', NULL, '87Sr/86Sr', 0.70916, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (188, 'Seawater', 47, 'Ag', 2.5e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (189, 'Seawater', 47, 'Ag', 0.04, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (190, 'Seawater', 47, 'Ag', 2.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (191, 'Seawater', 47, 'Ag', 25, NULL, NULL, 0.5, 35, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (192, 'Seawater', 47, 'Ag', 3, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Schutz & Turekian 1965', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (193, 'Seawater', 47, 'Ag', 0.022, NULL, NULL, 0.001, NULL, NULL, '', '', 'Martin et al. 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (194, 'Seawater', 13, 'Al', 20, NULL, NULL, 5, 40, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (195, 'Seawater', 13, 'Al', 2e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (196, 'Seawater', 13, 'Al', 300, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (197, 'Seawater', 13, 'Al', 1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Hydes 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (198, 'Seawater', 13, 'Al', 0.03, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (199, 'Seawater', 13, 'Al', 2, NULL, NULL, NULL, NULL, NULL, '', '', 'Orians & Bruland 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (200, 'Seawater', 13, 'Al', 1, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Hydes 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (201, 'Seawater', 18, 'Ar', 15, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (202, 'Seawater', 33, 'As', 2, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Andreae 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (203, 'Seawater', 33, 'As', 23, NULL, NULL, 15, 25, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (204, 'Seawater', 33, 'As', 1700, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (205, 'Seawater', 33, 'As', 5.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (206, 'Seawater', 33, 'As', 1.8, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Andreae 1977', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (207, 'Seawater', 33, 'As', 0.023, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (208, 'Seawater', 79, 'Au', 0.004, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (209, 'Seawater', 79, 'Au', 0.03, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (210, 'Seawater', 79, 'Au', 25, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (211, 'Seawater', 79, 'Au', 5e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Falkner & Edmond 1990', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (212, 'Seawater', 79, 'Au', 2.5e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (213, 'Seawater', 79, 'Au', 11, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Schutz & Turekian 1965', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (214, 'Seawater', 5, 'B', 4500000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (215, 'Seawater', 5, 'B', 4440, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (216, 'Seawater', 5, 'B', 4.5, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Smith et al. 1995', 'Spivack 1986', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (217, 'Seawater', 5, 'B', 0.416, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (218, 'Seawater', 5, 'B', 420, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (219, 'Seawater', 5, 'B', 4.4, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Noakes & Hood 1961', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (220, 'Seawater', 56, 'Ba', 15000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (221, 'Seawater', 56, 'Ba', 100, NULL, NULL, 32, 150, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (222, 'Seawater', 56, 'Ba', 0.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (223, 'Seawater', 56, 'Ba', 11.7, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Chan et al. 1976', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (224, 'Seawater', 56, 'Ba', 20, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Turekian & Wedepohl 1961', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (225, 'Seawater', 4, 'Be', 6.5e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (226, 'Seawater', 4, 'Be', 20, NULL, NULL, 4, 30, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (227, 'Seawater', 4, 'Be', 0.0002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Measures & Edmond 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (228, 'Seawater', 4, 'Be', 0.21, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (229, 'Seawater', 4, 'Be', 0.2, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Measures & Edmond 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (230, 'Seawater', 83, 'Bi', 0.0001, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (233, 'Seawater', 83, 'Bi', 0.0042, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (234, 'Seawater', 83, 'Bi', 4e-05, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (235, 'Seawater', 35, 'Br', 0.85, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Jaenicke 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (236, 'Seawater', 35, 'Br', 67000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (237, 'Seawater', 35, 'Br', 67000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (238, 'Seawater', 35, 'Br', 0.84, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (239, 'Seawater', 35, 'Br', 840, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (240, 'Seawater', 35, 'Br', 67, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Morris & Riley 1966', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (241, 'Seawater', 6, 'C', 2, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Andrews et al. 1996', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (242, 'Seawater', 6, 'C', 28000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (243, 'Seawater', 6, 'C', 2.3, NULL, NULL, 2, 2.5, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (244, 'Seawater', 6, 'C', 4, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (245, 'Seawater', 6, 'C', 2300, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (246, 'Seawater', 6, 'C', 2200, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Broecker & Takahashi 1978', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (247, 'Seawater', 20, 'Ca', 10.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (248, 'Seawater', 20, 'Ca', 10.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (249, 'Seawater', 20, 'Ca', 448000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (250, 'Seawater', 20, 'Ca', 420000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (251, 'Seawater', 20, 'Ca', 415, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Horbie et al. 1974', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (252, 'Seawater', 20, 'Ca', 412, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Horbie et al. 1974', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (253, 'Seawater', 20, 'Ca', 10300, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (254, 'Seawater', 20, 'Ca', 10, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Andrews et al. 1996', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (255, 'Seawater', 48, 'Cd', 70, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Bruland 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (256, 'Seawater', 48, 'Cd', 0.0007, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (257, 'Seawater', 48, 'Cd', 0.7, NULL, NULL, 0.001, 1.1, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (258, 'Seawater', 48, 'Cd', 0.07, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Boyle 1976', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (259, 'Seawater', 48, 'Cd', 79, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (260, 'Seawater', 58, 'Ce', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (261, 'Seawater', 58, 'Ce', 1.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (262, 'Seawater', 58, 'Ce', 2e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (263, 'Seawater', 58, 'Ce', 20, NULL, NULL, 16, 26, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (264, 'Seawater', 58, 'Ce', 4, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (265, 'Seawater', 17, 'Cl', 19.353, NULL, NULL, NULL, NULL, NULL, 'g/kg', '', 'Quinby-Hunt & Turekian 1983', 'Wilson 1975', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (266, 'Seawater', 17, 'Cl', 550000, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (267, 'Seawater', 17, 'Cl', 0.546, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (268, 'Seawater', 17, 'Cl', 540, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (269, 'Seawater', 17, 'Cl', 18800000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (270, 'Seawater', 17, 'Cl', 550, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Andrews et al. 1996', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (271, 'Seawater', 17, 'Cl', 18800000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (272, 'Seawater', 27, 'Co', 1.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (273, 'Seawater', 27, 'Co', 0.02, NULL, NULL, 0.01, 0.1, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (274, 'Seawater', 27, 'Co', 3e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (275, 'Seawater', 27, 'Co', 2, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Knauer & Martin 1973', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (276, 'Seawater', 27, 'Co', 15.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Craig et al. 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (277, 'Seawater', 27, 'Co', 0.002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Knauer et al. 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (278, 'Seawater', 24, 'Cr', 0.004, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (279, 'Seawater', 24, 'Cr', 0.3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (280, 'Seawater', 24, 'Cr', 2.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (281, 'Seawater', 24, 'Cr', 250, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (282, 'Seawater', 24, 'Cr', 4, NULL, NULL, 2, 5, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (283, 'Seawater', 24, 'Cr', 2.3, NULL, NULL, 3, 5, NULL, '', '', 'Jeandel & Minster 1987', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (284, 'Seawater', 24, 'Cr', 350, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Cranston 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (285, 'Seawater', 24, 'Cr', 330, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Cranston 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (286, 'Seawater', 24, 'Cr', 330, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Cranston 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (287, 'Seawater', 55, 'Cs', 0.4, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (288, 'Seawater', 55, 'Cs', 306, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (289, 'Seawater', 55, 'Cs', 2, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (290, 'Seawater', 55, 'Cs', 0.3, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Brass & Turekian 1974', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (291, 'Seawater', 55, 'Cs', 0.0022, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (292, 'Seawater', 55, 'Cs', 0.3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (293, 'Seawater', 55, 'Cs', 2.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (294, 'Seawater', 29, 'Cu', 4, NULL, NULL, 0.5, 6, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (295, 'Seawater', 29, 'Cu', 120, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Bruland 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (296, 'Seawater', 29, 'Cu', 0.004, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (297, 'Seawater', 29, 'Cu', 210, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (298, 'Seawater', 29, 'Cu', 0.2, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Boyle 1976', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (300, 'Seawater', NULL, 'd18O', 0, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (302, 'Seawater', NULL, 'd6Li', -32.3, NULL, NULL, -32.8, -31.8, NULL, '', '', 'Chan et al. 1992', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (303, 'Seawater', NULL, 'dD', 0, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (304, 'Seawater', 66, 'Dy', 6e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (305, 'Seawater', 66, 'Dy', 6, NULL, NULL, 4.8, 6.1, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (306, 'Seawater', 66, 'Dy', 1.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (307, 'Seawater', 66, 'Dy', 1, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (308, 'Seawater', 68, 'Er', 5e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (309, 'Seawater', 68, 'Er', 5, NULL, NULL, 4.1, 5.8, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (310, 'Seawater', 68, 'Er', 1.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (311, 'Seawater', 68, 'Er', 0.0008, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (312, 'Seawater', 68, 'Er', 0.9, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (313, 'Seawater', 63, 'Eu', 9e-07, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (314, 'Seawater', 63, 'Eu', 0.9, NULL, NULL, 0.6, 1, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (315, 'Seawater', 63, 'Eu', 0.21, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (316, 'Seawater', 63, 'Eu', 0.0001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Turekian & Wedepohl 1961', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (317, 'Seawater', 63, 'Eu', 0.1, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (318, 'Seawater', 9, 'F', 1300000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (319, 'Seawater', 9, 'F', 1300, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (320, 'Seawater', 9, 'F', 68, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (321, 'Seawater', 9, 'F', 68, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (322, 'Seawater', 9, 'F', 1.3, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Bewers et al. 1973', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (323, 'Seawater', 26, 'Fe', 2, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (324, 'Seawater', 26, 'Fe', 250, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (325, 'Seawater', 26, 'Fe', 40, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Gordon et al. 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (326, 'Seawater', 26, 'Fe', 1, NULL, NULL, 0.1, 2.5, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (327, 'Seawater', 26, 'Fe', 0.001, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (328, 'Seawater', 26, 'Fe', 1.5e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (329, 'Seawater', 31, 'Ga', 1.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (330, 'Seawater', 31, 'Ga', 0.03, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (331, 'Seawater', 31, 'Ga', 0.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (332, 'Seawater', 31, 'Ga', 0.0003, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (333, 'Seawater', 31, 'Ga', NULL, NULL, NULL, 10, 20, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Burton et al. 1959', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (334, 'Seawater', 64, 'Gd', 6e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (335, 'Seawater', 64, 'Gd', 0.8, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (336, 'Seawater', 64, 'Gd', 6, NULL, NULL, 3.4, 7.2, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (337, 'Seawater', 64, 'Gd', 1.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (338, 'Seawater', 64, 'Gd', 0.0007, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (339, 'Seawater', 32, 'Ge', 5, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Froelich & Andreae 1981', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (340, 'Seawater', 32, 'Ge', 7e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (341, 'Seawater', 32, 'Ge', 70, NULL, NULL, 7, 115, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (342, 'Seawater', 32, 'Ge', 4.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (343, 'Seawater', 32, 'Ge', 0.007, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Froelich & Andreae 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (344, 'Seawater', 1, 'H', 54000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (345, 'Seawater', 2, 'He', 0.0018, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (346, 'Seawater', 2, 'He', 1.9, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Clarke et al. 1970', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (347, 'Seawater', 72, 'Hf', 3.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (348, 'Seawater', 72, 'Hf', NULL, NULL, NULL, NULL, 8, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Schutz & Turekian 1965', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (349, 'Seawater', 72, 'Hf', NULL, NULL, NULL, NULL, 4e-05, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (350, 'Seawater', 72, 'Hf', 0.0008, NULL, NULL, 0.0004, 0.02, NULL, '', '', 'Godfrey et al. 1996', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (351, 'Seawater', 72, 'Hf', NULL, NULL, NULL, NULL, 40, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (352, 'Seawater', 72, 'Hf', 0.007, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (353, 'Seawater', 80, 'Hg', 6, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Mukherji & Kester 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (354, 'Seawater', 80, 'Hg', 0.005, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Matsunaga et al. 1975', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (355, 'Seawater', 80, 'Hg', 0.42, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (356, 'Seawater', 80, 'Hg', 5, NULL, NULL, 2, 10, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (357, 'Seawater', 80, 'Hg', 5e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (358, 'Seawater', 67, 'Ho', 0.2, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Sastry et al. 1969', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (359, 'Seawater', 67, 'Ho', 2e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (360, 'Seawater', 67, 'Ho', 1.9, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (361, 'Seawater', 67, 'Ho', 0.45, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (362, 'Seawater', 67, 'Ho', 0.0002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (363, 'Seawater', 53, 'I', 0.01, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Jaenicke 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (364, 'Seawater', 53, 'I', 60, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (365, 'Seawater', 53, 'I', 4.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (366, 'Seawater', 53, 'I', 58000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (367, 'Seawater', 53, 'I', 0.4, NULL, NULL, 0.2, 0.5, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (368, 'Seawater', 53, 'I', 0.44, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (369, 'Seawater', 53, 'I', 60, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Wong & Brewer 1974', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (370, 'Seawater', 53, 'I', 59, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Wong & Brewer 1974', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (371, 'Seawater', 49, 'In', 0.0001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (372, 'Seawater', 49, 'In', 0.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (373, 'Seawater', 49, 'In', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (374, 'Seawater', 49, 'In', 1e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (375, 'Seawater', 49, 'In', 0.2, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Matthews & Riley 1970', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (376, 'Seawater', 77, 'Ir', 0.002, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (377, 'Seawater', 77, 'Ir', 0.18, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Goldberg et al. 1986', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (378, 'Seawater', 19, 'K', 10, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Andrews et al. 1996', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (379, 'Seawater', 19, 'K', 380000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (380, 'Seawater', 19, 'K', 390000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (381, 'Seawater', 19, 'K', 9.8, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (382, 'Seawater', 19, 'K', 10.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (383, 'Seawater', 19, 'K', 392, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (384, 'Seawater', 19, 'K', 10.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (385, 'Seawater', 19, 'K', 10200, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (386, 'Seawater', 19, 'K', 399, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Culkin & Cox 1966', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (387, 'Seawater', 36, 'Kr', 3.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Bieri et al. 1968', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (388, 'Seawater', 36, 'Kr', 0.0034, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (390, 'Seawater', 57, 'La', 30, NULL, NULL, 13, 37, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (391, 'Seawater', 57, 'La', 5.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (392, 'Seawater', 57, 'La', 0.003, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (393, 'Seawater', 57, 'La', 4, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Spell & McDougall 2003', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (394, 'Seawater', 3, 'Li', 178, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Fabricand et al. 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (395, 'Seawater', 3, 'Li', 25, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (396, 'Seawater', 3, 'Li', 25, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (397, 'Seawater', 3, 'Li', 180000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (398, 'Seawater', 3, 'Li', 180, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (399, 'Seawater', 71, 'Lu', 0.0002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (400, 'Seawater', 71, 'Lu', 0.32, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (401, 'Seawater', 71, 'Lu', 0.9, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (402, 'Seawater', 71, 'Lu', 9e-07, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (403, 'Seawater', 71, 'Lu', 0.2, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Sastry et al. 1969', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (404, 'Seawater', 12, 'Mg', 53, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Andrews et al. 1996', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (405, 'Seawater', 12, 'Mg', 1290000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (406, 'Seawater', 12, 'Mg', 1290000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (407, 'Seawater', 12, 'Mg', 52.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (408, 'Seawater', 12, 'Mg', 53.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (409, 'Seawater', 12, 'Mg', 53000, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (410, 'Seawater', 12, 'Mg', 1.28, NULL, NULL, NULL, NULL, NULL, 'g/kg', '', 'Quinby-Hunt & Turekian 1983', 'Carpenter & Mannella 1973', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (411, 'Seawater', 25, 'Mn', 0.04, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Klinkhammer & Bender 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (412, 'Seawater', 25, 'Mn', 72, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (413, 'Seawater', 25, 'Mn', 10, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Landing & Bruland 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (414, 'Seawater', 25, 'Mn', 0.005, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (415, 'Seawater', 25, 'Mn', 0.5, NULL, NULL, 0.2, 3, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (416, 'Seawater', 42, 'Mo', 10, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (417, 'Seawater', 42, 'Mo', 0.11, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (418, 'Seawater', 42, 'Mo', 0.11, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (419, 'Seawater', 42, 'Mo', 10000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (420, 'Seawater', 42, 'Mo', 11, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Cranston 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (421, 'Seawater', 7, 'N', 420000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (422, 'Seawater', 7, 'N', 30, NULL, NULL, 0.1, 45, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (423, 'Seawater', 7, 'N', 30, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (424, 'Seawater', 7, 'N', 580, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (425, 'Seawater', 7, 'N', 30, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Bainbridge 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (426, 'Seawater', 7, 'N', 590, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Craig et al. 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (427, 'Seawater', 11, 'Na', 470000, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (428, 'Seawater', 11, 'Na', 10.781, NULL, NULL, NULL, NULL, NULL, 'g/kg', '', 'Quinby-Hunt & Turekian 1983', 'Millero & Leung 1976', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (429, 'Seawater', 11, 'Na', 470, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Andrews et al. 1996', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (430, 'Seawater', 11, 'Na', 10800000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (431, 'Seawater', 11, 'Na', 10800000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (432, 'Seawater', 11, 'Na', 463, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (433, 'Seawater', 11, 'Na', 0.468, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (434, 'Seawater', 41, 'Nb', NULL, NULL, NULL, NULL, 5e-05, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (435, 'Seawater', 41, 'Nb', 10, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (436, 'Seawater', 41, 'Nb', NULL, NULL, NULL, NULL, 50, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (437, 'Seawater', 41, 'Nb', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (438, 'Seawater', 41, 'Nb', 1, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Carlisle & Hummerstone 1958', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (439, 'Seawater', 60, 'Nd', 0.003, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (440, 'Seawater', 60, 'Nd', 4.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (441, 'Seawater', 60, 'Nd', 20, NULL, NULL, 12, 25, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (442, 'Seawater', 60, 'Nd', 2e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (443, 'Seawater', 60, 'Nd', 4, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (444, 'Seawater', 10, 'Ne', 0.0075, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (445, 'Seawater', 10, 'Ne', 8, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Craig et al. 1967', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (446, 'Seawater', 28, 'Ni', 0.008, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (447, 'Seawater', 28, 'Ni', 8, NULL, NULL, 2, 12, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (448, 'Seawater', 28, 'Ni', 530, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (449, 'Seawater', 28, 'Ni', 0.5, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Boyle 1976', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (450, 'Seawater', 28, 'Ni', 480, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Bruland 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (451, 'Seawater', 8, 'O', NULL, NULL, NULL, 0, 300, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (452, 'Seawater', 8, 'O', 220, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (453, 'Seawater', 8, 'O', 54000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (454, 'Seawater', 8, 'O', 150, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Bainbridge 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (456, 'Seawater', 15, 'P', 60, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (457, 'Seawater', 15, 'P', 65000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (458, 'Seawater', 15, 'P', 2.3, NULL, NULL, 1, 3.5, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (459, 'Seawater', 15, 'P', 2.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (460, 'Seawater', 15, 'P', 2, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Bainbridge 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (461, 'Seawater', 82, 'Pb', 2.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (462, 'Seawater', 82, 'Pb', 0.002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Schaule & Patterson 1981', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (463, 'Seawater', 82, 'Pb', 10, NULL, NULL, 5, 175, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (464, 'Seawater', 82, 'Pb', 1e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (465, 'Seawater', 82, 'Pb', 1, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Schaule & Patterson 1981', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (466, 'Seawater', 46, 'Pd', 0.07, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (467, 'Seawater', 46, 'Pd', NULL, NULL, NULL, 0.00018, 0.00066, NULL, '', '', 'Lee 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (468, 'Seawater', 59, 'Pr', 4e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (471, 'Seawater', 59, 'Pr', 0.0006, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (472, 'Seawater', 59, 'Pr', 0.6, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Sastry et al. 1969', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (473, 'Seawater', 78, 'Pt', 0.27, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (474, 'Seawater', 78, 'Pt', 0.002, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Goldberg et al. 1986', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (475, 'Seawater', 88, 'Ra', 0.00013, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (476, 'Seawater', 37, 'Rb', 120000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (477, 'Seawater', 37, 'Rb', 1.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (478, 'Seawater', 37, 'Rb', 1.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (479, 'Seawater', 37, 'Rb', 1.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (480, 'Seawater', 37, 'Rb', 124, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Spencer et al. 1970', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (481, 'Seawater', 37, 'Rb', 120, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (482, 'Seawater', 37, 'Rb', 0.11, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (483, 'Seawater', 75, 'Re', 0.004, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (484, 'Seawater', 75, 'Re', 8, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (486, 'Seawater', 75, 'Re', 20, NULL, NULL, 14, 30, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (487, 'Seawater', 75, 'Re', 2e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (488, 'Seawater', 75, 'Re', 4, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Olafsson & Riley 1972', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (489, 'Seawater', 44, 'Ru', 0.5, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Dixon et al. 1966', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (490, 'Seawater', 44, 'Ru', NULL, NULL, NULL, NULL, 0.005, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (491, 'Seawater', 16, 'S', 28, NULL, NULL, NULL, NULL, NULL, '', '', 'von Glasow & Crutzen 2004', 'Andrews et al. 1996', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (492, 'Seawater', 16, 'S', 905000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (493, 'Seawater', 16, 'S', 898000000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (494, 'Seawater', 16, 'S', 28.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (495, 'Seawater', 16, 'S', 28000, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (496, 'Seawater', 16, 'S', 2.712, NULL, NULL, NULL, NULL, NULL, 'g/kg', '', 'Quinby-Hunt & Turekian 1983', 'Morris & Riley 1966', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (497, 'Seawater', 51, 'Sb', 150, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (498, 'Seawater', 51, 'Sb', 1.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (499, 'Seawater', 51, 'Sb', 0.0012, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (500, 'Seawater', 51, 'Sb', 0.2, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Griel & Robinson 1952', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (501, 'Seawater', 51, 'Sb', 0.15, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Andreae et al. 1981', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (502, 'Seawater', 21, 'Sc', NULL, NULL, NULL, NULL, 1, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Brewer et al. 1972', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (503, 'Seawater', 21, 'Sc', 1.5e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (504, 'Seawater', 21, 'Sc', 15, NULL, NULL, 8, 20, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (505, 'Seawater', 21, 'Sc', 0.86, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (506, 'Seawater', 21, 'Sc', 0.0006, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (507, 'Seawater', 34, 'Se', 0.0017, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (508, 'Seawater', 34, 'Se', 170, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Measures & Burton 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (509, 'Seawater', 34, 'Se', 1.7, NULL, NULL, 0.5, 2.3, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (510, 'Seawater', 34, 'Se', 100, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (511, 'Seawater', 34, 'Se', 55, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (512, 'Seawater', 34, 'Se', 0.1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Sugimura et al. 1976', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (513, 'Seawater', 14, 'Si', 110, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Bainbridge 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (514, 'Seawater', 14, 'Si', 0.18, NULL, NULL, NULL, NULL, NULL, '', '', 'Bowers & Taylor 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (515, 'Seawater', 14, 'Si', 2500000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (516, 'Seawater', 14, 'Si', 2000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Turekian & Wedepohl 1961', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (517, 'Seawater', 14, 'Si', 100, NULL, NULL, 1, 180, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (518, 'Seawater', 14, 'Si', 100, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (519, 'Seawater', 62, 'Sm', 4e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (520, 'Seawater', 62, 'Sm', 0.6, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (521, 'Seawater', 62, 'Sm', 4, NULL, NULL, 2.7, 4.8, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (522, 'Seawater', 62, 'Sm', 0.84, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (523, 'Seawater', 62, 'Sm', 0.0005, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Turekian & Wedepohl 1961', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (524, 'Seawater', 50, 'Sn', 0.5, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Byrd & Andreae 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (525, 'Seawater', 50, 'Sn', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (526, 'Seawater', 50, 'Sn', 0.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (528, 'Seawater', 50, 'Sn', 4e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (529, 'Seawater', 38, 'Sr', 7.8, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Brass & Turekian 1974', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (530, 'Seawater', 38, 'Sr', 8000, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Turekian & Wedepohl 1961', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (531, 'Seawater', 38, 'Sr', 7.7, NULL, NULL, NULL, NULL, NULL, 'mg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Brass & Turekian 1974', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (532, 'Seawater', 38, 'Sr', 90, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (533, 'Seawater', 38, 'Sr', 90, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (534, 'Seawater', 38, 'Sr', 87, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (535, 'Seawater', 38, 'Sr', 7800000, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (536, 'Seawater', 73, 'Ta', NULL, NULL, NULL, NULL, 14, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (537, 'Seawater', 73, 'Ta', NULL, NULL, NULL, NULL, 2.5, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (538, 'Seawater', 73, 'Ta', 0.002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (539, 'Seawater', 73, 'Ta', NULL, NULL, NULL, NULL, 1.4e-05, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (695, 'Core', 24, 'Cr', 7790, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Allegre et al. 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (540, 'Seawater', 73, 'Ta', NULL, NULL, NULL, NULL, 2.5, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Schutz & Turekian 1965', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (541, 'Seawater', 65, 'Tb', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (542, 'Seawater', 65, 'Tb', 0.1, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Sastry et al. 1969', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (543, 'Seawater', 65, 'Tb', 9e-07, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (544, 'Seawater', 65, 'Tb', 0.9, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (545, 'Seawater', 65, 'Tb', 0.21, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (546, 'Seawater', 52, 'Te', 0.05, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (704, 'Core', 63, 'Eu', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (547, 'Seawater', 52, 'Te', 0.02, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (548, 'Seawater', 90, 'Th', 6e-05, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Anderson 1981', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (549, 'Seawater', 90, 'Th', NULL, NULL, NULL, NULL, 3e-06, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (550, 'Seawater', 90, 'Th', 0.05, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (551, 'Seawater', 90, 'Th', NULL, NULL, NULL, NULL, 0.7, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Turekian & Chan 1971', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (552, 'Seawater', 22, 'Ti', NULL, NULL, NULL, NULL, 1, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Griel & Robinson 1952', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (553, 'Seawater', 22, 'Ti', NULL, NULL, NULL, NULL, 0.02, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (554, 'Seawater', 22, 'Ti', NULL, NULL, NULL, NULL, 20, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (555, 'Seawater', 22, 'Ti', 1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (556, 'Seawater', 22, 'Ti', 10, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (557, 'Seawater', 81, 'Tl', 6e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (558, 'Seawater', 81, 'Tl', 12, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (559, 'Seawater', 81, 'Tl', NULL, NULL, NULL, 12, 16, NULL, 'ng/kg', '', 'Flegal & Patterson 1985', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (560, 'Seawater', 81, 'Tl', 60, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (561, 'Seawater', 81, 'Tl', 14, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (562, 'Seawater', 81, 'Tl', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (563, 'Seawater', 69, 'Tm', 0.25, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (564, 'Seawater', 69, 'Tm', 0.8, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (565, 'Seawater', 69, 'Tm', 0.0002, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (566, 'Seawater', 69, 'Tm', 0.2, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Sastry et al. 1969', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (567, 'Seawater', 69, 'Tm', 8e-07, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (568, 'Seawater', 92, 'U', 3200, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (569, 'Seawater', 92, 'U', 3.2, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (570, 'Seawater', 92, 'U', 3.3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Hart & Staudigel 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (571, 'Seawater', 92, 'U', 3.238, NULL, NULL, NULL, NULL, 21, 'ng/g', '', 'Chen et al. 1986', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (572, 'Seawater', 92, 'U', 0.013, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (573, 'Seawater', 92, 'U', 3.2, NULL, NULL, NULL, NULL, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Turekian & Chan 1971', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (574, 'Seawater', 23, 'V', 2.5, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (575, 'Seawater', 23, 'V', 2150, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (576, 'Seawater', 23, 'V', 30, NULL, NULL, 20, 35, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (577, 'Seawater', 23, 'V', 0.023, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (578, 'Seawater', 23, 'V', NULL, NULL, NULL, NULL, 1, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Morris 1975', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (579, 'Seawater', 74, 'W', 0.1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (580, 'Seawater', 74, 'W', 100, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (581, 'Seawater', 74, 'W', 0.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (582, 'Seawater', 74, 'W', 6e-05, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (583, 'Seawater', 74, 'W', NULL, NULL, NULL, NULL, 1, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Ishibashi 1953', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (584, 'Seawater', 54, 'Xe', 0.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Quinby-Hunt & Turekian 1983', 'Mazor et al. 1964', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (585, 'Seawater', 54, 'Xe', 0.0005, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (586, 'Seawater', 39, 'Y', 0.0013, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (587, 'Seawater', 39, 'Y', 13, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (588, 'Seawater', 39, 'Y', 0.15, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (589, 'Seawater', 39, 'Y', 0.00015, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (590, 'Seawater', 39, 'Y', 13, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Hogdahl et al. 1968', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (591, 'Seawater', 70, 'Yb', 0.0008, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (592, 'Seawater', 70, 'Yb', 1.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (593, 'Seawater', 70, 'Yb', 0.9, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Elderfield & Greaves 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (594, 'Seawater', 70, 'Yb', 5e-06, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (595, 'Seawater', 70, 'Yb', 5, NULL, NULL, 3.5, 5.4, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (596, 'Seawater', 30, 'Zn', 390, NULL, NULL, NULL, NULL, NULL, 'ng/kg', '', 'Quinby-Hunt & Turekian 1983', 'Bruland 1980', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (597, 'Seawater', 30, 'Zn', 0.006, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (598, 'Seawater', 30, 'Zn', 6, NULL, NULL, 0.05, 9, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (599, 'Seawater', 30, 'Zn', 0.3, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', 'Boyle 1976', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (600, 'Seawater', 30, 'Zn', 320, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (601, 'Seawater', 40, 'Zr', 0.0003, NULL, NULL, NULL, NULL, NULL, '', '', 'Broeker & Peng 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (602, 'Seawater', 40, 'Zr', NULL, NULL, NULL, 0.012, 0.3, NULL, '', '', 'McKelvey & Orians 1993', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (603, 'Seawater', 40, 'Zr', 0.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Bruland 1983', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (604, 'Seawater', 40, 'Zr', 17, NULL, NULL, NULL, NULL, NULL, '', '', 'Li 1991', 'Whitfield & Turner 1987', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (605, 'Seawater', 40, 'Zr', NULL, NULL, NULL, NULL, 1, NULL, 'µg/kg', '', 'Quinby-Hunt & Turekian 1983', 'Sastry et al. 1969', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (606, 'Seawater', 40, 'Zr', 0.03, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'Li 1982', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (607, 'Lake Tanganyika', NULL, 'd6Li', -32.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', 'Chan & Edmond 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (608, 'Lake Tanganyika', 3, 'Li', 2.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', 'Chan & Edmond 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (609, 'Congo River', NULL, '87Sr/86Sr', 0.7155, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (610, 'Congo River', 3, 'Li', 125, NULL, NULL, NULL, NULL, NULL, '', '', 'Huh et al. 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (611, 'Congo River', 38, 'Sr', 0.313, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (613, 'Danube River', 38, 'Sr', 2.759, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Palmer & Edmond 1989', NULL, NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (612, 'Danube River', NULL, '87Sr/86Sr', 0.7089, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '	Palmer & Edmond 1989', NULL, NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (614, 'Rhine River', 38, 'Sr', 6.227, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Palmer & Edmond 1989', NULL, NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (615, 'Rhine River', NULL, '87Sr/86Sr', 0.7092, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '	Palmer & Edmond 1989', NULL, NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (616, 'Congo River Particulates', 47, 'Ag', 38, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (617, 'Congo River Particulates', 13, 'Al', 117000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (618, 'Congo River Particulates', 33, 'As', 3.8, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (619, 'Congo River Particulates', 79, 'Au', 0.04, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (620, 'Congo River Particulates', 5, 'B', 43, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (621, 'Congo River Particulates', 56, 'Ba', 790, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (622, 'Congo River Particulates', 35, 'Br', 10, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (623, 'Congo River Particulates', 20, 'Ca', 8400, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (624, 'Congo River Particulates', 58, 'Ce', 90, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (184, 'Seawater', NULL, '234U/238U', 625800, NULL, 600, NULL, NULL, 9, '', '', 'Chen et al. 1986', '', NULL, 600, 'sd');
INSERT INTO public.reservoir VALUES (625, 'Congo River Particulates', 27, 'Co', 25, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (626, 'Congo River Particulates', 24, 'Cr', 175, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (627, 'Congo River Particulates', 55, 'Cs', 6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (628, 'Congo River Particulates', 63, 'Eu', 1.6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (629, 'Congo River Particulates', 26, 'Fe', 71000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (630, 'Congo River Particulates', 31, 'Ga', 25, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (631, 'Congo River Particulates', 64, 'Gd', 2.5, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (632, 'Congo River Particulates', 72, 'Hf', 5.1, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (633, 'Congo River Particulates', 19, 'K', 12000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (634, 'Congo River Particulates', 57, 'La', 50, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (635, 'Congo River Particulates', 71, 'Lu', 0.37, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (636, 'Congo River Particulates', 12, 'Mg', 5800, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (637, 'Congo River Particulates', 25, 'Mn', 1400, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (638, 'Congo River Particulates', 42, 'Mo', 4, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (639, 'Congo River Particulates', 11, 'Na', 2100, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (640, 'Congo River Particulates', 28, 'Ni', 74, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (641, 'Congo River Particulates', 15, 'P', 1500, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (642, 'Congo River Particulates', 82, 'Pb', 455, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (643, 'Congo River Particulates', 37, 'Rb', 60, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (644, 'Congo River Particulates', 51, 'Sb', 1, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (645, 'Congo River Particulates', 21, 'Sc', 12, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (646, 'Congo River Particulates', 14, 'Si', 239000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (647, 'Congo River Particulates', 38, 'Sr', 61, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (648, 'Congo River Particulates', 73, 'Ta', 1.1, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (649, 'Congo River Particulates', 65, 'Tb', 1.6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (650, 'Congo River Particulates', 90, 'Th', 16.2, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (651, 'Congo River Particulates', 22, 'Ti', 8400, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (652, 'Congo River Particulates', 92, 'U', 3, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (653, 'Congo River Particulates', 23, 'V', 163, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (654, 'Congo River Particulates', 70, 'Yb', 2.6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (655, 'Congo River Particulates', 30, 'Zn', 400, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'Martin & Meybeck 1979', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (656, 'Core', 47, 'Ag', 0.15, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (657, 'Core', 47, 'Ag', 0.15, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (658, 'Core', 13, 'Al', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (659, 'Core', 13, 'Al', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (660, 'Core', 33, 'As', 5, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (661, 'Core', 33, 'As', 5, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (662, 'Core', 79, 'Au', 0.5, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (663, 'Core', 79, 'Au', 0.5, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (664, 'Core', 5, 'B', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (665, 'Core', 56, 'Ba', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (666, 'Core', 4, 'Be', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (667, 'Core', 83, 'Bi', 0.03, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (668, 'Core', 83, 'Bi', 0.03, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (669, 'Core', 35, 'Br', 0.7, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (670, 'Core', 35, 'Br', 0.7, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (671, 'Core', 6, 'C', NULL, NULL, NULL, 2, 4, NULL, 'wt%', '', 'Li & Fei 2004', 'Wood 1993', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (672, 'Core', 6, 'C', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'McDonough & Sun 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (673, 'Core', 6, 'C', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (674, 'Core', 6, 'C', 2000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (675, 'Core', 6, 'C', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (676, 'Core', 6, 'C', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (677, 'Core', 6, 'C', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (678, 'Core', 20, 'Ca', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (679, 'Core', 20, 'Ca', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (680, 'Core', 48, 'Cd', 0.15, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (681, 'Core', 48, 'Cd', 0.15, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (682, 'Core', 58, 'Ce', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (683, 'Core', 17, 'Cl', 200, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (684, 'Core', 17, 'Cl', 200, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (685, 'Core', 27, 'Co', 2530, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Allegre et al. 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (686, 'Core', 27, 'Co', NULL, NULL, NULL, 0.24, 0.26, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (687, 'Core', 27, 'Co', 2500, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (688, 'Core', 27, 'Co', 0.25, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (689, 'Core', 24, 'Cr', 0.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (690, 'Core', 24, 'Cr', 9000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (691, 'Core', 24, 'Cr', 0.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (692, 'Core', 24, 'Cr', 0.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (693, 'Core', 24, 'Cr', NULL, NULL, NULL, 0.8, 0.95, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (694, 'Core', 24, 'Cr', 0.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (696, 'Core', NULL, 'Cr/Mn', NULL, NULL, NULL, 1.8, 1.8, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (697, 'Core', NULL, 'Cr/V', NULL, NULL, NULL, 67, 79, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (698, 'Core', 55, 'Cs', 0.065, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (699, 'Core', 55, 'Cs', 0.065, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (700, 'Core', 29, 'Cu', 125, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (701, 'Core', 29, 'Cu', 125, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (702, 'Core', 66, 'Dy', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (703, 'Core', 68, 'Er', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (709, 'Core', 26, 'Fe', 85.5, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (710, 'Core', 26, 'Fe', 88.3, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (711, 'Core', 26, 'Fe', 85.5, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (712, 'Core', 26, 'Fe', 85.5, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (713, 'Core', NULL, 'Fe/Cr', NULL, NULL, NULL, 98, 92, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (714, 'Core', NULL, 'Fe/Ni', NULL, NULL, NULL, 16, 16, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (715, 'Core', 31, 'Ga', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (716, 'Core', 64, 'Gd', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (717, 'Core', 32, 'Ge', 20, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (718, 'Core', 32, 'Ge', 20, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (719, 'Core', 1, 'H', 0.06, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (720, 'Core', 1, 'H', 0.06, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (721, 'Core', 1, 'H', 0.06, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'McDonough & Sun 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (722, 'Core', 1, 'H', 600, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (723, 'Core', 1, 'H', 0.06, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (724, 'Core', 1, 'H', 600, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (725, 'Core', 72, 'Hf', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (726, 'Core', 80, 'Hg', 0.05, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (727, 'Core', 80, 'Hg', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (728, 'Core', 67, 'Ho', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (729, 'Core', 53, 'I', 0.13, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (730, 'Core', 53, 'I', 0.13, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (731, 'Core', 49, 'In', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (732, 'Core', 77, 'Ir', 2.6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (733, 'Core', 77, 'Ir', 2.6, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (734, 'Core', 19, 'K', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (735, 'Core', 57, 'La', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (736, 'Core', 3, 'Li', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (737, 'Core', 71, 'Lu', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (738, 'Core', 12, 'Mg', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (739, 'Core', 12, 'Mg', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (740, 'Core', 25, 'Mn', 0.03, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (741, 'Core', 25, 'Mn', 300, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (742, 'Core', 25, 'Mn', 5820, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Allegre et al. 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (743, 'Core', 25, 'Mn', NULL, NULL, NULL, 0.45, 0.5, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (744, 'Core', 25, 'Mn', 50, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (745, 'Core', 42, 'Mo', 5, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (746, 'Core', 42, 'Mo', 5, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (747, 'Core', 7, 'N', 75, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (748, 'Core', 7, 'N', 170, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (749, 'Core', 11, 'Na', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (750, 'Core', 11, 'Na', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (751, 'Core', 41, 'Nb', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (752, 'Core', 60, 'Nd', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (753, 'Core', 28, 'Ni', 52000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (754, 'Core', 28, 'Ni', NULL, NULL, NULL, 4.9, 5.4, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (755, 'Core', 28, 'Ni', 5.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (756, 'Core', 28, 'Ni', 5.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (757, 'Core', 28, 'Ni', 5.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (758, 'Core', 28, 'Ni', 5.4, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (760, 'Core', NULL, 'Ni/Co', NULL, NULL, NULL, 20.8, 20.8, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (761, 'Core', NULL, 'Ni/P', NULL, NULL, NULL, 10, 11, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (762, 'Core', 8, 'O', 3, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (763, 'Core', 8, 'O', 4.1, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'Allegre et al. 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (764, 'Core', 8, 'O', 5.8, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'McDonough & Sun 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (765, 'Core', 8, 'O', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (767, 'Core', 8, 'O', 0, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (768, 'Core', 76, 'Os', 2.8, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (769, 'Core', 76, 'Os', 2.8, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (770, 'Core', 15, 'P', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (771, 'Core', 15, 'P', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (772, 'Core', 15, 'P', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (773, 'Core', 15, 'P', 0.2, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (774, 'Core', 15, 'P', 3690, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'Allegre et al. 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (775, 'Core', 15, 'P', 3200, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (776, 'Core', 15, 'P', NULL, NULL, NULL, 0.5, 0.5, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (777, 'Core', 82, 'Pb', 0.4, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (778, 'Core', 82, 'Pb', 0.4, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (779, 'Core', 46, 'Pd', 3.1, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (780, 'Core', 46, 'Pd', 3.1, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (781, 'Core', 59, 'Pr', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (782, 'Core', 78, 'Pt', 5.7, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (783, 'Core', 78, 'Pt', 5.7, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (784, 'Core', 37, 'Rb', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (785, 'Core', 75, 'Re', 0.23, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (786, 'Core', 75, 'Re', 0.23, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (787, 'Core', 45, 'Rh', 0.74, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (788, 'Core', 45, 'Rh', 0.74, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (789, 'Core', 44, 'Ru', 4, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (790, 'Core', 44, 'Ru', 4, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (793, 'Core', 16, 'S', NULL, NULL, NULL, NULL, 2, NULL, 'wt%', '', 'Li & Fei 2004', 'Dreibus & Palme 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (794, 'Core', 16, 'S', NULL, NULL, NULL, 1.8, 4.1, NULL, 'wt%', '', 'Li & Fei 2004', 'Kargel & Lewis 1993', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (795, 'Core', 16, 'S', 2.3, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'Allegre et al. 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (796, 'Core', 16, 'S', 1.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'McDonough & Sun 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (798, 'Core', 16, 'S', 1.9, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (800, 'Core', 16, 'S', 19000, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (801, 'Core', 51, 'Sb', 0.13, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (802, 'Core', 51, 'Sb', 0.13, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (803, 'Core', 21, 'Sc', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (804, 'Core', 34, 'Se', 8, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (805, 'Core', 34, 'Se', 8, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (806, 'Core', 14, 'Si', 7.35, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Allegre et al. 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (807, 'Core', 14, 'Si', 6.4, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (808, 'Core', 14, 'Si', 7.35, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'Allegre et al. 1995', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (809, 'Core', 14, 'Si', 14, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'Li & Fei 2004', 'Wanke & Dreibus 1997', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (810, 'Core', 14, 'Si', 6, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (811, 'Core', 14, 'Si', 6, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (812, 'Core', 14, 'Si', 6, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (813, 'Core', 62, 'Sm', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (814, 'Core', 50, 'Sn', 0.5, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (815, 'Core', 50, 'Sn', 0.5, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (816, 'Core', 38, 'Sr', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (817, 'Core', 73, 'Ta', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (818, 'Core', 65, 'Tb', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (819, 'Core', 52, 'Te', 0.85, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (820, 'Core', 52, 'Te', 0.85, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (821, 'Core', 90, 'Th', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (822, 'Core', 22, 'Ti', 0.03, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (823, 'Core', 22, 'Ti', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (824, 'Core', 81, 'Tl', 0.03, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (825, 'Core', 69, 'Tm', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (826, 'Core', 92, 'U', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (827, 'Core', 23, 'V', 150, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (828, 'Core', 23, 'V', 120, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (829, 'Core', 23, 'V', NULL, NULL, NULL, 120, 120, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (830, 'Core', 74, 'W', 0.47, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (831, 'Core', 74, 'W', 0.47, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (832, 'Core', 39, 'Y', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (833, 'Core', 70, 'Yb', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (834, 'Core', 30, 'Zn', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (835, 'Core', 40, 'Zr', 0, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (836, 'Dniepr River', NULL, '87Sr/86Sr', 0.7084, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (837, 'Dniepr River', 38, 'Sr', 2.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (838, 'Don River', NULL, '87Sr/86Sr', 0.7084, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (839, 'Don River', 38, 'Sr', 2.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (840, 'Juba River', NULL, '87Sr/86Sr', 0.7061, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (841, 'Juba River', 38, 'Sr', 1.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Palmer & Edmond 1989', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (842, 'Silicate Earth', NULL, '143Nd/144Nd', 0.512638, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (843, 'Silicate Earth', NULL, '143Nd/144Nd', 0.512634, NULL, NULL, NULL, NULL, NULL, '', '', 'Salters & Stracke 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (844, 'Silicate Earth', NULL, '176Hf/177Hf', 0.282843, NULL, NULL, NULL, NULL, NULL, '', '', 'Salters & Stracke 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (845, 'Silicate Earth', NULL, '176Hf/177Hf', 0.28276, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (846, 'Silicate Earth', NULL, '206Pb/204Pb', 17.511, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (847, 'Silicate Earth', NULL, '207Pb/204Pb', 15.361, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (848, 'Silicate Earth', NULL, '208Pb/204Pb', 17.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Salters & Stracke 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (849, 'Silicate Earth', NULL, '87Sr/86Sr', 0.7045, NULL, NULL, NULL, NULL, NULL, '', '', 'Salters & Stracke 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (850, 'Silicate Earth', NULL, '87Sr/86Sr', 0.7045, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (851, 'Silicate Earth', 47, 'Ag', 0.008, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (852, 'Silicate Earth', 47, 'Ag', 0.008, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (853, 'Silicate Earth', 47, 'Ag', 8, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (854, 'Silicate Earth', 13, 'Al', 1.93, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (855, 'Silicate Earth', 13, 'Al', 2.15, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (856, 'Silicate Earth', 13, 'Al', 2.22, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (857, 'Silicate Earth', 13, 'Al', 2.36, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (858, 'Silicate Earth', 13, 'Al', 2.35, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (859, 'Silicate Earth', 13, 'Al', 4.45, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (861, 'Silicate Earth', 13, 'Al', 3.97, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (862, 'Silicate Earth', 13, 'Al', 4.4, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (863, 'Silicate Earth', 13, 'Al', 2.35, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (864, 'Silicate Earth', 13, 'Al', 3.65, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (865, 'Silicate Earth', 33, 'As', 0.05, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (866, 'Silicate Earth', 33, 'As', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (867, 'Silicate Earth', 33, 'As', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (868, 'Silicate Earth', 79, 'Au', 1, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (869, 'Silicate Earth', 79, 'Au', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (870, 'Silicate Earth', 79, 'Au', 0.001, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (886, 'Silicate Earth', 83, 'Bi', 0.003, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (887, 'Silicate Earth', 35, 'Br', 0.05, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (888, 'Silicate Earth', 35, 'Br', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (889, 'Silicate Earth', 35, 'Br', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (890, 'Silicate Earth', 6, 'C', 8.3e+21, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2013', 'Hunt 1972', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (891, 'Silicate Earth', 6, 'C', 120, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (892, 'Silicate Earth', 6, 'C', 120, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (893, 'Silicate Earth', 6, 'C', 120, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (894, 'Silicate Earth', 20, 'Ca', 2.53, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (896, 'Silicate Earth', 20, 'Ca', 3.55, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (897, 'Silicate Earth', 20, 'Ca', 2.53, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (898, 'Silicate Earth', 20, 'Ca', 2.9, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (899, 'Silicate Earth', 20, 'Ca', 2.57, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (900, 'Silicate Earth', 20, 'Ca', 3.5, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (901, 'Silicate Earth', 20, 'Ca', 2.07, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (902, 'Silicate Earth', 20, 'Ca', 2.3, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (903, 'Silicate Earth', 20, 'Ca', 2.53, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (904, 'Silicate Earth', 20, 'Ca', 3.4, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (905, 'Silicate Earth', 48, 'Cd', 0.04, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (906, 'Silicate Earth', 48, 'Cd', 0.04, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (909, 'Silicate Earth', 58, 'Ce', 1.68, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (910, 'Silicate Earth', 58, 'Ce', 1.833, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (911, 'Silicate Earth', 58, 'Ce', 1.73, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (912, 'Silicate Earth', 58, 'Ce', 1.6011, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (913, 'Silicate Earth', 58, 'Ce', 1.68, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (914, 'Silicate Earth', 58, 'Ce', 1.436, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (915, 'Silicate Earth', 17, 'Cl', 17, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (916, 'Silicate Earth', 17, 'Cl', 17, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (917, 'Silicate Earth', 17, 'Cl', 17, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (919, 'Silicate Earth', 27, 'Co', 105, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (920, 'Silicate Earth', 27, 'Co', 105, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (921, 'Silicate Earth', 24, 'Cr', 0.45, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (922, 'Silicate Earth', 24, 'Cr', 0.46, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (923, 'Silicate Earth', 24, 'Cr', 2625, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (924, 'Silicate Earth', 24, 'Cr', 0.384, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (926, 'Silicate Earth', 24, 'Cr', 2625, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (927, 'Silicate Earth', 24, 'Cr', 0.44, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (928, 'Silicate Earth', NULL, 'Cr/Mn', 2.5, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (929, 'Silicate Earth', NULL, 'Cr/V', 32, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (930, 'Silicate Earth', 55, 'Cs', 0.021, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (931, 'Silicate Earth', 55, 'Cs', 0.023, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (932, 'Silicate Earth', 55, 'Cs', 0.009, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (933, 'Silicate Earth', 55, 'Cs', 0.0268, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (934, 'Silicate Earth', 55, 'Cs', 0.018, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (935, 'Silicate Earth', 55, 'Cs', 0.021, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (937, 'Silicate Earth', 29, 'Cu', 30, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (938, 'Silicate Earth', 29, 'Cu', 30, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (940, 'Silicate Earth', 66, 'Dy', 0.67, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (941, 'Silicate Earth', 66, 'Dy', 0.572, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (942, 'Silicate Earth', 66, 'Dy', 0.6378, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (951, 'Silicate Earth', NULL, 'e182W', -1.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (952, 'Silicate Earth', NULL, 'e182W', -1.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (953, 'Silicate Earth', NULL, 'e182W', 0.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (954, 'Silicate Earth', NULL, 'e182W', 0.8, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (955, 'Silicate Earth', NULL, 'e182W', -0.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (956, 'Silicate Earth', NULL, 'e182W', 0.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (957, 'Silicate Earth', NULL, 'e182W', -1.2, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (958, 'Silicate Earth', NULL, 'e182W', -1.5, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (959, 'Silicate Earth', NULL, 'e182W', -0.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (960, 'Silicate Earth', NULL, 'e182W', -0.1, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (961, 'Silicate Earth', NULL, 'e182W', -1.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (962, 'Silicate Earth', NULL, 'e182W', -1.3, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (963, 'Silicate Earth', NULL, 'e182W', -0.8, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (964, 'Silicate Earth', NULL, 'e182W', -0.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (965, 'Silicate Earth', NULL, 'e182W', 1.7, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (966, 'Silicate Earth', NULL, 'e182W', 1.4, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (967, 'Silicate Earth', NULL, 'e182W', 1, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (968, 'Silicate Earth', NULL, 'e182W', -0.6, NULL, NULL, NULL, NULL, NULL, '', '', 'Halliday 2004', 'Walter et al. 2000', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (970, 'Silicate Earth', 68, 'Er', 0.44, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (971, 'Silicate Earth', 68, 'Er', 0.479, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (972, 'Silicate Earth', 68, 'Er', 0.46, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (973, 'Silicate Earth', 68, 'Er', 0.4167, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (974, 'Silicate Earth', 68, 'Er', 0.347, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (975, 'Silicate Earth', 68, 'Er', 0.44, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (977, 'Silicate Earth', 63, 'Eu', 0.15, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (978, 'Silicate Earth', 63, 'Eu', 0.168, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (979, 'Silicate Earth', 63, 'Eu', 0.188, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (980, 'Silicate Earth', 63, 'Eu', 0.1456, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (981, 'Silicate Earth', 63, 'Eu', 0.131, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (982, 'Silicate Earth', 63, 'Eu', 0.15, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (983, 'Silicate Earth', 9, 'F', 15, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (984, 'Silicate Earth', 9, 'F', 15, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (985, 'Silicate Earth', 9, 'F', 25, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (986, 'Silicate Earth', 26, 'Fe', 6.26, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (987, 'Silicate Earth', 26, 'Fe', 8, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (988, 'Silicate Earth', 26, 'Fe', 7.82, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (989, 'Silicate Earth', 26, 'Fe', 7.82, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (990, 'Silicate Earth', 26, 'Fe', 6.26, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (992, 'Silicate Earth', 26, 'Fe', 8.05, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (993, 'Silicate Earth', NULL, 'Fe/Al', 2.7, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (994, 'Silicate Earth', NULL, 'Fe/Cr', 23.8, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (995, 'Silicate Earth', NULL, 'Fe/Ni', 31.9, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (996, 'Silicate Earth', 31, 'Ga', 4, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (997, 'Silicate Earth', 31, 'Ga', 4, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (999, 'Silicate Earth', 64, 'Gd', 0.54, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1000, 'Silicate Earth', 64, 'Gd', 0.54, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1001, 'Silicate Earth', 64, 'Gd', 0.595, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1003, 'Silicate Earth', 64, 'Gd', 0.459, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1004, 'Silicate Earth', 64, 'Gd', 0.5128, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1005, 'Silicate Earth', 64, 'Gd', 0.74, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1007, 'Silicate Earth', 32, 'Ge', 1.1, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1008, 'Silicate Earth', 32, 'Ge', 1.1, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1009, 'Silicate Earth', 1, 'H', 100, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1010, 'Silicate Earth', 1, 'H', 100, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1012, 'Silicate Earth', 72, 'Hf', 0.28, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1013, 'Silicate Earth', 72, 'Hf', 0.309, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1014, 'Silicate Earth', 72, 'Hf', 0.28, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1015, 'Silicate Earth', 72, 'Hf', 0.2676, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1026, 'Silicate Earth', 67, 'Ho', 0.15, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1028, 'Silicate Earth', 53, 'I', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1029, 'Silicate Earth', 53, 'I', 0.01, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1030, 'Silicate Earth', 53, 'I', 10, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1031, 'Silicate Earth', 49, 'In', 0.01, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1032, 'Silicate Earth', 49, 'In', 0.01, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1034, 'Silicate Earth', 77, 'Ir', 0.003, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1035, 'Silicate Earth', 77, 'Ir', 0.003, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1037, 'Silicate Earth', 19, 'K', 240, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1038, 'Silicate Earth', 19, 'K', 0.022, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1039, 'Silicate Earth', 19, 'K', 0.003, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1040, 'Silicate Earth', 19, 'K', 0.031, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1041, 'Silicate Earth', 19, 'K', 180, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1042, 'Silicate Earth', 19, 'K', 258.2, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1043, 'Silicate Earth', 19, 'K', 231, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1044, 'Silicate Earth', 19, 'K', 240, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1045, 'Silicate Earth', 19, 'K', 240, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1046, 'Silicate Earth', 19, 'K', 0.029, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1048, 'Silicate Earth', 57, 'La', 0.65, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1049, 'Silicate Earth', 57, 'La', 0.708, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1051, 'Silicate Earth', 57, 'La', 0.65, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1052, 'Silicate Earth', 57, 'La', 0.551, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1053, 'Silicate Earth', 57, 'La', 0.6139, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1054, 'Silicate Earth', 57, 'La', 0.52, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1056, 'Silicate Earth', 3, 'Li', 1.6, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1057, 'Silicate Earth', 3, 'Li', 1.6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1058, 'Silicate Earth', 71, 'Lu', 0.068, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1059, 'Silicate Earth', 71, 'Lu', 0.057, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1060, 'Silicate Earth', 71, 'Lu', 0.0637, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1061, 'Silicate Earth', 71, 'Lu', 0.074, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1062, 'Silicate Earth', 71, 'Lu', 0.0737, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1063, 'Silicate Earth', 71, 'Lu', 0.068, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1065, 'Silicate Earth', NULL, 'Lu/Hf', 0.239, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1066, 'Silicate Earth', 12, 'Mg', 22.8, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1067, 'Silicate Earth', 12, 'Mg', 35.15, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1068, 'Silicate Earth', 12, 'Mg', 38.8, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1070, 'Silicate Earth', 12, 'Mg', 22.8, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1071, 'Silicate Earth', 12, 'Mg', 37.8, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1072, 'Silicate Earth', 12, 'Mg', 38.3, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1073, 'Silicate Earth', NULL, 'Mg/Al', 9.7, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1074, 'Silicate Earth', 25, 'Mn', 1045, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1186, 'Silicate Earth', 62, 'Sm', 0.41, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1075, 'Silicate Earth', 25, 'Mn', 0.13, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1076, 'Silicate Earth', 25, 'Mn', 0.11, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1077, 'Silicate Earth', 25, 'Mn', 0.13, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1078, 'Silicate Earth', 25, 'Mn', 1045, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1080, 'Silicate Earth', 25, 'Mn', 0.135, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1081, 'Silicate Earth', 42, 'Mo', 0.05, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1082, 'Silicate Earth', 42, 'Mo', 0.05, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1084, 'Silicate Earth', 7, 'N', 4e+19, NULL, NULL, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2012', 'Marty & Dauphas 2003', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1085, 'Silicate Earth', 7, 'N', 2, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1086, 'Silicate Earth', 7, 'N', 2, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1087, 'Silicate Earth', 7, 'N', 2, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1088, 'Silicate Earth', 11, 'Na', 0.27, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1105, 'Silicate Earth', 60, 'Nd', 1.25, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1107, 'Silicate Earth', 60, 'Nd', 1.067, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1109, 'Silicate Earth', 28, 'Ni', 0.25, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1110, 'Silicate Earth', 28, 'Ni', 1960, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1111, 'Silicate Earth', 28, 'Ni', 0.25, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1112, 'Silicate Earth', 28, 'Ni', 1960, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1113, 'Silicate Earth', 28, 'Ni', 0.27, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1114, 'Silicate Earth', 28, 'Ni', 0.26, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1115, 'Silicate Earth', NULL, 'Ni/Co', 18.7, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1116, 'Silicate Earth', NULL, 'Ni/P', 22, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1117, 'Silicate Earth', 8, 'O', 44, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1118, 'Silicate Earth', 8, 'O', 44, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1119, 'Silicate Earth', 76, 'Os', 0.003, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1121, 'Silicate Earth', 76, 'Os', 0.003, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1122, 'Silicate Earth', 15, 'P', 90, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1123, 'Silicate Earth', 15, 'P', 90, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1124, 'Silicate Earth', 15, 'P', 0.021, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1126, 'Silicate Earth', 82, 'Pb', 0.15, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1127, 'Silicate Earth', 82, 'Pb', 0.15, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1130, 'Silicate Earth', 46, 'Pd', 0.004, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1131, 'Silicate Earth', 46, 'Pd', 0.004, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1132, 'Silicate Earth', 59, 'Pr', 0.25, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1133, 'Silicate Earth', 59, 'Pr', 0.206, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1135, 'Silicate Earth', 59, 'Pr', 0.278, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1136, 'Silicate Earth', 59, 'Pr', 0.2419, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1137, 'Silicate Earth', 59, 'Pr', 0.25, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1139, 'Silicate Earth', 78, 'Pt', 0.007, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1140, 'Silicate Earth', 78, 'Pt', 0.007, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1141, 'Silicate Earth', 37, 'Rb', 0.6, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1142, 'Silicate Earth', 37, 'Rb', 0.55, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1143, 'Silicate Earth', 37, 'Rb', 0.5353, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1144, 'Silicate Earth', 37, 'Rb', 0.74, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1145, 'Silicate Earth', 37, 'Rb', 0.635, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1146, 'Silicate Earth', 37, 'Rb', 0.6, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1148, 'Silicate Earth', NULL, 'Rb/Cs', 81, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1149, 'Silicate Earth', NULL, 'Rb/Cs', 28, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1150, 'Silicate Earth', NULL, 'Rb/Cs', 20, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1151, 'Silicate Earth', NULL, 'Rb/Cs', 31, NULL, NULL, NULL, NULL, NULL, '', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1152, 'Silicate Earth', NULL, 'Rb/Sr', 0.0307, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1154, 'Silicate Earth', 75, 'Re', 0.0003, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1155, 'Silicate Earth', 75, 'Re', 0.0003, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1156, 'Silicate Earth', 45, 'Rh', 0.001, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1157, 'Silicate Earth', 45, 'Rh', 0.001, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1159, 'Silicate Earth', 44, 'Ru', 0.005, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1160, 'Silicate Earth', 44, 'Ru', 0.005, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1162, 'Silicate Earth', 16, 'S', 250, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1163, 'Silicate Earth', 16, 'S', 250, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1165, 'Silicate Earth', 51, 'Sb', 0.006, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1167, 'Silicate Earth', 51, 'Sb', 0.006, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1168, 'Silicate Earth', 21, 'Sc', 14.88, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1170, 'Silicate Earth', 21, 'Sc', 16, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1171, 'Silicate Earth', 21, 'Sc', 17.3, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1172, 'Silicate Earth', 21, 'Sc', 17, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1173, 'Silicate Earth', 21, 'Sc', 13, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1174, 'Silicate Earth', 21, 'Sc', 16, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1175, 'Silicate Earth', 34, 'Se', 0.075, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1177, 'Silicate Earth', 34, 'Se', 0.075, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1178, 'Silicate Earth', 14, 'Si', 45, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Green et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1179, 'Silicate Earth', 14, 'Si', 45.16, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1180, 'Silicate Earth', 14, 'Si', 21, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1182, 'Silicate Earth', 14, 'Si', 45, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1183, 'Silicate Earth', 14, 'Si', 21, NULL, NULL, NULL, NULL, NULL, 'wt%', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1184, 'Silicate Earth', 14, 'Si', 49.9, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1187, 'Silicate Earth', 62, 'Sm', 0.444, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1188, 'Silicate Earth', 62, 'Sm', 0.52, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1189, 'Silicate Earth', 62, 'Sm', 0.3865, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1190, 'Silicate Earth', 62, 'Sm', 0.347, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1191, 'Silicate Earth', 62, 'Sm', 0.41, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1192, 'Silicate Earth', NULL, 'Sm/Nd', 0.325, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1193, 'Silicate Earth', 50, 'Sn', 0.13, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1194, 'Silicate Earth', 50, 'Sn', 0.13, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1196, 'Silicate Earth', 38, 'Sr', 20, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1197, 'Silicate Earth', 38, 'Sr', 27.7, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1198, 'Silicate Earth', 38, 'Sr', 21.1, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1200, 'Silicate Earth', 38, 'Sr', 18.21, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1201, 'Silicate Earth', 38, 'Sr', 20, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1202, 'Silicate Earth', 38, 'Sr', 17.8, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1203, 'Silicate Earth', 73, 'Ta', 0.0351, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1204, 'Silicate Earth', 73, 'Ta', 0.038, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1205, 'Silicate Earth', 73, 'Ta', 0.041, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1206, 'Silicate Earth', 73, 'Ta', 0.037, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1208, 'Silicate Earth', 73, 'Ta', 0.04, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1209, 'Silicate Earth', 73, 'Ta', 0.037, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1210, 'Silicate Earth', 65, 'Tb', 0.094, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1211, 'Silicate Earth', 65, 'Tb', 0.126, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1212, 'Silicate Earth', 65, 'Tb', 0.108, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1213, 'Silicate Earth', 65, 'Tb', 0.087, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1215, 'Silicate Earth', 65, 'Tb', 0.1, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1216, 'Silicate Earth', 65, 'Tb', 0.1, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1217, 'Silicate Earth', 52, 'Te', 12, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1218, 'Silicate Earth', 52, 'Te', 0.012, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1219, 'Silicate Earth', 52, 'Te', 0.012, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1221, 'Silicate Earth', 90, 'Th', 0.08, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1222, 'Silicate Earth', 90, 'Th', 0.084, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1223, 'Silicate Earth', 90, 'Th', 0.0813, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1224, 'Silicate Earth', 90, 'Th', 0.064, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1225, 'Silicate Earth', 90, 'Th', 0.08, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1226, 'Silicate Earth', NULL, 'Th/U', 3.9, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', 'Lundstrom et al. 1999', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1227, 'Silicate Earth', 22, 'Ti', 1200, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1228, 'Silicate Earth', 22, 'Ti', 0.201, NULL, NULL, NULL, NULL, NULL, 'wt%ox', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1229, 'Silicate Earth', 22, 'Ti', 1200, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1230, 'Silicate Earth', 22, 'Ti', 1280, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1231, 'Silicate Earth', 22, 'Ti', 1350, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1232, 'Silicate Earth', 22, 'Ti', 0.004, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1244, 'Silicate Earth', 69, 'Tm', 0.068, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1245, 'Silicate Earth', 69, 'Tm', 0.074, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1246, 'Silicate Earth', 69, 'Tm', 0.0643, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1247, 'Silicate Earth', 92, 'U', 0.02, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1248, 'Silicate Earth', 92, 'U', 0.018, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1249, 'Silicate Earth', 92, 'U', 0.0203, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1250, 'Silicate Earth', 92, 'U', 0.029, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1251, 'Silicate Earth', 92, 'U', 0.021, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1252, 'Silicate Earth', 92, 'U', 0.02, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1254, 'Silicate Earth', NULL, 'U/Pb', 0.13, NULL, NULL, NULL, NULL, NULL, '', '', 'Workman & Hart 2005', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1255, 'Silicate Earth', 23, 'V', 82, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1256, 'Silicate Earth', 23, 'V', 82, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1258, 'Silicate Earth', 74, 'W', 0.029, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1259, 'Silicate Earth', 74, 'W', 0.029, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1260, 'Silicate Earth', 74, 'W', 29, NULL, NULL, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1261, 'Silicate Earth', 39, 'Y', 4.3, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1262, 'Silicate Earth', 39, 'Y', 3.4, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1263, 'Silicate Earth', 39, 'Y', 3.94, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1264, 'Silicate Earth', 39, 'Y', 4.55, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1265, 'Silicate Earth', 39, 'Y', 4.3, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1267, 'Silicate Earth', 70, 'Yb', 0.44, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1268, 'Silicate Earth', 70, 'Yb', 0.372, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1269, 'Silicate Earth', 70, 'Yb', 0.4144, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1271, 'Silicate Earth', 70, 'Yb', 0.481, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1272, 'Silicate Earth', 70, 'Yb', 0.44, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1273, 'Silicate Earth', 70, 'Yb', 0.49, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Jagoutz et al. 1979', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1274, 'Silicate Earth', 30, 'Zn', 55, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1275, 'Silicate Earth', 30, 'Zn', 55, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1277, 'Silicate Earth', 40, 'Zr', 11.2, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Sun 1982', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1278, 'Silicate Earth', 40, 'Zr', 10.5, NULL, NULL, NULL, NULL, NULL, 'µg/g', '', 'McDonough 1998', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1279, 'Silicate Earth', 40, 'Zr', 9.714, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Hofmann 1988', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1281, 'Silicate Earth', 40, 'Zr', 10.5, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough 2004', '', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (1282, 'Silicate Earth', 40, 'Zr', 8.3, NULL, NULL, NULL, NULL, NULL, 'ppm', '', 'McDonough et al. 1992', 'Taylor & McLennan 1985', NULL, NULL, NULL);
INSERT INTO public.reservoir VALUES (8, 'Atmosphere', NULL, '124Xe', 2.337, NULL, 0.008, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.008, 'sd');
INSERT INTO public.reservoir VALUES (9, 'Atmosphere', NULL, '126Xe', 2.18, NULL, 0.011, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.011, 'sd');
INSERT INTO public.reservoir VALUES (10, 'Atmosphere', NULL, '128Xe', 47.15, NULL, 0.07, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.07, 'sd');
INSERT INTO public.reservoir VALUES (11, 'Atmosphere', NULL, '129Xe', 649.6, NULL, 0.9, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.9, 'sd');
INSERT INTO public.reservoir VALUES (14, 'Atmosphere', NULL, '131Xe', 521.3, NULL, 0.8, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.8, 'sd');
INSERT INTO public.reservoir VALUES (15, 'Atmosphere', NULL, '132Xe', 660.7, NULL, 0.5, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.5, 'sd');
INSERT INTO public.reservoir VALUES (16, 'Atmosphere', NULL, '134Xe', 256.3, NULL, 0.4, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.4, 'sd');
INSERT INTO public.reservoir VALUES (17, 'Atmosphere', NULL, '136Xe', 217.6, NULL, 0.3, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.3, 'sd');
INSERT INTO public.reservoir VALUES (23, 'Atmosphere', NULL, '20Ne', 9.8, NULL, 0.08, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.08, 'sd');
INSERT INTO public.reservoir VALUES (25, 'Atmosphere', NULL, '21Ne', 0.029, NULL, 0.0003, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.0003, 'sd');
INSERT INTO public.reservoir VALUES (39, 'Atmosphere', NULL, '38Ar', 0.188, NULL, 0.0004, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.0004, 'sd');
INSERT INTO public.reservoir VALUES (43, 'Atmosphere', NULL, '3He', 1.399e-06, NULL, 1.3e-08, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 1.3e-08, 'sd');
INSERT INTO public.reservoir VALUES (46, 'Atmosphere', NULL, '40Ar', 295.5, NULL, 0.5, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.5, 'sd');
INSERT INTO public.reservoir VALUES (49, 'Atmosphere', NULL, '78Kr', 0.6087, NULL, 0.002, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.002, 'sd');
INSERT INTO public.reservoir VALUES (51, 'Atmosphere', NULL, '80Kr', 3.9599, NULL, 0.002, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.002, 'sd');
INSERT INTO public.reservoir VALUES (52, 'Atmosphere', NULL, '82Kr', 20.217, NULL, 0.004, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.004, 'sd');
INSERT INTO public.reservoir VALUES (53, 'Atmosphere', NULL, '83Kr', 20.136, NULL, 0.021, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.021, 'sd');
INSERT INTO public.reservoir VALUES (55, 'Atmosphere', NULL, '86Kr', 30.524, NULL, 0.025, NULL, NULL, NULL, '', '', 'Porcelli & Turekian 2014', 'Ozima & Podosek 2001', NULL, 0.025, 'sd');
INSERT INTO public.reservoir VALUES (183, 'Seawater', NULL, '187Os/186Os', 6.3, NULL, 3.1, NULL, NULL, NULL, '', '', 'Koide et al. 1996', '', NULL, 3.1, 'sd');
INSERT INTO public.reservoir VALUES (185, 'Seawater', NULL, '238U/235U', 137.89, NULL, 0.075, NULL, NULL, 21, '', '', 'Chen et al. 1986', '', NULL, 0.075, 'sd');
INSERT INTO public.reservoir VALUES (187, 'Seawater', 38, '87Sr/86Sr', 0.70907, NULL, 4e-05, NULL, NULL, 42, '', '', 'Burke et al. 1992', '', NULL, 4e-05, 'sd');
INSERT INTO public.reservoir VALUES (299, 'Seawater', 5, 'd11B', 39.52, NULL, 0.36, NULL, NULL, NULL, '', '', 'Smith et al. 1995', 'Spivack 1986', NULL, 0.36, 'sd');
INSERT INTO public.reservoir VALUES (301, 'Seawater', NULL, 'd234U', 144, NULL, 1, NULL, NULL, 9, '', '', 'Chen et al. 1986', '', NULL, 1, 'sd');
INSERT INTO public.reservoir VALUES (455, 'Seawater', 76, 'Os', 0.0017, NULL, 0.00085, NULL, NULL, NULL, 'ng/kg', '', 'Koide et al. 1996', '', NULL, 0.00085, 'sd');
INSERT INTO public.reservoir VALUES (485, 'Seawater', 75, 'Re', 8.19, NULL, 0.185, NULL, NULL, NULL, 'ng/kg', '', 'Anbar et al. 1992', 'Colodner 1991', NULL, 0.185, 'sd');
INSERT INTO public.reservoir VALUES (527, 'Seawater', 50, 'Sn', 4, NULL, 1, 12, NULL, NULL, '', '', 'Bruland 1983', '', NULL, 1, 'sd');
INSERT INTO public.reservoir VALUES (708, 'Core', 26, 'Fe', 79.39, NULL, 2, NULL, NULL, NULL, 'wt%', '', 'Allegre et al. 1995', '', NULL, 2, 'sd');
INSERT INTO public.reservoir VALUES (759, 'Core', 28, 'Ni', 4.87, NULL, 0.3, NULL, NULL, NULL, 'wt%', '', 'Allegre et al. 1995', '', NULL, 0.3, 'sd');
INSERT INTO public.reservoir VALUES (766, 'Core', 8, 'O', 4.1, NULL, 0.5, NULL, NULL, NULL, 'wt%', '', 'Allegre et al. 1995', '', NULL, 0.5, 'sd');
INSERT INTO public.reservoir VALUES (799, 'Core', 16, 'S', 2.3, NULL, 0.2, NULL, NULL, NULL, 'wt%', '', 'Allegre et al. 1995', '', NULL, 0.2, 'sd');
INSERT INTO public.reservoir VALUES (860, 'Silicate Earth', 13, 'Al', 2.35, NULL, 0.235, NULL, NULL, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, 0.235, 'sd');
INSERT INTO public.reservoir VALUES (876, 'Silicate Earth', 56, 'Ba', 6600, NULL, 660, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 660, 'sd');
INSERT INTO public.reservoir VALUES (881, 'Silicate Earth', 4, 'Be', 0.068, NULL, 0.0136, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 0.0136, 'sd');
INSERT INTO public.reservoir VALUES (884, 'Silicate Earth', 83, 'Bi', 2.5, NULL, 0.75, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 0.75, 'sd');
INSERT INTO public.reservoir VALUES (895, 'Silicate Earth', 20, 'Ca', 2.53, NULL, 0.253, NULL, NULL, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, 0.253, 'sd');
INSERT INTO public.reservoir VALUES (907, 'Silicate Earth', 48, 'Cd', 40, NULL, 12, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 12, 'sd');
INSERT INTO public.reservoir VALUES (908, 'Silicate Earth', 58, 'Ce', 1675, NULL, 167.5, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 167.5, 'sd');
INSERT INTO public.reservoir VALUES (918, 'Silicate Earth', 27, 'Co', 105, NULL, 10.5, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 10.5, 'sd');
INSERT INTO public.reservoir VALUES (925, 'Silicate Earth', 24, 'Cr', 2625, NULL, 393.75, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 393.75, 'sd');
INSERT INTO public.reservoir VALUES (936, 'Silicate Earth', 55, 'Cs', 21, NULL, 8.4, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 8.4, 'sd');
INSERT INTO public.reservoir VALUES (939, 'Silicate Earth', 29, 'Cu', 30, NULL, 4.5, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 4.5, 'sd');
INSERT INTO public.reservoir VALUES (943, 'Silicate Earth', 66, 'Dy', 674, NULL, 67.4, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 67.4, 'sd');
INSERT INTO public.reservoir VALUES (969, 'Silicate Earth', 68, 'Er', 438, NULL, 43.8, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 43.8, 'sd');
INSERT INTO public.reservoir VALUES (976, 'Silicate Earth', 63, 'Eu', 154, NULL, 15.4, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 15.4, 'sd');
INSERT INTO public.reservoir VALUES (991, 'Silicate Earth', 26, 'Fe', 6.26, NULL, 0.626, NULL, NULL, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, 0.626, 'sd');
INSERT INTO public.reservoir VALUES (998, 'Silicate Earth', 31, 'Ga', 4, NULL, 0.4, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 0.4, 'sd');
INSERT INTO public.reservoir VALUES (1002, 'Silicate Earth', 64, 'Gd', 544, NULL, 54.4, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 54.4, 'sd');
INSERT INTO public.reservoir VALUES (1006, 'Silicate Earth', 32, 'Ge', 1.1, NULL, 0.165, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 0.165, 'sd');
INSERT INTO public.reservoir VALUES (1011, 'Silicate Earth', 72, 'Hf', 283, NULL, 28.3, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 28.3, 'sd');
INSERT INTO public.reservoir VALUES (1027, 'Silicate Earth', 67, 'Ho', 149, NULL, 14.9, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 14.9, 'sd');
INSERT INTO public.reservoir VALUES (1033, 'Silicate Earth', 49, 'In', 11, NULL, 4.4, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 4.4, 'sd');
INSERT INTO public.reservoir VALUES (1036, 'Silicate Earth', 77, 'Ir', 3.2, NULL, 0.96, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 0.96, 'sd');
INSERT INTO public.reservoir VALUES (1047, 'Silicate Earth', 19, 'K', 240, NULL, 48, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 48, 'sd');
INSERT INTO public.reservoir VALUES (1050, 'Silicate Earth', 57, 'La', 648, NULL, 64.8, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 64.8, 'sd');
INSERT INTO public.reservoir VALUES (1055, 'Silicate Earth', 3, 'Li', 1.6, NULL, 0.48, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 0.48, 'sd');
INSERT INTO public.reservoir VALUES (1064, 'Silicate Earth', 71, 'Lu', 67.5, NULL, 6.75, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 6.75, 'sd');
INSERT INTO public.reservoir VALUES (1069, 'Silicate Earth', 12, 'Mg', 22.8, NULL, 2.28, NULL, NULL, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, 2.28, 'sd');
INSERT INTO public.reservoir VALUES (1079, 'Silicate Earth', 25, 'Mn', 1045, NULL, 104.5, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 104.5, 'sd');
INSERT INTO public.reservoir VALUES (1083, 'Silicate Earth', 42, 'Mo', 50, NULL, 20, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 20, 'sd');
INSERT INTO public.reservoir VALUES (1094, 'Silicate Earth', 11, 'Na', 2670, NULL, 400.5, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 400.5, 'sd');
INSERT INTO public.reservoir VALUES (1096, 'Silicate Earth', 41, 'Nb', 658, NULL, 98.7, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 98.7, 'sd');
INSERT INTO public.reservoir VALUES (1106, 'Silicate Earth', 60, 'Nd', 1250, NULL, 125, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 125, 'sd');
INSERT INTO public.reservoir VALUES (1108, 'Silicate Earth', 28, 'Ni', 1960, NULL, 196, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 196, 'sd');
INSERT INTO public.reservoir VALUES (1120, 'Silicate Earth', 76, 'Os', 3.4, NULL, 1.02, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 1.02, 'sd');
INSERT INTO public.reservoir VALUES (1125, 'Silicate Earth', 15, 'P', 90, NULL, 13.5, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 13.5, 'sd');
INSERT INTO public.reservoir VALUES (1128, 'Silicate Earth', 82, 'Pb', 150, NULL, 30, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 30, 'sd');
INSERT INTO public.reservoir VALUES (1129, 'Silicate Earth', 46, 'Pd', 3.9, NULL, 3.12, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 3.12, 'sd');
INSERT INTO public.reservoir VALUES (1134, 'Silicate Earth', 59, 'Pr', 254, NULL, 25.4, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 25.4, 'sd');
INSERT INTO public.reservoir VALUES (1138, 'Silicate Earth', 78, 'Pt', 7.1, NULL, 2.13, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 2.13, 'sd');
INSERT INTO public.reservoir VALUES (1147, 'Silicate Earth', 37, 'Rb', 0.6, NULL, 0.18, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 0.18, 'sd');
INSERT INTO public.reservoir VALUES (1153, 'Silicate Earth', 75, 'Re', 0.28, NULL, 0.084, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 0.084, 'sd');
INSERT INTO public.reservoir VALUES (1158, 'Silicate Earth', 45, 'Rh', 0.9, NULL, 0.36, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 0.36, 'sd');
INSERT INTO public.reservoir VALUES (1161, 'Silicate Earth', 44, 'Ru', 5, NULL, 1.5, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 1.5, 'sd');
INSERT INTO public.reservoir VALUES (1164, 'Silicate Earth', 16, 'S', 250, NULL, 50, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 50, 'sd');
INSERT INTO public.reservoir VALUES (1166, 'Silicate Earth', 51, 'Sb', 5.5, NULL, 2.75, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 2.75, 'sd');
INSERT INTO public.reservoir VALUES (1169, 'Silicate Earth', 21, 'Sc', 16.2, NULL, 1.62, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 1.62, 'sd');
INSERT INTO public.reservoir VALUES (1176, 'Silicate Earth', 34, 'Se', 0.075, NULL, 0.0525, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 0.0525, 'sd');
INSERT INTO public.reservoir VALUES (1181, 'Silicate Earth', 14, 'Si', 21, NULL, 2.1, NULL, NULL, NULL, 'wt%', '', 'McDonough & Sun 1995', '', NULL, 2.1, 'sd');
INSERT INTO public.reservoir VALUES (1185, 'Silicate Earth', 62, 'Sm', 406, NULL, 40.6, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 40.6, 'sd');
INSERT INTO public.reservoir VALUES (1195, 'Silicate Earth', 50, 'Sn', 130, NULL, 39, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 39, 'sd');
INSERT INTO public.reservoir VALUES (1199, 'Silicate Earth', 38, 'Sr', 19.9, NULL, 1.99, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 1.99, 'sd');
INSERT INTO public.reservoir VALUES (1207, 'Silicate Earth', 73, 'Ta', 37, NULL, 5.6, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 5.6, 'sd');
INSERT INTO public.reservoir VALUES (1214, 'Silicate Earth', 65, 'Tb', 99, NULL, 9.9, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 9.9, 'sd');
INSERT INTO public.reservoir VALUES (1220, 'Silicate Earth', 90, 'Th', 79.5, NULL, 11.9, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 11.9, 'sd');
INSERT INTO public.reservoir VALUES (1233, 'Silicate Earth', 22, 'Ti', 1205, NULL, 120.5, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 120.5, 'sd');
INSERT INTO public.reservoir VALUES (1240, 'Silicate Earth', 81, 'Tl', 3.5, NULL, 1.4, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 1.4, 'sd');
INSERT INTO public.reservoir VALUES (1243, 'Silicate Earth', 69, 'Tm', 68, NULL, 6.8, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 6.8, 'sd');
INSERT INTO public.reservoir VALUES (1253, 'Silicate Earth', 92, 'U', 20.3, NULL, 4.1, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 4.1, 'sd');
INSERT INTO public.reservoir VALUES (1257, 'Silicate Earth', 23, 'V', 82, NULL, 12.3, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 12.3, 'sd');
INSERT INTO public.reservoir VALUES (1266, 'Silicate Earth', 39, 'Y', 4.3, NULL, 0.43, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 0.43, 'sd');
INSERT INTO public.reservoir VALUES (1270, 'Silicate Earth', 70, 'Yb', 441, NULL, 44.1, NULL, NULL, NULL, 'ppb', '', 'McDonough & Sun 1995', '', NULL, 44.1, 'sd');
INSERT INTO public.reservoir VALUES (1276, 'Silicate Earth', 30, 'Zn', 55, NULL, 8.25, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 8.25, 'sd');
INSERT INTO public.reservoir VALUES (1280, 'Silicate Earth', 40, 'Zr', 10.5, NULL, 1.05, NULL, NULL, NULL, 'ppm', '', 'McDonough & Sun 1995', '', NULL, 1.05, 'sd');


--
-- TOC entry 4970 (class 0 OID 16432)
-- Dependencies: 230
-- Data for Name: sample_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4971 (class 0 OID 16437)
-- Dependencies: 231
-- Data for Name: sample_index; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4973 (class 0 OID 16441)
-- Dependencies: 233
-- Data for Name: spider_normalization; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.spider_normalization VALUES ('CI chondrite 95', '{"U": "0.0074", "Y": "1.57", "Ba": "2.41", "Ce": "0.613", "Cs": "0.19", "Dy": "0.246", "Er": "0.16", "Eu": "0.0563", "Gd": "0.199", "Hf": "0.103", "Ho": "0.0546", "La": "0.237", "Lu": "0.0246", "Nb": "0.24", "Nd": "0.457", "Pb": "2.47", "Pr": "0.0928", "Rb": "2.3", "Sm": "0.148", "Sr": "7.25", "Ta": "0.0136", "Tb": "0.0361", "Th": "0.029", "Yb": "0.161", "Zr": "3.82"}', '["Cs", "Rb", "Ba", "Th", "U", "Nb", "Ta", "La", "Ce", "Pb", "Pr", "Sr", "Nd", "Zr", "Hf", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Yb", "Y", "Lu"]');
INSERT INTO public.spider_normalization VALUES ('Pyrolite', '{"U": "0.0203", "Y": "4.3", "Ba": "6.6", "Ce": "1.675", "Cs": "0.021", "Dy": "0.674", "Er": "0.438", "Eu": "0.154", "Gd": "0.544", "Hf": "0.283", "Ho": "0.149", "La": "0.648", "Lu": "0.0675", "Nb": "0.685", "Nd": "1.25", "Pb": "0.15", "Pr": "0.254", "Rb": "0.6", "Sm": "0.406", "Sr": "19.9", "Ta": "0.037", "Tb": "0.099", "Th": "0.0795", "Yb": "0.441", "Zr": "10.5"}', '["Cs", "Rb", "Ba", "Th", "U", "Nb", "Ta", "La", "Ce", "Pb", "Pr", "Sr", "Nd", "Zr", "Hf", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Yb", "Y", "Lu"]');
INSERT INTO public.spider_normalization VALUES ('CI chondrite 89', '{"U": "0.008", "Y": "1.57", "Ba": "2.41", "Ce": "0.612", "Cs": "0.188", "Dy": "0.254", "Er": "0.1655", "Eu": "0.058", "Gd": "0.2055", "Hf": "0.1066", "Ho": "0.0566", "La": "0.237", "Lu": "0.0254", "Nb": "0.246", "Nd": "0.467", "Pb": "2.47", "Pr": "0.095", "Rb": "2.32", "Sm": "0.153", "Sr": "7.26", "Ta": "0.014", "Tb": "0.0374", "Th": "0.029", "Yb": "0.17", "Zr": "3.87"}', '["Cs", "Rb", "Ba", "Th", "U", "Nb", "Ta", "La", "Ce", "Pb", "Pr", "Sr", "Nd", "Zr", "Hf", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Yb", "Y", "Lu"]');
INSERT INTO public.spider_normalization VALUES ('P mantle', '{"U": "0.021", "Y": "4.55", "Ba": "6.989", "Ce": "1.775", "Cs": "0.0079", "Dy": "0.737", "Er": "0.48", "Eu": "0.168", "Gd": "0.596", "Hf": "0.309", "Ho": "0.164", "La": "0.687", "Lu": "0.074", "Nb": "0.713", "Nd": "1.354", "Pb": "0.071", "Pr": "0.276", "Rb": "0.635", "Sm": "0.444", "Sr": "21.1", "Ta": "0.041", "Tb": "0.108", "Th": "0.085", "Yb": "0.493", "Zr": "11.2"}', '["Cs", "Rb", "Ba", "Th", "U", "Nb", "Ta", "La", "Ce", "Pb", "Pr", "Sr", "Nd", "Zr", "Hf", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Yb", "Y", "Lu"]');
INSERT INTO public.spider_normalization VALUES ('NMORB', '{"U": "0.047", "Y": "28", "Ba": "6.3", "Ce": "7.5", "Cs": "0.007", "Dy": "4.55", "Er": "2.97", "Eu": "1.02", "Gd": "3.68", "Hf": "2.05", "Ho": "1.01", "La": "2.5", "Lu": "0.455", "Nb": "2.33", "Nd": "7.3", "Pb": "0.3", "Pr": "1.32", "Rb": "0.56", "Sm": "2.63", "Sr": "90", "Ta": "0.132", "Tb": "0.67", "Th": "0.12", "Yb": "3.05", "Zr": "74"}', '["Cs", "Rb", "Ba", "Th", "U", "Nb", "Ta", "La", "Ce", "Pb", "Pr", "Sr", "Nd", "Zr", "Hf", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Yb", "Y", "Lu"]');
INSERT INTO public.spider_normalization VALUES ('EMORB', '{"U": "0.18", "Y": "22", "Ba": "57", "Ce": "15", "Cs": "0.063", "Dy": "3.55", "Er": "2.31", "Eu": "0.91", "Gd": "2.97", "Hf": "2.03", "Ho": "0.79", "La": "6.3", "Lu": "0.354", "Nb": "8.3", "Nd": "9", "Pb": "0.6", "Pr": "2.05", "Rb": "5.04", "Sm": "2.6", "Sr": "155", "Ta": "0.47", "Tb": "0.53", "Th": "0.6", "Yb": "2.37", "Zr": "73"}', '["Cs", "Rb", "Ba", "Th", "U", "Nb", "Ta", "La", "Ce", "Pb", "Pr", "Sr", "Nd", "Zr", "Hf", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Yb", "Y", "Lu"]');


--
-- TOC entry 4974 (class 0 OID 16446)
-- Dependencies: 234
-- Data for Name: synonyms; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.synonyms VALUES ('124Xe', 'XE124');
INSERT INTO public.synonyms VALUES ('126Xe', 'XE126');
INSERT INTO public.synonyms VALUES ('128Xe', 'XE128');
INSERT INTO public.synonyms VALUES ('129Xe', 'XE129');
INSERT INTO public.synonyms VALUES ('12C', 'C12');
INSERT INTO public.synonyms VALUES ('130Xe', 'XE130');
INSERT INTO public.synonyms VALUES ('131Xe', 'XE131');
INSERT INTO public.synonyms VALUES ('132Xe', 'XE132');
INSERT INTO public.synonyms VALUES ('134Xe', 'XE134');
INSERT INTO public.synonyms VALUES ('136Xe', 'XE136');
INSERT INTO public.synonyms VALUES ('13C', 'C13');
INSERT INTO public.synonyms VALUES ('142Nd/144Nd', 'ND142_ND144');
INSERT INTO public.synonyms VALUES ('143Nd/144Nd', 'ND143_ND144');
INSERT INTO public.synonyms VALUES ('143Nd/144Nd Initial', 'ND143_ND144_INI');
INSERT INTO public.synonyms VALUES ('145Nd/144Nd', 'ND145_ND144');
INSERT INTO public.synonyms VALUES ('148Nd/144Nd', 'ND148_ND144');
INSERT INTO public.synonyms VALUES ('14C', 'C14');
INSERT INTO public.synonyms VALUES ('14N', 'N14');
INSERT INTO public.synonyms VALUES ('150Nd/144Nd', 'ND150_ND144');
INSERT INTO public.synonyms VALUES ('15N', 'N15');
INSERT INTO public.synonyms VALUES ('174Hf/177Hf', 'HF174_HF177');
INSERT INTO public.synonyms VALUES ('176Hf/177Hf', 'HF176_HF177');
INSERT INTO public.synonyms VALUES ('176Hf/177Hf Initial', 'HF176_HF177_INI');
INSERT INTO public.synonyms VALUES ('176Yb/177Hf', 'YB176_HF177');
INSERT INTO public.synonyms VALUES ('178Hf/177Hf', 'HF178_HF177');
INSERT INTO public.synonyms VALUES ('179Hf/177Hf', 'HF179_HF177');
INSERT INTO public.synonyms VALUES ('17O/16O', '17O_16O');
INSERT INTO public.synonyms VALUES ('180Hf/177Hf', '180HF_177HF');
INSERT INTO public.synonyms VALUES ('187Os/186Os', 'OS187_OS186');
INSERT INTO public.synonyms VALUES ('1H', 'H1');
INSERT INTO public.synonyms VALUES ('204Pb/206Pb', 'PB204_PB206');
INSERT INTO public.synonyms VALUES ('204Pb/207Pb', 'PB204_PB207');
INSERT INTO public.synonyms VALUES ('205Tl/203Tl', 'TI205_TI203');
INSERT INTO public.synonyms VALUES ('206Pb', 'PB206');
INSERT INTO public.synonyms VALUES ('206Pb/204Pb', 'PB206_PB204');
INSERT INTO public.synonyms VALUES ('206Pb/204Pb Initial', 'PB206_PB204_INI');
INSERT INTO public.synonyms VALUES ('206Pb/207Pb', 'PB206_PB207');
INSERT INTO public.synonyms VALUES ('206Pb/238U', 'PB206_U238');
INSERT INTO public.synonyms VALUES ('207Pb', 'PB207');
INSERT INTO public.synonyms VALUES ('207Pb/204Pb', 'PB207_PB204');
INSERT INTO public.synonyms VALUES ('207Pb/204Pb Initial', 'PB207_PB204_INI');
INSERT INTO public.synonyms VALUES ('207Pb/206Pb', 'PB207_PB206');
INSERT INTO public.synonyms VALUES ('208Pb', 'PB208');
INSERT INTO public.synonyms VALUES ('208Pb/204Pb', 'PB208_PB204');
INSERT INTO public.synonyms VALUES ('208Pb/204Pb Initial', 'PB208_PB204_INI');
INSERT INTO public.synonyms VALUES ('208Pb/206Pb', 'PB208_PB206');
INSERT INTO public.synonyms VALUES ('208Pb/207Pb', 'PB208_PB207');
INSERT INTO public.synonyms VALUES ('20Ne', 'NE20');
INSERT INTO public.synonyms VALUES ('20Ne/22Ne', 'NE20_NE22');
INSERT INTO public.synonyms VALUES ('210Pb/226Ra Act', 'PB210_RA226_ACT');
INSERT INTO public.synonyms VALUES ('21Ne', 'NE21');
INSERT INTO public.synonyms VALUES ('21Ne/20Ne', 'Ne21/NE20');
INSERT INTO public.synonyms VALUES ('21Ne/22Ne', 'NE21/NE22');
INSERT INTO public.synonyms VALUES ('226Ra Act', 'RA226_ACT');
INSERT INTO public.synonyms VALUES ('226Ra/230Th', 'RA226_TH230');
INSERT INTO public.synonyms VALUES ('226Ra/230Th Act', 'RA226_TH230_ACT');
INSERT INTO public.synonyms VALUES ('226Ra/238U', 'RA226_U238');
INSERT INTO public.synonyms VALUES ('228Ra/232Th', 'RA228_TH232');
INSERT INTO public.synonyms VALUES ('228Ra/232Th Act', 'RA228_TH232_ACT');
INSERT INTO public.synonyms VALUES ('228Th/228Ra Act', 'TH228_RA228_ACT');
INSERT INTO public.synonyms VALUES ('228Th/232Th', 'TH228_TH232');
INSERT INTO public.synonyms VALUES ('22Na', 'NA22');
INSERT INTO public.synonyms VALUES ('22Ne', 'NE22');
INSERT INTO public.synonyms VALUES ('22Ne/20Ne', 'NE22_NE20');
INSERT INTO public.synonyms VALUES ('230Th/232Th Act', 'TH230_TH232_ACT');
INSERT INTO public.synonyms VALUES ('230Th/238U Act', 'TH230_U238_ACT');
INSERT INTO public.synonyms VALUES ('232Th', 'TH232');
INSERT INTO public.synonyms VALUES ('232Th Act', 'TH232_ACT');
INSERT INTO public.synonyms VALUES ('232Th/207Pb', 'TH232_PB207');
INSERT INTO public.synonyms VALUES ('232Th/238U', 'TH232_U238');
INSERT INTO public.synonyms VALUES ('234U/238U', 'U234_U238');
INSERT INTO public.synonyms VALUES ('234U/238U Act', 'U234_U238_ACT');
INSERT INTO public.synonyms VALUES ('238U', 'U238');
INSERT INTO public.synonyms VALUES ('238U Act', 'U238_ACT');
INSERT INTO public.synonyms VALUES ('238U/204Pb', 'U238_PB204');
INSERT INTO public.synonyms VALUES ('238U/207Pb', 'U238_PB207');
INSERT INTO public.synonyms VALUES ('238U/232Th Act', 'U238_TH232_ACT');
INSERT INTO public.synonyms VALUES ('238U/235U', 'U238_U235');
INSERT INTO public.synonyms VALUES ('25Mg/24Mg', 'MG25_MG24');
INSERT INTO public.synonyms VALUES ('26Al', 'AL16');
INSERT INTO public.synonyms VALUES ('26Mg/24Mg', 'MG26_MG24');
INSERT INTO public.synonyms VALUES ('29Si/28Si', 'SI29_SI28');
INSERT INTO public.synonyms VALUES ('2H', 'H2');
INSERT INTO public.synonyms VALUES ('30Si/28Si', 'SI30_SI28');
INSERT INTO public.synonyms VALUES ('31Kr', 'KR31');
INSERT INTO public.synonyms VALUES ('32P', 'P32');
INSERT INTO public.synonyms VALUES ('32Si', 'SI32');
INSERT INTO public.synonyms VALUES ('33P', 'P33');
INSERT INTO public.synonyms VALUES ('33S/32S', 'S33_S32');
INSERT INTO public.synonyms VALUES ('34S/32S', 'S34_S32');
INSERT INTO public.synonyms VALUES ('35Cl/37Cl', 'CL35_CL37');
INSERT INTO public.synonyms VALUES ('36Ar', 'AR36');
INSERT INTO public.synonyms VALUES ('36Ar/39Ar', 'AR36_AR39');
INSERT INTO public.synonyms VALUES ('36Cl', 'CL36');
INSERT INTO public.synonyms VALUES ('36S', 'S36');
INSERT INTO public.synonyms VALUES ('36S/32S', 'S36_S32');
INSERT INTO public.synonyms VALUES ('37Ar', 'AR37');
INSERT INTO public.synonyms VALUES ('37Ar/39Ar', 'AR37_AR39');
INSERT INTO public.synonyms VALUES ('37Ar/40Ar', 'AR37_AR40');
INSERT INTO public.synonyms VALUES ('37Cl/36Cl', 'CL37_CL36');
INSERT INTO public.synonyms VALUES ('38Ar', 'AR38');
INSERT INTO public.synonyms VALUES ('38Ar/36Ar', 'AR38_AR36');
INSERT INTO public.synonyms VALUES ('39Ar', 'AR39');
INSERT INTO public.synonyms VALUES ('39K/41K', 'K38_K41');
INSERT INTO public.synonyms VALUES ('3H', 'H3');
INSERT INTO public.synonyms VALUES ('3He', 'HE3');
INSERT INTO public.synonyms VALUES ('3He/4He', 'HE3_HE4');
INSERT INTO public.synonyms VALUES ('40Ar', 'AR40');
INSERT INTO public.synonyms VALUES ('40Ar/36Ar', 'AR40_AR36');
INSERT INTO public.synonyms VALUES ('40Ar/39Ar', 'AR40_AR39');
INSERT INTO public.synonyms VALUES ('40Ca/44Ca', 'CA40_CA44');
INSERT INTO public.synonyms VALUES ('40K/41K', 'K40_K41');
INSERT INTO public.synonyms VALUES ('42Ca/44Ca', 'CA42_CA44');
INSERT INTO public.synonyms VALUES ('43Ca/42Ca', 'CA43_CA42');
INSERT INTO public.synonyms VALUES ('44Ca/40Ca', 'CA44_CA40');
INSERT INTO public.synonyms VALUES ('48Ca/44Ca', 'CA48_CA44');
INSERT INTO public.synonyms VALUES ('4He', 'HE4');
INSERT INTO public.synonyms VALUES ('50Cr/52Cr', 'CR50_CR52');
INSERT INTO public.synonyms VALUES ('53Cr/52Cr', 'CR53_CR52');
INSERT INTO public.synonyms VALUES ('54Cr/52Cr', 'CR54_CR52');
INSERT INTO public.synonyms VALUES ('56Fe/54Fe', 'FE56_FE54');
INSERT INTO public.synonyms VALUES ('57Fe/54Fe', 'FE57_FE54');
INSERT INTO public.synonyms VALUES ('58Fe/54Fe', 'FE58_FE54');
INSERT INTO public.synonyms VALUES ('58Ni/60Ni', 'NI58_NI60');
INSERT INTO public.synonyms VALUES ('61Ni/60Ni', 'NI61_NI60');
INSERT INTO public.synonyms VALUES ('62Ni/60Ni', 'NI62_NI60');
INSERT INTO public.synonyms VALUES ('63Cu/65Cu', 'CU63_CU65');
INSERT INTO public.synonyms VALUES ('64Ni/60Ni', 'NI64_NI60');
INSERT INTO public.synonyms VALUES ('65Cu/63Cu', 'CU65_CU63');
INSERT INTO public.synonyms VALUES ('66Zn/64Zn', 'ZN66_ZN64');
INSERT INTO public.synonyms VALUES ('67Zn/64Zn', 'ZN67_ZN64');
INSERT INTO public.synonyms VALUES ('68Zn/64Zn', 'ZN68_ZN64');
INSERT INTO public.synonyms VALUES ('70Zn/64Zn', 'ZN70_ZN64');
INSERT INTO public.synonyms VALUES ('78Kr', 'KR78');
INSERT INTO public.synonyms VALUES ('78Kr/84Kr', 'KR78_KR84');
INSERT INTO public.synonyms VALUES ('7Be', 'BE7');
INSERT INTO public.synonyms VALUES ('80Kr', 'KR80');
INSERT INTO public.synonyms VALUES ('80Kr/84Kr', 'KR80_KR84');
INSERT INTO public.synonyms VALUES ('82Kr', 'KR82');
INSERT INTO public.synonyms VALUES ('82Kr/84Kr', 'KR82_KR84');
INSERT INTO public.synonyms VALUES ('83Kr', 'KR83');
INSERT INTO public.synonyms VALUES ('83Kr/84Kr', 'KR83_KR84');
INSERT INTO public.synonyms VALUES ('84Kr', 'KR84');
INSERT INTO public.synonyms VALUES ('84Sr/86Sr', 'SR84_SR86');
INSERT INTO public.synonyms VALUES ('85Rb/87Rb', 'RB85_RB87');
INSERT INTO public.synonyms VALUES ('86Kr', 'KR86');
INSERT INTO public.synonyms VALUES ('86Kr/84Kr', 'KR86_KR84');
INSERT INTO public.synonyms VALUES ('86Sr/88Sr', 'SR86_SR88');
INSERT INTO public.synonyms VALUES ('87Rb/85Rb', 'RB87_RB85');
INSERT INTO public.synonyms VALUES ('87Rb/86Sr', 'RB87_SR86');
INSERT INTO public.synonyms VALUES ('87Sr/86Sr', 'SR87_SR86');
INSERT INTO public.synonyms VALUES ('87Sr/86Sr Initial', 'SR87_SR86_INI');
INSERT INTO public.synonyms VALUES ('87Sr/88Sr', 'SR87_SR88');
INSERT INTO public.synonyms VALUES ('88Sr/86Sr', 'SR88_SR86');
INSERT INTO public.synonyms VALUES ('97Mo/95Mo', 'MO97_MO95');
INSERT INTO public.synonyms VALUES ('98Mo/95Mo', 'MO98_MO95');
INSERT INTO public.synonyms VALUES ('Ag', 'AG');
INSERT INTO public.synonyms VALUES ('Ag+', 'AG+');
INSERT INTO public.synonyms VALUES ('Al', 'AL');
INSERT INTO public.synonyms VALUES ('Al2O3', 'AL2O3');
INSERT INTO public.synonyms VALUES ('Al3+', 'ALAl3_AL3');
INSERT INTO public.synonyms VALUES ('Ar', 'AR');
INSERT INTO public.synonyms VALUES ('As', 'AS');
INSERT INTO public.synonyms VALUES ('As2O5', 'AS2O5');
INSERT INTO public.synonyms VALUES ('Au', 'AUAu_AU');
INSERT INTO public.synonyms VALUES ('Au+', 'AUAu_AUA');
INSERT INTO public.synonyms VALUES ('Au3+', 'AUAu3_AU3');
INSERT INTO public.synonyms VALUES ('B', 'B');
INSERT INTO public.synonyms VALUES ('Ba', 'BA');
INSERT INTO public.synonyms VALUES ('Ba2+', 'BABa2_BA2');
INSERT INTO public.synonyms VALUES ('BaO', 'BAO');
INSERT INTO public.synonyms VALUES ('Be', 'BE');
INSERT INTO public.synonyms VALUES ('Bi', 'BI');
INSERT INTO public.synonyms VALUES ('BO33-', 'BOBO33_BO33');
INSERT INTO public.synonyms VALUES ('Br', 'BR');
INSERT INTO public.synonyms VALUES ('Br-', 'BRBr_BRB');
INSERT INTO public.synonyms VALUES ('BrO3-', 'BROBrO3_BRO3');
INSERT INTO public.synonyms VALUES ('C', 'C');
INSERT INTO public.synonyms VALUES ('C2O42-', 'CC2_C42');
INSERT INTO public.synonyms VALUES ('Ca', 'CA');
INSERT INTO public.synonyms VALUES ('Ca2+', 'CACa2_CA2');
INSERT INTO public.synonyms VALUES ('CaCO3', 'CACOCaCO3_CACO3');
INSERT INTO public.synonyms VALUES ('CaO', 'CAO');
INSERT INTO public.synonyms VALUES ('Cd', 'CD');
INSERT INTO public.synonyms VALUES ('Cd2+', 'CDCd2_CD2');
INSERT INTO public.synonyms VALUES ('Ce', 'CE');
INSERT INTO public.synonyms VALUES ('Ce2O3', 'CE2O3');
INSERT INTO public.synonyms VALUES ('CH3COO-', 'CHCH3_CH3');
INSERT INTO public.synonyms VALUES ('CH4', 'CH4');
INSERT INTO public.synonyms VALUES ('Cl', 'CL');
INSERT INTO public.synonyms VALUES ('Cl-', 'CLCl_CLC');
INSERT INTO public.synonyms VALUES ('ClO-', 'CLOCl_CLOCl');
INSERT INTO public.synonyms VALUES ('ClO2-', 'CLOClO2_CLO2');
INSERT INTO public.synonyms VALUES ('ClO3-', 'CLOClO3_CLO3');
INSERT INTO public.synonyms VALUES ('ClO4-', 'CLOClO4_CLO4');
INSERT INTO public.synonyms VALUES ('CN', 'CN');
INSERT INTO public.synonyms VALUES ('CN-', 'CNCN_CNC');
INSERT INTO public.synonyms VALUES ('Co', 'CO');
INSERT INTO public.synonyms VALUES ('CO2', 'CO2');
INSERT INTO public.synonyms VALUES ('Co2+', 'COCo2_CO2');
INSERT INTO public.synonyms VALUES ('Co3+', 'COCo3_CO3');
INSERT INTO public.synonyms VALUES ('CO32-', 'COCO32_CO32');
INSERT INTO public.synonyms VALUES ('Cr', 'CR');
INSERT INTO public.synonyms VALUES ('Cr2+', 'CRCr2_CR2');
INSERT INTO public.synonyms VALUES ('Cr2O3', 'CR2O3');
INSERT INTO public.synonyms VALUES ('Cr2O72-', 'CRCr2_CR72');
INSERT INTO public.synonyms VALUES ('Cr3+', 'CRCr3_CR3');
INSERT INTO public.synonyms VALUES ('CrO42-', 'CROCrO42_CRO42');
INSERT INTO public.synonyms VALUES ('Cs', 'CS');
INSERT INTO public.synonyms VALUES ('Cu', 'CU');
INSERT INTO public.synonyms VALUES ('Cu+', 'CUCu_CUC');
INSERT INTO public.synonyms VALUES ('Cu2+', 'CUCu2_CU2');
INSERT INTO public.synonyms VALUES ('CuO', 'CUO');
INSERT INTO public.synonyms VALUES ('delta11B', 'D11B');
INSERT INTO public.synonyms VALUES ('delta11B', 'd11B');
INSERT INTO public.synonyms VALUES ('delta13C', 'DELTAdelta13_DELTA13');
INSERT INTO public.synonyms VALUES ('delta15N', 'DELTAdelta15_DELTA15');
INSERT INTO public.synonyms VALUES ('delta18O', 'D18O');
INSERT INTO public.synonyms VALUES ('delta234U', 'd234U');
INSERT INTO public.synonyms VALUES ('delta2H', 'DELTAdelta2_DELTA2');
INSERT INTO public.synonyms VALUES ('delta66Zn', 'D66ZN');
INSERT INTO public.synonyms VALUES ('delta68Zn', 'D68ZN');
INSERT INTO public.synonyms VALUES ('delta6Li', 'd6Li');
INSERT INTO public.synonyms VALUES ('delta6Li', 'd6LI');
INSERT INTO public.synonyms VALUES ('delta7Li', 'DELTAdelta7_DELTA7');
INSERT INTO public.synonyms VALUES ('deltaD', 'DD');
INSERT INTO public.synonyms VALUES ('deltaD', 'dD');
INSERT INTO public.synonyms VALUES ('Dy', 'DY');
INSERT INTO public.synonyms VALUES ('Dy2O3', 'DY2O3');
INSERT INTO public.synonyms VALUES ('Epsilon Hf', 'EPSILON_HF');
INSERT INTO public.synonyms VALUES ('Epsilon Hf Initial', 'EPSILON_HF_INI');
INSERT INTO public.synonyms VALUES ('Epsilon Nd', 'EPSILON_ND');
INSERT INTO public.synonyms VALUES ('Epsilon Nd Initial', 'EPSILON_ND_INI');
INSERT INTO public.synonyms VALUES ('Epsilon Sr', 'EPSILON_SR');
INSERT INTO public.synonyms VALUES ('Er', 'ER');
INSERT INTO public.synonyms VALUES ('Er2O3', 'ER2O3');
INSERT INTO public.synonyms VALUES ('Eu', 'EU');
INSERT INTO public.synonyms VALUES ('F', 'F');
INSERT INTO public.synonyms VALUES ('F-', 'FF-_F');
INSERT INTO public.synonyms VALUES ('Fe', 'FE');
INSERT INTO public.synonyms VALUES ('Fe Tot', 'FET');
INSERT INTO public.synonyms VALUES ('Fe2+', 'FEFe2_FE2');
INSERT INTO public.synonyms VALUES ('Fe2O3', 'FE2O3');
INSERT INTO public.synonyms VALUES ('Fe2O3 Tot', 'FE2O3T');
INSERT INTO public.synonyms VALUES ('Fe3+', 'FEFe3_FE3');
INSERT INTO public.synonyms VALUES ('FeO', 'FEO');
INSERT INTO public.synonyms VALUES ('FeO Tot', 'FEOT');
INSERT INTO public.synonyms VALUES ('FO', 'FO');
INSERT INTO public.synonyms VALUES ('FS', 'FS');
INSERT INTO public.synonyms VALUES ('Ga', 'GA');
INSERT INTO public.synonyms VALUES ('Gd', 'GD');
INSERT INTO public.synonyms VALUES ('Gd2O3', 'GD2O3');
INSERT INTO public.synonyms VALUES ('Ge', 'GE');
INSERT INTO public.synonyms VALUES ('Ge/Si', 'GE_SI');
INSERT INTO public.synonyms VALUES ('GeIk', 'GEIK');
INSERT INTO public.synonyms VALUES ('H', 'H');
INSERT INTO public.synonyms VALUES ('H-', 'HH-_H');
INSERT INTO public.synonyms VALUES ('H2O', 'H2O');
INSERT INTO public.synonyms VALUES ('HCO3-', 'HCOHCO3_HCO3');
INSERT INTO public.synonyms VALUES ('He', 'HE');
INSERT INTO public.synonyms VALUES ('Hf', 'HF');
INSERT INTO public.synonyms VALUES ('HfO2', 'HFO2');
INSERT INTO public.synonyms VALUES ('Hg', 'HGHg_HG');
INSERT INTO public.synonyms VALUES ('Hg2+', 'HGHg2_HG2');
INSERT INTO public.synonyms VALUES ('Hg22+', 'HGHg22_HG22');
INSERT INTO public.synonyms VALUES ('Ho', 'HO');
INSERT INTO public.synonyms VALUES ('HPO42-', 'HPOHPO42_HPO42');
INSERT INTO public.synonyms VALUES ('HSO4-', 'HSOHSO4_HSO4');
INSERT INTO public.synonyms VALUES ('I', 'I');
INSERT INTO public.synonyms VALUES ('I-', 'II-_I');
INSERT INTO public.synonyms VALUES ('In', 'IN');
INSERT INTO public.synonyms VALUES ('Ir', 'IR');
INSERT INTO public.synonyms VALUES ('K', 'K');
INSERT INTO public.synonyms VALUES ('K+', 'KK+_K');
INSERT INTO public.synonyms VALUES ('K2O', 'K2O');
INSERT INTO public.synonyms VALUES ('Kr', 'KR');
INSERT INTO public.synonyms VALUES ('La', 'LA');
INSERT INTO public.synonyms VALUES ('La2O3', 'LA2O3');
INSERT INTO public.synonyms VALUES ('Li', 'LI');
INSERT INTO public.synonyms VALUES ('Li+', 'LILi_LIL');
INSERT INTO public.synonyms VALUES ('LOI', 'LOI');
INSERT INTO public.synonyms VALUES ('Lu', 'LU');
INSERT INTO public.synonyms VALUES ('Mg', 'MG');
INSERT INTO public.synonyms VALUES ('Mg2+', 'MGMg2_MG2');
INSERT INTO public.synonyms VALUES ('MgO', 'MGO');
INSERT INTO public.synonyms VALUES ('Mn', 'MN');
INSERT INTO public.synonyms VALUES ('Mn2+', 'MNMn2_MN2');
INSERT INTO public.synonyms VALUES ('Mn3+', 'MNMn3_MN3');
INSERT INTO public.synonyms VALUES ('MnO', 'MNO');
INSERT INTO public.synonyms VALUES ('MnO4-', 'MNOMnO4_MNO4');
INSERT INTO public.synonyms VALUES ('MNO42-', 'MNOMNO42_MNO42');
INSERT INTO public.synonyms VALUES ('Mo', 'MO');
INSERT INTO public.synonyms VALUES ('Mt', 'MT');
INSERT INTO public.synonyms VALUES ('N', 'N');
INSERT INTO public.synonyms VALUES ('Na', 'NA');
INSERT INTO public.synonyms VALUES ('Na+', 'NANa_NAN');
INSERT INTO public.synonyms VALUES ('Na2O', 'NA2O');
INSERT INTO public.synonyms VALUES ('name', 'synonym');
INSERT INTO public.synonyms VALUES ('Nb', 'NB');
INSERT INTO public.synonyms VALUES ('Nb2O5', 'NB2O5');
INSERT INTO public.synonyms VALUES ('Nd', 'ND');
INSERT INTO public.synonyms VALUES ('Nd2O3', 'ND2O3');
INSERT INTO public.synonyms VALUES ('Ne', 'NE');
INSERT INTO public.synonyms VALUES ('NH4+', 'NHNH4_NH4');
INSERT INTO public.synonyms VALUES ('Ni', 'NI');
INSERT INTO public.synonyms VALUES ('NiO', 'NIO');
INSERT INTO public.synonyms VALUES ('NO2-', 'NONO2_NO2');
INSERT INTO public.synonyms VALUES ('NO3-', 'NONO3_NO3');
INSERT INTO public.synonyms VALUES ('O', 'O');
INSERT INTO public.synonyms VALUES ('OH-', 'OHOH_OHO');
INSERT INTO public.synonyms VALUES ('Os', 'OS');
INSERT INTO public.synonyms VALUES ('P', 'P');
INSERT INTO public.synonyms VALUES ('P2O5', 'P2O5');
INSERT INTO public.synonyms VALUES ('Pb', 'PB');
INSERT INTO public.synonyms VALUES ('Pb2+', 'PBPb2_PB2');
INSERT INTO public.synonyms VALUES ('Pb4+', 'PBPb4_PB4');
INSERT INTO public.synonyms VALUES ('Pd', 'PD');
INSERT INTO public.synonyms VALUES ('PO33-', 'POPO33_PO33');
INSERT INTO public.synonyms VALUES ('PO43-', 'POPO43_PO43');
INSERT INTO public.synonyms VALUES ('Pr', 'PR');
INSERT INTO public.synonyms VALUES ('Pt', 'PT');
INSERT INTO public.synonyms VALUES ('Pt2+', 'PTPt2_PT2');
INSERT INTO public.synonyms VALUES ('pyP', 'PYP');
INSERT INTO public.synonyms VALUES ('Ra', 'RA');
INSERT INTO public.synonyms VALUES ('Rb', 'RB');
INSERT INTO public.synonyms VALUES ('Re', 'RE');
INSERT INTO public.synonyms VALUES ('Ru', 'RU');
INSERT INTO public.synonyms VALUES ('S', 'S');
INSERT INTO public.synonyms VALUES ('S2-', 'SS2_S2');
INSERT INTO public.synonyms VALUES ('S2O32-', 'SS2_S32');
INSERT INTO public.synonyms VALUES ('Sb', 'SB');
INSERT INTO public.synonyms VALUES ('Sc', 'SC');
INSERT INTO public.synonyms VALUES ('SCN-', 'SCNSC_SCNSC');
INSERT INTO public.synonyms VALUES ('Se', 'SE');
INSERT INTO public.synonyms VALUES ('Si', 'SI');
INSERT INTO public.synonyms VALUES ('SiO2', 'SIO2');
INSERT INTO public.synonyms VALUES ('Sm', 'SM');
INSERT INTO public.synonyms VALUES ('Sm2O3', 'SM2O3');
INSERT INTO public.synonyms VALUES ('Sn', 'SN');
INSERT INTO public.synonyms VALUES ('Sn2+', 'SNSn2_SN2');
INSERT INTO public.synonyms VALUES ('Sn4+', 'SNSn4_SN4');
INSERT INTO public.synonyms VALUES ('SO2', 'SO2');
INSERT INTO public.synonyms VALUES ('SO3', 'SO3');
INSERT INTO public.synonyms VALUES ('SO32-', 'SOSO32_SO32');
INSERT INTO public.synonyms VALUES ('SO4', 'SO4');
INSERT INTO public.synonyms VALUES ('SO42-', 'SOSO42_SO42');
INSERT INTO public.synonyms VALUES ('Sr', 'SR');
INSERT INTO public.synonyms VALUES ('SrO', 'SRO');
INSERT INTO public.synonyms VALUES ('Ta', 'TA');
INSERT INTO public.synonyms VALUES ('Tb', 'TB');
INSERT INTO public.synonyms VALUES ('Te', 'TE');
INSERT INTO public.synonyms VALUES ('Th', 'TH');
INSERT INTO public.synonyms VALUES ('ThO2', 'THO2');
INSERT INTO public.synonyms VALUES ('Ti', 'TI');
INSERT INTO public.synonyms VALUES ('TiO2', 'TIO2');
INSERT INTO public.synonyms VALUES ('Tl', 'TL');
INSERT INTO public.synonyms VALUES ('Tm', 'TM');
INSERT INTO public.synonyms VALUES ('U', 'U');
INSERT INTO public.synonyms VALUES ('UO2', 'UO2');
INSERT INTO public.synonyms VALUES ('V', 'V');
INSERT INTO public.synonyms VALUES ('V2O3', 'V2O3');
INSERT INTO public.synonyms VALUES ('V2O5', 'V2O5');
INSERT INTO public.synonyms VALUES ('W', 'W');
INSERT INTO public.synonyms VALUES ('WO', 'WO');
INSERT INTO public.synonyms VALUES ('Xe', 'XE');
INSERT INTO public.synonyms VALUES ('Y', 'Y');
INSERT INTO public.synonyms VALUES ('Y2O3', 'Y2O3');
INSERT INTO public.synonyms VALUES ('Yb', 'YB');
INSERT INTO public.synonyms VALUES ('Yb2O3', 'YB2O3');
INSERT INTO public.synonyms VALUES ('Zn', 'ZN');
INSERT INTO public.synonyms VALUES ('Zn2+', 'ZNZn2_ZN2');
INSERT INTO public.synonyms VALUES ('ZnO', 'ZNO');
INSERT INTO public.synonyms VALUES ('Zr', 'ZR');
INSERT INTO public.synonyms VALUES ('ZrO2', 'ZRO2');


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 216
-- Name: administrators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.administrators_id_seq', 1, false);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 218
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.authors_id_seq', 2483, true);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 220
-- Name: chem_elements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chem_elements_id_seq', 574, true);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 224
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.countries_id_seq', 1, false);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 227
-- Name: dataset_authors_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dataset_authors_author_id_seq', 1, false);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 228
-- Name: dataset_authors_dataset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dataset_authors_dataset_id_seq', 1, false);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 229
-- Name: dataset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dataset_id_seq', 868, true);


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 237
-- Name: matrix_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.matrix_id_seq', 1, false);


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 235
-- Name: reservoir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reservoir_id_seq', 1321, true);


--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 232
-- Name: sample_index2_sample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sample_index2_sample_id_seq', 20022, true);


--
-- TOC entry 4771 (class 2606 OID 16458)
-- Name: administrators administrators_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_pk PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 16460)
-- Name: administrators administrators_un; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_un UNIQUE (account);


--
-- TOC entry 4776 (class 2606 OID 16462)
-- Name: authors authors_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pk PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 16464)
-- Name: authors authors_un; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_un UNIQUE (surname, name);


--
-- TOC entry 4782 (class 2606 OID 16466)
-- Name: chem_elements chem_elements_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chem_elements
    ADD CONSTRAINT chem_elements_pk PRIMARY KEY (id);


--
-- TOC entry 4785 (class 2606 OID 16468)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- TOC entry 4787 (class 2606 OID 16470)
-- Name: dataset dataset_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT dataset_pk PRIMARY KEY (id);


--
-- TOC entry 4803 (class 2606 OID 73902)
-- Name: keywords keywords_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT keywords_pk PRIMARY KEY (key);


--
-- TOC entry 4801 (class 2606 OID 73896)
-- Name: matrix matrix_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matrix
    ADD CONSTRAINT matrix_pk PRIMARY KEY (id);


--
-- TOC entry 4805 (class 2606 OID 82083)
-- Name: measure_unit measure_unit_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.measure_unit
    ADD CONSTRAINT measure_unit_unique UNIQUE (um);


--
-- TOC entry 4799 (class 2606 OID 16530)
-- Name: reservoir reservoir_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservoir
    ADD CONSTRAINT reservoir_pk PRIMARY KEY (id);


--
-- TOC entry 4791 (class 2606 OID 16472)
-- Name: sample_index sample_index_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_index
    ADD CONSTRAINT sample_index_pk2 PRIMARY KEY (sample_id);


--
-- TOC entry 4793 (class 2606 OID 16474)
-- Name: spider_normalization spider_normalization_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spider_normalization
    ADD CONSTRAINT spider_normalization_unique UNIQUE (method);


--
-- TOC entry 4797 (class 2606 OID 16476)
-- Name: synonyms synonyms_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.synonyms
    ADD CONSTRAINT synonyms_unique UNIQUE (name, synonym);


--
-- TOC entry 4774 (class 1259 OID 16477)
-- Name: authors_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX authors_name_idx ON public.authors USING btree (name);


--
-- TOC entry 4777 (class 1259 OID 16478)
-- Name: authors_surname_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX authors_surname_idx ON public.authors USING btree (surname);


--
-- TOC entry 4780 (class 1259 OID 73883)
-- Name: chem_elements_element_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX chem_elements_element_idx ON public.chem_elements USING btree (element);


--
-- TOC entry 4783 (class 1259 OID 16480)
-- Name: countries_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX countries_index ON public.countries USING btree (country_name);


--
-- TOC entry 4788 (class 1259 OID 16481)
-- Name: dataset_authors_author_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dataset_authors_author_id_idx ON public.dataset_authors USING btree (author_id);


--
-- TOC entry 4789 (class 1259 OID 16482)
-- Name: dataset_authors_dataset_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dataset_authors_dataset_id_idx ON public.dataset_authors USING btree (dataset_id);


--
-- TOC entry 4794 (class 1259 OID 16483)
-- Name: synonyms_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX synonyms_name_idx ON public.synonyms USING btree (name);


--
-- TOC entry 4795 (class 1259 OID 16484)
-- Name: synonyms_synonym_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX synonyms_synonym_idx ON public.synonyms USING btree (synonym);


--
-- TOC entry 4807 (class 2606 OID 16485)
-- Name: dataset_authors author_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_authors
    ADD CONSTRAINT author_fk FOREIGN KEY (author_id) REFERENCES public.authors(id);


--
-- TOC entry 4806 (class 2606 OID 16490)
-- Name: coordinates coordinates_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coordinates
    ADD CONSTRAINT coordinates_fk FOREIGN KEY (sample_id) REFERENCES public.sample_index(sample_id);


--
-- TOC entry 4808 (class 2606 OID 16495)
-- Name: dataset_authors dataset_authors_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_authors
    ADD CONSTRAINT dataset_authors_fk FOREIGN KEY (dataset_id) REFERENCES public.dataset(id);


--
-- TOC entry 4809 (class 2606 OID 16500)
-- Name: dataset_authors dataset_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_authors
    ADD CONSTRAINT dataset_fk FOREIGN KEY (dataset_id) REFERENCES public.dataset(id);


--
-- TOC entry 4810 (class 2606 OID 16505)
-- Name: sample_attribute sample_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_attribute
    ADD CONSTRAINT sample_attribute_fk FOREIGN KEY (sample_id) REFERENCES public.sample_index(sample_id);


--
-- TOC entry 4811 (class 2606 OID 16510)
-- Name: sample_index sample_index_dataset_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_index
    ADD CONSTRAINT sample_index_dataset_fk FOREIGN KEY (dataset_id) REFERENCES public.dataset(id);


-- Completed on 2024-07-31 13:02:40

--
-- PostgreSQL database dump complete
--

