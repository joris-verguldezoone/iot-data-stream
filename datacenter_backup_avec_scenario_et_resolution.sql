--
-- PostgreSQL database dump
--

\restrict dPtokdGh0Rh9vL9CXUtoloEb1C2noh8KDlEY5bVB28Ec6thPp1i7S67JoOgrez9

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: tsuser
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO tsuser;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: tsuser
--

COMMENT ON SCHEMA public IS '';


--
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data (Community Edition)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO tsuser;

--
-- Name: cluster; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.cluster (
    cluster_id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cluster_location_id integer NOT NULL
);


ALTER TABLE public.cluster OWNER TO tsuser;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.cluster_cluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cluster_cluster_id_seq OWNER TO tsuser;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.cluster_cluster_id_seq OWNED BY public.cluster.cluster_id;


--
-- Name: cluster_configuration; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.cluster_configuration (
    cluster_config_id integer NOT NULL,
    name text NOT NULL,
    master integer NOT NULL,
    worker integer NOT NULL,
    consomation_per_master double precision,
    consomation_per_worker double precision,
    hardware_per_master text,
    hardware_per_worker text,
    pue double precision,
    location_id integer,
    fan_id integer,
    fan_count integer DEFAULT 1 NOT NULL,
    cpu_cooler_catalog_id integer NOT NULL,
    fan_catalog_id integer NOT NULL,
    load_profile_id integer
);


ALTER TABLE public.cluster_configuration OWNER TO tsuser;

--
-- Name: cluster_configuration_cluster_config_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.cluster_configuration_cluster_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cluster_configuration_cluster_config_id_seq OWNER TO tsuser;

--
-- Name: cluster_configuration_cluster_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.cluster_configuration_cluster_config_id_seq OWNED BY public.cluster_configuration.cluster_config_id;


--
-- Name: cluster_location; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.cluster_location (
    location_id integer NOT NULL,
    name text NOT NULL,
    location text,
    env_factor double precision DEFAULT 1.0 NOT NULL,
    cluster_count integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    energy_cost_kwh double precision DEFAULT 0.15 NOT NULL
);


ALTER TABLE public.cluster_location OWNER TO tsuser;

--
-- Name: cluster_location_location_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.cluster_location_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cluster_location_location_id_seq OWNER TO tsuser;

--
-- Name: cluster_location_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.cluster_location_location_id_seq OWNED BY public.cluster_location.location_id;


--
-- Name: cpucooler_catalog; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.cpucooler_catalog (
    cpu_cooler_catalog_id integer NOT NULL,
    model_name text NOT NULL,
    type text NOT NULL,
    thermal_capacity integer NOT NULL
);


ALTER TABLE public.cpucooler_catalog OWNER TO tsuser;

--
-- Name: cpucooler_catalog_cpu_cooler_catalog_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.cpucooler_catalog_cpu_cooler_catalog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cpucooler_catalog_cpu_cooler_catalog_id_seq OWNER TO tsuser;

--
-- Name: cpucooler_catalog_cpu_cooler_catalog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.cpucooler_catalog_cpu_cooler_catalog_id_seq OWNED BY public.cpucooler_catalog.cpu_cooler_catalog_id;


--
-- Name: fan; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.fan (
    fan_id integer NOT NULL,
    server_id integer NOT NULL,
    fan_catalog_id integer,
    fan_config_id integer,
    control_mode text DEFAULT 'AUTO'::text NOT NULL,
    status text DEFAULT 'OFF'::text NOT NULL,
    speed_percent integer DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.fan OWNER TO tsuser;

--
-- Name: fan_catalog; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.fan_catalog (
    fan_catalog_id integer NOT NULL,
    model_name text NOT NULL,
    consomation double precision
);


ALTER TABLE public.fan_catalog OWNER TO tsuser;

--
-- Name: fan_catalog_fan_catalog_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.fan_catalog_fan_catalog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fan_catalog_fan_catalog_id_seq OWNER TO tsuser;

--
-- Name: fan_catalog_fan_catalog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.fan_catalog_fan_catalog_id_seq OWNED BY public.fan_catalog.fan_catalog_id;


--
-- Name: fan_configuration; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.fan_configuration (
    fan_id integer NOT NULL,
    name text NOT NULL,
    consomation double precision
);


ALTER TABLE public.fan_configuration OWNER TO tsuser;

--
-- Name: fan_configuration_fan_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.fan_configuration_fan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fan_configuration_fan_id_seq OWNER TO tsuser;

--
-- Name: fan_configuration_fan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.fan_configuration_fan_id_seq OWNED BY public.fan_configuration.fan_id;


--
-- Name: fan_fan_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.fan_fan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fan_fan_id_seq OWNER TO tsuser;

--
-- Name: fan_fan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.fan_fan_id_seq OWNED BY public.fan.fan_id;


--
-- Name: load_profile; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.load_profile (
    id integer NOT NULL,
    name text NOT NULL,
    hour integer NOT NULL,
    expected_load_percent double precision NOT NULL,
    target_temp_celsius double precision NOT NULL,
    standard_fan_speed text DEFAULT 'MEDIUM'::text NOT NULL
);


ALTER TABLE public.load_profile OWNER TO tsuser;

--
-- Name: load_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.load_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.load_profile_id_seq OWNER TO tsuser;

--
-- Name: load_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.load_profile_id_seq OWNED BY public.load_profile.id;


--
-- Name: sensor; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.sensor (
    sensor_id integer NOT NULL,
    server_id integer NOT NULL,
    sensor_type text NOT NULL,
    unit text NOT NULL,
    last_value double precision,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.sensor OWNER TO tsuser;

--
-- Name: sensor_data; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.sensor_data (
    id integer NOT NULL,
    "time" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sensor_id integer NOT NULL,
    value double precision NOT NULL
);


ALTER TABLE public.sensor_data OWNER TO tsuser;

--
-- Name: sensor_data_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.sensor_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensor_data_id_seq OWNER TO tsuser;

--
-- Name: sensor_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.sensor_data_id_seq OWNED BY public.sensor_data.id;


--
-- Name: sensor_sensor_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.sensor_sensor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensor_sensor_id_seq OWNER TO tsuser;

--
-- Name: sensor_sensor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.sensor_sensor_id_seq OWNED BY public.sensor.sensor_id;


--
-- Name: server; Type: TABLE; Schema: public; Owner: tsuser
--

CREATE TABLE public.server (
    server_id integer NOT NULL,
    cluster_id integer NOT NULL,
    config_id integer,
    hostname text NOT NULL,
    status text DEFAULT 'ON'::text NOT NULL,
    base_consumption_offset double precision DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_master boolean DEFAULT false NOT NULL
);


ALTER TABLE public.server OWNER TO tsuser;

--
-- Name: server_server_id_seq; Type: SEQUENCE; Schema: public; Owner: tsuser
--

CREATE SEQUENCE public.server_server_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.server_server_id_seq OWNER TO tsuser;

--
-- Name: server_server_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tsuser
--

ALTER SEQUENCE public.server_server_id_seq OWNED BY public.server.server_id;


--
-- Name: cluster cluster_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster ALTER COLUMN cluster_id SET DEFAULT nextval('public.cluster_cluster_id_seq'::regclass);


--
-- Name: cluster_configuration cluster_config_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_configuration ALTER COLUMN cluster_config_id SET DEFAULT nextval('public.cluster_configuration_cluster_config_id_seq'::regclass);


--
-- Name: cluster_location location_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_location ALTER COLUMN location_id SET DEFAULT nextval('public.cluster_location_location_id_seq'::regclass);


--
-- Name: cpucooler_catalog cpu_cooler_catalog_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cpucooler_catalog ALTER COLUMN cpu_cooler_catalog_id SET DEFAULT nextval('public.cpucooler_catalog_cpu_cooler_catalog_id_seq'::regclass);


--
-- Name: fan fan_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan ALTER COLUMN fan_id SET DEFAULT nextval('public.fan_fan_id_seq'::regclass);


--
-- Name: fan_catalog fan_catalog_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan_catalog ALTER COLUMN fan_catalog_id SET DEFAULT nextval('public.fan_catalog_fan_catalog_id_seq'::regclass);


--
-- Name: fan_configuration fan_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan_configuration ALTER COLUMN fan_id SET DEFAULT nextval('public.fan_configuration_fan_id_seq'::regclass);


--
-- Name: load_profile id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.load_profile ALTER COLUMN id SET DEFAULT nextval('public.load_profile_id_seq'::regclass);


--
-- Name: sensor sensor_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.sensor ALTER COLUMN sensor_id SET DEFAULT nextval('public.sensor_sensor_id_seq'::regclass);


--
-- Name: sensor_data id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.sensor_data ALTER COLUMN id SET DEFAULT nextval('public.sensor_data_id_seq'::regclass);


--
-- Name: server server_id; Type: DEFAULT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.server ALTER COLUMN server_id SET DEFAULT nextval('public.server_server_id_seq'::regclass);


--
-- Data for Name: hypertable; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.hypertable (id, schema_name, table_name, associated_schema_name, associated_table_prefix, num_dimensions, chunk_sizing_func_schema, chunk_sizing_func_name, chunk_target_size, compression_state, compressed_hypertable_id, status) FROM stdin;
\.


--
-- Data for Name: chunk; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.chunk (id, hypertable_id, schema_name, table_name, compressed_chunk_id, dropped, status, osm_chunk, creation_time) FROM stdin;
\.


--
-- Data for Name: chunk_column_stats; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.chunk_column_stats (id, hypertable_id, chunk_id, column_name, range_start, range_end, valid) FROM stdin;
\.


--
-- Data for Name: dimension; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.dimension (id, hypertable_id, column_name, column_type, aligned, num_slices, partitioning_func_schema, partitioning_func, interval_length, compress_interval_length, integer_now_func_schema, integer_now_func) FROM stdin;
\.


--
-- Data for Name: dimension_slice; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.dimension_slice (id, dimension_id, range_start, range_end) FROM stdin;
\.


--
-- Data for Name: chunk_constraint; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.chunk_constraint (chunk_id, dimension_slice_id, constraint_name, hypertable_constraint_name) FROM stdin;
\.


--
-- Data for Name: compression_chunk_size; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.compression_chunk_size (chunk_id, compressed_chunk_id, uncompressed_heap_size, uncompressed_toast_size, uncompressed_index_size, compressed_heap_size, compressed_toast_size, compressed_index_size, numrows_pre_compression, numrows_post_compression, numrows_frozen_immediately) FROM stdin;
\.


--
-- Data for Name: compression_settings; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.compression_settings (relid, compress_relid, segmentby, orderby, orderby_desc, orderby_nullsfirst, index) FROM stdin;
\.


--
-- Data for Name: continuous_agg; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_agg (mat_hypertable_id, raw_hypertable_id, parent_mat_hypertable_id, user_view_schema, user_view_name, partial_view_schema, partial_view_name, direct_view_schema, direct_view_name, materialized_only, finalized) FROM stdin;
\.


--
-- Data for Name: continuous_agg_migrate_plan; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_agg_migrate_plan (mat_hypertable_id, start_ts, end_ts, user_view_definition) FROM stdin;
\.


--
-- Data for Name: continuous_agg_migrate_plan_step; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_agg_migrate_plan_step (mat_hypertable_id, step_id, status, start_ts, end_ts, type, config) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_bucket_function; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_aggs_bucket_function (mat_hypertable_id, bucket_func, bucket_width, bucket_origin, bucket_offset, bucket_timezone, bucket_fixed_width) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_hypertable_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_aggs_hypertable_invalidation_log (hypertable_id, lowest_modified_value, greatest_modified_value) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_invalidation_threshold; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_aggs_invalidation_threshold (hypertable_id, watermark) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_materialization_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_aggs_materialization_invalidation_log (materialization_id, lowest_modified_value, greatest_modified_value) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_materialization_ranges; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_aggs_materialization_ranges (materialization_id, lowest_modified_value, greatest_modified_value) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_watermark; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.continuous_aggs_watermark (mat_hypertable_id, watermark) FROM stdin;
\.


--
-- Data for Name: metadata; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.metadata (key, value, include_in_telemetry) FROM stdin;
install_timestamp	2026-05-16 22:02:38.358573+00	t
timescaledb_version	2.22.0	f
exported_uuid	c9a52103-585f-4c11-9ac6-145e682ab846	t
\.


--
-- Data for Name: tablespace; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: tsuser
--

COPY _timescaledb_catalog.tablespace (id, hypertable_id, tablespace_name) FROM stdin;
\.


--
-- Data for Name: bgw_job; Type: TABLE DATA; Schema: _timescaledb_config; Owner: tsuser
--

COPY _timescaledb_config.bgw_job (id, application_name, schedule_interval, max_runtime, max_retries, retry_period, proc_schema, proc_name, owner, scheduled, fixed_schedule, initial_start, hypertable_id, config, check_schema, check_name, timezone) FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
12c6faa0-9c23-439a-90f7-a014f9eb9070	725d2f8c01272136afe8ad2eec3296e39b4c47ecfc984f62a4ed76e07b7cfed7	2026-05-03 10:01:47.186234+00	20260503100147	\N	\N	2026-05-03 10:01:47.069967+00	1
d1fe05f0-2cef-464b-a121-39c3bd1b395e	916a41271e4fa0bdfb9b695ecb66857fb8ecc97e2c1a487e251a8f1dde14dc45	2026-05-14 12:42:12.421824+00	20260514124212_dto	\N	\N	2026-05-14 12:42:12.417195+00	1
\.


--
-- Data for Name: cluster; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.cluster (cluster_id, name, created_at, cluster_location_id) FROM stdin;
1	Marseille-Zone-01	2026-05-19 11:42:35.212	1
\.


--
-- Data for Name: cluster_configuration; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.cluster_configuration (cluster_config_id, name, master, worker, consomation_per_master, consomation_per_worker, hardware_per_master, hardware_per_worker, pue, location_id, fan_id, fan_count, cpu_cooler_catalog_id, fan_catalog_id, load_profile_id) FROM stdin;
1	Config_Marseille-Zone-01	2	8	850	700	2×EPYC + 1×RTX, 256GB	2×EPYC + 1×RTX, 256GB	1.322	1	1	4	2	1	13
\.


--
-- Data for Name: cluster_location; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.cluster_location (location_id, name, location, env_factor, cluster_count, created_at, energy_cost_kwh) FROM stdin;
1	Marseille	Marseille Tech Hub	1.2	1	2026-05-19 11:42:35.203	0.18
\.


--
-- Data for Name: cpucooler_catalog; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.cpucooler_catalog (cpu_cooler_catalog_id, model_name, type, thermal_capacity) FROM stdin;
1	LIQUID_COOLING	WATER	500
2	AIR_HIGH_PERF	AIR	250
3	AIR_STANDARD	AIR	150
\.


--
-- Data for Name: fan; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.fan (fan_id, server_id, fan_catalog_id, fan_config_id, control_mode, status, speed_percent, created_at) FROM stdin;
1	1	1	1	AUTO	ON	20	2026-05-19 11:42:35.218
2	1	1	1	AUTO	ON	20	2026-05-19 11:42:35.22
3	1	1	1	AUTO	ON	20	2026-05-19 11:42:35.223
6	2	1	1	AUTO	ON	20	2026-05-19 11:42:35.241
7	2	1	1	AUTO	ON	20	2026-05-19 11:42:35.242
8	2	1	1	AUTO	ON	20	2026-05-19 11:42:35.244
11	3	1	1	AUTO	ON	20	2026-05-19 11:42:35.26
12	3	1	1	AUTO	ON	20	2026-05-19 11:42:35.263
13	4	1	1	AUTO	ON	20	2026-05-19 11:42:35.279
16	4	1	1	AUTO	ON	20	2026-05-19 11:42:35.286
17	5	1	1	AUTO	ON	20	2026-05-19 11:42:35.302
18	5	1	1	AUTO	ON	20	2026-05-19 11:42:35.305
21	6	1	1	AUTO	ON	20	2026-05-19 11:42:35.328
22	6	1	1	AUTO	ON	20	2026-05-19 11:42:35.33
23	6	1	1	AUTO	ON	20	2026-05-19 11:42:35.332
26	7	1	1	AUTO	ON	20	2026-05-19 11:42:35.35
27	7	1	1	AUTO	ON	20	2026-05-19 11:42:35.352
28	7	1	1	AUTO	ON	20	2026-05-19 11:42:35.354
31	8	1	1	AUTO	ON	20	2026-05-19 11:42:35.371
32	8	1	1	AUTO	ON	20	2026-05-19 11:42:35.374
33	9	1	1	AUTO	ON	20	2026-05-19 11:42:35.386
36	9	1	1	AUTO	ON	20	2026-05-19 11:42:35.392
37	10	1	1	AUTO	ON	20	2026-05-19 11:42:35.406
38	10	1	1	AUTO	ON	20	2026-05-19 11:42:35.409
30	8	1	1	AUTO	ON	1	2026-05-19 11:42:35.369
35	9	1	1	AUTO	ON	2	2026-05-19 11:42:35.39
39	10	1	1	AUTO	ON	4	2026-05-19 11:42:35.411
25	7	1	1	AUTO	ON	5	2026-05-19 11:42:35.348
5	2	1	1	AUTO	ON	0	2026-05-19 11:42:35.24
4	1	1	1	AUTO	ON	0	2026-05-19 11:42:35.226
10	3	1	1	AUTO	ON	0	2026-05-19 11:42:35.258
15	4	1	1	AUTO	ON	58	2026-05-19 11:42:35.284
19	5	1	1	AUTO	ON	0	2026-05-19 11:42:35.308
24	6	1	1	AUTO	ON	5	2026-05-19 11:42:35.335
14	4	1	1	AUTO	ON	57	2026-05-19 11:42:35.281
29	8	1	1	AUTO	ON	1	2026-05-19 11:42:35.367
34	9	1	1	AUTO	ON	1	2026-05-19 11:42:35.388
40	10	1	1	AUTO	ON	5	2026-05-19 11:42:35.414
20	5	1	1	AUTO	ON	0	2026-05-19 11:42:35.31
9	3	1	1	MANUAL	ON	0	2026-05-19 11:42:35.256
\.


--
-- Data for Name: fan_catalog; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.fan_catalog (fan_catalog_id, model_name, consomation) FROM stdin;
1	FAN_HIGH_PERF	1.5
2	FAN_STANDARD	0.8
3	FAN_ECO	0.4
\.


--
-- Data for Name: fan_configuration; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.fan_configuration (fan_id, name, consomation) FROM stdin;
1	Default_Auto_Regulation	0.8
\.


--
-- Data for Name: load_profile; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.load_profile (id, name, hour, expected_load_percent, target_temp_celsius, standard_fan_speed) FROM stdin;
1	Config_Auto_H00	0	15	60	MEDIUM
2	Config_Auto_H01	1	15	60	MEDIUM
3	Config_Auto_H02	2	15	60	MEDIUM
4	Config_Auto_H03	3	15	60	MEDIUM
5	Config_Auto_H04	4	15	60	MEDIUM
6	Config_Auto_H05	5	15	60	MEDIUM
7	Config_Auto_H06	6	15	60	MEDIUM
8	Config_Auto_H07	7	15	60	MEDIUM
9	Config_Auto_H08	8	20	60	MEDIUM
10	Config_Auto_H09	9	28	60	MEDIUM
11	Config_Auto_H10	10	35	60	MEDIUM
12	Config_Auto_H11	11	41	60	MEDIUM
13	Config_Auto_H12	12	46	60	MEDIUM
14	Config_Auto_H13	13	49	60	MEDIUM
15	Config_Auto_H14	14	50	60	MEDIUM
16	Config_Auto_H15	15	49	60	MEDIUM
17	Config_Auto_H16	16	46	60	MEDIUM
18	Config_Auto_H17	17	41	60	MEDIUM
19	Config_Auto_H18	18	35	60	MEDIUM
20	Config_Auto_H19	19	28	60	MEDIUM
21	Config_Auto_H20	20	20	60	MEDIUM
22	Config_Auto_H21	21	15	60	MEDIUM
23	Config_Auto_H22	22	15	60	MEDIUM
24	Config_Auto_H23	23	15	60	MEDIUM
\.


--
-- Data for Name: sensor; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.sensor (sensor_id, server_id, sensor_type, unit, last_value, created_at) FROM stdin;
21	5	LOAD	%	38.04	2026-05-19 11:42:35.313
24	5	FAN_SPEED_1	%	10	2026-05-19 11:42:35.32
30	6	FAN_SPEED_2	%	16.25	2026-05-19 11:42:35.344
28	6	TOTAL_POWER	W	255.28	2026-05-19 11:42:35.34
27	6	CPU_TEMP	°C	40.16	2026-05-19 11:42:35.338
29	6	FAN_SPEED_1	%	16.25	2026-05-19 11:42:35.342
26	6	LOAD	%	38.04	2026-05-19 11:42:35.337
33	7	TOTAL_POWER	W	255.28	2026-05-19 11:42:35.36
34	7	FAN_SPEED_1	%	16.25	2026-05-19 11:42:35.362
35	7	FAN_SPEED_2	%	16.25	2026-05-19 11:42:35.363
32	7	CPU_TEMP	°C	40.16	2026-05-19 11:42:35.358
31	7	LOAD	%	38.04	2026-05-19 11:42:35.356
38	8	TOTAL_POWER	W	251.83	2026-05-19 11:42:35.379
36	8	LOAD	%	38.04	2026-05-19 11:42:35.376
39	8	FAN_SPEED_1	%	10.5	2026-05-19 11:42:35.381
40	8	FAN_SPEED_2	%	10.5	2026-05-19 11:42:35.382
37	8	CPU_TEMP	°C	41.14	2026-05-19 11:42:35.377
43	9	TOTAL_POWER	W	251.98	2026-05-19 11:42:35.399
44	9	FAN_SPEED_1	%	10.75	2026-05-19 11:42:35.401
45	9	FAN_SPEED_2	%	10.75	2026-05-19 11:42:35.403
41	9	LOAD	%	38.04	2026-05-19 11:42:35.394
42	9	CPU_TEMP	°C	41.09	2026-05-19 11:42:35.396
48	10	TOTAL_POWER	W	252.88	2026-05-19 11:42:35.423
49	10	FAN_SPEED_1	%	12.25	2026-05-19 11:42:35.425
47	10	CPU_TEMP	°C	40.84	2026-05-19 11:42:35.419
50	10	FAN_SPEED_2	%	12.25	2026-05-19 11:42:35.427
46	10	LOAD	%	38.04	2026-05-19 11:42:35.417
3	1	TOTAL_POWER	W	168.6	2026-05-19 11:42:35.233
2	1	CPU_TEMP	°C	27.03	2026-05-19 11:42:35.232
5	1	FAN_SPEED_2	%	15	2026-05-19 11:42:35.236
4	1	FAN_SPEED_1	%	15	2026-05-19 11:42:35.235
1	1	LOAD	%	12	2026-05-19 11:42:35.229
7	2	CPU_TEMP	°C	27.03	2026-05-19 11:42:35.246
10	2	FAN_SPEED_2	%	15	2026-05-19 11:42:35.251
9	2	FAN_SPEED_1	%	15	2026-05-19 11:42:35.249
8	2	TOTAL_POWER	W	168.6	2026-05-19 11:42:35.247
6	2	LOAD	%	12	2026-05-19 11:42:35.245
11	3	LOAD	%	38.04	2026-05-19 11:42:35.265
15	3	FAN_SPEED_2	%	10	2026-05-19 11:42:35.275
14	3	FAN_SPEED_1	%	10	2026-05-19 11:42:35.273
13	3	TOTAL_POWER	W	251.53	2026-05-19 11:42:35.27
12	3	CPU_TEMP	°C	56.22	2026-05-19 11:42:35.267
19	4	FAN_SPEED_1	%	38.75	2026-05-19 11:42:35.295
18	4	TOTAL_POWER	W	268.78	2026-05-19 11:42:35.292
20	4	FAN_SPEED_2	%	38.75	2026-05-19 11:42:35.297
16	4	LOAD	%	38.04	2026-05-19 11:42:35.288
17	4	CPU_TEMP	°C	36.33	2026-05-19 11:42:35.29
23	5	TOTAL_POWER	W	251.53	2026-05-19 11:42:35.317
25	5	FAN_SPEED_2	%	10	2026-05-19 11:42:35.322
22	5	CPU_TEMP	°C	41.22	2026-05-19 11:42:35.315
\.


--
-- Data for Name: sensor_data; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.sensor_data (id, "time", sensor_id, value) FROM stdin;
1	2026-05-18 00:00:00	11	20
2	2026-05-18 00:00:00	6	12
3	2026-05-18 00:00:00	46	20
4	2026-05-18 00:00:00	41	20
5	2026-05-18 00:00:00	1	12
6	2026-05-18 00:00:00	36	20
7	2026-05-18 00:00:00	31	20
8	2026-05-18 00:00:00	16	20
9	2026-05-18 00:00:00	26	20
10	2026-05-18 00:00:00	21	20
11	2026-05-18 00:00:00	12	28.33
12	2026-05-18 00:00:00	37	28.35
13	2026-05-18 00:00:00	7	24.33
14	2026-05-18 00:00:00	42	28.44
15	2026-05-18 00:00:00	47	28.25
16	2026-05-18 00:00:00	13	198
17	2026-05-18 00:00:00	2	24.36
18	2026-05-18 00:00:00	38	198
19	2026-05-18 00:00:00	22	28.32
20	2026-05-18 00:00:00	27	28.24
21	2026-05-18 00:00:00	17	28.39
22	2026-05-18 00:00:00	8	171.6
23	2026-05-18 00:00:00	32	28.28
24	2026-05-18 00:00:00	43	198
25	2026-05-18 00:00:00	48	198
26	2026-05-18 00:00:00	39	20
27	2026-05-18 00:00:00	14	20
28	2026-05-18 00:00:00	3	171.6
29	2026-05-18 00:00:00	44	20
30	2026-05-18 00:00:00	49	20
31	2026-05-18 00:00:00	9	20
32	2026-05-18 00:00:00	28	198
33	2026-05-18 00:00:00	23	198
34	2026-05-18 00:00:00	40	20
35	2026-05-18 00:00:00	15	20
36	2026-05-18 00:00:00	18	198
37	2026-05-18 00:00:00	33	198
38	2026-05-18 00:00:00	45	20
39	2026-05-18 00:00:00	10	20
40	2026-05-18 00:00:00	4	20
41	2026-05-18 00:00:00	19	20
42	2026-05-18 00:00:00	29	20
43	2026-05-18 00:00:00	24	20
44	2026-05-18 00:00:00	50	20
45	2026-05-18 00:00:00	34	20
46	2026-05-18 00:00:00	5	20
47	2026-05-18 00:00:00	20	20
48	2026-05-18 00:00:00	30	20
49	2026-05-18 00:00:00	25	20
50	2026-05-18 00:00:00	35	20
51	2026-05-18 02:00:00	3	168.6
52	2026-05-18 02:00:00	10	20
53	2026-05-18 02:00:00	16	20
54	2026-05-18 02:00:00	23	195
55	2026-05-18 02:00:00	31	20
56	2026-05-18 02:00:00	38	195
58	2026-05-18 02:00:00	14	15
57	2026-05-18 02:00:00	41	20
59	2026-05-18 02:00:00	46	20
60	2026-05-18 02:00:00	28	195
61	2026-05-18 02:00:00	9	20
62	2026-05-18 02:00:00	32	28.45
63	2026-05-18 02:00:00	21	20
64	2026-05-18 02:00:00	39	15
65	2026-05-18 02:00:00	1	12
66	2026-05-18 02:00:00	47	29.1
67	2026-05-18 02:00:00	15	15
68	2026-05-18 02:00:00	26	20
69	2026-05-18 02:00:00	17	28.98
70	2026-05-18 02:00:00	6	12
71	2026-05-18 02:00:00	33	198
72	2026-05-18 02:00:00	22	29.07
73	2026-05-18 02:00:00	40	15
74	2026-05-18 02:00:00	42	29.06
75	2026-05-18 02:00:00	7	24.19
76	2026-05-18 02:00:00	34	20
77	2026-05-18 02:00:00	24	15
78	2026-05-18 02:00:00	36	20
79	2026-05-18 02:00:00	11	20
80	2026-05-18 02:00:00	2	24.82
81	2026-05-18 02:00:00	27	29.07
82	2026-05-18 02:00:00	48	195
83	2026-05-18 02:00:00	18	195
84	2026-05-18 02:00:00	43	195
85	2026-05-18 02:00:00	12	29.04
86	2026-05-18 02:00:00	8	171.6
87	2026-05-18 02:00:00	25	15
88	2026-05-18 02:00:00	35	20
89	2026-05-18 02:00:00	37	29.1
90	2026-05-18 02:00:00	4	15
91	2026-05-18 02:00:00	49	15
92	2026-05-18 02:00:00	29	15
93	2026-05-18 02:00:00	19	15
94	2026-05-18 02:00:00	44	15
95	2026-05-18 02:00:00	13	195
96	2026-05-18 02:00:00	5	15
97	2026-05-18 02:00:00	50	15
98	2026-05-18 02:00:00	30	15
99	2026-05-18 02:00:00	45	15
100	2026-05-18 02:00:00	20	15
101	2026-05-18 03:00:00	5	15
104	2026-05-18 03:00:00	9	20
103	2026-05-18 03:00:00	20	15
102	2026-05-18 03:00:00	14	10
105	2026-05-18 03:00:00	31	20
106	2026-05-18 03:00:00	46	20
107	2026-05-18 03:00:00	41	20
108	2026-05-18 03:00:00	30	15
109	2026-05-18 03:00:00	23	195
110	2026-05-18 03:00:00	38	195
111	2026-05-18 03:00:00	6	12
112	2026-05-18 03:00:00	1	12
113	2026-05-18 03:00:00	47	28.85
114	2026-05-18 03:00:00	42	28.98
115	2026-05-18 03:00:00	28	195
116	2026-05-18 03:00:00	17	28.93
117	2026-05-18 03:00:00	15	10
118	2026-05-18 03:00:00	7	24.21
119	2026-05-18 03:00:00	21	20
120	2026-05-18 03:00:00	39	15
121	2026-05-18 03:00:00	32	28.38
122	2026-05-18 03:00:00	48	195
123	2026-05-18 03:00:00	43	195
124	2026-05-18 03:00:00	8	171.6
125	2026-05-18 03:00:00	22	28.88
126	2026-05-18 03:00:00	40	15
127	2026-05-18 03:00:00	2	24.95
128	2026-05-18 03:00:00	49	15
129	2026-05-18 03:00:00	44	15
130	2026-05-18 03:00:00	26	20
131	2026-05-18 03:00:00	18	195
132	2026-05-18 03:00:00	11	20
133	2026-05-18 03:00:00	10	20
134	2026-05-18 03:00:00	33	198
135	2026-05-18 03:00:00	50	15
136	2026-05-18 03:00:00	24	15
137	2026-05-18 03:00:00	36	20
145	2026-05-18 03:00:00	37	29.03
155	2026-05-18 04:00:00	23	192
166	2026-05-18 04:00:00	25	10
177	2026-05-18 04:00:00	21	20
187	2026-05-18 04:00:00	22	29.52
197	2026-05-18 04:00:00	24	10
205	2026-05-18 05:00:00	25	10
212	2026-05-18 05:00:00	21	20
220	2026-05-18 05:00:00	22	29.6
225	2026-05-18 05:00:00	24	10
233	2026-05-18 05:00:00	23	192
259	2026-05-18 06:00:00	46	20
280	2026-05-18 06:00:00	47	28.98
292	2026-05-18 06:00:00	48	195
299	2026-05-18 06:00:00	49	15
300	2026-05-18 06:00:00	50	15
305	2026-05-18 07:00:00	4	15
312	2026-05-18 07:00:00	3	168.6
322	2026-05-18 07:00:00	1	12
331	2026-05-18 07:00:00	2	24.89
346	2026-05-18 07:00:00	5	15
355	2026-05-18 08:00:00	23	192
367	2026-05-18 08:00:00	25	10
379	2026-05-18 08:00:00	21	20
390	2026-05-18 08:00:00	22	29.61
395	2026-05-18 08:00:00	24	10
405	2026-05-18 09:00:00	23	192
412	2026-05-18 09:00:00	25	10
422	2026-05-18 09:00:00	21	20
434	2026-05-18 09:00:00	22	29.52
442	2026-05-18 09:00:00	24	10
458	2026-05-18 10:00:00	29	15
470	2026-05-18 10:00:00	28	195
482	2026-05-18 10:00:00	26	20
492	2026-05-18 10:00:00	30	15
499	2026-05-18 10:00:00	27	29.04
503	2026-05-18 11:00:00	11	20
521	2026-05-18 11:00:00	12	29.55
534	2026-05-18 11:00:00	14	10
542	2026-05-18 11:00:00	13	192
549	2026-05-18 11:00:00	15	10
1551	2026-05-19 08:00:00	2	24.93
1562	2026-05-19 08:00:00	5	15
1578	2026-05-19 08:00:00	4	15
1588	2026-05-19 08:00:00	3	168.6
1597	2026-05-19 08:00:00	1	12
1607	2026-05-19 09:00:00	26	20
1612	2026-05-19 09:00:00	30	15
1620	2026-05-19 09:00:00	27	29.02
1626	2026-05-19 09:00:00	29	15
1634	2026-05-19 09:00:00	28	195
1656	2026-05-19 10:00:00	48	192
1663	2026-05-19 10:00:00	49	10
1671	2026-05-19 10:00:00	46	20
1678	2026-05-19 10:00:00	47	29.49
1688	2026-05-19 10:00:00	50	10
1709	2026-05-19 11:00:00	43	192
1718	2026-05-19 11:00:00	44	10
1729	2026-05-19 11:00:00	45	10
1740	2026-05-19 11:00:00	41	20
1747	2026-05-19 11:00:00	42	29.72
1755	2026-05-19 12:00:00	24	10
1765	2026-05-19 12:00:00	23	277.8
1775	2026-05-19 12:00:00	25	10
1785	2026-05-19 12:00:00	21	46
1795	2026-05-19 12:00:00	22	43.28
1803	2026-05-19 13:00:00	30	19.75
1820	2026-05-19 13:00:00	27	28.35
1833	2026-05-19 13:00:00	29	19.75
1842	2026-05-19 13:00:00	28	197.85
1850	2026-05-19 13:00:00	26	20
1855	2026-05-19 14:00:00	7	24.75
1869	2026-05-19 14:00:00	6	12
1879	2026-05-19 14:00:00	8	168.6
1894	2026-05-19 14:00:00	10	15
1900	2026-05-19 14:00:00	9	15
1901	2026-05-19 15:00:00	1	12
1913	2026-05-19 15:00:00	2	24.9
1924	2026-05-19 15:00:00	5	15
1938	2026-05-19 15:00:00	4	15
1947	2026-05-19 15:00:00	3	168.6
1953	2026-05-19 16:00:00	20	10
1961	2026-05-19 16:00:00	17	29.73
1970	2026-05-19 16:00:00	18	192
1976	2026-05-19 16:00:00	16	20
1985	2026-05-19 16:00:00	19	10
2010	2026-05-19 17:00:00	46	20
2024	2026-05-19 17:00:00	47	29.62
2038	2026-05-19 17:00:00	50	10
2046	2026-05-19 17:00:00	48	192
2050	2026-05-19 17:00:00	49	10
2557	2026-05-20 04:00:00	14	10
2565	2026-05-20 04:00:00	11	40
2575	2026-05-20 04:00:00	13	258
2583	2026-05-20 04:00:00	15	10
2595	2026-05-20 04:00:00	12	40.21
2607	2026-05-20 05:00:00	30	16.25
2619	2026-05-20 05:00:00	27	38.94
2633	2026-05-20 05:00:00	29	16.25
2642	2026-05-20 05:00:00	26	40
2646	2026-05-20 05:00:00	28	261.75
2657	2026-05-20 06:00:00	27	38.98
2670	2026-05-20 06:00:00	29	16.25
2676	2026-05-20 06:00:00	26	40
2688	2026-05-20 06:00:00	28	261.75
2697	2026-05-20 06:00:00	30	16.25
2704	2026-05-20 07:00:00	16	40
2714	2026-05-20 07:00:00	19	12.5
2724	2026-05-20 07:00:00	20	12.5
2733	2026-05-20 07:00:00	17	39.5
2744	2026-05-20 07:00:00	18	259.5
2755	2026-05-20 08:00:00	21	40
2770	2026-05-20 08:00:00	22	39.83
2783	2026-05-20 08:00:00	24	10.75
2790	2026-05-20 08:00:00	23	258.45
2799	2026-05-20 08:00:00	25	10.75
2802	2026-05-20 09:00:00	9	15
2816	2026-05-20 09:00:00	6	12
2827	2026-05-20 09:00:00	7	25
2836	2026-05-20 09:00:00	8	168.6
2847	2026-05-20 09:00:00	10	15
2852	2026-05-20 10:00:00	13	258
2867	2026-05-20 10:00:00	15	10
2879	2026-05-20 10:00:00	12	55.05
2891	2026-05-20 10:00:00	14	10
2898	2026-05-20 10:00:00	11	40
2905	2026-05-20 11:00:00	12	55.21
2913	2026-05-20 11:00:00	14	10
2922	2026-05-20 11:00:00	11	40
2929	2026-05-20 11:00:00	13	258
2937	2026-05-20 11:00:00	15	10
2958	2026-05-20 12:00:00	49	12
2968	2026-05-20 12:00:00	47	66.9
2981	2026-05-20 12:00:00	50	12
2992	2026-05-20 12:00:00	46	92
138	2026-05-18 03:00:00	4	15
144	2026-05-18 03:00:00	3	168.6
158	2026-05-18 04:00:00	31	20
169	2026-05-18 04:00:00	35	20
179	2026-05-18 04:00:00	32	28.4
185	2026-05-18 04:00:00	33	198
195	2026-05-18 04:00:00	34	20
204	2026-05-18 05:00:00	19	15
214	2026-05-18 05:00:00	17	28.91
231	2026-05-18 05:00:00	18	195
241	2026-05-18 05:00:00	16	20
248	2026-05-18 05:00:00	20	15
254	2026-05-18 06:00:00	18	192
269	2026-05-18 06:00:00	16	20
282	2026-05-18 06:00:00	19	10
291	2026-05-18 06:00:00	20	10
297	2026-05-18 06:00:00	17	29.7
301	2026-05-18 07:00:00	12	29.65
320	2026-05-18 07:00:00	14	10
335	2026-05-18 07:00:00	13	192
345	2026-05-18 07:00:00	15	10
350	2026-05-18 07:00:00	11	20
351	2026-05-18 08:00:00	5	15
361	2026-05-18 08:00:00	4	15
376	2026-05-18 08:00:00	3	168.6
391	2026-05-18 08:00:00	1	12
398	2026-05-18 08:00:00	2	25.01
410	2026-05-18 09:00:00	18	192
420	2026-05-18 09:00:00	16	20
431	2026-05-18 09:00:00	19	10
440	2026-05-18 09:00:00	20	10
448	2026-05-18 09:00:00	17	29.5
454	2026-05-18 10:00:00	18	192
465	2026-05-18 10:00:00	16	20
474	2026-05-18 10:00:00	19	10
488	2026-05-18 10:00:00	20	10
497	2026-05-18 10:00:00	17	29.51
502	2026-05-18 11:00:00	8	168.6
511	2026-05-18 11:00:00	10	15
519	2026-05-18 11:00:00	9	15
525	2026-05-18 11:00:00	7	24.94
532	2026-05-18 11:00:00	6	12
1552	2026-05-19 08:00:00	20	10
1561	2026-05-19 08:00:00	17	29.64
1569	2026-05-19 08:00:00	18	192
1577	2026-05-19 08:00:00	16	20
1587	2026-05-19 08:00:00	19	10
1609	2026-05-19 09:00:00	47	29.55
1616	2026-05-19 09:00:00	50	10
1630	2026-05-19 09:00:00	48	192
1641	2026-05-19 09:00:00	49	10
1648	2026-05-19 09:00:00	46	20
1652	2026-05-19 10:00:00	9	15
1666	2026-05-19 10:00:00	7	24.99
1679	2026-05-19 10:00:00	6	12
1689	2026-05-19 10:00:00	8	168.6
1696	2026-05-19 10:00:00	10	15
1708	2026-05-19 11:00:00	24	10
1716	2026-05-19 11:00:00	23	192
1724	2026-05-19 11:00:00	25	10
1732	2026-05-19 11:00:00	21	20
1739	2026-05-19 11:00:00	22	29.49
1754	2026-05-19 12:00:00	34	15
1767	2026-05-19 12:00:00	31	46
1773	2026-05-19 12:00:00	35	15
1780	2026-05-19 12:00:00	32	42.43
1789	2026-05-19 12:00:00	33	280.8
1809	2026-05-19 13:00:00	48	194.85
1811	2026-05-19 13:00:00	49	14.75
1821	2026-05-19 13:00:00	46	20
1828	2026-05-19 13:00:00	47	29
1837	2026-05-19 13:00:00	50	14.75
1858	2026-05-19 14:00:00	47	29.59
1862	2026-05-19 14:00:00	50	10
1871	2026-05-19 14:00:00	48	192
1883	2026-05-19 14:00:00	49	10
1892	2026-05-19 14:00:00	46	20
1908	2026-05-19 15:00:00	42	29.62
1916	2026-05-19 15:00:00	43	192
1931	2026-05-19 15:00:00	44	10
1941	2026-05-19 15:00:00	45	10
1948	2026-05-19 15:00:00	41	20
1954	2026-05-19 16:00:00	12	29.46
1969	2026-05-19 16:00:00	14	10
1984	2026-05-19 16:00:00	13	192
1993	2026-05-19 16:00:00	15	10
2000	2026-05-19 16:00:00	11	20
2001	2026-05-19 17:00:00	2	25.01
2013	2026-05-19 17:00:00	5	15
2022	2026-05-19 17:00:00	4	15
2028	2026-05-19 17:00:00	3	168.6
2036	2026-05-19 17:00:00	1	12
2558	2026-05-20 04:00:00	41	40
2562	2026-05-20 04:00:00	42	40
2572	2026-05-20 04:00:00	43	258
2579	2026-05-20 04:00:00	44	10
2588	2026-05-20 04:00:00	45	10
2610	2026-05-20 05:00:00	41	40
2623	2026-05-20 05:00:00	42	39.96
2630	2026-05-20 05:00:00	43	258.3
2636	2026-05-20 05:00:00	44	10.5
2644	2026-05-20 05:00:00	45	10.5
2655	2026-05-20 06:00:00	38	258.15
2664	2026-05-20 06:00:00	36	40
2674	2026-05-20 06:00:00	39	10.25
2684	2026-05-20 06:00:00	40	10.25
2694	2026-05-20 06:00:00	37	40.17
2708	2026-05-20 07:00:00	34	15
2712	2026-05-20 07:00:00	35	15
2722	2026-05-20 07:00:00	32	39.29
2728	2026-05-20 07:00:00	31	40
2737	2026-05-20 07:00:00	33	261
2760	2026-05-20 08:00:00	44	10.5
2767	2026-05-20 08:00:00	45	10.5
2775	2026-05-20 08:00:00	41	40
2788	2026-05-20 08:00:00	42	39.97
2798	2026-05-20 08:00:00	43	258.3
2805	2026-05-20 09:00:00	14	10
2812	2026-05-20 09:00:00	11	40
2823	2026-05-20 09:00:00	13	258
2835	2026-05-20 09:00:00	15	10
2846	2026-05-20 09:00:00	12	54.96
2854	2026-05-20 10:00:00	24	10
2868	2026-05-20 10:00:00	23	258
2880	2026-05-20 10:00:00	25	10
2893	2026-05-20 10:00:00	21	40
2899	2026-05-20 10:00:00	22	40.2
2901	2026-05-20 11:00:00	4	15
2911	2026-05-20 11:00:00	3	168.6
2927	2026-05-20 11:00:00	2	24.75
2941	2026-05-20 11:00:00	5	15
2947	2026-05-20 11:00:00	1	12
2954	2026-05-20 12:00:00	19	38.75
2961	2026-05-20 12:00:00	20	38.75
2969	2026-05-20 12:00:00	17	58.76
2975	2026-05-20 12:00:00	18	446.85
139	2026-05-18 03:00:00	45	15
157	2026-05-18 04:00:00	37	29.62
164	2026-05-18 04:00:00	38	192
175	2026-05-18 04:00:00	39	10
189	2026-05-18 04:00:00	40	10
198	2026-05-18 04:00:00	36	20
206	2026-05-18 05:00:00	35	15
218	2026-05-18 05:00:00	32	29.02
227	2026-05-18 05:00:00	33	195
235	2026-05-18 05:00:00	34	15
243	2026-05-18 05:00:00	31	20
257	2026-05-18 06:00:00	33	195
268	2026-05-18 06:00:00	34	15
273	2026-05-18 06:00:00	31	20
283	2026-05-18 06:00:00	35	15
290	2026-05-18 06:00:00	32	28.98
306	2026-05-18 07:00:00	31	20
316	2026-05-18 07:00:00	35	15
328	2026-05-18 07:00:00	32	29.09
339	2026-05-18 07:00:00	33	195
347	2026-05-18 07:00:00	34	15
354	2026-05-18 08:00:00	16	20
364	2026-05-18 08:00:00	19	10
370	2026-05-18 08:00:00	20	10
381	2026-05-18 08:00:00	17	29.55
396	2026-05-18 08:00:00	18	192
404	2026-05-18 09:00:00	13	192
416	2026-05-18 09:00:00	15	10
426	2026-05-18 09:00:00	11	20
438	2026-05-18 09:00:00	12	29.51
445	2026-05-18 09:00:00	14	10
459	2026-05-18 10:00:00	38	192
466	2026-05-18 10:00:00	39	10
478	2026-05-18 10:00:00	40	10
484	2026-05-18 10:00:00	36	20
494	2026-05-18 10:00:00	37	29.47
504	2026-05-18 11:00:00	28	195
512	2026-05-18 11:00:00	26	20
520	2026-05-18 11:00:00	30	15
526	2026-05-18 11:00:00	27	28.88
533	2026-05-18 11:00:00	29	15
1553	2026-05-19 08:00:00	25	10
1566	2026-05-19 08:00:00	21	20
1575	2026-05-19 08:00:00	22	29.44
1584	2026-05-19 08:00:00	24	10
1590	2026-05-19 08:00:00	23	192
1608	2026-05-19 09:00:00	45	10
1611	2026-05-19 09:00:00	41	20
1623	2026-05-19 09:00:00	42	29.6
1632	2026-05-19 09:00:00	43	192
1639	2026-05-19 09:00:00	44	10
1655	2026-05-19 10:00:00	36	20
1662	2026-05-19 10:00:00	37	29.45
1670	2026-05-19 10:00:00	38	192
1677	2026-05-19 10:00:00	39	10
1687	2026-05-19 10:00:00	40	10
1704	2026-05-19 11:00:00	36	20
1713	2026-05-19 11:00:00	37	29.63
1723	2026-05-19 11:00:00	38	192
1728	2026-05-19 11:00:00	39	10
1737	2026-05-19 11:00:00	40	10
1760	2026-05-19 12:00:00	36	46
1771	2026-05-19 12:00:00	37	43.33
1784	2026-05-19 12:00:00	38	277.8
1793	2026-05-19 12:00:00	39	10
1800	2026-05-19 12:00:00	40	10
1801	2026-05-19 13:00:00	3	168.6
1815	2026-05-19 13:00:00	1	12
1825	2026-05-19 13:00:00	2	24.75
1836	2026-05-19 13:00:00	5	15
1846	2026-05-19 13:00:00	4	15
1853	2026-05-19 14:00:00	25	10
1867	2026-05-19 14:00:00	21	20
1875	2026-05-19 14:00:00	22	29.46
1881	2026-05-19 14:00:00	24	10
1890	2026-05-19 14:00:00	23	192
1907	2026-05-19 15:00:00	35	15
1918	2026-05-19 15:00:00	32	28.92
1927	2026-05-19 15:00:00	33	195
1943	2026-05-19 15:00:00	34	15
1949	2026-05-19 15:00:00	31	20
1952	2026-05-19 16:00:00	8	168.6
1964	2026-05-19 16:00:00	10	15
1980	2026-05-19 16:00:00	9	15
1991	2026-05-19 16:00:00	7	24.99
1999	2026-05-19 16:00:00	6	12
2003	2026-05-19 17:00:00	10	15
2012	2026-05-19 17:00:00	9	15
2021	2026-05-19 17:00:00	7	24.72
2035	2026-05-19 17:00:00	6	12
2045	2026-05-19 17:00:00	8	168.6
2559	2026-05-20 04:00:00	37	40.08
2570	2026-05-20 04:00:00	38	258
2586	2026-05-20 04:00:00	36	40
2597	2026-05-20 04:00:00	39	10
2600	2026-05-20 04:00:00	40	10
2601	2026-05-20 05:00:00	5	15
2614	2026-05-20 05:00:00	1	12
2627	2026-05-20 05:00:00	4	15
2639	2026-05-20 05:00:00	3	168.6
2648	2026-05-20 05:00:00	2	24.96
2653	2026-05-20 06:00:00	11	40
2661	2026-05-20 06:00:00	13	258
2671	2026-05-20 06:00:00	15	10
2678	2026-05-20 06:00:00	12	40.23
2686	2026-05-20 06:00:00	14	10
2709	2026-05-20 07:00:00	45	10.5
2715	2026-05-20 07:00:00	41	40
2725	2026-05-20 07:00:00	42	40.05
2732	2026-05-20 07:00:00	43	258.3
2741	2026-05-20 07:00:00	44	10.5
2757	2026-05-20 08:00:00	34	15
2764	2026-05-20 08:00:00	35	15
2772	2026-05-20 08:00:00	32	39.13
2780	2026-05-20 08:00:00	31	40
2785	2026-05-20 08:00:00	33	261
2808	2026-05-20 09:00:00	48	259.35
2817	2026-05-20 09:00:00	49	12.25
2831	2026-05-20 09:00:00	47	39.65
2839	2026-05-20 09:00:00	50	12.25
2848	2026-05-20 09:00:00	46	40
2853	2026-05-20 10:00:00	16	40
2864	2026-05-20 10:00:00	19	25.5
2874	2026-05-20 10:00:00	20	25.5
2882	2026-05-20 10:00:00	17	37.28
2894	2026-05-20 10:00:00	18	267.3
2903	2026-05-20 11:00:00	28	261.75
2919	2026-05-20 11:00:00	30	16.25
2931	2026-05-20 11:00:00	27	38.87
2939	2026-05-20 11:00:00	29	16.25
2946	2026-05-20 11:00:00	26	40
2955	2026-05-20 12:00:00	23	429.6
2966	2026-05-20 12:00:00	25	10
2978	2026-05-20 12:00:00	21	92
2990	2026-05-20 12:00:00	22	67.51
2996	2026-05-20 12:00:00	24	10
140	2026-05-18 03:00:00	16	20
148	2026-05-18 03:00:00	19	15
156	2026-05-18 04:00:00	29	15
163	2026-05-18 04:00:00	28	195
173	2026-05-18 04:00:00	26	20
184	2026-05-18 04:00:00	30	15
193	2026-05-18 04:00:00	27	29.06
208	2026-05-18 05:00:00	37	29.55
217	2026-05-18 05:00:00	38	192
228	2026-05-18 05:00:00	39	10
236	2026-05-18 05:00:00	40	10
244	2026-05-18 05:00:00	36	20
256	2026-05-18 06:00:00	26	20
264	2026-05-18 06:00:00	30	15
275	2026-05-18 06:00:00	27	28.98
285	2026-05-18 06:00:00	29	15
294	2026-05-18 06:00:00	28	195
302	2026-05-18 07:00:00	28	195
319	2026-05-18 07:00:00	26	20
326	2026-05-18 07:00:00	30	15
336	2026-05-18 07:00:00	27	29.07
343	2026-05-18 07:00:00	29	15
357	2026-05-18 08:00:00	42	29.72
366	2026-05-18 08:00:00	43	192
373	2026-05-18 08:00:00	44	10
380	2026-05-18 08:00:00	45	10
387	2026-05-18 08:00:00	41	20
408	2026-05-18 09:00:00	50	15
419	2026-05-18 09:00:00	46	20
429	2026-05-18 09:00:00	47	28.95
439	2026-05-18 09:00:00	48	195
449	2026-05-18 09:00:00	49	15
455	2026-05-18 10:00:00	7	24.84
468	2026-05-18 10:00:00	6	12
481	2026-05-18 10:00:00	8	168.6
485	2026-05-18 10:00:00	10	15
495	2026-05-18 10:00:00	9	15
507	2026-05-18 11:00:00	33	195
514	2026-05-18 11:00:00	34	15
523	2026-05-18 11:00:00	31	20
529	2026-05-18 11:00:00	35	15
536	2026-05-18 11:00:00	32	29.06
1554	2026-05-19 08:00:00	7	24.74
1568	2026-05-19 08:00:00	6	12
1579	2026-05-19 08:00:00	8	168.6
1589	2026-05-19 08:00:00	10	15
1598	2026-05-19 08:00:00	9	15
1603	2026-05-19 09:00:00	15	10
1617	2026-05-19 09:00:00	11	20
1631	2026-05-19 09:00:00	12	29.72
1642	2026-05-19 09:00:00	14	10
1649	2026-05-19 09:00:00	13	192
1651	2026-05-19 10:00:00	3	168.6
1665	2026-05-19 10:00:00	1	12
1675	2026-05-19 10:00:00	2	24.98
1686	2026-05-19 10:00:00	5	15
1695	2026-05-19 10:00:00	4	15
1706	2026-05-19 11:00:00	26	20
1720	2026-05-19 11:00:00	30	15
1734	2026-05-19 11:00:00	27	28.88
1743	2026-05-19 11:00:00	29	15
1749	2026-05-19 11:00:00	28	195
1751	2026-05-19 12:00:00	4	15
1761	2026-05-19 12:00:00	3	168.6
1769	2026-05-19 12:00:00	1	12
1782	2026-05-19 12:00:00	2	25
1791	2026-05-19 12:00:00	5	15
1810	2026-05-19 13:00:00	43	194.4
1819	2026-05-19 13:00:00	44	14
1832	2026-05-19 13:00:00	45	14
1843	2026-05-19 13:00:00	41	20
1849	2026-05-19 13:00:00	42	29.19
1854	2026-05-19 14:00:00	13	192
1865	2026-05-19 14:00:00	15	10
1877	2026-05-19 14:00:00	11	20
1886	2026-05-19 14:00:00	12	29.65
1895	2026-05-19 14:00:00	14	10
1906	2026-05-19 15:00:00	30	19.75
1910	2026-05-19 15:00:00	27	28.31
1920	2026-05-19 15:00:00	29	19.75
1930	2026-05-19 15:00:00	28	197.85
1942	2026-05-19 15:00:00	26	20
1955	2026-05-19 16:00:00	31	20
1968	2026-05-19 16:00:00	35	15
1983	2026-05-19 16:00:00	32	28.97
1994	2026-05-19 16:00:00	33	195
1998	2026-05-19 16:00:00	34	15
2002	2026-05-19 17:00:00	14	10
2011	2026-05-19 17:00:00	13	192
2020	2026-05-19 17:00:00	15	10
2029	2026-05-19 17:00:00	11	20
2037	2026-05-19 17:00:00	12	29.57
2560	2026-05-20 04:00:00	31	40
2566	2026-05-20 04:00:00	33	261
2576	2026-05-20 04:00:00	34	15
2585	2026-05-20 04:00:00	35	15
2594	2026-05-20 04:00:00	32	39.2
2605	2026-05-20 05:00:00	21	40
2617	2026-05-20 05:00:00	22	40
2628	2026-05-20 05:00:00	24	11.25
2641	2026-05-20 05:00:00	23	258.75
2649	2026-05-20 05:00:00	25	11.25
2651	2026-05-20 06:00:00	9	15
2667	2026-05-20 06:00:00	6	12
2683	2026-05-20 06:00:00	7	24.9
2693	2026-05-20 06:00:00	8	168.6
2700	2026-05-20 06:00:00	10	15
2703	2026-05-20 07:00:00	14	10
2711	2026-05-20 07:00:00	11	40
2721	2026-05-20 07:00:00	13	258
2727	2026-05-20 07:00:00	15	10
2736	2026-05-20 07:00:00	12	40.01
2759	2026-05-20 08:00:00	48	259.35
2765	2026-05-20 08:00:00	49	12.25
2773	2026-05-20 08:00:00	47	39.71
2781	2026-05-20 08:00:00	50	12.25
2789	2026-05-20 08:00:00	46	40
2804	2026-05-20 09:00:00	26	40
2811	2026-05-20 09:00:00	28	261.6
2819	2026-05-20 09:00:00	30	16
2824	2026-05-20 09:00:00	27	39.04
2834	2026-05-20 09:00:00	29	16
2860	2026-05-20 10:00:00	49	12
2870	2026-05-20 10:00:00	47	39.74
2883	2026-05-20 10:00:00	50	12
2895	2026-05-20 10:00:00	46	40
2900	2026-05-20 10:00:00	48	259.2
2906	2026-05-20 11:00:00	10	15
2914	2026-05-20 11:00:00	9	15
2923	2026-05-20 11:00:00	6	12
2930	2026-05-20 11:00:00	7	24.83
2938	2026-05-20 11:00:00	8	168.6
2957	2026-05-20 12:00:00	37	67.2
2967	2026-05-20 12:00:00	38	429.9
2980	2026-05-20 12:00:00	36	92
2993	2026-05-20 12:00:00	39	10.5
141	2026-05-18 03:00:00	27	28.94
147	2026-05-18 03:00:00	29	15
153	2026-05-18 04:00:00	14	10
162	2026-05-18 04:00:00	13	192
172	2026-05-18 04:00:00	15	10
183	2026-05-18 04:00:00	11	20
196	2026-05-18 04:00:00	12	29.71
201	2026-05-18 05:00:00	5	15
211	2026-05-18 05:00:00	3	168.6
224	2026-05-18 05:00:00	1	12
238	2026-05-18 05:00:00	2	24.74
246	2026-05-18 05:00:00	4	15
255	2026-05-18 06:00:00	24	10
267	2026-05-18 06:00:00	23	192
276	2026-05-18 06:00:00	25	10
284	2026-05-18 06:00:00	21	20
289	2026-05-18 06:00:00	22	29.64
310	2026-05-18 07:00:00	43	192
311	2026-05-18 07:00:00	44	10
321	2026-05-18 07:00:00	45	10
327	2026-05-18 07:00:00	41	20
337	2026-05-18 07:00:00	42	29.65
360	2026-05-18 08:00:00	46	20
375	2026-05-18 08:00:00	47	28.98
384	2026-05-18 08:00:00	48	195
393	2026-05-18 08:00:00	49	15
399	2026-05-18 08:00:00	50	15
402	2026-05-18 09:00:00	9	15
411	2026-05-18 09:00:00	7	24.98
421	2026-05-18 09:00:00	6	12
425	2026-05-18 09:00:00	8	168.6
435	2026-05-18 09:00:00	10	15
460	2026-05-18 10:00:00	46	20
467	2026-05-18 10:00:00	47	29.09
479	2026-05-18 10:00:00	50	15
487	2026-05-18 10:00:00	48	195
493	2026-05-18 10:00:00	49	15
508	2026-05-18 11:00:00	40	10
515	2026-05-18 11:00:00	36	20
527	2026-05-18 11:00:00	37	29.65
540	2026-05-18 11:00:00	38	192
546	2026-05-18 11:00:00	39	10
1555	2026-05-19 08:00:00	28	195
1567	2026-05-19 08:00:00	26	20
1576	2026-05-19 08:00:00	30	15
1585	2026-05-19 08:00:00	27	29.02
1595	2026-05-19 08:00:00	29	15
1605	2026-05-19 09:00:00	21	20
1618	2026-05-19 09:00:00	22	29.51
1628	2026-05-19 09:00:00	24	10
1640	2026-05-19 09:00:00	23	192
1647	2026-05-19 09:00:00	25	10
1658	2026-05-19 10:00:00	16	20
1664	2026-05-19 10:00:00	19	10
1674	2026-05-19 10:00:00	20	10
1685	2026-05-19 10:00:00	17	29.52
1694	2026-05-19 10:00:00	18	192
1710	2026-05-19 11:00:00	34	15
1717	2026-05-19 11:00:00	31	20
1725	2026-05-19 11:00:00	35	15
1738	2026-05-19 11:00:00	32	28.9
1745	2026-05-19 11:00:00	33	195
1756	2026-05-19 12:00:00	26	46
1764	2026-05-19 12:00:00	30	15
1777	2026-05-19 12:00:00	27	42.42
1788	2026-05-19 12:00:00	29	15
1798	2026-05-19 12:00:00	28	280.8
1805	2026-05-19 13:00:00	19	14.5
1813	2026-05-19 13:00:00	20	14.5
1823	2026-05-19 13:00:00	17	29.14
1827	2026-05-19 13:00:00	18	194.7
1835	2026-05-19 13:00:00	16	20
1859	2026-05-19 14:00:00	45	14
1870	2026-05-19 14:00:00	41	20
1884	2026-05-19 14:00:00	42	29.18
1893	2026-05-19 14:00:00	43	194.4
1897	2026-05-19 14:00:00	44	14
1905	2026-05-19 15:00:00	23	192
1911	2026-05-19 15:00:00	25	10
1923	2026-05-19 15:00:00	21	20
1929	2026-05-19 15:00:00	22	29.7
1937	2026-05-19 15:00:00	24	10
1959	2026-05-19 16:00:00	41	20
1965	2026-05-19 16:00:00	42	29.5
1974	2026-05-19 16:00:00	43	192
1981	2026-05-19 16:00:00	44	10
1989	2026-05-19 16:00:00	45	10
2007	2026-05-19 17:00:00	40	10
2019	2026-05-19 17:00:00	36	20
2031	2026-05-19 17:00:00	37	29.57
2043	2026-05-19 17:00:00	38	192
2049	2026-05-19 17:00:00	39	10
2982	2026-05-20 12:00:00	16	92
3007	2026-05-20 13:00:00	49	36
3016	2026-05-20 13:00:00	47	35.49
3026	2026-05-20 13:00:00	50	36
3038	2026-05-20 13:00:00	46	40
3044	2026-05-20 13:00:00	48	273.6
3548	2026-05-20 23:00:00	44	10.5
4001	2026-05-21 09:00:00	4	15
4011	2026-05-21 09:00:00	3	168.6
4016	2026-05-21 09:00:00	2	24.83
4024	2026-05-21 09:00:00	5	15
4028	2026-05-21 09:00:00	1	12
4057	2026-05-21 10:00:00	48	259.35
4065	2026-05-21 10:00:00	49	12.25
4075	2026-05-21 10:00:00	47	39.73
4081	2026-05-21 10:00:00	50	12.25
4093	2026-05-21 10:00:00	46	40
4108	2026-05-21 11:00:00	29	16
4109	2026-05-21 11:00:00	39	10.75
4117	2026-05-21 11:00:00	40	10.75
4121	2026-05-21 11:00:00	26	40
4127	2026-05-21 11:00:00	37	39.93
4134	2026-05-21 11:00:00	38	258.45
4135	2026-05-21 11:00:00	28	261.6
4145	2026-05-21 11:00:00	36	40
4148	2026-05-21 11:00:00	30	16
4150	2026-05-21 11:00:00	27	39
4151	2026-05-21 12:00:00	3	168.6
4153	2026-05-21 12:00:00	18	446.85
4165	2026-05-21 12:00:00	5	15
4166	2026-05-21 12:00:00	19	38.75
4177	2026-05-21 12:00:00	20	38.75
4178	2026-05-21 12:00:00	1	12
4187	2026-05-21 12:00:00	16	92
4188	2026-05-21 12:00:00	4	15
4196	2026-05-21 12:00:00	2	24.75
4197	2026-05-21 12:00:00	17	58.73
4204	2026-05-21 13:00:00	13	258
4207	2026-05-21 13:00:00	25	34
4216	2026-05-21 13:00:00	15	10
4219	2026-05-21 13:00:00	21	40
4223	2026-05-21 13:00:00	11	40
4227	2026-05-21 13:00:00	24	34
4231	2026-05-21 13:00:00	14	10
142	2026-05-18 03:00:00	12	29.57
149	2026-05-18 03:00:00	13	192
154	2026-05-18 04:00:00	20	15
165	2026-05-18 04:00:00	19	15
176	2026-05-18 04:00:00	17	29.09
186	2026-05-18 04:00:00	18	195
199	2026-05-18 04:00:00	16	20
202	2026-05-18 05:00:00	7	25
215	2026-05-18 05:00:00	8	168.6
229	2026-05-18 05:00:00	10	15
240	2026-05-18 05:00:00	9	15
247	2026-05-18 05:00:00	6	12
253	2026-05-18 06:00:00	15	10
266	2026-05-18 06:00:00	11	20
277	2026-05-18 06:00:00	12	29.71
287	2026-05-18 06:00:00	14	10
296	2026-05-18 06:00:00	13	192
303	2026-05-18 07:00:00	19	10
314	2026-05-18 07:00:00	20	10
324	2026-05-18 07:00:00	17	29.53
333	2026-05-18 07:00:00	18	192
342	2026-05-18 07:00:00	16	20
356	2026-05-18 08:00:00	38	192
362	2026-05-18 08:00:00	39	10
372	2026-05-18 08:00:00	40	10
377	2026-05-18 08:00:00	36	20
386	2026-05-18 08:00:00	37	29.47
409	2026-05-18 09:00:00	38	192
418	2026-05-18 09:00:00	39	10
430	2026-05-18 09:00:00	40	10
444	2026-05-18 09:00:00	36	20
450	2026-05-18 09:00:00	37	29.53
451	2026-05-18 10:00:00	4	15
462	2026-05-18 10:00:00	3	168.6
471	2026-05-18 10:00:00	1	12
476	2026-05-18 10:00:00	2	24.88
483	2026-05-18 10:00:00	5	15
509	2026-05-18 11:00:00	50	15
517	2026-05-18 11:00:00	48	195
530	2026-05-18 11:00:00	49	15
538	2026-05-18 11:00:00	46	20
543	2026-05-18 11:00:00	47	28.86
1556	2026-05-19 08:00:00	15	10
1563	2026-05-19 08:00:00	11	20
1572	2026-05-19 08:00:00	12	29.6
1583	2026-05-19 08:00:00	14	10
1593	2026-05-19 08:00:00	13	192
1606	2026-05-19 09:00:00	34	15
1614	2026-05-19 09:00:00	31	20
1622	2026-05-19 09:00:00	35	15
1633	2026-05-19 09:00:00	32	29.03
1644	2026-05-19 09:00:00	33	195
1659	2026-05-19 10:00:00	27	29.02
1673	2026-05-19 10:00:00	29	15
1683	2026-05-19 10:00:00	28	195
1693	2026-05-19 10:00:00	26	20
1700	2026-05-19 10:00:00	30	15
1701	2026-05-19 11:00:00	4	15
1714	2026-05-19 11:00:00	3	168.6
1731	2026-05-19 11:00:00	1	12
1741	2026-05-19 11:00:00	2	24.88
1748	2026-05-19 11:00:00	5	15
1753	2026-05-19 12:00:00	8	168.6
1763	2026-05-19 12:00:00	10	15
1774	2026-05-19 12:00:00	9	15
1781	2026-05-19 12:00:00	7	24.85
1794	2026-05-19 12:00:00	6	12
1806	2026-05-19 13:00:00	23	194.85
1816	2026-05-19 13:00:00	25	14.75
1830	2026-05-19 13:00:00	21	20
1840	2026-05-19 13:00:00	22	29.03
1845	2026-05-19 13:00:00	24	14.75
1856	2026-05-19 14:00:00	33	195
1863	2026-05-19 14:00:00	34	15
1872	2026-05-19 14:00:00	31	20
1887	2026-05-19 14:00:00	35	15
1899	2026-05-19 14:00:00	32	28.92
1903	2026-05-19 15:00:00	8	168.6
1914	2026-05-19 15:00:00	10	15
1921	2026-05-19 15:00:00	9	15
1935	2026-05-19 15:00:00	7	24.72
1946	2026-05-19 15:00:00	6	12
1956	2026-05-19 16:00:00	23	192
1967	2026-05-19 16:00:00	25	10
1979	2026-05-19 16:00:00	21	20
1990	2026-05-19 16:00:00	22	29.68
1996	2026-05-19 16:00:00	24	10
2006	2026-05-19 17:00:00	23	192
2018	2026-05-19 17:00:00	25	10
2030	2026-05-19 17:00:00	21	20
2042	2026-05-19 17:00:00	22	29.55
2048	2026-05-19 17:00:00	24	10
2998	2026-05-20 12:00:00	48	430.8
3002	2026-05-20 13:00:00	6	12
3013	2026-05-20 13:00:00	7	24.99
3023	2026-05-20 13:00:00	8	168.6
3036	2026-05-20 13:00:00	10	15
3045	2026-05-20 13:00:00	9	15
3549	2026-05-20 23:00:00	30	16.25
4006	2026-05-21 09:00:00	31	40
4007	2026-05-21 09:00:00	27	38.97
4014	2026-05-21 09:00:00	29	16
4020	2026-05-21 09:00:00	33	261.6
4027	2026-05-21 09:00:00	26	40
4033	2026-05-21 09:00:00	34	16
4040	2026-05-21 09:00:00	28	261.6
4043	2026-05-21 09:00:00	35	16
4047	2026-05-21 09:00:00	30	16
4049	2026-05-21 09:00:00	32	38.95
4052	2026-05-21 10:00:00	10	15
4058	2026-05-21 10:00:00	17	34.98
4068	2026-05-21 10:00:00	18	275.25
4074	2026-05-21 10:00:00	9	15
4082	2026-05-21 10:00:00	19	38.75
4086	2026-05-21 10:00:00	6	12
4091	2026-05-21 10:00:00	8	168.6
4092	2026-05-21 10:00:00	20	38.75
4097	2026-05-21 10:00:00	7	24.73
4098	2026-05-21 10:00:00	16	40
4103	2026-05-21 11:00:00	13	258
4106	2026-05-21 11:00:00	18	275.25
4113	2026-05-21 11:00:00	19	38.75
4119	2026-05-21 11:00:00	15	10
4122	2026-05-21 11:00:00	20	38.75
4130	2026-05-21 11:00:00	16	40
4132	2026-05-21 11:00:00	11	40
4138	2026-05-21 11:00:00	17	35.17
4142	2026-05-21 11:00:00	14	10
4149	2026-05-21 11:00:00	12	55.14
4152	2026-05-21 12:00:00	10	15
4158	2026-05-21 12:00:00	43	429.9
4164	2026-05-21 12:00:00	7	24.98
4169	2026-05-21 12:00:00	44	10.5
4176	2026-05-21 12:00:00	9	15
4181	2026-05-21 12:00:00	45	10.5
4184	2026-05-21 12:00:00	6	12
143	2026-05-18 03:00:00	34	20
150	2026-05-18 03:00:00	35	20
151	2026-05-18 04:00:00	3	168.6
161	2026-05-18 04:00:00	1	12
168	2026-05-18 04:00:00	2	24.75
180	2026-05-18 04:00:00	4	15
192	2026-05-18 04:00:00	5	15
209	2026-05-18 05:00:00	46	20
213	2026-05-18 05:00:00	47	28.99
221	2026-05-18 05:00:00	48	195
226	2026-05-18 05:00:00	49	15
234	2026-05-18 05:00:00	50	15
260	2026-05-18 06:00:00	41	20
265	2026-05-18 06:00:00	42	29.59
274	2026-05-18 06:00:00	43	192
286	2026-05-18 06:00:00	44	10
295	2026-05-18 06:00:00	45	10
304	2026-05-18 07:00:00	25	10
313	2026-05-18 07:00:00	21	20
323	2026-05-18 07:00:00	22	29.72
332	2026-05-18 07:00:00	24	10
341	2026-05-18 07:00:00	23	192
359	2026-05-18 08:00:00	33	195
374	2026-05-18 08:00:00	34	15
385	2026-05-18 08:00:00	31	20
397	2026-05-18 08:00:00	35	15
400	2026-05-18 08:00:00	32	29.11
401	2026-05-18 09:00:00	5	15
417	2026-05-18 09:00:00	4	15
428	2026-05-18 09:00:00	3	168.6
437	2026-05-18 09:00:00	1	12
446	2026-05-18 09:00:00	2	24.89
452	2026-05-18 10:00:00	23	192
461	2026-05-18 10:00:00	25	10
475	2026-05-18 10:00:00	21	20
489	2026-05-18 10:00:00	22	29.62
496	2026-05-18 10:00:00	24	10
506	2026-05-18 11:00:00	23	192
518	2026-05-18 11:00:00	25	10
531	2026-05-18 11:00:00	21	20
539	2026-05-18 11:00:00	22	29.5
545	2026-05-18 11:00:00	24	10
1558	2026-05-19 08:00:00	39	10
1564	2026-05-19 08:00:00	40	10
1573	2026-05-19 08:00:00	36	20
1582	2026-05-19 08:00:00	37	29.54
1591	2026-05-19 08:00:00	38	192
1610	2026-05-19 09:00:00	40	10
1625	2026-05-19 09:00:00	36	20
1638	2026-05-19 09:00:00	37	29.48
1645	2026-05-19 09:00:00	38	192
1650	2026-05-19 09:00:00	39	10
1653	2026-05-19 10:00:00	12	29.71
1667	2026-05-19 10:00:00	14	10
1681	2026-05-19 10:00:00	13	192
1690	2026-05-19 10:00:00	15	10
1697	2026-05-19 10:00:00	11	20
1703	2026-05-19 11:00:00	18	192
1711	2026-05-19 11:00:00	16	20
1721	2026-05-19 11:00:00	19	10
1726	2026-05-19 11:00:00	20	10
1735	2026-05-19 11:00:00	17	29.57
1758	2026-05-19 12:00:00	50	10
1762	2026-05-19 12:00:00	48	277.8
1772	2026-05-19 12:00:00	49	10
1786	2026-05-19 12:00:00	46	46
1796	2026-05-19 12:00:00	47	43.12
1802	2026-05-19 13:00:00	10	15
1817	2026-05-19 13:00:00	9	15
1826	2026-05-19 13:00:00	7	24.73
1841	2026-05-19 13:00:00	6	12
1848	2026-05-19 13:00:00	8	168.6
1851	2026-05-19 14:00:00	2	24.92
1861	2026-05-19 14:00:00	5	15
1874	2026-05-19 14:00:00	4	15
1880	2026-05-19 14:00:00	3	168.6
1889	2026-05-19 14:00:00	1	12
1917	2026-05-19 15:00:00	40	10
1926	2026-05-19 15:00:00	36	20
1934	2026-05-19 15:00:00	37	29.47
1940	2026-05-19 15:00:00	38	192
1945	2026-05-19 15:00:00	39	10
1957	2026-05-19 16:00:00	30	19.75
1962	2026-05-19 16:00:00	27	28.47
1971	2026-05-19 16:00:00	29	19.75
1977	2026-05-19 16:00:00	28	197.85
1986	2026-05-19 16:00:00	26	20
2005	2026-05-19 17:00:00	41	20
2014	2026-05-19 17:00:00	42	29.45
2023	2026-05-19 17:00:00	43	192
2034	2026-05-19 17:00:00	44	10
2044	2026-05-19 17:00:00	45	10
2999	2026-05-20 12:00:00	40	10.5
3003	2026-05-20 13:00:00	12	55.05
3012	2026-05-20 13:00:00	14	10
3022	2026-05-20 13:00:00	11	40
3027	2026-05-20 13:00:00	13	258
3034	2026-05-20 13:00:00	15	10
3550	2026-05-20 23:00:00	34	16.25
4005	2026-05-21 09:00:00	17	35.09
4012	2026-05-21 09:00:00	18	275.25
4021	2026-05-21 09:00:00	20	38.75
4025	2026-05-21 09:00:00	16	40
4034	2026-05-21 09:00:00	19	38.75
4059	2026-05-21 10:00:00	41	40
4066	2026-05-21 10:00:00	42	39.88
4076	2026-05-21 10:00:00	43	258.3
4084	2026-05-21 10:00:00	44	10.5
4094	2026-05-21 10:00:00	45	10.5
4102	2026-05-21 11:00:00	25	10
4118	2026-05-21 11:00:00	21	40
4128	2026-05-21 11:00:00	24	10
4139	2026-05-21 11:00:00	23	258
4143	2026-05-21 11:00:00	22	40.23
4160	2026-05-21 12:00:00	39	10.75
4171	2026-05-21 12:00:00	40	10.75
4175	2026-05-21 12:00:00	37	67.1
4183	2026-05-21 12:00:00	38	430.05
4185	2026-05-21 12:00:00	33	433.35
4191	2026-05-21 12:00:00	34	16.25
4194	2026-05-21 12:00:00	36	92
4206	2026-05-21 13:00:00	35	40
4209	2026-05-21 13:00:00	39	35.25
4214	2026-05-21 13:00:00	32	34.76
4220	2026-05-21 13:00:00	40	35.25
4228	2026-05-21 13:00:00	31	40
4233	2026-05-21 13:00:00	37	35.72
4241	2026-05-21 13:00:00	38	273.15
4242	2026-05-21 13:00:00	33	276
4248	2026-05-21 13:00:00	36	40
4249	2026-05-21 13:00:00	34	40
4252	2026-05-21 15:00:00	13	258
4253	2026-05-21 15:00:00	8	168.6
4261	2026-05-21 15:00:00	7	24.76
4265	2026-05-21 15:00:00	15	10
4271	2026-05-21 15:00:00	10	15
146	2026-05-18 03:00:00	25	15
152	2026-05-18 04:00:00	6	12
167	2026-05-18 04:00:00	7	25
178	2026-05-18 04:00:00	8	168.6
188	2026-05-18 04:00:00	10	15
194	2026-05-18 04:00:00	9	15
203	2026-05-18 05:00:00	28	195
222	2026-05-18 05:00:00	26	20
237	2026-05-18 05:00:00	30	15
245	2026-05-18 05:00:00	27	28.85
250	2026-05-18 05:00:00	29	15
252	2026-05-18 06:00:00	1	12
262	2026-05-18 06:00:00	2	24.92
272	2026-05-18 06:00:00	5	15
278	2026-05-18 06:00:00	4	15
288	2026-05-18 06:00:00	3	168.6
308	2026-05-18 07:00:00	36	20
317	2026-05-18 07:00:00	37	29.56
329	2026-05-18 07:00:00	38	192
340	2026-05-18 07:00:00	39	10
349	2026-05-18 07:00:00	40	10
352	2026-05-18 08:00:00	13	192
365	2026-05-18 08:00:00	15	10
371	2026-05-18 08:00:00	11	20
382	2026-05-18 08:00:00	12	29.52
388	2026-05-18 08:00:00	14	10
407	2026-05-18 09:00:00	42	29.69
414	2026-05-18 09:00:00	43	192
424	2026-05-18 09:00:00	44	10
432	2026-05-18 09:00:00	45	10
443	2026-05-18 09:00:00	41	20
457	2026-05-18 10:00:00	32	28.93
469	2026-05-18 10:00:00	33	195
480	2026-05-18 10:00:00	34	15
491	2026-05-18 10:00:00	31	20
500	2026-05-18 10:00:00	35	15
501	2026-05-18 11:00:00	1	12
513	2026-05-18 11:00:00	2	24.76
528	2026-05-18 11:00:00	5	15
541	2026-05-18 11:00:00	4	15
548	2026-05-18 11:00:00	3	168.6
1557	2026-05-19 08:00:00	33	195
1565	2026-05-19 08:00:00	34	15
1574	2026-05-19 08:00:00	31	20
1586	2026-05-19 08:00:00	35	15
1596	2026-05-19 08:00:00	32	28.9
1604	2026-05-19 09:00:00	17	29.59
1619	2026-05-19 09:00:00	18	192
1629	2026-05-19 09:00:00	16	20
1636	2026-05-19 09:00:00	19	10
1643	2026-05-19 09:00:00	20	10
1660	2026-05-19 10:00:00	35	15
1672	2026-05-19 10:00:00	32	28.83
1684	2026-05-19 10:00:00	33	195
1692	2026-05-19 10:00:00	34	15
1698	2026-05-19 10:00:00	31	20
1707	2026-05-19 11:00:00	8	168.6
1712	2026-05-19 11:00:00	10	15
1722	2026-05-19 11:00:00	9	15
1727	2026-05-19 11:00:00	7	24.81
1736	2026-05-19 11:00:00	6	12
1759	2026-05-19 12:00:00	43	277.8
1770	2026-05-19 12:00:00	44	10
1778	2026-05-19 12:00:00	45	10
1783	2026-05-19 12:00:00	41	46
1792	2026-05-19 12:00:00	42	43.1
1808	2026-05-19 13:00:00	36	20
1818	2026-05-19 13:00:00	37	29.05
1831	2026-05-19 13:00:00	38	194.4
1839	2026-05-19 13:00:00	39	14
1847	2026-05-19 13:00:00	40	14
1852	2026-05-19 14:00:00	18	194.7
1866	2026-05-19 14:00:00	16	20
1876	2026-05-19 14:00:00	19	14.5
1882	2026-05-19 14:00:00	20	14.5
1891	2026-05-19 14:00:00	17	29
1909	2026-05-19 15:00:00	46	20
1919	2026-05-19 15:00:00	47	29.44
1925	2026-05-19 15:00:00	50	10
1933	2026-05-19 15:00:00	48	192
1939	2026-05-19 15:00:00	49	10
1958	2026-05-19 16:00:00	40	10
1966	2026-05-19 16:00:00	36	20
1975	2026-05-19 16:00:00	37	29.51
1982	2026-05-19 16:00:00	38	192
1992	2026-05-19 16:00:00	39	10
2008	2026-05-19 17:00:00	27	28.51
2017	2026-05-19 17:00:00	29	19.75
2025	2026-05-19 17:00:00	28	197.85
2032	2026-05-19 17:00:00	26	20
2039	2026-05-19 17:00:00	30	19.75
3005	2026-05-20 13:00:00	23	272.4
3020	2026-05-20 13:00:00	25	34
3033	2026-05-20 13:00:00	21	40
3042	2026-05-20 13:00:00	22	35.99
3049	2026-05-20 13:00:00	24	34
3552	2026-05-21 00:00:00	25	10
3551	2026-05-21 00:00:00	42	40.03
3561	2026-05-21 00:00:00	21	40
3566	2026-05-21 00:00:00	22	40.24
3569	2026-05-21 00:00:00	43	258.3
3578	2026-05-21 00:00:00	24	10
3580	2026-05-21 00:00:00	44	10.5
3589	2026-05-21 00:00:00	23	258
3590	2026-05-21 00:00:00	45	10.5
3596	2026-05-21 00:00:00	41	40
3602	2026-05-21 01:00:00	25	10
3606	2026-05-21 01:00:00	31	40
3613	2026-05-21 01:00:00	33	261.75
3619	2026-05-21 01:00:00	21	40
3621	2026-05-21 01:00:00	34	16.25
3629	2026-05-21 01:00:00	35	16.25
3637	2026-05-21 01:00:00	22	40.05
3638	2026-05-21 01:00:00	32	39.08
3646	2026-05-21 01:00:00	24	10
3650	2026-05-21 01:00:00	23	258
3651	2026-05-21 02:00:00	3	168.6
3658	2026-05-21 02:00:00	50	12.25
3661	2026-05-21 02:00:00	2	24.9
3663	2026-05-21 02:00:00	46	40
3665	2026-05-21 02:00:00	5	15
3671	2026-05-21 02:00:00	48	259.35
3674	2026-05-21 02:00:00	1	12
3678	2026-05-21 02:00:00	49	12.25
3680	2026-05-21 02:00:00	4	15
3685	2026-05-21 02:00:00	47	39.84
3708	2026-05-21 03:00:00	49	12.25
3710	2026-05-21 03:00:00	39	10.5
3719	2026-05-21 03:00:00	40	10.5
3723	2026-05-21 03:00:00	47	39.68
3725	2026-05-21 03:00:00	37	39.89
3733	2026-05-21 03:00:00	50	12.25
3740	2026-05-21 03:00:00	38	258.3
3744	2026-05-21 03:00:00	46	40
3748	2026-05-21 03:00:00	36	40
3749	2026-05-21 03:00:00	48	259.35
159	2026-05-18 04:00:00	41	20
170	2026-05-18 04:00:00	42	28.86
174	2026-05-18 04:00:00	43	195
182	2026-05-18 04:00:00	44	15
190	2026-05-18 04:00:00	45	15
210	2026-05-18 05:00:00	41	20
219	2026-05-18 05:00:00	42	29.52
232	2026-05-18 05:00:00	43	192
242	2026-05-18 05:00:00	44	10
249	2026-05-18 05:00:00	45	10
251	2026-05-18 06:00:00	10	15
261	2026-05-18 06:00:00	9	15
263	2026-05-18 06:00:00	7	24.77
271	2026-05-18 06:00:00	6	12
279	2026-05-18 06:00:00	8	168.6
309	2026-05-18 07:00:00	47	29.09
315	2026-05-18 07:00:00	48	195
325	2026-05-18 07:00:00	49	15
334	2026-05-18 07:00:00	50	15
344	2026-05-18 07:00:00	46	20
358	2026-05-18 08:00:00	29	15
368	2026-05-18 08:00:00	28	195
383	2026-05-18 08:00:00	26	20
389	2026-05-18 08:00:00	30	15
394	2026-05-18 08:00:00	27	28.85
403	2026-05-18 09:00:00	32	29.07
413	2026-05-18 09:00:00	33	195
423	2026-05-18 09:00:00	34	15
433	2026-05-18 09:00:00	31	20
441	2026-05-18 09:00:00	35	15
456	2026-05-18 10:00:00	42	29.54
463	2026-05-18 10:00:00	43	192
472	2026-05-18 10:00:00	44	10
477	2026-05-18 10:00:00	45	10
490	2026-05-18 10:00:00	41	20
510	2026-05-18 11:00:00	44	10
516	2026-05-18 11:00:00	45	10
524	2026-05-18 11:00:00	41	20
537	2026-05-18 11:00:00	42	29.65
547	2026-05-18 11:00:00	43	192
1559	2026-05-19 08:00:00	45	10
1570	2026-05-19 08:00:00	41	20
1580	2026-05-19 08:00:00	42	29.51
1592	2026-05-19 08:00:00	43	192
1599	2026-05-19 08:00:00	44	10
1601	2026-05-19 09:00:00	6	12
1613	2026-05-19 09:00:00	8	168.6
1621	2026-05-19 09:00:00	10	15
1627	2026-05-19 09:00:00	9	15
1635	2026-05-19 09:00:00	7	24.99
1657	2026-05-19 10:00:00	43	192
1668	2026-05-19 10:00:00	44	10
1680	2026-05-19 10:00:00	45	10
1691	2026-05-19 10:00:00	41	20
1699	2026-05-19 10:00:00	42	29.69
1702	2026-05-19 11:00:00	15	10
1715	2026-05-19 11:00:00	11	20
1730	2026-05-19 11:00:00	12	29.61
1742	2026-05-19 11:00:00	14	10
1746	2026-05-19 11:00:00	13	192
1757	2026-05-19 12:00:00	18	277.8
1768	2026-05-19 12:00:00	16	46
1779	2026-05-19 12:00:00	19	10
1790	2026-05-19 12:00:00	20	10
1799	2026-05-19 12:00:00	17	43.16
1804	2026-05-19 13:00:00	11	20
1814	2026-05-19 13:00:00	12	29.64
1824	2026-05-19 13:00:00	14	10
1834	2026-05-19 13:00:00	13	192
1844	2026-05-19 13:00:00	15	10
1857	2026-05-19 14:00:00	29	19.75
1868	2026-05-19 14:00:00	28	197.85
1878	2026-05-19 14:00:00	26	20
1885	2026-05-19 14:00:00	30	19.75
1896	2026-05-19 14:00:00	27	28.49
1904	2026-05-19 15:00:00	17	29.66
1915	2026-05-19 15:00:00	18	192
1932	2026-05-19 15:00:00	16	20
1944	2026-05-19 15:00:00	19	10
1950	2026-05-19 15:00:00	20	10
1951	2026-05-19 16:00:00	1	12
1963	2026-05-19 16:00:00	2	24.9
1972	2026-05-19 16:00:00	5	15
1978	2026-05-19 16:00:00	4	15
1987	2026-05-19 16:00:00	3	168.6
2009	2026-05-19 17:00:00	31	20
2016	2026-05-19 17:00:00	35	15
2026	2026-05-19 17:00:00	32	29.06
2033	2026-05-19 17:00:00	33	195
2040	2026-05-19 17:00:00	34	15
3051	2026-05-20 14:00:00	3	168.6
3058	2026-05-20 14:00:00	2	24.86
3065	2026-05-20 14:00:00	5	15
3072	2026-05-20 14:00:00	1	12
3081	2026-05-20 14:00:00	4	15
3108	2026-05-20 15:00:00	47	39.74
3116	2026-05-20 15:00:00	50	12.25
3126	2026-05-20 15:00:00	46	40
3134	2026-05-20 15:00:00	48	259.35
3145	2026-05-20 15:00:00	49	12.25
3154	2026-05-20 16:00:00	22	40.24
3162	2026-05-20 16:00:00	24	10
3171	2026-05-20 16:00:00	23	258
3180	2026-05-20 16:00:00	25	10
3188	2026-05-20 16:00:00	21	40
3210	2026-05-20 17:00:00	41	40
3222	2026-05-20 17:00:00	42	40.07
3237	2026-05-20 17:00:00	43	258.45
3243	2026-05-20 17:00:00	44	10.75
3247	2026-05-20 17:00:00	45	10.75
3254	2026-05-20 18:00:00	16	40
3268	2026-05-20 18:00:00	19	38.5
3278	2026-05-20 18:00:00	20	38.5
3288	2026-05-20 18:00:00	17	35.03
3299	2026-05-20 18:00:00	18	275.1
3302	2026-05-20 19:00:00	6	12
3311	2026-05-20 19:00:00	7	24.89
3321	2026-05-20 19:00:00	8	168.6
3327	2026-05-20 19:00:00	10	15
3334	2026-05-20 19:00:00	9	15
3360	2026-05-20 20:00:00	50	12
3372	2026-05-20 20:00:00	46	40
3381	2026-05-20 20:00:00	48	259.2
3392	2026-05-20 20:00:00	49	12
3400	2026-05-20 20:00:00	47	39.61
3401	2026-05-20 21:00:00	4	15
3411	2026-05-20 21:00:00	3	168.6
3423	2026-05-20 21:00:00	2	24.87
3429	2026-05-20 21:00:00	5	15
3438	2026-05-20 21:00:00	1	12
3459	2026-05-20 22:00:00	46	40
3468	2026-05-20 22:00:00	48	259.35
3482	2026-05-20 22:00:00	49	12.25
3493	2026-05-20 22:00:00	47	39.67
3499	2026-05-20 22:00:00	50	12.25
3503	2026-05-20 23:00:00	6	12
160	2026-05-18 04:00:00	46	20
171	2026-05-18 04:00:00	47	29.08
181	2026-05-18 04:00:00	48	195
191	2026-05-18 04:00:00	49	15
200	2026-05-18 04:00:00	50	15
207	2026-05-18 05:00:00	15	10
216	2026-05-18 05:00:00	11	20
223	2026-05-18 05:00:00	12	29.5
230	2026-05-18 05:00:00	14	10
239	2026-05-18 05:00:00	13	192
258	2026-05-18 06:00:00	39	10
270	2026-05-18 06:00:00	40	10
281	2026-05-18 06:00:00	36	20
293	2026-05-18 06:00:00	37	29.68
298	2026-05-18 06:00:00	38	192
307	2026-05-18 07:00:00	6	12
318	2026-05-18 07:00:00	8	168.6
330	2026-05-18 07:00:00	10	15
338	2026-05-18 07:00:00	9	15
348	2026-05-18 07:00:00	7	24.83
353	2026-05-18 08:00:00	9	15
363	2026-05-18 08:00:00	7	24.78
369	2026-05-18 08:00:00	6	12
378	2026-05-18 08:00:00	8	168.6
392	2026-05-18 08:00:00	10	15
406	2026-05-18 09:00:00	29	15
415	2026-05-18 09:00:00	28	195
427	2026-05-18 09:00:00	26	20
436	2026-05-18 09:00:00	30	15
447	2026-05-18 09:00:00	27	28.84
453	2026-05-18 10:00:00	13	192
464	2026-05-18 10:00:00	15	10
473	2026-05-18 10:00:00	11	20
486	2026-05-18 10:00:00	12	29.65
498	2026-05-18 10:00:00	14	10
505	2026-05-18 11:00:00	19	10
522	2026-05-18 11:00:00	20	10
535	2026-05-18 11:00:00	17	29.47
544	2026-05-18 11:00:00	18	192
550	2026-05-18 11:00:00	16	20
551	2026-05-18 12:00:00	4	15
552	2026-05-18 12:00:00	17	43.36
556	2026-05-18 12:00:00	14	10
554	2026-05-18 12:00:00	32	42.19
553	2026-05-18 12:00:00	49	10
555	2026-05-18 12:00:00	8	168.6
557	2026-05-18 12:00:00	40	10
558	2026-05-18 12:00:00	21	46
559	2026-05-18 12:00:00	42	43.19
560	2026-05-18 12:00:00	28	280.8
561	2026-05-18 12:00:00	3	168.6
562	2026-05-18 12:00:00	46	46
563	2026-05-18 12:00:00	33	280.8
564	2026-05-18 12:00:00	10	15
565	2026-05-18 12:00:00	18	277.8
566	2026-05-18 12:00:00	1	12
567	2026-05-18 12:00:00	13	277.8
568	2026-05-18 12:00:00	36	46
569	2026-05-18 12:00:00	22	43.32
570	2026-05-18 12:00:00	47	43.32
571	2026-05-18 12:00:00	34	15
572	2026-05-18 12:00:00	9	15
573	2026-05-18 12:00:00	43	277.8
574	2026-05-18 12:00:00	2	24.79
575	2026-05-18 12:00:00	26	46
576	2026-05-18 12:00:00	50	10
577	2026-05-18 12:00:00	31	46
578	2026-05-18 12:00:00	15	10
579	2026-05-18 12:00:00	16	46
580	2026-05-18 12:00:00	5	15
581	2026-05-18 12:00:00	37	43.36
582	2026-05-18 12:00:00	24	10
583	2026-05-18 12:00:00	7	24.76
584	2026-05-18 12:00:00	44	10
585	2026-05-18 12:00:00	48	277.8
586	2026-05-18 12:00:00	11	46
587	2026-05-18 12:00:00	35	15
588	2026-05-18 12:00:00	30	15
589	2026-05-18 12:00:00	19	10
590	2026-05-18 12:00:00	23	277.8
591	2026-05-18 12:00:00	38	277.8
592	2026-05-18 12:00:00	45	10
593	2026-05-18 12:00:00	6	12
594	2026-05-18 12:00:00	27	42.2
595	2026-05-18 12:00:00	12	43.19
596	2026-05-18 12:00:00	20	10
597	2026-05-18 12:00:00	39	10
598	2026-05-18 12:00:00	25	10
599	2026-05-18 12:00:00	41	46
600	2026-05-18 12:00:00	29	15
601	2026-05-18 13:00:00	4	15
602	2026-05-18 13:00:00	8	168.6
604	2026-05-18 13:00:00	20	14.75
603	2026-05-18 13:00:00	14	10
605	2026-05-18 13:00:00	29	19.75
606	2026-05-18 13:00:00	41	20
607	2026-05-18 13:00:00	49	14.75
608	2026-05-18 13:00:00	39	13.75
609	2026-05-18 13:00:00	32	29.02
610	2026-05-18 13:00:00	25	14.75
611	2026-05-18 13:00:00	3	168.6
612	2026-05-18 13:00:00	10	15
613	2026-05-18 13:00:00	33	195
614	2026-05-18 13:00:00	42	29.16
615	2026-05-18 13:00:00	13	192
616	2026-05-18 13:00:00	21	20
617	2026-05-18 13:00:00	40	13.75
618	2026-05-18 13:00:00	46	20
619	2026-05-18 13:00:00	1	12
620	2026-05-18 13:00:00	17	29.13
621	2026-05-18 13:00:00	28	197.85
622	2026-05-18 13:00:00	43	194.25
623	2026-05-18 13:00:00	34	15
624	2026-05-18 13:00:00	15	10
625	2026-05-18 13:00:00	9	15
626	2026-05-18 13:00:00	2	25.01
627	2026-05-18 13:00:00	36	20
628	2026-05-18 13:00:00	22	28.88
629	2026-05-18 13:00:00	47	29.02
630	2026-05-18 13:00:00	18	194.85
631	2026-05-18 13:00:00	26	20
632	2026-05-18 13:00:00	7	24.98
633	2026-05-18 13:00:00	11	20
634	2026-05-18 13:00:00	31	20
635	2026-05-18 13:00:00	5	15
636	2026-05-18 13:00:00	44	13.75
637	2026-05-18 13:00:00	37	29.04
638	2026-05-18 13:00:00	6	12
639	2026-05-18 13:00:00	12	29.61
640	2026-05-18 13:00:00	35	15
641	2026-05-18 13:00:00	24	14.75
642	2026-05-18 13:00:00	50	14.75
643	2026-05-18 13:00:00	16	20
644	2026-05-18 13:00:00	30	19.75
645	2026-05-18 13:00:00	38	194.25
646	2026-05-18 13:00:00	23	194.85
647	2026-05-18 13:00:00	45	13.75
653	2026-05-18 14:00:00	20	10
662	2026-05-18 14:00:00	17	29.44
675	2026-05-18 14:00:00	18	192
685	2026-05-18 14:00:00	16	20
695	2026-05-18 14:00:00	19	10
710	2026-05-18 15:00:00	26	20
713	2026-05-18 15:00:00	30	19.75
723	2026-05-18 15:00:00	27	28.28
733	2026-05-18 15:00:00	29	19.75
741	2026-05-18 15:00:00	28	197.85
760	2026-05-18 16:00:00	49	10
774	2026-05-18 16:00:00	46	20
786	2026-05-18 16:00:00	47	29.67
796	2026-05-18 16:00:00	50	10
800	2026-05-18 16:00:00	48	192
801	2026-05-18 17:00:00	4	15
815	2026-05-18 17:00:00	3	168.6
823	2026-05-18 17:00:00	1	12
833	2026-05-18 17:00:00	2	24.77
842	2026-05-18 17:00:00	5	15
857	2026-05-18 18:00:00	37	29.47
864	2026-05-18 18:00:00	38	192
874	2026-05-18 18:00:00	39	10
883	2026-05-18 18:00:00	40	10
896	2026-05-18 18:00:00	36	20
904	2026-05-18 19:00:00	23	192
911	2026-05-18 19:00:00	25	10
920	2026-05-18 19:00:00	21	20
925	2026-05-18 19:00:00	22	29.68
939	2026-05-18 19:00:00	24	10
958	2026-05-18 20:00:00	41	20
969	2026-05-18 20:00:00	42	29.53
981	2026-05-18 20:00:00	43	192
992	2026-05-18 20:00:00	44	10
1000	2026-05-18 20:00:00	45	10
1001	2026-05-18 21:00:00	3	168.6
1014	2026-05-18 21:00:00	1	12
1029	2026-05-18 21:00:00	2	24.78
1042	2026-05-18 21:00:00	5	15
1049	2026-05-18 21:00:00	4	15
1560	2026-05-19 08:00:00	47	29.59
1571	2026-05-19 08:00:00	50	10
1581	2026-05-19 08:00:00	48	192
1594	2026-05-19 08:00:00	49	10
1600	2026-05-19 08:00:00	46	20
1602	2026-05-19 09:00:00	5	15
1615	2026-05-19 09:00:00	4	15
1624	2026-05-19 09:00:00	3	168.6
1637	2026-05-19 09:00:00	1	12
1646	2026-05-19 09:00:00	2	24.95
1654	2026-05-19 10:00:00	24	10
1661	2026-05-19 10:00:00	23	192
1669	2026-05-19 10:00:00	25	10
1676	2026-05-19 10:00:00	21	20
1682	2026-05-19 10:00:00	22	29.54
1705	2026-05-19 11:00:00	50	10
1719	2026-05-19 11:00:00	48	192
1733	2026-05-19 11:00:00	49	10
1744	2026-05-19 11:00:00	46	20
1750	2026-05-19 11:00:00	47	29.61
1752	2026-05-19 12:00:00	15	10
1766	2026-05-19 12:00:00	11	46
1776	2026-05-19 12:00:00	12	43.11
1787	2026-05-19 12:00:00	14	10
1797	2026-05-19 12:00:00	13	277.8
1807	2026-05-19 13:00:00	31	20
1812	2026-05-19 13:00:00	35	15
1822	2026-05-19 13:00:00	32	28.94
1829	2026-05-19 13:00:00	33	195
1838	2026-05-19 13:00:00	34	15
1860	2026-05-19 14:00:00	38	192
1864	2026-05-19 14:00:00	39	10
1873	2026-05-19 14:00:00	40	10
1888	2026-05-19 14:00:00	36	20
1898	2026-05-19 14:00:00	37	29.74
1902	2026-05-19 15:00:00	12	29.68
1912	2026-05-19 15:00:00	14	10
1922	2026-05-19 15:00:00	13	192
1928	2026-05-19 15:00:00	15	10
1936	2026-05-19 15:00:00	11	20
1960	2026-05-19 16:00:00	46	20
1973	2026-05-19 16:00:00	47	29.52
1988	2026-05-19 16:00:00	50	10
1995	2026-05-19 16:00:00	48	192
1997	2026-05-19 16:00:00	49	10
2004	2026-05-19 17:00:00	17	29.69
2015	2026-05-19 17:00:00	18	192
2027	2026-05-19 17:00:00	16	20
2041	2026-05-19 17:00:00	19	10
2047	2026-05-19 17:00:00	20	10
3052	2026-05-20 14:00:00	8	168.6
3059	2026-05-20 14:00:00	10	15
3068	2026-05-20 14:00:00	9	15
3075	2026-05-20 14:00:00	6	12
3084	2026-05-20 14:00:00	7	24.97
3107	2026-05-20 15:00:00	43	258.6
3112	2026-05-20 15:00:00	44	11
3122	2026-05-20 15:00:00	45	11
3128	2026-05-20 15:00:00	41	40
3137	2026-05-20 15:00:00	42	40.03
3155	2026-05-20 16:00:00	48	259.35
3163	2026-05-20 16:00:00	49	12.25
3175	2026-05-20 16:00:00	47	39.77
3185	2026-05-20 16:00:00	50	12.25
3193	2026-05-20 16:00:00	46	40
3209	2026-05-20 17:00:00	34	16
3214	2026-05-20 17:00:00	35	16
3223	2026-05-20 17:00:00	32	39.11
3230	2026-05-20 17:00:00	31	40
3238	2026-05-20 17:00:00	33	261.6
3253	2026-05-20 18:00:00	36	40
3262	2026-05-20 18:00:00	39	10.5
3271	2026-05-20 18:00:00	40	10.5
3283	2026-05-20 18:00:00	37	39.93
3294	2026-05-20 18:00:00	38	258.3
3306	2026-05-20 19:00:00	29	16.25
3313	2026-05-20 19:00:00	26	40
3323	2026-05-20 19:00:00	28	261.75
3329	2026-05-20 19:00:00	30	16.25
3338	2026-05-20 19:00:00	27	38.89
3358	2026-05-20 20:00:00	36	40
3365	2026-05-20 20:00:00	39	10.5
3377	2026-05-20 20:00:00	40	10.5
3390	2026-05-20 20:00:00	37	40
3396	2026-05-20 20:00:00	38	258.3
3404	2026-05-20 21:00:00	16	40
3413	2026-05-20 21:00:00	19	38.75
3421	2026-05-20 21:00:00	20	38.75
3427	2026-05-20 21:00:00	17	35.19
3434	2026-05-20 21:00:00	18	275.25
3456	2026-05-20 22:00:00	43	258.3
3463	2026-05-20 22:00:00	44	10.5
3472	2026-05-20 22:00:00	45	10.5
3477	2026-05-20 22:00:00	41	40
3488	2026-05-20 22:00:00	42	40
648	2026-05-18 13:00:00	48	194.85
654	2026-05-18 14:00:00	14	10
664	2026-05-18 14:00:00	13	192
673	2026-05-18 14:00:00	15	10
683	2026-05-18 14:00:00	11	20
691	2026-05-18 14:00:00	12	29.56
709	2026-05-18 15:00:00	43	192
715	2026-05-18 15:00:00	44	10
726	2026-05-18 15:00:00	45	10
737	2026-05-18 15:00:00	41	20
746	2026-05-18 15:00:00	42	29.56
755	2026-05-18 16:00:00	24	10
762	2026-05-18 16:00:00	23	192
771	2026-05-18 16:00:00	25	10
776	2026-05-18 16:00:00	21	20
784	2026-05-18 16:00:00	22	29.47
807	2026-05-18 17:00:00	48	192
813	2026-05-18 17:00:00	49	10
822	2026-05-18 17:00:00	46	20
831	2026-05-18 17:00:00	47	29.6
840	2026-05-18 17:00:00	50	10
859	2026-05-18 18:00:00	41	20
862	2026-05-18 18:00:00	42	29.66
872	2026-05-18 18:00:00	43	192
877	2026-05-18 18:00:00	44	10
887	2026-05-18 18:00:00	45	10
909	2026-05-18 19:00:00	43	192
916	2026-05-18 19:00:00	44	10
926	2026-05-18 19:00:00	45	10
938	2026-05-18 19:00:00	41	20
947	2026-05-18 19:00:00	42	29.65
955	2026-05-18 20:00:00	18	192
967	2026-05-18 20:00:00	16	20
979	2026-05-18 20:00:00	19	10
990	2026-05-18 20:00:00	20	10
998	2026-05-18 20:00:00	17	29.68
1002	2026-05-18 21:00:00	13	192
1012	2026-05-18 21:00:00	15	10
1026	2026-05-18 21:00:00	11	20
1034	2026-05-18 21:00:00	12	29.5
1041	2026-05-18 21:00:00	14	10
2051	2026-05-19 18:00:00	4	15
2061	2026-05-19 18:00:00	3	168.6
2069	2026-05-19 18:00:00	1	12
2077	2026-05-19 18:00:00	2	24.96
2082	2026-05-19 18:00:00	5	15
2110	2026-05-19 19:00:00	50	10
2116	2026-05-19 19:00:00	48	192
2125	2026-05-19 19:00:00	49	10
2137	2026-05-19 19:00:00	46	20
2144	2026-05-19 19:00:00	47	29.6
2155	2026-05-19 20:00:00	18	192
2163	2026-05-19 20:00:00	16	20
2172	2026-05-19 20:00:00	19	10
2183	2026-05-19 20:00:00	20	10
2194	2026-05-19 20:00:00	17	29.56
2206	2026-05-19 21:00:00	30	15
2212	2026-05-19 21:00:00	27	28.95
2220	2026-05-19 21:00:00	29	15
2227	2026-05-19 21:00:00	28	195
2235	2026-05-19 21:00:00	26	20
2259	2026-05-19 22:00:00	46	20
2266	2026-05-19 22:00:00	47	29.59
2271	2026-05-19 22:00:00	50	10
2281	2026-05-19 22:00:00	48	192
2296	2026-05-19 22:00:00	49	10
2306	2026-05-19 23:00:00	27	29
2314	2026-05-19 23:00:00	29	15
2322	2026-05-19 23:00:00	28	195
2334	2026-05-19 23:00:00	26	20
2346	2026-05-19 23:00:00	30	15
2355	2026-05-20 00:00:00	26	20
2368	2026-05-20 00:00:00	30	15
2382	2026-05-20 00:00:00	27	28.91
2394	2026-05-20 00:00:00	29	15
2399	2026-05-20 00:00:00	28	195
2404	2026-05-20 01:00:00	18	192
2414	2026-05-20 01:00:00	16	20
2423	2026-05-20 01:00:00	19	10
2430	2026-05-20 01:00:00	20	10
2443	2026-05-20 01:00:00	17	29.52
2456	2026-05-20 02:00:00	29	15
2467	2026-05-20 02:00:00	28	195
2476	2026-05-20 02:00:00	26	20
2486	2026-05-20 02:00:00	30	15
2496	2026-05-20 02:00:00	27	29.01
2504	2026-05-20 03:00:00	24	10
2516	2026-05-20 03:00:00	23	192
2526	2026-05-20 03:00:00	25	10
2532	2026-05-20 03:00:00	21	20
2542	2026-05-20 03:00:00	22	29.49
3053	2026-05-20 14:00:00	11	40
3067	2026-05-20 14:00:00	13	258
3079	2026-05-20 14:00:00	15	10
3091	2026-05-20 14:00:00	12	55.08
3098	2026-05-20 14:00:00	14	10
3106	2026-05-20 15:00:00	13	258
3114	2026-05-20 15:00:00	15	10
3124	2026-05-20 15:00:00	12	55.13
3130	2026-05-20 15:00:00	14	10
3144	2026-05-20 15:00:00	11	40
3156	2026-05-20 16:00:00	26	40
3168	2026-05-20 16:00:00	28	261.75
3182	2026-05-20 16:00:00	30	16.25
3192	2026-05-20 16:00:00	27	38.96
3199	2026-05-20 16:00:00	29	16.25
3202	2026-05-20 17:00:00	9	15
3219	2026-05-20 17:00:00	6	12
3232	2026-05-20 17:00:00	7	24.73
3242	2026-05-20 17:00:00	8	168.6
3250	2026-05-20 17:00:00	10	15
3251	2026-05-20 18:00:00	2	24.76
3266	2026-05-20 18:00:00	5	15
3279	2026-05-20 18:00:00	1	12
3290	2026-05-20 18:00:00	4	15
3298	2026-05-20 18:00:00	3	168.6
3304	2026-05-20 19:00:00	18	275.1
3317	2026-05-20 19:00:00	16	40
3331	2026-05-20 19:00:00	19	38.5
3342	2026-05-20 19:00:00	20	38.5
3348	2026-05-20 19:00:00	17	35.17
3352	2026-05-20 20:00:00	9	15
3364	2026-05-20 20:00:00	6	12
3378	2026-05-20 20:00:00	7	24.89
3391	2026-05-20 20:00:00	8	168.6
3399	2026-05-20 20:00:00	10	15
3402	2026-05-20 21:00:00	8	168.6
3412	2026-05-20 21:00:00	10	15
3424	2026-05-20 21:00:00	9	15
3437	2026-05-20 21:00:00	6	12
3445	2026-05-20 21:00:00	7	25
3455	2026-05-20 22:00:00	33	261.6
3462	2026-05-20 22:00:00	34	16
3471	2026-05-20 22:00:00	35	16
3476	2026-05-20 22:00:00	32	39.07
3485	2026-05-20 22:00:00	31	40
649	2026-05-18 13:00:00	19	14.75
651	2026-05-18 14:00:00	8	168.6
661	2026-05-18 14:00:00	10	15
669	2026-05-18 14:00:00	9	15
680	2026-05-18 14:00:00	7	24.91
687	2026-05-18 14:00:00	6	12
707	2026-05-18 15:00:00	47	28.97
714	2026-05-18 15:00:00	50	14.75
724	2026-05-18 15:00:00	48	194.85
734	2026-05-18 15:00:00	49	14.75
744	2026-05-18 15:00:00	46	20
756	2026-05-18 16:00:00	35	15
769	2026-05-18 16:00:00	32	29.06
783	2026-05-18 16:00:00	33	195
793	2026-05-18 16:00:00	34	15
799	2026-05-18 16:00:00	31	20
803	2026-05-18 17:00:00	6	12
816	2026-05-18 17:00:00	8	168.6
828	2026-05-18 17:00:00	10	15
838	2026-05-18 17:00:00	9	15
848	2026-05-18 17:00:00	7	24.92
852	2026-05-18 18:00:00	14	10
867	2026-05-18 18:00:00	13	192
880	2026-05-18 18:00:00	15	10
888	2026-05-18 18:00:00	11	20
894	2026-05-18 18:00:00	12	29.63
905	2026-05-18 19:00:00	32	28.92
919	2026-05-18 19:00:00	33	195
932	2026-05-18 19:00:00	34	15
944	2026-05-18 19:00:00	31	20
949	2026-05-18 19:00:00	35	15
952	2026-05-18 20:00:00	10	15
961	2026-05-18 20:00:00	9	15
968	2026-05-18 20:00:00	7	24.89
975	2026-05-18 20:00:00	6	12
980	2026-05-18 20:00:00	8	168.6
1007	2026-05-18 21:00:00	47	29.66
1011	2026-05-18 21:00:00	50	10
1021	2026-05-18 21:00:00	48	192
1028	2026-05-18 21:00:00	49	10
1039	2026-05-18 21:00:00	46	20
2052	2026-05-19 18:00:00	7	24.87
2068	2026-05-19 18:00:00	6	12
2081	2026-05-19 18:00:00	8	168.6
2093	2026-05-19 18:00:00	10	15
2099	2026-05-19 18:00:00	9	15
2102	2026-05-19 19:00:00	6	12
2111	2026-05-19 19:00:00	8	168.6
2120	2026-05-19 19:00:00	10	15
2129	2026-05-19 19:00:00	9	15
2135	2026-05-19 19:00:00	7	24.93
2158	2026-05-19 20:00:00	45	10
2167	2026-05-19 20:00:00	41	20
2176	2026-05-19 20:00:00	42	29.55
2189	2026-05-19 20:00:00	43	192
2199	2026-05-19 20:00:00	44	10
2203	2026-05-19 21:00:00	15	10
2216	2026-05-19 21:00:00	11	20
2226	2026-05-19 21:00:00	12	29.46
2241	2026-05-19 21:00:00	14	10
2247	2026-05-19 21:00:00	13	192
2253	2026-05-19 22:00:00	17	29.69
2268	2026-05-19 22:00:00	18	192
2278	2026-05-19 22:00:00	16	20
2284	2026-05-19 22:00:00	19	10
2292	2026-05-19 22:00:00	20	10
2309	2026-05-19 23:00:00	44	10
2317	2026-05-19 23:00:00	45	10
2324	2026-05-19 23:00:00	41	20
2333	2026-05-19 23:00:00	42	29.49
2340	2026-05-19 23:00:00	43	192
2360	2026-05-20 00:00:00	42	29.52
2374	2026-05-20 00:00:00	43	192
2381	2026-05-20 00:00:00	44	10
2390	2026-05-20 00:00:00	45	10
2398	2026-05-20 00:00:00	41	20
2402	2026-05-20 01:00:00	8	168.6
2416	2026-05-20 01:00:00	10	15
2426	2026-05-20 01:00:00	9	15
2439	2026-05-20 01:00:00	7	24.73
2447	2026-05-20 01:00:00	6	12
2455	2026-05-20 02:00:00	21	20
2469	2026-05-20 02:00:00	22	29.71
2483	2026-05-20 02:00:00	24	10
2488	2026-05-20 02:00:00	23	192
2494	2026-05-20 02:00:00	25	10
2508	2026-05-20 03:00:00	28	195
2519	2026-05-20 03:00:00	26	20
2535	2026-05-20 03:00:00	30	15
2545	2026-05-20 03:00:00	27	28.93
2547	2026-05-20 03:00:00	29	15
3054	2026-05-20 14:00:00	34	15
3066	2026-05-20 14:00:00	35	15
3076	2026-05-20 14:00:00	32	39.15
3086	2026-05-20 14:00:00	31	40
3090	2026-05-20 14:00:00	33	261
3110	2026-05-20 15:00:00	35	16.25
3121	2026-05-20 15:00:00	32	38.9
3135	2026-05-20 15:00:00	31	40
3140	2026-05-20 15:00:00	33	261.75
3149	2026-05-20 15:00:00	34	16.25
3158	2026-05-20 16:00:00	6	12
3165	2026-05-20 16:00:00	7	24.93
3174	2026-05-20 16:00:00	8	168.6
3184	2026-05-20 16:00:00	10	15
3194	2026-05-20 16:00:00	9	15
3204	2026-05-20 17:00:00	27	38.87
3217	2026-05-20 17:00:00	29	16.25
3226	2026-05-20 17:00:00	26	40
3239	2026-05-20 17:00:00	28	261.75
3246	2026-05-20 17:00:00	30	16.25
3256	2026-05-20 18:00:00	27	38.9
3263	2026-05-20 18:00:00	29	16.25
3272	2026-05-20 18:00:00	26	40
3284	2026-05-20 18:00:00	28	261.75
3293	2026-05-20 18:00:00	30	16.25
3309	2026-05-20 19:00:00	39	10.5
3312	2026-05-20 19:00:00	40	10.5
3322	2026-05-20 19:00:00	37	39.94
3328	2026-05-20 19:00:00	38	258.3
3335	2026-05-20 19:00:00	36	40
3359	2026-05-20 20:00:00	44	10.5
3368	2026-05-20 20:00:00	45	10.5
3375	2026-05-20 20:00:00	41	40
3384	2026-05-20 20:00:00	42	40.05
3397	2026-05-20 20:00:00	43	258.3
3406	2026-05-20 21:00:00	30	16.25
3414	2026-05-20 21:00:00	27	38.92
3422	2026-05-20 21:00:00	29	16.25
3428	2026-05-20 21:00:00	26	40
3435	2026-05-20 21:00:00	28	261.75
3457	2026-05-20 22:00:00	38	258.3
3461	2026-05-20 22:00:00	36	40
3470	2026-05-20 22:00:00	39	10.5
3475	2026-05-20 22:00:00	40	10.5
3484	2026-05-20 22:00:00	37	40.04
650	2026-05-18 13:00:00	27	28.39
652	2026-05-18 14:00:00	3	168.6
665	2026-05-18 14:00:00	1	12
676	2026-05-18 14:00:00	2	24.92
686	2026-05-18 14:00:00	5	15
696	2026-05-18 14:00:00	4	15
705	2026-05-18 15:00:00	25	14.75
718	2026-05-18 15:00:00	21	20
728	2026-05-18 15:00:00	22	29.09
738	2026-05-18 15:00:00	24	14.75
748	2026-05-18 15:00:00	23	194.85
753	2026-05-18 16:00:00	14	10
763	2026-05-18 16:00:00	13	192
772	2026-05-18 16:00:00	15	10
780	2026-05-18 16:00:00	11	20
787	2026-05-18 16:00:00	12	29.67
810	2026-05-18 17:00:00	41	20
817	2026-05-18 17:00:00	42	29.62
826	2026-05-18 17:00:00	43	192
837	2026-05-18 17:00:00	44	10
847	2026-05-18 17:00:00	45	10
856	2026-05-18 18:00:00	18	192
861	2026-05-18 18:00:00	16	20
871	2026-05-18 18:00:00	19	10
876	2026-05-18 18:00:00	20	10
886	2026-05-18 18:00:00	17	29.45
910	2026-05-18 19:00:00	46	20
924	2026-05-18 19:00:00	47	29.46
934	2026-05-18 19:00:00	50	10
945	2026-05-18 19:00:00	48	192
950	2026-05-18 19:00:00	49	10
951	2026-05-18 20:00:00	3	168.6
965	2026-05-18 20:00:00	1	12
977	2026-05-18 20:00:00	2	24.92
988	2026-05-18 20:00:00	5	15
997	2026-05-18 20:00:00	4	15
1004	2026-05-18 21:00:00	17	29.7
1019	2026-05-18 21:00:00	18	192
1033	2026-05-18 21:00:00	16	20
1044	2026-05-18 21:00:00	19	10
1050	2026-05-18 21:00:00	20	10
2053	2026-05-19 18:00:00	11	20
2054	2026-05-19 18:00:00	16	20
2062	2026-05-19 18:00:00	12	29.73
2063	2026-05-19 18:00:00	19	10
2072	2026-05-19 18:00:00	14	10
2073	2026-05-19 18:00:00	20	10
2079	2026-05-19 18:00:00	13	192
2080	2026-05-19 18:00:00	17	29.58
2087	2026-05-19 18:00:00	15	10
2088	2026-05-19 18:00:00	18	192
2108	2026-05-19 19:00:00	36	20
2109	2026-05-19 19:00:00	43	192
2117	2026-05-19 19:00:00	37	29.61
2123	2026-05-19 19:00:00	44	10
2128	2026-05-19 19:00:00	38	192
2134	2026-05-19 19:00:00	45	10
2140	2026-05-19 19:00:00	39	10
2142	2026-05-19 19:00:00	41	20
2148	2026-05-19 19:00:00	40	10
2149	2026-05-19 19:00:00	42	29.63
2151	2026-05-19 20:00:00	2	25.01
2153	2026-05-19 20:00:00	15	10
2162	2026-05-19 20:00:00	5	15
2165	2026-05-19 20:00:00	11	20
2174	2026-05-19 20:00:00	12	29.45
2175	2026-05-19 20:00:00	4	15
2178	2026-05-19 20:00:00	14	10
2185	2026-05-19 20:00:00	13	192
2188	2026-05-19 20:00:00	3	168.6
2197	2026-05-19 20:00:00	1	12
2204	2026-05-19 21:00:00	17	29.64
2210	2026-05-19 21:00:00	46	20
2213	2026-05-19 21:00:00	18	192
2221	2026-05-19 21:00:00	16	20
2223	2026-05-19 21:00:00	47	29.62
2229	2026-05-19 21:00:00	19	10
2233	2026-05-19 21:00:00	50	10
2240	2026-05-19 21:00:00	20	10
2244	2026-05-19 21:00:00	48	192
2248	2026-05-19 21:00:00	49	10
2252	2026-05-19 22:00:00	10	15
2258	2026-05-19 22:00:00	35	15
2262	2026-05-19 22:00:00	32	29.11
2269	2026-05-19 22:00:00	9	15
2272	2026-05-19 22:00:00	33	195
2279	2026-05-19 22:00:00	7	25
2286	2026-05-19 22:00:00	34	15
2288	2026-05-19 22:00:00	6	12
2295	2026-05-19 22:00:00	31	20
2298	2026-05-19 22:00:00	8	168.6
2305	2026-05-19 23:00:00	23	192
2307	2026-05-19 23:00:00	32	28.98
2312	2026-05-19 23:00:00	33	195
2318	2026-05-19 23:00:00	25	10
2320	2026-05-19 23:00:00	34	15
2326	2026-05-19 23:00:00	31	20
2330	2026-05-19 23:00:00	21	20
2336	2026-05-19 23:00:00	35	15
2344	2026-05-19 23:00:00	22	29.5
2350	2026-05-19 23:00:00	24	10
2351	2026-05-20 00:00:00	3	168.6
2356	2026-05-20 00:00:00	39	10
2361	2026-05-20 00:00:00	1	12
2367	2026-05-20 00:00:00	40	10
2369	2026-05-20 00:00:00	2	24.78
2375	2026-05-20 00:00:00	5	15
2383	2026-05-20 00:00:00	36	20
2384	2026-05-20 00:00:00	4	15
2393	2026-05-20 00:00:00	37	29.54
2397	2026-05-20 00:00:00	38	192
2403	2026-05-20 01:00:00	14	10
2410	2026-05-20 01:00:00	48	192
2412	2026-05-20 01:00:00	13	192
2421	2026-05-20 01:00:00	15	10
2425	2026-05-20 01:00:00	49	10
2428	2026-05-20 01:00:00	11	20
2436	2026-05-20 01:00:00	12	29.59
2438	2026-05-20 01:00:00	46	20
2445	2026-05-20 01:00:00	47	29.6
2450	2026-05-20 01:00:00	50	10
2451	2026-05-20 02:00:00	3	168.6
2458	2026-05-20 02:00:00	38	192
2464	2026-05-20 02:00:00	1	12
2468	2026-05-20 02:00:00	39	10
2480	2026-05-20 02:00:00	40	10
2481	2026-05-20 02:00:00	2	24.89
2492	2026-05-20 02:00:00	36	20
2493	2026-05-20 02:00:00	5	15
2498	2026-05-20 02:00:00	37	29.57
2500	2026-05-20 02:00:00	4	15
2501	2026-05-20 03:00:00	1	12
2503	2026-05-20 03:00:00	13	192
2511	2026-05-20 03:00:00	15	10
2518	2026-05-20 03:00:00	2	24.74
2521	2026-05-20 03:00:00	11	20
657	2026-05-18 14:00:00	32	28.88
671	2026-05-18 14:00:00	33	195
682	2026-05-18 14:00:00	34	15
692	2026-05-18 14:00:00	31	20
698	2026-05-18 14:00:00	35	15
702	2026-05-18 15:00:00	9	15
716	2026-05-18 15:00:00	7	24.99
725	2026-05-18 15:00:00	6	12
735	2026-05-18 15:00:00	8	168.6
750	2026-05-18 15:00:00	10	15
751	2026-05-18 16:00:00	3	168.6
765	2026-05-18 16:00:00	1	12
778	2026-05-18 16:00:00	2	24.84
789	2026-05-18 16:00:00	5	15
797	2026-05-18 16:00:00	4	15
802	2026-05-18 17:00:00	17	29.73
811	2026-05-18 17:00:00	18	192
820	2026-05-18 17:00:00	16	20
829	2026-05-18 17:00:00	19	10
841	2026-05-18 17:00:00	20	10
855	2026-05-18 18:00:00	28	195
870	2026-05-18 18:00:00	26	20
885	2026-05-18 18:00:00	30	15
895	2026-05-18 18:00:00	27	28.91
899	2026-05-18 18:00:00	29	15
902	2026-05-18 19:00:00	9	15
912	2026-05-18 19:00:00	7	24.99
921	2026-05-18 19:00:00	6	12
930	2026-05-18 19:00:00	8	168.6
937	2026-05-18 19:00:00	10	15
956	2026-05-18 20:00:00	28	195
964	2026-05-18 20:00:00	26	20
972	2026-05-18 20:00:00	30	15
978	2026-05-18 20:00:00	27	29.05
986	2026-05-18 20:00:00	29	15
1008	2026-05-18 21:00:00	45	10
1015	2026-05-18 21:00:00	41	20
1022	2026-05-18 21:00:00	42	29.52
1030	2026-05-18 21:00:00	43	192
1037	2026-05-18 21:00:00	44	10
2055	2026-05-19 18:00:00	21	20
2065	2026-05-19 18:00:00	22	29.7
2075	2026-05-19 18:00:00	24	10
2084	2026-05-19 18:00:00	23	192
2094	2026-05-19 18:00:00	25	10
2106	2026-05-19 19:00:00	26	20
2115	2026-05-19 19:00:00	30	15
2124	2026-05-19 19:00:00	27	29.01
2138	2026-05-19 19:00:00	29	15
2145	2026-05-19 19:00:00	28	195
2156	2026-05-19 20:00:00	33	195
2168	2026-05-19 20:00:00	34	15
2181	2026-05-19 20:00:00	31	20
2193	2026-05-19 20:00:00	35	15
2198	2026-05-19 20:00:00	32	28.92
2202	2026-05-19 21:00:00	10	15
2214	2026-05-19 21:00:00	9	15
2224	2026-05-19 21:00:00	7	24.8
2237	2026-05-19 21:00:00	6	12
2242	2026-05-19 21:00:00	8	168.6
2255	2026-05-19 22:00:00	30	15
2264	2026-05-19 22:00:00	27	28.89
2274	2026-05-19 22:00:00	29	15
2287	2026-05-19 22:00:00	28	195
2297	2026-05-19 22:00:00	26	20
2303	2026-05-19 23:00:00	11	20
2319	2026-05-19 23:00:00	12	29.51
2331	2026-05-19 23:00:00	14	10
2343	2026-05-19 23:00:00	13	192
2349	2026-05-19 23:00:00	15	10
2352	2026-05-20 00:00:00	8	168.6
2362	2026-05-20 00:00:00	10	15
2371	2026-05-20 00:00:00	9	15
2378	2026-05-20 00:00:00	7	24.82
2387	2026-05-20 00:00:00	6	12
2409	2026-05-20 01:00:00	41	20
2415	2026-05-20 01:00:00	42	29.73
2424	2026-05-20 01:00:00	43	192
2432	2026-05-20 01:00:00	44	10
2440	2026-05-20 01:00:00	45	10
2457	2026-05-20 02:00:00	34	15
2465	2026-05-20 02:00:00	31	20
2474	2026-05-20 02:00:00	35	15
2482	2026-05-20 02:00:00	32	29
2487	2026-05-20 02:00:00	33	195
2509	2026-05-20 03:00:00	46	20
2517	2026-05-20 03:00:00	47	29.61
2533	2026-05-20 03:00:00	50	10
2544	2026-05-20 03:00:00	48	192
2549	2026-05-20 03:00:00	49	10
3056	2026-05-20 14:00:00	36	40
3063	2026-05-20 14:00:00	39	10.5
3070	2026-05-20 14:00:00	40	10.5
3078	2026-05-20 14:00:00	37	40.14
3088	2026-05-20 14:00:00	38	258.3
3109	2026-05-20 15:00:00	39	10.5
3120	2026-05-20 15:00:00	40	10.5
3136	2026-05-20 15:00:00	37	40.03
3146	2026-05-20 15:00:00	38	258.3
3150	2026-05-20 15:00:00	36	40
3151	2026-05-20 16:00:00	3	168.6
3166	2026-05-20 16:00:00	2	24.98
3177	2026-05-20 16:00:00	5	15
3189	2026-05-20 16:00:00	1	12
3196	2026-05-20 16:00:00	4	15
3205	2026-05-20 17:00:00	22	40.06
3215	2026-05-20 17:00:00	24	10
3224	2026-05-20 17:00:00	23	258
3236	2026-05-20 17:00:00	25	10
3245	2026-05-20 17:00:00	21	40
3252	2026-05-20 18:00:00	22	40.12
3261	2026-05-20 18:00:00	24	10
3270	2026-05-20 18:00:00	23	258
3280	2026-05-20 18:00:00	25	10
3289	2026-05-20 18:00:00	21	40
3308	2026-05-20 19:00:00	48	259.2
3319	2026-05-20 19:00:00	49	12
3324	2026-05-20 19:00:00	47	39.85
3336	2026-05-20 19:00:00	50	12
3346	2026-05-20 19:00:00	46	40
3353	2026-05-20 20:00:00	21	40
3362	2026-05-20 20:00:00	22	40.04
3374	2026-05-20 20:00:00	24	10
3389	2026-05-20 20:00:00	23	258
3395	2026-05-20 20:00:00	25	10
3405	2026-05-20 21:00:00	25	10
3415	2026-05-20 21:00:00	21	40
3426	2026-05-20 21:00:00	22	39.97
3439	2026-05-20 21:00:00	24	10
3446	2026-05-20 21:00:00	23	258
3460	2026-05-20 22:00:00	25	10
3474	2026-05-20 22:00:00	21	40
3486	2026-05-20 22:00:00	22	40.22
3492	2026-05-20 22:00:00	24	10
3498	2026-05-20 22:00:00	23	258
3502	2026-05-20 23:00:00	15	10
655	2026-05-18 14:00:00	25	14.75
667	2026-05-18 14:00:00	21	20
679	2026-05-18 14:00:00	22	29.02
690	2026-05-18 14:00:00	24	14.75
699	2026-05-18 14:00:00	23	194.85
701	2026-05-18 15:00:00	2	24.82
717	2026-05-18 15:00:00	5	15
727	2026-05-18 15:00:00	4	15
736	2026-05-18 15:00:00	3	168.6
747	2026-05-18 15:00:00	1	12
754	2026-05-18 16:00:00	17	29.74
761	2026-05-18 16:00:00	18	192
770	2026-05-18 16:00:00	16	20
775	2026-05-18 16:00:00	19	10
788	2026-05-18 16:00:00	20	10
805	2026-05-18 17:00:00	36	20
812	2026-05-18 17:00:00	37	29.57
821	2026-05-18 17:00:00	38	192
830	2026-05-18 17:00:00	39	10
839	2026-05-18 17:00:00	40	10
860	2026-05-18 18:00:00	48	192
865	2026-05-18 18:00:00	49	10
875	2026-05-18 18:00:00	46	20
882	2026-05-18 18:00:00	47	29.51
889	2026-05-18 18:00:00	50	10
908	2026-05-18 19:00:00	39	10
917	2026-05-18 19:00:00	40	10
928	2026-05-18 19:00:00	36	20
935	2026-05-18 19:00:00	37	29.65
941	2026-05-18 19:00:00	38	192
957	2026-05-18 20:00:00	31	20
966	2026-05-18 20:00:00	35	15
976	2026-05-18 20:00:00	32	29.06
987	2026-05-18 20:00:00	33	195
996	2026-05-18 20:00:00	34	15
1006	2026-05-18 21:00:00	24	10
1016	2026-05-18 21:00:00	23	192
1023	2026-05-18 21:00:00	25	10
1031	2026-05-18 21:00:00	21	20
1038	2026-05-18 21:00:00	22	29.66
2056	2026-05-19 18:00:00	28	197.85
2064	2026-05-19 18:00:00	26	20
2074	2026-05-19 18:00:00	30	19.75
2089	2026-05-19 18:00:00	27	28.38
2098	2026-05-19 18:00:00	29	19.75
2104	2026-05-19 19:00:00	12	29.52
2113	2026-05-19 19:00:00	14	10
2122	2026-05-19 19:00:00	13	192
2127	2026-05-19 19:00:00	15	10
2136	2026-05-19 19:00:00	11	20
2160	2026-05-19 20:00:00	38	192
2171	2026-05-19 20:00:00	39	10
2184	2026-05-19 20:00:00	40	10
2196	2026-05-19 20:00:00	36	20
2200	2026-05-19 20:00:00	37	29.61
2201	2026-05-19 21:00:00	1	12
2211	2026-05-19 21:00:00	2	24.96
2219	2026-05-19 21:00:00	5	15
2228	2026-05-19 21:00:00	4	15
2236	2026-05-19 21:00:00	3	168.6
2260	2026-05-19 22:00:00	43	192
2265	2026-05-19 22:00:00	44	10
2277	2026-05-19 22:00:00	45	10
2289	2026-05-19 22:00:00	41	20
2299	2026-05-19 22:00:00	42	29.57
2302	2026-05-19 23:00:00	9	15
2316	2026-05-19 23:00:00	7	24.72
2328	2026-05-19 23:00:00	6	12
2337	2026-05-19 23:00:00	8	168.6
2347	2026-05-19 23:00:00	10	15
2358	2026-05-20 00:00:00	21	20
2364	2026-05-20 00:00:00	22	29.46
2373	2026-05-20 00:00:00	24	10
2380	2026-05-20 00:00:00	23	192
2389	2026-05-20 00:00:00	25	10
2407	2026-05-20 01:00:00	34	15
2418	2026-05-20 01:00:00	31	20
2433	2026-05-20 01:00:00	35	15
2441	2026-05-20 01:00:00	32	29.03
2446	2026-05-20 01:00:00	33	195
2454	2026-05-20 02:00:00	18	192
2466	2026-05-20 02:00:00	16	20
2475	2026-05-20 02:00:00	19	10
2485	2026-05-20 02:00:00	20	10
2495	2026-05-20 02:00:00	17	29.7
2506	2026-05-20 03:00:00	16	20
2513	2026-05-20 03:00:00	19	10
2523	2026-05-20 03:00:00	20	10
2529	2026-05-20 03:00:00	17	29.53
2539	2026-05-20 03:00:00	18	192
3055	2026-05-20 14:00:00	28	261.75
3064	2026-05-20 14:00:00	30	16.25
3071	2026-05-20 14:00:00	27	39.1
3080	2026-05-20 14:00:00	29	16.25
3093	2026-05-20 14:00:00	26	40
3105	2026-05-20 15:00:00	30	16.25
3115	2026-05-20 15:00:00	27	39.06
3125	2026-05-20 15:00:00	29	16.25
3133	2026-05-20 15:00:00	26	40
3141	2026-05-20 15:00:00	28	261.75
3160	2026-05-20 16:00:00	32	39.18
3169	2026-05-20 16:00:00	31	40
3181	2026-05-20 16:00:00	33	261.6
3190	2026-05-20 16:00:00	34	16
3198	2026-05-20 16:00:00	35	16
3206	2026-05-20 17:00:00	16	40
3212	2026-05-20 17:00:00	19	38.75
3221	2026-05-20 17:00:00	20	38.75
3228	2026-05-20 17:00:00	17	35.18
3234	2026-05-20 17:00:00	18	275.25
3257	2026-05-20 18:00:00	41	40
3265	2026-05-20 18:00:00	42	39.92
3274	2026-05-20 18:00:00	43	258.3
3281	2026-05-20 18:00:00	44	10.5
3291	2026-05-20 18:00:00	45	10.5
3307	2026-05-20 19:00:00	42	40.13
3315	2026-05-20 19:00:00	43	258.3
3326	2026-05-20 19:00:00	44	10.5
3339	2026-05-20 19:00:00	45	10.5
3347	2026-05-20 19:00:00	41	40
3357	2026-05-20 20:00:00	19	38.5
3371	2026-05-20 20:00:00	20	38.5
3380	2026-05-20 20:00:00	17	35.14
3388	2026-05-20 20:00:00	18	275.1
3393	2026-05-20 20:00:00	16	40
3410	2026-05-20 21:00:00	38	258.3
3420	2026-05-20 21:00:00	36	40
3433	2026-05-20 21:00:00	39	10.5
3443	2026-05-20 21:00:00	40	10.5
3449	2026-05-20 21:00:00	37	40.04
3458	2026-05-20 22:00:00	10	15
3464	2026-05-20 22:00:00	9	15
3473	2026-05-20 22:00:00	6	12
3478	2026-05-20 22:00:00	7	24.72
3491	2026-05-20 22:00:00	8	168.6
3507	2026-05-20 23:00:00	35	16.25
656	2026-05-18 14:00:00	39	13.75
668	2026-05-18 14:00:00	40	13.75
681	2026-05-18 14:00:00	36	20
693	2026-05-18 14:00:00	37	29.01
700	2026-05-18 14:00:00	38	194.25
703	2026-05-18 15:00:00	15	10
711	2026-05-18 15:00:00	11	20
721	2026-05-18 15:00:00	12	29.58
732	2026-05-18 15:00:00	14	10
742	2026-05-18 15:00:00	13	192
758	2026-05-18 16:00:00	36	20
768	2026-05-18 16:00:00	37	29.64
781	2026-05-18 16:00:00	38	192
791	2026-05-18 16:00:00	39	10
795	2026-05-18 16:00:00	40	10
804	2026-05-18 17:00:00	24	10
819	2026-05-18 17:00:00	23	192
835	2026-05-18 17:00:00	25	10
846	2026-05-18 17:00:00	21	20
850	2026-05-18 17:00:00	22	29.59
851	2026-05-18 18:00:00	3	168.6
866	2026-05-18 18:00:00	1	12
879	2026-05-18 18:00:00	2	24.86
893	2026-05-18 18:00:00	5	15
898	2026-05-18 18:00:00	4	15
903	2026-05-18 19:00:00	15	10
913	2026-05-18 19:00:00	11	20
922	2026-05-18 19:00:00	12	29.66
931	2026-05-18 19:00:00	14	10
942	2026-05-18 19:00:00	13	192
959	2026-05-18 20:00:00	36	20
971	2026-05-18 20:00:00	37	29.46
982	2026-05-18 20:00:00	38	192
989	2026-05-18 20:00:00	39	10
993	2026-05-18 20:00:00	40	10
1009	2026-05-18 21:00:00	36	20
1018	2026-05-18 21:00:00	37	29.58
1025	2026-05-18 21:00:00	38	192
1035	2026-05-18 21:00:00	39	10
1045	2026-05-18 21:00:00	40	10
2057	2026-05-19 18:00:00	32	28.94
2066	2026-05-19 18:00:00	33	195
2076	2026-05-19 18:00:00	34	15
2090	2026-05-19 18:00:00	31	20
2095	2026-05-19 18:00:00	35	15
2105	2026-05-19 19:00:00	22	29.58
2118	2026-05-19 19:00:00	24	10
2131	2026-05-19 19:00:00	23	192
2143	2026-05-19 19:00:00	25	10
2150	2026-05-19 19:00:00	21	20
2152	2026-05-19 20:00:00	9	15
2161	2026-05-19 20:00:00	7	24.93
2169	2026-05-19 20:00:00	6	12
2177	2026-05-19 20:00:00	8	168.6
2190	2026-05-19 20:00:00	10	15
2207	2026-05-19 21:00:00	35	15
2218	2026-05-19 21:00:00	32	28.96
2230	2026-05-19 21:00:00	33	195
2243	2026-05-19 21:00:00	34	15
2249	2026-05-19 21:00:00	31	20
2254	2026-05-19 22:00:00	15	10
2263	2026-05-19 22:00:00	11	20
2275	2026-05-19 22:00:00	12	29.53
2283	2026-05-19 22:00:00	14	10
2291	2026-05-19 22:00:00	13	192
2308	2026-05-19 23:00:00	50	10
2313	2026-05-19 23:00:00	48	192
2321	2026-05-19 23:00:00	49	10
2329	2026-05-19 23:00:00	46	20
2338	2026-05-19 23:00:00	47	29.55
2357	2026-05-20 00:00:00	46	20
2366	2026-05-20 00:00:00	47	29.67
2376	2026-05-20 00:00:00	50	10
2385	2026-05-20 00:00:00	48	192
2392	2026-05-20 00:00:00	49	10
2406	2026-05-20 01:00:00	29	15
2411	2026-05-20 01:00:00	28	195
2420	2026-05-20 01:00:00	26	20
2427	2026-05-20 01:00:00	30	15
2435	2026-05-20 01:00:00	27	28.98
2460	2026-05-20 02:00:00	48	192
2462	2026-05-20 02:00:00	49	10
2472	2026-05-20 02:00:00	46	20
2478	2026-05-20 02:00:00	47	29.65
2489	2026-05-20 02:00:00	50	10
2505	2026-05-20 03:00:00	39	10
2514	2026-05-20 03:00:00	40	10
2524	2026-05-20 03:00:00	36	20
2530	2026-05-20 03:00:00	37	29.53
2541	2026-05-20 03:00:00	38	192
3057	2026-05-20 14:00:00	20	38.5
3069	2026-05-20 14:00:00	17	35.01
3083	2026-05-20 14:00:00	18	275.1
3092	2026-05-20 14:00:00	16	40
3097	2026-05-20 14:00:00	19	38.5
3104	2026-05-20 15:00:00	18	275.1
3113	2026-05-20 15:00:00	16	40
3123	2026-05-20 15:00:00	19	38.5
3129	2026-05-20 15:00:00	20	38.5
3138	2026-05-20 15:00:00	17	35.22
3157	2026-05-20 16:00:00	41	40
3164	2026-05-20 16:00:00	42	39.95
3173	2026-05-20 16:00:00	43	258.45
3179	2026-05-20 16:00:00	44	10.75
3187	2026-05-20 16:00:00	45	10.75
3208	2026-05-20 17:00:00	36	40
3216	2026-05-20 17:00:00	39	10.5
3225	2026-05-20 17:00:00	40	10.5
3235	2026-05-20 17:00:00	37	40.02
3241	2026-05-20 17:00:00	38	258.3
3260	2026-05-20 18:00:00	34	16
3267	2026-05-20 18:00:00	35	16
3276	2026-05-20 18:00:00	32	38.99
3287	2026-05-20 18:00:00	31	40
3297	2026-05-20 18:00:00	33	261.6
3303	2026-05-20 19:00:00	11	40
3318	2026-05-20 19:00:00	13	258
3332	2026-05-20 19:00:00	15	10
3341	2026-05-20 19:00:00	12	55.04
3349	2026-05-20 19:00:00	14	10
3354	2026-05-20 20:00:00	15	10
3367	2026-05-20 20:00:00	12	55.23
3376	2026-05-20 20:00:00	14	10
3385	2026-05-20 20:00:00	11	40
3398	2026-05-20 20:00:00	13	258
3403	2026-05-20 21:00:00	13	258
3416	2026-05-20 21:00:00	15	10
3425	2026-05-20 21:00:00	12	55.12
3436	2026-05-20 21:00:00	14	10
3444	2026-05-20 21:00:00	11	40
3453	2026-05-20 22:00:00	16	40
3467	2026-05-20 22:00:00	19	38.5
3481	2026-05-20 22:00:00	20	38.5
3487	2026-05-20 22:00:00	17	35.16
3496	2026-05-20 22:00:00	18	275.1
3506	2026-05-20 23:00:00	27	38.91
658	2026-05-18 14:00:00	41	20
663	2026-05-18 14:00:00	42	29.68
672	2026-05-18 14:00:00	43	192
677	2026-05-18 14:00:00	44	10
688	2026-05-18 14:00:00	45	10
708	2026-05-18 15:00:00	40	13.75
720	2026-05-18 15:00:00	36	20
730	2026-05-18 15:00:00	37	29.03
739	2026-05-18 15:00:00	38	194.25
745	2026-05-18 15:00:00	39	13.75
757	2026-05-18 16:00:00	28	197.85
764	2026-05-18 16:00:00	26	20
773	2026-05-18 16:00:00	30	19.75
782	2026-05-18 16:00:00	27	28.36
792	2026-05-18 16:00:00	29	19.75
809	2026-05-18 17:00:00	31	20
818	2026-05-18 17:00:00	35	15
827	2026-05-18 17:00:00	32	28.86
836	2026-05-18 17:00:00	33	195
844	2026-05-18 17:00:00	34	15
858	2026-05-18 18:00:00	31	20
863	2026-05-18 18:00:00	35	15
873	2026-05-18 18:00:00	32	28.95
878	2026-05-18 18:00:00	33	195
891	2026-05-18 18:00:00	34	15
907	2026-05-18 19:00:00	26	20
914	2026-05-18 19:00:00	30	15
923	2026-05-18 19:00:00	27	28.89
929	2026-05-18 19:00:00	29	15
936	2026-05-18 19:00:00	28	195
960	2026-05-18 20:00:00	50	10
970	2026-05-18 20:00:00	48	192
983	2026-05-18 20:00:00	49	10
991	2026-05-18 20:00:00	46	20
999	2026-05-18 20:00:00	47	29.68
1003	2026-05-18 21:00:00	10	15
1017	2026-05-18 21:00:00	9	15
1024	2026-05-18 21:00:00	7	24.88
1036	2026-05-18 21:00:00	6	12
1046	2026-05-18 21:00:00	8	168.6
2058	2026-05-19 18:00:00	36	20
2059	2026-05-19 18:00:00	43	192
2070	2026-05-19 18:00:00	44	10
2071	2026-05-19 18:00:00	37	29.5
2085	2026-05-19 18:00:00	45	10
2086	2026-05-19 18:00:00	38	192
2092	2026-05-19 18:00:00	41	20
2096	2026-05-19 18:00:00	39	10
2097	2026-05-19 18:00:00	42	29.51
2100	2026-05-19 18:00:00	40	10
2101	2026-05-19 19:00:00	3	168.6
2103	2026-05-19 19:00:00	20	10
2114	2026-05-19 19:00:00	1	12
2119	2026-05-19 19:00:00	17	29.48
2130	2026-05-19 19:00:00	2	24.97
2132	2026-05-19 19:00:00	18	192
2139	2026-05-19 19:00:00	5	15
2141	2026-05-19 19:00:00	16	20
2146	2026-05-19 19:00:00	19	10
2147	2026-05-19 19:00:00	4	15
2154	2026-05-19 20:00:00	23	192
2157	2026-05-19 20:00:00	27	29
2164	2026-05-19 20:00:00	25	10
2166	2026-05-19 20:00:00	29	15
2173	2026-05-19 20:00:00	21	20
2180	2026-05-19 20:00:00	28	195
2182	2026-05-19 20:00:00	22	29.64
2187	2026-05-19 20:00:00	26	20
2192	2026-05-19 20:00:00	30	15
2195	2026-05-19 20:00:00	24	10
2205	2026-05-19 21:00:00	24	10
2208	2026-05-19 21:00:00	36	20
2215	2026-05-19 21:00:00	23	192
2217	2026-05-19 21:00:00	37	29.56
2225	2026-05-19 21:00:00	25	10
2231	2026-05-19 21:00:00	21	20
2232	2026-05-19 21:00:00	38	192
2238	2026-05-19 21:00:00	22	29.69
2239	2026-05-19 21:00:00	39	10
2245	2026-05-19 21:00:00	40	10
2256	2026-05-19 22:00:00	24	10
2257	2026-05-19 22:00:00	36	20
2267	2026-05-19 22:00:00	23	192
2270	2026-05-19 22:00:00	37	29.5
2273	2026-05-19 22:00:00	25	10
2280	2026-05-19 22:00:00	38	192
2282	2026-05-19 22:00:00	21	20
2290	2026-05-19 22:00:00	22	29.58
2293	2026-05-19 22:00:00	39	10
2300	2026-05-19 22:00:00	40	10
2301	2026-05-19 23:00:00	2	24.81
2310	2026-05-19 23:00:00	37	29.6
2311	2026-05-19 23:00:00	5	15
2323	2026-05-19 23:00:00	38	192
2325	2026-05-19 23:00:00	4	15
2332	2026-05-19 23:00:00	39	10
2335	2026-05-19 23:00:00	3	168.6
2339	2026-05-19 23:00:00	40	10
2342	2026-05-19 23:00:00	1	12
2345	2026-05-19 23:00:00	36	20
2353	2026-05-20 00:00:00	16	20
2359	2026-05-20 00:00:00	35	15
2365	2026-05-20 00:00:00	19	10
2370	2026-05-20 00:00:00	32	28.86
2377	2026-05-20 00:00:00	20	10
2386	2026-05-20 00:00:00	33	195
2391	2026-05-20 00:00:00	17	29.45
2395	2026-05-20 00:00:00	34	15
2396	2026-05-20 00:00:00	18	192
2400	2026-05-20 00:00:00	31	20
2401	2026-05-20 01:00:00	3	168.6
2405	2026-05-20 01:00:00	21	20
2413	2026-05-20 01:00:00	22	29.57
2417	2026-05-20 01:00:00	1	12
2422	2026-05-20 01:00:00	24	10
2429	2026-05-20 01:00:00	23	192
2431	2026-05-20 01:00:00	2	24.81
2437	2026-05-20 01:00:00	25	10
2442	2026-05-20 01:00:00	5	15
2448	2026-05-20 01:00:00	4	15
2452	2026-05-20 02:00:00	10	15
2459	2026-05-20 02:00:00	41	20
2461	2026-05-20 02:00:00	9	15
2463	2026-05-20 02:00:00	42	29.57
2471	2026-05-20 02:00:00	7	24.75
2473	2026-05-20 02:00:00	43	192
2477	2026-05-20 02:00:00	6	12
2479	2026-05-20 02:00:00	44	10
2490	2026-05-20 02:00:00	45	10
2491	2026-05-20 02:00:00	8	168.6
2507	2026-05-20 03:00:00	43	192
2510	2026-05-20 03:00:00	35	15
2515	2026-05-20 03:00:00	44	10
2520	2026-05-20 03:00:00	32	28.85
2525	2026-05-20 03:00:00	45	10
2531	2026-05-20 03:00:00	41	20
659	2026-05-18 14:00:00	29	19.75
666	2026-05-18 14:00:00	28	197.85
674	2026-05-18 14:00:00	26	20
684	2026-05-18 14:00:00	30	19.75
694	2026-05-18 14:00:00	27	28.35
706	2026-05-18 15:00:00	33	195
719	2026-05-18 15:00:00	34	15
731	2026-05-18 15:00:00	31	20
743	2026-05-18 15:00:00	35	15
749	2026-05-18 15:00:00	32	29.11
752	2026-05-18 16:00:00	8	168.6
766	2026-05-18 16:00:00	10	15
779	2026-05-18 16:00:00	9	15
790	2026-05-18 16:00:00	7	24.99
798	2026-05-18 16:00:00	6	12
808	2026-05-18 17:00:00	14	10
825	2026-05-18 17:00:00	13	192
834	2026-05-18 17:00:00	15	10
845	2026-05-18 17:00:00	11	20
849	2026-05-18 17:00:00	12	29.64
853	2026-05-18 18:00:00	8	168.6
868	2026-05-18 18:00:00	10	15
881	2026-05-18 18:00:00	9	15
892	2026-05-18 18:00:00	7	24.72
900	2026-05-18 18:00:00	6	12
901	2026-05-18 19:00:00	2	24.75
915	2026-05-18 19:00:00	5	15
927	2026-05-18 19:00:00	4	15
940	2026-05-18 19:00:00	3	168.6
946	2026-05-18 19:00:00	1	12
954	2026-05-18 20:00:00	24	10
963	2026-05-18 20:00:00	23	192
973	2026-05-18 20:00:00	25	10
985	2026-05-18 20:00:00	21	20
995	2026-05-18 20:00:00	22	29.51
1010	2026-05-18 21:00:00	28	195
1020	2026-05-18 21:00:00	26	20
1032	2026-05-18 21:00:00	30	15
1043	2026-05-18 21:00:00	27	29.04
1048	2026-05-18 21:00:00	29	15
1051	2026-05-18 22:00:00	1	12
1055	2026-05-18 22:00:00	15	10
1056	2026-05-18 22:00:00	17	29.68
1059	2026-05-18 22:00:00	45	10
1058	2026-05-18 22:00:00	35	15
1061	2026-05-18 22:00:00	2	24.78
1064	2026-05-18 22:00:00	11	20
1065	2026-05-18 22:00:00	18	192
1068	2026-05-18 22:00:00	5	15
1069	2026-05-18 22:00:00	41	20
1070	2026-05-18 22:00:00	32	28.91
1073	2026-05-18 22:00:00	12	29.73
1074	2026-05-18 22:00:00	16	20
1080	2026-05-18 22:00:00	4	15
1081	2026-05-18 22:00:00	19	10
1083	2026-05-18 22:00:00	14	10
1084	2026-05-18 22:00:00	42	29.54
1085	2026-05-18 22:00:00	33	195
1090	2026-05-18 22:00:00	20	10
1092	2026-05-18 22:00:00	3	168.6
1093	2026-05-18 22:00:00	43	192
1094	2026-05-18 22:00:00	34	15
1095	2026-05-18 22:00:00	13	192
1097	2026-05-18 22:00:00	31	20
1099	2026-05-18 22:00:00	44	10
1102	2026-05-18 23:00:00	8	168.6
1103	2026-05-18 23:00:00	23	192
1105	2026-05-18 23:00:00	16	20
1109	2026-05-18 23:00:00	38	192
1110	2026-05-18 23:00:00	30	15
1113	2026-05-18 23:00:00	25	10
1114	2026-05-18 23:00:00	10	15
1118	2026-05-18 23:00:00	19	10
1119	2026-05-18 23:00:00	27	29
1120	2026-05-18 23:00:00	39	10
1122	2026-05-18 23:00:00	21	20
1123	2026-05-18 23:00:00	9	15
1125	2026-05-18 23:00:00	20	10
1128	2026-05-18 23:00:00	22	29.74
1131	2026-05-18 23:00:00	40	10
1132	2026-05-18 23:00:00	29	15
1134	2026-05-18 23:00:00	24	10
1136	2026-05-18 23:00:00	7	24.93
1137	2026-05-18 23:00:00	17	29.5
1141	2026-05-18 23:00:00	36	20
1143	2026-05-18 23:00:00	28	195
1144	2026-05-18 23:00:00	6	12
1145	2026-05-18 23:00:00	18	192
1149	2026-05-18 23:00:00	26	20
1150	2026-05-18 23:00:00	37	29.5
1151	2026-05-19 00:00:00	1	12
1152	2026-05-19 00:00:00	7	24.85
1156	2026-05-19 00:00:00	29	15
1157	2026-05-19 00:00:00	31	20
1160	2026-05-19 00:00:00	44	10
1164	2026-05-19 00:00:00	28	195
1165	2026-05-19 00:00:00	2	24.82
1166	2026-05-19 00:00:00	6	12
1169	2026-05-19 00:00:00	35	15
1170	2026-05-19 00:00:00	45	10
1174	2026-05-19 00:00:00	26	20
1176	2026-05-19 00:00:00	8	168.6
1177	2026-05-19 00:00:00	5	15
1179	2026-05-19 00:00:00	32	29.09
1182	2026-05-19 00:00:00	30	15
1183	2026-05-19 00:00:00	41	20
1187	2026-05-19 00:00:00	10	15
1188	2026-05-19 00:00:00	4	15
1190	2026-05-19 00:00:00	33	195
1191	2026-05-19 00:00:00	27	28.9
1193	2026-05-19 00:00:00	42	29.59
1195	2026-05-19 00:00:00	3	168.6
1196	2026-05-19 00:00:00	9	15
1197	2026-05-19 00:00:00	43	192
1198	2026-05-19 00:00:00	34	15
1201	2026-05-19 01:00:00	1	12
1203	2026-05-19 01:00:00	29	15
1208	2026-05-19 01:00:00	7	24.89
1209	2026-05-19 01:00:00	24	10
1210	2026-05-19 01:00:00	34	15
1211	2026-05-19 01:00:00	2	25.01
1212	2026-05-19 01:00:00	28	195
1215	2026-05-19 01:00:00	6	12
1217	2026-05-19 01:00:00	23	192
1220	2026-05-19 01:00:00	31	20
1221	2026-05-19 01:00:00	26	20
1225	2026-05-19 01:00:00	5	15
1226	2026-05-19 01:00:00	30	15
1229	2026-05-19 01:00:00	8	168.6
1230	2026-05-19 01:00:00	25	10
1234	2026-05-19 01:00:00	35	15
1235	2026-05-19 01:00:00	27	29
1238	2026-05-19 01:00:00	4	15
1240	2026-05-19 01:00:00	10	15
1241	2026-05-19 01:00:00	38	192
1242	2026-05-19 01:00:00	21	20
660	2026-05-18 14:00:00	49	14.75
670	2026-05-18 14:00:00	46	20
678	2026-05-18 14:00:00	47	29.12
689	2026-05-18 14:00:00	50	14.75
697	2026-05-18 14:00:00	48	194.85
704	2026-05-18 15:00:00	18	192
712	2026-05-18 15:00:00	16	20
722	2026-05-18 15:00:00	19	10
729	2026-05-18 15:00:00	20	10
740	2026-05-18 15:00:00	17	29.48
759	2026-05-18 16:00:00	41	20
767	2026-05-18 16:00:00	42	29.7
777	2026-05-18 16:00:00	43	192
785	2026-05-18 16:00:00	44	10
794	2026-05-18 16:00:00	45	10
806	2026-05-18 17:00:00	28	195
814	2026-05-18 17:00:00	26	20
824	2026-05-18 17:00:00	30	15
832	2026-05-18 17:00:00	27	28.91
843	2026-05-18 17:00:00	29	15
854	2026-05-18 18:00:00	24	10
869	2026-05-18 18:00:00	23	192
884	2026-05-18 18:00:00	25	10
890	2026-05-18 18:00:00	21	20
897	2026-05-18 18:00:00	22	29.45
906	2026-05-18 19:00:00	19	10
918	2026-05-18 19:00:00	20	10
933	2026-05-18 19:00:00	17	29.63
943	2026-05-18 19:00:00	18	192
948	2026-05-18 19:00:00	16	20
953	2026-05-18 20:00:00	13	192
962	2026-05-18 20:00:00	15	10
974	2026-05-18 20:00:00	11	20
984	2026-05-18 20:00:00	12	29.61
994	2026-05-18 20:00:00	14	10
1005	2026-05-18 21:00:00	31	20
1013	2026-05-18 21:00:00	35	15
1027	2026-05-18 21:00:00	32	28.91
1040	2026-05-18 21:00:00	33	195
1047	2026-05-18 21:00:00	34	15
1053	2026-05-18 22:00:00	24	10
1052	2026-05-18 22:00:00	6	12
1054	2026-05-18 22:00:00	28	195
1057	2026-05-18 22:00:00	36	20
1060	2026-05-18 22:00:00	47	29.5
1062	2026-05-18 22:00:00	23	192
1063	2026-05-18 22:00:00	37	29.45
1066	2026-05-18 22:00:00	26	20
1067	2026-05-18 22:00:00	8	168.6
1071	2026-05-18 22:00:00	25	10
1072	2026-05-18 22:00:00	38	192
1075	2026-05-18 22:00:00	30	15
1076	2026-05-18 22:00:00	50	10
1077	2026-05-18 22:00:00	21	20
1078	2026-05-18 22:00:00	39	10
1079	2026-05-18 22:00:00	10	15
1082	2026-05-18 22:00:00	27	29.1
1086	2026-05-18 22:00:00	22	29.56
1087	2026-05-18 22:00:00	40	10
1088	2026-05-18 22:00:00	48	192
1089	2026-05-18 22:00:00	29	15
1091	2026-05-18 22:00:00	9	15
1096	2026-05-18 22:00:00	49	10
1098	2026-05-18 22:00:00	7	24.8
1100	2026-05-18 22:00:00	46	20
1101	2026-05-18 23:00:00	5	15
1104	2026-05-18 23:00:00	12	29.69
1106	2026-05-18 23:00:00	32	29.08
1107	2026-05-18 23:00:00	50	10
1108	2026-05-18 23:00:00	41	20
1111	2026-05-18 23:00:00	4	15
1112	2026-05-18 23:00:00	14	10
1115	2026-05-18 23:00:00	48	192
1116	2026-05-18 23:00:00	33	195
1117	2026-05-18 23:00:00	42	29.64
1121	2026-05-18 23:00:00	13	192
1124	2026-05-18 23:00:00	43	192
1126	2026-05-18 23:00:00	3	168.6
1127	2026-05-18 23:00:00	15	10
1129	2026-05-18 23:00:00	49	10
1130	2026-05-18 23:00:00	34	15
1133	2026-05-18 23:00:00	11	20
1135	2026-05-18 23:00:00	44	10
1138	2026-05-18 23:00:00	1	12
1139	2026-05-18 23:00:00	31	20
1140	2026-05-18 23:00:00	46	20
1142	2026-05-18 23:00:00	45	10
1146	2026-05-18 23:00:00	2	24.86
1147	2026-05-18 23:00:00	47	29.66
1148	2026-05-18 23:00:00	35	15
1153	2026-05-19 00:00:00	12	29.61
1154	2026-05-19 00:00:00	17	29.58
1155	2026-05-19 00:00:00	24	10
1158	2026-05-19 00:00:00	46	20
1159	2026-05-19 00:00:00	40	10
1161	2026-05-19 00:00:00	18	192
1162	2026-05-19 00:00:00	36	20
1163	2026-05-19 00:00:00	14	10
1167	2026-05-19 00:00:00	23	192
1168	2026-05-19 00:00:00	47	29.69
1171	2026-05-19 00:00:00	16	20
1172	2026-05-19 00:00:00	37	29.51
1173	2026-05-19 00:00:00	25	10
1175	2026-05-19 00:00:00	13	192
1178	2026-05-19 00:00:00	19	10
1180	2026-05-19 00:00:00	50	10
1181	2026-05-19 00:00:00	21	20
1184	2026-05-19 00:00:00	20	10
1185	2026-05-19 00:00:00	38	192
1186	2026-05-19 00:00:00	15	10
1189	2026-05-19 00:00:00	22	29.5
1192	2026-05-19 00:00:00	48	192
1194	2026-05-19 00:00:00	39	10
1199	2026-05-19 00:00:00	11	20
1200	2026-05-19 00:00:00	49	10
1202	2026-05-19 01:00:00	11	20
1204	2026-05-19 01:00:00	17	29.69
1205	2026-05-19 01:00:00	43	192
1206	2026-05-19 01:00:00	40	10
1207	2026-05-19 01:00:00	46	20
1213	2026-05-19 01:00:00	44	10
1214	2026-05-19 01:00:00	47	29.61
1216	2026-05-19 01:00:00	36	20
1218	2026-05-19 01:00:00	18	192
1219	2026-05-19 01:00:00	12	29.7
1222	2026-05-19 01:00:00	45	10
1223	2026-05-19 01:00:00	50	10
1224	2026-05-19 01:00:00	14	10
1227	2026-05-19 01:00:00	41	20
1228	2026-05-19 01:00:00	16	20
1231	2026-05-19 01:00:00	37	29.49
1232	2026-05-19 01:00:00	48	192
1233	2026-05-19 01:00:00	13	192
1236	2026-05-19 01:00:00	42	29.49
1237	2026-05-19 01:00:00	49	10
1239	2026-05-19 01:00:00	19	10
1243	2026-05-19 01:00:00	15	10
1257	2026-05-19 02:00:00	34	15
1266	2026-05-19 02:00:00	31	20
1275	2026-05-19 02:00:00	35	15
1284	2026-05-19 02:00:00	32	28.87
1291	2026-05-19 02:00:00	33	195
1308	2026-05-19 03:00:00	37	29.48
1312	2026-05-19 03:00:00	38	192
1320	2026-05-19 03:00:00	39	10
1325	2026-05-19 03:00:00	40	10
1333	2026-05-19 03:00:00	36	20
1359	2026-05-19 04:00:00	42	29.47
1370	2026-05-19 04:00:00	43	192
1378	2026-05-19 04:00:00	44	10
1388	2026-05-19 04:00:00	45	10
1398	2026-05-19 04:00:00	41	20
1405	2026-05-19 05:00:00	22	29.66
1417	2026-05-19 05:00:00	24	10
1430	2026-05-19 05:00:00	23	192
1442	2026-05-19 05:00:00	25	10
1450	2026-05-19 05:00:00	21	20
1451	2026-05-19 06:00:00	2	24.78
1462	2026-05-19 06:00:00	5	15
1471	2026-05-19 06:00:00	4	15
1478	2026-05-19 06:00:00	3	168.6
1491	2026-05-19 06:00:00	1	12
1506	2026-05-19 07:00:00	21	20
1518	2026-05-19 07:00:00	22	29.67
1524	2026-05-19 07:00:00	24	10
1532	2026-05-19 07:00:00	23	192
1538	2026-05-19 07:00:00	25	10
2060	2026-05-19 18:00:00	47	29.46
2067	2026-05-19 18:00:00	50	10
2078	2026-05-19 18:00:00	48	192
2083	2026-05-19 18:00:00	49	10
2091	2026-05-19 18:00:00	46	20
2107	2026-05-19 19:00:00	33	195
2112	2026-05-19 19:00:00	34	15
2121	2026-05-19 19:00:00	31	20
2126	2026-05-19 19:00:00	35	15
2133	2026-05-19 19:00:00	32	29
2159	2026-05-19 20:00:00	49	10
2170	2026-05-19 20:00:00	46	20
2179	2026-05-19 20:00:00	47	29.54
2186	2026-05-19 20:00:00	50	10
2191	2026-05-19 20:00:00	48	192
2209	2026-05-19 21:00:00	43	192
2222	2026-05-19 21:00:00	44	10
2234	2026-05-19 21:00:00	45	10
2246	2026-05-19 21:00:00	41	20
2250	2026-05-19 21:00:00	42	29.55
2251	2026-05-19 22:00:00	3	168.6
2261	2026-05-19 22:00:00	1	12
2276	2026-05-19 22:00:00	2	24.98
2285	2026-05-19 22:00:00	5	15
2294	2026-05-19 22:00:00	4	15
2304	2026-05-19 23:00:00	17	29.51
2315	2026-05-19 23:00:00	18	192
2327	2026-05-19 23:00:00	16	20
2341	2026-05-19 23:00:00	19	10
2348	2026-05-19 23:00:00	20	10
2354	2026-05-20 00:00:00	14	10
2363	2026-05-20 00:00:00	13	192
2372	2026-05-20 00:00:00	15	10
2379	2026-05-20 00:00:00	11	20
2388	2026-05-20 00:00:00	12	29.6
2408	2026-05-20 01:00:00	38	192
2419	2026-05-20 01:00:00	39	10
2434	2026-05-20 01:00:00	40	10
2444	2026-05-20 01:00:00	36	20
2449	2026-05-20 01:00:00	37	29.65
2453	2026-05-20 02:00:00	14	10
2470	2026-05-20 02:00:00	13	192
2484	2026-05-20 02:00:00	15	10
2497	2026-05-20 02:00:00	11	20
2499	2026-05-20 02:00:00	12	29.62
2502	2026-05-20 03:00:00	7	24.97
2512	2026-05-20 03:00:00	6	12
2522	2026-05-20 03:00:00	8	168.6
2528	2026-05-20 03:00:00	10	15
2538	2026-05-20 03:00:00	9	15
3060	2026-05-20 14:00:00	25	10
3074	2026-05-20 14:00:00	21	40
3085	2026-05-20 14:00:00	22	40.2
3094	2026-05-20 14:00:00	24	10
3099	2026-05-20 14:00:00	23	258
3102	2026-05-20 15:00:00	10	15
3117	2026-05-20 15:00:00	9	15
3131	2026-05-20 15:00:00	6	12
3142	2026-05-20 15:00:00	7	24.82
3147	2026-05-20 15:00:00	8	168.6
3152	2026-05-20 16:00:00	20	29.25
3167	2026-05-20 16:00:00	17	36.76
3178	2026-05-20 16:00:00	18	269.55
3191	2026-05-20 16:00:00	16	40
3197	2026-05-20 16:00:00	19	29.25
3203	2026-05-20 17:00:00	14	10
3213	2026-05-20 17:00:00	11	40
3229	2026-05-20 17:00:00	13	258
3240	2026-05-20 17:00:00	15	10
3249	2026-05-20 17:00:00	12	54.99
3258	2026-05-20 18:00:00	9	15
3275	2026-05-20 18:00:00	6	12
3286	2026-05-20 18:00:00	7	24.79
3295	2026-05-20 18:00:00	8	168.6
3300	2026-05-20 18:00:00	10	15
3301	2026-05-20 19:00:00	5	15
3316	2026-05-20 19:00:00	1	12
3330	2026-05-20 19:00:00	4	15
3340	2026-05-20 19:00:00	3	168.6
3344	2026-05-20 19:00:00	2	24.76
3355	2026-05-20 20:00:00	30	16.25
3366	2026-05-20 20:00:00	27	39.05
3370	2026-05-20 20:00:00	29	16.25
3379	2026-05-20 20:00:00	26	40
3387	2026-05-20 20:00:00	28	261.75
3409	2026-05-20 21:00:00	43	258.3
3419	2026-05-20 21:00:00	44	10.5
3432	2026-05-20 21:00:00	45	10.5
3442	2026-05-20 21:00:00	41	40
3450	2026-05-20 21:00:00	42	39.89
3451	2026-05-20 22:00:00	4	15
3465	2026-05-20 22:00:00	3	168.6
3479	2026-05-20 22:00:00	2	24.91
3489	2026-05-20 22:00:00	5	15
3495	2026-05-20 22:00:00	1	12
3505	2026-05-20 23:00:00	22	40.16
3516	2026-05-20 23:00:00	24	10
3530	2026-05-20 23:00:00	23	258
3537	2026-05-20 23:00:00	25	10
3542	2026-05-20 23:00:00	21	40
3553	2026-05-21 00:00:00	28	261.75
3559	2026-05-21 00:00:00	30	16.25
3568	2026-05-21 00:00:00	27	39.13
3579	2026-05-21 00:00:00	29	16.25
3588	2026-05-21 00:00:00	26	40
1244	2026-05-19 01:00:00	32	28.94
1250	2026-05-19 01:00:00	33	195
1251	2026-05-19 02:00:00	2	24.89
1268	2026-05-19 02:00:00	5	15
1280	2026-05-19 02:00:00	4	15
1289	2026-05-19 02:00:00	3	168.6
1298	2026-05-19 02:00:00	1	12
1305	2026-05-19 03:00:00	19	10
1317	2026-05-19 03:00:00	20	10
1330	2026-05-19 03:00:00	17	29.66
1342	2026-05-19 03:00:00	18	192
1347	2026-05-19 03:00:00	16	20
1355	2026-05-19 04:00:00	18	192
1368	2026-05-19 04:00:00	16	20
1381	2026-05-19 04:00:00	19	10
1392	2026-05-19 04:00:00	20	10
1400	2026-05-19 04:00:00	17	29.55
1401	2026-05-19 05:00:00	1	12
1412	2026-05-19 05:00:00	2	24.88
1425	2026-05-19 05:00:00	5	15
1438	2026-05-19 05:00:00	4	15
1448	2026-05-19 05:00:00	3	168.6
1460	2026-05-19 06:00:00	17	29.55
1463	2026-05-19 06:00:00	18	192
1473	2026-05-19 06:00:00	16	20
1480	2026-05-19 06:00:00	19	10
1488	2026-05-19 06:00:00	20	10
1507	2026-05-19 07:00:00	42	29.46
1514	2026-05-19 07:00:00	43	192
1526	2026-05-19 07:00:00	44	10
1535	2026-05-19 07:00:00	45	10
1542	2026-05-19 07:00:00	41	20
2527	2026-05-20 03:00:00	12	29.5
2537	2026-05-20 03:00:00	14	10
3061	2026-05-20 14:00:00	43	258.3
3073	2026-05-20 14:00:00	44	10.5
3082	2026-05-20 14:00:00	45	10.5
3087	2026-05-20 14:00:00	41	40
3095	2026-05-20 14:00:00	42	40.01
3103	2026-05-20 15:00:00	25	10
3118	2026-05-20 15:00:00	21	40
3132	2026-05-20 15:00:00	22	39.95
3143	2026-05-20 15:00:00	24	10
3148	2026-05-20 15:00:00	23	258
3153	2026-05-20 16:00:00	14	10
3161	2026-05-20 16:00:00	11	40
3170	2026-05-20 16:00:00	13	258
3176	2026-05-20 16:00:00	15	10
3183	2026-05-20 16:00:00	12	55.17
3207	2026-05-20 17:00:00	46	40
3218	2026-05-20 17:00:00	48	259.35
3231	2026-05-20 17:00:00	49	12.25
3244	2026-05-20 17:00:00	47	39.61
3248	2026-05-20 17:00:00	50	12.25
3259	2026-05-20 18:00:00	14	10
3264	2026-05-20 18:00:00	11	40
3273	2026-05-20 18:00:00	13	258
3282	2026-05-20 18:00:00	15	10
3292	2026-05-20 18:00:00	12	55.14
3305	2026-05-20 19:00:00	35	16
3314	2026-05-20 19:00:00	32	38.97
3325	2026-05-20 19:00:00	31	40
3337	2026-05-20 19:00:00	33	261.6
3345	2026-05-20 19:00:00	34	16
3356	2026-05-20 20:00:00	34	16
3361	2026-05-20 20:00:00	35	16
3369	2026-05-20 20:00:00	32	38.98
3383	2026-05-20 20:00:00	31	40
3394	2026-05-20 20:00:00	33	261.6
3408	2026-05-20 21:00:00	33	261.6
3418	2026-05-20 21:00:00	34	16
3431	2026-05-20 21:00:00	35	16
3441	2026-05-20 21:00:00	32	39.11
3448	2026-05-20 21:00:00	31	40
3452	2026-05-20 22:00:00	13	258
3466	2026-05-20 22:00:00	15	10
3480	2026-05-20 22:00:00	12	55.1
3490	2026-05-20 22:00:00	14	10
3497	2026-05-20 22:00:00	11	40
3504	2026-05-20 23:00:00	19	38.5
3517	2026-05-20 23:00:00	20	38.5
3528	2026-05-20 23:00:00	17	35.14
3534	2026-05-20 23:00:00	18	275.1
3546	2026-05-20 23:00:00	16	40
3554	2026-05-21 00:00:00	50	12.25
3567	2026-05-21 00:00:00	46	40
3576	2026-05-21 00:00:00	48	259.35
3586	2026-05-21 00:00:00	49	12.25
3595	2026-05-21 00:00:00	47	39.82
3605	2026-05-21 01:00:00	28	261.75
3612	2026-05-21 01:00:00	30	16.25
3622	2026-05-21 01:00:00	27	38.97
3630	2026-05-21 01:00:00	29	16.25
3639	2026-05-21 01:00:00	26	40
3659	2026-05-21 02:00:00	42	39.97
3673	2026-05-21 02:00:00	43	258.3
3687	2026-05-21 02:00:00	44	10.5
3693	2026-05-21 02:00:00	45	10.5
3700	2026-05-21 02:00:00	41	40
3701	2026-05-21 03:00:00	1	12
3712	2026-05-21 03:00:00	4	15
3718	2026-05-21 03:00:00	3	168.6
3724	2026-05-21 03:00:00	2	24.81
3736	2026-05-21 03:00:00	5	15
3760	2026-05-21 04:00:00	42	39.93
3768	2026-05-21 04:00:00	43	258.3
3776	2026-05-21 04:00:00	44	10.5
3790	2026-05-21 04:00:00	45	10.5
3799	2026-05-21 04:00:00	41	40
3802	2026-05-21 05:00:00	9	15
3812	2026-05-21 05:00:00	6	12
3825	2026-05-21 05:00:00	7	24.83
3840	2026-05-21 05:00:00	8	168.6
3848	2026-05-21 05:00:00	10	15
3851	2026-05-21 06:00:00	1	12
3862	2026-05-21 06:00:00	4	15
3876	2026-05-21 06:00:00	3	168.6
3888	2026-05-21 06:00:00	2	25
3896	2026-05-21 06:00:00	5	15
3905	2026-05-21 07:00:00	16	40
3917	2026-05-21 07:00:00	19	38.5
3929	2026-05-21 07:00:00	20	38.5
3938	2026-05-21 07:00:00	17	34.96
3948	2026-05-21 07:00:00	18	275.1
3953	2026-05-21 08:00:00	17	35.19
3969	2026-05-21 08:00:00	18	275.1
3980	2026-05-21 08:00:00	16	40
3990	2026-05-21 08:00:00	19	38.5
3999	2026-05-21 08:00:00	20	38.5
4004	2026-05-21 09:00:00	25	10
4003	2026-05-21 09:00:00	8	168.6
4015	2026-05-21 09:00:00	21	40
4019	2026-05-21 09:00:00	10	15
4026	2026-05-21 09:00:00	22	40.1
4030	2026-05-21 09:00:00	9	15
4035	2026-05-21 09:00:00	24	10
1245	2026-05-19 01:00:00	3	168.6
1256	2026-05-19 02:00:00	29	15
1264	2026-05-19 02:00:00	28	195
1276	2026-05-19 02:00:00	26	20
1287	2026-05-19 02:00:00	30	15
1299	2026-05-19 02:00:00	27	28.95
1302	2026-05-19 03:00:00	4	15
1315	2026-05-19 03:00:00	3	168.6
1327	2026-05-19 03:00:00	1	12
1338	2026-05-19 03:00:00	2	24.72
1345	2026-05-19 03:00:00	5	15
1357	2026-05-19 04:00:00	28	195
1365	2026-05-19 04:00:00	26	20
1373	2026-05-19 04:00:00	30	15
1385	2026-05-19 04:00:00	27	28.82
1394	2026-05-19 04:00:00	29	15
1409	2026-05-19 05:00:00	28	195
1418	2026-05-19 05:00:00	26	20
1429	2026-05-19 05:00:00	30	15
1441	2026-05-19 05:00:00	27	28.87
1447	2026-05-19 05:00:00	29	15
1458	2026-05-19 06:00:00	28	195
1472	2026-05-19 06:00:00	26	20
1487	2026-05-19 06:00:00	30	15
1496	2026-05-19 06:00:00	27	29.08
1500	2026-05-19 06:00:00	29	15
1501	2026-05-19 07:00:00	4	15
1512	2026-05-19 07:00:00	3	168.6
1527	2026-05-19 07:00:00	1	12
1539	2026-05-19 07:00:00	2	24.84
1547	2026-05-19 07:00:00	5	15
2534	2026-05-20 03:00:00	5	15
2543	2026-05-20 03:00:00	4	15
2548	2026-05-20 03:00:00	3	168.6
3062	2026-05-20 14:00:00	47	39.82
3077	2026-05-20 14:00:00	50	11
3089	2026-05-20 14:00:00	46	40
3096	2026-05-20 14:00:00	48	258.6
3100	2026-05-20 14:00:00	49	11
3101	2026-05-20 15:00:00	5	15
3111	2026-05-20 15:00:00	1	12
3119	2026-05-20 15:00:00	4	15
3127	2026-05-20 15:00:00	3	168.6
3139	2026-05-20 15:00:00	2	24.96
3159	2026-05-20 16:00:00	40	10.5
3172	2026-05-20 16:00:00	37	39.97
3186	2026-05-20 16:00:00	38	258.3
3195	2026-05-20 16:00:00	36	40
3200	2026-05-20 16:00:00	39	10.5
3201	2026-05-20 17:00:00	1	12
3211	2026-05-20 17:00:00	4	15
3220	2026-05-20 17:00:00	3	168.6
3227	2026-05-20 17:00:00	2	24.95
3233	2026-05-20 17:00:00	5	15
3255	2026-05-20 18:00:00	46	40
3269	2026-05-20 18:00:00	48	259.35
3277	2026-05-20 18:00:00	49	12.25
3285	2026-05-20 18:00:00	47	39.57
3296	2026-05-20 18:00:00	50	12.25
3310	2026-05-20 19:00:00	23	258
3320	2026-05-20 19:00:00	25	10
3333	2026-05-20 19:00:00	21	40
3343	2026-05-20 19:00:00	22	39.96
3350	2026-05-20 19:00:00	24	10
3351	2026-05-20 20:00:00	4	15
3363	2026-05-20 20:00:00	3	168.6
3373	2026-05-20 20:00:00	2	24.74
3382	2026-05-20 20:00:00	5	15
3386	2026-05-20 20:00:00	1	12
3407	2026-05-20 21:00:00	46	40
3417	2026-05-20 21:00:00	48	259.35
3430	2026-05-20 21:00:00	49	12.25
3440	2026-05-20 21:00:00	47	39.76
3447	2026-05-20 21:00:00	50	12.25
3454	2026-05-20 22:00:00	30	16.25
3469	2026-05-20 22:00:00	27	39.09
3483	2026-05-20 22:00:00	29	16.25
3494	2026-05-20 22:00:00	26	40
3500	2026-05-20 22:00:00	28	261.75
3501	2026-05-20 23:00:00	3	168.6
3511	2026-05-20 23:00:00	2	24.84
3518	2026-05-20 23:00:00	5	15
3525	2026-05-20 23:00:00	1	12
3536	2026-05-20 23:00:00	4	15
3555	2026-05-21 00:00:00	37	40.07
3558	2026-05-21 00:00:00	38	258.3
3563	2026-05-21 00:00:00	36	40
3573	2026-05-21 00:00:00	39	10.5
3584	2026-05-21 00:00:00	40	10.5
3607	2026-05-21 01:00:00	50	12.25
3614	2026-05-21 01:00:00	46	40
3623	2026-05-21 01:00:00	48	259.35
3631	2026-05-21 01:00:00	49	12.25
3640	2026-05-21 01:00:00	47	39.58
3660	2026-05-21 02:00:00	38	258.3
3666	2026-05-21 02:00:00	36	40
3675	2026-05-21 02:00:00	39	10.5
3686	2026-05-21 02:00:00	40	10.5
3694	2026-05-21 02:00:00	37	40.01
3707	2026-05-21 03:00:00	26	40
3714	2026-05-21 03:00:00	28	261.75
3728	2026-05-21 03:00:00	30	16.25
3735	2026-05-21 03:00:00	27	39.02
3742	2026-05-21 03:00:00	29	16.25
3754	2026-05-21 04:00:00	31	40
3764	2026-05-21 04:00:00	33	261.75
3774	2026-05-21 04:00:00	34	16.25
3780	2026-05-21 04:00:00	35	16.25
3789	2026-05-21 04:00:00	32	39.08
3810	2026-05-21 05:00:00	38	258.3
3814	2026-05-21 05:00:00	36	40
3822	2026-05-21 05:00:00	39	10.5
3831	2026-05-21 05:00:00	40	10.5
3841	2026-05-21 05:00:00	37	39.89
3859	2026-05-21 06:00:00	41	40
3865	2026-05-21 06:00:00	42	39.91
3874	2026-05-21 06:00:00	43	258.3
3884	2026-05-21 06:00:00	44	10.5
3891	2026-05-21 06:00:00	45	10.5
3909	2026-05-21 07:00:00	43	258.3
3914	2026-05-21 07:00:00	44	10.5
3926	2026-05-21 07:00:00	45	10.5
3936	2026-05-21 07:00:00	41	40
3946	2026-05-21 07:00:00	42	40.06
3956	2026-05-21 08:00:00	27	39.11
3963	2026-05-21 08:00:00	29	16
3978	2026-05-21 08:00:00	26	40
3985	2026-05-21 08:00:00	28	261.6
3992	2026-05-21 08:00:00	30	16
4002	2026-05-21 09:00:00	14	10
4018	2026-05-21 09:00:00	11	40
4032	2026-05-21 09:00:00	12	55.18
4042	2026-05-21 09:00:00	13	258
4048	2026-05-21 09:00:00	15	10
4053	2026-05-21 10:00:00	14	10
4063	2026-05-21 10:00:00	12	55.15
1246	2026-05-19 01:00:00	9	15
1255	2026-05-19 02:00:00	24	10
1262	2026-05-19 02:00:00	23	192
1272	2026-05-19 02:00:00	25	10
1285	2026-05-19 02:00:00	21	20
1295	2026-05-19 02:00:00	22	29.68
1304	2026-05-19 03:00:00	25	10
1318	2026-05-19 03:00:00	21	20
1331	2026-05-19 03:00:00	22	29.58
1340	2026-05-19 03:00:00	24	10
1346	2026-05-19 03:00:00	23	192
1354	2026-05-19 04:00:00	22	29.54
1362	2026-05-19 04:00:00	24	10
1371	2026-05-19 04:00:00	23	192
1376	2026-05-19 04:00:00	25	10
1382	2026-05-19 04:00:00	21	20
1408	2026-05-19 05:00:00	48	192
1415	2026-05-19 05:00:00	49	10
1422	2026-05-19 05:00:00	46	20
1427	2026-05-19 05:00:00	47	29.58
1440	2026-05-19 05:00:00	50	10
1454	2026-05-19 06:00:00	40	10
1468	2026-05-19 06:00:00	36	20
1476	2026-05-19 06:00:00	37	29.6
1483	2026-05-19 06:00:00	38	192
1490	2026-05-19 06:00:00	39	10
1505	2026-05-19 07:00:00	26	20
1513	2026-05-19 07:00:00	30	15
1521	2026-05-19 07:00:00	27	28.82
1528	2026-05-19 07:00:00	29	15
1534	2026-05-19 07:00:00	28	195
2536	2026-05-20 03:00:00	33	195
2546	2026-05-20 03:00:00	34	15
2550	2026-05-20 03:00:00	31	20
3508	2026-05-20 23:00:00	39	10.5
3521	2026-05-20 23:00:00	40	10.5
3532	2026-05-20 23:00:00	37	40.02
3540	2026-05-20 23:00:00	38	258.3
3545	2026-05-20 23:00:00	36	40
3556	2026-05-21 00:00:00	31	40
3560	2026-05-21 00:00:00	33	261.75
3570	2026-05-21 00:00:00	34	16.25
3577	2026-05-21 00:00:00	35	16.25
3587	2026-05-21 00:00:00	32	38.92
3609	2026-05-21 01:00:00	37	40.08
3611	2026-05-21 01:00:00	38	258.3
3620	2026-05-21 01:00:00	36	40
3628	2026-05-21 01:00:00	39	10.5
3636	2026-05-21 01:00:00	40	10.5
3657	2026-05-21 02:00:00	31	40
3672	2026-05-21 02:00:00	33	261.75
3681	2026-05-21 02:00:00	34	16.25
3689	2026-05-21 02:00:00	35	16.25
3696	2026-05-21 02:00:00	32	38.94
3703	2026-05-21 03:00:00	22	40
3716	2026-05-21 03:00:00	24	10
3726	2026-05-21 03:00:00	23	258
3737	2026-05-21 03:00:00	25	10
3745	2026-05-21 03:00:00	21	40
3756	2026-05-21 04:00:00	25	10
3769	2026-05-21 04:00:00	21	40
3783	2026-05-21 04:00:00	22	40.17
3793	2026-05-21 04:00:00	24	10
3796	2026-05-21 04:00:00	23	258
3805	2026-05-21 05:00:00	25	10
3820	2026-05-21 05:00:00	21	40
3827	2026-05-21 05:00:00	22	40.22
3835	2026-05-21 05:00:00	24	10
3846	2026-05-21 05:00:00	23	258
3855	2026-05-21 06:00:00	25	10
3864	2026-05-21 06:00:00	21	40
3875	2026-05-21 06:00:00	22	40.21
3885	2026-05-21 06:00:00	24	10
3892	2026-05-21 06:00:00	23	258
3910	2026-05-21 07:00:00	34	16.25
3920	2026-05-21 07:00:00	35	16.25
3930	2026-05-21 07:00:00	32	39.08
3940	2026-05-21 07:00:00	31	40
3949	2026-05-21 07:00:00	33	261.75
3951	2026-05-21 08:00:00	4	15
3961	2026-05-21 08:00:00	3	168.6
3976	2026-05-21 08:00:00	2	24.88
3987	2026-05-21 08:00:00	5	15
3996	2026-05-21 08:00:00	1	12
4008	2026-05-21 09:00:00	48	259.35
4013	2026-05-21 09:00:00	49	12.25
4022	2026-05-21 09:00:00	47	39.67
4029	2026-05-21 09:00:00	50	12.25
4039	2026-05-21 09:00:00	46	40
4055	2026-05-21 10:00:00	38	258.45
4062	2026-05-21 10:00:00	36	40
4070	2026-05-21 10:00:00	39	10.75
4078	2026-05-21 10:00:00	40	10.75
4087	2026-05-21 10:00:00	37	39.98
4105	2026-05-21 11:00:00	49	12
4115	2026-05-21 11:00:00	47	39.75
4124	2026-05-21 11:00:00	50	12
4136	2026-05-21 11:00:00	46	40
4146	2026-05-21 11:00:00	48	259.2
4154	2026-05-21 12:00:00	13	429.6
4167	2026-05-21 12:00:00	15	10
4179	2026-05-21 12:00:00	11	92
4189	2026-05-21 12:00:00	14	10
4190	2026-05-21 12:00:00	8	168.6
4198	2026-05-21 12:00:00	12	82.28
4203	2026-05-21 13:00:00	18	275.25
4208	2026-05-21 13:00:00	43	273.15
4211	2026-05-21 13:00:00	19	38.75
4215	2026-05-21 13:00:00	44	35.25
4222	2026-05-21 13:00:00	45	35.25
4226	2026-05-21 13:00:00	20	38.75
4230	2026-05-21 13:00:00	41	40
4235	2026-05-21 13:00:00	42	35.64
4237	2026-05-21 13:00:00	16	40
4246	2026-05-21 13:00:00	17	34.91
4258	2026-05-21 15:00:00	50	11
4260	2026-05-21 15:00:00	25	10
4263	2026-05-21 15:00:00	46	40
4270	2026-05-21 15:00:00	21	40
4274	2026-05-21 15:00:00	11	40
4275	2026-05-21 15:00:00	48	258.6
4283	2026-05-21 15:00:00	24	10
4284	2026-05-21 15:00:00	14	10
4286	2026-05-21 15:00:00	49	11
4292	2026-05-21 15:00:00	23	258
4295	2026-05-21 15:00:00	12	54.94
4296	2026-05-21 15:00:00	47	39.82
4300	2026-05-21 15:00:00	22	40.24
4301	2026-05-21 16:00:00	4	15
4303	2026-05-21 16:00:00	25	10
4304	2026-05-21 16:00:00	26	40
4307	2026-05-21 16:00:00	43	258.45
4311	2026-05-21 16:00:00	3	168.6
4314	2026-05-21 16:00:00	28	261.6
4316	2026-05-21 16:00:00	44	10.75
4318	2026-05-21 16:00:00	21	40
1247	2026-05-19 01:00:00	20	10
1253	2026-05-19 02:00:00	18	192
1269	2026-05-19 02:00:00	16	20
1274	2026-05-19 02:00:00	19	10
1283	2026-05-19 02:00:00	20	10
1290	2026-05-19 02:00:00	17	29.45
1310	2026-05-19 03:00:00	45	10
1321	2026-05-19 03:00:00	41	20
1335	2026-05-19 03:00:00	42	29.47
1343	2026-05-19 03:00:00	43	192
1350	2026-05-19 03:00:00	44	10
1351	2026-05-19 04:00:00	2	24.75
1361	2026-05-19 04:00:00	5	15
1375	2026-05-19 04:00:00	4	15
1386	2026-05-19 04:00:00	3	168.6
1397	2026-05-19 04:00:00	1	12
1403	2026-05-19 05:00:00	17	29.6
1413	2026-05-19 05:00:00	18	192
1424	2026-05-19 05:00:00	16	20
1437	2026-05-19 05:00:00	19	10
1446	2026-05-19 05:00:00	20	10
1456	2026-05-19 06:00:00	22	29.58
1467	2026-05-19 06:00:00	24	10
1475	2026-05-19 06:00:00	23	192
1482	2026-05-19 06:00:00	25	10
1489	2026-05-19 06:00:00	21	20
1510	2026-05-19 07:00:00	37	29.74
1522	2026-05-19 07:00:00	38	192
1537	2026-05-19 07:00:00	39	10
1545	2026-05-19 07:00:00	40	10
1550	2026-05-19 07:00:00	36	20
2540	2026-05-20 03:00:00	42	29.55
3509	2026-05-20 23:00:00	45	10.5
3520	2026-05-20 23:00:00	41	40
3531	2026-05-20 23:00:00	42	40.1
3541	2026-05-20 23:00:00	43	258.3
3557	2026-05-21 00:00:00	4	15
3571	2026-05-21 00:00:00	3	168.6
3581	2026-05-21 00:00:00	2	24.95
3591	2026-05-21 00:00:00	5	15
3597	2026-05-21 00:00:00	1	12
3608	2026-05-21 01:00:00	9	15
3618	2026-05-21 01:00:00	6	12
3634	2026-05-21 01:00:00	7	25
3643	2026-05-21 01:00:00	8	168.6
3649	2026-05-21 01:00:00	10	15
3653	2026-05-21 02:00:00	9	15
3664	2026-05-21 02:00:00	6	12
3679	2026-05-21 02:00:00	7	24.92
3690	2026-05-21 02:00:00	8	168.6
3699	2026-05-21 02:00:00	10	15
3704	2026-05-21 03:00:00	7	24.79
3717	2026-05-21 03:00:00	8	168.6
3727	2026-05-21 03:00:00	10	15
3738	2026-05-21 03:00:00	9	15
3746	2026-05-21 03:00:00	6	12
3755	2026-05-21 04:00:00	18	275.1
3770	2026-05-21 04:00:00	16	40
3786	2026-05-21 04:00:00	19	38.5
3795	2026-05-21 04:00:00	20	38.5
3800	2026-05-21 04:00:00	17	35.11
3801	2026-05-21 05:00:00	5	15
3811	2026-05-21 05:00:00	1	12
3826	2026-05-21 05:00:00	4	15
3837	2026-05-21 05:00:00	3	168.6
3844	2026-05-21 05:00:00	2	24.88
3860	2026-05-21 06:00:00	29	16.25
3871	2026-05-21 06:00:00	26	40
3878	2026-05-21 06:00:00	28	261.75
3886	2026-05-21 06:00:00	30	16.25
3895	2026-05-21 06:00:00	27	38.95
3904	2026-05-21 07:00:00	22	39.95
3916	2026-05-21 07:00:00	24	10
3924	2026-05-21 07:00:00	23	258
3935	2026-05-21 07:00:00	25	10
3944	2026-05-21 07:00:00	21	40
3960	2026-05-21 08:00:00	38	258.45
3970	2026-05-21 08:00:00	36	40
3983	2026-05-21 08:00:00	39	10.75
3994	2026-05-21 08:00:00	40	10.75
3997	2026-05-21 08:00:00	37	40.1
4009	2026-05-21 09:00:00	38	258.45
4017	2026-05-21 09:00:00	36	40
4031	2026-05-21 09:00:00	39	10.75
4041	2026-05-21 09:00:00	40	10.75
4046	2026-05-21 09:00:00	37	40.01
4054	2026-05-21 10:00:00	25	10
4067	2026-05-21 10:00:00	21	40
4083	2026-05-21 10:00:00	24	10
4095	2026-05-21 10:00:00	23	258
4099	2026-05-21 10:00:00	22	40.19
4104	2026-05-21 11:00:00	9	15
4111	2026-05-21 11:00:00	10	15
4120	2026-05-21 11:00:00	6	12
4126	2026-05-21 11:00:00	8	168.6
4133	2026-05-21 11:00:00	7	24.74
4157	2026-05-21 12:00:00	47	66.89
4161	2026-05-21 12:00:00	50	12
4170	2026-05-21 12:00:00	46	92
4174	2026-05-21 12:00:00	48	430.8
4182	2026-05-21 12:00:00	49	12
4192	2026-05-21 12:00:00	41	92
4200	2026-05-21 12:00:00	42	67.09
4201	2026-05-21 13:00:00	2	24.81
4210	2026-05-21 13:00:00	50	36
4213	2026-05-21 13:00:00	3	168.6
4217	2026-05-21 13:00:00	46	40
4224	2026-05-21 13:00:00	48	273.6
4229	2026-05-21 13:00:00	5	15
4232	2026-05-21 13:00:00	49	36
4240	2026-05-21 13:00:00	47	35.65
4247	2026-05-21 13:00:00	1	12
4250	2026-05-21 13:00:00	4	15
4251	2026-05-21 15:00:00	1	12
4259	2026-05-21 15:00:00	39	10.5
4266	2026-05-21 15:00:00	4	15
4268	2026-05-21 15:00:00	40	10.5
4273	2026-05-21 15:00:00	3	168.6
4278	2026-05-21 15:00:00	37	40.15
4281	2026-05-21 15:00:00	2	24.91
4282	2026-05-21 15:00:00	9	15
4288	2026-05-21 15:00:00	38	258.3
4291	2026-05-21 15:00:00	5	15
4293	2026-05-21 15:00:00	6	12
4297	2026-05-21 15:00:00	36	40
4302	2026-05-21 16:00:00	13	258
4306	2026-05-21 16:00:00	35	16.25
4308	2026-05-21 16:00:00	39	10.5
4315	2026-05-21 16:00:00	32	39.03
4317	2026-05-21 16:00:00	15	10
4320	2026-05-21 16:00:00	40	10.5
4323	2026-05-21 16:00:00	30	16
4324	2026-05-21 16:00:00	31	40
4326	2026-05-21 16:00:00	2	24.77
4327	2026-05-21 16:00:00	11	40
4329	2026-05-21 16:00:00	33	261.75
1248	2026-05-19 01:00:00	39	10
1254	2026-05-19 02:00:00	14	10
1263	2026-05-19 02:00:00	13	192
1277	2026-05-19 02:00:00	15	10
1286	2026-05-19 02:00:00	11	20
1297	2026-05-19 02:00:00	12	29.7
1303	2026-05-19 03:00:00	15	10
1311	2026-05-19 03:00:00	11	20
1319	2026-05-19 03:00:00	12	29.5
1324	2026-05-19 03:00:00	14	10
1332	2026-05-19 03:00:00	13	192
1360	2026-05-19 04:00:00	48	192
1369	2026-05-19 04:00:00	49	10
1377	2026-05-19 04:00:00	46	20
1383	2026-05-19 04:00:00	47	29.66
1391	2026-05-19 04:00:00	50	10
1407	2026-05-19 05:00:00	41	20
1416	2026-05-19 05:00:00	42	29.46
1428	2026-05-19 05:00:00	43	192
1435	2026-05-19 05:00:00	44	10
1444	2026-05-19 05:00:00	45	10
1457	2026-05-19 06:00:00	34	15
1469	2026-05-19 06:00:00	31	20
1485	2026-05-19 06:00:00	35	15
1495	2026-05-19 06:00:00	32	29.11
1498	2026-05-19 06:00:00	33	195
1503	2026-05-19 07:00:00	14	10
1515	2026-05-19 07:00:00	13	192
1529	2026-05-19 07:00:00	15	10
1540	2026-05-19 07:00:00	11	20
1548	2026-05-19 07:00:00	12	29.53
2551	2026-05-20 04:00:00	5	15
2569	2026-05-20 04:00:00	1	12
2584	2026-05-20 04:00:00	4	15
2592	2026-05-20 04:00:00	3	168.6
2598	2026-05-20 04:00:00	2	24.99
2603	2026-05-20 05:00:00	14	10
2615	2026-05-20 05:00:00	11	40
2626	2026-05-20 05:00:00	13	258
2637	2026-05-20 05:00:00	15	10
2647	2026-05-20 05:00:00	12	40.14
2656	2026-05-20 06:00:00	19	11.25
2662	2026-05-20 06:00:00	20	11.25
2672	2026-05-20 06:00:00	17	39.82
2679	2026-05-20 06:00:00	18	258.75
2687	2026-05-20 06:00:00	16	40
2707	2026-05-20 07:00:00	40	10.5
2719	2026-05-20 07:00:00	37	39.96
2734	2026-05-20 07:00:00	38	258.3
2746	2026-05-20 07:00:00	36	40
2748	2026-05-20 07:00:00	39	10.5
2753	2026-05-20 08:00:00	14	10
2769	2026-05-20 08:00:00	11	40
2784	2026-05-20 08:00:00	13	258
2795	2026-05-20 08:00:00	15	10
2800	2026-05-20 08:00:00	12	55.21
2801	2026-05-20 09:00:00	3	168.6
2815	2026-05-20 09:00:00	2	24.8
2826	2026-05-20 09:00:00	5	15
2837	2026-05-20 09:00:00	1	12
2844	2026-05-20 09:00:00	4	15
2857	2026-05-20 10:00:00	35	15
2865	2026-05-20 10:00:00	32	39.17
2875	2026-05-20 10:00:00	31	40
2884	2026-05-20 10:00:00	33	261
2887	2026-05-20 10:00:00	34	15
2908	2026-05-20 11:00:00	50	12
2915	2026-05-20 11:00:00	46	40
2924	2026-05-20 11:00:00	48	259.2
2934	2026-05-20 11:00:00	49	12
2944	2026-05-20 11:00:00	47	39.68
2956	2026-05-20 12:00:00	26	92
2962	2026-05-20 12:00:00	28	433.35
2970	2026-05-20 12:00:00	30	16.25
2976	2026-05-20 12:00:00	27	65.35
2983	2026-05-20 12:00:00	29	16.25
3009	2026-05-20 13:00:00	42	35.66
3021	2026-05-20 13:00:00	43	273.3
3031	2026-05-20 13:00:00	44	35.5
3039	2026-05-20 13:00:00	45	35.5
3047	2026-05-20 13:00:00	41	40
3510	2026-05-20 23:00:00	48	259.35
3519	2026-05-20 23:00:00	49	12.25
3527	2026-05-20 23:00:00	47	39.55
3533	2026-05-20 23:00:00	50	12.25
3544	2026-05-20 23:00:00	46	40
3562	2026-05-21 00:00:00	18	275.1
3575	2026-05-21 00:00:00	16	40
3585	2026-05-21 00:00:00	19	38.5
3594	2026-05-21 00:00:00	20	38.5
3600	2026-05-21 00:00:00	17	35.22
3601	2026-05-21 01:00:00	4	15
3616	2026-05-21 01:00:00	3	168.6
3625	2026-05-21 01:00:00	2	24.76
3635	2026-05-21 01:00:00	5	15
3645	2026-05-21 01:00:00	1	12
3652	2026-05-21 02:00:00	28	261.75
3662	2026-05-21 02:00:00	30	16.25
3670	2026-05-21 02:00:00	27	38.93
3677	2026-05-21 02:00:00	29	16.25
3684	2026-05-21 02:00:00	26	40
3709	2026-05-21 03:00:00	43	258.3
3713	2026-05-21 03:00:00	44	10.5
3722	2026-05-21 03:00:00	45	10.5
3732	2026-05-21 03:00:00	41	40
3739	2026-05-21 03:00:00	42	40.1
3759	2026-05-21 04:00:00	38	258.3
3765	2026-05-21 04:00:00	36	40
3775	2026-05-21 04:00:00	39	10.5
3781	2026-05-21 04:00:00	40	10.5
3791	2026-05-21 04:00:00	37	39.9
3809	2026-05-21 05:00:00	29	16.25
3819	2026-05-21 05:00:00	26	40
3824	2026-05-21 05:00:00	28	261.75
3833	2026-05-21 05:00:00	30	16.25
3843	2026-05-21 05:00:00	27	39.07
3857	2026-05-21 06:00:00	33	261.75
3869	2026-05-21 06:00:00	34	16.25
3880	2026-05-21 06:00:00	35	16.25
3893	2026-05-21 06:00:00	32	39.02
3899	2026-05-21 06:00:00	31	40
3902	2026-05-21 07:00:00	10	15
3912	2026-05-21 07:00:00	9	15
3922	2026-05-21 07:00:00	6	12
3931	2026-05-21 07:00:00	7	24.88
3941	2026-05-21 07:00:00	8	168.6
3959	2026-05-21 08:00:00	41	40
3964	2026-05-21 08:00:00	42	39.86
3975	2026-05-21 08:00:00	43	258.3
3988	2026-05-21 08:00:00	44	10.5
3998	2026-05-21 08:00:00	45	10.5
4010	2026-05-21 09:00:00	41	40
4023	2026-05-21 09:00:00	42	40.11
4036	2026-05-21 09:00:00	43	258.3
4044	2026-05-21 09:00:00	44	10.5
4050	2026-05-21 09:00:00	45	10.5
1249	2026-05-19 01:00:00	22	29.53
1252	2026-05-19 02:00:00	7	24.85
1261	2026-05-19 02:00:00	6	12
1271	2026-05-19 02:00:00	8	168.6
1278	2026-05-19 02:00:00	10	15
1288	2026-05-19 02:00:00	9	15
1309	2026-05-19 03:00:00	47	29.56
1322	2026-05-19 03:00:00	50	10
1336	2026-05-19 03:00:00	48	192
1344	2026-05-19 03:00:00	49	10
1349	2026-05-19 03:00:00	46	20
1352	2026-05-19 04:00:00	6	12
1366	2026-05-19 04:00:00	8	168.6
1379	2026-05-19 04:00:00	10	15
1389	2026-05-19 04:00:00	9	15
1399	2026-05-19 04:00:00	7	24.75
1402	2026-05-19 05:00:00	7	24.84
1411	2026-05-19 05:00:00	6	12
1423	2026-05-19 05:00:00	8	168.6
1433	2026-05-19 05:00:00	10	15
1439	2026-05-19 05:00:00	9	15
1453	2026-05-19 06:00:00	41	20
1464	2026-05-19 06:00:00	42	29.71
1477	2026-05-19 06:00:00	43	192
1484	2026-05-19 06:00:00	44	10
1493	2026-05-19 06:00:00	45	10
1508	2026-05-19 07:00:00	31	20
1519	2026-05-19 07:00:00	35	15
1525	2026-05-19 07:00:00	32	28.95
1536	2026-05-19 07:00:00	33	195
1544	2026-05-19 07:00:00	34	15
2552	2026-05-20 04:00:00	9	15
2563	2026-05-20 04:00:00	6	12
2573	2026-05-20 04:00:00	7	24.91
2580	2026-05-20 04:00:00	8	168.6
2589	2026-05-20 04:00:00	10	15
2606	2026-05-20 05:00:00	31	40
2612	2026-05-20 05:00:00	33	261
2621	2026-05-20 05:00:00	34	15
2631	2026-05-20 05:00:00	35	15
2640	2026-05-20 05:00:00	32	39.32
2660	2026-05-20 06:00:00	34	15
2669	2026-05-20 06:00:00	35	15
2675	2026-05-20 06:00:00	32	39.26
2689	2026-05-20 06:00:00	31	40
2698	2026-05-20 06:00:00	33	261
2702	2026-05-20 07:00:00	7	24.72
2718	2026-05-20 07:00:00	8	168.6
2731	2026-05-20 07:00:00	10	15
2743	2026-05-20 07:00:00	9	15
2750	2026-05-20 07:00:00	6	12
2751	2026-05-20 08:00:00	3	168.6
2762	2026-05-20 08:00:00	2	24.78
2778	2026-05-20 08:00:00	5	15
2793	2026-05-20 08:00:00	1	12
2796	2026-05-20 08:00:00	4	15
2803	2026-05-20 09:00:00	21	40
2813	2026-05-20 09:00:00	22	40.11
2822	2026-05-20 09:00:00	24	10.75
2829	2026-05-20 09:00:00	23	258.45
2840	2026-05-20 09:00:00	25	10.75
2858	2026-05-20 10:00:00	39	10.5
2861	2026-05-20 10:00:00	40	10.5
2871	2026-05-20 10:00:00	37	39.94
2876	2026-05-20 10:00:00	38	258.3
2889	2026-05-20 10:00:00	36	40
2909	2026-05-20 11:00:00	42	39.93
2916	2026-05-20 11:00:00	43	258.6
2925	2026-05-20 11:00:00	44	11
2933	2026-05-20 11:00:00	45	11
2942	2026-05-20 11:00:00	41	40
2959	2026-05-20 12:00:00	31	92
2972	2026-05-20 12:00:00	33	433.35
2986	2026-05-20 12:00:00	34	16.25
2994	2026-05-20 12:00:00	35	16.25
2997	2026-05-20 12:00:00	32	65.48
3004	2026-05-20 13:00:00	19	38.75
3018	2026-05-20 13:00:00	20	38.75
3029	2026-05-20 13:00:00	17	35.1
3040	2026-05-20 13:00:00	18	275.25
3046	2026-05-20 13:00:00	16	40
3512	2026-05-20 23:00:00	12	55.13
3522	2026-05-20 23:00:00	14	10
3535	2026-05-20 23:00:00	11	40
3547	2026-05-20 23:00:00	13	258
3564	2026-05-21 00:00:00	9	15
3574	2026-05-21 00:00:00	6	12
3583	2026-05-21 00:00:00	7	24.93
3592	2026-05-21 00:00:00	8	168.6
3598	2026-05-21 00:00:00	10	15
3603	2026-05-21 01:00:00	14	10
3617	2026-05-21 01:00:00	11	40
3627	2026-05-21 01:00:00	13	258
3642	2026-05-21 01:00:00	15	10
3648	2026-05-21 01:00:00	12	55.02
3654	2026-05-21 02:00:00	13	258
3668	2026-05-21 02:00:00	15	10
3682	2026-05-21 02:00:00	12	55.18
3691	2026-05-21 02:00:00	14	10
3697	2026-05-21 02:00:00	11	40
3705	2026-05-21 03:00:00	18	275.25
3715	2026-05-21 03:00:00	16	40
3721	2026-05-21 03:00:00	19	38.75
3729	2026-05-21 03:00:00	20	38.75
3734	2026-05-21 03:00:00	17	35.01
3758	2026-05-21 04:00:00	50	12
3763	2026-05-21 04:00:00	46	40
3773	2026-05-21 04:00:00	48	259.2
3779	2026-05-21 04:00:00	49	12
3788	2026-05-21 04:00:00	47	39.72
3806	2026-05-21 05:00:00	31	40
3815	2026-05-21 05:00:00	33	261.75
3828	2026-05-21 05:00:00	34	16.25
3838	2026-05-21 05:00:00	35	16.25
3849	2026-05-21 05:00:00	32	39.03
3852	2026-05-21 06:00:00	6	12
3861	2026-05-21 06:00:00	7	24.81
3870	2026-05-21 06:00:00	8	168.6
3872	2026-05-21 06:00:00	10	15
3882	2026-05-21 06:00:00	9	15
3908	2026-05-21 07:00:00	49	12.25
3915	2026-05-21 07:00:00	47	39.74
3923	2026-05-21 07:00:00	50	12.25
3933	2026-05-21 07:00:00	46	40
3943	2026-05-21 07:00:00	48	259.35
3957	2026-05-21 08:00:00	31	40
3962	2026-05-21 08:00:00	33	261.75
3971	2026-05-21 08:00:00	34	16.25
3977	2026-05-21 08:00:00	35	16.25
3984	2026-05-21 08:00:00	32	39.03
4037	2026-05-21 09:00:00	23	258
4056	2026-05-21 10:00:00	31	40
4061	2026-05-21 10:00:00	33	261.75
4069	2026-05-21 10:00:00	34	16.25
4077	2026-05-21 10:00:00	35	16.25
4089	2026-05-21 10:00:00	32	38.94
1258	2026-05-19 02:00:00	40	10
1265	2026-05-19 02:00:00	36	20
1273	2026-05-19 02:00:00	37	29.67
1282	2026-05-19 02:00:00	38	192
1294	2026-05-19 02:00:00	39	10
1307	2026-05-19 03:00:00	35	15
1316	2026-05-19 03:00:00	32	29.1
1329	2026-05-19 03:00:00	33	195
1341	2026-05-19 03:00:00	34	15
1348	2026-05-19 03:00:00	31	20
1353	2026-05-19 04:00:00	15	10
1367	2026-05-19 04:00:00	11	20
1380	2026-05-19 04:00:00	12	29.5
1390	2026-05-19 04:00:00	14	10
1395	2026-05-19 04:00:00	13	192
1406	2026-05-19 05:00:00	34	15
1419	2026-05-19 05:00:00	31	20
1431	2026-05-19 05:00:00	35	15
1443	2026-05-19 05:00:00	32	28.86
1449	2026-05-19 05:00:00	33	195
1452	2026-05-19 06:00:00	9	15
1465	2026-05-19 06:00:00	7	24.77
1479	2026-05-19 06:00:00	6	12
1492	2026-05-19 06:00:00	8	168.6
1497	2026-05-19 06:00:00	10	15
1504	2026-05-19 07:00:00	16	20
1516	2026-05-19 07:00:00	19	10
1530	2026-05-19 07:00:00	20	10
1541	2026-05-19 07:00:00	17	29.44
1546	2026-05-19 07:00:00	18	192
2553	2026-05-20 04:00:00	30	15
2567	2026-05-20 04:00:00	27	39.3
2577	2026-05-20 04:00:00	29	15
2591	2026-05-20 04:00:00	26	40
2596	2026-05-20 04:00:00	28	261
2604	2026-05-20 05:00:00	18	258.75
2613	2026-05-20 05:00:00	16	40
2622	2026-05-20 05:00:00	19	11.25
2629	2026-05-20 05:00:00	20	11.25
2635	2026-05-20 05:00:00	17	39.87
2658	2026-05-20 06:00:00	50	11
2666	2026-05-20 06:00:00	46	40
2681	2026-05-20 06:00:00	48	258.6
2691	2026-05-20 06:00:00	49	11
2695	2026-05-20 06:00:00	47	39.93
2706	2026-05-20 07:00:00	28	261.75
2716	2026-05-20 07:00:00	30	16.25
2726	2026-05-20 07:00:00	27	39.04
2740	2026-05-20 07:00:00	29	16.25
2747	2026-05-20 07:00:00	26	40
2754	2026-05-20 08:00:00	18	259.5
2768	2026-05-20 08:00:00	16	40
2776	2026-05-20 08:00:00	19	12.5
2786	2026-05-20 08:00:00	20	12.5
2794	2026-05-20 08:00:00	17	39.64
2810	2026-05-20 09:00:00	34	15
2820	2026-05-20 09:00:00	35	15
2825	2026-05-20 09:00:00	32	39.2
2833	2026-05-20 09:00:00	31	40
2842	2026-05-20 09:00:00	33	261
2859	2026-05-20 10:00:00	45	10.5
2869	2026-05-20 10:00:00	41	40
2885	2026-05-20 10:00:00	42	40.03
2888	2026-05-20 10:00:00	43	258.3
2896	2026-05-20 10:00:00	44	10.5
2904	2026-05-20 11:00:00	25	10
2917	2026-05-20 11:00:00	21	40
2926	2026-05-20 11:00:00	22	40.24
2940	2026-05-20 11:00:00	24	10
2948	2026-05-20 11:00:00	23	258
2953	2026-05-20 12:00:00	12	82.48
2965	2026-05-20 12:00:00	14	10
2977	2026-05-20 12:00:00	11	92
2984	2026-05-20 12:00:00	13	429.6
2989	2026-05-20 12:00:00	15	10
3008	2026-05-20 13:00:00	31	40
3014	2026-05-20 13:00:00	33	276
3024	2026-05-20 13:00:00	34	40
3032	2026-05-20 13:00:00	35	40
3041	2026-05-20 13:00:00	32	34.96
3513	2026-05-20 23:00:00	7	24.75
3523	2026-05-20 23:00:00	8	168.6
3529	2026-05-20 23:00:00	10	15
3538	2026-05-20 23:00:00	9	15
3565	2026-05-21 00:00:00	11	40
3572	2026-05-21 00:00:00	13	258
3582	2026-05-21 00:00:00	15	10
3593	2026-05-21 00:00:00	12	55.07
3599	2026-05-21 00:00:00	14	10
3604	2026-05-21 01:00:00	17	35.22
3615	2026-05-21 01:00:00	18	275.1
3624	2026-05-21 01:00:00	16	40
3632	2026-05-21 01:00:00	19	38.5
3644	2026-05-21 01:00:00	20	38.5
3656	2026-05-21 02:00:00	25	10
3667	2026-05-21 02:00:00	21	40
3676	2026-05-21 02:00:00	22	40.2
3688	2026-05-21 02:00:00	24	10
3695	2026-05-21 02:00:00	23	258
3702	2026-05-21 03:00:00	33	261.75
3711	2026-05-21 03:00:00	34	16.25
3720	2026-05-21 03:00:00	35	16.25
3731	2026-05-21 03:00:00	32	39.01
3743	2026-05-21 03:00:00	31	40
3757	2026-05-21 04:00:00	29	16.25
3762	2026-05-21 04:00:00	26	40
3772	2026-05-21 04:00:00	28	261.75
3778	2026-05-21 04:00:00	30	16.25
3787	2026-05-21 04:00:00	27	39.11
3807	2026-05-21 05:00:00	50	12
3817	2026-05-21 05:00:00	46	40
3832	2026-05-21 05:00:00	48	259.2
3842	2026-05-21 05:00:00	49	12
3850	2026-05-21 05:00:00	47	39.73
3854	2026-05-21 06:00:00	17	34.99
3868	2026-05-21 06:00:00	18	275.1
3881	2026-05-21 06:00:00	16	40
3894	2026-05-21 06:00:00	19	38.5
3900	2026-05-21 06:00:00	20	38.5
3901	2026-05-21 07:00:00	3	168.6
3911	2026-05-21 07:00:00	2	25
3921	2026-05-21 07:00:00	5	15
3932	2026-05-21 07:00:00	1	12
3942	2026-05-21 07:00:00	4	15
3958	2026-05-21 08:00:00	48	259.2
3966	2026-05-21 08:00:00	49	12
3973	2026-05-21 08:00:00	47	39.61
3982	2026-05-21 08:00:00	50	12
3989	2026-05-21 08:00:00	46	40
4038	2026-05-21 09:00:00	6	12
4045	2026-05-21 09:00:00	7	24.85
4060	2026-05-21 10:00:00	27	38.9
4073	2026-05-21 10:00:00	29	16
4085	2026-05-21 10:00:00	26	40
4096	2026-05-21 10:00:00	28	261.6
4100	2026-05-21 10:00:00	30	16
1259	2026-05-19 02:00:00	43	192
1267	2026-05-19 02:00:00	44	10
1281	2026-05-19 02:00:00	45	10
1293	2026-05-19 02:00:00	41	20
1300	2026-05-19 02:00:00	42	29.52
1301	2026-05-19 03:00:00	8	168.6
1314	2026-05-19 03:00:00	10	15
1326	2026-05-19 03:00:00	9	15
1334	2026-05-19 03:00:00	7	24.76
1339	2026-05-19 03:00:00	6	12
1356	2026-05-19 04:00:00	34	15
1364	2026-05-19 04:00:00	31	20
1372	2026-05-19 04:00:00	35	15
1384	2026-05-19 04:00:00	32	28.96
1393	2026-05-19 04:00:00	33	195
1410	2026-05-19 05:00:00	40	10
1420	2026-05-19 05:00:00	36	20
1432	2026-05-19 05:00:00	37	29.52
1436	2026-05-19 05:00:00	38	192
1445	2026-05-19 05:00:00	39	10
1459	2026-05-19 06:00:00	15	10
1461	2026-05-19 06:00:00	11	20
1466	2026-05-19 06:00:00	12	29.74
1474	2026-05-19 06:00:00	14	10
1481	2026-05-19 06:00:00	13	192
1509	2026-05-19 07:00:00	49	10
1520	2026-05-19 07:00:00	46	20
1533	2026-05-19 07:00:00	47	29.56
1543	2026-05-19 07:00:00	50	10
1549	2026-05-19 07:00:00	48	192
2554	2026-05-20 04:00:00	21	40
2568	2026-05-20 04:00:00	22	40
2582	2026-05-20 04:00:00	24	10
2593	2026-05-20 04:00:00	23	258
2599	2026-05-20 04:00:00	25	10
2602	2026-05-20 05:00:00	7	25
2611	2026-05-20 05:00:00	8	168.6
2616	2026-05-20 05:00:00	10	15
2624	2026-05-20 05:00:00	9	15
2638	2026-05-20 05:00:00	6	12
2659	2026-05-20 06:00:00	42	39.95
2665	2026-05-20 06:00:00	43	258.3
2677	2026-05-20 06:00:00	44	10.5
2690	2026-05-20 06:00:00	45	10.5
2696	2026-05-20 06:00:00	41	40
2705	2026-05-20 07:00:00	21	40
2713	2026-05-20 07:00:00	22	39.79
2723	2026-05-20 07:00:00	24	11
2729	2026-05-20 07:00:00	23	258.6
2738	2026-05-20 07:00:00	25	11
2758	2026-05-20 08:00:00	36	40
2763	2026-05-20 08:00:00	39	10.5
2771	2026-05-20 08:00:00	40	10.5
2779	2026-05-20 08:00:00	37	40.12
2791	2026-05-20 08:00:00	38	258.3
2809	2026-05-20 09:00:00	44	10.25
2821	2026-05-20 09:00:00	45	10.25
2832	2026-05-20 09:00:00	41	40
2843	2026-05-20 09:00:00	42	40.1
2850	2026-05-20 09:00:00	43	258.15
2851	2026-05-20 10:00:00	2	24.94
2866	2026-05-20 10:00:00	5	15
2878	2026-05-20 10:00:00	1	12
2890	2026-05-20 10:00:00	4	15
2897	2026-05-20 10:00:00	3	168.6
2902	2026-05-20 11:00:00	17	35.15
2918	2026-05-20 11:00:00	18	275.1
2932	2026-05-20 11:00:00	16	40
2945	2026-05-20 11:00:00	19	38.5
2950	2026-05-20 11:00:00	20	38.5
2951	2026-05-20 12:00:00	1	12
2963	2026-05-20 12:00:00	4	15
2971	2026-05-20 12:00:00	3	168.6
2979	2026-05-20 12:00:00	2	24.92
2988	2026-05-20 12:00:00	5	15
3010	2026-05-20 13:00:00	37	35.69
3015	2026-05-20 13:00:00	38	273.15
3025	2026-05-20 13:00:00	36	40
3037	2026-05-20 13:00:00	39	35.25
3048	2026-05-20 13:00:00	40	35.25
3514	2026-05-20 23:00:00	29	16.25
3524	2026-05-20 23:00:00	26	40
3539	2026-05-20 23:00:00	28	261.75
3610	2026-05-21 01:00:00	42	40.11
3626	2026-05-21 01:00:00	43	258.3
3633	2026-05-21 01:00:00	44	10.5
3641	2026-05-21 01:00:00	45	10.5
3647	2026-05-21 01:00:00	41	40
3655	2026-05-21 02:00:00	17	35.03
3669	2026-05-21 02:00:00	18	275.1
3683	2026-05-21 02:00:00	16	40
3692	2026-05-21 02:00:00	19	38.5
3698	2026-05-21 02:00:00	20	38.5
3706	2026-05-21 03:00:00	15	10
3730	2026-05-21 03:00:00	12	55.05
3741	2026-05-21 03:00:00	14	10
3747	2026-05-21 03:00:00	11	40
3750	2026-05-21 03:00:00	13	258
3751	2026-05-21 04:00:00	5	15
3766	2026-05-21 04:00:00	1	12
3782	2026-05-21 04:00:00	4	15
3792	2026-05-21 04:00:00	3	168.6
3798	2026-05-21 04:00:00	2	24.72
3804	2026-05-21 05:00:00	14	10
3816	2026-05-21 05:00:00	11	40
3830	2026-05-21 05:00:00	13	258
3839	2026-05-21 05:00:00	15	10
3847	2026-05-21 05:00:00	12	55.07
3853	2026-05-21 06:00:00	14	10
3863	2026-05-21 06:00:00	11	40
3877	2026-05-21 06:00:00	13	258
3889	2026-05-21 06:00:00	15	10
3898	2026-05-21 06:00:00	12	54.97
3906	2026-05-21 07:00:00	26	40
3913	2026-05-21 07:00:00	28	261.75
3925	2026-05-21 07:00:00	30	16.25
3934	2026-05-21 07:00:00	27	39.15
3947	2026-05-21 07:00:00	29	16.25
3954	2026-05-21 08:00:00	14	10
3968	2026-05-21 08:00:00	11	40
3979	2026-05-21 08:00:00	13	258
3991	2026-05-21 08:00:00	15	10
4000	2026-05-21 08:00:00	12	55.17
4051	2026-05-21 10:00:00	4	15
4064	2026-05-21 10:00:00	3	168.6
4072	2026-05-21 10:00:00	2	24.93
4080	2026-05-21 10:00:00	5	15
4090	2026-05-21 10:00:00	1	12
4107	2026-05-21 11:00:00	34	16.25
4114	2026-05-21 11:00:00	35	16.25
4123	2026-05-21 11:00:00	32	39.05
4131	2026-05-21 11:00:00	31	40
4141	2026-05-21 11:00:00	33	261.75
4156	2026-05-21 12:00:00	35	16.25
4162	2026-05-21 12:00:00	32	65.53
4173	2026-05-21 12:00:00	31	92
1260	2026-05-19 02:00:00	46	20
1270	2026-05-19 02:00:00	47	29.56
1279	2026-05-19 02:00:00	50	10
1292	2026-05-19 02:00:00	48	192
1296	2026-05-19 02:00:00	49	10
1306	2026-05-19 03:00:00	26	20
1313	2026-05-19 03:00:00	30	15
1323	2026-05-19 03:00:00	27	28.84
1328	2026-05-19 03:00:00	29	15
1337	2026-05-19 03:00:00	28	195
1358	2026-05-19 04:00:00	40	10
1363	2026-05-19 04:00:00	36	20
1374	2026-05-19 04:00:00	37	29.54
1387	2026-05-19 04:00:00	38	192
1396	2026-05-19 04:00:00	39	10
1404	2026-05-19 05:00:00	15	10
1414	2026-05-19 05:00:00	11	20
1421	2026-05-19 05:00:00	12	29.61
1426	2026-05-19 05:00:00	14	10
1434	2026-05-19 05:00:00	13	192
1455	2026-05-19 06:00:00	48	192
1470	2026-05-19 06:00:00	49	10
1486	2026-05-19 06:00:00	46	20
1494	2026-05-19 06:00:00	47	29.74
1499	2026-05-19 06:00:00	50	10
1502	2026-05-19 07:00:00	7	24.95
1511	2026-05-19 07:00:00	6	12
1517	2026-05-19 07:00:00	8	168.6
1523	2026-05-19 07:00:00	10	15
1531	2026-05-19 07:00:00	9	15
2555	2026-05-20 04:00:00	18	258
2564	2026-05-20 04:00:00	16	40
2574	2026-05-20 04:00:00	19	10
2581	2026-05-20 04:00:00	20	10
2590	2026-05-20 04:00:00	17	40.19
2609	2026-05-20 05:00:00	37	39.95
2618	2026-05-20 05:00:00	38	258.3
2625	2026-05-20 05:00:00	36	40
2634	2026-05-20 05:00:00	39	10.5
2643	2026-05-20 05:00:00	40	10.5
2654	2026-05-20 06:00:00	24	11
2663	2026-05-20 06:00:00	23	258.6
2673	2026-05-20 06:00:00	25	11
2680	2026-05-20 06:00:00	21	40
2685	2026-05-20 06:00:00	22	40.02
2710	2026-05-20 07:00:00	48	258.75
2720	2026-05-20 07:00:00	49	11.25
2735	2026-05-20 07:00:00	47	39.83
2745	2026-05-20 07:00:00	50	11.25
2749	2026-05-20 07:00:00	46	40
2752	2026-05-20 08:00:00	9	15
2761	2026-05-20 08:00:00	6	12
2777	2026-05-20 08:00:00	7	24.78
2787	2026-05-20 08:00:00	8	168.6
2797	2026-05-20 08:00:00	10	15
2806	2026-05-20 09:00:00	18	267.45
2814	2026-05-20 09:00:00	16	40
2828	2026-05-20 09:00:00	19	25.75
2838	2026-05-20 09:00:00	20	25.75
2845	2026-05-20 09:00:00	17	37.33
2856	2026-05-20 10:00:00	30	16.25
2862	2026-05-20 10:00:00	27	38.96
2872	2026-05-20 10:00:00	29	16.25
2877	2026-05-20 10:00:00	26	40
2886	2026-05-20 10:00:00	28	261.75
2910	2026-05-20 11:00:00	36	40
2920	2026-05-20 11:00:00	39	10.5
2935	2026-05-20 11:00:00	40	10.5
2943	2026-05-20 11:00:00	37	39.96
2949	2026-05-20 11:00:00	38	258.3
2952	2026-05-20 12:00:00	10	15
2964	2026-05-20 12:00:00	9	15
2974	2026-05-20 12:00:00	6	12
2985	2026-05-20 12:00:00	7	24.83
2991	2026-05-20 12:00:00	8	168.6
3006	2026-05-20 13:00:00	26	40
3017	2026-05-20 13:00:00	28	261.75
3030	2026-05-20 13:00:00	30	16.25
3043	2026-05-20 13:00:00	27	39.13
3050	2026-05-20 13:00:00	29	16.25
3515	2026-05-20 23:00:00	32	38.95
3526	2026-05-20 23:00:00	31	40
3543	2026-05-20 23:00:00	33	261.75
3752	2026-05-21 04:00:00	9	15
3767	2026-05-21 04:00:00	6	12
3784	2026-05-21 04:00:00	7	25
3794	2026-05-21 04:00:00	8	168.6
3797	2026-05-21 04:00:00	10	15
3803	2026-05-21 05:00:00	17	35.21
3818	2026-05-21 05:00:00	18	275.1
3823	2026-05-21 05:00:00	16	40
3834	2026-05-21 05:00:00	19	38.5
3845	2026-05-21 05:00:00	20	38.5
3856	2026-05-21 06:00:00	38	258.3
3867	2026-05-21 06:00:00	36	40
3879	2026-05-21 06:00:00	39	10.5
3887	2026-05-21 06:00:00	40	10.5
3897	2026-05-21 06:00:00	37	40.06
3903	2026-05-21 07:00:00	13	258
3918	2026-05-21 07:00:00	15	10
3927	2026-05-21 07:00:00	12	54.98
3937	2026-05-21 07:00:00	14	10
3945	2026-05-21 07:00:00	11	40
3955	2026-05-21 08:00:00	25	10
3967	2026-05-21 08:00:00	21	40
3972	2026-05-21 08:00:00	22	39.99
3981	2026-05-21 08:00:00	24	10
3995	2026-05-21 08:00:00	23	258
4071	2026-05-21 10:00:00	13	258
4079	2026-05-21 10:00:00	15	10
4088	2026-05-21 10:00:00	11	40
4110	2026-05-21 11:00:00	42	39.91
4116	2026-05-21 11:00:00	43	258.3
4125	2026-05-21 11:00:00	44	10.5
4137	2026-05-21 11:00:00	45	10.5
4147	2026-05-21 11:00:00	41	40
4159	2026-05-21 12:00:00	26	92
4168	2026-05-21 12:00:00	28	433.2
4180	2026-05-21 12:00:00	30	16
4193	2026-05-21 12:00:00	27	65.55
4199	2026-05-21 12:00:00	29	16
4202	2026-05-21 13:00:00	7	24.92
4212	2026-05-21 13:00:00	10	15
4221	2026-05-21 13:00:00	9	15
4234	2026-05-21 13:00:00	6	12
4236	2026-05-21 13:00:00	12	55.15
4243	2026-05-21 13:00:00	8	168.6
4256	2026-05-21 15:00:00	43	258.15
4257	2026-05-21 15:00:00	35	15
4262	2026-05-21 15:00:00	44	10.25
4267	2026-05-21 15:00:00	32	39.31
4276	2026-05-21 15:00:00	45	10.25
4277	2026-05-21 15:00:00	31	40
4285	2026-05-21 15:00:00	33	261
4287	2026-05-21 15:00:00	41	40
4294	2026-05-21 15:00:00	34	15
2556	2026-05-20 04:00:00	47	39.97
2561	2026-05-20 04:00:00	50	10
2571	2026-05-20 04:00:00	46	40
2578	2026-05-20 04:00:00	48	258
2587	2026-05-20 04:00:00	49	10
2608	2026-05-20 05:00:00	47	40.01
2620	2026-05-20 05:00:00	50	11.25
2632	2026-05-20 05:00:00	46	40
2645	2026-05-20 05:00:00	48	258.75
2650	2026-05-20 05:00:00	49	11.25
2652	2026-05-20 06:00:00	4	15
2668	2026-05-20 06:00:00	3	168.6
2682	2026-05-20 06:00:00	2	24.93
2692	2026-05-20 06:00:00	5	15
2699	2026-05-20 06:00:00	1	12
2701	2026-05-20 07:00:00	2	24.98
2717	2026-05-20 07:00:00	5	15
2730	2026-05-20 07:00:00	1	12
2739	2026-05-20 07:00:00	4	15
2742	2026-05-20 07:00:00	3	168.6
2756	2026-05-20 08:00:00	26	40
2766	2026-05-20 08:00:00	28	261.6
2774	2026-05-20 08:00:00	30	16
2782	2026-05-20 08:00:00	27	38.99
2792	2026-05-20 08:00:00	29	16
2807	2026-05-20 09:00:00	36	40
2818	2026-05-20 09:00:00	39	10.5
2830	2026-05-20 09:00:00	40	10.5
2841	2026-05-20 09:00:00	37	39.87
2849	2026-05-20 09:00:00	38	258.3
2855	2026-05-20 10:00:00	6	12
2863	2026-05-20 10:00:00	7	24.81
2873	2026-05-20 10:00:00	8	168.6
2881	2026-05-20 10:00:00	10	15
2892	2026-05-20 10:00:00	9	15
2907	2026-05-20 11:00:00	31	40
2912	2026-05-20 11:00:00	33	261
2921	2026-05-20 11:00:00	34	15
2928	2026-05-20 11:00:00	35	15
2936	2026-05-20 11:00:00	32	39.11
2960	2026-05-20 12:00:00	42	67.28
2973	2026-05-20 12:00:00	43	430.05
2987	2026-05-20 12:00:00	44	10.75
2995	2026-05-20 12:00:00	45	10.75
3000	2026-05-20 12:00:00	41	92
3001	2026-05-20 13:00:00	1	12
3011	2026-05-20 13:00:00	4	15
3019	2026-05-20 13:00:00	3	168.6
3028	2026-05-20 13:00:00	2	24.87
3035	2026-05-20 13:00:00	5	15
3753	2026-05-21 04:00:00	14	10
3761	2026-05-21 04:00:00	11	40
3771	2026-05-21 04:00:00	13	258
3777	2026-05-21 04:00:00	15	10
3785	2026-05-21 04:00:00	12	54.99
3808	2026-05-21 05:00:00	41	40
3813	2026-05-21 05:00:00	42	40.07
3821	2026-05-21 05:00:00	43	258.3
3829	2026-05-21 05:00:00	44	10.5
3836	2026-05-21 05:00:00	45	10.5
3858	2026-05-21 06:00:00	46	40
3866	2026-05-21 06:00:00	48	259.2
3873	2026-05-21 06:00:00	49	12
3883	2026-05-21 06:00:00	47	39.63
3890	2026-05-21 06:00:00	50	12
3907	2026-05-21 07:00:00	39	10.5
3919	2026-05-21 07:00:00	40	10.5
3928	2026-05-21 07:00:00	37	39.9
3939	2026-05-21 07:00:00	38	258.3
3950	2026-05-21 07:00:00	36	40
3952	2026-05-21 08:00:00	8	168.6
3965	2026-05-21 08:00:00	10	15
3974	2026-05-21 08:00:00	9	15
3986	2026-05-21 08:00:00	6	12
3993	2026-05-21 08:00:00	7	25
4101	2026-05-21 11:00:00	4	15
4112	2026-05-21 11:00:00	2	24.98
4129	2026-05-21 11:00:00	3	168.6
4140	2026-05-21 11:00:00	5	15
4144	2026-05-21 11:00:00	1	12
4155	2026-05-21 12:00:00	25	10
4163	2026-05-21 12:00:00	21	92
4172	2026-05-21 12:00:00	24	10
4186	2026-05-21 12:00:00	23	429.6
4195	2026-05-21 12:00:00	22	67.54
4205	2026-05-21 13:00:00	26	40
4218	2026-05-21 13:00:00	28	261.6
4225	2026-05-21 13:00:00	30	16
4238	2026-05-21 13:00:00	23	272.4
4239	2026-05-21 13:00:00	27	38.91
4244	2026-05-21 13:00:00	22	35.77
4245	2026-05-21 13:00:00	29	16
4254	2026-05-21 15:00:00	26	40
4255	2026-05-21 15:00:00	17	35.01
4264	2026-05-21 15:00:00	18	275.4
4269	2026-05-21 15:00:00	28	261.6
4272	2026-05-21 15:00:00	19	39
4279	2026-05-21 15:00:00	30	16
4280	2026-05-21 15:00:00	20	39
4289	2026-05-21 15:00:00	16	40
4290	2026-05-21 15:00:00	27	38.97
4298	2026-05-21 15:00:00	29	16
4299	2026-05-21 15:00:00	42	39.99
4305	2026-05-21 16:00:00	17	35.06
4309	2026-05-21 16:00:00	7	24.74
4310	2026-05-21 16:00:00	50	12.25
4312	2026-05-21 16:00:00	18	275.25
4313	2026-05-21 16:00:00	10	15
4319	2026-05-21 16:00:00	46	40
4321	2026-05-21 16:00:00	19	38.75
4322	2026-05-21 16:00:00	9	15
4325	2026-05-21 16:00:00	45	10.75
4328	2026-05-21 16:00:00	24	10
4330	2026-05-21 16:00:00	41	40
4331	2026-05-21 16:00:00	27	39.07
4332	2026-05-21 16:00:00	37	40.11
4333	2026-05-21 16:00:00	48	259.35
4334	2026-05-21 16:00:00	20	38.75
4335	2026-05-21 16:00:00	6	12
4336	2026-05-21 16:00:00	34	16.25
4337	2026-05-21 16:00:00	42	39.86
4338	2026-05-21 16:00:00	5	15
4339	2026-05-21 16:00:00	14	10
4340	2026-05-21 16:00:00	23	258
4341	2026-05-21 16:00:00	38	258.3
4342	2026-05-21 16:00:00	29	16
4343	2026-05-21 16:00:00	49	12.25
4344	2026-05-21 16:00:00	8	168.6
4345	2026-05-21 16:00:00	1	12
4346	2026-05-21 16:00:00	16	40
4347	2026-05-21 16:00:00	22	40.1
4348	2026-05-21 16:00:00	12	55.1
4349	2026-05-21 16:00:00	36	40
4350	2026-05-21 16:00:00	47	39.77
4351	2026-05-21 17:00:00	3	168.6
4353	2026-05-21 17:00:00	9	15
4352	2026-05-21 17:00:00	15	10
4362	2026-05-21 17:00:00	11	40
4371	2026-05-21 17:00:00	14	10
4379	2026-05-21 17:00:00	13	258
4386	2026-05-21 17:00:00	12	55.01
4407	2026-05-21 18:00:00	50	12.25
4418	2026-05-21 18:00:00	46	40
4431	2026-05-21 18:00:00	48	259.35
4443	2026-05-21 18:00:00	49	12.25
4448	2026-05-21 18:00:00	47	39.57
4456	2026-05-21 19:00:00	11	40
4466	2026-05-21 19:00:00	14	10
4479	2026-05-21 19:00:00	13	258
4488	2026-05-21 19:00:00	12	55
4497	2026-05-21 19:00:00	15	10
5501	2026-05-22 16:00:00	1	12
5514	2026-05-22 16:00:00	3	168.6
5529	2026-05-22 16:00:00	2	24.79
5539	2026-05-22 16:00:00	5	15
5546	2026-05-22 16:00:00	4	15
5559	2026-05-22 17:00:00	24	10
5566	2026-05-22 17:00:00	23	258
5575	2026-05-22 17:00:00	25	10
5586	2026-05-22 17:00:00	22	40.17
5590	2026-05-22 17:00:00	21	40
5605	2026-05-22 18:00:00	35	16.25
5611	2026-05-22 18:00:00	32	38.96
5619	2026-05-22 18:00:00	31	40
5624	2026-05-22 18:00:00	33	261.75
5633	2026-05-22 18:00:00	34	16.25
5658	2026-05-22 19:00:00	47	39.77
5662	2026-05-22 19:00:00	50	12.25
5672	2026-05-22 19:00:00	46	40
5678	2026-05-22 19:00:00	48	259.35
5687	2026-05-22 19:00:00	49	12.25
5708	2026-05-22 20:00:00	47	39.75
5712	2026-05-22 20:00:00	50	12.25
5721	2026-05-22 20:00:00	46	40
5729	2026-05-22 20:00:00	48	259.35
5740	2026-05-22 20:00:00	49	12.25
5758	2026-05-22 21:00:00	40	10.5
5763	2026-05-22 21:00:00	37	39.86
5772	2026-05-22 21:00:00	38	258.3
5776	2026-05-22 21:00:00	36	40
5785	2026-05-22 21:00:00	39	10.5
5808	2026-05-22 22:00:00	48	259.2
5820	2026-05-22 22:00:00	49	12
5831	2026-05-22 22:00:00	47	39.87
5842	2026-05-22 22:00:00	50	12
5850	2026-05-22 22:00:00	46	40
5851	2026-05-22 23:00:00	2	24.93
5867	2026-05-22 23:00:00	5	15
5878	2026-05-22 23:00:00	4	15
5890	2026-05-22 23:00:00	1	12
5900	2026-05-22 23:00:00	3	168.6
5901	2026-05-23 00:00:00	3	168.6
5913	2026-05-23 00:00:00	2	24.73
5922	2026-05-23 00:00:00	5	15
5928	2026-05-23 00:00:00	4	15
5936	2026-05-23 00:00:00	1	12
5959	2026-05-23 01:00:00	40	10.75
5969	2026-05-23 01:00:00	37	40.05
5983	2026-05-23 01:00:00	38	258.45
5993	2026-05-23 01:00:00	36	40
5999	2026-05-23 01:00:00	39	10.75
6001	2026-05-23 02:00:00	9	15
6015	2026-05-23 02:00:00	8	168.6
6029	2026-05-23 02:00:00	6	12
6038	2026-05-23 02:00:00	7	24.84
6047	2026-05-23 02:00:00	10	15
6053	2026-05-23 03:00:00	17	34.98
6061	2026-05-23 03:00:00	19	38.75
6070	2026-05-23 03:00:00	18	275.25
6080	2026-05-23 03:00:00	20	38.75
6089	2026-05-23 03:00:00	16	40
6110	2026-05-23 04:00:00	38	258.3
6115	2026-05-23 04:00:00	36	40
6133	2026-05-23 04:00:00	39	10.5
6138	2026-05-23 04:00:00	40	10.5
6148	2026-05-23 04:00:00	37	39.89
6154	2026-05-23 05:00:00	21	40
6167	2026-05-23 05:00:00	24	10
6181	2026-05-23 05:00:00	23	258
6187	2026-05-23 05:00:00	1	12
6191	2026-05-23 05:00:00	25	10
6197	2026-05-23 05:00:00	3	168.6
6198	2026-05-23 05:00:00	22	40.12
6203	2026-05-23 06:00:00	12	54.98
6210	2026-05-23 06:00:00	20	38.5
6212	2026-05-23 06:00:00	11	40
6214	2026-05-23 06:00:00	16	40
6222	2026-05-23 06:00:00	15	10
6229	2026-05-23 06:00:00	17	35.13
6233	2026-05-23 06:00:00	19	38.5
6235	2026-05-23 06:00:00	14	10
6240	2026-05-23 06:00:00	18	275.1
6244	2026-05-23 06:00:00	13	258
6254	2026-05-23 07:00:00	23	258
6258	2026-05-23 07:00:00	33	261.75
6263	2026-05-23 07:00:00	25	10
6265	2026-05-23 07:00:00	34	16.25
6272	2026-05-23 07:00:00	22	40.12
6274	2026-05-23 07:00:00	35	16.25
6280	2026-05-23 07:00:00	21	40
6285	2026-05-23 07:00:00	32	39.03
6291	2026-05-23 07:00:00	24	10
6293	2026-05-23 07:00:00	31	40
6309	2026-05-23 08:00:00	33	261.75
6310	2026-05-23 08:00:00	40	10.5
6313	2026-05-23 08:00:00	34	16.25
6314	2026-05-23 08:00:00	37	39.95
6321	2026-05-23 08:00:00	35	16.25
6322	2026-05-23 08:00:00	38	258.3
6329	2026-05-23 08:00:00	32	38.9
6330	2026-05-23 08:00:00	36	40
6335	2026-05-23 08:00:00	31	40
6338	2026-05-23 08:00:00	39	10.5
6357	2026-05-23 09:00:00	35	16
6359	2026-05-23 09:00:00	49	12
6364	2026-05-23 09:00:00	32	39.01
6367	2026-05-23 09:00:00	47	39.86
6373	2026-05-23 09:00:00	31	40
6378	2026-05-23 09:00:00	50	12
6384	2026-05-23 09:00:00	33	261.6
6388	2026-05-23 09:00:00	46	40
6394	2026-05-23 09:00:00	34	16
6398	2026-05-23 09:00:00	48	259.2
6407	2026-05-23 10:00:00	27	39.02
6409	2026-05-23 10:00:00	18	275.25
6413	2026-05-23 10:00:00	29	16.25
6420	2026-05-23 10:00:00	20	38.75
6422	2026-05-23 10:00:00	26	40
6428	2026-05-23 10:00:00	16	40
6431	2026-05-23 10:00:00	30	16.25
6438	2026-05-23 10:00:00	17	34.92
6443	2026-05-23 10:00:00	28	261.75
4354	2026-05-21 17:00:00	25	10
4363	2026-05-21 17:00:00	21	40
4375	2026-05-21 17:00:00	24	10
4390	2026-05-21 17:00:00	23	258
4395	2026-05-21 17:00:00	22	40.05
4406	2026-05-21 18:00:00	28	261.6
4413	2026-05-21 18:00:00	30	16
4422	2026-05-21 18:00:00	27	38.94
4430	2026-05-21 18:00:00	29	16
4441	2026-05-21 18:00:00	26	40
4454	2026-05-21 19:00:00	35	16.25
4464	2026-05-21 19:00:00	32	39.09
4475	2026-05-21 19:00:00	31	40
4486	2026-05-21 19:00:00	33	261.75
4495	2026-05-21 19:00:00	34	16.25
5502	2026-05-22 16:00:00	8	168.6
5513	2026-05-22 16:00:00	6	12
5521	2026-05-22 16:00:00	7	24.73
5527	2026-05-22 16:00:00	10	15
5535	2026-05-22 16:00:00	9	15
5557	2026-05-22 17:00:00	36	40
5563	2026-05-22 17:00:00	39	10.5
5572	2026-05-22 17:00:00	40	10.5
5578	2026-05-22 17:00:00	37	39.97
5585	2026-05-22 17:00:00	38	258.3
5607	2026-05-22 18:00:00	45	10.5
5614	2026-05-22 18:00:00	41	40
5622	2026-05-22 18:00:00	42	40.12
5632	2026-05-22 18:00:00	43	258.3
5641	2026-05-22 18:00:00	44	10.5
5660	2026-05-22 19:00:00	43	258.3
5666	2026-05-22 19:00:00	44	10.5
5676	2026-05-22 19:00:00	45	10.5
5688	2026-05-22 19:00:00	41	40
5690	2026-05-22 19:00:00	42	40.05
5707	2026-05-22 20:00:00	39	10.5
5719	2026-05-22 20:00:00	40	10.5
5728	2026-05-22 20:00:00	37	39.88
5735	2026-05-22 20:00:00	38	258.3
5741	2026-05-22 20:00:00	36	40
5760	2026-05-22 21:00:00	50	12.25
5769	2026-05-22 21:00:00	46	40
5782	2026-05-22 21:00:00	48	259.35
5793	2026-05-22 21:00:00	49	12.25
5800	2026-05-22 21:00:00	47	39.74
5803	2026-05-22 22:00:00	7	24.9
5815	2026-05-22 22:00:00	10	15
5827	2026-05-22 22:00:00	9	15
5839	2026-05-22 22:00:00	8	168.6
5845	2026-05-22 22:00:00	6	12
5860	2026-05-22 23:00:00	30	16
5870	2026-05-22 23:00:00	28	261.6
5879	2026-05-22 23:00:00	27	39.13
5887	2026-05-22 23:00:00	29	16
5895	2026-05-22 23:00:00	26	40
5905	2026-05-23 00:00:00	25	10
5915	2026-05-23 00:00:00	22	40.18
5924	2026-05-23 00:00:00	21	40
5930	2026-05-23 00:00:00	24	10
5941	2026-05-23 00:00:00	23	258
5956	2026-05-23 01:00:00	27	39.1
5963	2026-05-23 01:00:00	29	16
5972	2026-05-23 01:00:00	26	40
5978	2026-05-23 01:00:00	30	16
5986	2026-05-23 01:00:00	28	261.6
6008	2026-05-23 02:00:00	38	258.3
6012	2026-05-23 02:00:00	36	40
6021	2026-05-23 02:00:00	39	10.5
6025	2026-05-23 02:00:00	40	10.5
6035	2026-05-23 02:00:00	37	39.94
6060	2026-05-23 03:00:00	48	259.35
6066	2026-05-23 03:00:00	49	12.25
6075	2026-05-23 03:00:00	47	39.73
6086	2026-05-23 03:00:00	50	12.25
6096	2026-05-23 03:00:00	46	40
6109	2026-05-23 04:00:00	35	16.25
6114	2026-05-23 04:00:00	32	39.08
6125	2026-05-23 04:00:00	31	40
6134	2026-05-23 04:00:00	33	261.75
6143	2026-05-23 04:00:00	34	16.25
6159	2026-05-23 05:00:00	45	10.5
6171	2026-05-23 05:00:00	41	40
6183	2026-05-23 05:00:00	42	39.9
6190	2026-05-23 05:00:00	43	258.3
6192	2026-05-23 05:00:00	10	15
6195	2026-05-23 05:00:00	44	10.5
6199	2026-05-23 05:00:00	9	15
6202	2026-05-23 06:00:00	1	12
6205	2026-05-23 06:00:00	26	40
6211	2026-05-23 06:00:00	30	16.25
6219	2026-05-23 06:00:00	3	168.6
6221	2026-05-23 06:00:00	28	261.75
6228	2026-05-23 06:00:00	27	39.08
6230	2026-05-23 06:00:00	2	24.77
6234	2026-05-23 06:00:00	29	16.25
6246	2026-05-23 06:00:00	5	15
6249	2026-05-23 06:00:00	4	15
6255	2026-05-23 07:00:00	41	40
6259	2026-05-23 07:00:00	6	12
6264	2026-05-23 07:00:00	42	40.04
6269	2026-05-23 07:00:00	7	24.85
6273	2026-05-23 07:00:00	43	258.3
6281	2026-05-23 07:00:00	44	10.5
6283	2026-05-23 07:00:00	10	15
6292	2026-05-23 07:00:00	45	10.5
6294	2026-05-23 07:00:00	9	15
6298	2026-05-23 07:00:00	8	168.6
6304	2026-05-23 08:00:00	13	258
6307	2026-05-23 08:00:00	41	40
6316	2026-05-23 08:00:00	42	40
6319	2026-05-23 08:00:00	12	55.15
6324	2026-05-23 08:00:00	43	258.3
6332	2026-05-23 08:00:00	44	10.5
6333	2026-05-23 08:00:00	11	40
6340	2026-05-23 08:00:00	45	10.5
6343	2026-05-23 08:00:00	15	10
6348	2026-05-23 08:00:00	14	10
6352	2026-05-23 09:00:00	12	55.19
6358	2026-05-23 09:00:00	38	258.3
6361	2026-05-23 09:00:00	36	40
6366	2026-05-23 09:00:00	11	40
6371	2026-05-23 09:00:00	39	10.5
6376	2026-05-23 09:00:00	15	10
6381	2026-05-23 09:00:00	40	10.5
6386	2026-05-23 09:00:00	14	10
6390	2026-05-23 09:00:00	37	40.03
6393	2026-05-23 09:00:00	13	258
6406	2026-05-23 10:00:00	32	39.15
6408	2026-05-23 10:00:00	46	40
6414	2026-05-23 10:00:00	48	259.35
6416	2026-05-23 10:00:00	31	40
6423	2026-05-23 10:00:00	49	12.25
6424	2026-05-23 10:00:00	33	261.6
6435	2026-05-23 10:00:00	47	39.62
6436	2026-05-23 10:00:00	34	16
6440	2026-05-23 10:00:00	35	16
4357	2026-05-21 17:00:00	43	258.3
4360	2026-05-21 17:00:00	50	12.25
4365	2026-05-21 17:00:00	44	10.5
4369	2026-05-21 17:00:00	46	40
4370	2026-05-21 17:00:00	45	10.5
4384	2026-05-21 17:00:00	48	259.35
4385	2026-05-21 17:00:00	41	40
4396	2026-05-21 17:00:00	49	12.25
4397	2026-05-21 17:00:00	42	40.15
4400	2026-05-21 17:00:00	47	39.76
4401	2026-05-21 18:00:00	5	15
4404	2026-05-21 18:00:00	16	40
4412	2026-05-21 18:00:00	17	34.93
4415	2026-05-21 18:00:00	1	12
4421	2026-05-21 18:00:00	19	38.75
4424	2026-05-21 18:00:00	4	15
4428	2026-05-21 18:00:00	18	275.25
4433	2026-05-21 18:00:00	3	168.6
4438	2026-05-21 18:00:00	20	38.75
4442	2026-05-21 18:00:00	2	24.75
4457	2026-05-21 19:00:00	36	40
4461	2026-05-21 19:00:00	50	12
4467	2026-05-21 19:00:00	39	10.5
4471	2026-05-21 19:00:00	46	40
4477	2026-05-21 19:00:00	40	10.5
4481	2026-05-21 19:00:00	48	259.2
4485	2026-05-21 19:00:00	37	40.15
4493	2026-05-21 19:00:00	49	12
4494	2026-05-21 19:00:00	38	258.3
4500	2026-05-21 19:00:00	47	39.8
4606	2026-05-21 22:00:00	22	40.13
4610	2026-05-21 22:00:00	44	10.5
4612	2026-05-21 22:00:00	3	168.6
4614	2026-05-21 22:00:00	34	16.25
4616	2026-05-21 22:00:00	16	40
4618	2026-05-21 22:00:00	45	10.5
4621	2026-05-21 22:00:00	21	40
4622	2026-05-21 22:00:00	35	16.25
4624	2026-05-21 22:00:00	24	10
4626	2026-05-21 22:00:00	2	24.77
4628	2026-05-21 22:00:00	17	35.13
4631	2026-05-21 22:00:00	41	40
4633	2026-05-21 22:00:00	23	258
4635	2026-05-21 22:00:00	32	39.01
4638	2026-05-21 22:00:00	19	38.75
4639	2026-05-21 22:00:00	5	15
4640	2026-05-21 22:00:00	25	10
4641	2026-05-21 22:00:00	42	40.09
4644	2026-05-21 22:00:00	31	40
4645	2026-05-21 22:00:00	18	275.25
4648	2026-05-21 22:00:00	1	12
4649	2026-05-21 22:00:00	43	258.3
4652	2026-05-21 23:00:00	6	12
4654	2026-05-21 23:00:00	14	10
4655	2026-05-21 23:00:00	28	261.75
4659	2026-05-21 23:00:00	42	39.9
4660	2026-05-21 23:00:00	39	10.5
4663	2026-05-21 23:00:00	43	258.3
4664	2026-05-21 23:00:00	13	258
4666	2026-05-21 23:00:00	27	38.87
4667	2026-05-21 23:00:00	7	24.95
4670	2026-05-21 23:00:00	40	10.5
4674	2026-05-21 23:00:00	12	55.15
4675	2026-05-21 23:00:00	10	15
4676	2026-05-21 23:00:00	44	10.5
4677	2026-05-21 23:00:00	29	16.25
4678	2026-05-21 23:00:00	37	39.9
4681	2026-05-21 23:00:00	11	40
4684	2026-05-21 23:00:00	9	15
4685	2026-05-21 23:00:00	38	258.3
4686	2026-05-21 23:00:00	45	10.5
4687	2026-05-21 23:00:00	15	10
4688	2026-05-21 23:00:00	26	40
4692	2026-05-21 23:00:00	30	16.25
4696	2026-05-21 23:00:00	8	168.6
4697	2026-05-21 23:00:00	36	40
4698	2026-05-21 23:00:00	41	40
4702	2026-05-22 00:00:00	14	10
4704	2026-05-22 00:00:00	17	34.98
4705	2026-05-22 00:00:00	36	40
4709	2026-05-22 00:00:00	25	10
4710	2026-05-22 00:00:00	49	12
4713	2026-05-22 00:00:00	19	39
4714	2026-05-22 00:00:00	39	10.5
4716	2026-05-22 00:00:00	13	258
4717	2026-05-22 00:00:00	22	40.11
4722	2026-05-22 00:00:00	18	275.4
4723	2026-05-22 00:00:00	40	10.5
4724	2026-05-22 00:00:00	47	39.81
4728	2026-05-22 00:00:00	20	39
4729	2026-05-22 00:00:00	37	40.01
4730	2026-05-22 00:00:00	21	40
4731	2026-05-22 00:00:00	12	55.09
4736	2026-05-22 00:00:00	50	12
4737	2026-05-22 00:00:00	16	40
4739	2026-05-22 00:00:00	38	258.3
4740	2026-05-22 00:00:00	24	10
4741	2026-05-22 00:00:00	11	40
4745	2026-05-22 00:00:00	46	40
4746	2026-05-22 00:00:00	15	10
4747	2026-05-22 00:00:00	23	258
4749	2026-05-22 00:00:00	48	259.2
4751	2026-05-22 01:00:00	7	24.79
4753	2026-05-22 01:00:00	13	258
4755	2026-05-22 01:00:00	25	10
4758	2026-05-22 01:00:00	31	40
4760	2026-05-22 01:00:00	36	40
4762	2026-05-22 01:00:00	22	40.16
4763	2026-05-22 01:00:00	33	261.75
4764	2026-05-22 01:00:00	12	55.17
4766	2026-05-22 01:00:00	10	15
4771	2026-05-22 01:00:00	21	40
4772	2026-05-22 01:00:00	34	16.25
4773	2026-05-22 01:00:00	11	40
4775	2026-05-22 01:00:00	39	10.5
4777	2026-05-22 01:00:00	24	10
4778	2026-05-22 01:00:00	35	16.25
4779	2026-05-22 01:00:00	15	10
4781	2026-05-22 01:00:00	9	15
4786	2026-05-22 01:00:00	40	10.5
4787	2026-05-22 01:00:00	32	38.88
4788	2026-05-22 01:00:00	23	258
4789	2026-05-22 01:00:00	14	10
4794	2026-05-22 01:00:00	8	168.6
4795	2026-05-22 01:00:00	37	40.14
4799	2026-05-22 01:00:00	6	12
4800	2026-05-22 01:00:00	38	258.3
4801	2026-05-22 02:00:00	3	168.6
4802	2026-05-22 02:00:00	10	15
4806	2026-05-22 02:00:00	34	16.25
4807	2026-05-22 02:00:00	39	10.5
4810	2026-05-22 02:00:00	43	258.3
4811	2026-05-22 02:00:00	2	24.95
4815	2026-05-22 02:00:00	35	16.25
4817	2026-05-22 02:00:00	9	15
4818	2026-05-22 02:00:00	5	15
4355	2026-05-21 17:00:00	19	29.5
4367	2026-05-21 17:00:00	20	29.5
4377	2026-05-21 17:00:00	16	40
4392	2026-05-21 17:00:00	17	36.65
4399	2026-05-21 17:00:00	18	269.7
4402	2026-05-21 18:00:00	8	168.6
4416	2026-05-21 18:00:00	7	24.73
4427	2026-05-21 18:00:00	9	15
4436	2026-05-21 18:00:00	10	15
4445	2026-05-21 18:00:00	6	12
4459	2026-05-21 19:00:00	19	39
4468	2026-05-21 19:00:00	18	275.4
4478	2026-05-21 19:00:00	20	39
4489	2026-05-21 19:00:00	16	40
4499	2026-05-21 19:00:00	17	35.13
5503	2026-05-22 16:00:00	30	16
5504	2026-05-22 16:00:00	16	40
5511	2026-05-22 16:00:00	28	261.6
5518	2026-05-22 16:00:00	17	36.74
5519	2026-05-22 16:00:00	27	39.06
5525	2026-05-22 16:00:00	29	16
5531	2026-05-22 16:00:00	19	29.25
5532	2026-05-22 16:00:00	26	40
5541	2026-05-22 16:00:00	18	269.55
5547	2026-05-22 16:00:00	20	29.25
5554	2026-05-22 17:00:00	17	35.1
5556	2026-05-22 17:00:00	49	12.5
5565	2026-05-22 17:00:00	19	38.75
5568	2026-05-22 17:00:00	47	39.67
5576	2026-05-22 17:00:00	18	275.25
5581	2026-05-22 17:00:00	50	12.5
5589	2026-05-22 17:00:00	20	38.75
5592	2026-05-22 17:00:00	46	40
5596	2026-05-22 17:00:00	16	40
5598	2026-05-22 17:00:00	48	259.5
5603	2026-05-22 18:00:00	25	10
5604	2026-05-22 18:00:00	18	275.25
5617	2026-05-22 18:00:00	22	40.15
5618	2026-05-22 18:00:00	20	38.75
5628	2026-05-22 18:00:00	21	40
5629	2026-05-22 18:00:00	16	40
5637	2026-05-22 18:00:00	24	10
5638	2026-05-22 18:00:00	17	35.04
5647	2026-05-22 18:00:00	19	38.75
5649	2026-05-22 18:00:00	23	258
5651	2026-05-22 19:00:00	2	24.83
5656	2026-05-22 19:00:00	28	261.75
5667	2026-05-22 19:00:00	5	15
5669	2026-05-22 19:00:00	27	38.91
5680	2026-05-22 19:00:00	4	15
5685	2026-05-22 19:00:00	29	16.25
5691	2026-05-22 19:00:00	26	40
5693	2026-05-22 19:00:00	1	12
5697	2026-05-22 19:00:00	30	16.25
5699	2026-05-22 19:00:00	3	168.6
5702	2026-05-22 20:00:00	10	15
5705	2026-05-22 20:00:00	24	10
5713	2026-05-22 20:00:00	23	258
5717	2026-05-22 20:00:00	9	15
5722	2026-05-22 20:00:00	25	10
5727	2026-05-22 20:00:00	8	168.6
5733	2026-05-22 20:00:00	22	39.96
5738	2026-05-22 20:00:00	6	12
5742	2026-05-22 20:00:00	21	40
5748	2026-05-22 20:00:00	7	24.75
5755	2026-05-22 21:00:00	32	39.1
5753	2026-05-22 21:00:00	9	15
5764	2026-05-22 21:00:00	8	168.6
5765	2026-05-22 21:00:00	31	40
5773	2026-05-22 21:00:00	6	12
5778	2026-05-22 21:00:00	33	261.75
5781	2026-05-22 21:00:00	7	24.72
5788	2026-05-22 21:00:00	34	16.25
5794	2026-05-22 21:00:00	10	15
5797	2026-05-22 21:00:00	35	16.25
5805	2026-05-22 22:00:00	22	39.98
5807	2026-05-22 22:00:00	35	16.25
5814	2026-05-22 22:00:00	21	40
5819	2026-05-22 22:00:00	32	38.9
5826	2026-05-22 22:00:00	24	10
5830	2026-05-22 22:00:00	31	40
5837	2026-05-22 22:00:00	23	258
5838	2026-05-22 22:00:00	33	261.75
5848	2026-05-22 22:00:00	34	16.25
5849	2026-05-22 22:00:00	25	10
5852	2026-05-22 23:00:00	6	12
5855	2026-05-22 23:00:00	11	40
5861	2026-05-22 23:00:00	15	10
5863	2026-05-22 23:00:00	7	24.97
5873	2026-05-22 23:00:00	14	10
5875	2026-05-22 23:00:00	10	15
5884	2026-05-22 23:00:00	9	15
5885	2026-05-22 23:00:00	13	258
5894	2026-05-22 23:00:00	8	168.6
5896	2026-05-22 23:00:00	12	55.14
5906	2026-05-23 00:00:00	30	16
5907	2026-05-23 00:00:00	34	16.25
5912	2026-05-23 00:00:00	28	261.6
5918	2026-05-23 00:00:00	35	16.25
5921	2026-05-23 00:00:00	27	39.09
5927	2026-05-23 00:00:00	29	16
5932	2026-05-23 00:00:00	32	38.98
5935	2026-05-23 00:00:00	26	40
5943	2026-05-23 00:00:00	31	40
5950	2026-05-23 00:00:00	33	261.75
5952	2026-05-23 01:00:00	2	24.81
5958	2026-05-23 01:00:00	41	40
5961	2026-05-23 01:00:00	42	40.03
5967	2026-05-23 01:00:00	5	15
5971	2026-05-23 01:00:00	43	258.3
5977	2026-05-23 01:00:00	44	10.5
5982	2026-05-23 01:00:00	4	15
5985	2026-05-23 01:00:00	45	10.5
5992	2026-05-23 01:00:00	1	12
5998	2026-05-23 01:00:00	3	168.6
6004	2026-05-23 02:00:00	11	40
6009	2026-05-23 02:00:00	45	10.5
6014	2026-05-23 02:00:00	15	10
6019	2026-05-23 02:00:00	41	40
6023	2026-05-23 02:00:00	14	10
6031	2026-05-23 02:00:00	42	40
6034	2026-05-23 02:00:00	13	258
6042	2026-05-23 02:00:00	43	258.3
6043	2026-05-23 02:00:00	12	55.23
6048	2026-05-23 02:00:00	44	10.5
6055	2026-05-23 03:00:00	12	55.11
6058	2026-05-23 03:00:00	44	10.5
6067	2026-05-23 03:00:00	45	10.5
6069	2026-05-23 03:00:00	11	40
6076	2026-05-23 03:00:00	41	40
6082	2026-05-23 03:00:00	15	10
6088	2026-05-23 03:00:00	42	39.94
6092	2026-05-23 03:00:00	14	10
6097	2026-05-23 03:00:00	43	258.3
6099	2026-05-23 03:00:00	13	258
6102	2026-05-23 04:00:00	10	15
4358	2026-05-21 17:00:00	26	40
4361	2026-05-21 17:00:00	2	24.93
4368	2026-05-21 17:00:00	28	261.6
4373	2026-05-21 17:00:00	5	15
4374	2026-05-21 17:00:00	30	16
4381	2026-05-21 17:00:00	1	12
4382	2026-05-21 17:00:00	27	39.04
4388	2026-05-21 17:00:00	4	15
4389	2026-05-21 17:00:00	29	16
4409	2026-05-21 18:00:00	36	40
4410	2026-05-21 18:00:00	43	258.3
4419	2026-05-21 18:00:00	39	10.5
4425	2026-05-21 18:00:00	44	10.5
4432	2026-05-21 18:00:00	40	10.5
4434	2026-05-21 18:00:00	45	10.5
4440	2026-05-21 18:00:00	37	39.97
4446	2026-05-21 18:00:00	41	40
4449	2026-05-21 18:00:00	38	258.3
4450	2026-05-21 18:00:00	42	39.95
4451	2026-05-21 19:00:00	2	24.93
4452	2026-05-21 19:00:00	10	15
4458	2026-05-21 19:00:00	5	15
4465	2026-05-21 19:00:00	8	168.6
4469	2026-05-21 19:00:00	1	12
4476	2026-05-21 19:00:00	6	12
4480	2026-05-21 19:00:00	4	15
4487	2026-05-21 19:00:00	7	24.83
4490	2026-05-21 19:00:00	3	168.6
4498	2026-05-21 19:00:00	9	15
4609	2026-05-21 22:00:00	50	12
4611	2026-05-21 22:00:00	13	258
4613	2026-05-21 22:00:00	29	16.25
4615	2026-05-21 22:00:00	38	258.3
4617	2026-05-21 22:00:00	12	55.22
4619	2026-05-21 22:00:00	46	40
4620	2026-05-21 22:00:00	9	15
4623	2026-05-21 22:00:00	11	40
4625	2026-05-21 22:00:00	26	40
4627	2026-05-21 22:00:00	36	40
4629	2026-05-21 22:00:00	48	259.2
4630	2026-05-21 22:00:00	8	168.6
4632	2026-05-21 22:00:00	15	10
4634	2026-05-21 22:00:00	30	16.25
4636	2026-05-21 22:00:00	49	12
4637	2026-05-21 22:00:00	6	12
4642	2026-05-21 22:00:00	39	10.5
4643	2026-05-21 22:00:00	28	261.75
4646	2026-05-21 22:00:00	7	24.99
4647	2026-05-21 22:00:00	47	39.66
4650	2026-05-21 22:00:00	40	10.5
4651	2026-05-21 23:00:00	5	15
4653	2026-05-21 23:00:00	19	39
4656	2026-05-21 23:00:00	25	10
4657	2026-05-21 23:00:00	31	40
4658	2026-05-21 23:00:00	50	12.25
4661	2026-05-21 23:00:00	4	15
4662	2026-05-21 23:00:00	46	40
4665	2026-05-21 23:00:00	22	39.97
4668	2026-05-21 23:00:00	18	275.4
4669	2026-05-21 23:00:00	33	261.75
4671	2026-05-21 23:00:00	48	259.35
4672	2026-05-21 23:00:00	1	12
4673	2026-05-21 23:00:00	20	39
4679	2026-05-21 23:00:00	34	16.25
4680	2026-05-21 23:00:00	21	40
4682	2026-05-21 23:00:00	3	168.6
4683	2026-05-21 23:00:00	16	40
4689	2026-05-21 23:00:00	24	10
4690	2026-05-21 23:00:00	35	16.25
4691	2026-05-21 23:00:00	2	24.89
4693	2026-05-21 23:00:00	23	258
4694	2026-05-21 23:00:00	49	12.25
4695	2026-05-21 23:00:00	17	34.88
4699	2026-05-21 23:00:00	32	38.91
4700	2026-05-21 23:00:00	47	39.62
4701	2026-05-22 00:00:00	5	15
4703	2026-05-22 00:00:00	8	168.6
4706	2026-05-22 00:00:00	28	261.75
4707	2026-05-22 00:00:00	41	40
4708	2026-05-22 00:00:00	32	39.15
4711	2026-05-22 00:00:00	31	40
4712	2026-05-22 00:00:00	42	40.09
4715	2026-05-22 00:00:00	4	15
4718	2026-05-22 00:00:00	6	12
4719	2026-05-22 00:00:00	27	39
4720	2026-05-22 00:00:00	33	261.6
4721	2026-05-22 00:00:00	43	258.3
4725	2026-05-22 00:00:00	1	12
4726	2026-05-22 00:00:00	34	16
4727	2026-05-22 00:00:00	44	10.5
4732	2026-05-22 00:00:00	29	16.25
4733	2026-05-22 00:00:00	7	24.97
4734	2026-05-22 00:00:00	35	16
4735	2026-05-22 00:00:00	45	10.5
4738	2026-05-22 00:00:00	3	168.6
4742	2026-05-22 00:00:00	26	40
4743	2026-05-22 00:00:00	10	15
4744	2026-05-22 00:00:00	2	24.75
4748	2026-05-22 00:00:00	9	15
4750	2026-05-22 00:00:00	30	16.25
4752	2026-05-22 01:00:00	4	15
4754	2026-05-22 01:00:00	17	35.01
4756	2026-05-22 01:00:00	42	40.08
4757	2026-05-22 01:00:00	28	261.75
4759	2026-05-22 01:00:00	49	12.25
4761	2026-05-22 01:00:00	19	38.75
4765	2026-05-22 01:00:00	1	12
4767	2026-05-22 01:00:00	47	39.74
4768	2026-05-22 01:00:00	27	38.93
4769	2026-05-22 01:00:00	43	258.45
4770	2026-05-22 01:00:00	18	275.25
4774	2026-05-22 01:00:00	3	168.6
4776	2026-05-22 01:00:00	20	38.75
4780	2026-05-22 01:00:00	50	12.25
4782	2026-05-22 01:00:00	2	24.79
4783	2026-05-22 01:00:00	44	10.75
4784	2026-05-22 01:00:00	29	16.25
4785	2026-05-22 01:00:00	16	40
4790	2026-05-22 01:00:00	46	40
4791	2026-05-22 01:00:00	5	15
4792	2026-05-22 01:00:00	26	40
4793	2026-05-22 01:00:00	45	10.75
4796	2026-05-22 01:00:00	48	259.35
4797	2026-05-22 01:00:00	41	40
4798	2026-05-22 01:00:00	30	16.25
4803	2026-05-22 02:00:00	11	40
4804	2026-05-22 02:00:00	24	10
4805	2026-05-22 02:00:00	18	275.25
4808	2026-05-22 02:00:00	27	38.99
4809	2026-05-22 02:00:00	47	39.82
4812	2026-05-22 02:00:00	23	258
4813	2026-05-22 02:00:00	15	10
4814	2026-05-22 02:00:00	29	16.25
4816	2026-05-22 02:00:00	20	38.75
4819	2026-05-22 02:00:00	44	10.5
4820	2026-05-22 02:00:00	40	10.5
4356	2026-05-21 17:00:00	36	40
4366	2026-05-21 17:00:00	39	10.5
4376	2026-05-21 17:00:00	40	10.5
4391	2026-05-21 17:00:00	37	40.04
4398	2026-05-21 17:00:00	38	258.3
4408	2026-05-21 18:00:00	13	258
4414	2026-05-21 18:00:00	12	55.21
4423	2026-05-21 18:00:00	15	10
4435	2026-05-21 18:00:00	11	40
4444	2026-05-21 18:00:00	14	10
4460	2026-05-21 19:00:00	26	40
4470	2026-05-21 19:00:00	28	261.75
4474	2026-05-21 19:00:00	30	16.25
4484	2026-05-21 19:00:00	27	39.12
4491	2026-05-21 19:00:00	29	16.25
5505	2026-05-22 16:00:00	21	40
5517	2026-05-22 16:00:00	24	10
5530	2026-05-22 16:00:00	23	258
5540	2026-05-22 16:00:00	25	10
5548	2026-05-22 16:00:00	22	40.12
5552	2026-05-22 17:00:00	13	258
5567	2026-05-22 17:00:00	12	55.21
5580	2026-05-22 17:00:00	11	40
5591	2026-05-22 17:00:00	15	10
5597	2026-05-22 17:00:00	14	10
5609	2026-05-22 18:00:00	11	40
5620	2026-05-22 18:00:00	15	10
5631	2026-05-22 18:00:00	14	10
5642	2026-05-22 18:00:00	13	258
5650	2026-05-22 18:00:00	12	55.19
5652	2026-05-22 19:00:00	10	15
5668	2026-05-22 19:00:00	9	15
5681	2026-05-22 19:00:00	8	168.6
5695	2026-05-22 19:00:00	6	12
5700	2026-05-22 19:00:00	7	24.73
5701	2026-05-22 20:00:00	4	15
5716	2026-05-22 20:00:00	1	12
5726	2026-05-22 20:00:00	3	168.6
5732	2026-05-22 20:00:00	2	24.93
5744	2026-05-22 20:00:00	5	15
5752	2026-05-22 21:00:00	16	40
5768	2026-05-22 21:00:00	17	35.12
5779	2026-05-22 21:00:00	19	38.75
5790	2026-05-22 21:00:00	18	275.25
5798	2026-05-22 21:00:00	20	38.75
5802	2026-05-22 22:00:00	15	10
5818	2026-05-22 22:00:00	14	10
5829	2026-05-22 22:00:00	13	258
5840	2026-05-22 22:00:00	12	55.02
5847	2026-05-22 22:00:00	11	40
5854	2026-05-22 23:00:00	17	35.16
5866	2026-05-22 23:00:00	19	38.5
5877	2026-05-22 23:00:00	18	275.1
5888	2026-05-22 23:00:00	20	38.5
5898	2026-05-22 23:00:00	16	40
5904	2026-05-23 00:00:00	11	40
5919	2026-05-23 00:00:00	15	10
5933	2026-05-23 00:00:00	14	10
5945	2026-05-23 00:00:00	13	258
5949	2026-05-23 00:00:00	12	55.23
5951	2026-05-23 01:00:00	7	24.79
5966	2026-05-23 01:00:00	10	15
5981	2026-05-23 01:00:00	9	15
5991	2026-05-23 01:00:00	8	168.6
5997	2026-05-23 01:00:00	6	12
6006	2026-05-23 02:00:00	18	275.1
6018	2026-05-23 02:00:00	20	38.5
6032	2026-05-23 02:00:00	16	40
6041	2026-05-23 02:00:00	17	35.17
6049	2026-05-23 02:00:00	19	38.5
6052	2026-05-23 03:00:00	5	15
6063	2026-05-23 03:00:00	4	15
6072	2026-05-23 03:00:00	1	12
6078	2026-05-23 03:00:00	3	168.6
6087	2026-05-23 03:00:00	2	24.95
6107	2026-05-23 04:00:00	48	259.35
6117	2026-05-23 04:00:00	49	12.25
6126	2026-05-23 04:00:00	47	39.83
6136	2026-05-23 04:00:00	50	12.25
6146	2026-05-23 04:00:00	46	40
6153	2026-05-23 05:00:00	17	34.94
6165	2026-05-23 05:00:00	19	38.75
6177	2026-05-23 05:00:00	18	275.25
6188	2026-05-23 05:00:00	20	38.75
6196	2026-05-23 05:00:00	16	40
6204	2026-05-23 06:00:00	23	258
6218	2026-05-23 06:00:00	25	10
6224	2026-05-23 06:00:00	22	40.06
6231	2026-05-23 06:00:00	21	40
6236	2026-05-23 06:00:00	24	10
6257	2026-05-23 07:00:00	40	10.5
6268	2026-05-23 07:00:00	37	39.86
6282	2026-05-23 07:00:00	38	258.3
6289	2026-05-23 07:00:00	36	40
6299	2026-05-23 07:00:00	39	10.5
6302	2026-05-23 08:00:00	7	24.88
6312	2026-05-23 08:00:00	10	15
6328	2026-05-23 08:00:00	9	15
6339	2026-05-23 08:00:00	8	168.6
6346	2026-05-23 08:00:00	6	12
6354	2026-05-23 09:00:00	16	40
6369	2026-05-23 09:00:00	17	35.19
6377	2026-05-23 09:00:00	19	38.75
6385	2026-05-23 09:00:00	18	275.25
6396	2026-05-23 09:00:00	20	38.75
6410	2026-05-23 10:00:00	45	10.5
6419	2026-05-23 10:00:00	41	40
6430	2026-05-23 10:00:00	42	40.01
6441	2026-05-23 10:00:00	43	258.3
6446	2026-05-23 10:00:00	50	12.25
6449	2026-05-23 10:00:00	44	10.5
6453	2026-05-23 11:00:00	15	10
6460	2026-05-23 11:00:00	21	40
6469	2026-05-23 11:00:00	14	10
6470	2026-05-23 11:00:00	24	10
6472	2026-05-23 11:00:00	13	258
6479	2026-05-23 11:00:00	23	258
6483	2026-05-23 11:00:00	12	55.16
6492	2026-05-23 11:00:00	25	10
6499	2026-05-23 11:00:00	11	40
6500	2026-05-23 11:00:00	22	40.13
6503	2026-05-23 12:00:00	9	15
6504	2026-05-23 12:00:00	21	92
6512	2026-05-23 12:00:00	8	168.6
6516	2026-05-23 12:00:00	24	10
6526	2026-05-23 12:00:00	23	429.6
6528	2026-05-23 12:00:00	6	12
6532	2026-05-23 12:00:00	25	10
6539	2026-05-23 12:00:00	7	24.83
6542	2026-05-23 12:00:00	22	67.46
6549	2026-05-23 12:00:00	10	15
6552	2026-05-23 13:00:00	8	168.6
6555	2026-05-23 13:00:00	27	34.94
6562	2026-05-23 13:00:00	29	40
6567	2026-05-23 13:00:00	6	12
6572	2026-05-23 13:00:00	26	40
4359	2026-05-21 17:00:00	35	16.25
4364	2026-05-21 17:00:00	6	12
4372	2026-05-21 17:00:00	32	39.04
4378	2026-05-21 17:00:00	8	168.6
4380	2026-05-21 17:00:00	31	40
4383	2026-05-21 17:00:00	7	24.97
4387	2026-05-21 17:00:00	33	261.75
4393	2026-05-21 17:00:00	10	15
4394	2026-05-21 17:00:00	34	16.25
4405	2026-05-21 18:00:00	35	16.25
4403	2026-05-21 18:00:00	24	10
4411	2026-05-21 18:00:00	32	39.03
4417	2026-05-21 18:00:00	23	258
4420	2026-05-21 18:00:00	31	40
4426	2026-05-21 18:00:00	33	261.75
4429	2026-05-21 18:00:00	22	40.05
4437	2026-05-21 18:00:00	34	16.25
4439	2026-05-21 18:00:00	25	10
4447	2026-05-21 18:00:00	21	40
4453	2026-05-21 19:00:00	25	10
4455	2026-05-21 19:00:00	43	258.3
4462	2026-05-21 19:00:00	21	40
4463	2026-05-21 19:00:00	44	10.5
4472	2026-05-21 19:00:00	45	10.5
4473	2026-05-21 19:00:00	24	10
4482	2026-05-21 19:00:00	41	40
4483	2026-05-21 19:00:00	23	258
4492	2026-05-21 19:00:00	42	39.92
4496	2026-05-21 19:00:00	22	40.16
4501	2026-05-21 20:00:00	7	24.75
4502	2026-05-21 20:00:00	16	40
4503	2026-05-21 20:00:00	29	16.25
4504	2026-05-21 20:00:00	38	258.3
4505	2026-05-21 20:00:00	34	16.25
4507	2026-05-21 20:00:00	43	258.3
4506	2026-05-21 20:00:00	25	10
4508	2026-05-21 20:00:00	12	55.03
4509	2026-05-21 20:00:00	3	168.6
4510	2026-05-21 20:00:00	50	12.25
4511	2026-05-21 20:00:00	36	40
4512	2026-05-21 20:00:00	17	35.21
4513	2026-05-21 20:00:00	26	40
4514	2026-05-21 20:00:00	35	16.25
4515	2026-05-21 20:00:00	10	15
4516	2026-05-21 20:00:00	22	40.2
4517	2026-05-21 20:00:00	46	40
4518	2026-05-21 20:00:00	44	10.5
4519	2026-05-21 20:00:00	2	24.79
4520	2026-05-21 20:00:00	11	40
4521	2026-05-21 20:00:00	28	261.75
4522	2026-05-21 20:00:00	32	39.1
4523	2026-05-21 20:00:00	19	38.75
4524	2026-05-21 20:00:00	39	10.5
4525	2026-05-21 20:00:00	21	40
4526	2026-05-21 20:00:00	48	259.35
4527	2026-05-21 20:00:00	9	15
4528	2026-05-21 20:00:00	30	16.25
4529	2026-05-21 20:00:00	31	40
4530	2026-05-21 20:00:00	5	15
4531	2026-05-21 20:00:00	45	10.5
4532	2026-05-21 20:00:00	24	10
4533	2026-05-21 20:00:00	49	12.25
4534	2026-05-21 20:00:00	18	275.25
4535	2026-05-21 20:00:00	15	10
4536	2026-05-21 20:00:00	27	39.1
4537	2026-05-21 20:00:00	33	261.75
4538	2026-05-21 20:00:00	1	12
4539	2026-05-21 20:00:00	40	10.5
4540	2026-05-21 20:00:00	23	258
4541	2026-05-21 20:00:00	47	39.67
4542	2026-05-21 20:00:00	20	38.75
4543	2026-05-21 20:00:00	8	168.6
4544	2026-05-21 20:00:00	41	40
4545	2026-05-21 20:00:00	14	10
4546	2026-05-21 20:00:00	4	15
4547	2026-05-21 20:00:00	6	12
4548	2026-05-21 20:00:00	37	39.94
4549	2026-05-21 20:00:00	42	40.05
4550	2026-05-21 20:00:00	13	258
4551	2026-05-21 21:00:00	6	12
4552	2026-05-21 21:00:00	2	24.79
4553	2026-05-21 21:00:00	11	40
4554	2026-05-21 21:00:00	21	40
4555	2026-05-21 21:00:00	19	38.5
4556	2026-05-21 21:00:00	30	16.25
4557	2026-05-21 21:00:00	50	12
4558	2026-05-21 21:00:00	39	10.5
4559	2026-05-21 21:00:00	32	38.98
4560	2026-05-21 21:00:00	44	10.5
4561	2026-05-21 21:00:00	24	10
4562	2026-05-21 21:00:00	46	40
4563	2026-05-21 21:00:00	5	15
4564	2026-05-21 21:00:00	7	24.94
4565	2026-05-21 21:00:00	40	10.5
4566	2026-05-21 21:00:00	28	261.75
4567	2026-05-21 21:00:00	45	10.5
4568	2026-05-21 21:00:00	15	10
4569	2026-05-21 21:00:00	18	275.1
4570	2026-05-21 21:00:00	23	258
4571	2026-05-21 21:00:00	48	259.2
4572	2026-05-21 21:00:00	31	40
4573	2026-05-21 21:00:00	1	12
4574	2026-05-21 21:00:00	25	10
4575	2026-05-21 21:00:00	49	12
4576	2026-05-21 21:00:00	41	40
4577	2026-05-21 21:00:00	27	39
4578	2026-05-21 21:00:00	37	39.99
4579	2026-05-21 21:00:00	10	15
4580	2026-05-21 21:00:00	20	38.5
4581	2026-05-21 21:00:00	14	10
4582	2026-05-21 21:00:00	22	40.17
4583	2026-05-21 21:00:00	47	39.72
4584	2026-05-21 21:00:00	33	261.75
4585	2026-05-21 21:00:00	4	15
4586	2026-05-21 21:00:00	42	39.85
4587	2026-05-21 21:00:00	29	16.25
4588	2026-05-21 21:00:00	38	258.3
4589	2026-05-21 21:00:00	9	15
4590	2026-05-21 21:00:00	16	40
4591	2026-05-21 21:00:00	13	258
4592	2026-05-21 21:00:00	34	16.25
4593	2026-05-21 21:00:00	26	40
4594	2026-05-21 21:00:00	43	258.3
4595	2026-05-21 21:00:00	3	168.6
4596	2026-05-21 21:00:00	36	40
4597	2026-05-21 21:00:00	8	168.6
4598	2026-05-21 21:00:00	12	55.23
4599	2026-05-21 21:00:00	17	35.01
4600	2026-05-21 21:00:00	35	16.25
4601	2026-05-21 22:00:00	4	15
4605	2026-05-21 22:00:00	20	38.75
4602	2026-05-21 22:00:00	27	39.02
4603	2026-05-21 22:00:00	14	10
4607	2026-05-21 22:00:00	37	40.14
4608	2026-05-21 22:00:00	33	261.75
4604	2026-05-21 22:00:00	10	15
4821	2026-05-22 02:00:00	25	10
4828	2026-05-22 02:00:00	22	40.12
4841	2026-05-22 02:00:00	21	40
4860	2026-05-22 03:00:00	37	39.91
4868	2026-05-22 03:00:00	38	258.3
4884	2026-05-22 03:00:00	36	40
4896	2026-05-22 03:00:00	39	10.5
4899	2026-05-22 03:00:00	40	10.5
4902	2026-05-22 04:00:00	9	15
4912	2026-05-22 04:00:00	8	168.6
4921	2026-05-22 04:00:00	6	12
4930	2026-05-22 04:00:00	7	24.85
4942	2026-05-22 04:00:00	10	15
4960	2026-05-22 05:00:00	39	10.5
4967	2026-05-22 05:00:00	40	10.5
4976	2026-05-22 05:00:00	37	39.96
4989	2026-05-22 05:00:00	38	258.3
4996	2026-05-22 05:00:00	36	40
5010	2026-05-22 06:00:00	21	40
5016	2026-05-22 06:00:00	24	10
5025	2026-05-22 06:00:00	23	258
5033	2026-05-22 06:00:00	25	10
5046	2026-05-22 06:00:00	22	40.22
5055	2026-05-22 07:00:00	24	10
5068	2026-05-22 07:00:00	23	258
5078	2026-05-22 07:00:00	25	10
5090	2026-05-22 07:00:00	22	39.99
5100	2026-05-22 07:00:00	21	40
5101	2026-05-22 08:00:00	1	12
5114	2026-05-22 08:00:00	3	168.6
5126	2026-05-22 08:00:00	2	24.96
5135	2026-05-22 08:00:00	5	15
5146	2026-05-22 08:00:00	4	15
5159	2026-05-22 09:00:00	23	258
5167	2026-05-22 09:00:00	25	10
5179	2026-05-22 09:00:00	22	40.22
5188	2026-05-22 09:00:00	21	40
5196	2026-05-22 09:00:00	24	10
5205	2026-05-22 10:00:00	23	258
5215	2026-05-22 10:00:00	25	10
5224	2026-05-22 10:00:00	22	40.23
5231	2026-05-22 10:00:00	21	40
5242	2026-05-22 10:00:00	24	10
5256	2026-05-22 11:00:00	30	16
5264	2026-05-22 11:00:00	28	261.6
5275	2026-05-22 11:00:00	27	38.98
5288	2026-05-22 11:00:00	29	16
5295	2026-05-22 11:00:00	26	40
5306	2026-05-22 12:00:00	27	65.68
5315	2026-05-22 12:00:00	29	16
5325	2026-05-22 12:00:00	26	92
5331	2026-05-22 12:00:00	30	16
5341	2026-05-22 12:00:00	28	433.2
5356	2026-05-22 13:00:00	33	276
5368	2026-05-22 13:00:00	34	40
5380	2026-05-22 13:00:00	35	40
5390	2026-05-22 13:00:00	32	34.94
5398	2026-05-22 13:00:00	31	40
5406	2026-05-22 14:00:00	16	40
5419	2026-05-22 14:00:00	17	34.92
5422	2026-05-22 14:00:00	19	38.75
5430	2026-05-22 14:00:00	18	275.25
5438	2026-05-22 14:00:00	20	38.75
5458	2026-05-22 15:00:00	45	10.75
5464	2026-05-22 15:00:00	41	40
5470	2026-05-22 15:00:00	42	40.11
5478	2026-05-22 15:00:00	43	258.45
5485	2026-05-22 15:00:00	44	10.75
5506	2026-05-22 16:00:00	13	258
5515	2026-05-22 16:00:00	12	55.2
5523	2026-05-22 16:00:00	11	40
5536	2026-05-22 16:00:00	15	10
5543	2026-05-22 16:00:00	14	10
5560	2026-05-22 17:00:00	33	261.75
5570	2026-05-22 17:00:00	34	16.25
5582	2026-05-22 17:00:00	35	16.25
5593	2026-05-22 17:00:00	32	38.94
5600	2026-05-22 17:00:00	31	40
5601	2026-05-22 18:00:00	5	15
5612	2026-05-22 18:00:00	4	15
5623	2026-05-22 18:00:00	1	12
5634	2026-05-22 18:00:00	3	168.6
5643	2026-05-22 18:00:00	2	24.87
5659	2026-05-22 19:00:00	39	10.5
5670	2026-05-22 19:00:00	40	10.5
5684	2026-05-22 19:00:00	37	39.91
5692	2026-05-22 19:00:00	38	258.3
5698	2026-05-22 19:00:00	36	40
5704	2026-05-22 20:00:00	13	258
5715	2026-05-22 20:00:00	12	55.19
5724	2026-05-22 20:00:00	11	40
5736	2026-05-22 20:00:00	15	10
5746	2026-05-22 20:00:00	14	10
5756	2026-05-22 21:00:00	23	258
5761	2026-05-22 21:00:00	25	10
5777	2026-05-22 21:00:00	22	40.03
5786	2026-05-22 21:00:00	21	40
5792	2026-05-22 21:00:00	24	10
5809	2026-05-22 22:00:00	39	10.75
5816	2026-05-22 22:00:00	40	10.75
5821	2026-05-22 22:00:00	37	40.1
5828	2026-05-22 22:00:00	38	258.45
5834	2026-05-22 22:00:00	36	40
5858	2026-05-22 23:00:00	46	40
5869	2026-05-22 23:00:00	48	259.35
5880	2026-05-22 23:00:00	49	12.25
5886	2026-05-22 23:00:00	47	39.56
5899	2026-05-22 23:00:00	50	12.25
5902	2026-05-23 00:00:00	6	12
5914	2026-05-23 00:00:00	7	24.8
5929	2026-05-23 00:00:00	10	15
5940	2026-05-23 00:00:00	9	15
5946	2026-05-23 00:00:00	8	168.6
5953	2026-05-23 01:00:00	22	39.96
5965	2026-05-23 01:00:00	21	40
5980	2026-05-23 01:00:00	24	10
5990	2026-05-23 01:00:00	23	258
5995	2026-05-23 01:00:00	25	10
6005	2026-05-23 02:00:00	24	10
6016	2026-05-23 02:00:00	23	258
6028	2026-05-23 02:00:00	25	10
6040	2026-05-23 02:00:00	22	39.96
6050	2026-05-23 02:00:00	21	40
6051	2026-05-23 03:00:00	10	15
6064	2026-05-23 03:00:00	9	15
6077	2026-05-23 03:00:00	8	168.6
6084	2026-05-23 03:00:00	6	12
6094	2026-05-23 03:00:00	7	24.93
6106	2026-05-23 04:00:00	30	16.25
6116	2026-05-23 04:00:00	28	261.75
6124	2026-05-23 04:00:00	27	39.13
6131	2026-05-23 04:00:00	29	16.25
6142	2026-05-23 04:00:00	26	40
6157	2026-05-23 05:00:00	32	39.03
6163	2026-05-23 05:00:00	31	40
6172	2026-05-23 05:00:00	33	261.75
4822	2026-05-22 02:00:00	14	10
4832	2026-05-22 02:00:00	13	258
4843	2026-05-22 02:00:00	12	55.18
4857	2026-05-22 03:00:00	46	40
4873	2026-05-22 03:00:00	48	259.2
4879	2026-05-22 03:00:00	49	12
4887	2026-05-22 03:00:00	47	39.59
4891	2026-05-22 03:00:00	50	12
4910	2026-05-22 04:00:00	39	10.5
4914	2026-05-22 04:00:00	40	10.5
4927	2026-05-22 04:00:00	37	40.05
4940	2026-05-22 04:00:00	38	258.3
4948	2026-05-22 04:00:00	36	40
4954	2026-05-22 05:00:00	13	258
4965	2026-05-22 05:00:00	12	55.16
4971	2026-05-22 05:00:00	11	40
4979	2026-05-22 05:00:00	15	10
4986	2026-05-22 05:00:00	14	10
5007	2026-05-22 06:00:00	46	40
5021	2026-05-22 06:00:00	48	259.2
5036	2026-05-22 06:00:00	49	12
5045	2026-05-22 06:00:00	47	39.68
5049	2026-05-22 06:00:00	50	12
5051	2026-05-22 07:00:00	5	15
5061	2026-05-22 07:00:00	4	15
5076	2026-05-22 07:00:00	1	12
5089	2026-05-22 07:00:00	3	168.6
5096	2026-05-22 07:00:00	2	24.96
5104	2026-05-22 08:00:00	25	10
5117	2026-05-22 08:00:00	22	40.22
5129	2026-05-22 08:00:00	21	40
5136	2026-05-22 08:00:00	24	10
5142	2026-05-22 08:00:00	23	258
5157	2026-05-22 09:00:00	32	39.08
5163	2026-05-22 09:00:00	31	40
5172	2026-05-22 09:00:00	33	261.75
5177	2026-05-22 09:00:00	34	16.25
5190	2026-05-22 09:00:00	35	16.25
5209	2026-05-22 10:00:00	43	258.3
5217	2026-05-22 10:00:00	44	10.5
5226	2026-05-22 10:00:00	45	10.5
5235	2026-05-22 10:00:00	41	40
5245	2026-05-22 10:00:00	42	40.14
5254	2026-05-22 11:00:00	25	10
5261	2026-05-22 11:00:00	22	40.1
5271	2026-05-22 11:00:00	21	40
5276	2026-05-22 11:00:00	24	10
5285	2026-05-22 11:00:00	23	258
5310	2026-05-22 12:00:00	46	92
5318	2026-05-22 12:00:00	48	431.1
5328	2026-05-22 12:00:00	49	12.5
5339	2026-05-22 12:00:00	47	66.51
5346	2026-05-22 12:00:00	50	12.5
5360	2026-05-22 13:00:00	23	272.4
5371	2026-05-22 13:00:00	25	34
5384	2026-05-22 13:00:00	22	35.95
5393	2026-05-22 13:00:00	21	40
5400	2026-05-22 13:00:00	24	34
5401	2026-05-22 14:00:00	3	168.6
5413	2026-05-22 14:00:00	2	24.99
5424	2026-05-22 14:00:00	5	15
5437	2026-05-22 14:00:00	4	15
5446	2026-05-22 14:00:00	1	12
5457	2026-05-22 15:00:00	25	10
5467	2026-05-22 15:00:00	22	40.14
5481	2026-05-22 15:00:00	21	40
5491	2026-05-22 15:00:00	24	10
5496	2026-05-22 15:00:00	23	258
5507	2026-05-22 16:00:00	38	258.3
5512	2026-05-22 16:00:00	36	40
5520	2026-05-22 16:00:00	39	10.5
5526	2026-05-22 16:00:00	40	10.5
5534	2026-05-22 16:00:00	37	40.03
5558	2026-05-22 17:00:00	44	10.5
5569	2026-05-22 17:00:00	45	10.5
5583	2026-05-22 17:00:00	41	40
5594	2026-05-22 17:00:00	42	40.14
5599	2026-05-22 17:00:00	43	258.3
5602	2026-05-22 18:00:00	9	15
5613	2026-05-22 18:00:00	8	168.6
5626	2026-05-22 18:00:00	6	12
5636	2026-05-22 18:00:00	7	24.94
5644	2026-05-22 18:00:00	10	15
5657	2026-05-22 19:00:00	24	10
5663	2026-05-22 19:00:00	23	258
5673	2026-05-22 19:00:00	25	10
5679	2026-05-22 19:00:00	22	40.11
5689	2026-05-22 19:00:00	21	40
5706	2026-05-22 20:00:00	35	16.25
5718	2026-05-22 20:00:00	32	39.09
5731	2026-05-22 20:00:00	31	40
5743	2026-05-22 20:00:00	33	261.75
5749	2026-05-22 20:00:00	34	16.25
5754	2026-05-22 21:00:00	12	55.06
5767	2026-05-22 21:00:00	11	40
5780	2026-05-22 21:00:00	15	10
5791	2026-05-22 21:00:00	14	10
5799	2026-05-22 21:00:00	13	258
5801	2026-05-22 22:00:00	5	15
5811	2026-05-22 22:00:00	4	15
5822	2026-05-22 22:00:00	1	12
5833	2026-05-22 22:00:00	3	168.6
5844	2026-05-22 22:00:00	2	24.75
5856	2026-05-22 23:00:00	34	16.25
5865	2026-05-22 23:00:00	35	16.25
5872	2026-05-22 23:00:00	32	39.08
5882	2026-05-22 23:00:00	31	40
5892	2026-05-22 23:00:00	33	261.75
5910	2026-05-23 00:00:00	39	10.75
5923	2026-05-23 00:00:00	40	10.75
5938	2026-05-23 00:00:00	37	40.1
5944	2026-05-23 00:00:00	38	258.45
5948	2026-05-23 00:00:00	36	40
5955	2026-05-23 01:00:00	17	35.07
5968	2026-05-23 01:00:00	19	38.75
5974	2026-05-23 01:00:00	18	275.25
5988	2026-05-23 01:00:00	20	38.75
5994	2026-05-23 01:00:00	16	40
6003	2026-05-23 02:00:00	28	261.6
6017	2026-05-23 02:00:00	27	39.11
6026	2026-05-23 02:00:00	29	16
6036	2026-05-23 02:00:00	26	40
6045	2026-05-23 02:00:00	30	16
6054	2026-05-23 03:00:00	30	16
6062	2026-05-23 03:00:00	28	261.6
6071	2026-05-23 03:00:00	27	38.94
6079	2026-05-23 03:00:00	29	16
6090	2026-05-23 03:00:00	26	40
6108	2026-05-23 04:00:00	44	10.5
6118	2026-05-23 04:00:00	45	10.5
6130	2026-05-23 04:00:00	41	40
6140	2026-05-23 04:00:00	42	39.94
6149	2026-05-23 04:00:00	43	258.3
6156	2026-05-23 05:00:00	8	168.6
6168	2026-05-23 05:00:00	6	12
6182	2026-05-23 05:00:00	7	24.99
4823	2026-05-22 02:00:00	26	40
4831	2026-05-22 02:00:00	30	16.25
4839	2026-05-22 02:00:00	28	261.75
4856	2026-05-22 03:00:00	31	40
4861	2026-05-22 03:00:00	33	261.75
4869	2026-05-22 03:00:00	34	16.25
4881	2026-05-22 03:00:00	35	16.25
4895	2026-05-22 03:00:00	32	38.99
4905	2026-05-22 04:00:00	22	39.99
4913	2026-05-22 04:00:00	21	40
4928	2026-05-22 04:00:00	24	10
4938	2026-05-22 04:00:00	23	258
4947	2026-05-22 04:00:00	25	10
4955	2026-05-22 05:00:00	22	40.14
4968	2026-05-22 05:00:00	21	40
4983	2026-05-22 05:00:00	24	10
4994	2026-05-22 05:00:00	23	258
4999	2026-05-22 05:00:00	25	10
5003	2026-05-22 06:00:00	10	15
5014	2026-05-22 06:00:00	9	15
5023	2026-05-22 06:00:00	8	168.6
5030	2026-05-22 06:00:00	6	12
5041	2026-05-22 06:00:00	7	24.94
5056	2026-05-22 07:00:00	34	16.25
5063	2026-05-22 07:00:00	35	16.25
5073	2026-05-22 07:00:00	32	39.14
5085	2026-05-22 07:00:00	31	40
5095	2026-05-22 07:00:00	33	261.75
5107	2026-05-22 08:00:00	31	40
5119	2026-05-22 08:00:00	33	261.75
5131	2026-05-22 08:00:00	34	16.25
5140	2026-05-22 08:00:00	35	16.25
5147	2026-05-22 08:00:00	32	38.95
5152	2026-05-22 09:00:00	14	10
5164	2026-05-22 09:00:00	13	258
5173	2026-05-22 09:00:00	12	55.2
5183	2026-05-22 09:00:00	11	40
5192	2026-05-22 09:00:00	15	10
5207	2026-05-22 10:00:00	36	40
5212	2026-05-22 10:00:00	39	10.5
5221	2026-05-22 10:00:00	40	10.5
5228	2026-05-22 10:00:00	37	40.04
5237	2026-05-22 10:00:00	38	258.3
5259	2026-05-22 11:00:00	47	39.54
5266	2026-05-22 11:00:00	50	12.5
5279	2026-05-22 11:00:00	46	40
5291	2026-05-22 11:00:00	48	259.5
5297	2026-05-22 11:00:00	49	12.5
5305	2026-05-22 12:00:00	16	92
5312	2026-05-22 12:00:00	17	58.78
5322	2026-05-22 12:00:00	19	38.5
5327	2026-05-22 12:00:00	18	446.7
5336	2026-05-22 12:00:00	20	38.5
5357	2026-05-22 13:00:00	50	36.25
5367	2026-05-22 13:00:00	46	40
5381	2026-05-22 13:00:00	48	273.75
5392	2026-05-22 13:00:00	49	36.25
5399	2026-05-22 13:00:00	47	35.58
5403	2026-05-22 14:00:00	7	24.98
5414	2026-05-22 14:00:00	10	15
5429	2026-05-22 14:00:00	9	15
5439	2026-05-22 14:00:00	8	168.6
5448	2026-05-22 14:00:00	6	12
5454	2026-05-22 15:00:00	18	275.1
5468	2026-05-22 15:00:00	20	38.5
5482	2026-05-22 15:00:00	16	40
5492	2026-05-22 15:00:00	17	35.22
5498	2026-05-22 15:00:00	19	38.5
5508	2026-05-22 16:00:00	43	258.3
5516	2026-05-22 16:00:00	44	10.5
5528	2026-05-22 16:00:00	45	10.5
5538	2026-05-22 16:00:00	41	40
5545	2026-05-22 16:00:00	42	39.96
5555	2026-05-22 17:00:00	28	261.75
5562	2026-05-22 17:00:00	27	39.08
5571	2026-05-22 17:00:00	29	16.25
5577	2026-05-22 17:00:00	26	40
5584	2026-05-22 17:00:00	30	16.25
5608	2026-05-22 18:00:00	50	12.25
5615	2026-05-22 18:00:00	46	40
5625	2026-05-22 18:00:00	48	259.35
5635	2026-05-22 18:00:00	49	12.25
5645	2026-05-22 18:00:00	47	39.76
5654	2026-05-22 19:00:00	19	38.75
5664	2026-05-22 19:00:00	18	275.25
5674	2026-05-22 19:00:00	20	38.75
5683	2026-05-22 19:00:00	16	40
5696	2026-05-22 19:00:00	17	34.92
5703	2026-05-22 20:00:00	19	38.75
5711	2026-05-22 20:00:00	18	275.25
5720	2026-05-22 20:00:00	20	38.75
5730	2026-05-22 20:00:00	16	40
5739	2026-05-22 20:00:00	17	35.21
5759	2026-05-22 21:00:00	44	10.5
5770	2026-05-22 21:00:00	45	10.5
5783	2026-05-22 21:00:00	41	40
5789	2026-05-22 21:00:00	42	40.06
5795	2026-05-22 21:00:00	43	258.3
5806	2026-05-22 22:00:00	28	261.6
5812	2026-05-22 22:00:00	27	39.18
5823	2026-05-22 22:00:00	29	16
5832	2026-05-22 22:00:00	26	40
5841	2026-05-22 22:00:00	30	16
5859	2026-05-22 23:00:00	45	10.5
5868	2026-05-22 23:00:00	41	40
5876	2026-05-22 23:00:00	42	39.92
5889	2026-05-22 23:00:00	43	258.3
5897	2026-05-22 23:00:00	44	10.5
5903	2026-05-23 00:00:00	17	35.18
5911	2026-05-23 00:00:00	19	38.5
5920	2026-05-23 00:00:00	18	275.1
5926	2026-05-23 00:00:00	20	38.5
5934	2026-05-23 00:00:00	16	40
5962	2026-05-23 01:00:00	48	259.35
5975	2026-05-23 01:00:00	49	12.25
5989	2026-05-23 01:00:00	47	39.63
5996	2026-05-23 01:00:00	50	12.25
6000	2026-05-23 01:00:00	46	40
6002	2026-05-23 02:00:00	4	15
6013	2026-05-23 02:00:00	1	12
6022	2026-05-23 02:00:00	3	168.6
6033	2026-05-23 02:00:00	2	24.87
6044	2026-05-23 02:00:00	5	15
6057	2026-05-23 03:00:00	35	16.25
6065	2026-05-23 03:00:00	32	38.9
6074	2026-05-23 03:00:00	31	40
6085	2026-05-23 03:00:00	33	261.75
6095	2026-05-23 03:00:00	34	16.25
6104	2026-05-23 04:00:00	22	40.21
6123	2026-05-23 04:00:00	21	40
6135	2026-05-23 04:00:00	24	10
6145	2026-05-23 04:00:00	23	258
6150	2026-05-23 04:00:00	25	10
6151	2026-05-23 05:00:00	2	24.88
6164	2026-05-23 05:00:00	5	15
6176	2026-05-23 05:00:00	4	15
4824	2026-05-22 02:00:00	32	38.93
4833	2026-05-22 02:00:00	31	40
4842	2026-05-22 02:00:00	33	261.75
4859	2026-05-22 03:00:00	41	40
4864	2026-05-22 03:00:00	42	39.88
4872	2026-05-22 03:00:00	43	258.3
4882	2026-05-22 03:00:00	44	10.5
4893	2026-05-22 03:00:00	45	10.5
4906	2026-05-22 04:00:00	28	261.75
4915	2026-05-22 04:00:00	27	39.1
4922	2026-05-22 04:00:00	29	16.25
4931	2026-05-22 04:00:00	26	40
4936	2026-05-22 04:00:00	30	16.25
4957	2026-05-22 05:00:00	41	40
4969	2026-05-22 05:00:00	42	39.88
4984	2026-05-22 05:00:00	43	258.3
4995	2026-05-22 05:00:00	44	10.5
4998	2026-05-22 05:00:00	45	10.5
5008	2026-05-22 06:00:00	11	40
5020	2026-05-22 06:00:00	15	10
5035	2026-05-22 06:00:00	14	10
5044	2026-05-22 06:00:00	13	258
5048	2026-05-22 06:00:00	12	55.01
5059	2026-05-22 07:00:00	17	35.12
5067	2026-05-22 07:00:00	19	38.5
5077	2026-05-22 07:00:00	18	275.1
5080	2026-05-22 07:00:00	20	38.5
5087	2026-05-22 07:00:00	16	40
5106	2026-05-22 08:00:00	47	39.51
5112	2026-05-22 08:00:00	50	12.5
5121	2026-05-22 08:00:00	46	40
5128	2026-05-22 08:00:00	48	259.5
5141	2026-05-22 08:00:00	49	12.5
5160	2026-05-22 09:00:00	43	258.3
5170	2026-05-22 09:00:00	44	10.5
5181	2026-05-22 09:00:00	45	10.5
5193	2026-05-22 09:00:00	41	40
5199	2026-05-22 09:00:00	42	40.14
5202	2026-05-22 10:00:00	6	12
5219	2026-05-22 10:00:00	7	24.89
5234	2026-05-22 10:00:00	10	15
5243	2026-05-22 10:00:00	9	15
5249	2026-05-22 10:00:00	8	168.6
5255	2026-05-22 11:00:00	13	258
5269	2026-05-22 11:00:00	12	54.97
5283	2026-05-22 11:00:00	11	40
5293	2026-05-22 11:00:00	15	10
5299	2026-05-22 11:00:00	14	10
5302	2026-05-22 12:00:00	9	15
5317	2026-05-22 12:00:00	8	168.6
5329	2026-05-22 12:00:00	6	12
5343	2026-05-22 12:00:00	7	24.89
5349	2026-05-22 12:00:00	10	15
5354	2026-05-22 13:00:00	12	55.17
5364	2026-05-22 13:00:00	11	40
5374	2026-05-22 13:00:00	15	10
5387	2026-05-22 13:00:00	14	10
5396	2026-05-22 13:00:00	13	258
5402	2026-05-22 14:00:00	12	54.97
5415	2026-05-22 14:00:00	11	40
5426	2026-05-22 14:00:00	15	10
5434	2026-05-22 14:00:00	14	10
5442	2026-05-22 14:00:00	13	258
5461	2026-05-22 15:00:00	37	40.11
5476	2026-05-22 15:00:00	38	258.3
5490	2026-05-22 15:00:00	36	40
5497	2026-05-22 15:00:00	39	10.5
5500	2026-05-22 15:00:00	40	10.5
5509	2026-05-22 16:00:00	49	12.5
5522	2026-05-22 16:00:00	47	39.56
5533	2026-05-22 16:00:00	50	12.5
5542	2026-05-22 16:00:00	46	40
5549	2026-05-22 16:00:00	48	259.5
5553	2026-05-22 17:00:00	6	12
5564	2026-05-22 17:00:00	7	24.86
5573	2026-05-22 17:00:00	10	15
5579	2026-05-22 17:00:00	9	15
5588	2026-05-22 17:00:00	8	168.6
5606	2026-05-22 18:00:00	37	39.95
5616	2026-05-22 18:00:00	38	258.3
5627	2026-05-22 18:00:00	36	40
5640	2026-05-22 18:00:00	39	10.5
5646	2026-05-22 18:00:00	40	10.5
5655	2026-05-22 19:00:00	35	16.25
5661	2026-05-22 19:00:00	32	39.05
5671	2026-05-22 19:00:00	31	40
5677	2026-05-22 19:00:00	33	261.75
5686	2026-05-22 19:00:00	34	16.25
5709	2026-05-22 20:00:00	43	258.3
5714	2026-05-22 20:00:00	44	10.5
5725	2026-05-22 20:00:00	45	10.5
5737	2026-05-22 20:00:00	41	40
5747	2026-05-22 20:00:00	42	39.9
5757	2026-05-22 21:00:00	27	39.19
5762	2026-05-22 21:00:00	29	16
5771	2026-05-22 21:00:00	26	40
5775	2026-05-22 21:00:00	30	16
5784	2026-05-22 21:00:00	28	261.6
5810	2026-05-22 22:00:00	41	40
5817	2026-05-22 22:00:00	42	39.92
5825	2026-05-22 22:00:00	43	258.3
5836	2026-05-22 22:00:00	44	10.5
5846	2026-05-22 22:00:00	45	10.5
5853	2026-05-22 23:00:00	25	10
5862	2026-05-22 23:00:00	22	40.02
5874	2026-05-22 23:00:00	21	40
5883	2026-05-22 23:00:00	24	10
5893	2026-05-22 23:00:00	23	258
5908	2026-05-23 00:00:00	45	10.5
5916	2026-05-23 00:00:00	41	40
5925	2026-05-23 00:00:00	42	39.87
5937	2026-05-23 00:00:00	43	258.3
5939	2026-05-23 00:00:00	44	10.5
5957	2026-05-23 01:00:00	35	16.25
5964	2026-05-23 01:00:00	32	38.97
5973	2026-05-23 01:00:00	31	40
5979	2026-05-23 01:00:00	33	261.75
5987	2026-05-23 01:00:00	34	16.25
6007	2026-05-23 02:00:00	35	16.25
6011	2026-05-23 02:00:00	32	38.91
6020	2026-05-23 02:00:00	31	40
6027	2026-05-23 02:00:00	33	261.75
6039	2026-05-23 02:00:00	34	16.25
6059	2026-05-23 03:00:00	38	258.3
6073	2026-05-23 03:00:00	36	40
6083	2026-05-23 03:00:00	39	10.5
6093	2026-05-23 03:00:00	40	10.5
6098	2026-05-23 03:00:00	37	39.87
6105	2026-05-23 04:00:00	17	35.03
6119	2026-05-23 04:00:00	19	38.5
6127	2026-05-23 04:00:00	18	275.1
6137	2026-05-23 04:00:00	20	38.5
6147	2026-05-23 04:00:00	16	40
6152	2026-05-23 05:00:00	11	40
6161	2026-05-23 05:00:00	15	10
6169	2026-05-23 05:00:00	14	10
4825	2026-05-22 02:00:00	50	12.25
4835	2026-05-22 02:00:00	46	40
4845	2026-05-22 02:00:00	48	259.35
4850	2026-05-22 02:00:00	49	12.25
4851	2026-05-22 03:00:00	1	12
4866	2026-05-22 03:00:00	3	168.6
4875	2026-05-22 03:00:00	2	24.77
4883	2026-05-22 03:00:00	5	15
4889	2026-05-22 03:00:00	4	15
4908	2026-05-22 04:00:00	41	40
4918	2026-05-22 04:00:00	42	40
4933	2026-05-22 04:00:00	43	258.3
4944	2026-05-22 04:00:00	44	10.5
4950	2026-05-22 04:00:00	45	10.5
4953	2026-05-22 05:00:00	6	12
4961	2026-05-22 05:00:00	7	24.98
4973	2026-05-22 05:00:00	10	15
4981	2026-05-22 05:00:00	9	15
4988	2026-05-22 05:00:00	8	168.6
5009	2026-05-22 06:00:00	40	10.5
5017	2026-05-22 06:00:00	37	40.05
5026	2026-05-22 06:00:00	38	258.3
5034	2026-05-22 06:00:00	36	40
5042	2026-05-22 06:00:00	39	10.5
5060	2026-05-22 07:00:00	43	258.3
5066	2026-05-22 07:00:00	44	10.5
5075	2026-05-22 07:00:00	45	10.5
5084	2026-05-22 07:00:00	41	40
5094	2026-05-22 07:00:00	42	40.04
5110	2026-05-22 08:00:00	28	261.6
5123	2026-05-22 08:00:00	27	38.94
5133	2026-05-22 08:00:00	29	16
5144	2026-05-22 08:00:00	26	40
5150	2026-05-22 08:00:00	30	16
5151	2026-05-22 09:00:00	4	15
5161	2026-05-22 09:00:00	1	12
5175	2026-05-22 09:00:00	3	168.6
5189	2026-05-22 09:00:00	2	24.74
5198	2026-05-22 09:00:00	5	15
5208	2026-05-22 10:00:00	18	275.25
5216	2026-05-22 10:00:00	20	38.75
5225	2026-05-22 10:00:00	16	40
5232	2026-05-22 10:00:00	17	34.98
5241	2026-05-22 10:00:00	19	38.75
5258	2026-05-22 11:00:00	31	40
5262	2026-05-22 11:00:00	33	261.75
5272	2026-05-22 11:00:00	34	16.25
5277	2026-05-22 11:00:00	35	16.25
5286	2026-05-22 11:00:00	32	39.03
5308	2026-05-22 12:00:00	38	429.9
5319	2026-05-22 12:00:00	36	92
5334	2026-05-22 12:00:00	39	10.5
5344	2026-05-22 12:00:00	40	10.5
5350	2026-05-22 12:00:00	37	67.3
5351	2026-05-22 13:00:00	4	15
5365	2026-05-22 13:00:00	1	12
5377	2026-05-22 13:00:00	3	168.6
5389	2026-05-22 13:00:00	2	24.97
5394	2026-05-22 13:00:00	5	15
5408	2026-05-22 14:00:00	33	261
5416	2026-05-22 14:00:00	34	15
5427	2026-05-22 14:00:00	35	15
5433	2026-05-22 14:00:00	32	39.15
5441	2026-05-22 14:00:00	31	40
5460	2026-05-22 15:00:00	46	40
5473	2026-05-22 15:00:00	48	273.75
5483	2026-05-22 15:00:00	49	36.25
5494	2026-05-22 15:00:00	47	35.36
5499	2026-05-22 15:00:00	50	36.25
5510	2026-05-22 16:00:00	33	261.75
5524	2026-05-22 16:00:00	34	16.25
5537	2026-05-22 16:00:00	35	16.25
5544	2026-05-22 16:00:00	32	39.02
5550	2026-05-22 16:00:00	31	40
5551	2026-05-22 17:00:00	3	168.6
5561	2026-05-22 17:00:00	2	24.99
5574	2026-05-22 17:00:00	5	15
5587	2026-05-22 17:00:00	4	15
5595	2026-05-22 17:00:00	1	12
5610	2026-05-22 18:00:00	29	16.25
5621	2026-05-22 18:00:00	26	40
5630	2026-05-22 18:00:00	30	16.25
5639	2026-05-22 18:00:00	28	261.75
5648	2026-05-22 18:00:00	27	38.93
5653	2026-05-22 19:00:00	13	258
5665	2026-05-22 19:00:00	12	55.18
5675	2026-05-22 19:00:00	11	40
5682	2026-05-22 19:00:00	15	10
5694	2026-05-22 19:00:00	14	10
5710	2026-05-22 20:00:00	28	261.75
5723	2026-05-22 20:00:00	27	39.01
5734	2026-05-22 20:00:00	29	16.25
5745	2026-05-22 20:00:00	26	40
5750	2026-05-22 20:00:00	30	16.25
5751	2026-05-22 21:00:00	1	12
5766	2026-05-22 21:00:00	3	168.6
5774	2026-05-22 21:00:00	2	25
5787	2026-05-22 21:00:00	5	15
5796	2026-05-22 21:00:00	4	15
5804	2026-05-22 22:00:00	19	38.5
5813	2026-05-22 22:00:00	18	275.1
5824	2026-05-22 22:00:00	20	38.5
5835	2026-05-22 22:00:00	16	40
5843	2026-05-22 22:00:00	17	34.95
5857	2026-05-22 23:00:00	39	10.75
5864	2026-05-22 23:00:00	40	10.75
5871	2026-05-22 23:00:00	37	39.9
5881	2026-05-22 23:00:00	38	258.45
5891	2026-05-22 23:00:00	36	40
5909	2026-05-23 00:00:00	46	40
5917	2026-05-23 00:00:00	48	259.2
5931	2026-05-23 00:00:00	49	12
5942	2026-05-23 00:00:00	47	39.85
5947	2026-05-23 00:00:00	50	12
5954	2026-05-23 01:00:00	15	10
5960	2026-05-23 01:00:00	14	10
5970	2026-05-23 01:00:00	13	258
5976	2026-05-23 01:00:00	12	55.13
5984	2026-05-23 01:00:00	11	40
6010	2026-05-23 02:00:00	49	12.5
6024	2026-05-23 02:00:00	47	39.51
6030	2026-05-23 02:00:00	50	12.5
6037	2026-05-23 02:00:00	46	40
6046	2026-05-23 02:00:00	48	259.5
6056	2026-05-23 03:00:00	22	40.19
6068	2026-05-23 03:00:00	21	40
6081	2026-05-23 03:00:00	24	10
6091	2026-05-23 03:00:00	23	258
6100	2026-05-23 03:00:00	25	10
6101	2026-05-23 04:00:00	3	168.6
6111	2026-05-23 04:00:00	2	24.84
6122	2026-05-23 04:00:00	5	15
6128	2026-05-23 04:00:00	4	15
6139	2026-05-23 04:00:00	1	12
6160	2026-05-23 05:00:00	36	40
6170	2026-05-23 05:00:00	39	10.5
4826	2026-05-22 02:00:00	4	15
4836	2026-05-22 02:00:00	1	12
4854	2026-05-22 03:00:00	28	261.75
4862	2026-05-22 03:00:00	27	38.96
4870	2026-05-22 03:00:00	29	16.25
4878	2026-05-22 03:00:00	26	40
4886	2026-05-22 03:00:00	30	16.25
4909	2026-05-22 04:00:00	50	12
4916	2026-05-22 04:00:00	46	40
4923	2026-05-22 04:00:00	48	259.2
4934	2026-05-22 04:00:00	49	12
4943	2026-05-22 04:00:00	47	39.68
4959	2026-05-22 05:00:00	32	38.88
4966	2026-05-22 05:00:00	31	40
4972	2026-05-22 05:00:00	33	261.75
4980	2026-05-22 05:00:00	34	16.25
4987	2026-05-22 05:00:00	35	16.25
5004	2026-05-22 06:00:00	42	40.05
5011	2026-05-22 06:00:00	43	258.3
5019	2026-05-22 06:00:00	44	10.5
5028	2026-05-22 06:00:00	45	10.5
5037	2026-05-22 06:00:00	41	40
5057	2026-05-22 07:00:00	46	40
5062	2026-05-22 07:00:00	48	259.35
5072	2026-05-22 07:00:00	49	12.25
5083	2026-05-22 07:00:00	47	39.81
5092	2026-05-22 07:00:00	50	12.25
5108	2026-05-22 08:00:00	39	10.25
5113	2026-05-22 08:00:00	40	10.25
5122	2026-05-22 08:00:00	37	40.02
5132	2026-05-22 08:00:00	38	258.15
5143	2026-05-22 08:00:00	36	40
5156	2026-05-22 09:00:00	36	40
5169	2026-05-22 09:00:00	39	10.25
5184	2026-05-22 09:00:00	40	10.25
5194	2026-05-22 09:00:00	37	40.11
5200	2026-05-22 09:00:00	38	258.15
5201	2026-05-22 10:00:00	2	24.72
5211	2026-05-22 10:00:00	5	15
5227	2026-05-22 10:00:00	4	15
5240	2026-05-22 10:00:00	1	12
5247	2026-05-22 10:00:00	3	168.6
5253	2026-05-22 11:00:00	19	38.5
5265	2026-05-22 11:00:00	18	275.1
5274	2026-05-22 11:00:00	20	38.5
5282	2026-05-22 11:00:00	16	40
5290	2026-05-22 11:00:00	17	35.07
5309	2026-05-22 12:00:00	33	433.35
5314	2026-05-22 12:00:00	34	16.25
5324	2026-05-22 12:00:00	35	16.25
5333	2026-05-22 12:00:00	32	65.43
5338	2026-05-22 12:00:00	31	92
5359	2026-05-22 13:00:00	44	35.25
5370	2026-05-22 13:00:00	45	35.25
5383	2026-05-22 13:00:00	41	40
5391	2026-05-22 13:00:00	42	35.67
5395	2026-05-22 13:00:00	43	273.15
5405	2026-05-22 14:00:00	28	261.6
5417	2026-05-22 14:00:00	27	39.08
5428	2026-05-22 14:00:00	29	16
5440	2026-05-22 14:00:00	26	40
5449	2026-05-22 14:00:00	30	16
5452	2026-05-22 15:00:00	10	15
5462	2026-05-22 15:00:00	9	15
5475	2026-05-22 15:00:00	8	168.6
5488	2026-05-22 15:00:00	6	12
5493	2026-05-22 15:00:00	7	24.76
6103	2026-05-23 04:00:00	12	55.17
6113	2026-05-23 04:00:00	11	40
6121	2026-05-23 04:00:00	15	10
6129	2026-05-23 04:00:00	14	10
6141	2026-05-23 04:00:00	13	258
6158	2026-05-23 05:00:00	49	12.25
6166	2026-05-23 05:00:00	47	39.59
6180	2026-05-23 05:00:00	50	12.25
6193	2026-05-23 05:00:00	46	40
6200	2026-05-23 05:00:00	48	259.35
6201	2026-05-23 06:00:00	7	24.83
6215	2026-05-23 06:00:00	10	15
6227	2026-05-23 06:00:00	9	15
6239	2026-05-23 06:00:00	8	168.6
6247	2026-05-23 06:00:00	6	12
6253	2026-05-23 07:00:00	20	38.5
6262	2026-05-23 07:00:00	16	40
6271	2026-05-23 07:00:00	17	35.07
6279	2026-05-23 07:00:00	19	38.5
6290	2026-05-23 07:00:00	18	275.1
6303	2026-05-23 08:00:00	26	40
6320	2026-05-23 08:00:00	30	16.25
6334	2026-05-23 08:00:00	28	261.75
6344	2026-05-23 08:00:00	27	38.89
6350	2026-05-23 08:00:00	29	16.25
6351	2026-05-23 09:00:00	4	15
6365	2026-05-23 09:00:00	1	12
6375	2026-05-23 09:00:00	3	168.6
6387	2026-05-23 09:00:00	2	24.99
6397	2026-05-23 09:00:00	5	15
6403	2026-05-23 10:00:00	14	10
6417	2026-05-23 10:00:00	13	258
6427	2026-05-23 10:00:00	12	55.16
6439	2026-05-23 10:00:00	11	40
6447	2026-05-23 10:00:00	19	38.75
6448	2026-05-23 10:00:00	15	10
6451	2026-05-23 11:00:00	2	24.99
6454	2026-05-23 11:00:00	19	39
6461	2026-05-23 11:00:00	5	15
6462	2026-05-23 11:00:00	18	275.4
6471	2026-05-23 11:00:00	4	15
6475	2026-05-23 11:00:00	20	39
6484	2026-05-23 11:00:00	1	12
6487	2026-05-23 11:00:00	16	40
6493	2026-05-23 11:00:00	3	168.6
6494	2026-05-23 11:00:00	17	34.87
6506	2026-05-23 12:00:00	48	430.95
6505	2026-05-23 12:00:00	44	10.5
6511	2026-05-23 12:00:00	49	12.25
6515	2026-05-23 12:00:00	45	10.5
6522	2026-05-23 12:00:00	47	66.67
6527	2026-05-23 12:00:00	41	92
6533	2026-05-23 12:00:00	42	67.23
6538	2026-05-23 12:00:00	50	12.25
6545	2026-05-23 12:00:00	43	429.9
6547	2026-05-23 12:00:00	46	92
6553	2026-05-23 13:00:00	13	258
6556	2026-05-23 13:00:00	24	33.75
6565	2026-05-23 13:00:00	12	55.08
6568	2026-05-23 13:00:00	23	272.25
6575	2026-05-23 13:00:00	11	40
6579	2026-05-23 13:00:00	25	33.75
6580	2026-05-23 13:00:00	7	24.74
6587	2026-05-23 13:00:00	10	15
6588	2026-05-23 13:00:00	15	10
6590	2026-05-23 13:00:00	22	36.01
6597	2026-05-23 13:00:00	9	15
6598	2026-05-23 13:00:00	14	10
6599	2026-05-23 13:00:00	21	40
4827	2026-05-22 02:00:00	45	10.5
4837	2026-05-22 02:00:00	41	40
4846	2026-05-22 02:00:00	42	40.15
4855	2026-05-22 03:00:00	21	40
4867	2026-05-22 03:00:00	24	10
4877	2026-05-22 03:00:00	23	258
4890	2026-05-22 03:00:00	25	10
4898	2026-05-22 03:00:00	22	40.07
4903	2026-05-22 04:00:00	13	258
4911	2026-05-22 04:00:00	12	54.95
4920	2026-05-22 04:00:00	11	40
4925	2026-05-22 04:00:00	15	10
4935	2026-05-22 04:00:00	14	10
4958	2026-05-22 05:00:00	50	12.25
4970	2026-05-22 05:00:00	46	40
4975	2026-05-22 05:00:00	48	259.35
4985	2026-05-22 05:00:00	49	12.25
4990	2026-05-22 05:00:00	47	39.65
5006	2026-05-22 06:00:00	33	261.75
5018	2026-05-22 06:00:00	34	16.25
5032	2026-05-22 06:00:00	35	16.25
5043	2026-05-22 06:00:00	32	38.97
5050	2026-05-22 06:00:00	31	40
5052	2026-05-22 07:00:00	9	15
5069	2026-05-22 07:00:00	8	168.6
5079	2026-05-22 07:00:00	6	12
5091	2026-05-22 07:00:00	7	24.99
5099	2026-05-22 07:00:00	10	15
5103	2026-05-22 08:00:00	6	12
5111	2026-05-22 08:00:00	7	24.89
5120	2026-05-22 08:00:00	10	15
5124	2026-05-22 08:00:00	9	15
5137	2026-05-22 08:00:00	8	168.6
5158	2026-05-22 09:00:00	49	12.5
5162	2026-05-22 09:00:00	47	39.75
5171	2026-05-22 09:00:00	50	12.5
5176	2026-05-22 09:00:00	46	40
5185	2026-05-22 09:00:00	48	259.5
5210	2026-05-22 10:00:00	49	12.5
5220	2026-05-22 10:00:00	47	39.71
5236	2026-05-22 10:00:00	50	12.5
5246	2026-05-22 10:00:00	46	40
5250	2026-05-22 10:00:00	48	259.5
5251	2026-05-22 11:00:00	5	15
5267	2026-05-22 11:00:00	4	15
5281	2026-05-22 11:00:00	1	12
5292	2026-05-22 11:00:00	3	168.6
5298	2026-05-22 11:00:00	2	24.86
5303	2026-05-22 12:00:00	11	92
5313	2026-05-22 12:00:00	15	10
5323	2026-05-22 12:00:00	14	10
5332	2026-05-22 12:00:00	13	429.6
5342	2026-05-22 12:00:00	12	82.41
5355	2026-05-22 13:00:00	28	261.6
5361	2026-05-22 13:00:00	27	39.07
5369	2026-05-22 13:00:00	29	16
5375	2026-05-22 13:00:00	26	40
5382	2026-05-22 13:00:00	30	16
5410	2026-05-22 14:00:00	50	35
5420	2026-05-22 14:00:00	46	40
5431	2026-05-22 14:00:00	48	273
5443	2026-05-22 14:00:00	49	35
5450	2026-05-22 14:00:00	47	35.74
5451	2026-05-22 15:00:00	2	24.76
5459	2026-05-22 15:00:00	5	15
5474	2026-05-22 15:00:00	4	15
5487	2026-05-22 15:00:00	1	12
5495	2026-05-22 15:00:00	3	168.6
6112	2026-05-23 04:00:00	9	15
6120	2026-05-23 04:00:00	8	168.6
6132	2026-05-23 04:00:00	6	12
6144	2026-05-23 04:00:00	7	24.88
6155	2026-05-23 05:00:00	28	261.75
6162	2026-05-23 05:00:00	27	39
6173	2026-05-23 05:00:00	29	16.25
6179	2026-05-23 05:00:00	26	40
6194	2026-05-23 05:00:00	30	16.25
6208	2026-05-23 06:00:00	33	261.75
6213	2026-05-23 06:00:00	34	16.25
6223	2026-05-23 06:00:00	35	16.25
6226	2026-05-23 06:00:00	32	38.89
6237	2026-05-23 06:00:00	31	40
6256	2026-05-23 07:00:00	46	40
6261	2026-05-23 07:00:00	48	259.35
6270	2026-05-23 07:00:00	49	12.25
6276	2026-05-23 07:00:00	47	39.66
6284	2026-05-23 07:00:00	50	12.25
6308	2026-05-23 08:00:00	46	40
6315	2026-05-23 08:00:00	48	259.2
6323	2026-05-23 08:00:00	49	12
6331	2026-05-23 08:00:00	47	39.62
6337	2026-05-23 08:00:00	50	12
6360	2026-05-23 09:00:00	43	258.3
6370	2026-05-23 09:00:00	44	10.5
6380	2026-05-23 09:00:00	45	10.5
6392	2026-05-23 09:00:00	41	40
6400	2026-05-23 09:00:00	42	40.03
6401	2026-05-23 10:00:00	2	24.94
6411	2026-05-23 10:00:00	5	15
6426	2026-05-23 10:00:00	4	15
6433	2026-05-23 10:00:00	1	12
6437	2026-05-23 10:00:00	3	168.6
6457	2026-05-23 11:00:00	44	10.75
6458	2026-05-23 11:00:00	48	259.5
6464	2026-05-23 11:00:00	45	10.75
6466	2026-05-23 11:00:00	49	12.5
6476	2026-05-23 11:00:00	41	40
6480	2026-05-23 11:00:00	47	39.78
6489	2026-05-23 11:00:00	42	39.95
6491	2026-05-23 11:00:00	50	12.5
6495	2026-05-23 11:00:00	46	40
6497	2026-05-23 11:00:00	43	258.45
6507	2026-05-23 12:00:00	19	39
6519	2026-05-23 12:00:00	18	447
6534	2026-05-23 12:00:00	20	39
6546	2026-05-23 12:00:00	16	92
6550	2026-05-23 12:00:00	17	58.44
6551	2026-05-23 13:00:00	4	15
6561	2026-05-23 13:00:00	1	12
6574	2026-05-23 13:00:00	3	168.6
6583	2026-05-23 13:00:00	30	40
6584	2026-05-23 13:00:00	2	24.91
6593	2026-05-23 13:00:00	28	276
6594	2026-05-23 13:00:00	5	15
6605	2026-05-23 14:00:00	17	34.93
6609	2026-05-23 14:00:00	42	39.81
6618	2026-05-23 14:00:00	43	258.45
6621	2026-05-23 14:00:00	19	38.75
6626	2026-05-23 14:00:00	44	10.75
6634	2026-05-23 14:00:00	18	275.25
6636	2026-05-23 14:00:00	45	10.75
6644	2026-05-23 14:00:00	41	40
6645	2026-05-23 14:00:00	20	38.75
6650	2026-05-23 14:00:00	16	40
6651	2026-05-23 15:00:00	2	24.79
6655	2026-05-23 15:00:00	26	40
4829	2026-05-22 02:00:00	8	168.6
4838	2026-05-22 02:00:00	6	12
4847	2026-05-22 02:00:00	7	24.88
4853	2026-05-22 03:00:00	16	40
4874	2026-05-22 03:00:00	17	35.14
4885	2026-05-22 03:00:00	19	38.75
4897	2026-05-22 03:00:00	18	275.25
4900	2026-05-22 03:00:00	20	38.75
4901	2026-05-22 04:00:00	1	12
4917	2026-05-22 04:00:00	3	168.6
4929	2026-05-22 04:00:00	2	24.84
4941	2026-05-22 04:00:00	5	15
4949	2026-05-22 04:00:00	4	15
4951	2026-05-22 05:00:00	1	12
4963	2026-05-22 05:00:00	3	168.6
4977	2026-05-22 05:00:00	2	24.85
4992	2026-05-22 05:00:00	5	15
4997	2026-05-22 05:00:00	4	15
5005	2026-05-22 06:00:00	20	38.75
5015	2026-05-22 06:00:00	16	40
5024	2026-05-22 06:00:00	17	35.03
5031	2026-05-22 06:00:00	19	38.75
5040	2026-05-22 06:00:00	18	275.25
5054	2026-05-22 07:00:00	26	40
5070	2026-05-22 07:00:00	30	16.25
5082	2026-05-22 07:00:00	28	261.75
5093	2026-05-22 07:00:00	27	38.85
5098	2026-05-22 07:00:00	29	16.25
5102	2026-05-22 08:00:00	13	258
5115	2026-05-22 08:00:00	12	55.12
5127	2026-05-22 08:00:00	11	40
5138	2026-05-22 08:00:00	15	10
5148	2026-05-22 08:00:00	14	10
5153	2026-05-22 09:00:00	6	12
5165	2026-05-22 09:00:00	7	24.88
5174	2026-05-22 09:00:00	10	15
5182	2026-05-22 09:00:00	9	15
5191	2026-05-22 09:00:00	8	168.6
5206	2026-05-22 10:00:00	32	38.92
5214	2026-05-22 10:00:00	31	40
5223	2026-05-22 10:00:00	33	261.75
5230	2026-05-22 10:00:00	34	16.25
5239	2026-05-22 10:00:00	35	16.25
5257	2026-05-22 11:00:00	40	10.5
5270	2026-05-22 11:00:00	37	40.14
5284	2026-05-22 11:00:00	38	258.3
5294	2026-05-22 11:00:00	36	40
5300	2026-05-22 11:00:00	39	10.5
5301	2026-05-22 12:00:00	1	12
5316	2026-05-22 12:00:00	3	168.6
5330	2026-05-22 12:00:00	2	24.75
5340	2026-05-22 12:00:00	5	15
5347	2026-05-22 12:00:00	4	15
5353	2026-05-22 13:00:00	16	40
5362	2026-05-22 13:00:00	17	35.04
5373	2026-05-22 13:00:00	19	38.5
5379	2026-05-22 13:00:00	18	275.1
5386	2026-05-22 13:00:00	20	38.5
5409	2026-05-22 14:00:00	40	10.5
5412	2026-05-22 14:00:00	37	40.11
5425	2026-05-22 14:00:00	38	258.3
5436	2026-05-22 14:00:00	36	40
5447	2026-05-22 14:00:00	39	10.5
5453	2026-05-22 15:00:00	11	40
5465	2026-05-22 15:00:00	15	10
5471	2026-05-22 15:00:00	14	10
5479	2026-05-22 15:00:00	13	258
5486	2026-05-22 15:00:00	12	55.01
6174	2026-05-23 05:00:00	13	258
6185	2026-05-23 05:00:00	12	55.08
6209	2026-05-23 06:00:00	50	12.25
6217	2026-05-23 06:00:00	46	40
6241	2026-05-23 06:00:00	48	259.35
6248	2026-05-23 06:00:00	49	12.25
6250	2026-05-23 06:00:00	47	39.67
6251	2026-05-23 07:00:00	5	15
6266	2026-05-23 07:00:00	4	15
6277	2026-05-23 07:00:00	1	12
6287	2026-05-23 07:00:00	3	168.6
6297	2026-05-23 07:00:00	2	24.88
6306	2026-05-23 08:00:00	20	38.75
6317	2026-05-23 08:00:00	16	40
6325	2026-05-23 08:00:00	17	35.06
6336	2026-05-23 08:00:00	19	38.75
6345	2026-05-23 08:00:00	18	275.25
6355	2026-05-23 09:00:00	30	16.25
6368	2026-05-23 09:00:00	28	261.75
6379	2026-05-23 09:00:00	27	39.05
6389	2026-05-23 09:00:00	29	16.25
6399	2026-05-23 09:00:00	26	40
6402	2026-05-23 10:00:00	6	12
6418	2026-05-23 10:00:00	7	25
6432	2026-05-23 10:00:00	10	15
6444	2026-05-23 10:00:00	9	15
6450	2026-05-23 10:00:00	8	168.6
6452	2026-05-23 11:00:00	9	15
6459	2026-05-23 11:00:00	39	10.5
6463	2026-05-23 11:00:00	8	168.6
6468	2026-05-23 11:00:00	40	10.5
6474	2026-05-23 11:00:00	37	39.99
6477	2026-05-23 11:00:00	6	12
6486	2026-05-23 11:00:00	38	258.3
6488	2026-05-23 11:00:00	7	24.76
6496	2026-05-23 11:00:00	36	40
6498	2026-05-23 11:00:00	10	15
6508	2026-05-23 12:00:00	32	65.58
6518	2026-05-23 12:00:00	31	92
6525	2026-05-23 12:00:00	33	433.2
6531	2026-05-23 12:00:00	34	16
6541	2026-05-23 12:00:00	35	16
6557	2026-05-23 13:00:00	31	40
6563	2026-05-23 13:00:00	33	261.6
6573	2026-05-23 13:00:00	34	16
6582	2026-05-23 13:00:00	35	16
6589	2026-05-23 13:00:00	32	39.18
6603	2026-05-23 14:00:00	25	33.75
6610	2026-05-23 14:00:00	48	273
6616	2026-05-23 14:00:00	49	35
6620	2026-05-23 14:00:00	22	35.81
6631	2026-05-23 14:00:00	21	40
6632	2026-05-23 14:00:00	47	35.74
6641	2026-05-23 14:00:00	50	35
6642	2026-05-23 14:00:00	24	33.75
6647	2026-05-23 14:00:00	46	40
6649	2026-05-23 14:00:00	23	272.25
6653	2026-05-23 15:00:00	10	15
6657	2026-05-23 15:00:00	50	11.25
6656	2026-05-23 15:00:00	42	39.81
6652	2026-05-23 15:00:00	20	39
6658	2026-05-23 15:00:00	24	10
6659	2026-05-23 15:00:00	35	15
6660	2026-05-23 15:00:00	36	40
6661	2026-05-23 15:00:00	46	40
6662	2026-05-23 15:00:00	30	15
6663	2026-05-23 15:00:00	15	10
6664	2026-05-23 15:00:00	43	258.45
4830	2026-05-22 02:00:00	16	40
4840	2026-05-22 02:00:00	17	35.09
4848	2026-05-22 02:00:00	19	38.75
4852	2026-05-22 03:00:00	13	258
4863	2026-05-22 03:00:00	12	54.96
4871	2026-05-22 03:00:00	11	40
4880	2026-05-22 03:00:00	15	10
4894	2026-05-22 03:00:00	14	10
4907	2026-05-22 04:00:00	32	39.07
4924	2026-05-22 04:00:00	31	40
4932	2026-05-22 04:00:00	33	261.75
4937	2026-05-22 04:00:00	34	16.25
4945	2026-05-22 04:00:00	35	16.25
4956	2026-05-22 05:00:00	28	261.6
4962	2026-05-22 05:00:00	27	39.09
4974	2026-05-22 05:00:00	29	16
4982	2026-05-22 05:00:00	26	40
4991	2026-05-22 05:00:00	30	16
5002	2026-05-22 06:00:00	29	16.25
5013	2026-05-22 06:00:00	26	40
5022	2026-05-22 06:00:00	30	16.25
5029	2026-05-22 06:00:00	28	261.75
5039	2026-05-22 06:00:00	27	39.08
5058	2026-05-22 07:00:00	37	40.12
5064	2026-05-22 07:00:00	38	258.3
5071	2026-05-22 07:00:00	36	40
5086	2026-05-22 07:00:00	39	10.5
5097	2026-05-22 07:00:00	40	10.5
5109	2026-05-22 08:00:00	20	38.5
5116	2026-05-22 08:00:00	16	40
5125	2026-05-22 08:00:00	17	35.09
5134	2026-05-22 08:00:00	19	38.5
5145	2026-05-22 08:00:00	18	275.1
5155	2026-05-22 09:00:00	26	40
5168	2026-05-22 09:00:00	30	16
5180	2026-05-22 09:00:00	28	261.6
5187	2026-05-22 09:00:00	27	38.9
5197	2026-05-22 09:00:00	29	16
5204	2026-05-22 10:00:00	14	10
5213	2026-05-22 10:00:00	13	258
5222	2026-05-22 10:00:00	12	55.05
5229	2026-05-22 10:00:00	11	40
5238	2026-05-22 10:00:00	15	10
5260	2026-05-22 11:00:00	44	10.5
5263	2026-05-22 11:00:00	45	10.5
5273	2026-05-22 11:00:00	41	40
5278	2026-05-22 11:00:00	42	40.04
5287	2026-05-22 11:00:00	43	258.3
5307	2026-05-22 12:00:00	42	67.09
5320	2026-05-22 12:00:00	43	429.9
5335	2026-05-22 12:00:00	44	10.5
5345	2026-05-22 12:00:00	45	10.5
5348	2026-05-22 12:00:00	41	92
5352	2026-05-22 13:00:00	7	24.98
5366	2026-05-22 13:00:00	10	15
5376	2026-05-22 13:00:00	9	15
5388	2026-05-22 13:00:00	8	168.6
5397	2026-05-22 13:00:00	6	12
5404	2026-05-22 14:00:00	23	258
5418	2026-05-22 14:00:00	25	10
5423	2026-05-22 14:00:00	22	40.15
5435	2026-05-22 14:00:00	21	40
5445	2026-05-22 14:00:00	24	10
5456	2026-05-22 15:00:00	27	39.04
5466	2026-05-22 15:00:00	29	16
5472	2026-05-22 15:00:00	26	40
5480	2026-05-22 15:00:00	30	16
5489	2026-05-22 15:00:00	28	261.6
6175	2026-05-23 05:00:00	40	10.5
6184	2026-05-23 05:00:00	37	39.88
6189	2026-05-23 05:00:00	38	258.3
6207	2026-05-23 06:00:00	42	40
6216	2026-05-23 06:00:00	43	258.3
6225	2026-05-23 06:00:00	44	10.5
6238	2026-05-23 06:00:00	45	10.5
6243	2026-05-23 06:00:00	41	40
6260	2026-05-23 07:00:00	26	40
6275	2026-05-23 07:00:00	30	16.25
6286	2026-05-23 07:00:00	28	261.75
6295	2026-05-23 07:00:00	27	39
6300	2026-05-23 07:00:00	29	16.25
6301	2026-05-23 08:00:00	5	15
6311	2026-05-23 08:00:00	4	15
6327	2026-05-23 08:00:00	1	12
6341	2026-05-23 08:00:00	3	168.6
6349	2026-05-23 08:00:00	2	24.76
6353	2026-05-23 09:00:00	10	15
6363	2026-05-23 09:00:00	9	15
6374	2026-05-23 09:00:00	8	168.6
6383	2026-05-23 09:00:00	6	12
6391	2026-05-23 09:00:00	7	24.78
6404	2026-05-23 10:00:00	40	10.5
6412	2026-05-23 10:00:00	37	40.12
6421	2026-05-23 10:00:00	38	258.3
6429	2026-05-23 10:00:00	36	40
6442	2026-05-23 10:00:00	39	10.5
6455	2026-05-23 11:00:00	32	38.98
6465	2026-05-23 11:00:00	31	40
6478	2026-05-23 11:00:00	33	261.6
6482	2026-05-23 11:00:00	34	16
6490	2026-05-23 11:00:00	35	16
6501	2026-05-23 12:00:00	2	24.81
6509	2026-05-23 12:00:00	39	10.5
6513	2026-05-23 12:00:00	5	15
6517	2026-05-23 12:00:00	40	10.5
6520	2026-05-23 12:00:00	4	15
6524	2026-05-23 12:00:00	37	67.26
6529	2026-05-23 12:00:00	1	12
6530	2026-05-23 12:00:00	38	429.9
6535	2026-05-23 12:00:00	3	168.6
6540	2026-05-23 12:00:00	36	92
6559	2026-05-23 13:00:00	45	35.25
6560	2026-05-23 13:00:00	47	35.49
6569	2026-05-23 13:00:00	41	40
6570	2026-05-23 13:00:00	50	36.25
6576	2026-05-23 13:00:00	46	40
6578	2026-05-23 13:00:00	42	35.6
6586	2026-05-23 13:00:00	48	273.75
6591	2026-05-23 13:00:00	43	273.15
6595	2026-05-23 13:00:00	49	36.25
6600	2026-05-23 13:00:00	44	35.25
6601	2026-05-23 14:00:00	2	24.73
6602	2026-05-23 14:00:00	10	15
6607	2026-05-23 14:00:00	35	16
6611	2026-05-23 14:00:00	5	15
6614	2026-05-23 14:00:00	9	15
6617	2026-05-23 14:00:00	4	15
6619	2026-05-23 14:00:00	32	39.02
6623	2026-05-23 14:00:00	8	168.6
6625	2026-05-23 14:00:00	1	12
6627	2026-05-23 14:00:00	31	40
6630	2026-05-23 14:00:00	6	12
6637	2026-05-23 14:00:00	3	168.6
6638	2026-05-23 14:00:00	33	261.6
6640	2026-05-23 14:00:00	7	24.76
6643	2026-05-23 14:00:00	34	16
4834	2026-05-22 02:00:00	37	39.91
4844	2026-05-22 02:00:00	38	258.3
4849	2026-05-22 02:00:00	36	40
4858	2026-05-22 03:00:00	8	168.6
4865	2026-05-22 03:00:00	6	12
4876	2026-05-22 03:00:00	7	24.95
4888	2026-05-22 03:00:00	10	15
4892	2026-05-22 03:00:00	9	15
4904	2026-05-22 04:00:00	18	275.1
4919	2026-05-22 04:00:00	20	38.5
4926	2026-05-22 04:00:00	16	40
4939	2026-05-22 04:00:00	17	35.16
4946	2026-05-22 04:00:00	19	38.5
4952	2026-05-22 05:00:00	18	275.1
4964	2026-05-22 05:00:00	20	38.5
4978	2026-05-22 05:00:00	16	40
4993	2026-05-22 05:00:00	17	35.03
5000	2026-05-22 05:00:00	19	38.5
5001	2026-05-22 06:00:00	2	24.91
5012	2026-05-22 06:00:00	5	15
5027	2026-05-22 06:00:00	4	15
5038	2026-05-22 06:00:00	1	12
5047	2026-05-22 06:00:00	3	168.6
5053	2026-05-22 07:00:00	11	40
5065	2026-05-22 07:00:00	15	10
5074	2026-05-22 07:00:00	14	10
5081	2026-05-22 07:00:00	13	258
5088	2026-05-22 07:00:00	12	55.01
5105	2026-05-22 08:00:00	45	10.5
5118	2026-05-22 08:00:00	41	40
5130	2026-05-22 08:00:00	42	39.96
5139	2026-05-22 08:00:00	43	258.3
5149	2026-05-22 08:00:00	44	10.5
5154	2026-05-22 09:00:00	18	275.1
5166	2026-05-22 09:00:00	20	38.5
5178	2026-05-22 09:00:00	16	40
5186	2026-05-22 09:00:00	17	35.23
5195	2026-05-22 09:00:00	19	38.5
5203	2026-05-22 10:00:00	26	40
5218	2026-05-22 10:00:00	30	16
5233	2026-05-22 10:00:00	28	261.6
5244	2026-05-22 10:00:00	27	39.13
5248	2026-05-22 10:00:00	29	16
5252	2026-05-22 11:00:00	7	24.78
5268	2026-05-22 11:00:00	10	15
5280	2026-05-22 11:00:00	9	15
5289	2026-05-22 11:00:00	8	168.6
5296	2026-05-22 11:00:00	6	12
5304	2026-05-22 12:00:00	23	429.6
5311	2026-05-22 12:00:00	25	10
5321	2026-05-22 12:00:00	22	67.43
5326	2026-05-22 12:00:00	21	92
5337	2026-05-22 12:00:00	24	10
5358	2026-05-22 13:00:00	40	35.25
5363	2026-05-22 13:00:00	37	35.58
5372	2026-05-22 13:00:00	38	273.15
5378	2026-05-22 13:00:00	36	40
5385	2026-05-22 13:00:00	39	35.25
5407	2026-05-22 14:00:00	44	10.25
5411	2026-05-22 14:00:00	45	10.25
5421	2026-05-22 14:00:00	41	40
5432	2026-05-22 14:00:00	42	40.15
5444	2026-05-22 14:00:00	43	258.15
5455	2026-05-22 15:00:00	34	16.25
5463	2026-05-22 15:00:00	35	16.25
5469	2026-05-22 15:00:00	32	39.01
5477	2026-05-22 15:00:00	31	40
5484	2026-05-22 15:00:00	33	261.75
6178	2026-05-23 05:00:00	34	16.25
6186	2026-05-23 05:00:00	35	16.25
6206	2026-05-23 06:00:00	37	39.91
6220	2026-05-23 06:00:00	38	258.3
6232	2026-05-23 06:00:00	36	40
6242	2026-05-23 06:00:00	39	10.5
6245	2026-05-23 06:00:00	40	10.5
6252	2026-05-23 07:00:00	13	258
6267	2026-05-23 07:00:00	12	55.18
6278	2026-05-23 07:00:00	11	40
6288	2026-05-23 07:00:00	15	10
6296	2026-05-23 07:00:00	14	10
6305	2026-05-23 08:00:00	23	258
6318	2026-05-23 08:00:00	25	10
6326	2026-05-23 08:00:00	22	39.99
6342	2026-05-23 08:00:00	21	40
6347	2026-05-23 08:00:00	24	10
6356	2026-05-23 09:00:00	25	10
6362	2026-05-23 09:00:00	22	39.94
6372	2026-05-23 09:00:00	21	40
6382	2026-05-23 09:00:00	24	10
6395	2026-05-23 09:00:00	23	258
6405	2026-05-23 10:00:00	24	10
6415	2026-05-23 10:00:00	23	258
6425	2026-05-23 10:00:00	25	10
6434	2026-05-23 10:00:00	22	40.19
6445	2026-05-23 10:00:00	21	40
6456	2026-05-23 11:00:00	28	261.75
6467	2026-05-23 11:00:00	27	39.01
6473	2026-05-23 11:00:00	29	16.25
6481	2026-05-23 11:00:00	26	40
6485	2026-05-23 11:00:00	30	16.25
6502	2026-05-23 12:00:00	15	10
6510	2026-05-23 12:00:00	28	433.35
6514	2026-05-23 12:00:00	14	10
6521	2026-05-23 12:00:00	13	429.6
6523	2026-05-23 12:00:00	27	65.49
6536	2026-05-23 12:00:00	29	16.25
6537	2026-05-23 12:00:00	12	82.31
6543	2026-05-23 12:00:00	11	92
6544	2026-05-23 12:00:00	26	92
6548	2026-05-23 12:00:00	30	16.25
6554	2026-05-23 13:00:00	18	275.4
6558	2026-05-23 13:00:00	40	35.25
6564	2026-05-23 13:00:00	37	35.64
6566	2026-05-23 13:00:00	20	39
6571	2026-05-23 13:00:00	38	273.15
6577	2026-05-23 13:00:00	16	40
6581	2026-05-23 13:00:00	36	40
6585	2026-05-23 13:00:00	17	34.98
6592	2026-05-23 13:00:00	39	35.25
6596	2026-05-23 13:00:00	19	39
6604	2026-05-23 14:00:00	15	10
6606	2026-05-23 14:00:00	30	15
6608	2026-05-23 14:00:00	36	40
6612	2026-05-23 14:00:00	28	261
6613	2026-05-23 14:00:00	39	10.25
6615	2026-05-23 14:00:00	14	10
6622	2026-05-23 14:00:00	40	10.25
6624	2026-05-23 14:00:00	13	258
6628	2026-05-23 14:00:00	27	39.26
6629	2026-05-23 14:00:00	37	40.05
6633	2026-05-23 14:00:00	12	55.15
6635	2026-05-23 14:00:00	38	258.15
6639	2026-05-23 14:00:00	29	15
6646	2026-05-23 14:00:00	11	40
6648	2026-05-23 14:00:00	26	40
6654	2026-05-23 15:00:00	11	40
6665	2026-05-23 15:00:00	5	15
6682	2026-05-23 15:00:00	4	15
6692	2026-05-23 15:00:00	1	12
6699	2026-05-23 15:00:00	3	168.6
6703	2026-05-23 16:00:00	11	40
6717	2026-05-23 16:00:00	15	10
6728	2026-05-23 16:00:00	14	10
6741	2026-05-23 16:00:00	13	258
6749	2026-05-23 16:00:00	12	54.95
6755	2026-05-23 17:00:00	7	24.91
6765	2026-05-23 17:00:00	10	15
6774	2026-05-23 17:00:00	9	15
6781	2026-05-23 17:00:00	8	168.6
6791	2026-05-23 17:00:00	6	12
6810	2026-05-23 18:00:00	34	15
6820	2026-05-23 18:00:00	35	15
6832	2026-05-23 18:00:00	32	39.13
6842	2026-05-23 18:00:00	31	40
6849	2026-05-23 18:00:00	33	261
6852	2026-05-23 19:00:00	8	168.6
6869	2026-05-23 19:00:00	6	12
6882	2026-05-23 19:00:00	7	24.81
6891	2026-05-23 19:00:00	10	15
6897	2026-05-23 19:00:00	9	15
6903	2026-05-23 20:00:00	20	38.5
6912	2026-05-23 20:00:00	16	40
6921	2026-05-23 20:00:00	17	35.16
6928	2026-05-23 20:00:00	19	38.5
6937	2026-05-23 20:00:00	18	275.1
6958	2026-05-23 21:00:00	42	40.02
6967	2026-05-23 21:00:00	43	258.45
6976	2026-05-23 21:00:00	44	10.75
6987	2026-05-23 21:00:00	45	10.75
6998	2026-05-23 21:00:00	41	40
7005	2026-05-23 22:00:00	20	38.75
7015	2026-05-23 22:00:00	16	40
7023	2026-05-23 22:00:00	17	34.96
7033	2026-05-23 22:00:00	19	38.75
7044	2026-05-23 22:00:00	18	275.25
7055	2026-05-23 23:00:00	37	40.09
7066	2026-05-23 23:00:00	38	258.3
7075	2026-05-23 23:00:00	36	40
7087	2026-05-23 23:00:00	39	10.5
7095	2026-05-23 23:00:00	40	10.5
7106	2026-05-24 00:00:00	26	40
7118	2026-05-24 00:00:00	30	16
7132	2026-05-24 00:00:00	28	261.6
7143	2026-05-24 00:00:00	27	38.9
7149	2026-05-24 00:00:00	29	16
7152	2026-05-24 01:00:00	8	168.6
7161	2026-05-24 01:00:00	6	12
7173	2026-05-24 01:00:00	7	24.88
7185	2026-05-24 01:00:00	10	15
7195	2026-05-24 01:00:00	9	15
7205	2026-05-24 02:00:00	27	39.06
7222	2026-05-24 02:00:00	29	16.25
7231	2026-05-24 02:00:00	26	40
7237	2026-05-24 02:00:00	30	16.25
7244	2026-05-24 02:00:00	28	261.75
7256	2026-05-24 03:00:00	27	39.14
7268	2026-05-24 03:00:00	29	16.25
7278	2026-05-24 03:00:00	26	40
7290	2026-05-24 03:00:00	30	16.25
7297	2026-05-24 03:00:00	28	261.75
7304	2026-05-24 04:00:00	18	275.1
7312	2026-05-24 04:00:00	20	38.5
7322	2026-05-24 04:00:00	16	40
7324	2026-05-24 04:00:00	17	34.99
7334	2026-05-24 04:00:00	19	38.5
7359	2026-05-24 05:00:00	41	40
7367	2026-05-24 05:00:00	42	40.09
7378	2026-05-24 05:00:00	43	258.3
7384	2026-05-24 05:00:00	44	10.5
7394	2026-05-24 05:00:00	45	10.5
7407	2026-05-24 06:00:00	31	40
7416	2026-05-24 06:00:00	33	261.6
7424	2026-05-24 06:00:00	34	16
7435	2026-05-24 06:00:00	35	16
7444	2026-05-24 06:00:00	32	38.96
7456	2026-05-24 07:00:00	23	258
7464	2026-05-24 07:00:00	25	10
7473	2026-05-24 07:00:00	22	40.06
7484	2026-05-24 07:00:00	21	40
7495	2026-05-24 07:00:00	24	10
6666	2026-05-23 15:00:00	9	15
6683	2026-05-23 15:00:00	8	168.6
6693	2026-05-23 15:00:00	6	12
6700	2026-05-23 15:00:00	7	24.72
6701	2026-05-23 16:00:00	2	24.87
6714	2026-05-23 16:00:00	5	15
6733	2026-05-23 16:00:00	4	15
6745	2026-05-23 16:00:00	1	12
6748	2026-05-23 16:00:00	3	168.6
6753	2026-05-23 17:00:00	15	10
6768	2026-05-23 17:00:00	14	10
6785	2026-05-23 17:00:00	13	258
6796	2026-05-23 17:00:00	12	55.19
6800	2026-05-23 17:00:00	11	40
6802	2026-05-23 18:00:00	6	12
6817	2026-05-23 18:00:00	7	25.01
6829	2026-05-23 18:00:00	10	15
6837	2026-05-23 18:00:00	9	15
6846	2026-05-23 18:00:00	8	168.6
6855	2026-05-23 19:00:00	22	40.17
6867	2026-05-23 19:00:00	21	40
6881	2026-05-23 19:00:00	24	10
6890	2026-05-23 19:00:00	23	258
6896	2026-05-23 19:00:00	25	10
6910	2026-05-23 20:00:00	26	40
6922	2026-05-23 20:00:00	30	16.25
6939	2026-05-23 20:00:00	28	261.75
6947	2026-05-23 20:00:00	27	38.98
6949	2026-05-23 20:00:00	29	16.25
6952	2026-05-23 21:00:00	6	12
6966	2026-05-23 21:00:00	7	25
6975	2026-05-23 21:00:00	10	15
6985	2026-05-23 21:00:00	9	15
6996	2026-05-23 21:00:00	8	168.6
7004	2026-05-23 22:00:00	23	258
7012	2026-05-23 22:00:00	25	10
7026	2026-05-23 22:00:00	22	40.08
7036	2026-05-23 22:00:00	21	40
7047	2026-05-23 22:00:00	24	10
7052	2026-05-23 23:00:00	16	40
7064	2026-05-23 23:00:00	17	35.09
7073	2026-05-23 23:00:00	19	38.75
7080	2026-05-23 23:00:00	18	275.25
7088	2026-05-23 23:00:00	20	38.75
7109	2026-05-24 00:00:00	32	38.94
7121	2026-05-24 00:00:00	31	40
7134	2026-05-24 00:00:00	33	261.75
7146	2026-05-24 00:00:00	34	16.25
7150	2026-05-24 00:00:00	35	16.25
7151	2026-05-24 01:00:00	4	15
7163	2026-05-24 01:00:00	1	12
7177	2026-05-24 01:00:00	3	168.6
7188	2026-05-24 01:00:00	2	24.72
7197	2026-05-24 01:00:00	5	15
7203	2026-05-24 02:00:00	16	40
7211	2026-05-24 02:00:00	17	35.07
7227	2026-05-24 02:00:00	19	38.5
7236	2026-05-24 02:00:00	18	275.1
7245	2026-05-24 02:00:00	20	38.5
7255	2026-05-24 03:00:00	21	40
7274	2026-05-24 03:00:00	24	10
7285	2026-05-24 03:00:00	23	258
7295	2026-05-24 03:00:00	25	10
7300	2026-05-24 03:00:00	22	40.18
7301	2026-05-24 04:00:00	2	24.78
7311	2026-05-24 04:00:00	5	15
7317	2026-05-24 04:00:00	4	15
7323	2026-05-24 04:00:00	1	12
7331	2026-05-24 04:00:00	3	168.6
7358	2026-05-24 05:00:00	50	12.25
7368	2026-05-24 05:00:00	46	40
7377	2026-05-24 05:00:00	48	259.35
7388	2026-05-24 05:00:00	49	12.25
7396	2026-05-24 05:00:00	47	39.75
7405	2026-05-24 06:00:00	14	10
7415	2026-05-24 06:00:00	13	258
7423	2026-05-24 06:00:00	12	55.11
7436	2026-05-24 06:00:00	11	40
7445	2026-05-24 06:00:00	15	10
7455	2026-05-24 07:00:00	31	40
7469	2026-05-24 07:00:00	33	261.75
7482	2026-05-24 07:00:00	34	16.25
7491	2026-05-24 07:00:00	35	16.25
7498	2026-05-24 07:00:00	32	38.85
6667	2026-05-23 15:00:00	39	10.5
6675	2026-05-23 15:00:00	40	10.5
6685	2026-05-23 15:00:00	37	39.94
6695	2026-05-23 15:00:00	38	258.3
6707	2026-05-23 16:00:00	26	40
6712	2026-05-23 16:00:00	30	16.25
6720	2026-05-23 16:00:00	28	261.75
6732	2026-05-23 16:00:00	27	38.94
6744	2026-05-23 16:00:00	29	16.25
6754	2026-05-23 17:00:00	28	261.6
6762	2026-05-23 17:00:00	27	39
6771	2026-05-23 17:00:00	29	16
6784	2026-05-23 17:00:00	26	40
6793	2026-05-23 17:00:00	30	16
6804	2026-05-23 18:00:00	26	40
6821	2026-05-23 18:00:00	30	16.25
6834	2026-05-23 18:00:00	28	261.75
6844	2026-05-23 18:00:00	27	38.96
6850	2026-05-23 18:00:00	29	16.25
6851	2026-05-23 19:00:00	2	24.92
6864	2026-05-23 19:00:00	5	15
6875	2026-05-23 19:00:00	4	15
6885	2026-05-23 19:00:00	1	12
6894	2026-05-23 19:00:00	3	168.6
6909	2026-05-23 20:00:00	34	15
6919	2026-05-23 20:00:00	35	15
6935	2026-05-23 20:00:00	32	39.11
6946	2026-05-23 20:00:00	31	40
6950	2026-05-23 20:00:00	33	261
6951	2026-05-23 21:00:00	1	12
6961	2026-05-23 21:00:00	3	168.6
6977	2026-05-23 21:00:00	2	24.77
6989	2026-05-23 21:00:00	5	15
6997	2026-05-23 21:00:00	4	15
7003	2026-05-23 22:00:00	14	10
7013	2026-05-23 22:00:00	13	258
7021	2026-05-23 22:00:00	12	54.99
7030	2026-05-23 22:00:00	11	40
7041	2026-05-23 22:00:00	15	10
7057	2026-05-23 23:00:00	33	261.75
7063	2026-05-23 23:00:00	34	16.25
7072	2026-05-23 23:00:00	35	16.25
7079	2026-05-23 23:00:00	32	38.91
7086	2026-05-23 23:00:00	31	40
7110	2026-05-24 00:00:00	43	258.3
7123	2026-05-24 00:00:00	44	10.5
7130	2026-05-24 00:00:00	45	10.5
7139	2026-05-24 00:00:00	41	40
7145	2026-05-24 00:00:00	42	39.85
7154	2026-05-24 01:00:00	21	40
7165	2026-05-24 01:00:00	24	10
7179	2026-05-24 01:00:00	23	258
7189	2026-05-24 01:00:00	25	10
7196	2026-05-24 01:00:00	22	40.02
7204	2026-05-24 02:00:00	13	258
7214	2026-05-24 02:00:00	12	55.01
7221	2026-05-24 02:00:00	11	40
7229	2026-05-24 02:00:00	15	10
7239	2026-05-24 02:00:00	14	10
7260	2026-05-24 03:00:00	38	258.3
7269	2026-05-24 03:00:00	36	40
7282	2026-05-24 03:00:00	39	10.5
7293	2026-05-24 03:00:00	40	10.5
7298	2026-05-24 03:00:00	37	40.09
7302	2026-05-24 04:00:00	7	24.92
7314	2026-05-24 04:00:00	10	15
7328	2026-05-24 04:00:00	9	15
7340	2026-05-24 04:00:00	8	168.6
7348	2026-05-24 04:00:00	6	12
7355	2026-05-24 05:00:00	18	275.25
7364	2026-05-24 05:00:00	20	38.75
7374	2026-05-24 05:00:00	16	40
7387	2026-05-24 05:00:00	17	35.17
7397	2026-05-24 05:00:00	19	38.75
7404	2026-05-24 06:00:00	19	38.5
7411	2026-05-24 06:00:00	18	275.1
7421	2026-05-24 06:00:00	20	38.5
7425	2026-05-24 06:00:00	16	40
7433	2026-05-24 06:00:00	17	35.01
7459	2026-05-24 07:00:00	47	39.62
7466	2026-05-24 07:00:00	50	12.25
7475	2026-05-24 07:00:00	46	40
7485	2026-05-24 07:00:00	48	259.35
7494	2026-05-24 07:00:00	49	12.25
6668	2026-05-23 15:00:00	48	258.75
6676	2026-05-23 15:00:00	49	11.25
6687	2026-05-23 15:00:00	47	39.96
6706	2026-05-23 16:00:00	35	15
6711	2026-05-23 16:00:00	32	39.2
6719	2026-05-23 16:00:00	31	40
6727	2026-05-23 16:00:00	33	261
6739	2026-05-23 16:00:00	34	15
6757	2026-05-23 17:00:00	31	40
6769	2026-05-23 17:00:00	33	261
6780	2026-05-23 17:00:00	34	15
6792	2026-05-23 17:00:00	35	15
6798	2026-05-23 17:00:00	32	39.11
6805	2026-05-23 18:00:00	13	258
6816	2026-05-23 18:00:00	12	55
6826	2026-05-23 18:00:00	11	40
6839	2026-05-23 18:00:00	15	10
6847	2026-05-23 18:00:00	14	10
6853	2026-05-23 19:00:00	14	10
6868	2026-05-23 19:00:00	13	258
6880	2026-05-23 19:00:00	12	55.06
6892	2026-05-23 19:00:00	11	40
6898	2026-05-23 19:00:00	15	10
6902	2026-05-23 20:00:00	14	10
6911	2026-05-23 20:00:00	13	258
6920	2026-05-23 20:00:00	12	55.12
6927	2026-05-23 20:00:00	11	40
6936	2026-05-23 20:00:00	15	10
6959	2026-05-23 21:00:00	46	40
6963	2026-05-23 21:00:00	48	259.35
6972	2026-05-23 21:00:00	49	12.25
6979	2026-05-23 21:00:00	47	39.67
6992	2026-05-23 21:00:00	50	12.25
7008	2026-05-23 22:00:00	40	10.5
7019	2026-05-23 22:00:00	37	39.94
7032	2026-05-23 22:00:00	38	258.3
7045	2026-05-23 22:00:00	36	40
7049	2026-05-23 22:00:00	39	10.5
7054	2026-05-23 23:00:00	8	168.6
7069	2026-05-23 23:00:00	6	12
7084	2026-05-23 23:00:00	7	24.85
7094	2026-05-23 23:00:00	10	15
7100	2026-05-23 23:00:00	9	15
7101	2026-05-24 00:00:00	3	168.6
7115	2026-05-24 00:00:00	2	24.97
7128	2026-05-24 00:00:00	5	15
7141	2026-05-24 00:00:00	4	15
7148	2026-05-24 00:00:00	1	12
7153	2026-05-24 01:00:00	13	258
7162	2026-05-24 01:00:00	12	55.11
7171	2026-05-24 01:00:00	11	40
7174	2026-05-24 01:00:00	15	10
7182	2026-05-24 01:00:00	14	10
7208	2026-05-24 02:00:00	46	40
7215	2026-05-24 02:00:00	48	259.35
7223	2026-05-24 02:00:00	49	12.25
7232	2026-05-24 02:00:00	47	39.7
7243	2026-05-24 02:00:00	50	12.25
7258	2026-05-24 03:00:00	33	261.75
7264	2026-05-24 03:00:00	34	16.25
7272	2026-05-24 03:00:00	35	16.25
7280	2026-05-24 03:00:00	32	39.08
7291	2026-05-24 03:00:00	31	40
7307	2026-05-24 04:00:00	35	16.25
7316	2026-05-24 04:00:00	32	39.13
7330	2026-05-24 04:00:00	31	40
7339	2026-05-24 04:00:00	33	261.75
7346	2026-05-24 04:00:00	34	16.25
7353	2026-05-24 05:00:00	23	258
7363	2026-05-24 05:00:00	25	10
7372	2026-05-24 05:00:00	22	39.98
7383	2026-05-24 05:00:00	21	40
7393	2026-05-24 05:00:00	24	10
7410	2026-05-24 06:00:00	41	40
7420	2026-05-24 06:00:00	42	40.03
7432	2026-05-24 06:00:00	43	258.3
7442	2026-05-24 06:00:00	44	10.5
7450	2026-05-24 06:00:00	45	10.5
7451	2026-05-24 07:00:00	5	15
7461	2026-05-24 07:00:00	4	15
7477	2026-05-24 07:00:00	1	12
7489	2026-05-24 07:00:00	3	168.6
7496	2026-05-24 07:00:00	2	24.85
6669	2026-05-23 15:00:00	28	261
6677	2026-05-23 15:00:00	27	39.07
6689	2026-05-23 15:00:00	29	15
6710	2026-05-23 16:00:00	36	40
6715	2026-05-23 16:00:00	39	10.25
6724	2026-05-23 16:00:00	40	10.25
6731	2026-05-23 16:00:00	37	40.08
6737	2026-05-23 16:00:00	38	258.15
6759	2026-05-23 17:00:00	46	40
6766	2026-05-23 17:00:00	48	258.75
6775	2026-05-23 17:00:00	49	11.25
6783	2026-05-23 17:00:00	47	39.94
6795	2026-05-23 17:00:00	50	11.25
6803	2026-05-23 18:00:00	22	40.19
6815	2026-05-23 18:00:00	21	40
6825	2026-05-23 18:00:00	24	10
6835	2026-05-23 18:00:00	23	258
6845	2026-05-23 18:00:00	25	10
6857	2026-05-23 19:00:00	29	16.25
6862	2026-05-23 19:00:00	26	40
6871	2026-05-23 19:00:00	30	16.25
6879	2026-05-23 19:00:00	28	261.75
6888	2026-05-23 19:00:00	27	38.99
6906	2026-05-23 20:00:00	40	10.5
6913	2026-05-23 20:00:00	37	39.86
6926	2026-05-23 20:00:00	38	258.3
6933	2026-05-23 20:00:00	36	40
6943	2026-05-23 20:00:00	39	10.5
6957	2026-05-23 21:00:00	30	16.25
6962	2026-05-23 21:00:00	28	261.75
6971	2026-05-23 21:00:00	27	39.05
6978	2026-05-23 21:00:00	29	16.25
6988	2026-05-23 21:00:00	26	40
7009	2026-05-23 22:00:00	50	12
7018	2026-05-23 22:00:00	46	40
7025	2026-05-23 22:00:00	48	259.2
7034	2026-05-23 22:00:00	49	12
7040	2026-05-23 22:00:00	47	39.89
7059	2026-05-23 23:00:00	50	12
7070	2026-05-23 23:00:00	46	40
7076	2026-05-23 23:00:00	48	259.2
7089	2026-05-23 23:00:00	49	12
7096	2026-05-23 23:00:00	47	39.72
7105	2026-05-24 00:00:00	21	40
7111	2026-05-24 00:00:00	24	10
7119	2026-05-24 00:00:00	23	258
7125	2026-05-24 00:00:00	25	10
7136	2026-05-24 00:00:00	22	40.07
7160	2026-05-24 01:00:00	46	40
7167	2026-05-24 01:00:00	48	259.2
7172	2026-05-24 01:00:00	49	12
7184	2026-05-24 01:00:00	47	39.79
7194	2026-05-24 01:00:00	50	12
7207	2026-05-24 02:00:00	33	261.75
7224	2026-05-24 02:00:00	34	16.25
7238	2026-05-24 02:00:00	35	16.25
7247	2026-05-24 02:00:00	32	39.03
7250	2026-05-24 02:00:00	31	40
7251	2026-05-24 03:00:00	1	12
7261	2026-05-24 03:00:00	3	168.6
7276	2026-05-24 03:00:00	2	24.88
7287	2026-05-24 03:00:00	5	15
7296	2026-05-24 03:00:00	4	15
7303	2026-05-24 04:00:00	21	40
7321	2026-05-24 04:00:00	24	10
7333	2026-05-24 04:00:00	23	258
7342	2026-05-24 04:00:00	25	10
7349	2026-05-24 04:00:00	22	40.08
7352	2026-05-24 05:00:00	8	168.6
7362	2026-05-24 05:00:00	6	12
7371	2026-05-24 05:00:00	7	24.92
7379	2026-05-24 05:00:00	10	15
7385	2026-05-24 05:00:00	9	15
7409	2026-05-24 06:00:00	47	39.59
7419	2026-05-24 06:00:00	50	12.25
7431	2026-05-24 06:00:00	46	40
7441	2026-05-24 06:00:00	48	259.35
7447	2026-05-24 06:00:00	49	12.25
7457	2026-05-24 07:00:00	28	261.75
7463	2026-05-24 07:00:00	27	39.07
7472	2026-05-24 07:00:00	29	16.25
7481	2026-05-24 07:00:00	26	40
7488	2026-05-24 07:00:00	30	16.25
6670	2026-05-23 15:00:00	14	10
6678	2026-05-23 15:00:00	13	258
6686	2026-05-23 15:00:00	12	55.22
6709	2026-05-23 16:00:00	50	11
6722	2026-05-23 16:00:00	46	40
6730	2026-05-23 16:00:00	48	258.6
6736	2026-05-23 16:00:00	49	11
6742	2026-05-23 16:00:00	47	39.82
6760	2026-05-23 17:00:00	43	258.6
6773	2026-05-23 17:00:00	44	11
6786	2026-05-23 17:00:00	45	11
6794	2026-05-23 17:00:00	41	40
6799	2026-05-23 17:00:00	42	40.06
6801	2026-05-23 18:00:00	2	24.88
6811	2026-05-23 18:00:00	5	15
6819	2026-05-23 18:00:00	4	15
6827	2026-05-23 18:00:00	1	12
6838	2026-05-23 18:00:00	3	168.6
6859	2026-05-23 19:00:00	45	10.75
6866	2026-05-23 19:00:00	41	40
6883	2026-05-23 19:00:00	42	39.94
6893	2026-05-23 19:00:00	43	258.45
6900	2026-05-23 19:00:00	44	10.75
6901	2026-05-23 20:00:00	5	15
6916	2026-05-23 20:00:00	4	15
6923	2026-05-23 20:00:00	1	12
6931	2026-05-23 20:00:00	3	168.6
6940	2026-05-23 20:00:00	2	24.98
6960	2026-05-23 21:00:00	38	258.3
6970	2026-05-23 21:00:00	36	40
6982	2026-05-23 21:00:00	39	10.5
6986	2026-05-23 21:00:00	40	10.5
6993	2026-05-23 21:00:00	37	39.98
7007	2026-05-23 22:00:00	45	10.5
7014	2026-05-23 22:00:00	41	40
7022	2026-05-23 22:00:00	42	39.95
7029	2026-05-23 22:00:00	43	258.3
7038	2026-05-23 22:00:00	44	10.5
7060	2026-05-23 23:00:00	41	40
7067	2026-05-23 23:00:00	42	40.03
7082	2026-05-23 23:00:00	43	258.45
7093	2026-05-23 23:00:00	44	10.75
7099	2026-05-23 23:00:00	45	10.75
7102	2026-05-24 00:00:00	7	24.96
7116	2026-05-24 00:00:00	10	15
7127	2026-05-24 00:00:00	9	15
7137	2026-05-24 00:00:00	8	168.6
7147	2026-05-24 00:00:00	6	12
7155	2026-05-24 01:00:00	16	40
7166	2026-05-24 01:00:00	17	35.06
7178	2026-05-24 01:00:00	19	38.5
7190	2026-05-24 01:00:00	18	275.1
7198	2026-05-24 01:00:00	20	38.5
7209	2026-05-24 02:00:00	21	40
7217	2026-05-24 02:00:00	24	10
7230	2026-05-24 02:00:00	23	258
7241	2026-05-24 02:00:00	25	10
7248	2026-05-24 02:00:00	22	40.07
7252	2026-05-24 03:00:00	13	258
7263	2026-05-24 03:00:00	12	55.13
7271	2026-05-24 03:00:00	11	40
7281	2026-05-24 03:00:00	15	10
7292	2026-05-24 03:00:00	14	10
7308	2026-05-24 04:00:00	36	40
7313	2026-05-24 04:00:00	39	10.5
7327	2026-05-24 04:00:00	40	10.5
7337	2026-05-24 04:00:00	37	40.14
7345	2026-05-24 04:00:00	38	258.3
7356	2026-05-24 05:00:00	28	261.75
7365	2026-05-24 05:00:00	27	39.13
7373	2026-05-24 05:00:00	29	16.25
7381	2026-05-24 05:00:00	26	40
7392	2026-05-24 05:00:00	30	16.25
7408	2026-05-24 06:00:00	38	258.3
7417	2026-05-24 06:00:00	36	40
7427	2026-05-24 06:00:00	39	10.5
7437	2026-05-24 06:00:00	40	10.5
7449	2026-05-24 06:00:00	37	40.11
7452	2026-05-24 07:00:00	10	15
7468	2026-05-24 07:00:00	9	15
7478	2026-05-24 07:00:00	8	168.6
7492	2026-05-24 07:00:00	6	12
7499	2026-05-24 07:00:00	7	24.89
6671	2026-05-23 15:00:00	44	10.75
6679	2026-05-23 15:00:00	45	10.75
6688	2026-05-23 15:00:00	41	40
6708	2026-05-23 16:00:00	42	39.85
6723	2026-05-23 16:00:00	43	258.6
6735	2026-05-23 16:00:00	44	11
6746	2026-05-23 16:00:00	45	11
6750	2026-05-23 16:00:00	41	40
6751	2026-05-23 17:00:00	5	15
6764	2026-05-23 17:00:00	4	15
6777	2026-05-23 17:00:00	1	12
6782	2026-05-23 17:00:00	3	168.6
6790	2026-05-23 17:00:00	2	24.94
6809	2026-05-23 18:00:00	47	39.74
6813	2026-05-23 18:00:00	50	12.5
6823	2026-05-23 18:00:00	46	40
6828	2026-05-23 18:00:00	48	259.5
6836	2026-05-23 18:00:00	49	12.5
6858	2026-05-23 19:00:00	47	39.55
6865	2026-05-23 19:00:00	50	12.5
6874	2026-05-23 19:00:00	46	40
6884	2026-05-23 19:00:00	48	259.5
6895	2026-05-23 19:00:00	49	12.5
6907	2026-05-23 20:00:00	22	40.18
6918	2026-05-23 20:00:00	21	40
6929	2026-05-23 20:00:00	24	10
6938	2026-05-23 20:00:00	23	258
6945	2026-05-23 20:00:00	25	10
6953	2026-05-23 21:00:00	17	35.08
6969	2026-05-23 21:00:00	19	38.5
6980	2026-05-23 21:00:00	18	275.1
6990	2026-05-23 21:00:00	20	38.5
7000	2026-05-23 21:00:00	16	40
7001	2026-05-23 22:00:00	5	15
7011	2026-05-23 22:00:00	4	15
7024	2026-05-23 22:00:00	1	12
7035	2026-05-23 22:00:00	3	168.6
7046	2026-05-23 22:00:00	2	24.87
7056	2026-05-23 23:00:00	25	10
7065	2026-05-23 23:00:00	22	40.09
7074	2026-05-23 23:00:00	21	40
7081	2026-05-23 23:00:00	24	10
7091	2026-05-23 23:00:00	23	258
7108	2026-05-24 00:00:00	36	40
7114	2026-05-24 00:00:00	39	10.5
7122	2026-05-24 00:00:00	40	10.5
7129	2026-05-24 00:00:00	37	39.96
7140	2026-05-24 00:00:00	38	258.3
7157	2026-05-24 01:00:00	42	40.14
7170	2026-05-24 01:00:00	43	258.3
7181	2026-05-24 01:00:00	44	10.5
7192	2026-05-24 01:00:00	45	10.5
7200	2026-05-24 01:00:00	41	40
7201	2026-05-24 02:00:00	4	15
7212	2026-05-24 02:00:00	1	12
7219	2026-05-24 02:00:00	3	168.6
7226	2026-05-24 02:00:00	2	24.92
7234	2026-05-24 02:00:00	5	15
7257	2026-05-24 03:00:00	46	40
7266	2026-05-24 03:00:00	48	259.35
7275	2026-05-24 03:00:00	49	12.25
7283	2026-05-24 03:00:00	47	39.82
7288	2026-05-24 03:00:00	50	12.25
7310	2026-05-24 04:00:00	49	12.25
7320	2026-05-24 04:00:00	47	39.69
7332	2026-05-24 04:00:00	50	12.25
7343	2026-05-24 04:00:00	46	40
7350	2026-05-24 04:00:00	48	259.35
7351	2026-05-24 05:00:00	2	24.97
7361	2026-05-24 05:00:00	5	15
7375	2026-05-24 05:00:00	4	15
7386	2026-05-24 05:00:00	1	12
7395	2026-05-24 05:00:00	3	168.6
7406	2026-05-24 06:00:00	28	261.75
7418	2026-05-24 06:00:00	27	39.06
7428	2026-05-24 06:00:00	29	16.25
7439	2026-05-24 06:00:00	26	40
7448	2026-05-24 06:00:00	30	16.25
7453	2026-05-24 07:00:00	19	38.5
7465	2026-05-24 07:00:00	18	275.1
7474	2026-05-24 07:00:00	20	38.5
7480	2026-05-24 07:00:00	16	40
7487	2026-05-24 07:00:00	17	35.18
6672	2026-05-23 15:00:00	16	40
6680	2026-05-23 15:00:00	17	34.95
6691	2026-05-23 15:00:00	19	39
6697	2026-05-23 15:00:00	18	275.4
6705	2026-05-23 16:00:00	20	29.5
6713	2026-05-23 16:00:00	16	40
6721	2026-05-23 16:00:00	17	36.71
6729	2026-05-23 16:00:00	19	29.5
6740	2026-05-23 16:00:00	18	269.7
6756	2026-05-23 17:00:00	21	40
6761	2026-05-23 17:00:00	24	10
6770	2026-05-23 17:00:00	23	258
6779	2026-05-23 17:00:00	25	10
6789	2026-05-23 17:00:00	22	40.13
6808	2026-05-23 18:00:00	40	10.5
6812	2026-05-23 18:00:00	37	40.13
6822	2026-05-23 18:00:00	38	258.3
6833	2026-05-23 18:00:00	36	40
6843	2026-05-23 18:00:00	39	10.5
6856	2026-05-23 19:00:00	33	261
6861	2026-05-23 19:00:00	34	15
6870	2026-05-23 19:00:00	35	15
6876	2026-05-23 19:00:00	32	39.22
6887	2026-05-23 19:00:00	31	40
6905	2026-05-23 20:00:00	45	11
6915	2026-05-23 20:00:00	41	40
6924	2026-05-23 20:00:00	42	39.84
6932	2026-05-23 20:00:00	43	258.6
6941	2026-05-23 20:00:00	44	11
6955	2026-05-23 21:00:00	35	15
6968	2026-05-23 21:00:00	32	39.12
6981	2026-05-23 21:00:00	31	40
6991	2026-05-23 21:00:00	33	261
6999	2026-05-23 21:00:00	34	15
7002	2026-05-23 22:00:00	9	15
7017	2026-05-23 22:00:00	8	168.6
7028	2026-05-23 22:00:00	6	12
7037	2026-05-23 22:00:00	7	24.84
7043	2026-05-23 22:00:00	10	15
7058	2026-05-23 23:00:00	30	16
7062	2026-05-23 23:00:00	28	261.6
7071	2026-05-23 23:00:00	27	38.98
7078	2026-05-23 23:00:00	29	16
7085	2026-05-23 23:00:00	26	40
7107	2026-05-24 00:00:00	48	259.35
7113	2026-05-24 00:00:00	49	12.25
7124	2026-05-24 00:00:00	47	39.6
7135	2026-05-24 00:00:00	50	12.25
7142	2026-05-24 00:00:00	46	40
7156	2026-05-24 01:00:00	27	38.87
7168	2026-05-24 01:00:00	29	16.25
7176	2026-05-24 01:00:00	26	40
7187	2026-05-24 01:00:00	30	16.25
7193	2026-05-24 01:00:00	28	261.75
7210	2026-05-24 02:00:00	38	258.3
7218	2026-05-24 02:00:00	36	40
7233	2026-05-24 02:00:00	39	10.5
7242	2026-05-24 02:00:00	40	10.5
7249	2026-05-24 02:00:00	37	40.09
7253	2026-05-24 03:00:00	8	168.6
7265	2026-05-24 03:00:00	6	12
7273	2026-05-24 03:00:00	7	24.95
7284	2026-05-24 03:00:00	10	15
7294	2026-05-24 03:00:00	9	15
7306	2026-05-24 04:00:00	29	16.25
7315	2026-05-24 04:00:00	26	40
7329	2026-05-24 04:00:00	30	16.25
7338	2026-05-24 04:00:00	28	261.75
7347	2026-05-24 04:00:00	27	39.07
7354	2026-05-24 05:00:00	13	258
7369	2026-05-24 05:00:00	12	54.97
7380	2026-05-24 05:00:00	11	40
7390	2026-05-24 05:00:00	15	10
7399	2026-05-24 05:00:00	14	10
7401	2026-05-24 06:00:00	8	168.6
7414	2026-05-24 06:00:00	6	12
7429	2026-05-24 06:00:00	7	24.9
7440	2026-05-24 06:00:00	10	15
7443	2026-05-24 06:00:00	9	15
7460	2026-05-24 07:00:00	38	258.3
7470	2026-05-24 07:00:00	36	40
7483	2026-05-24 07:00:00	39	10.5
7493	2026-05-24 07:00:00	40	10.5
7500	2026-05-24 07:00:00	37	40.15
6673	2026-05-23 15:00:00	23	258
6681	2026-05-23 15:00:00	25	10
6690	2026-05-23 15:00:00	22	40.2
6696	2026-05-23 15:00:00	21	40
6704	2026-05-23 16:00:00	24	10
6718	2026-05-23 16:00:00	23	258
6726	2026-05-23 16:00:00	25	10
6734	2026-05-23 16:00:00	22	39.97
6743	2026-05-23 16:00:00	21	40
6758	2026-05-23 17:00:00	40	10.25
6767	2026-05-23 17:00:00	37	40.16
6776	2026-05-23 17:00:00	38	258.15
6788	2026-05-23 17:00:00	36	40
6797	2026-05-23 17:00:00	39	10.25
6806	2026-05-23 18:00:00	16	40
6818	2026-05-23 18:00:00	17	35.09
6831	2026-05-23 18:00:00	19	39
6841	2026-05-23 18:00:00	18	275.4
6848	2026-05-23 18:00:00	20	39
6854	2026-05-23 19:00:00	20	38.75
6863	2026-05-23 19:00:00	16	40
6872	2026-05-23 19:00:00	17	35.06
6878	2026-05-23 19:00:00	19	38.75
6886	2026-05-23 19:00:00	18	275.25
6908	2026-05-23 20:00:00	47	39.73
6914	2026-05-23 20:00:00	50	12.5
6925	2026-05-23 20:00:00	46	40
6934	2026-05-23 20:00:00	48	259.5
6942	2026-05-23 20:00:00	49	12.5
6954	2026-05-23 21:00:00	22	39.97
6964	2026-05-23 21:00:00	21	40
6973	2026-05-23 21:00:00	24	10
6984	2026-05-23 21:00:00	23	258
6995	2026-05-23 21:00:00	25	10
7006	2026-05-23 22:00:00	26	40
7016	2026-05-23 22:00:00	30	16
7027	2026-05-23 22:00:00	28	261.6
7039	2026-05-23 22:00:00	27	39.08
7048	2026-05-23 22:00:00	29	16
7053	2026-05-23 23:00:00	14	10
7068	2026-05-23 23:00:00	13	258
7083	2026-05-23 23:00:00	12	55
7092	2026-05-23 23:00:00	11	40
7098	2026-05-23 23:00:00	15	10
7103	2026-05-24 00:00:00	19	38.75
7117	2026-05-24 00:00:00	18	275.25
7131	2026-05-24 00:00:00	20	38.75
7138	2026-05-24 00:00:00	16	40
7144	2026-05-24 00:00:00	17	34.91
7158	2026-05-24 01:00:00	33	261.75
7164	2026-05-24 01:00:00	34	16.25
7175	2026-05-24 01:00:00	35	16.25
7183	2026-05-24 01:00:00	32	38.97
7186	2026-05-24 01:00:00	31	40
7206	2026-05-24 02:00:00	41	40
7216	2026-05-24 02:00:00	42	40.06
7228	2026-05-24 02:00:00	43	258.3
7240	2026-05-24 02:00:00	44	10.5
7246	2026-05-24 02:00:00	45	10.5
7254	2026-05-24 03:00:00	17	35.25
7262	2026-05-24 03:00:00	19	38.5
7270	2026-05-24 03:00:00	18	275.1
7279	2026-05-24 03:00:00	20	38.5
7286	2026-05-24 03:00:00	16	40
7309	2026-05-24 04:00:00	43	258.3
7319	2026-05-24 04:00:00	44	10.5
7325	2026-05-24 04:00:00	45	10.5
7335	2026-05-24 04:00:00	41	40
7344	2026-05-24 04:00:00	42	39.88
7360	2026-05-24 05:00:00	33	261.75
7370	2026-05-24 05:00:00	34	16.25
7382	2026-05-24 05:00:00	35	16.25
7391	2026-05-24 05:00:00	32	38.89
7400	2026-05-24 05:00:00	31	40
7402	2026-05-24 06:00:00	2	24.93
7413	2026-05-24 06:00:00	5	15
7430	2026-05-24 06:00:00	4	15
7438	2026-05-24 06:00:00	1	12
7446	2026-05-24 06:00:00	3	168.6
7454	2026-05-24 07:00:00	14	10
7467	2026-05-24 07:00:00	13	258
7476	2026-05-24 07:00:00	12	55.17
7490	2026-05-24 07:00:00	11	40
7497	2026-05-24 07:00:00	15	10
6674	2026-05-23 15:00:00	32	39.23
6684	2026-05-23 15:00:00	31	40
6694	2026-05-23 15:00:00	33	261
6698	2026-05-23 15:00:00	34	15
6702	2026-05-23 16:00:00	8	168.6
6716	2026-05-23 16:00:00	6	12
6725	2026-05-23 16:00:00	7	24.82
6738	2026-05-23 16:00:00	10	15
6747	2026-05-23 16:00:00	9	15
6752	2026-05-23 17:00:00	17	34.95
6763	2026-05-23 17:00:00	19	38.75
6772	2026-05-23 17:00:00	18	275.25
6778	2026-05-23 17:00:00	20	38.75
6787	2026-05-23 17:00:00	16	40
6807	2026-05-23 18:00:00	45	10.75
6814	2026-05-23 18:00:00	41	40
6824	2026-05-23 18:00:00	42	40.08
6830	2026-05-23 18:00:00	43	258.45
6840	2026-05-23 18:00:00	44	10.75
6860	2026-05-23 19:00:00	40	10.5
6873	2026-05-23 19:00:00	37	40.1
6877	2026-05-23 19:00:00	38	258.3
6889	2026-05-23 19:00:00	36	40
6899	2026-05-23 19:00:00	39	10.5
6904	2026-05-23 20:00:00	9	15
6917	2026-05-23 20:00:00	8	168.6
6930	2026-05-23 20:00:00	6	12
6944	2026-05-23 20:00:00	7	25
6948	2026-05-23 20:00:00	10	15
6956	2026-05-23 21:00:00	12	55.16
6965	2026-05-23 21:00:00	11	40
6974	2026-05-23 21:00:00	15	10
6983	2026-05-23 21:00:00	14	10
6994	2026-05-23 21:00:00	13	258
7010	2026-05-23 22:00:00	33	261
7020	2026-05-23 22:00:00	34	15
7031	2026-05-23 22:00:00	35	15
7042	2026-05-23 22:00:00	32	39.32
7050	2026-05-23 22:00:00	31	40
7051	2026-05-23 23:00:00	4	15
7061	2026-05-23 23:00:00	1	12
7077	2026-05-23 23:00:00	3	168.6
7090	2026-05-23 23:00:00	2	24.87
7097	2026-05-23 23:00:00	5	15
7104	2026-05-24 00:00:00	12	55.02
7112	2026-05-24 00:00:00	11	40
7120	2026-05-24 00:00:00	15	10
7126	2026-05-24 00:00:00	14	10
7133	2026-05-24 00:00:00	13	258
7159	2026-05-24 01:00:00	38	258.3
7169	2026-05-24 01:00:00	36	40
7180	2026-05-24 01:00:00	39	10.5
7191	2026-05-24 01:00:00	40	10.5
7199	2026-05-24 01:00:00	37	40.04
7202	2026-05-24 02:00:00	8	168.6
7213	2026-05-24 02:00:00	6	12
7220	2026-05-24 02:00:00	7	24.86
7225	2026-05-24 02:00:00	10	15
7235	2026-05-24 02:00:00	9	15
7259	2026-05-24 03:00:00	41	40
7267	2026-05-24 03:00:00	42	39.95
7277	2026-05-24 03:00:00	43	258.3
7289	2026-05-24 03:00:00	44	10.5
7299	2026-05-24 03:00:00	45	10.5
7305	2026-05-24 04:00:00	11	40
7318	2026-05-24 04:00:00	15	10
7326	2026-05-24 04:00:00	14	10
7336	2026-05-24 04:00:00	13	258
7341	2026-05-24 04:00:00	12	55.17
7357	2026-05-24 05:00:00	36	40
7366	2026-05-24 05:00:00	39	10.5
7376	2026-05-24 05:00:00	40	10.5
7389	2026-05-24 05:00:00	37	40.15
7398	2026-05-24 05:00:00	38	258.3
7403	2026-05-24 06:00:00	23	258
7412	2026-05-24 06:00:00	25	10
7422	2026-05-24 06:00:00	22	40.23
7426	2026-05-24 06:00:00	21	40
7434	2026-05-24 06:00:00	24	10
7458	2026-05-24 07:00:00	41	40
7462	2026-05-24 07:00:00	42	39.85
7471	2026-05-24 07:00:00	43	258.3
7479	2026-05-24 07:00:00	44	10.5
7486	2026-05-24 07:00:00	45	10.5
7501	2026-05-24 08:00:00	4	15
7502	2026-05-24 08:00:00	9	15
7503	2026-05-24 08:00:00	12	54.97
7504	2026-05-24 08:00:00	23	258
7505	2026-05-24 08:00:00	20	38.75
7506	2026-05-24 08:00:00	36	40
7507	2026-05-24 08:00:00	33	261.75
7508	2026-05-24 08:00:00	43	258.15
7509	2026-05-24 08:00:00	29	16.25
7510	2026-05-24 08:00:00	46	40
7511	2026-05-24 08:00:00	34	16.25
7512	2026-05-24 08:00:00	39	10.5
7513	2026-05-24 08:00:00	25	10
7514	2026-05-24 08:00:00	11	40
7515	2026-05-24 08:00:00	16	40
7516	2026-05-24 08:00:00	1	12
7517	2026-05-24 08:00:00	8	168.6
7518	2026-05-24 08:00:00	44	10.25
7519	2026-05-24 08:00:00	26	40
7520	2026-05-24 08:00:00	48	259.35
7521	2026-05-24 08:00:00	35	16.25
7522	2026-05-24 08:00:00	40	10.5
7523	2026-05-24 08:00:00	22	40.09
7524	2026-05-24 08:00:00	17	35.13
7525	2026-05-24 08:00:00	15	10
7526	2026-05-24 08:00:00	30	16.25
7527	2026-05-24 08:00:00	45	10.25
7528	2026-05-24 08:00:00	49	12.25
7529	2026-05-24 08:00:00	3	168.6
7530	2026-05-24 08:00:00	6	12
7531	2026-05-24 08:00:00	21	40
7532	2026-05-24 08:00:00	19	38.75
7533	2026-05-24 08:00:00	14	10
7534	2026-05-24 08:00:00	32	39.01
7535	2026-05-24 08:00:00	37	40.11
7536	2026-05-24 08:00:00	41	40
7537	2026-05-24 08:00:00	2	24.91
7538	2026-05-24 08:00:00	47	39.65
7539	2026-05-24 08:00:00	28	261.75
7540	2026-05-24 08:00:00	18	275.25
7541	2026-05-24 08:00:00	42	40.02
7542	2026-05-24 08:00:00	7	24.85
7543	2026-05-24 08:00:00	13	258
7544	2026-05-24 08:00:00	24	10
7545	2026-05-24 08:00:00	5	15
7546	2026-05-24 08:00:00	50	12.25
7547	2026-05-24 08:00:00	31	40
7548	2026-05-24 08:00:00	38	258.3
7549	2026-05-24 08:00:00	27	38.98
7550	2026-05-24 08:00:00	10	15
7551	2026-05-24 09:00:00	2	24.73
7552	2026-05-24 09:00:00	13	258
7554	2026-05-24 09:00:00	18	275.25
7569	2026-05-24 09:00:00	20	38.75
7581	2026-05-24 09:00:00	16	40
7593	2026-05-24 09:00:00	17	35.09
7600	2026-05-24 09:00:00	19	38.75
7602	2026-05-24 10:00:00	8	168.6
7614	2026-05-24 10:00:00	6	12
7631	2026-05-24 10:00:00	7	24.72
7641	2026-05-24 10:00:00	10	15
7649	2026-05-24 10:00:00	9	15
7655	2026-05-24 11:00:00	19	38.75
7673	2026-05-24 11:00:00	18	275.25
7684	2026-05-24 11:00:00	20	38.75
7694	2026-05-24 11:00:00	16	40
7700	2026-05-24 11:00:00	17	35.09
7701	2026-05-24 12:00:00	1	12
7713	2026-05-24 12:00:00	3	168.6
7728	2026-05-24 12:00:00	2	24.78
7738	2026-05-24 12:00:00	5	15
7745	2026-05-24 12:00:00	4	15
7755	2026-05-24 13:00:00	25	33.75
7767	2026-05-24 13:00:00	22	35.9
7775	2026-05-24 13:00:00	21	40
7786	2026-05-24 13:00:00	24	33.75
7791	2026-05-24 13:00:00	23	272.25
7809	2026-05-24 14:00:00	45	10.25
7814	2026-05-24 14:00:00	41	40
7822	2026-05-24 14:00:00	42	39.91
7840	2026-05-24 14:00:00	43	258.15
7848	2026-05-24 14:00:00	44	10.25
7853	2026-05-24 15:00:00	16	40
7861	2026-05-24 15:00:00	17	35.19
7870	2026-05-24 15:00:00	19	38.75
7876	2026-05-24 15:00:00	18	275.25
7884	2026-05-24 15:00:00	20	38.75
7908	2026-05-24 16:00:00	48	259.35
7913	2026-05-24 16:00:00	49	12.25
7925	2026-05-24 16:00:00	47	39.75
7938	2026-05-24 16:00:00	50	12.25
7946	2026-05-24 16:00:00	46	40
7953	2026-05-24 17:00:00	29	15
7961	2026-05-24 17:00:00	26	40
7969	2026-05-24 17:00:00	30	15
7975	2026-05-24 17:00:00	28	261
7983	2026-05-24 17:00:00	27	39.2
8009	2026-05-24 18:00:00	43	258.45
8016	2026-05-24 18:00:00	44	10.75
8026	2026-05-24 18:00:00	45	10.75
8037	2026-05-24 18:00:00	41	40
8045	2026-05-24 18:00:00	42	40.08
8054	2026-05-24 19:00:00	17	34.99
8069	2026-05-24 19:00:00	19	38.5
8078	2026-05-24 19:00:00	18	275.1
8090	2026-05-24 19:00:00	20	38.5
8098	2026-05-24 19:00:00	16	40
8103	2026-05-24 20:00:00	11	40
8116	2026-05-24 20:00:00	15	10
8126	2026-05-24 20:00:00	14	10
8135	2026-05-24 20:00:00	13	258
8140	2026-05-24 20:00:00	12	54.98
8160	2026-05-24 21:00:00	40	10.5
8169	2026-05-24 21:00:00	37	40.07
8184	2026-05-24 21:00:00	38	258.3
8191	2026-05-24 21:00:00	36	40
8195	2026-05-24 21:00:00	39	10.5
8206	2026-05-24 22:00:00	29	16.25
8211	2026-05-24 22:00:00	26	40
8221	2026-05-24 22:00:00	30	16.25
8229	2026-05-24 22:00:00	28	261.75
8236	2026-05-24 22:00:00	27	38.86
8259	2026-05-24 23:00:00	41	40
8263	2026-05-24 23:00:00	42	39.97
8272	2026-05-24 23:00:00	43	258.45
8277	2026-05-24 23:00:00	44	10.75
8291	2026-05-24 23:00:00	45	10.75
7553	2026-05-24 09:00:00	6	12
7570	2026-05-24 09:00:00	7	24.8
7582	2026-05-24 09:00:00	10	15
7591	2026-05-24 09:00:00	9	15
7597	2026-05-24 09:00:00	8	168.6
7603	2026-05-24 10:00:00	21	40
7611	2026-05-24 10:00:00	24	10
7621	2026-05-24 10:00:00	23	258
7627	2026-05-24 10:00:00	25	10
7636	2026-05-24 10:00:00	22	39.96
7659	2026-05-24 11:00:00	41	40
7668	2026-05-24 11:00:00	42	40.15
7680	2026-05-24 11:00:00	43	258.3
7693	2026-05-24 11:00:00	44	10.5
7699	2026-05-24 11:00:00	45	10.5
7702	2026-05-24 12:00:00	10	15
7714	2026-05-24 12:00:00	9	15
7729	2026-05-24 12:00:00	8	168.6
7741	2026-05-24 12:00:00	6	12
7747	2026-05-24 12:00:00	7	24.85
7754	2026-05-24 13:00:00	16	40
7761	2026-05-24 13:00:00	17	34.94
7771	2026-05-24 13:00:00	19	38.75
7780	2026-05-24 13:00:00	18	275.25
7788	2026-05-24 13:00:00	20	38.75
7808	2026-05-24 14:00:00	47	39.78
7818	2026-05-24 14:00:00	50	11
7826	2026-05-24 14:00:00	46	40
7831	2026-05-24 14:00:00	48	258.6
7838	2026-05-24 14:00:00	49	11
7859	2026-05-24 15:00:00	50	12
7865	2026-05-24 15:00:00	46	40
7874	2026-05-24 15:00:00	48	259.2
7881	2026-05-24 15:00:00	49	12
7889	2026-05-24 15:00:00	47	39.88
7906	2026-05-24 16:00:00	32	39.3
7917	2026-05-24 16:00:00	31	40
7929	2026-05-24 16:00:00	33	261
7936	2026-05-24 16:00:00	34	15
7941	2026-05-24 16:00:00	35	15
7958	2026-05-24 17:00:00	40	10.5
7967	2026-05-24 17:00:00	37	40.15
7978	2026-05-24 17:00:00	38	258.3
7990	2026-05-24 17:00:00	36	40
7998	2026-05-24 17:00:00	39	10.5
8003	2026-05-24 18:00:00	12	55.1
8014	2026-05-24 18:00:00	11	40
8027	2026-05-24 18:00:00	15	10
8034	2026-05-24 18:00:00	14	10
8043	2026-05-24 18:00:00	13	258
8060	2026-05-24 19:00:00	40	10.5
8070	2026-05-24 19:00:00	37	40.13
8081	2026-05-24 19:00:00	38	258.3
8089	2026-05-24 19:00:00	36	40
8097	2026-05-24 19:00:00	39	10.5
8104	2026-05-24 20:00:00	19	38.5
8114	2026-05-24 20:00:00	18	275.1
8124	2026-05-24 20:00:00	20	38.5
8131	2026-05-24 20:00:00	16	40
8143	2026-05-24 20:00:00	17	35.03
8157	2026-05-24 21:00:00	29	16.25
8164	2026-05-24 21:00:00	26	40
8172	2026-05-24 21:00:00	30	16.25
8179	2026-05-24 21:00:00	28	261.75
8189	2026-05-24 21:00:00	27	39.1
8209	2026-05-24 22:00:00	31	40
8215	2026-05-24 22:00:00	33	261.75
8225	2026-05-24 22:00:00	34	16.25
8233	2026-05-24 22:00:00	35	16.25
8244	2026-05-24 22:00:00	32	38.87
8256	2026-05-24 23:00:00	31	40
8269	2026-05-24 23:00:00	33	261.75
8279	2026-05-24 23:00:00	34	16.25
8290	2026-05-24 23:00:00	35	16.25
8297	2026-05-24 23:00:00	32	38.87
7555	2026-05-24 09:00:00	28	261.75
7563	2026-05-24 09:00:00	27	39.1
7572	2026-05-24 09:00:00	29	16.25
7580	2026-05-24 09:00:00	26	40
7590	2026-05-24 09:00:00	30	16.25
7608	2026-05-24 10:00:00	32	39.06
7617	2026-05-24 10:00:00	31	40
7625	2026-05-24 10:00:00	33	261.75
7637	2026-05-24 10:00:00	34	16.25
7647	2026-05-24 10:00:00	35	16.25
7653	2026-05-24 11:00:00	6	12
7663	2026-05-24 11:00:00	7	24.75
7671	2026-05-24 11:00:00	10	15
7678	2026-05-24 11:00:00	9	15
7685	2026-05-24 11:00:00	8	168.6
7708	2026-05-24 12:00:00	46	92
7716	2026-05-24 12:00:00	48	430.95
7723	2026-05-24 12:00:00	49	12.25
7731	2026-05-24 12:00:00	47	66.84
7740	2026-05-24 12:00:00	50	12.25
7757	2026-05-24 13:00:00	34	40
7763	2026-05-24 13:00:00	35	40
7773	2026-05-24 13:00:00	32	34.81
7778	2026-05-24 13:00:00	31	40
7793	2026-05-24 13:00:00	33	276
7806	2026-05-24 14:00:00	29	16.25
7813	2026-05-24 14:00:00	26	40
7821	2026-05-24 14:00:00	30	16.25
7833	2026-05-24 14:00:00	28	261.75
7844	2026-05-24 14:00:00	27	38.91
7857	2026-05-24 15:00:00	34	15
7862	2026-05-24 15:00:00	35	15
7871	2026-05-24 15:00:00	32	39.08
7877	2026-05-24 15:00:00	31	40
7885	2026-05-24 15:00:00	33	261
7910	2026-05-24 16:00:00	42	40.08
7921	2026-05-24 16:00:00	43	258.3
7934	2026-05-24 16:00:00	44	10.5
7944	2026-05-24 16:00:00	45	10.5
7950	2026-05-24 16:00:00	41	40
7951	2026-05-24 17:00:00	4	15
7962	2026-05-24 17:00:00	1	12
7974	2026-05-24 17:00:00	3	168.6
7984	2026-05-24 17:00:00	2	25
7993	2026-05-24 17:00:00	5	15
8007	2026-05-24 18:00:00	40	10.75
8017	2026-05-24 18:00:00	37	39.83
8030	2026-05-24 18:00:00	38	258.45
8041	2026-05-24 18:00:00	36	40
8050	2026-05-24 18:00:00	39	10.75
8055	2026-05-24 19:00:00	7	24.84
8062	2026-05-24 19:00:00	10	15
8071	2026-05-24 19:00:00	9	15
8077	2026-05-24 19:00:00	8	168.6
8084	2026-05-24 19:00:00	6	12
8110	2026-05-24 20:00:00	49	12.25
8118	2026-05-24 20:00:00	47	39.78
8130	2026-05-24 20:00:00	50	12.25
8139	2026-05-24 20:00:00	46	40
8142	2026-05-24 20:00:00	48	259.35
8156	2026-05-24 21:00:00	33	261.75
8167	2026-05-24 21:00:00	34	16.25
8175	2026-05-24 21:00:00	35	16.25
8188	2026-05-24 21:00:00	32	38.94
8196	2026-05-24 21:00:00	31	40
8205	2026-05-24 22:00:00	24	10
8219	2026-05-24 22:00:00	23	258
8234	2026-05-24 22:00:00	25	10
8241	2026-05-24 22:00:00	22	40.03
8248	2026-05-24 22:00:00	21	40
8253	2026-05-24 23:00:00	13	258
8262	2026-05-24 23:00:00	12	55.2
8271	2026-05-24 23:00:00	11	40
8276	2026-05-24 23:00:00	15	10
8288	2026-05-24 23:00:00	14	10
7558	2026-05-24 09:00:00	32	38.87
7559	2026-05-24 09:00:00	41	40
7564	2026-05-24 09:00:00	31	40
7568	2026-05-24 09:00:00	42	39.95
7575	2026-05-24 09:00:00	43	258.3
7576	2026-05-24 09:00:00	33	261.75
7584	2026-05-24 09:00:00	44	10.5
7585	2026-05-24 09:00:00	34	16.25
7592	2026-05-24 09:00:00	35	16.25
7594	2026-05-24 09:00:00	45	10.5
7606	2026-05-24 10:00:00	28	261.6
7609	2026-05-24 10:00:00	41	40
7615	2026-05-24 10:00:00	42	39.88
7620	2026-05-24 10:00:00	27	39.02
7623	2026-05-24 10:00:00	43	258.3
7632	2026-05-24 10:00:00	44	10.5
7633	2026-05-24 10:00:00	29	16
7643	2026-05-24 10:00:00	45	10.5
7644	2026-05-24 10:00:00	26	40
7650	2026-05-24 10:00:00	30	16
7651	2026-05-24 11:00:00	2	24.9
7660	2026-05-24 11:00:00	39	10.5
7661	2026-05-24 11:00:00	5	15
7664	2026-05-24 11:00:00	40	10.5
7670	2026-05-24 11:00:00	4	15
7672	2026-05-24 11:00:00	37	40.08
7679	2026-05-24 11:00:00	1	12
7683	2026-05-24 11:00:00	38	258.3
7686	2026-05-24 11:00:00	3	168.6
7689	2026-05-24 11:00:00	36	40
7709	2026-05-24 12:00:00	31	92
7712	2026-05-24 12:00:00	37	67.28
7721	2026-05-24 12:00:00	33	433.35
7725	2026-05-24 12:00:00	38	429.9
7735	2026-05-24 12:00:00	34	16.25
7739	2026-05-24 12:00:00	36	92
7744	2026-05-24 12:00:00	35	16.25
7746	2026-05-24 12:00:00	39	10.5
7749	2026-05-24 12:00:00	40	10.5
7750	2026-05-24 12:00:00	32	65.5
7751	2026-05-24 13:00:00	6	12
7752	2026-05-24 13:00:00	5	15
7764	2026-05-24 13:00:00	4	15
7766	2026-05-24 13:00:00	7	24.79
7774	2026-05-24 13:00:00	1	12
7776	2026-05-24 13:00:00	10	15
7784	2026-05-24 13:00:00	3	168.6
7785	2026-05-24 13:00:00	9	15
7790	2026-05-24 13:00:00	8	168.6
7796	2026-05-24 13:00:00	2	24.79
7805	2026-05-24 14:00:00	25	33.75
7810	2026-05-24 14:00:00	37	39.99
7817	2026-05-24 14:00:00	38	258.3
7820	2026-05-24 14:00:00	22	36
7825	2026-05-24 14:00:00	36	40
7829	2026-05-24 14:00:00	21	40
7834	2026-05-24 14:00:00	24	33.75
7836	2026-05-24 14:00:00	39	10.5
7843	2026-05-24 14:00:00	23	272.25
7845	2026-05-24 14:00:00	40	10.5
7854	2026-05-24 15:00:00	29	16.25
7860	2026-05-24 15:00:00	37	40.03
7867	2026-05-24 15:00:00	26	40
7872	2026-05-24 15:00:00	38	258.3
7878	2026-05-24 15:00:00	30	16.25
7886	2026-05-24 15:00:00	36	40
7892	2026-05-24 15:00:00	28	261.75
7895	2026-05-24 15:00:00	39	10.5
7898	2026-05-24 15:00:00	27	38.91
7900	2026-05-24 15:00:00	40	10.5
7901	2026-05-24 16:00:00	3	168.6
7903	2026-05-24 16:00:00	12	54.99
7912	2026-05-24 16:00:00	11	40
7915	2026-05-24 16:00:00	2	24.98
7920	2026-05-24 16:00:00	15	10
7926	2026-05-24 16:00:00	14	10
7927	2026-05-24 16:00:00	5	15
7932	2026-05-24 16:00:00	13	258
7940	2026-05-24 16:00:00	4	15
7948	2026-05-24 16:00:00	1	12
7957	2026-05-24 17:00:00	12	55.19
7960	2026-05-24 17:00:00	44	10.75
7965	2026-05-24 17:00:00	11	40
7970	2026-05-24 17:00:00	45	10.75
7977	2026-05-24 17:00:00	15	10
7982	2026-05-24 17:00:00	41	40
7988	2026-05-24 17:00:00	14	10
7992	2026-05-24 17:00:00	42	39.91
7997	2026-05-24 17:00:00	13	258
8000	2026-05-24 17:00:00	43	258.45
8001	2026-05-24 18:00:00	4	15
8004	2026-05-24 18:00:00	17	35.15
8011	2026-05-24 18:00:00	19	38.75
8013	2026-05-24 18:00:00	1	12
8021	2026-05-24 18:00:00	18	275.25
8023	2026-05-24 18:00:00	3	168.6
8024	2026-05-24 18:00:00	20	38.75
8033	2026-05-24 18:00:00	2	24.75
8035	2026-05-24 18:00:00	16	40
8044	2026-05-24 18:00:00	5	15
8057	2026-05-24 19:00:00	48	259.2
8058	2026-05-24 19:00:00	34	15
8066	2026-05-24 19:00:00	49	12
8067	2026-05-24 19:00:00	35	15
8075	2026-05-24 19:00:00	47	39.88
8080	2026-05-24 19:00:00	32	39.33
8085	2026-05-24 19:00:00	50	12
8088	2026-05-24 19:00:00	46	40
8091	2026-05-24 19:00:00	31	40
8099	2026-05-24 19:00:00	33	261
8102	2026-05-24 20:00:00	9	15
8108	2026-05-24 20:00:00	45	10.75
8112	2026-05-24 20:00:00	8	168.6
8121	2026-05-24 20:00:00	41	40
8122	2026-05-24 20:00:00	6	12
8133	2026-05-24 20:00:00	7	24.85
8136	2026-05-24 20:00:00	42	40.03
8145	2026-05-24 20:00:00	10	15
8147	2026-05-24 20:00:00	43	258.45
8149	2026-05-24 20:00:00	44	10.75
8152	2026-05-24 21:00:00	7	24.92
8154	2026-05-24 21:00:00	16	40
8166	2026-05-24 21:00:00	17	35.14
8168	2026-05-24 21:00:00	10	15
8174	2026-05-24 21:00:00	19	38.5
8181	2026-05-24 21:00:00	18	275.1
8183	2026-05-24 21:00:00	9	15
8185	2026-05-24 21:00:00	20	38.5
8194	2026-05-24 21:00:00	8	168.6
8200	2026-05-24 21:00:00	6	12
8203	2026-05-24 22:00:00	6	12
8204	2026-05-24 22:00:00	41	40
8218	2026-05-24 22:00:00	7	24.88
8220	2026-05-24 22:00:00	42	40
8226	2026-05-24 22:00:00	10	15
8235	2026-05-24 22:00:00	43	258.45
7556	2026-05-24 09:00:00	21	40
7565	2026-05-24 09:00:00	24	10
7577	2026-05-24 09:00:00	23	258
7586	2026-05-24 09:00:00	25	10
7596	2026-05-24 09:00:00	22	39.99
7604	2026-05-24 10:00:00	19	39
7612	2026-05-24 10:00:00	18	275.4
7622	2026-05-24 10:00:00	20	39
7628	2026-05-24 10:00:00	16	40
7635	2026-05-24 10:00:00	17	35.15
7657	2026-05-24 11:00:00	47	39.63
7666	2026-05-24 11:00:00	50	12
7674	2026-05-24 11:00:00	46	40
7682	2026-05-24 11:00:00	48	259.2
7688	2026-05-24 11:00:00	49	12
7707	2026-05-24 12:00:00	42	67.33
7715	2026-05-24 12:00:00	43	429.9
7722	2026-05-24 12:00:00	44	10.5
7730	2026-05-24 12:00:00	45	10.5
7736	2026-05-24 12:00:00	41	92
7759	2026-05-24 13:00:00	38	273.15
7768	2026-05-24 13:00:00	36	40
7781	2026-05-24 13:00:00	39	35.25
7787	2026-05-24 13:00:00	40	35.25
7797	2026-05-24 13:00:00	37	35.68
7804	2026-05-24 14:00:00	16	40
7819	2026-05-24 14:00:00	17	35.12
7832	2026-05-24 14:00:00	19	38.75
7842	2026-05-24 14:00:00	18	275.25
7850	2026-05-24 14:00:00	20	38.75
7852	2026-05-24 15:00:00	7	24.94
7869	2026-05-24 15:00:00	10	15
7883	2026-05-24 15:00:00	9	15
7891	2026-05-24 15:00:00	8	168.6
7897	2026-05-24 15:00:00	6	12
7904	2026-05-24 16:00:00	22	35.81
7916	2026-05-24 16:00:00	21	40
7923	2026-05-24 16:00:00	24	33.75
7928	2026-05-24 16:00:00	23	272.25
7935	2026-05-24 16:00:00	25	33.75
7959	2026-05-24 17:00:00	50	12
7971	2026-05-24 17:00:00	46	40
7981	2026-05-24 17:00:00	48	259.2
7991	2026-05-24 17:00:00	49	12
7999	2026-05-24 17:00:00	47	39.7
8002	2026-05-24 18:00:00	6	12
8015	2026-05-24 18:00:00	7	24.82
8028	2026-05-24 18:00:00	10	15
8036	2026-05-24 18:00:00	9	15
8047	2026-05-24 18:00:00	8	168.6
8053	2026-05-24 19:00:00	12	54.97
8068	2026-05-24 19:00:00	11	40
8079	2026-05-24 19:00:00	15	10
8092	2026-05-24 19:00:00	14	10
8100	2026-05-24 19:00:00	13	258
8101	2026-05-24 20:00:00	1	12
8111	2026-05-24 20:00:00	3	168.6
8119	2026-05-24 20:00:00	2	24.98
8127	2026-05-24 20:00:00	5	15
8134	2026-05-24 20:00:00	4	15
8159	2026-05-24 21:00:00	46	40
8163	2026-05-24 21:00:00	48	259.35
8171	2026-05-24 21:00:00	49	12.25
8178	2026-05-24 21:00:00	47	39.82
8186	2026-05-24 21:00:00	50	12.25
8208	2026-05-24 22:00:00	46	40
8213	2026-05-24 22:00:00	48	259.35
8223	2026-05-24 22:00:00	49	12.25
8231	2026-05-24 22:00:00	47	39.75
8238	2026-05-24 22:00:00	50	12.25
8258	2026-05-24 23:00:00	46	40
8270	2026-05-24 23:00:00	48	259.2
8283	2026-05-24 23:00:00	49	12
8293	2026-05-24 23:00:00	47	39.87
8300	2026-05-24 23:00:00	50	12
7560	2026-05-24 09:00:00	47	39.72
7566	2026-05-24 09:00:00	50	12.25
7579	2026-05-24 09:00:00	46	40
7587	2026-05-24 09:00:00	48	259.35
7595	2026-05-24 09:00:00	49	12.25
7607	2026-05-24 10:00:00	39	10.5
7618	2026-05-24 10:00:00	40	10.5
7626	2026-05-24 10:00:00	37	39.94
7638	2026-05-24 10:00:00	38	258.3
7648	2026-05-24 10:00:00	36	40
7652	2026-05-24 11:00:00	14	10
7662	2026-05-24 11:00:00	13	258
7677	2026-05-24 11:00:00	12	55.12
7691	2026-05-24 11:00:00	11	40
7698	2026-05-24 11:00:00	15	10
7703	2026-05-24 12:00:00	12	82.43
7717	2026-05-24 12:00:00	11	92
7724	2026-05-24 12:00:00	15	10
7737	2026-05-24 12:00:00	14	10
7743	2026-05-24 12:00:00	13	429.6
7756	2026-05-24 13:00:00	29	16.25
7762	2026-05-24 13:00:00	26	40
7772	2026-05-24 13:00:00	30	16.25
7779	2026-05-24 13:00:00	28	261.75
7792	2026-05-24 13:00:00	27	38.86
7807	2026-05-24 14:00:00	34	15
7816	2026-05-24 14:00:00	35	15
7824	2026-05-24 14:00:00	32	39.07
7841	2026-05-24 14:00:00	31	40
7849	2026-05-24 14:00:00	33	261
7851	2026-05-24 15:00:00	4	15
7863	2026-05-24 15:00:00	1	12
7879	2026-05-24 15:00:00	3	168.6
7893	2026-05-24 15:00:00	2	24.76
7899	2026-05-24 15:00:00	5	15
7902	2026-05-24 16:00:00	10	15
7911	2026-05-24 16:00:00	9	15
7922	2026-05-24 16:00:00	8	168.6
7933	2026-05-24 16:00:00	6	12
7943	2026-05-24 16:00:00	7	24.77
7956	2026-05-24 17:00:00	34	15
7966	2026-05-24 17:00:00	35	15
7976	2026-05-24 17:00:00	32	39.3
7989	2026-05-24 17:00:00	31	40
7996	2026-05-24 17:00:00	33	261
8006	2026-05-24 18:00:00	29	16.25
8012	2026-05-24 18:00:00	26	40
8022	2026-05-24 18:00:00	30	16.25
8025	2026-05-24 18:00:00	28	261.75
8039	2026-05-24 18:00:00	27	39.07
8059	2026-05-24 19:00:00	43	258.45
8063	2026-05-24 19:00:00	44	10.75
8072	2026-05-24 19:00:00	45	10.75
8086	2026-05-24 19:00:00	41	40
8096	2026-05-24 19:00:00	42	40.09
8107	2026-05-24 20:00:00	25	10
8115	2026-05-24 20:00:00	22	40.01
8125	2026-05-24 20:00:00	21	40
8129	2026-05-24 20:00:00	24	10
8138	2026-05-24 20:00:00	23	258
8158	2026-05-24 21:00:00	42	39.97
8170	2026-05-24 21:00:00	43	258.6
8182	2026-05-24 21:00:00	44	11
8193	2026-05-24 21:00:00	45	11
8198	2026-05-24 21:00:00	41	40
8207	2026-05-24 22:00:00	16	40
8212	2026-05-24 22:00:00	17	35
8222	2026-05-24 22:00:00	19	38.5
8230	2026-05-24 22:00:00	18	275.1
8237	2026-05-24 22:00:00	20	38.5
8245	2026-05-24 22:00:00	44	10.75
8249	2026-05-24 22:00:00	45	10.75
8251	2026-05-24 23:00:00	4	15
8260	2026-05-24 23:00:00	40	10.5
8261	2026-05-24 23:00:00	1	12
8268	2026-05-24 23:00:00	37	40.1
8275	2026-05-24 23:00:00	3	168.6
8281	2026-05-24 23:00:00	38	258.3
8285	2026-05-24 23:00:00	2	24.75
8289	2026-05-24 23:00:00	36	40
8296	2026-05-24 23:00:00	5	15
8298	2026-05-24 23:00:00	39	10.5
7562	2026-05-24 09:00:00	5	15
7573	2026-05-24 09:00:00	4	15
7588	2026-05-24 09:00:00	1	12
7599	2026-05-24 09:00:00	3	168.6
7601	2026-05-24 10:00:00	3	168.6
7613	2026-05-24 10:00:00	2	25.01
7630	2026-05-24 10:00:00	5	15
7639	2026-05-24 10:00:00	4	15
7645	2026-05-24 10:00:00	1	12
7654	2026-05-24 11:00:00	28	261.6
7665	2026-05-24 11:00:00	27	39.06
7675	2026-05-24 11:00:00	29	16
7687	2026-05-24 11:00:00	26	40
7695	2026-05-24 11:00:00	30	16
7706	2026-05-24 12:00:00	29	16.25
7711	2026-05-24 12:00:00	26	92
7720	2026-05-24 12:00:00	30	16.25
7727	2026-05-24 12:00:00	28	433.35
7734	2026-05-24 12:00:00	27	65.6
7758	2026-05-24 13:00:00	41	40
7770	2026-05-24 13:00:00	42	35.55
7783	2026-05-24 13:00:00	43	273.15
7794	2026-05-24 13:00:00	44	35.25
7799	2026-05-24 13:00:00	45	35.25
7802	2026-05-24 14:00:00	6	12
7812	2026-05-24 14:00:00	7	25
7828	2026-05-24 14:00:00	10	15
7830	2026-05-24 14:00:00	9	15
7837	2026-05-24 14:00:00	8	168.6
7858	2026-05-24 15:00:00	45	10.5
7864	2026-05-24 15:00:00	41	40
7873	2026-05-24 15:00:00	42	40.12
7880	2026-05-24 15:00:00	43	258.3
7888	2026-05-24 15:00:00	44	10.5
7909	2026-05-24 16:00:00	38	258.3
7918	2026-05-24 16:00:00	36	40
7930	2026-05-24 16:00:00	39	10.5
7939	2026-05-24 16:00:00	40	10.5
7947	2026-05-24 16:00:00	37	39.92
7954	2026-05-24 17:00:00	17	35.05
7963	2026-05-24 17:00:00	19	38.5
7972	2026-05-24 17:00:00	18	275.1
7985	2026-05-24 17:00:00	20	38.5
7994	2026-05-24 17:00:00	16	40
8008	2026-05-24 18:00:00	34	15
8019	2026-05-24 18:00:00	35	15
8031	2026-05-24 18:00:00	32	39.24
8040	2026-05-24 18:00:00	31	40
8048	2026-05-24 18:00:00	33	261
8052	2026-05-24 19:00:00	22	40.08
8064	2026-05-24 19:00:00	21	40
8073	2026-05-24 19:00:00	24	10
8083	2026-05-24 19:00:00	23	258
8095	2026-05-24 19:00:00	25	10
8106	2026-05-24 20:00:00	30	16.25
8117	2026-05-24 20:00:00	28	261.75
8128	2026-05-24 20:00:00	27	39
8141	2026-05-24 20:00:00	29	16.25
8148	2026-05-24 20:00:00	26	40
8155	2026-05-24 21:00:00	13	258
8165	2026-05-24 21:00:00	12	55.12
8173	2026-05-24 21:00:00	11	40
8180	2026-05-24 21:00:00	15	10
8190	2026-05-24 21:00:00	14	10
8210	2026-05-24 22:00:00	40	10.5
8214	2026-05-24 22:00:00	37	39.86
8224	2026-05-24 22:00:00	38	258.3
8232	2026-05-24 22:00:00	36	40
8243	2026-05-24 22:00:00	39	10.5
8254	2026-05-24 23:00:00	29	16.25
8266	2026-05-24 23:00:00	26	40
8280	2026-05-24 23:00:00	30	16.25
8292	2026-05-24 23:00:00	28	261.75
8299	2026-05-24 23:00:00	27	39.13
7557	2026-05-24 09:00:00	39	10.5
7561	2026-05-24 09:00:00	40	10.5
7571	2026-05-24 09:00:00	37	39.99
7574	2026-05-24 09:00:00	38	258.3
7583	2026-05-24 09:00:00	36	40
7610	2026-05-24 10:00:00	47	39.64
7616	2026-05-24 10:00:00	50	12
7624	2026-05-24 10:00:00	46	40
7634	2026-05-24 10:00:00	48	259.2
7642	2026-05-24 10:00:00	49	12
7658	2026-05-24 11:00:00	32	38.89
7669	2026-05-24 11:00:00	31	40
7681	2026-05-24 11:00:00	33	261.75
7692	2026-05-24 11:00:00	34	16.25
7696	2026-05-24 11:00:00	35	16.25
7705	2026-05-24 12:00:00	18	446.85
7718	2026-05-24 12:00:00	20	38.75
7732	2026-05-24 12:00:00	16	92
7742	2026-05-24 12:00:00	17	58.53
7748	2026-05-24 12:00:00	19	38.75
7753	2026-05-24 13:00:00	14	10
7765	2026-05-24 13:00:00	13	258
7777	2026-05-24 13:00:00	12	55.12
7789	2026-05-24 13:00:00	11	40
7798	2026-05-24 13:00:00	15	10
7803	2026-05-24 14:00:00	14	10
7815	2026-05-24 14:00:00	13	258
7823	2026-05-24 14:00:00	12	54.94
7835	2026-05-24 14:00:00	11	40
7846	2026-05-24 14:00:00	15	10
7856	2026-05-24 15:00:00	14	10
7866	2026-05-24 15:00:00	13	258
7875	2026-05-24 15:00:00	12	55.05
7887	2026-05-24 15:00:00	11	40
7896	2026-05-24 15:00:00	15	10
7905	2026-05-24 16:00:00	18	269.55
7914	2026-05-24 16:00:00	20	29.25
7924	2026-05-24 16:00:00	16	40
7937	2026-05-24 16:00:00	17	36.85
7945	2026-05-24 16:00:00	19	29.25
7955	2026-05-24 17:00:00	22	40.1
7964	2026-05-24 17:00:00	21	40
7973	2026-05-24 17:00:00	24	10
7979	2026-05-24 17:00:00	23	258
7986	2026-05-24 17:00:00	25	10
8010	2026-05-24 18:00:00	48	259.35
8020	2026-05-24 18:00:00	49	12.25
8032	2026-05-24 18:00:00	47	39.78
8042	2026-05-24 18:00:00	50	12.25
8049	2026-05-24 18:00:00	46	40
8051	2026-05-24 19:00:00	4	15
8061	2026-05-24 19:00:00	1	12
8076	2026-05-24 19:00:00	3	168.6
8087	2026-05-24 19:00:00	2	24.85
8093	2026-05-24 19:00:00	5	15
8109	2026-05-24 20:00:00	37	39.91
8120	2026-05-24 20:00:00	38	258.3
8137	2026-05-24 20:00:00	36	40
8146	2026-05-24 20:00:00	39	10.5
8150	2026-05-24 20:00:00	40	10.5
8151	2026-05-24 21:00:00	4	15
8161	2026-05-24 21:00:00	1	12
8177	2026-05-24 21:00:00	3	168.6
8192	2026-05-24 21:00:00	2	24.9
8199	2026-05-24 21:00:00	5	15
8201	2026-05-24 22:00:00	5	15
8216	2026-05-24 22:00:00	4	15
8227	2026-05-24 22:00:00	1	12
8239	2026-05-24 22:00:00	3	168.6
8246	2026-05-24 22:00:00	2	24.85
8255	2026-05-24 23:00:00	24	10
8267	2026-05-24 23:00:00	23	258
8282	2026-05-24 23:00:00	25	10
8286	2026-05-24 23:00:00	22	40.1
8294	2026-05-24 23:00:00	21	40
7567	2026-05-24 09:00:00	12	55.2
7578	2026-05-24 09:00:00	11	40
7589	2026-05-24 09:00:00	15	10
7598	2026-05-24 09:00:00	14	10
7605	2026-05-24 10:00:00	14	10
7619	2026-05-24 10:00:00	13	258
7629	2026-05-24 10:00:00	12	55.05
7640	2026-05-24 10:00:00	11	40
7646	2026-05-24 10:00:00	15	10
7656	2026-05-24 11:00:00	24	10
7667	2026-05-24 11:00:00	23	258
7676	2026-05-24 11:00:00	25	10
7690	2026-05-24 11:00:00	22	40.09
7697	2026-05-24 11:00:00	21	40
7704	2026-05-24 12:00:00	25	10
7710	2026-05-24 12:00:00	22	67.44
7719	2026-05-24 12:00:00	21	92
7726	2026-05-24 12:00:00	24	10
7733	2026-05-24 12:00:00	23	429.6
7760	2026-05-24 13:00:00	50	36
7769	2026-05-24 13:00:00	46	40
7782	2026-05-24 13:00:00	48	273.6
7795	2026-05-24 13:00:00	49	36
7800	2026-05-24 13:00:00	47	35.56
7801	2026-05-24 14:00:00	5	15
7811	2026-05-24 14:00:00	4	15
7827	2026-05-24 14:00:00	1	12
7839	2026-05-24 14:00:00	3	168.6
7847	2026-05-24 14:00:00	2	24.75
7855	2026-05-24 15:00:00	25	33.75
7868	2026-05-24 15:00:00	22	35.84
7882	2026-05-24 15:00:00	21	40
7890	2026-05-24 15:00:00	24	33.75
7894	2026-05-24 15:00:00	23	272.25
7907	2026-05-24 16:00:00	30	16.25
7919	2026-05-24 16:00:00	28	261.75
7931	2026-05-24 16:00:00	27	38.87
7942	2026-05-24 16:00:00	29	16.25
7949	2026-05-24 16:00:00	26	40
7952	2026-05-24 17:00:00	6	12
7968	2026-05-24 17:00:00	7	24.81
7980	2026-05-24 17:00:00	10	15
7987	2026-05-24 17:00:00	9	15
7995	2026-05-24 17:00:00	8	168.6
8005	2026-05-24 18:00:00	22	40.12
8018	2026-05-24 18:00:00	21	40
8029	2026-05-24 18:00:00	24	10
8038	2026-05-24 18:00:00	23	258
8046	2026-05-24 18:00:00	25	10
8056	2026-05-24 19:00:00	29	16.25
8065	2026-05-24 19:00:00	26	40
8074	2026-05-24 19:00:00	30	16.25
8082	2026-05-24 19:00:00	28	261.75
8094	2026-05-24 19:00:00	27	39.08
8105	2026-05-24 20:00:00	35	15
8113	2026-05-24 20:00:00	32	39.29
8123	2026-05-24 20:00:00	31	40
8132	2026-05-24 20:00:00	33	261
8144	2026-05-24 20:00:00	34	15
8153	2026-05-24 21:00:00	23	258
8162	2026-05-24 21:00:00	25	10
8176	2026-05-24 21:00:00	22	40.13
8187	2026-05-24 21:00:00	21	40
8197	2026-05-24 21:00:00	24	10
8202	2026-05-24 22:00:00	13	258
8217	2026-05-24 22:00:00	12	55.15
8228	2026-05-24 22:00:00	11	40
8242	2026-05-24 22:00:00	15	10
8250	2026-05-24 22:00:00	14	10
8252	2026-05-24 23:00:00	8	168.6
8264	2026-05-24 23:00:00	6	12
8273	2026-05-24 23:00:00	7	24.72
8278	2026-05-24 23:00:00	10	15
8287	2026-05-24 23:00:00	9	15
8240	2026-05-24 22:00:00	9	15
8247	2026-05-24 22:00:00	8	168.6
8257	2026-05-24 23:00:00	16	40
8265	2026-05-24 23:00:00	17	35.17
8274	2026-05-24 23:00:00	19	38.75
8284	2026-05-24 23:00:00	18	275.25
8295	2026-05-24 23:00:00	20	38.75
\.


--
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.server (server_id, cluster_id, config_id, hostname, status, base_consumption_offset, created_at, is_master) FROM stdin;
1	1	1	marseille-marseille-zone-01-master-01	ON	850	2026-05-19 11:42:35.215	t
2	1	1	marseille-marseille-zone-01-master-02	ON	850	2026-05-19 11:42:35.238	t
3	1	1	marseille-marseille-zone-01-worker-01	ON	700	2026-05-19 11:42:35.253	f
4	1	1	marseille-marseille-zone-01-worker-02	ON	700	2026-05-19 11:42:35.277	f
5	1	1	marseille-marseille-zone-01-worker-03	ON	700	2026-05-19 11:42:35.299	f
6	1	1	marseille-marseille-zone-01-worker-04	ON	700	2026-05-19 11:42:35.323	f
7	1	1	marseille-marseille-zone-01-worker-05	ON	700	2026-05-19 11:42:35.346	f
8	1	1	marseille-marseille-zone-01-worker-06	ON	700	2026-05-19 11:42:35.365	f
9	1	1	marseille-marseille-zone-01-worker-07	ON	700	2026-05-19 11:42:35.384	f
10	1	1	marseille-marseille-zone-01-worker-08	ON	700	2026-05-19 11:42:35.405	f
\.


--
-- Name: chunk_column_stats_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_column_stats_id_seq', 1, false);


--
-- Name: chunk_constraint_name; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_constraint_name', 1, false);


--
-- Name: chunk_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_id_seq', 1, false);


--
-- Name: continuous_agg_migrate_plan_step_step_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_catalog.continuous_agg_migrate_plan_step_step_id_seq', 1, false);


--
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_id_seq', 1, false);


--
-- Name: dimension_slice_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_slice_id_seq', 1, false);


--
-- Name: hypertable_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_catalog.hypertable_id_seq', 1, false);


--
-- Name: bgw_job_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_config; Owner: tsuser
--

SELECT pg_catalog.setval('_timescaledb_config.bgw_job_id_seq', 1000, false);


--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.cluster_cluster_id_seq', 1, true);


--
-- Name: cluster_configuration_cluster_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.cluster_configuration_cluster_config_id_seq', 1, true);


--
-- Name: cluster_location_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.cluster_location_location_id_seq', 1, true);


--
-- Name: cpucooler_catalog_cpu_cooler_catalog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.cpucooler_catalog_cpu_cooler_catalog_id_seq', 3, true);


--
-- Name: fan_catalog_fan_catalog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.fan_catalog_fan_catalog_id_seq', 3, true);


--
-- Name: fan_configuration_fan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.fan_configuration_fan_id_seq', 1, true);


--
-- Name: fan_fan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.fan_fan_id_seq', 40, true);


--
-- Name: load_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.load_profile_id_seq', 24, true);


--
-- Name: sensor_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.sensor_data_id_seq', 8300, true);


--
-- Name: sensor_sensor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.sensor_sensor_id_seq', 50, true);


--
-- Name: server_server_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.server_server_id_seq', 10, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: cluster_configuration cluster_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_configuration
    ADD CONSTRAINT cluster_configuration_pkey PRIMARY KEY (cluster_config_id);


--
-- Name: cluster_location cluster_location_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_location
    ADD CONSTRAINT cluster_location_pkey PRIMARY KEY (location_id);


--
-- Name: cluster cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT cluster_pkey PRIMARY KEY (cluster_id);


--
-- Name: cpucooler_catalog cpucooler_catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cpucooler_catalog
    ADD CONSTRAINT cpucooler_catalog_pkey PRIMARY KEY (cpu_cooler_catalog_id);


--
-- Name: fan_catalog fan_catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan_catalog
    ADD CONSTRAINT fan_catalog_pkey PRIMARY KEY (fan_catalog_id);


--
-- Name: fan_configuration fan_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan_configuration
    ADD CONSTRAINT fan_configuration_pkey PRIMARY KEY (fan_id);


--
-- Name: fan fan_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan
    ADD CONSTRAINT fan_pkey PRIMARY KEY (fan_id);


--
-- Name: load_profile load_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.load_profile
    ADD CONSTRAINT load_profile_pkey PRIMARY KEY (id);


--
-- Name: sensor_data sensor_data_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.sensor_data
    ADD CONSTRAINT sensor_data_pkey PRIMARY KEY (id);


--
-- Name: sensor sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.sensor
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (sensor_id);


--
-- Name: server server_pkey; Type: CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_pkey PRIMARY KEY (server_id);


--
-- Name: cluster_configuration_name_key; Type: INDEX; Schema: public; Owner: tsuser
--

CREATE UNIQUE INDEX cluster_configuration_name_key ON public.cluster_configuration USING btree (name);


--
-- Name: cluster_location_name_key; Type: INDEX; Schema: public; Owner: tsuser
--

CREATE UNIQUE INDEX cluster_location_name_key ON public.cluster_location USING btree (name);


--
-- Name: cluster_name_key; Type: INDEX; Schema: public; Owner: tsuser
--

CREATE UNIQUE INDEX cluster_name_key ON public.cluster USING btree (name);


--
-- Name: cpucooler_catalog_model_name_key; Type: INDEX; Schema: public; Owner: tsuser
--

CREATE UNIQUE INDEX cpucooler_catalog_model_name_key ON public.cpucooler_catalog USING btree (model_name);


--
-- Name: fan_catalog_model_name_key; Type: INDEX; Schema: public; Owner: tsuser
--

CREATE UNIQUE INDEX fan_catalog_model_name_key ON public.fan_catalog USING btree (model_name);


--
-- Name: fan_configuration_name_key; Type: INDEX; Schema: public; Owner: tsuser
--

CREATE UNIQUE INDEX fan_configuration_name_key ON public.fan_configuration USING btree (name);


--
-- Name: load_profile_name_hour_key; Type: INDEX; Schema: public; Owner: tsuser
--

CREATE UNIQUE INDEX load_profile_name_hour_key ON public.load_profile USING btree (name, hour);


--
-- Name: cluster cluster_cluster_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT cluster_cluster_location_id_fkey FOREIGN KEY (cluster_location_id) REFERENCES public.cluster_location(location_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cluster_configuration cluster_configuration_cpu_cooler_catalog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_configuration
    ADD CONSTRAINT cluster_configuration_cpu_cooler_catalog_id_fkey FOREIGN KEY (cpu_cooler_catalog_id) REFERENCES public.cpucooler_catalog(cpu_cooler_catalog_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cluster_configuration cluster_configuration_fan_catalog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_configuration
    ADD CONSTRAINT cluster_configuration_fan_catalog_id_fkey FOREIGN KEY (fan_catalog_id) REFERENCES public.fan_catalog(fan_catalog_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cluster_configuration cluster_configuration_fan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_configuration
    ADD CONSTRAINT cluster_configuration_fan_id_fkey FOREIGN KEY (fan_id) REFERENCES public.fan_configuration(fan_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cluster_configuration cluster_configuration_load_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_configuration
    ADD CONSTRAINT cluster_configuration_load_profile_id_fkey FOREIGN KEY (load_profile_id) REFERENCES public.load_profile(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cluster_configuration cluster_configuration_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.cluster_configuration
    ADD CONSTRAINT cluster_configuration_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.cluster_location(location_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fan fan_fan_catalog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan
    ADD CONSTRAINT fan_fan_catalog_id_fkey FOREIGN KEY (fan_catalog_id) REFERENCES public.fan_catalog(fan_catalog_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fan fan_fan_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan
    ADD CONSTRAINT fan_fan_config_id_fkey FOREIGN KEY (fan_config_id) REFERENCES public.fan_configuration(fan_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fan fan_server_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.fan
    ADD CONSTRAINT fan_server_id_fkey FOREIGN KEY (server_id) REFERENCES public.server(server_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: sensor_data sensor_data_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.sensor_data
    ADD CONSTRAINT sensor_data_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES public.sensor(sensor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: sensor sensor_server_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.sensor
    ADD CONSTRAINT sensor_server_id_fkey FOREIGN KEY (server_id) REFERENCES public.server(server_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: server server_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.cluster(cluster_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: server server_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tsuser
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.cluster_configuration(cluster_config_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: tsuser
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict dPtokdGh0Rh9vL9CXUtoloEb1C2noh8KDlEY5bVB28Ec6thPp1i7S67JoOgrez9

