--
-- PostgreSQL database dump
--

-- Dumped from database version 12.19
-- Dumped by pg_dump version 16.1

-- Started on 2024-07-31 11:54:40

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
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 208 (class 1259 OID 116717)
-- Name: cache; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO mitrakam_petesemart;

--
-- TOC entry 209 (class 1259 OID 116725)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO mitrakam_petesemart;

--
-- TOC entry 216 (class 1259 OID 116769)
-- Name: customers; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.customers (
    "idCustomer" bigint NOT NULL,
    nama character varying(255),
    tipe character varying(255) DEFAULT 'lead'::character varying NOT NULL,
    skala character varying(255) DEFAULT 'individu'::character varying NOT NULL,
    email character varying(255),
    telefon character varying(255),
    alamat character varying(255),
    instagram character varying(255),
    facebook character varying(255),
    twitter character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT customers_skala_check CHECK (((skala)::text = ANY ((ARRAY['individu'::character varying, 'perusahaan'::character varying])::text[]))),
    CONSTRAINT customers_tipe_check CHECK (((tipe)::text = ANY ((ARRAY['lead'::character varying, 'customer'::character varying])::text[])))
);


ALTER TABLE public.customers OWNER TO mitrakam_petesemart;

--
-- TOC entry 215 (class 1259 OID 116767)
-- Name: customers_idCustomer_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public."customers_idCustomer_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."customers_idCustomer_seq" OWNER TO mitrakam_petesemart;

--
-- TOC entry 4059 (class 0 OID 0)
-- Dependencies: 215
-- Name: customers_idCustomer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public."customers_idCustomer_seq" OWNED BY public.customers."idCustomer";


--
-- TOC entry 214 (class 1259 OID 116755)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO mitrakam_petesemart;

--
-- TOC entry 213 (class 1259 OID 116753)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO mitrakam_petesemart;

--
-- TOC entry 4061 (class 0 OID 0)
-- Dependencies: 213
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 212 (class 1259 OID 116745)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO mitrakam_petesemart;

--
-- TOC entry 211 (class 1259 OID 116735)
-- Name: jobs; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO mitrakam_petesemart;

--
-- TOC entry 210 (class 1259 OID 116733)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO mitrakam_petesemart;

--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 210
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 222 (class 1259 OID 116823)
-- Name: lead_process; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.lead_process (
    "idLeadProcess" bigint NOT NULL,
    "idCustomer" bigint,
    status character varying(255) DEFAULT 'dibuat'::character varying NOT NULL,
    "idManager" bigint,
    deskripsi text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT lead_process_status_check CHECK (((status)::text = ANY ((ARRAY['dibuat'::character varying, 'pending'::character varying, 'diterima'::character varying, 'ditolak'::character varying])::text[])))
);


ALTER TABLE public.lead_process OWNER TO mitrakam_petesemart;

--
-- TOC entry 221 (class 1259 OID 116821)
-- Name: lead_process_idLeadProcess_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public."lead_process_idLeadProcess_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."lead_process_idLeadProcess_seq" OWNER TO mitrakam_petesemart;

--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 221
-- Name: lead_process_idLeadProcess_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public."lead_process_idLeadProcess_seq" OWNED BY public.lead_process."idLeadProcess";


--
-- TOC entry 203 (class 1259 OID 116679)
-- Name: migrations; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO mitrakam_petesemart;

--
-- TOC entry 202 (class 1259 OID 116677)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO mitrakam_petesemart;

--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 202
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 206 (class 1259 OID 116699)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO mitrakam_petesemart;

--
-- TOC entry 218 (class 1259 OID 116788)
-- Name: product; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.product (
    "idProduct" bigint NOT NULL,
    nama character varying(255) NOT NULL,
    deskripsi text,
    harga character varying(255) NOT NULL,
    "gambarProduct" character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.product OWNER TO mitrakam_petesemart;

--
-- TOC entry 217 (class 1259 OID 116786)
-- Name: product_idProduct_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public."product_idProduct_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."product_idProduct_seq" OWNER TO mitrakam_petesemart;

--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 217
-- Name: product_idProduct_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public."product_idProduct_seq" OWNED BY public.product."idProduct";


--
-- TOC entry 220 (class 1259 OID 116799)
-- Name: sales; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.sales (
    "idSales" bigint NOT NULL,
    "idCustomer" bigint,
    "idProduct" bigint,
    "jumlahTransaksi" character varying(255) DEFAULT '0'::character varying NOT NULL,
    deskripsi text,
    status character varying(255) DEFAULT 'belumdibayar'::character varying NOT NULL,
    invoice_file character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT sales_status_check CHECK (((status)::text = ANY ((ARRAY['belumdibayar'::character varying, 'dibayar'::character varying, 'expired'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.sales OWNER TO mitrakam_petesemart;

--
-- TOC entry 219 (class 1259 OID 116797)
-- Name: sales_idSales_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public."sales_idSales_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."sales_idSales_seq" OWNER TO mitrakam_petesemart;

--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 219
-- Name: sales_idSales_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public."sales_idSales_seq" OWNED BY public.sales."idSales";


--
-- TOC entry 207 (class 1259 OID 116707)
-- Name: sessions; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO mitrakam_petesemart;

--
-- TOC entry 205 (class 1259 OID 116687)
-- Name: users; Type: TABLE; Schema: public; Owner: mitrakam_petesemart
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    role integer DEFAULT 2,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO mitrakam_petesemart;

--
-- TOC entry 204 (class 1259 OID 116685)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mitrakam_petesemart
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO mitrakam_petesemart;

--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 204
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mitrakam_petesemart
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3849 (class 2604 OID 116772)
-- Name: customers idCustomer; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.customers ALTER COLUMN "idCustomer" SET DEFAULT nextval('public."customers_idCustomer_seq"'::regclass);


--
-- TOC entry 3847 (class 2604 OID 116758)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 3846 (class 2604 OID 116738)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 3856 (class 2604 OID 116826)
-- Name: lead_process idLeadProcess; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.lead_process ALTER COLUMN "idLeadProcess" SET DEFAULT nextval('public."lead_process_idLeadProcess_seq"'::regclass);


--
-- TOC entry 3843 (class 2604 OID 116682)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3852 (class 2604 OID 116791)
-- Name: product idProduct; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.product ALTER COLUMN "idProduct" SET DEFAULT nextval('public."product_idProduct_seq"'::regclass);


--
-- TOC entry 3853 (class 2604 OID 116802)
-- Name: sales idSales; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.sales ALTER COLUMN "idSales" SET DEFAULT nextval('public."sales_idSales_seq"'::regclass);


--
-- TOC entry 3844 (class 2604 OID 116690)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4035 (class 0 OID 116717)
-- Dependencies: 208
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.cache (key, value, expiration) FROM stdin;
cfacf268a6dfe720a9e0de7c6c5e622d606c062f:timer	i:1722389806;	1722389806
cfacf268a6dfe720a9e0de7c6c5e622d606c062f	i:1;	1722389806
77de68daecd823babbb58edb1c8e14d7106e83bb:timer	i:1722393462;	1722393462
77de68daecd823babbb58edb1c8e14d7106e83bb	i:1;	1722393462
356a192b7913b04c54574d18c28d46e6395428ab:timer	i:1722397763;	1722397763
356a192b7913b04c54574d18c28d46e6395428ab	i:3;	1722397763
5b4e6ec86e5a395901a9441b181c02c030dcc920:timer	i:1722399011;	1722399011
5b4e6ec86e5a395901a9441b181c02c030dcc920	i:1;	1722399011
\.


--
-- TOC entry 4036 (class 0 OID 116725)
-- Dependencies: 209
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 4043 (class 0 OID 116769)
-- Dependencies: 216
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.customers ("idCustomer", nama, tipe, skala, email, telefon, alamat, instagram, facebook, twitter, created_at, updated_at) FROM stdin;
1	Agus Setiawan	customer	individu	agus.setiawan@example.com	081234567890	Jl. Merdeka No.12, Jakarta	agussetiawaninsta	agussetiawanfb	agussetiwantw	\N	\N
2	Ratna Sari	lead	perusahaan	ratna.sari@example.com	082345678901	Jl. Sudirman No.34, Bandung	ratnasariinsta	ratnasarifb	ratnasaritw	\N	\N
3	Budi Raharjo	lead	individu	budi.raharjo@example.com	083456789012	Jl. Malioboro No.56, Yogyakarta	budiraharjoinsta	budiraharjofb	budiraharjotw	\N	\N
5	Andi Sunarto	customer	individu	andi.sunarto@example.com	085678901234	Jl. Diponegoro No.123, Medan	andisunartoinsta	andisunartofb	andisunartotw	\N	\N
6	Maria Ulfa	lead	perusahaan	maria.ulfa@example.com	086789012345	Jl. Basuki Rahmat No.234, Palembang	mariaulfainsta	mariaulfafb	mariaulfatw	\N	\N
7	Rudi Hartono	lead	individu	rudi.hartono@example.com	087890123456	Jl. Raya Kuta No.345, Bali	rudihartoinsta	rudihartonofb	rudihartonotw	\N	\N
9	Dewi Sukma	lead	perusahaan	dewi.sukma@example.com	089012345678	Jl. Pattimura No.567, Makassar	dewisukmainsta	dewisukmafb	dewisukmatw	\N	\N
10	Adi Putra	customer	perusahaan	adi.putra@example.com	090123456789	Jl. Ahmad Yani No.678, Semarang	adiputrainsta	adiputrafab	adiputratw	\N	\N
12	Putri Anggraini	lead	perusahaan	putri.anggraini@example.com	082234455667	Jl. Sultan Hasanuddin No.25, Malang	putrianggrainiinsta	putrianggrainifb	putrianggrainitw	\N	\N
13	Galih Pratama	customer	individu	galih.pratama@example.com	083245566778	Jl. Teuku Umar No.40, Padang	galihpratamainsta	galihpratamafb	galihpratamatw	\N	\N
14	Rini Astuti	lead	perusahaan	rini.astuti@example.com	084256677889	Jl. Cendana No.55, Samarinda	riniastutiinsta	riniastutifb	riniastutitw	\N	\N
15	Ahmad Syarif	lead	individu	ahmad.syarif@example.com	085267788990	Jl. A. Yani No.70, Bandar Lampung	ahmadsyarifinsta	ahmadsyariffb	ahmadsyariftw	\N	\N
17	Bima Sakti	lead	perusahaan	bima.sakti@example.com	087289901122	Jl. Pemuda No.100, Jayapura	bimasaktiinsta	bimasaktifb	bimasaktitw	\N	\N
19	Dian Sastro	lead	individu	dian.sastro@example.com	089301122344	Jl. Sudirman No.130, Manado	diansastroinsta	diansastrofb	diansastrotw	\N	\N
\.


--
-- TOC entry 4041 (class 0 OID 116755)
-- Dependencies: 214
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 4039 (class 0 OID 116745)
-- Dependencies: 212
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 4038 (class 0 OID 116735)
-- Dependencies: 211
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 4049 (class 0 OID 116823)
-- Dependencies: 222
-- Data for Name: lead_process; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.lead_process ("idLeadProcess", "idCustomer", status, "idManager", deskripsi, created_at, updated_at) FROM stdin;
1	17	diterima	\N	Bima Sakti Lead Process menjadi Customer promosi	2024-07-31 09:29:06	2024-07-31 09:29:45
2	2	pending	\N	ratna lead project	2024-07-31 10:50:57	2024-07-31 10:51:09
\.


--
-- TOC entry 4030 (class 0 OID 116679)
-- Dependencies: 203
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2024_07_29_054204_create_customers_table	1
5	2024_07_29_054907_create_product_table	1
6	2024_07_29_075842_create_sales_table	1
7	2024_07_29_080115_create_lead_process_table	1
\.


--
-- TOC entry 4033 (class 0 OID 116699)
-- Dependencies: 206
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 4045 (class 0 OID 116788)
-- Dependencies: 218
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.product ("idProduct", nama, deskripsi, harga, "gambarProduct", created_at, updated_at) FROM stdin;
1	Product 1	ini adalah produk 1 	500000	product_images/01J43A6FYKTBZXHVAYGFK5Q4TP.jpg	2024-07-31 09:31:56	2024-07-31 09:34:07
2	Product 2	ini adalah layanan produk 2	800000	product_images/01J43A8PQDNY8RGPKJQJRDJXWN.jpg	2024-07-31 09:35:20	2024-07-31 09:35:20
\.


--
-- TOC entry 4047 (class 0 OID 116799)
-- Dependencies: 220
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.sales ("idSales", "idCustomer", "idProduct", "jumlahTransaksi", deskripsi, status, invoice_file, created_at, updated_at) FROM stdin;
2	1	2	70000	agus	dibayar	invoices/01J43ECFZZT76YTB4C4316K89P.pdf	2024-07-31 10:47:18	2024-07-31 10:47:18
3	5	1	800000	andi	dibayar	invoices/01J43EDQX2837VPCM91APP4KV5.pdf	2024-07-31 10:47:59	2024-07-31 10:47:59
4	10	2	970000	adi	dibayar	invoices/01J43EEHG1GGQ7NYQEQWW3FR1G.pdf	2024-07-31 10:48:25	2024-07-31 10:48:25
5	13	1	800000	galih transaksi 1	dibayar	invoices/01J43EFCPTW20DMRYS4CPSF6D6.pdf	2024-07-31 10:48:53	2024-07-31 10:48:53
6	13	2	5000000	galih transaksi 2	dibayar	invoices/01J43EGAFRN0NM9PN7971KSADA.pdf	2024-07-31 10:49:24	2024-07-31 10:49:24
\.


--
-- TOC entry 4034 (class 0 OID 116707)
-- Dependencies: 207
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
XHXHM54weocTV1V1uDknVp1hiwOpoeNaEEheejX8	\N	52.16.245.145	Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101 Firefox/83.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQkZMbmhoWEdIS1plUGJWZ2VPWmZOYUpSYjFhU1UweGM2bUc5Mk9LSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM3OiJodHRwczovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9fQ==	1722398663
P8ZiwM1SQDrRGU2yXbwZ2yLy8cS22Wg5zyw4Epcx	\N	52.16.245.145	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiczhZZTZ1RTV4UFFnNFNSM3FZQmV1NnM4c3ZaTE9DY085WVIxbkhQaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1722398669
WooLm7XvVKfdtvpVUedj3BiVYwe1D21rcPcigvh5	\N	36.68.217.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSzlJNndZZG1hdVdjWktQU2ppMWlZMWxOMTJWalBUcDd2U01DeEc0QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM3OiJodHRwczovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9fQ==	1722398870
jP10nzieknTFnrVglx59ycpMmbxSqgQxTOQDIEME	\N	52.16.245.145	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOWxuMmFIc0ROZkVUY0NBbklDa0hlRFg5amFORkZad050SjBHQ2UxaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vd3d3LnB0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MToiaHR0cHM6Ly93d3cucHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4iO319	1722398685
mg2SWSMkqxWPm0JdRZjfWnMUV6ydBx7PH8ijYUpT	\N	2001:448a:50e2:bb9:e1b6:902f:5fe7:776	WhatsApp/2.23.20.0	YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTFWSGdsdlhndmpCZlA2RkprRHVrYWdheEh4a3ZlTXViMFBMdjROUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1722398768
iMVAt9wGsnGsFfDhRPZl8BGLnoSBJzabgTu8fu5X	\N	2001:448a:50e2:bb9:e1b6:902f:5fe7:776	WhatsApp/2.23.20.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTkUwTUN6YWI4d29sUUtXOVMyQ01Ua1kzcEVZUlZUTjlJNnluUWRsYyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNzoiaHR0cHM6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbiI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwczovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1722398768
L6IAsPpGuSxR3sxs9kEBMMsGSTJjpDltrkUwE4p8	\N	2001:448a:50e2:bb9:e1b6:902f:5fe7:776	WhatsApp/2.23.20.0	YTozOntzOjY6Il90b2tlbiI7czo0MDoiMW9zZzBLaUVSMXpZenZDZnl3MUxHRTZ3ZUdJaUs1REJBeXZtSXNMTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1722398769
VrSostVfzZ3gqMiV3zV3nOgZOiYy3v2Zu3G1rGaw	3	36.68.217.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36	YTo3OntzOjY6Il90b2tlbiI7czo0MDoiNm1oMm9GRkxaQTI2WlQxaTJtS213SzRUYUhmUzV1VERPWHREM3NmZCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQzOiJodHRwczovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluL3NhbGVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJDNDc0lXSkZSVk5kYXNTOTFHRHN2OGVpQy8ybVZqaWFwQzh1SC8wQjlkQWIzTFJsYUNISFRTIjtzOjg6ImZpbGFtZW50IjthOjA6e319	1722394012
lWyc1mQO6txh9YKIApg9eswFo7SFgLt9OOFY8YIb	\N	133.242.174.119	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoibjJud0lSM3RmMFBPQVZnVUtSMkxYUVI5YmZSTXR3MHB2MWVYUlBDQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vd3d3LnB0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MToiaHR0cHM6Ly93d3cucHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4iO319	1722398913
JBdLFoi6sZxTGnHVGuPfFYlkHlEcRj7T1EPkbQiz	2	36.68.217.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36	YTo2OntzOjY6Il90b2tlbiI7czo0MDoiVjd1TUFaOXJ6N1AzQ3JNejNpb1F2Z0laMDdkakhsNllBTjU2VUM2SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vc2FsZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJHB2NE5lNW5QbHVTLzBMWVNZVHFhcHV3Z0pvQXdUclJJczRSTEIwV0hEMWlORm9oeW1UQ1dhIjt9	1722398985
uDpWf9BWFrkb0qQwvw9xPr75RSd9hO8cCS2otfDU	\N	104.166.80.15	Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOUVSV0hOVGR2U2NqTzBud00zRmlHa21BSmJkeDB4WkdCWUdHR1lnSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM3OiJodHRwczovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9fQ==	1722399120
LOQYo5iAJru0HXKGJYru3TW8DXDvvQe9nMGg99hs	\N	104.166.80.126	Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZE1yWGlJVzB0YnlObXZMWmtyZ1FHT290VTc4RWx5UE9UeVVkeWozcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vd3d3LnB0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MToiaHR0cHM6Ly93d3cucHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4iO319	1722399508
YpKMeTXfWIKCyCc6XA453hvmJ4E8Zq3zPP1HmUjq	\N	64.15.129.117	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiMk1zRjBUMHh6bEdUMW5Jdnk2ZFBGMExNNWdmVXJCcXNkU1I4MktidSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392505
qClr2dic9NTAbxvdJjeqZpYiJnjqHLyj1LSReRWb	\N	64.15.129.117	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSElNT0ZxbFd1YllHNDFFSnpreHoyVFY0UFpWQzE4NU1YcVRXeTVDQyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNjoiaHR0cDovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392506
WWSFcSMlmAeolX7NIjw2c7MM0FS9HmDXakuS1C8e	\N	64.15.129.117	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVJnOVhKeUV3bjFxOEdJS0s5WkNQRXB4NTFDMzNZcWlVd3V0bElHcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbi9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392506
DCPETaCS16kHs7vRonQTeNxgAFGbqtakm9Uh16ZN	\N	64.15.129.118	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoickRpbER5QjdkWUlIbWZ2ZUFSdzkzbmxzMURha25Dam1aU0dRVXVFcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392510
3EGpGXqvloOTd9iXsjdRlzt0hHeduCZYlXOxRgoP	\N	64.15.129.118	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR0I3TzdzaFU3V1NBVzk5WDAyVzVaMkVmc2RPa2ZZM2w2VXhZbHdRZiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNjoiaHR0cDovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392510
mgpSGo0vP3dvpl50w4jz2oHxv21Fgs6DsFmYUQxe	\N	64.15.129.118	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiS3poVGNoc1JSWXpOYm1SMlV0aXg5SklneWY1d2ExUGlydkhLTEVjZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbi9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392511
vEbZlF7a9Fc7mRCrRgHtF0CRPFaKvKHnTwP3DOzE	\N	192.175.111.237	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGJhM3dtNU1ldFJjaE5PdVp6Y1dNSjFJVjhqbm5pWWhva3Nvdm1VOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392515
wFxYeSg2rpvpjzINejILzliyZxuedvqqvkcbvapa	\N	192.175.111.237	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiazUzYTB1ZFdMQTRNdUxOQzVLOUtCcTNvdTFrcHl0dXdLZFhmTlBDbCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNjoiaHR0cDovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392516
EGYdlgLmtY7XMKJ10om6XyAKhRVtyYEFCV6DFBkf	\N	192.175.111.237	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoieUJuc2gyWkl3a29kQkpOZHc4bTE0MkV0dHFoMG9ERFRwbHBoQWQ3VSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbi9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392517
ZegPJ7tSXKjl0rmzxT4tGWhGPOevo8mroNOvHW0c	\N	64.15.129.105	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoibEJ5VVlYUUliUXRtN0Z2b291OGxIWlFXdlNBMzlrMklEWEZNdnVNaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392518
1eFKDM9N3e5rNH1hKlGTCOuKWuXroAyNTrtbntwy	\N	64.15.129.105	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV3FJUVEwYXowaXJKMkl2a3dsTGI5VnhIZXFzcklMS2hFRnBsTXF1NCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNjoiaHR0cDovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392518
ia5nKtZyLUlVpYYL6K6K8R9jX0e7wC0e8s7jg2KR	\N	64.15.129.105	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiVXl5aVNMelpWY01YeUVRQkU0ZUsxWklQeVlJVDBxVEdwa1JBSDJJcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9wdHNtYXJ0Lm1pdHJha2FtaS5teS5pZC9hZG1pbi9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1722392519
eH4yWBdryi1ER2RXijOSzDjfsJjNTybnu1FGKDfU	1	36.68.217.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36	YTo4OntzOjY6Il90b2tlbiI7czo0MDoiUHBGdUp4Q3RzWUxsT0w0d2FlTFVkWHE0OVBiMzdtUFNaODkxTEhNVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vc2FsZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJGVXNFY2RHQyT08xQWg5OTY2ekdkLi42NnlBT1pBZC9JbHppRnFNUUpsU0p3dDVvdFRIbThDIjtzOjY6InRhYmxlcyI7YToxOntzOjIyOiJMaXN0Q3VzdG9tZXJzX3Blcl9wYWdlIjtzOjI6IjI1Ijt9czo4OiJmaWxhbWVudCI7YTowOnt9fQ==	1722401414
S6FAEwkKYL9ywEL2KMwcAn7JMU38boYSWaxlir0j	2	36.68.217.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36	YTo3OntzOjY6Il90b2tlbiI7czo0MDoic0YzRXhlV2xpbUNzMGdqTlZiVDdXS1ZrNDROUWJvd1ZnbElaODJrdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTI6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vbGVhZC1wcm9jZXNzZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJHB2NE5lNW5QbHVTLzBMWVNZVHFhcHV3Z0pvQXdUclJJczRSTEIwV0hEMWlORm9oeW1UQ1dhIjtzOjg6ImZpbGFtZW50IjthOjA6e319	1722392955
ChhdkgKZjWl59MNXjQn2Hx5wrXiEUPPTjLFr8dvz	\N	52.16.245.145	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTWlHeENMaVBKNGh6b3Nubkh1azNibWluT1pZU1hCeWJObkZ1cTN1byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vcHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM3OiJodHRwczovL3B0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluIjt9fQ==	1722398665
jTY0I7lR6cCFAMsr9zEioycm0O447yPDZaIynjRw	\N	52.16.245.145	Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101 Firefox/83.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoibzZGcXJvWnY1cXpVTk1KZHAzcHRKSEJ2WTFIVWNLTHU4ZVdtRVhLRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vd3d3LnB0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MToiaHR0cHM6Ly93d3cucHRzbWFydC5taXRyYWthbWkubXkuaWQvYWRtaW4iO319	1722398683
sjUfF34fyvvgRacy0mybRgWn1haLfLcjIxNUY5Ri	\N	52.16.245.145	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0lFSVduTlBEZHJWRk03WUd2RFl0d1JRSElZSGdLeER2MUNEY0ZNUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vd3d3LnB0c21hcnQubWl0cmFrYW1pLm15LmlkL2FkbWluL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1722398688
\.


--
-- TOC entry 4032 (class 0 OID 116687)
-- Dependencies: 205
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mitrakam_petesemart
--

COPY public.users (id, name, email, role, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
1	Admin	admin@ptsmart.com	1	\N	$2y$12$eW4V6Dt2OO1Ah9966zGd..66yAOZAd/IlziFqMQJlSJwt5otTHm8C	VIUM0LNAE7aArZzkdeTg5pHtvEXHXsutNmwE9gYBjk8t2btvwwn1bh31NFyd	2024-07-31 08:31:42	2024-07-31 08:31:42
2	Sales 1	sales1@ptsmart.com	2	\N	$2y$12$pv4Ne5nPluS/0LYSYTqapuwgJoAwTrRIs4RLB0WHD1iNFohymTCWa	UtLpv0LTPX7pAat7Kfc3lk5IC4aexcZOWInKAaHpbzQe5GvJPE9Jwj414rkT	2024-07-31 09:27:12	2024-07-31 09:27:12
3	Manager 1	manager1@ptsmart.com	3	\N	$2y$12$3CsIWJFRVNdasS91GDsv8eiC/2mVjiapC8uH/0B9dAb3LRlaCHHTS	QPkGFWfCvHJ0tIfFmPq9BINUcf6ePOlpvuTlSYKdSoLhveI9yX5uGkW9mNn6	2024-07-31 09:28:10	2024-07-31 09:28:10
\.


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 215
-- Name: customers_idCustomer_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public."customers_idCustomer_seq"', 20, true);


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 213
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 210
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 221
-- Name: lead_process_idLeadProcess_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public."lead_process_idLeadProcess_seq"', 2, true);


--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 202
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public.migrations_id_seq', 7, true);


--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 217
-- Name: product_idProduct_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public."product_idProduct_seq"', 2, true);


--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 219
-- Name: sales_idSales_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public."sales_idSales_seq"', 6, true);


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 204
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mitrakam_petesemart
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 3877 (class 2606 OID 116732)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 3875 (class 2606 OID 116724)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 3888 (class 2606 OID 116783)
-- Name: customers customers_email_unique; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_unique UNIQUE (email);


--
-- TOC entry 3890 (class 2606 OID 116781)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY ("idCustomer");


--
-- TOC entry 3892 (class 2606 OID 116785)
-- Name: customers customers_telefon_unique; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_telefon_unique UNIQUE (telefon);


--
-- TOC entry 3884 (class 2606 OID 116764)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3886 (class 2606 OID 116766)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3882 (class 2606 OID 116752)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 3879 (class 2606 OID 116743)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3898 (class 2606 OID 116833)
-- Name: lead_process lead_process_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.lead_process
    ADD CONSTRAINT lead_process_pkey PRIMARY KEY ("idLeadProcess");


--
-- TOC entry 3863 (class 2606 OID 116684)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3869 (class 2606 OID 116706)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 3894 (class 2606 OID 116796)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY ("idProduct");


--
-- TOC entry 3896 (class 2606 OID 116810)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY ("idSales");


--
-- TOC entry 3872 (class 2606 OID 116714)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3865 (class 2606 OID 116698)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 3867 (class 2606 OID 116696)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3880 (class 1259 OID 116744)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: mitrakam_petesemart
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 3870 (class 1259 OID 116716)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: mitrakam_petesemart
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 3873 (class 1259 OID 116715)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: mitrakam_petesemart
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 3901 (class 2606 OID 116834)
-- Name: lead_process lead_process_idcustomer_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.lead_process
    ADD CONSTRAINT lead_process_idcustomer_foreign FOREIGN KEY ("idCustomer") REFERENCES public.customers("idCustomer") ON DELETE SET NULL;


--
-- TOC entry 3902 (class 2606 OID 116839)
-- Name: lead_process lead_process_idmanager_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.lead_process
    ADD CONSTRAINT lead_process_idmanager_foreign FOREIGN KEY ("idManager") REFERENCES public.users(id);


--
-- TOC entry 3899 (class 2606 OID 116811)
-- Name: sales sales_idcustomer_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_idcustomer_foreign FOREIGN KEY ("idCustomer") REFERENCES public.customers("idCustomer") ON DELETE SET NULL;


--
-- TOC entry 3900 (class 2606 OID 116816)
-- Name: sales sales_idproduct_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mitrakam_petesemart
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_idproduct_foreign FOREIGN KEY ("idProduct") REFERENCES public.product("idProduct") ON DELETE SET NULL;


--
-- TOC entry 4055 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 4056 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE cache; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.cache TO mitrakam_ptsmart;


--
-- TOC entry 4057 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE cache_locks; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.cache_locks TO mitrakam_ptsmart;


--
-- TOC entry 4058 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE customers; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.customers TO mitrakam_ptsmart;


--
-- TOC entry 4060 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE failed_jobs; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.failed_jobs TO mitrakam_ptsmart;


--
-- TOC entry 4062 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE job_batches; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.job_batches TO mitrakam_ptsmart;


--
-- TOC entry 4063 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE jobs; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.jobs TO mitrakam_ptsmart;


--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE lead_process; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.lead_process TO mitrakam_ptsmart;


--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE migrations; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.migrations TO mitrakam_ptsmart;


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE password_reset_tokens; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.password_reset_tokens TO mitrakam_ptsmart;


--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE product; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.product TO mitrakam_ptsmart;


--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE sales; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.sales TO mitrakam_ptsmart;


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE sessions; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.sessions TO mitrakam_ptsmart;


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE users; Type: ACL; Schema: public; Owner: mitrakam_petesemart
--

GRANT ALL ON TABLE public.users TO mitrakam_ptsmart;


-- Completed on 2024-07-31 11:54:42

--
-- PostgreSQL database dump complete
--

