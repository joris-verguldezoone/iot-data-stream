--
-- PostgreSQL database dump
--

\restrict EdXbVnfnWMqan7cTsPI8Pgpv8QBSXiIfVhVebJADDjiKjCdyIGwb2JwqbNfGsPA

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
1	Marseille-Zone-01	2026-05-19 11:46:37.958	1
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
1	Marseille	Marseille Tech Hub	1.2	1	2026-05-19 11:46:37.953	0.18
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
1	1	1	1	AUTO	ON	20	2026-05-19 11:46:37.961
2	1	1	1	AUTO	ON	20	2026-05-19 11:46:37.963
3	1	1	1	AUTO	ON	20	2026-05-19 11:46:37.966
4	1	1	1	AUTO	ON	20	2026-05-19 11:46:37.967
5	2	1	1	AUTO	ON	20	2026-05-19 11:46:37.976
6	2	1	1	AUTO	ON	20	2026-05-19 11:46:37.977
7	2	1	1	AUTO	ON	20	2026-05-19 11:46:37.978
8	2	1	1	AUTO	ON	20	2026-05-19 11:46:37.979
10	3	1	1	AUTO	ON	20	2026-05-19 11:46:37.989
11	3	1	1	AUTO	ON	20	2026-05-19 11:46:37.99
12	3	1	1	AUTO	ON	20	2026-05-19 11:46:37.991
13	4	1	1	AUTO	ON	20	2026-05-19 11:46:38.005
14	4	1	1	AUTO	ON	20	2026-05-19 11:46:38.007
15	4	1	1	AUTO	ON	20	2026-05-19 11:46:38.008
16	4	1	1	AUTO	ON	20	2026-05-19 11:46:38.009
17	5	1	1	AUTO	ON	20	2026-05-19 11:46:38.018
18	5	1	1	AUTO	ON	20	2026-05-19 11:46:38.02
19	5	1	1	AUTO	ON	20	2026-05-19 11:46:38.021
20	5	1	1	AUTO	ON	20	2026-05-19 11:46:38.022
21	6	1	1	AUTO	ON	20	2026-05-19 11:46:38.034
22	6	1	1	AUTO	ON	20	2026-05-19 11:46:38.036
23	6	1	1	AUTO	ON	20	2026-05-19 11:46:38.038
24	6	1	1	AUTO	ON	20	2026-05-19 11:46:38.04
25	7	1	1	AUTO	ON	20	2026-05-19 11:46:38.056
26	7	1	1	AUTO	ON	20	2026-05-19 11:46:38.059
27	7	1	1	AUTO	ON	20	2026-05-19 11:46:38.061
28	7	1	1	AUTO	ON	20	2026-05-19 11:46:38.064
29	8	1	1	AUTO	ON	20	2026-05-19 11:46:38.074
30	8	1	1	AUTO	ON	20	2026-05-19 11:46:38.076
31	8	1	1	AUTO	ON	20	2026-05-19 11:46:38.079
32	8	1	1	AUTO	ON	20	2026-05-19 11:46:38.081
33	9	1	1	AUTO	ON	20	2026-05-19 11:46:38.095
34	9	1	1	AUTO	ON	20	2026-05-19 11:46:38.097
35	9	1	1	AUTO	ON	20	2026-05-19 11:46:38.1
36	9	1	1	AUTO	ON	20	2026-05-19 11:46:38.101
37	10	1	1	AUTO	ON	20	2026-05-19 11:46:38.113
38	10	1	1	AUTO	ON	20	2026-05-19 11:46:38.116
39	10	1	1	AUTO	ON	20	2026-05-19 11:46:38.118
40	10	1	1	AUTO	ON	20	2026-05-19 11:46:38.12
9	3	1	1	MANUAL	ON	0	2026-05-19 11:46:37.988
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
35	7	FAN_SPEED_2	%	20	2026-05-19 11:46:38.071
31	7	LOAD	%	38.04	2026-05-19 11:46:38.065
33	7	TOTAL_POWER	W	257.53	2026-05-19 11:46:38.069
39	8	FAN_SPEED_1	%	20	2026-05-19 11:46:38.089
36	8	LOAD	%	38.04	2026-05-19 11:46:38.083
38	8	TOTAL_POWER	W	257.53	2026-05-19 11:46:38.087
40	8	FAN_SPEED_2	%	20	2026-05-19 11:46:38.091
37	8	CPU_TEMP	°C	39.52	2026-05-19 11:46:38.085
43	9	TOTAL_POWER	W	257.53	2026-05-19 11:46:38.106
45	9	FAN_SPEED_2	%	20	2026-05-19 11:46:38.109
42	9	CPU_TEMP	°C	39.52	2026-05-19 11:46:38.105
44	9	FAN_SPEED_1	%	20	2026-05-19 11:46:38.108
41	9	LOAD	%	38.04	2026-05-19 11:46:38.103
47	10	CPU_TEMP	°C	39.52	2026-05-19 11:46:38.126
48	10	TOTAL_POWER	W	257.53	2026-05-19 11:46:38.128
49	10	FAN_SPEED_1	%	20	2026-05-19 11:46:38.13
46	10	LOAD	%	38.04	2026-05-19 11:46:38.123
50	10	FAN_SPEED_2	%	20	2026-05-19 11:46:38.131
4	1	FAN_SPEED_1	%	20	2026-05-19 11:46:37.972
2	1	CPU_TEMP	°C	26.5	2026-05-19 11:46:37.97
5	1	FAN_SPEED_2	%	20	2026-05-19 11:46:37.973
1	1	LOAD	%	12	2026-05-19 11:46:37.968
3	1	TOTAL_POWER	W	171.6	2026-05-19 11:46:37.971
10	2	FAN_SPEED_2	%	20	2026-05-19 11:46:37.985
9	2	FAN_SPEED_1	%	20	2026-05-19 11:46:37.984
8	2	TOTAL_POWER	W	171.6	2026-05-19 11:46:37.983
7	2	CPU_TEMP	°C	26.5	2026-05-19 11:46:37.982
6	2	LOAD	%	12	2026-05-19 11:46:37.98
13	3	TOTAL_POWER	W	254.53	2026-05-19 11:46:37.997
14	3	FAN_SPEED_1	%	15	2026-05-19 11:46:37.999
11	3	LOAD	%	38.04	2026-05-19 11:46:37.993
15	3	FAN_SPEED_2	%	15	2026-05-19 11:46:38
12	3	CPU_TEMP	°C	55.37	2026-05-19 11:46:37.994
20	4	FAN_SPEED_2	%	20	2026-05-19 11:46:38.016
16	4	LOAD	%	38.04	2026-05-19 11:46:38.011
19	4	FAN_SPEED_1	%	20	2026-05-19 11:46:38.015
18	4	TOTAL_POWER	W	257.53	2026-05-19 11:46:38.013
17	4	CPU_TEMP	°C	39.52	2026-05-19 11:46:38.012
23	5	TOTAL_POWER	W	257.53	2026-05-19 11:46:38.026
21	5	LOAD	%	38.04	2026-05-19 11:46:38.024
24	5	FAN_SPEED_1	%	20	2026-05-19 11:46:38.028
25	5	FAN_SPEED_2	%	20	2026-05-19 11:46:38.029
22	5	CPU_TEMP	°C	39.52	2026-05-19 11:46:38.025
26	6	LOAD	%	38.04	2026-05-19 11:46:38.042
27	6	CPU_TEMP	°C	39.52	2026-05-19 11:46:38.045
28	6	TOTAL_POWER	W	257.53	2026-05-19 11:46:38.048
29	6	FAN_SPEED_1	%	20	2026-05-19 11:46:38.05
30	6	FAN_SPEED_2	%	20	2026-05-19 11:46:38.053
32	7	CPU_TEMP	°C	39.52	2026-05-19 11:46:38.067
34	7	FAN_SPEED_1	%	20	2026-05-19 11:46:38.07
\.


--
-- Data for Name: sensor_data; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.sensor_data (id, "time", sensor_id, value) FROM stdin;
1	2026-05-18 00:00:00	26	20
3	2026-05-18 00:00:00	21	20
2	2026-05-18 00:00:00	6	12
4	2026-05-18 00:00:00	11	20
5	2026-05-18 00:00:00	36	20
6	2026-05-18 00:00:00	1	12
7	2026-05-18 00:00:00	22	28.19
8	2026-05-18 00:00:00	31	20
9	2026-05-18 00:00:00	46	20
10	2026-05-18 00:00:00	37	28.34
11	2026-05-18 00:00:00	12	28.39
12	2026-05-18 00:00:00	7	24.42
13	2026-05-18 00:00:00	27	28.3
14	2026-05-18 00:00:00	2	24.24
15	2026-05-18 00:00:00	16	20
16	2026-05-18 00:00:00	23	198
17	2026-05-18 00:00:00	47	28.48
18	2026-05-18 00:00:00	41	20
19	2026-05-18 00:00:00	38	198
20	2026-05-18 00:00:00	8	171.6
21	2026-05-18 00:00:00	13	198
22	2026-05-18 00:00:00	3	171.6
23	2026-05-18 00:00:00	28	198
24	2026-05-18 00:00:00	32	28.38
25	2026-05-18 00:00:00	17	28.36
26	2026-05-18 00:00:00	24	20
27	2026-05-18 00:00:00	39	20
28	2026-05-18 00:00:00	48	198
29	2026-05-18 00:00:00	29	20
30	2026-05-18 00:00:00	33	198
31	2026-05-18 00:00:00	9	20
32	2026-05-18 00:00:00	14	20
33	2026-05-18 00:00:00	42	28.42
34	2026-05-18 00:00:00	4	20
35	2026-05-18 00:00:00	25	20
36	2026-05-18 00:00:00	40	20
37	2026-05-18 00:00:00	18	198
38	2026-05-18 00:00:00	49	20
39	2026-05-18 00:00:00	30	20
40	2026-05-18 00:00:00	10	20
41	2026-05-18 00:00:00	34	20
42	2026-05-18 00:00:00	15	20
43	2026-05-18 00:00:00	43	198
44	2026-05-18 00:00:00	5	20
45	2026-05-18 00:00:00	35	20
46	2026-05-18 00:00:00	50	20
47	2026-05-18 00:00:00	19	20
48	2026-05-18 00:00:00	44	20
49	2026-05-18 00:00:00	45	20
50	2026-05-18 00:00:00	20	20
51	2026-05-18 02:00:00	1	12
53	2026-05-18 02:00:00	17	28.25
52	2026-05-18 02:00:00	9	20
54	2026-05-18 02:00:00	11	20
55	2026-05-18 02:00:00	28	198
56	2026-05-18 02:00:00	24	20
57	2026-05-18 02:00:00	32	28.44
58	2026-05-18 02:00:00	41	20
59	2026-05-18 02:00:00	46	20
60	2026-05-18 02:00:00	39	20
61	2026-05-18 02:00:00	21	20
62	2026-05-18 02:00:00	6	12
63	2026-05-18 02:00:00	33	198
64	2026-05-18 02:00:00	2	24.31
65	2026-05-18 02:00:00	14	20
66	2026-05-18 02:00:00	29	20
67	2026-05-18 02:00:00	36	20
68	2026-05-18 02:00:00	47	28.47
69	2026-05-18 02:00:00	16	20
70	2026-05-18 02:00:00	42	28.47
71	2026-05-18 02:00:00	22	28.38
72	2026-05-18 02:00:00	7	24.39
73	2026-05-18 02:00:00	31	20
74	2026-05-18 02:00:00	23	198
75	2026-05-18 02:00:00	37	28.4
76	2026-05-18 02:00:00	48	198
77	2026-05-18 02:00:00	12	28.4
78	2026-05-18 02:00:00	26	20
79	2026-05-18 02:00:00	4	20
80	2026-05-18 02:00:00	34	20
81	2026-05-18 02:00:00	18	198
82	2026-05-18 02:00:00	43	198
83	2026-05-18 02:00:00	8	171.6
84	2026-05-18 02:00:00	25	20
85	2026-05-18 02:00:00	49	20
86	2026-05-18 02:00:00	38	198
87	2026-05-18 02:00:00	10	20
88	2026-05-18 02:00:00	35	20
89	2026-05-18 02:00:00	44	20
90	2026-05-18 02:00:00	13	198
91	2026-05-18 02:00:00	27	28.42
92	2026-05-18 02:00:00	19	20
93	2026-05-18 02:00:00	5	20
94	2026-05-18 02:00:00	40	20
95	2026-05-18 02:00:00	50	20
96	2026-05-18 02:00:00	15	20
97	2026-05-18 02:00:00	30	20
98	2026-05-18 02:00:00	45	20
99	2026-05-18 02:00:00	3	171.6
100	2026-05-18 02:00:00	20	20
101	2026-05-18 03:00:00	9	20
102	2026-05-18 03:00:00	3	171.6
103	2026-05-18 03:00:00	15	20
104	2026-05-18 03:00:00	17	28.4
105	2026-05-18 03:00:00	24	20
106	2026-05-18 03:00:00	30	20
107	2026-05-18 03:00:00	32	28.21
108	2026-05-18 03:00:00	41	20
109	2026-05-18 03:00:00	39	20
110	2026-05-18 03:00:00	46	20
111	2026-05-18 03:00:00	20	20
112	2026-05-18 03:00:00	42	28.26
113	2026-05-18 03:00:00	6	12
114	2026-05-18 03:00:00	14	20
115	2026-05-18 03:00:00	2	24.44
116	2026-05-18 03:00:00	21	20
117	2026-05-18 03:00:00	36	20
118	2026-05-18 03:00:00	33	198
119	2026-05-18 03:00:00	28	198
120	2026-05-18 03:00:00	16	20
121	2026-05-18 03:00:00	47	28.37
122	2026-05-18 03:00:00	43	198
123	2026-05-18 03:00:00	7	24.31
124	2026-05-18 03:00:00	18	198
125	2026-05-18 03:00:00	22	28.29
126	2026-05-18 03:00:00	12	28.31
127	2026-05-18 03:00:00	4	20
128	2026-05-18 03:00:00	37	28.28
129	2026-05-18 03:00:00	31	20
130	2026-05-18 03:00:00	29	20
131	2026-05-18 03:00:00	19	20
132	2026-05-18 03:00:00	8	171.6
133	2026-05-18 03:00:00	44	20
134	2026-05-18 03:00:00	48	198
135	2026-05-18 03:00:00	11	20
136	2026-05-18 03:00:00	26	20
137	2026-05-18 03:00:00	1	12
143	2026-05-18 03:00:00	5	20
157	2026-05-18 04:00:00	32	28.22
169	2026-05-18 04:00:00	33	198
180	2026-05-18 04:00:00	31	20
189	2026-05-18 04:00:00	34	20
197	2026-05-18 04:00:00	35	20
203	2026-05-18 05:00:00	16	20
215	2026-05-18 05:00:00	18	198
222	2026-05-18 05:00:00	19	20
236	2026-05-18 05:00:00	20	20
245	2026-05-18 05:00:00	17	28.41
1251	2026-05-19 02:00:00	10	20
1264	2026-05-19 02:00:00	6	12
1273	2026-05-19 02:00:00	9	20
1282	2026-05-19 02:00:00	7	24.47
1291	2026-05-19 02:00:00	8	171.6
1306	2026-05-19 03:00:00	34	20
1318	2026-05-19 03:00:00	35	20
1331	2026-05-19 03:00:00	33	198
1342	2026-05-19 03:00:00	32	28.45
1350	2026-05-19 03:00:00	31	20
1353	2026-05-19 04:00:00	11	20
1365	2026-05-19 04:00:00	15	20
1373	2026-05-19 04:00:00	13	198
1385	2026-05-19 04:00:00	14	20
1396	2026-05-19 04:00:00	12	28.22
1405	2026-05-19 05:00:00	21	20
1414	2026-05-19 05:00:00	22	28.37
1424	2026-05-19 05:00:00	23	198
1437	2026-05-19 05:00:00	24	20
1446	2026-05-19 05:00:00	25	20
1458	2026-05-19 06:00:00	28	198
1470	2026-05-19 06:00:00	29	20
1483	2026-05-19 06:00:00	26	20
1492	2026-05-19 06:00:00	30	20
1499	2026-05-19 06:00:00	27	28.19
1501	2026-05-19 07:00:00	1	12
1512	2026-05-19 07:00:00	4	20
1525	2026-05-19 07:00:00	5	20
1535	2026-05-19 07:00:00	3	171.6
1545	2026-05-19 07:00:00	2	24.27
1557	2026-05-19 08:00:00	35	20
1562	2026-05-19 08:00:00	33	198
1572	2026-05-19 08:00:00	32	28.28
1578	2026-05-19 08:00:00	31	20
1587	2026-05-19 08:00:00	34	20
1608	2026-05-19 09:00:00	43	198
1617	2026-05-19 09:00:00	44	20
1628	2026-05-19 09:00:00	45	20
1639	2026-05-19 09:00:00	41	20
1649	2026-05-19 09:00:00	42	28.47
1655	2026-05-19 10:00:00	18	198
1666	2026-05-19 10:00:00	20	20
1679	2026-05-19 10:00:00	17	28.2
1688	2026-05-19 10:00:00	16	20
1697	2026-05-19 10:00:00	19	20
1705	2026-05-19 11:00:00	21	20
1720	2026-05-19 11:00:00	22	28.21
1733	2026-05-19 11:00:00	23	198
1739	2026-05-19 11:00:00	24	20
1750	2026-05-19 11:00:00	25	20
2335	2026-05-19 23:00:00	18	198
2344	2026-05-19 23:00:00	20	20
2358	2026-05-20 00:00:00	47	28.49
2369	2026-05-20 00:00:00	48	198
2383	2026-05-20 00:00:00	50	20
2393	2026-05-20 00:00:00	46	20
2400	2026-05-20 00:00:00	49	20
2401	2026-05-20 01:00:00	4	20
2411	2026-05-20 01:00:00	5	20
2425	2026-05-20 01:00:00	3	171.6
2433	2026-05-20 01:00:00	2	24.38
2441	2026-05-20 01:00:00	1	12
2454	2026-05-20 02:00:00	38	198
2469	2026-05-20 02:00:00	40	20
2478	2026-05-20 02:00:00	36	20
2488	2026-05-20 02:00:00	37	28.3
2493	2026-05-20 02:00:00	39	20
2509	2026-05-20 03:00:00	43	198
2518	2026-05-20 03:00:00	44	20
2530	2026-05-20 03:00:00	45	20
2540	2026-05-20 03:00:00	41	20
2550	2026-05-20 03:00:00	42	28.23
2552	2026-05-20 04:00:00	9	20
2564	2026-05-20 04:00:00	7	24.21
2575	2026-05-20 04:00:00	8	171.6
2582	2026-05-20 04:00:00	6	12
2592	2026-05-20 04:00:00	10	20
2609	2026-05-20 05:00:00	42	38.4
2619	2026-05-20 05:00:00	41	40
2623	2026-05-20 05:00:00	43	264
2631	2026-05-20 05:00:00	44	20
2641	2026-05-20 05:00:00	45	20
2659	2026-05-20 06:00:00	45	20
2669	2026-05-20 06:00:00	42	38.2
2676	2026-05-20 06:00:00	41	40
2686	2026-05-20 06:00:00	43	264
2696	2026-05-20 06:00:00	44	20
2705	2026-05-20 07:00:00	22	38.42
2716	2026-05-20 07:00:00	23	264
2721	2026-05-20 07:00:00	24	20
2733	2026-05-20 07:00:00	21	40
2743	2026-05-20 07:00:00	25	20
2751	2026-05-20 08:00:00	7	24.21
2761	2026-05-20 08:00:00	8	171.6
2779	2026-05-20 08:00:00	6	12
2786	2026-05-20 08:00:00	10	20
2797	2026-05-20 08:00:00	9	20
2804	2026-05-20 09:00:00	18	264
2819	2026-05-20 09:00:00	20	20
2830	2026-05-20 09:00:00	17	38.21
2841	2026-05-20 09:00:00	16	40
2850	2026-05-20 09:00:00	19	20
2851	2026-05-20 10:00:00	2	24.48
2863	2026-05-20 10:00:00	4	20
2876	2026-05-20 10:00:00	1	12
2888	2026-05-20 10:00:00	5	20
2897	2026-05-20 10:00:00	3	171.6
2904	2026-05-20 11:00:00	18	264
2911	2026-05-20 11:00:00	20	20
2921	2026-05-20 11:00:00	17	38.21
2925	2026-05-20 11:00:00	16	40
2939	2026-05-20 11:00:00	19	20
2957	2026-05-20 12:00:00	40	20
2967	2026-05-20 12:00:00	37	64.28
2977	2026-05-20 12:00:00	39	20
2989	2026-05-20 12:00:00	36	92
2997	2026-05-20 12:00:00	38	435.6
3004	2026-05-20 13:00:00	18	264
3012	2026-05-20 13:00:00	20	20
3022	2026-05-20 13:00:00	17	38.25
3032	2026-05-20 13:00:00	16	40
3039	2026-05-20 13:00:00	19	20
3060	2026-05-20 14:00:00	47	38.23
3071	2026-05-20 14:00:00	48	264
138	2026-05-18 03:00:00	10	20
160	2026-05-18 04:00:00	41	20
172	2026-05-18 04:00:00	42	28.19
183	2026-05-18 04:00:00	43	198
193	2026-05-18 04:00:00	44	20
200	2026-05-18 04:00:00	45	20
201	2026-05-18 05:00:00	1	12
212	2026-05-18 05:00:00	5	20
224	2026-05-18 05:00:00	3	171.6
237	2026-05-18 05:00:00	2	24.45
246	2026-05-18 05:00:00	4	20
1252	2026-05-19 02:00:00	4	20
1261	2026-05-19 02:00:00	5	20
1270	2026-05-19 02:00:00	3	171.6
1277	2026-05-19 02:00:00	2	24.29
1284	2026-05-19 02:00:00	1	12
1310	2026-05-19 03:00:00	46	20
1325	2026-05-19 03:00:00	49	20
1336	2026-05-19 03:00:00	47	28.31
1345	2026-05-19 03:00:00	48	198
1349	2026-05-19 03:00:00	50	20
1352	2026-05-19 04:00:00	2	24.25
1363	2026-05-19 04:00:00	1	12
1375	2026-05-19 04:00:00	4	20
1387	2026-05-19 04:00:00	5	20
1395	2026-05-19 04:00:00	3	171.6
1407	2026-05-19 05:00:00	30	20
1411	2026-05-19 05:00:00	27	28.41
1421	2026-05-19 05:00:00	28	198
1429	2026-05-19 05:00:00	29	20
1440	2026-05-19 05:00:00	26	20
1459	2026-05-19 06:00:00	40	20
1469	2026-05-19 06:00:00	36	20
1479	2026-05-19 06:00:00	37	28.42
1491	2026-05-19 06:00:00	39	20
1498	2026-05-19 06:00:00	38	198
1502	2026-05-19 07:00:00	17	28.42
1513	2026-05-19 07:00:00	16	20
1526	2026-05-19 07:00:00	19	20
1534	2026-05-19 07:00:00	18	198
1544	2026-05-19 07:00:00	20	20
1556	2026-05-19 08:00:00	29	20
1568	2026-05-19 08:00:00	26	20
1583	2026-05-19 08:00:00	30	20
1593	2026-05-19 08:00:00	27	28.38
1599	2026-05-19 08:00:00	28	198
1602	2026-05-19 09:00:00	10	20
1616	2026-05-19 09:00:00	6	12
1627	2026-05-19 09:00:00	9	20
1637	2026-05-19 09:00:00	7	24.49
1647	2026-05-19 09:00:00	8	171.6
1654	2026-05-19 10:00:00	23	198
1665	2026-05-19 10:00:00	24	20
1675	2026-05-19 10:00:00	25	20
1682	2026-05-19 10:00:00	21	20
1692	2026-05-19 10:00:00	22	28.28
1707	2026-05-19 11:00:00	33	198
1717	2026-05-19 11:00:00	32	28.3
1727	2026-05-19 11:00:00	31	20
1734	2026-05-19 11:00:00	34	20
1744	2026-05-19 11:00:00	35	20
2752	2026-05-20 08:00:00	1	12
2763	2026-05-20 08:00:00	5	20
2780	2026-05-20 08:00:00	3	171.6
2788	2026-05-20 08:00:00	2	24.29
2795	2026-05-20 08:00:00	4	20
2807	2026-05-20 09:00:00	30	20
2814	2026-05-20 09:00:00	26	40
2824	2026-05-20 09:00:00	27	38.33
2833	2026-05-20 09:00:00	28	264
2843	2026-05-20 09:00:00	29	20
2859	2026-05-20 10:00:00	39	20
2865	2026-05-20 10:00:00	36	40
2875	2026-05-20 10:00:00	38	264
2885	2026-05-20 10:00:00	40	20
2892	2026-05-20 10:00:00	37	38.46
2909	2026-05-20 11:00:00	40	20
2914	2026-05-20 11:00:00	37	38.3
2924	2026-05-20 11:00:00	39	20
2931	2026-05-20 11:00:00	36	40
2942	2026-05-20 11:00:00	38	264
2958	2026-05-20 12:00:00	35	20
2961	2026-05-20 12:00:00	31	92
2971	2026-05-20 12:00:00	33	435.6
2978	2026-05-20 12:00:00	32	64.41
2985	2026-05-20 12:00:00	34	20
3008	2026-05-20 13:00:00	50	20
3019	2026-05-20 13:00:00	49	20
3028	2026-05-20 13:00:00	47	38.37
3037	2026-05-20 13:00:00	48	264
3047	2026-05-20 13:00:00	46	40
3055	2026-05-20 14:00:00	24	20
3063	2026-05-20 14:00:00	21	40
3076	2026-05-20 14:00:00	25	20
3086	2026-05-20 14:00:00	22	38.22
3097	2026-05-20 14:00:00	23	264
3105	2026-05-20 15:00:00	22	38.19
3118	2026-05-20 15:00:00	23	264
3121	2026-05-20 15:00:00	24	20
3134	2026-05-20 15:00:00	21	40
3145	2026-05-20 15:00:00	25	20
3156	2026-05-20 16:00:00	22	38.48
3169	2026-05-20 16:00:00	23	264
3178	2026-05-20 16:00:00	24	20
3188	2026-05-20 16:00:00	21	40
3198	2026-05-20 16:00:00	25	20
3202	2026-05-20 17:00:00	9	20
3213	2026-05-20 17:00:00	7	24.23
3224	2026-05-20 17:00:00	8	171.6
3236	2026-05-20 17:00:00	6	12
3244	2026-05-20 17:00:00	10	20
3708	2026-05-21 03:00:00	28	264
3716	2026-05-21 03:00:00	29	20
3728	2026-05-21 03:00:00	30	20
3738	2026-05-21 03:00:00	26	40
3746	2026-05-21 03:00:00	27	38.4
3751	2026-05-21 04:00:00	9	20
3763	2026-05-21 04:00:00	7	24.46
3776	2026-05-21 04:00:00	8	171.6
3785	2026-05-21 04:00:00	6	12
3794	2026-05-21 04:00:00	10	20
3805	2026-05-21 05:00:00	30	20
3815	2026-05-21 05:00:00	26	40
3824	2026-05-21 05:00:00	27	38.44
3834	2026-05-21 05:00:00	28	264
3843	2026-05-21 05:00:00	29	20
3855	2026-05-21 06:00:00	34	20
3862	2026-05-21 06:00:00	35	20
3875	2026-05-21 06:00:00	31	40
3885	2026-05-21 06:00:00	33	264
3895	2026-05-21 06:00:00	32	38.32
3907	2026-05-21 07:00:00	27	38.41
3912	2026-05-21 07:00:00	28	264
3922	2026-05-21 07:00:00	29	20
3932	2026-05-21 07:00:00	30	20
3939	2026-05-21 07:00:00	26	40
139	2026-05-18 03:00:00	23	198
148	2026-05-18 03:00:00	25	20
153	2026-05-18 04:00:00	14	20
163	2026-05-18 04:00:00	12	28.26
173	2026-05-18 04:00:00	11	20
182	2026-05-18 04:00:00	15	20
192	2026-05-18 04:00:00	13	198
209	2026-05-18 05:00:00	36	20
221	2026-05-18 05:00:00	37	28.41
234	2026-05-18 05:00:00	38	198
244	2026-05-18 05:00:00	40	20
249	2026-05-18 05:00:00	39	20
1253	2026-05-19 02:00:00	19	20
1265	2026-05-19 02:00:00	18	198
1281	2026-05-19 02:00:00	20	20
1292	2026-05-19 02:00:00	17	28.32
1298	2026-05-19 02:00:00	16	20
1304	2026-05-19 03:00:00	20	20
1313	2026-05-19 03:00:00	17	28.29
1322	2026-05-19 03:00:00	16	20
1328	2026-05-19 03:00:00	19	20
1338	2026-05-19 03:00:00	18	198
1357	2026-05-19 04:00:00	41	20
1367	2026-05-19 04:00:00	42	28.47
1379	2026-05-19 04:00:00	43	198
1391	2026-05-19 04:00:00	44	20
1400	2026-05-19 04:00:00	45	20
1402	2026-05-19 05:00:00	9	20
1417	2026-05-19 05:00:00	7	24.43
1426	2026-05-19 05:00:00	8	171.6
1432	2026-05-19 05:00:00	10	20
1445	2026-05-19 05:00:00	6	12
1455	2026-05-19 06:00:00	24	20
1466	2026-05-19 06:00:00	25	20
1474	2026-05-19 06:00:00	21	20
1485	2026-05-19 06:00:00	22	28.33
1495	2026-05-19 06:00:00	23	198
1506	2026-05-19 07:00:00	26	20
1519	2026-05-19 07:00:00	30	20
1529	2026-05-19 07:00:00	27	28.41
1542	2026-05-19 07:00:00	28	198
1550	2026-05-19 07:00:00	29	20
1551	2026-05-19 08:00:00	2	24.35
1565	2026-05-19 08:00:00	1	12
1575	2026-05-19 08:00:00	4	20
1581	2026-05-19 08:00:00	5	20
1591	2026-05-19 08:00:00	3	171.6
1610	2026-05-19 09:00:00	35	20
1614	2026-05-19 09:00:00	33	198
1624	2026-05-19 09:00:00	32	28.44
1634	2026-05-19 09:00:00	31	20
1645	2026-05-19 09:00:00	34	20
1656	2026-05-19 10:00:00	26	20
1667	2026-05-19 10:00:00	30	20
1678	2026-05-19 10:00:00	27	28.47
1687	2026-05-19 10:00:00	28	198
1696	2026-05-19 10:00:00	29	20
1706	2026-05-19 11:00:00	27	28.37
1719	2026-05-19 11:00:00	28	198
1729	2026-05-19 11:00:00	29	20
1741	2026-05-19 11:00:00	26	20
1749	2026-05-19 11:00:00	30	20
2753	2026-05-20 08:00:00	11	40
2762	2026-05-20 08:00:00	13	264
2773	2026-05-20 08:00:00	14	20
2783	2026-05-20 08:00:00	12	53.49
2793	2026-05-20 08:00:00	15	20
2806	2026-05-20 09:00:00	37	38.22
2821	2026-05-20 09:00:00	39	20
2831	2026-05-20 09:00:00	36	40
2842	2026-05-20 09:00:00	38	264
2849	2026-05-20 09:00:00	40	20
2852	2026-05-20 10:00:00	10	20
2862	2026-05-20 10:00:00	9	20
2873	2026-05-20 10:00:00	7	24.32
2884	2026-05-20 10:00:00	8	171.6
2893	2026-05-20 10:00:00	6	12
2908	2026-05-20 11:00:00	35	20
2912	2026-05-20 11:00:00	31	40
2922	2026-05-20 11:00:00	33	264
2926	2026-05-20 11:00:00	32	38.21
2937	2026-05-20 11:00:00	34	20
2960	2026-05-20 12:00:00	50	20
2968	2026-05-20 12:00:00	49	20
2979	2026-05-20 12:00:00	47	64.4
2988	2026-05-20 12:00:00	48	435.6
2996	2026-05-20 12:00:00	46	92
3007	2026-05-20 13:00:00	23	264
3017	2026-05-20 13:00:00	24	20
3027	2026-05-20 13:00:00	21	40
3038	2026-05-20 13:00:00	25	20
3048	2026-05-20 13:00:00	22	38.36
3052	2026-05-20 14:00:00	7	24.2
3064	2026-05-20 14:00:00	8	171.6
3075	2026-05-20 14:00:00	6	12
3085	2026-05-20 14:00:00	10	20
3095	2026-05-20 14:00:00	9	20
3104	2026-05-20 15:00:00	18	264
3114	2026-05-20 15:00:00	20	20
3127	2026-05-20 15:00:00	17	38.33
3137	2026-05-20 15:00:00	16	40
3148	2026-05-20 15:00:00	19	20
3154	2026-05-20 16:00:00	14	15
3162	2026-05-20 16:00:00	12	54.15
3173	2026-05-20 16:00:00	15	15
3183	2026-05-20 16:00:00	11	40
3193	2026-05-20 16:00:00	13	261
3208	2026-05-20 17:00:00	40	20
3218	2026-05-20 17:00:00	37	38.42
3228	2026-05-20 17:00:00	39	20
3238	2026-05-20 17:00:00	36	40
3248	2026-05-20 17:00:00	38	264
3709	2026-05-21 03:00:00	45	20
3719	2026-05-21 03:00:00	42	38.23
3730	2026-05-21 03:00:00	41	40
3742	2026-05-21 03:00:00	43	264
3750	2026-05-21 03:00:00	44	20
3752	2026-05-21 04:00:00	5	20
3762	2026-05-21 04:00:00	3	171.6
3773	2026-05-21 04:00:00	2	24.41
3781	2026-05-21 04:00:00	4	20
3790	2026-05-21 04:00:00	1	12
3808	2026-05-21 05:00:00	39	20
3821	2026-05-21 05:00:00	36	40
3833	2026-05-21 05:00:00	38	264
3842	2026-05-21 05:00:00	40	20
3848	2026-05-21 05:00:00	37	38.21
3854	2026-05-21 06:00:00	18	264
3865	2026-05-21 06:00:00	20	20
3871	2026-05-21 06:00:00	17	38.4
3880	2026-05-21 06:00:00	16	40
3890	2026-05-21 06:00:00	19	20
3909	2026-05-21 07:00:00	49	20
3915	2026-05-21 07:00:00	47	38.29
3926	2026-05-21 07:00:00	48	264
3937	2026-05-21 07:00:00	46	40
140	2026-05-18 03:00:00	34	20
147	2026-05-18 03:00:00	35	20
155	2026-05-18 04:00:00	20	20
165	2026-05-18 04:00:00	16	20
177	2026-05-18 04:00:00	18	198
187	2026-05-18 04:00:00	19	20
195	2026-05-18 04:00:00	17	28.43
205	2026-05-18 05:00:00	22	28.2
217	2026-05-18 05:00:00	23	198
229	2026-05-18 05:00:00	24	20
235	2026-05-18 05:00:00	25	20
240	2026-05-18 05:00:00	21	20
1254	2026-05-19 02:00:00	13	198
1263	2026-05-19 02:00:00	14	20
1272	2026-05-19 02:00:00	12	28.2
1279	2026-05-19 02:00:00	11	20
1286	2026-05-19 02:00:00	15	20
1308	2026-05-19 03:00:00	39	20
1315	2026-05-19 03:00:00	38	198
1324	2026-05-19 03:00:00	40	20
1333	2026-05-19 03:00:00	36	20
1344	2026-05-19 03:00:00	37	28.48
1359	2026-05-19 04:00:00	30	20
1369	2026-05-19 04:00:00	27	28.44
1380	2026-05-19 04:00:00	28	198
1386	2026-05-19 04:00:00	29	20
1398	2026-05-19 04:00:00	26	20
1403	2026-05-19 05:00:00	11	20
1415	2026-05-19 05:00:00	15	20
1427	2026-05-19 05:00:00	13	198
1436	2026-05-19 05:00:00	14	20
1443	2026-05-19 05:00:00	12	28.45
1460	2026-05-19 06:00:00	34	20
1463	2026-05-19 06:00:00	35	20
1475	2026-05-19 06:00:00	33	198
1486	2026-05-19 06:00:00	32	28.25
1494	2026-05-19 06:00:00	31	20
1507	2026-05-19 07:00:00	37	28.33
1516	2026-05-19 07:00:00	39	20
1523	2026-05-19 07:00:00	38	198
1533	2026-05-19 07:00:00	40	20
1543	2026-05-19 07:00:00	36	20
1560	2026-05-19 08:00:00	36	20
1570	2026-05-19 08:00:00	37	28.25
1585	2026-05-19 08:00:00	39	20
1595	2026-05-19 08:00:00	38	198
1600	2026-05-19 08:00:00	40	20
1601	2026-05-19 09:00:00	2	24.19
1611	2026-05-19 09:00:00	1	12
1621	2026-05-19 09:00:00	4	20
1631	2026-05-19 09:00:00	5	20
1641	2026-05-19 09:00:00	3	171.6
1659	2026-05-19 10:00:00	44	20
1671	2026-05-19 10:00:00	45	20
1680	2026-05-19 10:00:00	41	20
1691	2026-05-19 10:00:00	42	28.39
1699	2026-05-19 10:00:00	43	198
1701	2026-05-19 11:00:00	11	20
1711	2026-05-19 11:00:00	15	20
1722	2026-05-19 11:00:00	13	198
1737	2026-05-19 11:00:00	14	20
1748	2026-05-19 11:00:00	12	28.39
2754	2026-05-20 08:00:00	30	20
2768	2026-05-20 08:00:00	26	40
2776	2026-05-20 08:00:00	27	38.25
2787	2026-05-20 08:00:00	28	264
2798	2026-05-20 08:00:00	29	20
2805	2026-05-20 09:00:00	14	20
2817	2026-05-20 09:00:00	12	53.34
2827	2026-05-20 09:00:00	15	20
2837	2026-05-20 09:00:00	11	40
2846	2026-05-20 09:00:00	13	264
2854	2026-05-20 10:00:00	17	38.48
2867	2026-05-20 10:00:00	16	40
2877	2026-05-20 10:00:00	19	20
2890	2026-05-20 10:00:00	18	264
2899	2026-05-20 10:00:00	20	20
2903	2026-05-20 11:00:00	6	12
2916	2026-05-20 11:00:00	10	20
2929	2026-05-20 11:00:00	9	20
2938	2026-05-20 11:00:00	7	24.2
2947	2026-05-20 11:00:00	8	171.6
2954	2026-05-20 12:00:00	18	435.6
2969	2026-05-20 12:00:00	20	20
2980	2026-05-20 12:00:00	17	64.26
2992	2026-05-20 12:00:00	16	92
2999	2026-05-20 12:00:00	19	20
3003	2026-05-20 13:00:00	12	54.16
3018	2026-05-20 13:00:00	15	15
3029	2026-05-20 13:00:00	11	40
3041	2026-05-20 13:00:00	13	261
3049	2026-05-20 13:00:00	14	15
3053	2026-05-20 14:00:00	15	15
3065	2026-05-20 14:00:00	11	40
3078	2026-05-20 14:00:00	13	261
3088	2026-05-20 14:00:00	14	15
3096	2026-05-20 14:00:00	12	54.33
3106	2026-05-20 15:00:00	29	20
3117	2026-05-20 15:00:00	30	20
3129	2026-05-20 15:00:00	26	40
3139	2026-05-20 15:00:00	27	38.21
3149	2026-05-20 15:00:00	28	264
3152	2026-05-20 16:00:00	10	20
3163	2026-05-20 16:00:00	9	20
3172	2026-05-20 16:00:00	7	24.31
3184	2026-05-20 16:00:00	8	171.6
3194	2026-05-20 16:00:00	6	12
3206	2026-05-20 17:00:00	22	38.21
3219	2026-05-20 17:00:00	23	264
3229	2026-05-20 17:00:00	24	20
3240	2026-05-20 17:00:00	21	40
3247	2026-05-20 17:00:00	25	20
3710	2026-05-21 03:00:00	46	40
3720	2026-05-21 03:00:00	50	20
3729	2026-05-21 03:00:00	49	20
3739	2026-05-21 03:00:00	47	38.25
3748	2026-05-21 03:00:00	48	264
3753	2026-05-21 04:00:00	13	261
3764	2026-05-21 04:00:00	14	15
3775	2026-05-21 04:00:00	12	54.14
3784	2026-05-21 04:00:00	15	15
3796	2026-05-21 04:00:00	11	40
3807	2026-05-21 05:00:00	31	40
3811	2026-05-21 05:00:00	33	264
3820	2026-05-21 05:00:00	32	38.45
3822	2026-05-21 05:00:00	34	20
3831	2026-05-21 05:00:00	35	20
3859	2026-05-21 06:00:00	48	264
3870	2026-05-21 06:00:00	46	40
3881	2026-05-21 06:00:00	50	20
3891	2026-05-21 06:00:00	49	20
3900	2026-05-21 06:00:00	47	38.2
3901	2026-05-21 07:00:00	5	20
3911	2026-05-21 07:00:00	3	171.6
3921	2026-05-21 07:00:00	2	24.37
3931	2026-05-21 07:00:00	4	20
141	2026-05-18 03:00:00	38	198
149	2026-05-18 03:00:00	40	20
152	2026-05-18 04:00:00	6	12
166	2026-05-18 04:00:00	7	24.49
175	2026-05-18 04:00:00	8	171.6
184	2026-05-18 04:00:00	10	20
194	2026-05-18 04:00:00	9	20
214	2026-05-18 05:00:00	33	198
228	2026-05-18 05:00:00	31	20
239	2026-05-18 05:00:00	34	20
247	2026-05-18 05:00:00	35	20
250	2026-05-18 05:00:00	32	28.45
1255	2026-05-19 02:00:00	35	20
1262	2026-05-19 02:00:00	33	198
1271	2026-05-19 02:00:00	32	28.47
1278	2026-05-19 02:00:00	31	20
1285	2026-05-19 02:00:00	34	20
1309	2026-05-19 03:00:00	42	28.2
1317	2026-05-19 03:00:00	43	198
1332	2026-05-19 03:00:00	44	20
1339	2026-05-19 03:00:00	45	20
1346	2026-05-19 03:00:00	41	20
1356	2026-05-19 04:00:00	21	20
1370	2026-05-19 04:00:00	22	28.36
1378	2026-05-19 04:00:00	23	198
1388	2026-05-19 04:00:00	24	20
1397	2026-05-19 04:00:00	25	20
1404	2026-05-19 05:00:00	20	20
1413	2026-05-19 05:00:00	17	28.31
1423	2026-05-19 05:00:00	16	20
1428	2026-05-19 05:00:00	19	20
1435	2026-05-19 05:00:00	18	198
1456	2026-05-19 06:00:00	46	20
1462	2026-05-19 06:00:00	49	20
1476	2026-05-19 06:00:00	47	28.24
1487	2026-05-19 06:00:00	48	198
1496	2026-05-19 06:00:00	50	20
1505	2026-05-19 07:00:00	22	28.37
1515	2026-05-19 07:00:00	23	198
1522	2026-05-19 07:00:00	24	20
1531	2026-05-19 07:00:00	25	20
1541	2026-05-19 07:00:00	21	20
1558	2026-05-19 08:00:00	50	20
1563	2026-05-19 08:00:00	46	20
1573	2026-05-19 08:00:00	49	20
1579	2026-05-19 08:00:00	47	28.26
1589	2026-05-19 08:00:00	48	198
1609	2026-05-19 09:00:00	36	20
1618	2026-05-19 09:00:00	37	28.23
1626	2026-05-19 09:00:00	39	20
1636	2026-05-19 09:00:00	38	198
1643	2026-05-19 09:00:00	40	20
1652	2026-05-19 10:00:00	4	20
1661	2026-05-19 10:00:00	5	20
1668	2026-05-19 10:00:00	3	171.6
1672	2026-05-19 10:00:00	2	24.46
1684	2026-05-19 10:00:00	1	12
1710	2026-05-19 11:00:00	47	28.3
1713	2026-05-19 11:00:00	48	198
1724	2026-05-19 11:00:00	50	20
1731	2026-05-19 11:00:00	46	20
1743	2026-05-19 11:00:00	49	20
2755	2026-05-20 08:00:00	34	20
2769	2026-05-20 08:00:00	35	20
2777	2026-05-20 08:00:00	31	40
2790	2026-05-20 08:00:00	33	264
2799	2026-05-20 08:00:00	32	38.32
2802	2026-05-20 09:00:00	8	171.6
2812	2026-05-20 09:00:00	6	12
2822	2026-05-20 09:00:00	10	20
2832	2026-05-20 09:00:00	9	20
2839	2026-05-20 09:00:00	7	24.27
2860	2026-05-20 10:00:00	48	264
2870	2026-05-20 10:00:00	46	40
2880	2026-05-20 10:00:00	50	20
2891	2026-05-20 10:00:00	49	20
2900	2026-05-20 10:00:00	47	38.31
2901	2026-05-20 11:00:00	5	20
2915	2026-05-20 11:00:00	3	171.6
2928	2026-05-20 11:00:00	2	24.21
2936	2026-05-20 11:00:00	4	20
2946	2026-05-20 11:00:00	1	12
2956	2026-05-20 12:00:00	29	20
2963	2026-05-20 12:00:00	30	20
2973	2026-05-20 12:00:00	26	92
2983	2026-05-20 12:00:00	27	64.42
2993	2026-05-20 12:00:00	28	435.6
3009	2026-05-20 13:00:00	40	20
3013	2026-05-20 13:00:00	37	38.24
3025	2026-05-20 13:00:00	39	20
3035	2026-05-20 13:00:00	36	40
3045	2026-05-20 13:00:00	38	264
3054	2026-05-20 14:00:00	26	40
3066	2026-05-20 14:00:00	27	38.29
3077	2026-05-20 14:00:00	28	264
3087	2026-05-20 14:00:00	29	20
3093	2026-05-20 14:00:00	30	20
3109	2026-05-20 15:00:00	40	20
3115	2026-05-20 15:00:00	37	38.48
3128	2026-05-20 15:00:00	39	20
3138	2026-05-20 15:00:00	36	40
3146	2026-05-20 15:00:00	38	264
3153	2026-05-20 16:00:00	18	264
3164	2026-05-20 16:00:00	20	20
3174	2026-05-20 16:00:00	17	38.34
3186	2026-05-20 16:00:00	16	40
3195	2026-05-20 16:00:00	19	20
3207	2026-05-20 17:00:00	34	20
3217	2026-05-20 17:00:00	35	20
3227	2026-05-20 17:00:00	31	40
3233	2026-05-20 17:00:00	33	264
3242	2026-05-20 17:00:00	32	38.22
3941	2026-05-21 07:00:00	1	12
3958	2026-05-21 08:00:00	44	20
3968	2026-05-21 08:00:00	45	20
3976	2026-05-21 08:00:00	42	38.3
3987	2026-05-21 08:00:00	41	40
3995	2026-05-21 08:00:00	43	264
4004	2026-05-21 09:00:00	21	40
4015	2026-05-21 09:00:00	25	20
4025	2026-05-21 09:00:00	22	38.37
4038	2026-05-21 09:00:00	23	264
4046	2026-05-21 09:00:00	24	20
4060	2026-05-21 10:00:00	34	20
4069	2026-05-21 10:00:00	35	20
4076	2026-05-21 10:00:00	31	40
4088	2026-05-21 10:00:00	33	264
4097	2026-05-21 10:00:00	32	38.42
4103	2026-05-21 11:00:00	15	15
4114	2026-05-21 11:00:00	11	40
4126	2026-05-21 11:00:00	13	261
4136	2026-05-21 11:00:00	14	15
4144	2026-05-21 11:00:00	12	54.07
4154	2026-05-21 12:00:00	40	20
4162	2026-05-21 12:00:00	37	64.27
4169	2026-05-21 12:00:00	39	20
142	2026-05-18 03:00:00	45	20
158	2026-05-18 04:00:00	36	20
168	2026-05-18 04:00:00	37	28.46
178	2026-05-18 04:00:00	38	198
190	2026-05-18 04:00:00	40	20
198	2026-05-18 04:00:00	39	20
202	2026-05-18 05:00:00	7	24.32
213	2026-05-18 05:00:00	8	171.6
225	2026-05-18 05:00:00	10	20
233	2026-05-18 05:00:00	6	12
243	2026-05-18 05:00:00	9	20
1256	2026-05-19 02:00:00	28	198
1268	2026-05-19 02:00:00	29	20
1280	2026-05-19 02:00:00	26	20
1290	2026-05-19 02:00:00	30	20
1297	2026-05-19 02:00:00	27	28.23
1305	2026-05-19 03:00:00	15	20
1319	2026-05-19 03:00:00	13	198
1334	2026-05-19 03:00:00	14	20
1340	2026-05-19 03:00:00	12	28.24
1347	2026-05-19 03:00:00	11	20
1351	2026-05-19 04:00:00	8	171.6
1361	2026-05-19 04:00:00	10	20
1374	2026-05-19 04:00:00	6	12
1384	2026-05-19 04:00:00	9	20
1394	2026-05-19 04:00:00	7	24.25
1406	2026-05-19 05:00:00	31	20
1420	2026-05-19 05:00:00	34	20
1434	2026-05-19 05:00:00	35	20
1442	2026-05-19 05:00:00	33	198
1448	2026-05-19 05:00:00	32	28.38
1452	2026-05-19 06:00:00	13	198
1464	2026-05-19 06:00:00	14	20
1472	2026-05-19 06:00:00	12	28.38
1480	2026-05-19 06:00:00	11	20
1484	2026-05-19 06:00:00	15	20
1509	2026-05-19 07:00:00	48	198
1517	2026-05-19 07:00:00	50	20
1527	2026-05-19 07:00:00	46	20
1537	2026-05-19 07:00:00	49	20
1547	2026-05-19 07:00:00	47	28.32
1552	2026-05-19 08:00:00	10	20
1567	2026-05-19 08:00:00	6	12
1584	2026-05-19 08:00:00	9	20
1594	2026-05-19 08:00:00	7	24.33
1597	2026-05-19 08:00:00	8	171.6
1603	2026-05-19 09:00:00	20	20
1620	2026-05-19 09:00:00	17	28.41
1630	2026-05-19 09:00:00	16	20
1640	2026-05-19 09:00:00	19	20
1650	2026-05-19 09:00:00	18	198
1651	2026-05-19 10:00:00	6	12
1662	2026-05-19 10:00:00	9	20
1674	2026-05-19 10:00:00	7	24.35
1686	2026-05-19 10:00:00	8	171.6
1695	2026-05-19 10:00:00	10	20
1704	2026-05-19 11:00:00	17	28.29
1718	2026-05-19 11:00:00	16	20
1728	2026-05-19 11:00:00	19	20
1738	2026-05-19 11:00:00	18	198
1747	2026-05-19 11:00:00	20	20
2756	2026-05-20 08:00:00	19	20
2764	2026-05-20 08:00:00	18	264
2778	2026-05-20 08:00:00	20	20
2792	2026-05-20 08:00:00	17	38.32
2800	2026-05-20 08:00:00	16	40
2801	2026-05-20 09:00:00	5	20
2811	2026-05-20 09:00:00	3	171.6
2820	2026-05-20 09:00:00	2	24.2
2829	2026-05-20 09:00:00	4	20
2840	2026-05-20 09:00:00	1	12
2858	2026-05-20 10:00:00	43	264
2868	2026-05-20 10:00:00	44	20
2879	2026-05-20 10:00:00	45	20
2886	2026-05-20 10:00:00	42	38.41
2896	2026-05-20 10:00:00	41	40
2906	2026-05-20 11:00:00	30	20
2919	2026-05-20 11:00:00	26	40
2933	2026-05-20 11:00:00	27	38.33
2941	2026-05-20 11:00:00	28	264
2948	2026-05-20 11:00:00	29	20
2953	2026-05-20 12:00:00	14	15
2966	2026-05-20 12:00:00	12	80.91
2976	2026-05-20 12:00:00	15	15
2986	2026-05-20 12:00:00	11	92
2995	2026-05-20 12:00:00	13	432.6
3006	2026-05-20 13:00:00	31	40
3014	2026-05-20 13:00:00	33	264
3023	2026-05-20 13:00:00	32	38.25
3036	2026-05-20 13:00:00	34	20
3046	2026-05-20 13:00:00	35	20
3056	2026-05-20 14:00:00	17	38.43
3068	2026-05-20 14:00:00	16	40
3080	2026-05-20 14:00:00	19	20
3090	2026-05-20 14:00:00	18	264
3100	2026-05-20 14:00:00	20	20
3102	2026-05-20 15:00:00	10	20
3113	2026-05-20 15:00:00	9	20
3125	2026-05-20 15:00:00	7	24.42
3136	2026-05-20 15:00:00	8	171.6
3143	2026-05-20 15:00:00	6	12
3158	2026-05-20 16:00:00	40	20
3165	2026-05-20 16:00:00	37	38.24
3176	2026-05-20 16:00:00	39	20
3182	2026-05-20 16:00:00	36	40
3192	2026-05-20 16:00:00	38	264
3210	2026-05-20 17:00:00	46	40
3220	2026-05-20 17:00:00	50	20
3225	2026-05-20 17:00:00	49	20
3232	2026-05-20 17:00:00	47	38.36
3246	2026-05-20 17:00:00	48	264
3945	2026-05-21 07:00:00	50	20
3956	2026-05-21 08:00:00	32	38.28
3963	2026-05-21 08:00:00	34	20
3972	2026-05-21 08:00:00	35	20
3982	2026-05-21 08:00:00	31	40
3991	2026-05-21 08:00:00	33	264
4008	2026-05-21 09:00:00	47	38.4
4017	2026-05-21 09:00:00	48	264
4021	2026-05-21 09:00:00	46	40
4031	2026-05-21 09:00:00	50	20
4041	2026-05-21 09:00:00	49	20
4059	2026-05-21 10:00:00	37	38.25
4063	2026-05-21 10:00:00	39	20
4071	2026-05-21 10:00:00	36	40
4081	2026-05-21 10:00:00	38	264
4095	2026-05-21 10:00:00	40	20
4105	2026-05-21 11:00:00	17	38.22
4117	2026-05-21 11:00:00	16	40
4129	2026-05-21 11:00:00	19	20
4140	2026-05-21 11:00:00	18	264
4146	2026-05-21 11:00:00	20	20
4153	2026-05-21 12:00:00	9	20
4166	2026-05-21 12:00:00	7	24.35
4182	2026-05-21 12:00:00	8	171.6
4192	2026-05-21 12:00:00	6	12
144	2026-05-18 03:00:00	27	28.41
156	2026-05-18 04:00:00	30	20
164	2026-05-18 04:00:00	28	198
176	2026-05-18 04:00:00	29	20
186	2026-05-18 04:00:00	26	20
196	2026-05-18 04:00:00	27	28.28
206	2026-05-18 05:00:00	28	198
210	2026-05-18 05:00:00	29	20
219	2026-05-18 05:00:00	26	20
226	2026-05-18 05:00:00	30	20
231	2026-05-18 05:00:00	27	28.23
1257	2026-05-19 02:00:00	39	20
1267	2026-05-19 02:00:00	38	198
1276	2026-05-19 02:00:00	40	20
1289	2026-05-19 02:00:00	36	20
1295	2026-05-19 02:00:00	37	28.49
1307	2026-05-19 03:00:00	30	20
1312	2026-05-19 03:00:00	27	28.41
1321	2026-05-19 03:00:00	28	198
1327	2026-05-19 03:00:00	29	20
1343	2026-05-19 03:00:00	26	20
1355	2026-05-19 04:00:00	31	20
1364	2026-05-19 04:00:00	34	20
1376	2026-05-19 04:00:00	35	20
1389	2026-05-19 04:00:00	33	198
1399	2026-05-19 04:00:00	32	28.39
1401	2026-05-19 05:00:00	2	24.39
1416	2026-05-19 05:00:00	1	12
1425	2026-05-19 05:00:00	4	20
1431	2026-05-19 05:00:00	5	20
1439	2026-05-19 05:00:00	3	171.6
1457	2026-05-19 06:00:00	42	28.49
1468	2026-05-19 06:00:00	43	198
1478	2026-05-19 06:00:00	44	20
1493	2026-05-19 06:00:00	45	20
1500	2026-05-19 06:00:00	41	20
1504	2026-05-19 07:00:00	10	20
1514	2026-05-19 07:00:00	6	12
1521	2026-05-19 07:00:00	9	20
1532	2026-05-19 07:00:00	7	24.33
1540	2026-05-19 07:00:00	8	171.6
1559	2026-05-19 08:00:00	43	198
1561	2026-05-19 08:00:00	44	20
1571	2026-05-19 08:00:00	45	20
1577	2026-05-19 08:00:00	41	20
1586	2026-05-19 08:00:00	42	28.21
1607	2026-05-19 09:00:00	50	20
1613	2026-05-19 09:00:00	46	20
1623	2026-05-19 09:00:00	49	20
1632	2026-05-19 09:00:00	47	28.39
1646	2026-05-19 09:00:00	48	198
1657	2026-05-19 10:00:00	32	28.19
1663	2026-05-19 10:00:00	31	20
1676	2026-05-19 10:00:00	34	20
1689	2026-05-19 10:00:00	35	20
1698	2026-05-19 10:00:00	33	198
1703	2026-05-19 11:00:00	8	171.6
1716	2026-05-19 11:00:00	10	20
1725	2026-05-19 11:00:00	6	12
1735	2026-05-19 11:00:00	9	20
1746	2026-05-19 11:00:00	7	24.22
2757	2026-05-20 08:00:00	22	38.33
2765	2026-05-20 08:00:00	23	264
2772	2026-05-20 08:00:00	24	20
2782	2026-05-20 08:00:00	21	40
2789	2026-05-20 08:00:00	25	20
2810	2026-05-20 09:00:00	49	20
2816	2026-05-20 09:00:00	47	38.37
2826	2026-05-20 09:00:00	48	264
2838	2026-05-20 09:00:00	46	40
2848	2026-05-20 09:00:00	50	20
2853	2026-05-20 10:00:00	15	20
2866	2026-05-20 10:00:00	11	40
2878	2026-05-20 10:00:00	13	264
2887	2026-05-20 10:00:00	14	20
2898	2026-05-20 10:00:00	12	53.4
2902	2026-05-20 11:00:00	14	20
2917	2026-05-20 11:00:00	12	53.31
2930	2026-05-20 11:00:00	15	20
2935	2026-05-20 11:00:00	11	40
2945	2026-05-20 11:00:00	13	264
2955	2026-05-20 12:00:00	23	435.6
2970	2026-05-20 12:00:00	24	20
2981	2026-05-20 12:00:00	21	92
2990	2026-05-20 12:00:00	25	20
3000	2026-05-20 12:00:00	22	64.34
3002	2026-05-20 13:00:00	10	20
3016	2026-05-20 13:00:00	9	20
3026	2026-05-20 13:00:00	7	24.26
3034	2026-05-20 13:00:00	8	171.6
3043	2026-05-20 13:00:00	6	12
3058	2026-05-20 14:00:00	39	20
3067	2026-05-20 14:00:00	36	40
3072	2026-05-20 14:00:00	38	264
3084	2026-05-20 14:00:00	40	20
3094	2026-05-20 14:00:00	37	38.2
3107	2026-05-20 15:00:00	32	38.42
3119	2026-05-20 15:00:00	34	20
3122	2026-05-20 15:00:00	35	20
3133	2026-05-20 15:00:00	31	40
3144	2026-05-20 15:00:00	33	264
3155	2026-05-20 16:00:00	32	38.46
3166	2026-05-20 16:00:00	34	20
3175	2026-05-20 16:00:00	35	20
3190	2026-05-20 16:00:00	31	40
3200	2026-05-20 16:00:00	33	264
3204	2026-05-20 17:00:00	20	20
3211	2026-05-20 17:00:00	17	38.34
3221	2026-05-20 17:00:00	16	40
3231	2026-05-20 17:00:00	19	20
3237	2026-05-20 17:00:00	18	264
3960	2026-05-21 08:00:00	49	20
3970	2026-05-21 08:00:00	47	38.29
3979	2026-05-21 08:00:00	48	264
3985	2026-05-21 08:00:00	46	40
3999	2026-05-21 08:00:00	50	20
4002	2026-05-21 09:00:00	6	12
4013	2026-05-21 09:00:00	10	20
4023	2026-05-21 09:00:00	9	20
4034	2026-05-21 09:00:00	7	24.26
4043	2026-05-21 09:00:00	8	171.6
4058	2026-05-21 10:00:00	50	20
4066	2026-05-21 10:00:00	49	20
4072	2026-05-21 10:00:00	47	38.29
4082	2026-05-21 10:00:00	48	264
4092	2026-05-21 10:00:00	46	40
4108	2026-05-21 11:00:00	42	38.26
4111	2026-05-21 11:00:00	41	40
4122	2026-05-21 11:00:00	43	264
4132	2026-05-21 11:00:00	44	20
4142	2026-05-21 11:00:00	45	20
4160	2026-05-21 12:00:00	42	64.3
4170	2026-05-21 12:00:00	41	92
4177	2026-05-21 12:00:00	43	435.6
4186	2026-05-21 12:00:00	44	20
4194	2026-05-21 12:00:00	45	20
145	2026-05-18 03:00:00	13	198
154	2026-05-18 04:00:00	21	20
162	2026-05-18 04:00:00	22	28.37
171	2026-05-18 04:00:00	23	198
181	2026-05-18 04:00:00	24	20
188	2026-05-18 04:00:00	25	20
208	2026-05-18 05:00:00	49	20
216	2026-05-18 05:00:00	50	20
223	2026-05-18 05:00:00	46	20
232	2026-05-18 05:00:00	47	28.31
241	2026-05-18 05:00:00	48	198
1258	2026-05-19 02:00:00	48	198
1269	2026-05-19 02:00:00	50	20
1283	2026-05-19 02:00:00	46	20
1293	2026-05-19 02:00:00	49	20
1299	2026-05-19 02:00:00	47	28.29
1302	2026-05-19 03:00:00	8	171.6
1311	2026-05-19 03:00:00	10	20
1320	2026-05-19 03:00:00	6	12
1326	2026-05-19 03:00:00	9	20
1335	2026-05-19 03:00:00	7	24.41
1360	2026-05-19 04:00:00	50	20
1368	2026-05-19 04:00:00	46	20
1377	2026-05-19 04:00:00	49	20
1383	2026-05-19 04:00:00	47	28.41
1393	2026-05-19 04:00:00	48	198
1408	2026-05-19 05:00:00	39	20
1412	2026-05-19 05:00:00	38	198
1422	2026-05-19 05:00:00	40	20
1438	2026-05-19 05:00:00	36	20
1447	2026-05-19 05:00:00	37	28.45
1454	2026-05-19 06:00:00	16	20
1465	2026-05-19 06:00:00	19	20
1473	2026-05-19 06:00:00	18	198
1481	2026-05-19 06:00:00	20	20
1489	2026-05-19 06:00:00	17	28.49
1508	2026-05-19 07:00:00	33	198
1518	2026-05-19 07:00:00	32	28.41
1528	2026-05-19 07:00:00	31	20
1538	2026-05-19 07:00:00	34	20
1548	2026-05-19 07:00:00	35	20
1553	2026-05-19 08:00:00	11	20
1566	2026-05-19 08:00:00	15	20
1576	2026-05-19 08:00:00	13	198
1588	2026-05-19 08:00:00	14	20
1596	2026-05-19 08:00:00	12	28.46
1605	2026-05-19 09:00:00	22	28.26
1615	2026-05-19 09:00:00	23	198
1625	2026-05-19 09:00:00	24	20
1638	2026-05-19 09:00:00	25	20
1648	2026-05-19 09:00:00	21	20
1653	2026-05-19 10:00:00	13	198
1664	2026-05-19 10:00:00	14	20
1677	2026-05-19 10:00:00	12	28.43
1685	2026-05-19 10:00:00	11	20
1694	2026-05-19 10:00:00	15	20
1708	2026-05-19 11:00:00	41	20
1714	2026-05-19 11:00:00	42	28.44
1723	2026-05-19 11:00:00	43	198
1730	2026-05-19 11:00:00	44	20
1740	2026-05-19 11:00:00	45	20
2758	2026-05-20 08:00:00	40	20
2766	2026-05-20 08:00:00	37	38.37
2771	2026-05-20 08:00:00	39	20
2781	2026-05-20 08:00:00	36	40
2791	2026-05-20 08:00:00	38	264
2809	2026-05-20 09:00:00	42	38.3
2813	2026-05-20 09:00:00	41	40
2823	2026-05-20 09:00:00	43	264
2834	2026-05-20 09:00:00	44	20
2844	2026-05-20 09:00:00	45	20
2857	2026-05-20 10:00:00	27	38.41
2869	2026-05-20 10:00:00	28	264
2874	2026-05-20 10:00:00	29	20
2883	2026-05-20 10:00:00	30	20
2894	2026-05-20 10:00:00	26	40
2905	2026-05-20 11:00:00	42	38.46
2913	2026-05-20 11:00:00	41	40
2923	2026-05-20 11:00:00	43	264
2927	2026-05-20 11:00:00	44	20
2940	2026-05-20 11:00:00	45	20
2959	2026-05-20 12:00:00	42	64.3
2962	2026-05-20 12:00:00	41	92
2972	2026-05-20 12:00:00	43	435.6
2982	2026-05-20 12:00:00	44	20
2991	2026-05-20 12:00:00	45	20
3010	2026-05-20 13:00:00	42	38.24
3020	2026-05-20 13:00:00	41	40
3030	2026-05-20 13:00:00	43	264
3042	2026-05-20 13:00:00	44	20
3050	2026-05-20 13:00:00	45	20
3051	2026-05-20 14:00:00	4	20
3061	2026-05-20 14:00:00	1	12
3073	2026-05-20 14:00:00	5	20
3083	2026-05-20 14:00:00	3	171.6
3092	2026-05-20 14:00:00	2	24.32
3108	2026-05-20 15:00:00	45	20
3116	2026-05-20 15:00:00	42	38.31
3126	2026-05-20 15:00:00	41	40
3132	2026-05-20 15:00:00	43	264
3141	2026-05-20 15:00:00	44	20
3157	2026-05-20 16:00:00	28	264
3168	2026-05-20 16:00:00	29	20
3177	2026-05-20 16:00:00	30	20
3187	2026-05-20 16:00:00	26	40
3197	2026-05-20 16:00:00	27	38.45
3203	2026-05-20 17:00:00	12	54.15
3215	2026-05-20 17:00:00	15	15
3230	2026-05-20 17:00:00	11	40
3241	2026-05-20 17:00:00	13	261
3250	2026-05-20 17:00:00	14	15
4068	2026-05-21 10:00:00	19	20
4080	2026-05-21 10:00:00	18	264
4090	2026-05-21 10:00:00	20	20
4099	2026-05-21 10:00:00	17	38.21
4101	2026-05-21 11:00:00	9	20
4113	2026-05-21 11:00:00	7	24.47
4125	2026-05-21 11:00:00	8	171.6
4135	2026-05-21 11:00:00	6	12
4145	2026-05-21 11:00:00	10	20
4159	2026-05-21 12:00:00	32	64.3
4164	2026-05-21 12:00:00	34	20
4176	2026-05-21 12:00:00	35	20
4185	2026-05-21 12:00:00	31	92
4193	2026-05-21 12:00:00	33	435.6
4208	2026-05-21 13:00:00	30	20
4216	2026-05-21 13:00:00	26	40
4228	2026-05-21 13:00:00	27	38.32
4240	2026-05-21 13:00:00	28	264
4243	2026-05-21 13:00:00	40	20
4250	2026-05-21 13:00:00	29	20
4251	2026-05-21 14:00:00	4	20
4254	2026-05-21 14:00:00	23	264
4261	2026-05-21 14:00:00	1	12
4269	2026-05-21 14:00:00	24	20
4273	2026-05-21 14:00:00	21	40
146	2026-05-18 03:00:00	49	20
150	2026-05-18 03:00:00	50	20
151	2026-05-18 04:00:00	2	24.39
161	2026-05-18 04:00:00	4	20
167	2026-05-18 04:00:00	1	12
174	2026-05-18 04:00:00	5	20
185	2026-05-18 04:00:00	3	171.6
207	2026-05-18 05:00:00	41	20
218	2026-05-18 05:00:00	42	28.31
230	2026-05-18 05:00:00	43	198
242	2026-05-18 05:00:00	44	20
248	2026-05-18 05:00:00	45	20
1259	2026-05-19 02:00:00	44	20
1266	2026-05-19 02:00:00	45	20
1275	2026-05-19 02:00:00	41	20
1288	2026-05-19 02:00:00	42	28.22
1296	2026-05-19 02:00:00	43	198
1303	2026-05-19 03:00:00	21	20
1314	2026-05-19 03:00:00	22	28.48
1323	2026-05-19 03:00:00	23	198
1330	2026-05-19 03:00:00	24	20
1337	2026-05-19 03:00:00	25	20
1358	2026-05-19 04:00:00	39	20
1366	2026-05-19 04:00:00	38	198
1371	2026-05-19 04:00:00	40	20
1381	2026-05-19 04:00:00	36	20
1390	2026-05-19 04:00:00	37	28.45
1410	2026-05-19 05:00:00	41	20
1419	2026-05-19 05:00:00	42	28.2
1433	2026-05-19 05:00:00	43	198
1444	2026-05-19 05:00:00	44	20
1450	2026-05-19 05:00:00	45	20
1451	2026-05-19 06:00:00	4	20
1461	2026-05-19 06:00:00	5	20
1471	2026-05-19 06:00:00	3	171.6
1482	2026-05-19 06:00:00	2	24.2
1490	2026-05-19 06:00:00	1	12
1510	2026-05-19 07:00:00	44	20
1520	2026-05-19 07:00:00	45	20
1530	2026-05-19 07:00:00	41	20
1539	2026-05-19 07:00:00	42	28.25
1549	2026-05-19 07:00:00	43	198
1555	2026-05-19 08:00:00	20	20
1564	2026-05-19 08:00:00	17	28.4
1574	2026-05-19 08:00:00	16	20
1580	2026-05-19 08:00:00	19	20
1590	2026-05-19 08:00:00	18	198
1606	2026-05-19 09:00:00	29	20
1619	2026-05-19 09:00:00	26	20
1629	2026-05-19 09:00:00	30	20
1635	2026-05-19 09:00:00	27	28.4
1644	2026-05-19 09:00:00	28	198
1658	2026-05-19 10:00:00	37	28.36
1669	2026-05-19 10:00:00	39	20
1673	2026-05-19 10:00:00	38	198
1683	2026-05-19 10:00:00	40	20
1693	2026-05-19 10:00:00	36	20
1709	2026-05-19 11:00:00	40	20
1712	2026-05-19 11:00:00	36	20
1721	2026-05-19 11:00:00	37	28.31
1732	2026-05-19 11:00:00	39	20
1742	2026-05-19 11:00:00	38	198
2759	2026-05-20 08:00:00	45	20
2767	2026-05-20 08:00:00	42	38.29
2774	2026-05-20 08:00:00	41	40
2784	2026-05-20 08:00:00	43	264
2794	2026-05-20 08:00:00	44	20
2808	2026-05-20 09:00:00	35	20
2818	2026-05-20 09:00:00	31	40
2828	2026-05-20 09:00:00	33	264
2835	2026-05-20 09:00:00	32	38.35
2845	2026-05-20 09:00:00	34	20
2855	2026-05-20 10:00:00	33	264
2864	2026-05-20 10:00:00	32	38.32
2872	2026-05-20 10:00:00	34	20
2882	2026-05-20 10:00:00	35	20
2895	2026-05-20 10:00:00	31	40
2907	2026-05-20 11:00:00	24	20
2920	2026-05-20 11:00:00	21	40
2934	2026-05-20 11:00:00	25	20
2944	2026-05-20 11:00:00	22	38.34
2949	2026-05-20 11:00:00	23	264
2952	2026-05-20 12:00:00	5	20
2965	2026-05-20 12:00:00	3	171.6
2975	2026-05-20 12:00:00	2	24.27
2984	2026-05-20 12:00:00	4	20
2994	2026-05-20 12:00:00	1	12
3005	2026-05-20 13:00:00	29	20
3015	2026-05-20 13:00:00	30	20
3024	2026-05-20 13:00:00	26	40
3033	2026-05-20 13:00:00	27	38.43
3040	2026-05-20 13:00:00	28	264
3059	2026-05-20 14:00:00	41	40
3069	2026-05-20 14:00:00	43	264
3081	2026-05-20 14:00:00	44	20
3091	2026-05-20 14:00:00	45	20
3099	2026-05-20 14:00:00	42	38.29
3103	2026-05-20 15:00:00	14	15
3112	2026-05-20 15:00:00	12	54.15
3123	2026-05-20 15:00:00	15	15
3131	2026-05-20 15:00:00	11	40
3142	2026-05-20 15:00:00	13	261
3159	2026-05-20 16:00:00	46	40
3171	2026-05-20 16:00:00	50	20
3181	2026-05-20 16:00:00	49	20
3189	2026-05-20 16:00:00	47	38.23
3196	2026-05-20 16:00:00	48	264
3205	2026-05-20 17:00:00	28	264
3214	2026-05-20 17:00:00	29	20
3222	2026-05-20 17:00:00	30	20
3234	2026-05-20 17:00:00	26	40
3243	2026-05-20 17:00:00	27	38.38
4131	2026-05-21 11:00:00	27	38.46
4141	2026-05-21 11:00:00	28	264
4158	2026-05-21 12:00:00	46	92
4171	2026-05-21 12:00:00	50	20
4174	2026-05-21 12:00:00	49	20
4184	2026-05-21 12:00:00	47	64.31
4196	2026-05-21 12:00:00	48	435.6
4210	2026-05-21 13:00:00	50	20
4217	2026-05-21 13:00:00	49	20
4227	2026-05-21 13:00:00	47	38.4
4234	2026-05-21 13:00:00	48	264
4244	2026-05-21 13:00:00	22	38.38
4245	2026-05-21 13:00:00	46	40
4257	2026-05-21 14:00:00	30	20
4260	2026-05-21 14:00:00	20	20
4266	2026-05-21 14:00:00	26	40
4268	2026-05-21 14:00:00	17	38.32
4276	2026-05-21 14:00:00	27	38.3
4277	2026-05-21 14:00:00	16	40
4282	2026-05-21 14:00:00	25	20
4287	2026-05-21 14:00:00	19	20
4289	2026-05-21 14:00:00	28	264
4295	2026-05-21 14:00:00	22	38.3
4297	2026-05-21 14:00:00	18	264
159	2026-05-18 04:00:00	46	20
170	2026-05-18 04:00:00	47	28.21
179	2026-05-18 04:00:00	48	198
191	2026-05-18 04:00:00	49	20
199	2026-05-18 04:00:00	50	20
204	2026-05-18 05:00:00	12	28.34
211	2026-05-18 05:00:00	11	20
220	2026-05-18 05:00:00	15	20
227	2026-05-18 05:00:00	13	198
238	2026-05-18 05:00:00	14	20
251	2026-05-18 06:00:00	3	171.6
253	2026-05-18 06:00:00	26	20
255	2026-05-18 06:00:00	12	28.24
252	2026-05-18 06:00:00	10	20
254	2026-05-18 06:00:00	19	20
256	2026-05-18 06:00:00	23	198
258	2026-05-18 06:00:00	37	28.3
257	2026-05-18 06:00:00	49	20
259	2026-05-18 06:00:00	42	28.21
260	2026-05-18 06:00:00	33	198
261	2026-05-18 06:00:00	2	24.26
262	2026-05-18 06:00:00	30	20
263	2026-05-18 06:00:00	6	12
264	2026-05-18 06:00:00	11	20
265	2026-05-18 06:00:00	50	20
266	2026-05-18 06:00:00	20	20
267	2026-05-18 06:00:00	24	20
268	2026-05-18 06:00:00	43	198
269	2026-05-18 06:00:00	38	198
270	2026-05-18 06:00:00	31	20
271	2026-05-18 06:00:00	1	12
272	2026-05-18 06:00:00	27	28.44
273	2026-05-18 06:00:00	15	20
274	2026-05-18 06:00:00	46	20
275	2026-05-18 06:00:00	44	20
276	2026-05-18 06:00:00	25	20
277	2026-05-18 06:00:00	4	20
278	2026-05-18 06:00:00	7	24.39
279	2026-05-18 06:00:00	28	198
280	2026-05-18 06:00:00	17	28.36
281	2026-05-18 06:00:00	40	20
282	2026-05-18 06:00:00	13	198
283	2026-05-18 06:00:00	34	20
284	2026-05-18 06:00:00	21	20
285	2026-05-18 06:00:00	36	20
286	2026-05-18 06:00:00	47	28.3
287	2026-05-18 06:00:00	45	20
288	2026-05-18 06:00:00	5	20
289	2026-05-18 06:00:00	9	20
290	2026-05-18 06:00:00	29	20
291	2026-05-18 06:00:00	16	20
292	2026-05-18 06:00:00	35	20
293	2026-05-18 06:00:00	14	20
294	2026-05-18 06:00:00	22	28.34
295	2026-05-18 06:00:00	41	20
296	2026-05-18 06:00:00	39	20
297	2026-05-18 06:00:00	48	198
298	2026-05-18 06:00:00	8	171.6
299	2026-05-18 06:00:00	32	28.39
300	2026-05-18 06:00:00	18	198
301	2026-05-18 07:00:00	5	20
302	2026-05-18 07:00:00	9	20
303	2026-05-18 07:00:00	13	198
304	2026-05-18 07:00:00	25	20
306	2026-05-18 07:00:00	29	20
305	2026-05-18 07:00:00	16	20
307	2026-05-18 07:00:00	36	20
308	2026-05-18 07:00:00	34	20
309	2026-05-18 07:00:00	42	28.46
310	2026-05-18 07:00:00	49	20
311	2026-05-18 07:00:00	3	171.6
312	2026-05-18 07:00:00	14	20
313	2026-05-18 07:00:00	21	20
314	2026-05-18 07:00:00	39	20
315	2026-05-18 07:00:00	8	171.6
316	2026-05-18 07:00:00	2	24.31
317	2026-05-18 07:00:00	26	20
318	2026-05-18 07:00:00	35	20
319	2026-05-18 07:00:00	19	20
320	2026-05-18 07:00:00	43	198
321	2026-05-18 07:00:00	12	28.21
322	2026-05-18 07:00:00	22	28.31
323	2026-05-18 07:00:00	37	28.21
324	2026-05-18 07:00:00	50	20
325	2026-05-18 07:00:00	1	12
326	2026-05-18 07:00:00	11	20
327	2026-05-18 07:00:00	23	198
328	2026-05-18 07:00:00	30	20
329	2026-05-18 07:00:00	10	20
330	2026-05-18 07:00:00	32	28.33
331	2026-05-18 07:00:00	18	198
332	2026-05-18 07:00:00	44	20
333	2026-05-18 07:00:00	4	20
334	2026-05-18 07:00:00	24	20
335	2026-05-18 07:00:00	38	198
336	2026-05-18 07:00:00	46	20
337	2026-05-18 07:00:00	6	12
338	2026-05-18 07:00:00	15	20
339	2026-05-18 07:00:00	20	20
340	2026-05-18 07:00:00	27	28.4
341	2026-05-18 07:00:00	33	198
342	2026-05-18 07:00:00	45	20
343	2026-05-18 07:00:00	7	24.47
344	2026-05-18 07:00:00	40	20
345	2026-05-18 07:00:00	47	28.47
346	2026-05-18 07:00:00	17	28.43
347	2026-05-18 07:00:00	28	198
348	2026-05-18 07:00:00	41	20
349	2026-05-18 07:00:00	31	20
350	2026-05-18 07:00:00	48	198
352	2026-05-18 08:00:00	5	20
351	2026-05-18 08:00:00	9	20
353	2026-05-18 08:00:00	13	198
355	2026-05-18 08:00:00	25	20
356	2026-05-18 08:00:00	28	198
354	2026-05-18 08:00:00	17	28.48
357	2026-05-18 08:00:00	33	198
358	2026-05-18 08:00:00	45	20
359	2026-05-18 08:00:00	49	20
360	2026-05-18 08:00:00	40	20
361	2026-05-18 08:00:00	8	171.6
362	2026-05-18 08:00:00	29	20
363	2026-05-18 08:00:00	21	20
364	2026-05-18 08:00:00	16	20
365	2026-05-18 08:00:00	50	20
366	2026-05-18 08:00:00	14	20
367	2026-05-18 08:00:00	31	20
368	2026-05-18 08:00:00	3	171.6
369	2026-05-18 08:00:00	36	20
370	2026-05-18 08:00:00	26	20
371	2026-05-18 08:00:00	22	28.25
372	2026-05-18 08:00:00	19	20
373	2026-05-18 08:00:00	46	20
374	2026-05-18 08:00:00	10	20
375	2026-05-18 08:00:00	41	20
376	2026-05-18 08:00:00	12	28.47
377	2026-05-18 08:00:00	34	20
390	2026-05-18 08:00:00	35	20
399	2026-05-18 08:00:00	32	28.42
401	2026-05-18 09:00:00	5	20
412	2026-05-18 09:00:00	3	171.6
422	2026-05-18 09:00:00	2	24.36
435	2026-05-18 09:00:00	1	12
444	2026-05-18 09:00:00	4	20
459	2026-05-18 10:00:00	38	198
463	2026-05-18 10:00:00	40	20
471	2026-05-18 10:00:00	36	20
482	2026-05-18 10:00:00	37	28.25
491	2026-05-18 10:00:00	39	20
508	2026-05-18 11:00:00	46	20
511	2026-05-18 11:00:00	47	28.27
518	2026-05-18 11:00:00	48	198
524	2026-05-18 11:00:00	49	20
534	2026-05-18 11:00:00	50	20
560	2026-05-18 12:00:00	50	20
569	2026-05-18 12:00:00	46	46
580	2026-05-18 12:00:00	47	41.32
591	2026-05-18 12:00:00	48	283.8
599	2026-05-18 12:00:00	49	20
602	2026-05-18 13:00:00	6	12
616	2026-05-18 13:00:00	9	20
627	2026-05-18 13:00:00	7	24.4
639	2026-05-18 13:00:00	8	171.6
645	2026-05-18 13:00:00	10	20
657	2026-05-18 14:00:00	26	20
667	2026-05-18 14:00:00	30	20
679	2026-05-18 14:00:00	27	28.46
686	2026-05-18 14:00:00	28	198
697	2026-05-18 14:00:00	29	20
701	2026-05-18 15:00:00	13	198
714	2026-05-18 15:00:00	14	20
724	2026-05-18 15:00:00	12	28.23
731	2026-05-18 15:00:00	11	20
739	2026-05-18 15:00:00	15	20
1260	2026-05-19 02:00:00	24	20
1274	2026-05-19 02:00:00	25	20
1287	2026-05-19 02:00:00	21	20
1294	2026-05-19 02:00:00	22	28.34
1300	2026-05-19 02:00:00	23	198
1301	2026-05-19 03:00:00	1	12
1316	2026-05-19 03:00:00	4	20
1329	2026-05-19 03:00:00	5	20
1341	2026-05-19 03:00:00	3	171.6
1348	2026-05-19 03:00:00	2	24.2
1354	2026-05-19 04:00:00	20	20
1362	2026-05-19 04:00:00	17	28.23
1372	2026-05-19 04:00:00	16	20
1382	2026-05-19 04:00:00	19	20
1392	2026-05-19 04:00:00	18	198
1409	2026-05-19 05:00:00	50	20
1418	2026-05-19 05:00:00	46	20
1430	2026-05-19 05:00:00	49	20
1441	2026-05-19 05:00:00	47	28.27
1449	2026-05-19 05:00:00	48	198
1453	2026-05-19 06:00:00	7	24.47
1467	2026-05-19 06:00:00	8	171.6
1477	2026-05-19 06:00:00	10	20
1488	2026-05-19 06:00:00	6	12
1497	2026-05-19 06:00:00	9	20
1503	2026-05-19 07:00:00	15	20
1511	2026-05-19 07:00:00	13	198
1524	2026-05-19 07:00:00	14	20
1536	2026-05-19 07:00:00	12	28.22
1546	2026-05-19 07:00:00	11	20
1554	2026-05-19 08:00:00	22	28.39
1569	2026-05-19 08:00:00	23	198
1582	2026-05-19 08:00:00	24	20
1592	2026-05-19 08:00:00	25	20
1598	2026-05-19 08:00:00	21	20
1604	2026-05-19 09:00:00	11	20
1612	2026-05-19 09:00:00	15	20
1622	2026-05-19 09:00:00	13	198
1633	2026-05-19 09:00:00	14	20
1642	2026-05-19 09:00:00	12	28.26
1660	2026-05-19 10:00:00	46	20
1670	2026-05-19 10:00:00	49	20
1681	2026-05-19 10:00:00	47	28.3
1690	2026-05-19 10:00:00	48	198
1700	2026-05-19 10:00:00	50	20
1702	2026-05-19 11:00:00	1	12
1715	2026-05-19 11:00:00	4	20
1726	2026-05-19 11:00:00	5	20
1736	2026-05-19 11:00:00	3	171.6
1745	2026-05-19 11:00:00	2	24.2
2760	2026-05-20 08:00:00	49	20
2770	2026-05-20 08:00:00	47	38.48
2775	2026-05-20 08:00:00	48	264
2785	2026-05-20 08:00:00	46	40
2796	2026-05-20 08:00:00	50	20
2803	2026-05-20 09:00:00	23	264
2815	2026-05-20 09:00:00	24	20
2825	2026-05-20 09:00:00	21	40
2836	2026-05-20 09:00:00	25	20
2847	2026-05-20 09:00:00	22	38.35
2856	2026-05-20 10:00:00	21	40
2861	2026-05-20 10:00:00	25	20
2871	2026-05-20 10:00:00	22	38.27
2881	2026-05-20 10:00:00	23	264
2889	2026-05-20 10:00:00	24	20
2910	2026-05-20 11:00:00	49	20
2918	2026-05-20 11:00:00	47	38.21
2932	2026-05-20 11:00:00	48	264
2943	2026-05-20 11:00:00	46	40
2950	2026-05-20 11:00:00	50	20
2951	2026-05-20 12:00:00	6	12
2964	2026-05-20 12:00:00	10	20
2974	2026-05-20 12:00:00	9	20
2987	2026-05-20 12:00:00	7	24.19
2998	2026-05-20 12:00:00	8	171.6
3001	2026-05-20 13:00:00	3	171.6
3011	2026-05-20 13:00:00	2	24.19
3021	2026-05-20 13:00:00	4	20
3031	2026-05-20 13:00:00	1	12
3044	2026-05-20 13:00:00	5	20
3057	2026-05-20 14:00:00	32	38.29
3062	2026-05-20 14:00:00	34	20
3070	2026-05-20 14:00:00	35	20
3074	2026-05-20 14:00:00	31	40
3082	2026-05-20 14:00:00	33	264
3111	2026-05-20 15:00:00	50	20
3124	2026-05-20 15:00:00	49	20
3135	2026-05-20 15:00:00	47	38.32
3147	2026-05-20 15:00:00	48	264
3150	2026-05-20 15:00:00	46	40
3151	2026-05-20 16:00:00	2	24.43
3161	2026-05-20 16:00:00	4	20
3170	2026-05-20 16:00:00	1	12
3180	2026-05-20 16:00:00	5	20
3191	2026-05-20 16:00:00	3	171.6
3209	2026-05-20 17:00:00	45	20
3216	2026-05-20 17:00:00	42	38.48
3226	2026-05-20 17:00:00	41	40
378	2026-05-18 08:00:00	2	24.29
389	2026-05-18 08:00:00	1	12
396	2026-05-18 08:00:00	4	20
402	2026-05-18 09:00:00	25	20
411	2026-05-18 09:00:00	21	20
421	2026-05-18 09:00:00	22	28.36
428	2026-05-18 09:00:00	23	198
434	2026-05-18 09:00:00	24	20
460	2026-05-18 10:00:00	49	20
462	2026-05-18 10:00:00	50	20
472	2026-05-18 10:00:00	46	20
484	2026-05-18 10:00:00	47	28.31
498	2026-05-18 10:00:00	48	198
509	2026-05-18 11:00:00	19	20
520	2026-05-18 11:00:00	18	198
529	2026-05-18 11:00:00	20	20
535	2026-05-18 11:00:00	17	28.39
546	2026-05-18 11:00:00	16	20
555	2026-05-18 12:00:00	15	20
566	2026-05-18 12:00:00	13	283.8
571	2026-05-18 12:00:00	14	20
577	2026-05-18 12:00:00	12	41.3
584	2026-05-18 12:00:00	11	46
609	2026-05-18 13:00:00	50	20
613	2026-05-18 13:00:00	46	20
623	2026-05-18 13:00:00	47	28.45
633	2026-05-18 13:00:00	48	198
641	2026-05-18 13:00:00	49	20
659	2026-05-18 14:00:00	45	20
668	2026-05-18 14:00:00	41	20
681	2026-05-18 14:00:00	42	28.2
692	2026-05-18 14:00:00	43	198
699	2026-05-18 14:00:00	44	20
703	2026-05-18 15:00:00	2	24.19
717	2026-05-18 15:00:00	1	12
726	2026-05-18 15:00:00	4	20
737	2026-05-18 15:00:00	5	20
747	2026-05-18 15:00:00	3	171.6
1751	2026-05-19 12:00:00	2	24.23
1761	2026-05-19 12:00:00	1	12
1772	2026-05-19 12:00:00	4	20
1782	2026-05-19 12:00:00	5	20
1792	2026-05-19 12:00:00	3	171.6
1803	2026-05-19 13:00:00	26	20
1816	2026-05-19 13:00:00	30	20
1824	2026-05-19 13:00:00	27	28.27
1834	2026-05-19 13:00:00	28	198
1844	2026-05-19 13:00:00	29	20
1859	2026-05-19 14:00:00	45	20
1869	2026-05-19 14:00:00	41	20
1880	2026-05-19 14:00:00	42	28.28
1891	2026-05-19 14:00:00	43	198
1898	2026-05-19 14:00:00	44	20
1903	2026-05-19 15:00:00	13	198
1912	2026-05-19 15:00:00	14	20
1928	2026-05-19 15:00:00	12	28.25
1940	2026-05-19 15:00:00	11	20
1948	2026-05-19 15:00:00	15	20
1951	2026-05-19 16:00:00	2	24.3
1966	2026-05-19 16:00:00	1	12
1978	2026-05-19 16:00:00	4	20
1989	2026-05-19 16:00:00	5	20
1998	2026-05-19 16:00:00	3	171.6
2002	2026-05-19 17:00:00	8	171.6
2015	2026-05-19 17:00:00	10	20
2026	2026-05-19 17:00:00	6	12
2034	2026-05-19 17:00:00	9	20
2041	2026-05-19 17:00:00	7	24.38
2056	2026-05-19 18:00:00	37	28.39
2064	2026-05-19 18:00:00	39	20
2076	2026-05-19 18:00:00	38	198
2088	2026-05-19 18:00:00	40	20
2096	2026-05-19 18:00:00	36	20
2104	2026-05-19 19:00:00	18	198
2116	2026-05-19 19:00:00	20	20
2127	2026-05-19 19:00:00	17	28.41
2136	2026-05-19 19:00:00	16	20
2144	2026-05-19 19:00:00	19	20
2153	2026-05-19 20:00:00	34	20
2167	2026-05-19 20:00:00	35	20
2180	2026-05-19 20:00:00	33	198
2189	2026-05-19 20:00:00	32	28.26
2199	2026-05-19 20:00:00	31	20
2203	2026-05-19 21:00:00	19	20
2212	2026-05-19 21:00:00	18	198
2221	2026-05-19 21:00:00	20	20
2227	2026-05-19 21:00:00	17	28.35
2238	2026-05-19 21:00:00	16	20
3079	2026-05-20 14:00:00	46	40
3089	2026-05-20 14:00:00	50	20
3098	2026-05-20 14:00:00	49	20
3101	2026-05-20 15:00:00	2	24.47
3110	2026-05-20 15:00:00	4	20
3120	2026-05-20 15:00:00	1	12
3130	2026-05-20 15:00:00	5	20
3140	2026-05-20 15:00:00	3	171.6
3160	2026-05-20 16:00:00	45	20
3167	2026-05-20 16:00:00	42	38.2
3179	2026-05-20 16:00:00	41	40
3185	2026-05-20 16:00:00	43	264
3199	2026-05-20 16:00:00	44	20
3201	2026-05-20 17:00:00	4	20
3212	2026-05-20 17:00:00	1	12
3223	2026-05-20 17:00:00	5	20
3235	2026-05-20 17:00:00	3	171.6
3245	2026-05-20 17:00:00	2	24.47
4134	2026-05-21 11:00:00	47	38.28
4149	2026-05-21 11:00:00	48	264
4155	2026-05-21 12:00:00	22	64.27
4165	2026-05-21 12:00:00	23	435.6
4180	2026-05-21 12:00:00	24	20
4190	2026-05-21 12:00:00	21	92
4198	2026-05-21 12:00:00	25	20
4209	2026-05-21 13:00:00	41	40
4218	2026-05-21 13:00:00	43	264
4224	2026-05-21 13:00:00	44	20
4238	2026-05-21 13:00:00	45	20
4246	2026-05-21 13:00:00	2	24.32
4247	2026-05-21 13:00:00	42	38.32
4255	2026-05-21 14:00:00	37	38.46
4256	2026-05-21 14:00:00	34	20
4267	2026-05-21 14:00:00	35	20
4270	2026-05-21 14:00:00	39	20
4278	2026-05-21 14:00:00	31	40
4283	2026-05-21 14:00:00	36	40
4285	2026-05-21 14:00:00	33	264
4293	2026-05-21 14:00:00	32	38.21
4294	2026-05-21 14:00:00	38	264
4298	2026-05-21 14:00:00	29	20
4300	2026-05-21 14:00:00	40	20
4301	2026-05-21 15:00:00	5	20
4305	2026-05-21 15:00:00	24	20
4309	2026-05-21 15:00:00	35	20
4315	2026-05-21 15:00:00	3	171.6
4319	2026-05-21 15:00:00	21	40
4320	2026-05-21 15:00:00	31	40
379	2026-05-18 08:00:00	39	20
391	2026-05-18 08:00:00	37	28.37
400	2026-05-18 08:00:00	38	198
403	2026-05-18 09:00:00	7	24.29
416	2026-05-18 09:00:00	8	171.6
425	2026-05-18 09:00:00	10	20
436	2026-05-18 09:00:00	6	12
446	2026-05-18 09:00:00	9	20
455	2026-05-18 10:00:00	13	198
465	2026-05-18 10:00:00	14	20
473	2026-05-18 10:00:00	12	28.21
481	2026-05-18 10:00:00	11	20
492	2026-05-18 10:00:00	15	20
510	2026-05-18 11:00:00	36	20
521	2026-05-18 11:00:00	37	28.31
531	2026-05-18 11:00:00	39	20
540	2026-05-18 11:00:00	38	198
549	2026-05-18 11:00:00	40	20
553	2026-05-18 12:00:00	17	41.31
562	2026-05-18 12:00:00	16	46
573	2026-05-18 12:00:00	19	20
583	2026-05-18 12:00:00	18	283.8
593	2026-05-18 12:00:00	20	20
608	2026-05-18 13:00:00	37	28.32
620	2026-05-18 13:00:00	39	20
631	2026-05-18 13:00:00	38	198
642	2026-05-18 13:00:00	40	20
650	2026-05-18 13:00:00	36	20
653	2026-05-18 14:00:00	15	20
662	2026-05-18 14:00:00	13	198
675	2026-05-18 14:00:00	14	20
689	2026-05-18 14:00:00	12	28.45
698	2026-05-18 14:00:00	11	20
704	2026-05-18 15:00:00	24	20
713	2026-05-18 15:00:00	25	20
723	2026-05-18 15:00:00	21	20
732	2026-05-18 15:00:00	22	28.38
742	2026-05-18 15:00:00	23	198
1752	2026-05-19 12:00:00	7	24.44
1764	2026-05-19 12:00:00	8	171.6
1775	2026-05-19 12:00:00	10	20
1786	2026-05-19 12:00:00	6	12
1798	2026-05-19 12:00:00	9	20
1805	2026-05-19 13:00:00	21	20
1811	2026-05-19 13:00:00	22	28.32
1822	2026-05-19 13:00:00	23	198
1836	2026-05-19 13:00:00	24	20
1845	2026-05-19 13:00:00	25	20
1855	2026-05-19 14:00:00	27	28.31
1866	2026-05-19 14:00:00	28	198
1876	2026-05-19 14:00:00	29	20
1883	2026-05-19 14:00:00	26	20
1895	2026-05-19 14:00:00	30	20
1906	2026-05-19 15:00:00	26	20
1920	2026-05-19 15:00:00	30	20
1929	2026-05-19 15:00:00	27	28.44
1945	2026-05-19 15:00:00	28	198
1950	2026-05-19 15:00:00	29	20
1952	2026-05-19 16:00:00	7	24.23
1963	2026-05-19 16:00:00	8	171.6
1974	2026-05-19 16:00:00	10	20
1985	2026-05-19 16:00:00	6	12
1997	2026-05-19 16:00:00	9	20
2006	2026-05-19 17:00:00	24	20
2019	2026-05-19 17:00:00	25	20
2033	2026-05-19 17:00:00	21	20
2044	2026-05-19 17:00:00	22	28.22
2050	2026-05-19 17:00:00	23	198
2051	2026-05-19 18:00:00	4	20
2066	2026-05-19 18:00:00	5	20
2075	2026-05-19 18:00:00	3	171.6
2087	2026-05-19 18:00:00	2	24.44
2093	2026-05-19 18:00:00	1	12
2107	2026-05-19 19:00:00	34	20
2112	2026-05-19 19:00:00	35	20
2121	2026-05-19 19:00:00	33	198
2125	2026-05-19 19:00:00	32	28.41
2133	2026-05-19 19:00:00	31	20
2160	2026-05-19 20:00:00	48	198
2166	2026-05-19 20:00:00	50	20
2176	2026-05-19 20:00:00	46	20
2186	2026-05-19 20:00:00	49	20
2196	2026-05-19 20:00:00	47	28.31
2206	2026-05-19 21:00:00	23	198
2215	2026-05-19 21:00:00	24	20
2231	2026-05-19 21:00:00	25	20
2239	2026-05-19 21:00:00	21	20
2247	2026-05-19 21:00:00	22	28.35
3239	2026-05-20 17:00:00	43	264
3249	2026-05-20 17:00:00	44	20
4161	2026-05-21 12:00:00	11	92
4168	2026-05-21 12:00:00	13	432.6
4179	2026-05-21 12:00:00	14	15
4187	2026-05-21 12:00:00	12	80.93
4215	2026-05-21 13:00:00	14	15
4229	2026-05-21 13:00:00	12	54.26
4236	2026-05-21 13:00:00	15	15
4248	2026-05-21 13:00:00	11	40
4253	2026-05-21 14:00:00	13	261
4262	2026-05-21 14:00:00	9	20
4263	2026-05-21 14:00:00	14	15
4272	2026-05-21 14:00:00	7	24.48
4274	2026-05-21 14:00:00	12	54.36
4281	2026-05-21 14:00:00	8	171.6
4286	2026-05-21 14:00:00	15	15
4292	2026-05-21 14:00:00	6	12
4296	2026-05-21 14:00:00	11	40
4303	2026-05-21 15:00:00	12	54.14
4307	2026-05-21 15:00:00	27	38.25
4310	2026-05-21 15:00:00	44	20
4312	2026-05-21 15:00:00	45	20
4313	2026-05-21 15:00:00	28	264
4316	2026-05-21 15:00:00	15	15
4322	2026-05-21 15:00:00	42	38.4
4323	2026-05-21 15:00:00	29	20
4325	2026-05-21 15:00:00	41	40
4326	2026-05-21 15:00:00	2	24.46
4327	2026-05-21 15:00:00	11	40
4331	2026-05-21 15:00:00	33	264
4333	2026-05-21 15:00:00	30	20
4335	2026-05-21 15:00:00	32	38.25
4337	2026-05-21 15:00:00	43	264
4339	2026-05-21 15:00:00	50	20
4340	2026-05-21 15:00:00	13	261
4341	2026-05-21 15:00:00	40	20
4342	2026-05-21 15:00:00	4	20
4343	2026-05-21 15:00:00	26	40
4344	2026-05-21 15:00:00	23	264
4345	2026-05-21 15:00:00	34	20
4346	2026-05-21 15:00:00	14	15
4347	2026-05-21 15:00:00	9	20
4348	2026-05-21 15:00:00	49	20
4349	2026-05-21 15:00:00	1	12
4350	2026-05-21 15:00:00	37	38.43
4351	2026-05-21 16:00:00	2	24.29
4352	2026-05-21 16:00:00	6	12
380	2026-05-18 08:00:00	42	28.24
387	2026-05-18 08:00:00	43	198
395	2026-05-18 08:00:00	44	20
410	2026-05-18 09:00:00	45	20
418	2026-05-18 09:00:00	41	20
429	2026-05-18 09:00:00	42	28.46
440	2026-05-18 09:00:00	43	198
449	2026-05-18 09:00:00	44	20
454	2026-05-18 10:00:00	7	24.49
470	2026-05-18 10:00:00	8	171.6
480	2026-05-18 10:00:00	10	20
490	2026-05-18 10:00:00	6	12
499	2026-05-18 10:00:00	9	20
501	2026-05-18 11:00:00	1	12
512	2026-05-18 11:00:00	4	20
523	2026-05-18 11:00:00	5	20
533	2026-05-18 11:00:00	3	171.6
542	2026-05-18 11:00:00	2	24.19
559	2026-05-18 12:00:00	41	46
563	2026-05-18 12:00:00	42	41.29
574	2026-05-18 12:00:00	43	283.8
585	2026-05-18 12:00:00	44	20
596	2026-05-18 12:00:00	45	20
603	2026-05-18 13:00:00	15	20
617	2026-05-18 13:00:00	13	198
626	2026-05-18 13:00:00	14	20
640	2026-05-18 13:00:00	12	28.22
648	2026-05-18 13:00:00	11	20
655	2026-05-18 14:00:00	23	198
670	2026-05-18 14:00:00	24	20
682	2026-05-18 14:00:00	25	20
693	2026-05-18 14:00:00	21	20
700	2026-05-18 14:00:00	22	28.41
702	2026-05-18 15:00:00	9	20
711	2026-05-18 15:00:00	7	24.21
721	2026-05-18 15:00:00	8	171.6
733	2026-05-18 15:00:00	10	20
744	2026-05-18 15:00:00	6	12
1756	2026-05-19 12:00:00	41	46
1765	2026-05-19 12:00:00	42	41.26
1778	2026-05-19 12:00:00	43	283.8
1788	2026-05-19 12:00:00	44	20
1797	2026-05-19 12:00:00	45	20
1806	2026-05-19 13:00:00	13	198
1819	2026-05-19 13:00:00	14	20
1829	2026-05-19 13:00:00	12	28.22
1839	2026-05-19 13:00:00	11	20
1848	2026-05-19 13:00:00	15	20
1853	2026-05-19 14:00:00	12	28.36
1867	2026-05-19 14:00:00	11	20
1879	2026-05-19 14:00:00	15	20
1889	2026-05-19 14:00:00	13	198
1896	2026-05-19 14:00:00	14	20
1902	2026-05-19 15:00:00	8	171.6
1913	2026-05-19 15:00:00	10	20
1927	2026-05-19 15:00:00	6	12
1937	2026-05-19 15:00:00	9	20
1947	2026-05-19 15:00:00	7	24.26
1954	2026-05-19 16:00:00	20	20
1964	2026-05-19 16:00:00	17	28.44
1972	2026-05-19 16:00:00	16	20
1980	2026-05-19 16:00:00	19	20
1987	2026-05-19 16:00:00	18	198
2010	2026-05-19 17:00:00	48	198
2023	2026-05-19 17:00:00	50	20
2031	2026-05-19 17:00:00	46	20
2038	2026-05-19 17:00:00	49	20
2046	2026-05-19 17:00:00	47	28.19
2054	2026-05-19 18:00:00	21	20
2061	2026-05-19 18:00:00	22	28.28
2071	2026-05-19 18:00:00	23	198
2083	2026-05-19 18:00:00	24	20
2095	2026-05-19 18:00:00	25	20
2106	2026-05-19 19:00:00	27	28.33
2120	2026-05-19 19:00:00	28	198
2132	2026-05-19 19:00:00	29	20
2142	2026-05-19 19:00:00	26	20
2150	2026-05-19 19:00:00	30	20
2151	2026-05-19 20:00:00	3	171.6
2161	2026-05-19 20:00:00	2	24.36
2173	2026-05-19 20:00:00	1	12
2182	2026-05-19 20:00:00	4	20
2195	2026-05-19 20:00:00	5	20
2205	2026-05-19 21:00:00	34	20
2214	2026-05-19 21:00:00	35	20
2226	2026-05-19 21:00:00	33	198
2235	2026-05-19 21:00:00	32	28.34
2245	2026-05-19 21:00:00	31	20
3251	2026-05-20 18:00:00	5	20
3262	2026-05-20 18:00:00	3	171.6
3272	2026-05-20 18:00:00	2	24.3
3283	2026-05-20 18:00:00	4	20
3292	2026-05-20 18:00:00	1	12
3308	2026-05-20 19:00:00	36	40
3316	2026-05-20 19:00:00	38	264
3325	2026-05-20 19:00:00	40	20
3338	2026-05-20 19:00:00	37	38.44
3345	2026-05-20 19:00:00	39	20
3354	2026-05-20 20:00:00	17	38.44
3366	2026-05-20 20:00:00	16	40
3372	2026-05-20 20:00:00	19	20
3380	2026-05-20 20:00:00	18	264
3391	2026-05-20 20:00:00	20	20
3410	2026-05-20 21:00:00	31	40
3419	2026-05-20 21:00:00	33	264
3431	2026-05-20 21:00:00	32	38.44
3438	2026-05-20 21:00:00	34	20
3448	2026-05-20 21:00:00	35	20
3455	2026-05-20 22:00:00	18	264
3463	2026-05-20 22:00:00	20	20
3475	2026-05-20 22:00:00	17	38.37
3484	2026-05-20 22:00:00	16	40
3495	2026-05-20 22:00:00	19	20
3505	2026-05-20 23:00:00	25	20
3513	2026-05-20 23:00:00	22	38.32
3527	2026-05-20 23:00:00	23	264
3537	2026-05-20 23:00:00	24	20
3547	2026-05-20 23:00:00	21	40
3553	2026-05-21 00:00:00	16	40
3570	2026-05-21 00:00:00	19	20
3589	2026-05-21 00:00:00	18	264
3599	2026-05-21 00:00:00	20	20
3600	2026-05-21 00:00:00	17	38.39
3601	2026-05-21 01:00:00	1	12
3611	2026-05-21 01:00:00	5	20
3623	2026-05-21 01:00:00	3	171.6
3631	2026-05-21 01:00:00	2	24.26
3642	2026-05-21 01:00:00	4	20
3660	2026-05-21 02:00:00	35	20
3664	2026-05-21 02:00:00	31	40
3676	2026-05-21 02:00:00	33	264
3686	2026-05-21 02:00:00	32	38.35
3698	2026-05-21 02:00:00	34	20
4167	2026-05-21 12:00:00	30	20
4175	2026-05-21 12:00:00	26	92
4183	2026-05-21 12:00:00	27	64.2
381	2026-05-18 08:00:00	11	20
388	2026-05-18 08:00:00	15	20
405	2026-05-18 09:00:00	49	20
414	2026-05-18 09:00:00	50	20
426	2026-05-18 09:00:00	46	20
438	2026-05-18 09:00:00	47	28.21
445	2026-05-18 09:00:00	48	198
456	2026-05-18 10:00:00	21	20
469	2026-05-18 10:00:00	22	28.45
479	2026-05-18 10:00:00	23	198
489	2026-05-18 10:00:00	24	20
500	2026-05-18 10:00:00	25	20
502	2026-05-18 11:00:00	8	171.6
515	2026-05-18 11:00:00	10	20
525	2026-05-18 11:00:00	6	12
537	2026-05-18 11:00:00	9	20
544	2026-05-18 11:00:00	7	24.47
558	2026-05-18 12:00:00	31	46
567	2026-05-18 12:00:00	34	20
581	2026-05-18 12:00:00	35	20
588	2026-05-18 12:00:00	33	283.8
600	2026-05-18 12:00:00	32	41.33
601	2026-05-18 13:00:00	5	20
611	2026-05-18 13:00:00	3	171.6
618	2026-05-18 13:00:00	2	24.4
634	2026-05-18 13:00:00	1	12
644	2026-05-18 13:00:00	4	20
658	2026-05-18 14:00:00	32	28.21
669	2026-05-18 14:00:00	31	20
680	2026-05-18 14:00:00	34	20
688	2026-05-18 14:00:00	35	20
695	2026-05-18 14:00:00	33	198
709	2026-05-18 15:00:00	39	20
720	2026-05-18 15:00:00	38	198
729	2026-05-18 15:00:00	40	20
741	2026-05-18 15:00:00	36	20
748	2026-05-18 15:00:00	37	28.3
1758	2026-05-19 12:00:00	35	20
1762	2026-05-19 12:00:00	33	283.8
1771	2026-05-19 12:00:00	32	41.35
1780	2026-05-19 12:00:00	31	46
1790	2026-05-19 12:00:00	34	20
1810	2026-05-19 13:00:00	49	20
1817	2026-05-19 13:00:00	47	28.37
1826	2026-05-19 13:00:00	48	198
1832	2026-05-19 13:00:00	50	20
1842	2026-05-19 13:00:00	46	20
1857	2026-05-19 14:00:00	31	20
1868	2026-05-19 14:00:00	34	20
1877	2026-05-19 14:00:00	35	20
1886	2026-05-19 14:00:00	33	198
1894	2026-05-19 14:00:00	32	28.27
1908	2026-05-19 15:00:00	36	20
1916	2026-05-19 15:00:00	37	28.41
1924	2026-05-19 15:00:00	39	20
1931	2026-05-19 15:00:00	38	198
1943	2026-05-19 15:00:00	40	20
1959	2026-05-19 16:00:00	43	198
1969	2026-05-19 16:00:00	44	20
1981	2026-05-19 16:00:00	45	20
1991	2026-05-19 16:00:00	41	20
1999	2026-05-19 16:00:00	42	28.38
2003	2026-05-19 17:00:00	15	20
2011	2026-05-19 17:00:00	13	198
2020	2026-05-19 17:00:00	14	20
2027	2026-05-19 17:00:00	12	28.26
2035	2026-05-19 17:00:00	11	20
2057	2026-05-19 18:00:00	50	20
2069	2026-05-19 18:00:00	46	20
2082	2026-05-19 18:00:00	49	20
2091	2026-05-19 18:00:00	47	28.3
2099	2026-05-19 18:00:00	48	198
2101	2026-05-19 19:00:00	8	171.6
2111	2026-05-19 19:00:00	10	20
2124	2026-05-19 19:00:00	6	12
2138	2026-05-19 19:00:00	9	20
2146	2026-05-19 19:00:00	7	24.29
2156	2026-05-19 20:00:00	26	20
2168	2026-05-19 20:00:00	30	20
2177	2026-05-19 20:00:00	27	28.36
2188	2026-05-19 20:00:00	28	198
2197	2026-05-19 20:00:00	29	20
2204	2026-05-19 21:00:00	12	28.38
2219	2026-05-19 21:00:00	11	20
2222	2026-05-19 21:00:00	15	20
2232	2026-05-19 21:00:00	13	198
2244	2026-05-19 21:00:00	14	20
3253	2026-05-20 18:00:00	11	40
3266	2026-05-20 18:00:00	13	261
3273	2026-05-20 18:00:00	14	15
3280	2026-05-20 18:00:00	12	54.23
3290	2026-05-20 18:00:00	15	15
3321	2026-05-20 19:00:00	50	20
3331	2026-05-20 19:00:00	49	20
3341	2026-05-20 19:00:00	47	38.29
3347	2026-05-20 19:00:00	48	264
3349	2026-05-20 19:00:00	46	40
3352	2026-05-20 20:00:00	9	20
3365	2026-05-20 20:00:00	7	24.28
3374	2026-05-20 20:00:00	8	171.6
3383	2026-05-20 20:00:00	6	12
3393	2026-05-20 20:00:00	10	20
3406	2026-05-20 21:00:00	27	38.3
3412	2026-05-20 21:00:00	28	264
3422	2026-05-20 21:00:00	29	20
3432	2026-05-20 21:00:00	30	20
3443	2026-05-20 21:00:00	26	40
3459	2026-05-20 22:00:00	46	40
3466	2026-05-20 22:00:00	50	20
3476	2026-05-20 22:00:00	49	20
3487	2026-05-20 22:00:00	47	38.46
3499	2026-05-20 22:00:00	48	264
3502	2026-05-20 23:00:00	10	20
3514	2026-05-20 23:00:00	9	20
3524	2026-05-20 23:00:00	7	24.33
3534	2026-05-20 23:00:00	8	171.6
3545	2026-05-20 23:00:00	6	12
3555	2026-05-21 00:00:00	29	20
3568	2026-05-21 00:00:00	30	20
3576	2026-05-21 00:00:00	26	40
3582	2026-05-21 00:00:00	27	38.34
3593	2026-05-21 00:00:00	28	264
3605	2026-05-21 01:00:00	28	264
3612	2026-05-21 01:00:00	29	20
3621	2026-05-21 01:00:00	30	20
3632	2026-05-21 01:00:00	26	40
3647	2026-05-21 01:00:00	27	38.27
3656	2026-05-21 02:00:00	24	20
3670	2026-05-21 02:00:00	21	40
3679	2026-05-21 02:00:00	25	20
3690	2026-05-21 02:00:00	22	38.44
3699	2026-05-21 02:00:00	23	264
4178	2026-05-21 12:00:00	36	92
4189	2026-05-21 12:00:00	38	435.6
4219	2026-05-21 13:00:00	17	38.32
4225	2026-05-21 13:00:00	16	40
382	2026-05-18 08:00:00	23	198
392	2026-05-18 08:00:00	24	20
406	2026-05-18 09:00:00	33	198
413	2026-05-18 09:00:00	32	28.37
427	2026-05-18 09:00:00	31	20
437	2026-05-18 09:00:00	34	20
447	2026-05-18 09:00:00	35	20
457	2026-05-18 10:00:00	28	198
466	2026-05-18 10:00:00	29	20
475	2026-05-18 10:00:00	26	20
483	2026-05-18 10:00:00	30	20
493	2026-05-18 10:00:00	27	28.42
506	2026-05-18 11:00:00	34	20
513	2026-05-18 11:00:00	35	20
522	2026-05-18 11:00:00	33	198
532	2026-05-18 11:00:00	32	28.39
543	2026-05-18 11:00:00	31	20
556	2026-05-18 12:00:00	25	20
568	2026-05-18 12:00:00	21	46
579	2026-05-18 12:00:00	22	41.25
590	2026-05-18 12:00:00	23	283.8
597	2026-05-18 12:00:00	24	20
606	2026-05-18 13:00:00	26	20
614	2026-05-18 13:00:00	30	20
624	2026-05-18 13:00:00	27	28.42
628	2026-05-18 13:00:00	28	198
638	2026-05-18 13:00:00	29	20
656	2026-05-18 14:00:00	37	28.28
666	2026-05-18 14:00:00	39	20
673	2026-05-18 14:00:00	38	198
683	2026-05-18 14:00:00	40	20
687	2026-05-18 14:00:00	36	20
710	2026-05-18 15:00:00	41	20
712	2026-05-18 15:00:00	42	28.2
722	2026-05-18 15:00:00	43	198
734	2026-05-18 15:00:00	44	20
745	2026-05-18 15:00:00	45	20
1759	2026-05-19 12:00:00	49	20
1769	2026-05-19 12:00:00	47	41.37
1779	2026-05-19 12:00:00	48	283.8
1789	2026-05-19 12:00:00	50	20
1799	2026-05-19 12:00:00	46	46
1801	2026-05-19 13:00:00	1	12
1814	2026-05-19 13:00:00	4	20
1827	2026-05-19 13:00:00	5	20
1838	2026-05-19 13:00:00	3	171.6
1849	2026-05-19 13:00:00	2	24.24
1854	2026-05-19 14:00:00	16	20
1865	2026-05-19 14:00:00	19	20
1874	2026-05-19 14:00:00	18	198
1885	2026-05-19 14:00:00	20	20
1897	2026-05-19 14:00:00	17	28.4
1905	2026-05-19 15:00:00	25	20
1918	2026-05-19 15:00:00	21	20
1926	2026-05-19 15:00:00	22	28.46
1935	2026-05-19 15:00:00	23	198
1944	2026-05-19 15:00:00	24	20
1958	2026-05-19 16:00:00	28	198
1970	2026-05-19 16:00:00	29	20
1982	2026-05-19 16:00:00	26	20
1993	2026-05-19 16:00:00	30	20
2000	2026-05-19 16:00:00	27	28.29
2001	2026-05-19 17:00:00	2	24.48
2014	2026-05-19 17:00:00	1	12
2024	2026-05-19 17:00:00	4	20
2036	2026-05-19 17:00:00	5	20
2048	2026-05-19 17:00:00	3	171.6
2055	2026-05-19 18:00:00	16	20
2070	2026-05-19 18:00:00	19	20
2081	2026-05-19 18:00:00	18	198
2092	2026-05-19 18:00:00	20	20
2100	2026-05-19 18:00:00	17	28.43
2102	2026-05-19 19:00:00	2	24.43
2115	2026-05-19 19:00:00	1	12
2130	2026-05-19 19:00:00	4	20
2141	2026-05-19 19:00:00	5	20
2149	2026-05-19 19:00:00	3	171.6
2157	2026-05-19 20:00:00	19	20
2162	2026-05-19 20:00:00	18	198
2171	2026-05-19 20:00:00	20	20
2181	2026-05-19 20:00:00	17	28.35
2191	2026-05-19 20:00:00	16	20
2210	2026-05-19 21:00:00	48	198
2218	2026-05-19 21:00:00	50	20
2223	2026-05-19 21:00:00	46	20
2233	2026-05-19 21:00:00	49	20
2242	2026-05-19 21:00:00	47	28.43
3252	2026-05-20 18:00:00	39	20
3265	2026-05-20 18:00:00	36	40
3276	2026-05-20 18:00:00	38	264
3285	2026-05-20 18:00:00	40	20
3294	2026-05-20 18:00:00	37	38.19
3305	2026-05-20 19:00:00	35	20
3311	2026-05-20 19:00:00	31	40
3318	2026-05-20 19:00:00	33	264
3324	2026-05-20 19:00:00	32	38.3
3333	2026-05-20 19:00:00	34	20
3359	2026-05-20 20:00:00	49	20
3369	2026-05-20 20:00:00	47	38.43
3377	2026-05-20 20:00:00	48	264
3388	2026-05-20 20:00:00	46	40
3397	2026-05-20 20:00:00	50	20
3405	2026-05-20 21:00:00	20	20
3417	2026-05-20 21:00:00	17	38.43
3427	2026-05-20 21:00:00	16	40
3440	2026-05-20 21:00:00	19	20
3449	2026-05-20 21:00:00	18	264
3452	2026-05-20 22:00:00	10	20
3464	2026-05-20 22:00:00	9	20
3477	2026-05-20 22:00:00	7	24.41
3488	2026-05-20 22:00:00	8	171.6
3498	2026-05-20 22:00:00	6	12
3503	2026-05-20 23:00:00	20	20
3511	2026-05-20 23:00:00	17	38.21
3521	2026-05-20 23:00:00	16	40
3528	2026-05-20 23:00:00	19	20
3536	2026-05-20 23:00:00	18	264
3559	2026-05-21 00:00:00	49	20
3561	2026-05-21 00:00:00	47	38.29
3571	2026-05-21 00:00:00	48	264
3580	2026-05-21 00:00:00	46	40
3588	2026-05-21 00:00:00	50	20
3610	2026-05-21 01:00:00	42	38.37
3620	2026-05-21 01:00:00	41	40
3629	2026-05-21 01:00:00	43	264
3639	2026-05-21 01:00:00	44	20
3648	2026-05-21 01:00:00	45	20
3652	2026-05-21 02:00:00	10	20
3661	2026-05-21 02:00:00	9	20
3671	2026-05-21 02:00:00	7	24.22
3681	2026-05-21 02:00:00	8	171.6
3687	2026-05-21 02:00:00	6	12
4195	2026-05-21 12:00:00	28	435.6
4220	2026-05-21 13:00:00	24	20
4223	2026-05-21 13:00:00	21	40
4232	2026-05-21 13:00:00	25	20
383	2026-05-18 08:00:00	18	198
393	2026-05-18 08:00:00	20	20
409	2026-05-18 09:00:00	39	20
417	2026-05-18 09:00:00	38	198
430	2026-05-18 09:00:00	40	20
439	2026-05-18 09:00:00	36	20
450	2026-05-18 09:00:00	37	28.48
451	2026-05-18 10:00:00	3	171.6
461	2026-05-18 10:00:00	2	24.37
474	2026-05-18 10:00:00	1	12
485	2026-05-18 10:00:00	4	20
497	2026-05-18 10:00:00	5	20
504	2026-05-18 11:00:00	12	28.23
514	2026-05-18 11:00:00	11	20
528	2026-05-18 11:00:00	15	20
539	2026-05-18 11:00:00	13	198
548	2026-05-18 11:00:00	14	20
552	2026-05-18 12:00:00	9	20
565	2026-05-18 12:00:00	7	24.37
575	2026-05-18 12:00:00	8	171.6
587	2026-05-18 12:00:00	10	20
595	2026-05-18 12:00:00	6	12
607	2026-05-18 13:00:00	32	28.42
621	2026-05-18 13:00:00	31	20
632	2026-05-18 13:00:00	34	20
643	2026-05-18 13:00:00	35	20
649	2026-05-18 13:00:00	33	198
651	2026-05-18 14:00:00	4	20
661	2026-05-18 14:00:00	5	20
665	2026-05-18 14:00:00	3	171.6
672	2026-05-18 14:00:00	2	24.41
677	2026-05-18 14:00:00	1	12
707	2026-05-18 15:00:00	48	198
715	2026-05-18 15:00:00	50	20
725	2026-05-18 15:00:00	46	20
735	2026-05-18 15:00:00	49	20
743	2026-05-18 15:00:00	47	28.49
1755	2026-05-19 12:00:00	25	20
1766	2026-05-19 12:00:00	21	46
1777	2026-05-19 12:00:00	22	41.32
1787	2026-05-19 12:00:00	23	283.8
1795	2026-05-19 12:00:00	24	20
1808	2026-05-19 13:00:00	42	28.31
1812	2026-05-19 13:00:00	43	198
1821	2026-05-19 13:00:00	44	20
1831	2026-05-19 13:00:00	45	20
1840	2026-05-19 13:00:00	41	20
1860	2026-05-19 14:00:00	48	198
1872	2026-05-19 14:00:00	50	20
1882	2026-05-19 14:00:00	46	20
1892	2026-05-19 14:00:00	49	20
1900	2026-05-19 14:00:00	47	28.19
1901	2026-05-19 15:00:00	1	12
1911	2026-05-19 15:00:00	4	20
1921	2026-05-19 15:00:00	5	20
1934	2026-05-19 15:00:00	3	171.6
1946	2026-05-19 15:00:00	2	24.2
1955	2026-05-19 16:00:00	24	20
1967	2026-05-19 16:00:00	25	20
1977	2026-05-19 16:00:00	21	20
1990	2026-05-19 16:00:00	22	28.2
1996	2026-05-19 16:00:00	23	198
2004	2026-05-19 17:00:00	20	20
2012	2026-05-19 17:00:00	17	28.45
2021	2026-05-19 17:00:00	16	20
2025	2026-05-19 17:00:00	19	20
2040	2026-05-19 17:00:00	18	198
2060	2026-05-19 18:00:00	44	20
2068	2026-05-19 18:00:00	45	20
2077	2026-05-19 18:00:00	41	20
2086	2026-05-19 18:00:00	42	28.21
2097	2026-05-19 18:00:00	43	198
2105	2026-05-19 19:00:00	24	20
2118	2026-05-19 19:00:00	25	20
2123	2026-05-19 19:00:00	21	20
2134	2026-05-19 19:00:00	22	28.42
2145	2026-05-19 19:00:00	23	198
2155	2026-05-19 20:00:00	12	28.33
2169	2026-05-19 20:00:00	11	20
2179	2026-05-19 20:00:00	15	20
2190	2026-05-19 20:00:00	13	198
2200	2026-05-19 20:00:00	14	20
2201	2026-05-19 21:00:00	3	171.6
2211	2026-05-19 21:00:00	2	24.45
2224	2026-05-19 21:00:00	1	12
2234	2026-05-19 21:00:00	4	20
2243	2026-05-19 21:00:00	5	20
3254	2026-05-20 18:00:00	24	20
3264	2026-05-20 18:00:00	21	40
3277	2026-05-20 18:00:00	25	20
3288	2026-05-20 18:00:00	22	38.34
3298	2026-05-20 18:00:00	23	264
3301	2026-05-20 19:00:00	6	12
3312	2026-05-20 19:00:00	10	20
3322	2026-05-20 19:00:00	9	20
3329	2026-05-20 19:00:00	7	24.34
3339	2026-05-20 19:00:00	8	171.6
3355	2026-05-20 20:00:00	40	20
3367	2026-05-20 20:00:00	37	38.47
3373	2026-05-20 20:00:00	39	20
3381	2026-05-20 20:00:00	36	40
3390	2026-05-20 20:00:00	38	264
3409	2026-05-20 21:00:00	42	38.29
3420	2026-05-20 21:00:00	41	40
3430	2026-05-20 21:00:00	43	264
3441	2026-05-20 21:00:00	44	20
3450	2026-05-20 21:00:00	45	20
3453	2026-05-20 22:00:00	12	54.11
3467	2026-05-20 22:00:00	15	15
3478	2026-05-20 22:00:00	11	40
3489	2026-05-20 22:00:00	13	261
3497	2026-05-20 22:00:00	14	15
3504	2026-05-20 23:00:00	12	54.15
3518	2026-05-20 23:00:00	15	15
3531	2026-05-20 23:00:00	11	40
3541	2026-05-20 23:00:00	13	261
3548	2026-05-20 23:00:00	14	15
3552	2026-05-21 00:00:00	7	24.25
3567	2026-05-21 00:00:00	8	171.6
3578	2026-05-21 00:00:00	6	12
3587	2026-05-21 00:00:00	10	20
3594	2026-05-21 00:00:00	9	20
3606	2026-05-21 01:00:00	35	20
3618	2026-05-21 01:00:00	31	40
3627	2026-05-21 01:00:00	33	264
3636	2026-05-21 01:00:00	32	38.31
3641	2026-05-21 01:00:00	34	20
3659	2026-05-21 02:00:00	37	38.3
3669	2026-05-21 02:00:00	39	20
3680	2026-05-21 02:00:00	36	40
3691	2026-05-21 02:00:00	38	264
3700	2026-05-21 02:00:00	40	20
4200	2026-05-21 12:00:00	10	20
4237	2026-05-21 13:00:00	19	20
4249	2026-05-21 13:00:00	18	264
4252	2026-05-21 14:00:00	10	20
384	2026-05-18 08:00:00	30	20
394	2026-05-18 08:00:00	27	28.45
407	2026-05-18 09:00:00	28	198
419	2026-05-18 09:00:00	29	20
423	2026-05-18 09:00:00	26	20
432	2026-05-18 09:00:00	30	20
443	2026-05-18 09:00:00	27	28.24
458	2026-05-18 10:00:00	41	20
464	2026-05-18 10:00:00	42	28.39
478	2026-05-18 10:00:00	43	198
486	2026-05-18 10:00:00	44	20
496	2026-05-18 10:00:00	45	20
507	2026-05-18 11:00:00	43	198
517	2026-05-18 11:00:00	44	20
526	2026-05-18 11:00:00	45	20
538	2026-05-18 11:00:00	41	20
547	2026-05-18 11:00:00	42	28.3
557	2026-05-18 12:00:00	27	41.21
570	2026-05-18 12:00:00	28	283.8
582	2026-05-18 12:00:00	29	20
592	2026-05-18 12:00:00	26	46
598	2026-05-18 12:00:00	30	20
604	2026-05-18 13:00:00	20	20
612	2026-05-18 13:00:00	17	28.4
622	2026-05-18 13:00:00	16	20
629	2026-05-18 13:00:00	19	20
637	2026-05-18 13:00:00	18	198
660	2026-05-18 14:00:00	47	28.2
671	2026-05-18 14:00:00	48	198
678	2026-05-18 14:00:00	50	20
685	2026-05-18 14:00:00	46	20
694	2026-05-18 14:00:00	49	20
705	2026-05-18 15:00:00	30	20
719	2026-05-18 15:00:00	27	28.3
730	2026-05-18 15:00:00	28	198
740	2026-05-18 15:00:00	29	20
750	2026-05-18 15:00:00	26	20
1753	2026-05-19 12:00:00	12	41.37
1767	2026-05-19 12:00:00	11	46
1773	2026-05-19 12:00:00	15	20
1783	2026-05-19 12:00:00	13	283.8
1793	2026-05-19 12:00:00	14	20
1809	2026-05-19 13:00:00	40	20
1818	2026-05-19 13:00:00	36	20
1825	2026-05-19 13:00:00	37	28.47
1833	2026-05-19 13:00:00	39	20
1843	2026-05-19 13:00:00	38	198
1858	2026-05-19 14:00:00	37	28.32
1862	2026-05-19 14:00:00	39	20
1871	2026-05-19 14:00:00	38	198
1881	2026-05-19 14:00:00	40	20
1888	2026-05-19 14:00:00	36	20
1910	2026-05-19 15:00:00	46	20
1915	2026-05-19 15:00:00	49	20
1923	2026-05-19 15:00:00	47	28.2
1932	2026-05-19 15:00:00	48	198
1938	2026-05-19 15:00:00	50	20
1956	2026-05-19 16:00:00	36	20
1962	2026-05-19 16:00:00	37	28.32
1971	2026-05-19 16:00:00	39	20
1979	2026-05-19 16:00:00	38	198
1988	2026-05-19 16:00:00	40	20
2007	2026-05-19 17:00:00	43	198
2017	2026-05-19 17:00:00	44	20
2028	2026-05-19 17:00:00	45	20
2039	2026-05-19 17:00:00	41	20
2047	2026-05-19 17:00:00	42	28.32
2053	2026-05-19 18:00:00	14	20
2067	2026-05-19 18:00:00	12	28.36
2078	2026-05-19 18:00:00	11	20
2090	2026-05-19 18:00:00	15	20
2098	2026-05-19 18:00:00	13	198
2103	2026-05-19 19:00:00	11	20
2117	2026-05-19 19:00:00	15	20
2129	2026-05-19 19:00:00	13	198
2139	2026-05-19 19:00:00	14	20
2147	2026-05-19 19:00:00	12	28.35
2154	2026-05-19 20:00:00	23	198
2165	2026-05-19 20:00:00	24	20
2174	2026-05-19 20:00:00	25	20
2184	2026-05-19 20:00:00	21	20
2194	2026-05-19 20:00:00	22	28.2
2207	2026-05-19 21:00:00	26	20
2216	2026-05-19 21:00:00	30	20
2229	2026-05-19 21:00:00	27	28.23
2240	2026-05-19 21:00:00	28	198
2248	2026-05-19 21:00:00	29	20
3256	2026-05-20 18:00:00	8	171.6
3267	2026-05-20 18:00:00	6	12
3275	2026-05-20 18:00:00	10	20
3284	2026-05-20 18:00:00	9	20
3295	2026-05-20 18:00:00	7	24.26
3306	2026-05-20 19:00:00	26	40
3315	2026-05-20 19:00:00	27	38.25
3327	2026-05-20 19:00:00	28	264
3336	2026-05-20 19:00:00	29	20
3344	2026-05-20 19:00:00	30	20
3356	2026-05-20 20:00:00	29	20
3368	2026-05-20 20:00:00	30	20
3382	2026-05-20 20:00:00	26	40
3392	2026-05-20 20:00:00	27	38.23
3399	2026-05-20 20:00:00	28	264
3402	2026-05-20 21:00:00	10	20
3413	2026-05-20 21:00:00	9	20
3424	2026-05-20 21:00:00	7	24.35
3433	2026-05-20 21:00:00	8	171.6
3442	2026-05-20 21:00:00	6	12
3460	2026-05-20 22:00:00	38	264
3468	2026-05-20 22:00:00	40	20
3473	2026-05-20 22:00:00	37	38.46
3482	2026-05-20 22:00:00	39	20
3492	2026-05-20 22:00:00	36	40
3509	2026-05-20 23:00:00	31	40
3520	2026-05-20 23:00:00	33	264
3529	2026-05-20 23:00:00	32	38.35
3539	2026-05-20 23:00:00	34	20
3550	2026-05-20 23:00:00	35	20
3551	2026-05-21 00:00:00	3	171.6
3563	2026-05-21 00:00:00	2	24.44
3573	2026-05-21 00:00:00	4	20
3585	2026-05-21 00:00:00	1	12
3596	2026-05-21 00:00:00	5	20
3603	2026-05-21 01:00:00	18	264
3619	2026-05-21 01:00:00	20	20
3630	2026-05-21 01:00:00	17	38.33
3638	2026-05-21 01:00:00	16	40
3643	2026-05-21 01:00:00	19	20
3657	2026-05-21 02:00:00	46	40
3665	2026-05-21 02:00:00	50	20
3675	2026-05-21 02:00:00	49	20
3684	2026-05-21 02:00:00	47	38.28
3692	2026-05-21 02:00:00	48	264
4202	2026-05-21 13:00:00	4	20
4213	2026-05-21 13:00:00	1	12
4230	2026-05-21 13:00:00	5	20
4239	2026-05-21 13:00:00	3	171.6
385	2026-05-18 08:00:00	47	28.32
397	2026-05-18 08:00:00	48	198
408	2026-05-18 09:00:00	13	198
420	2026-05-18 09:00:00	14	20
431	2026-05-18 09:00:00	12	28.45
441	2026-05-18 09:00:00	11	20
448	2026-05-18 09:00:00	15	20
452	2026-05-18 10:00:00	16	20
468	2026-05-18 10:00:00	19	20
476	2026-05-18 10:00:00	18	198
488	2026-05-18 10:00:00	20	20
494	2026-05-18 10:00:00	17	28.29
503	2026-05-18 11:00:00	26	20
519	2026-05-18 11:00:00	30	20
530	2026-05-18 11:00:00	27	28.34
541	2026-05-18 11:00:00	28	198
550	2026-05-18 11:00:00	29	20
551	2026-05-18 12:00:00	3	171.6
564	2026-05-18 12:00:00	2	24.24
576	2026-05-18 12:00:00	1	12
586	2026-05-18 12:00:00	4	20
594	2026-05-18 12:00:00	5	20
605	2026-05-18 13:00:00	23	198
619	2026-05-18 13:00:00	24	20
630	2026-05-18 13:00:00	25	20
636	2026-05-18 13:00:00	21	20
647	2026-05-18 13:00:00	22	28.45
654	2026-05-18 14:00:00	20	20
664	2026-05-18 14:00:00	17	28.25
674	2026-05-18 14:00:00	16	20
684	2026-05-18 14:00:00	19	20
691	2026-05-18 14:00:00	18	198
708	2026-05-18 15:00:00	31	20
716	2026-05-18 15:00:00	34	20
728	2026-05-18 15:00:00	35	20
738	2026-05-18 15:00:00	33	198
749	2026-05-18 15:00:00	32	28.46
1754	2026-05-19 12:00:00	26	46
1770	2026-05-19 12:00:00	30	20
1781	2026-05-19 12:00:00	27	41.48
1791	2026-05-19 12:00:00	28	283.8
1800	2026-05-19 12:00:00	29	20
1802	2026-05-19 13:00:00	8	171.6
1813	2026-05-19 13:00:00	10	20
1823	2026-05-19 13:00:00	6	12
1835	2026-05-19 13:00:00	9	20
1846	2026-05-19 13:00:00	7	24.21
1851	2026-05-19 14:00:00	6	12
1863	2026-05-19 14:00:00	9	20
1873	2026-05-19 14:00:00	7	24.39
1884	2026-05-19 14:00:00	8	171.6
1893	2026-05-19 14:00:00	10	20
1907	2026-05-19 15:00:00	33	198
1919	2026-05-19 15:00:00	32	28.21
1930	2026-05-19 15:00:00	31	20
1941	2026-05-19 15:00:00	34	20
1949	2026-05-19 15:00:00	35	20
1953	2026-05-19 16:00:00	15	20
1965	2026-05-19 16:00:00	13	198
1975	2026-05-19 16:00:00	14	20
1986	2026-05-19 16:00:00	12	28.29
1995	2026-05-19 16:00:00	11	20
2009	2026-05-19 17:00:00	35	20
2013	2026-05-19 17:00:00	33	198
2022	2026-05-19 17:00:00	32	28.33
2029	2026-05-19 17:00:00	31	20
2043	2026-05-19 17:00:00	34	20
2059	2026-05-19 18:00:00	32	28.32
2065	2026-05-19 18:00:00	31	20
2072	2026-05-19 18:00:00	34	20
2079	2026-05-19 18:00:00	35	20
2084	2026-05-19 18:00:00	33	198
2109	2026-05-19 19:00:00	49	20
2113	2026-05-19 19:00:00	47	28.32
2122	2026-05-19 19:00:00	48	198
2126	2026-05-19 19:00:00	50	20
2140	2026-05-19 19:00:00	46	20
2159	2026-05-19 20:00:00	41	20
2170	2026-05-19 20:00:00	42	28.42
2178	2026-05-19 20:00:00	43	198
2187	2026-05-19 20:00:00	44	20
2198	2026-05-19 20:00:00	45	20
2202	2026-05-19 21:00:00	7	24.38
2213	2026-05-19 21:00:00	8	171.6
2225	2026-05-19 21:00:00	10	20
2237	2026-05-19 21:00:00	6	12
2246	2026-05-19 21:00:00	9	20
3255	2026-05-20 18:00:00	16	40
3268	2026-05-20 18:00:00	19	20
3279	2026-05-20 18:00:00	18	264
3291	2026-05-20 18:00:00	20	20
3300	2026-05-20 18:00:00	17	38.29
3302	2026-05-20 19:00:00	3	171.6
3309	2026-05-20 19:00:00	2	24.4
3319	2026-05-20 19:00:00	4	20
3332	2026-05-20 19:00:00	1	12
3342	2026-05-20 19:00:00	5	20
3357	2026-05-20 20:00:00	22	38.24
3363	2026-05-20 20:00:00	23	264
3378	2026-05-20 20:00:00	24	20
3389	2026-05-20 20:00:00	21	40
3398	2026-05-20 20:00:00	25	20
3403	2026-05-20 21:00:00	12	54.2
3416	2026-05-20 21:00:00	15	15
3426	2026-05-20 21:00:00	11	40
3435	2026-05-20 21:00:00	13	261
3445	2026-05-20 21:00:00	14	15
3456	2026-05-20 22:00:00	27	38.3
3469	2026-05-20 22:00:00	28	264
3480	2026-05-20 22:00:00	29	20
3494	2026-05-20 22:00:00	30	20
3500	2026-05-20 22:00:00	26	40
3501	2026-05-20 23:00:00	1	12
3512	2026-05-20 23:00:00	5	20
3525	2026-05-20 23:00:00	3	171.6
3535	2026-05-20 23:00:00	2	24.44
3544	2026-05-20 23:00:00	4	20
3557	2026-05-21 00:00:00	40	20
3564	2026-05-21 00:00:00	37	38.42
3575	2026-05-21 00:00:00	39	20
3584	2026-05-21 00:00:00	36	40
3591	2026-05-21 00:00:00	38	264
3607	2026-05-21 01:00:00	50	20
3617	2026-05-21 01:00:00	49	20
3626	2026-05-21 01:00:00	47	38.23
3640	2026-05-21 01:00:00	48	264
3650	2026-05-21 01:00:00	46	40
3651	2026-05-21 02:00:00	1	12
3662	2026-05-21 02:00:00	5	20
3672	2026-05-21 02:00:00	3	171.6
3678	2026-05-21 02:00:00	2	24.25
3693	2026-05-21 02:00:00	4	20
4201	2026-05-21 13:00:00	7	24.42
4214	2026-05-21 13:00:00	8	171.6
4226	2026-05-21 13:00:00	6	12
4235	2026-05-21 13:00:00	10	20
386	2026-05-18 08:00:00	6	12
398	2026-05-18 08:00:00	7	24.2
404	2026-05-18 09:00:00	17	28.22
415	2026-05-18 09:00:00	16	20
424	2026-05-18 09:00:00	19	20
433	2026-05-18 09:00:00	18	198
442	2026-05-18 09:00:00	20	20
453	2026-05-18 10:00:00	32	28.28
467	2026-05-18 10:00:00	31	20
477	2026-05-18 10:00:00	34	20
487	2026-05-18 10:00:00	35	20
495	2026-05-18 10:00:00	33	198
505	2026-05-18 11:00:00	22	28.25
516	2026-05-18 11:00:00	23	198
527	2026-05-18 11:00:00	24	20
536	2026-05-18 11:00:00	25	20
545	2026-05-18 11:00:00	21	20
554	2026-05-18 12:00:00	39	20
561	2026-05-18 12:00:00	38	283.8
572	2026-05-18 12:00:00	40	20
578	2026-05-18 12:00:00	36	46
589	2026-05-18 12:00:00	37	41.22
610	2026-05-18 13:00:00	45	20
615	2026-05-18 13:00:00	41	20
625	2026-05-18 13:00:00	42	28.46
635	2026-05-18 13:00:00	43	198
646	2026-05-18 13:00:00	44	20
652	2026-05-18 14:00:00	6	12
663	2026-05-18 14:00:00	9	20
676	2026-05-18 14:00:00	7	24.37
690	2026-05-18 14:00:00	8	171.6
696	2026-05-18 14:00:00	10	20
706	2026-05-18 15:00:00	20	20
718	2026-05-18 15:00:00	17	28.27
727	2026-05-18 15:00:00	16	20
736	2026-05-18 15:00:00	19	20
746	2026-05-18 15:00:00	18	198
751	2026-05-18 16:00:00	4	20
753	2026-05-18 16:00:00	22	28.28
754	2026-05-18 16:00:00	10	20
752	2026-05-18 16:00:00	11	20
756	2026-05-18 16:00:00	33	198
755	2026-05-18 16:00:00	19	20
757	2026-05-18 16:00:00	44	20
759	2026-05-18 16:00:00	40	20
758	2026-05-18 16:00:00	28	198
760	2026-05-18 16:00:00	49	20
761	2026-05-18 16:00:00	6	12
762	2026-05-18 16:00:00	5	20
763	2026-05-18 16:00:00	45	20
764	2026-05-18 16:00:00	36	20
765	2026-05-18 16:00:00	47	28.44
766	2026-05-18 16:00:00	15	20
767	2026-05-18 16:00:00	18	198
768	2026-05-18 16:00:00	23	198
769	2026-05-18 16:00:00	9	20
770	2026-05-18 16:00:00	32	28.24
771	2026-05-18 16:00:00	29	20
772	2026-05-18 16:00:00	7	24.24
773	2026-05-18 16:00:00	3	171.6
774	2026-05-18 16:00:00	13	198
775	2026-05-18 16:00:00	41	20
776	2026-05-18 16:00:00	24	20
777	2026-05-18 16:00:00	37	28.45
778	2026-05-18 16:00:00	48	198
779	2026-05-18 16:00:00	20	20
780	2026-05-18 16:00:00	8	171.6
781	2026-05-18 16:00:00	31	20
782	2026-05-18 16:00:00	26	20
783	2026-05-18 16:00:00	42	28.19
784	2026-05-18 16:00:00	14	20
785	2026-05-18 16:00:00	2	24.25
786	2026-05-18 16:00:00	39	20
787	2026-05-18 16:00:00	25	20
788	2026-05-18 16:00:00	50	20
789	2026-05-18 16:00:00	17	28.33
790	2026-05-18 16:00:00	30	20
791	2026-05-18 16:00:00	43	198
792	2026-05-18 16:00:00	34	20
793	2026-05-18 16:00:00	1	12
794	2026-05-18 16:00:00	12	28.19
795	2026-05-18 16:00:00	38	198
796	2026-05-18 16:00:00	16	20
797	2026-05-18 16:00:00	21	20
798	2026-05-18 16:00:00	46	20
799	2026-05-18 16:00:00	27	28.49
800	2026-05-18 16:00:00	35	20
801	2026-05-18 17:00:00	5	20
802	2026-05-18 17:00:00	6	12
803	2026-05-18 17:00:00	12	28.38
804	2026-05-18 17:00:00	28	198
805	2026-05-18 17:00:00	23	198
807	2026-05-18 17:00:00	18	198
806	2026-05-18 17:00:00	36	20
809	2026-05-18 17:00:00	45	20
810	2026-05-18 17:00:00	47	28.38
808	2026-05-18 17:00:00	33	198
811	2026-05-18 17:00:00	3	171.6
812	2026-05-18 17:00:00	48	198
813	2026-05-18 17:00:00	24	20
814	2026-05-18 17:00:00	37	28.27
815	2026-05-18 17:00:00	41	20
816	2026-05-18 17:00:00	9	20
817	2026-05-18 17:00:00	20	20
818	2026-05-18 17:00:00	11	20
819	2026-05-18 17:00:00	29	20
820	2026-05-18 17:00:00	32	28.28
821	2026-05-18 17:00:00	50	20
822	2026-05-18 17:00:00	25	20
823	2026-05-18 17:00:00	2	24.26
824	2026-05-18 17:00:00	42	28.22
825	2026-05-18 17:00:00	7	24.33
826	2026-05-18 17:00:00	46	20
827	2026-05-18 17:00:00	21	20
828	2026-05-18 17:00:00	15	20
829	2026-05-18 17:00:00	39	20
830	2026-05-18 17:00:00	17	28.43
831	2026-05-18 17:00:00	31	20
832	2026-05-18 17:00:00	26	20
833	2026-05-18 17:00:00	1	12
834	2026-05-18 17:00:00	49	20
835	2026-05-18 17:00:00	43	198
836	2026-05-18 17:00:00	8	171.6
837	2026-05-18 17:00:00	22	28.19
838	2026-05-18 17:00:00	13	198
839	2026-05-18 17:00:00	16	20
840	2026-05-18 17:00:00	38	198
841	2026-05-18 17:00:00	30	20
842	2026-05-18 17:00:00	34	20
843	2026-05-18 17:00:00	44	20
844	2026-05-18 17:00:00	4	20
845	2026-05-18 17:00:00	10	20
846	2026-05-18 17:00:00	14	20
847	2026-05-18 17:00:00	19	20
848	2026-05-18 17:00:00	40	20
849	2026-05-18 17:00:00	35	20
850	2026-05-18 17:00:00	27	28.32
851	2026-05-18 18:00:00	2	24.31
862	2026-05-18 18:00:00	1	12
873	2026-05-18 18:00:00	4	20
883	2026-05-18 18:00:00	5	20
892	2026-05-18 18:00:00	3	171.6
907	2026-05-18 19:00:00	36	20
919	2026-05-18 19:00:00	37	28.31
930	2026-05-18 19:00:00	39	20
940	2026-05-18 19:00:00	38	198
947	2026-05-18 19:00:00	40	20
956	2026-05-18 20:00:00	18	198
967	2026-05-18 20:00:00	20	20
981	2026-05-18 20:00:00	17	28.31
990	2026-05-18 20:00:00	16	20
998	2026-05-18 20:00:00	19	20
1003	2026-05-18 21:00:00	14	20
1015	2026-05-18 21:00:00	12	28.47
1022	2026-05-18 21:00:00	11	20
1034	2026-05-18 21:00:00	15	20
1044	2026-05-18 21:00:00	13	198
1055	2026-05-18 22:00:00	28	198
1066	2026-05-18 22:00:00	29	20
1073	2026-05-18 22:00:00	26	20
1080	2026-05-18 22:00:00	30	20
1091	2026-05-18 22:00:00	27	28.3
1108	2026-05-18 23:00:00	31	20
1114	2026-05-18 23:00:00	34	20
1122	2026-05-18 23:00:00	35	20
1129	2026-05-18 23:00:00	33	198
1143	2026-05-18 23:00:00	32	28.46
1156	2026-05-19 00:00:00	30	20
1165	2026-05-19 00:00:00	27	28.41
1172	2026-05-19 00:00:00	28	198
1178	2026-05-19 00:00:00	29	20
1185	2026-05-19 00:00:00	26	20
1209	2026-05-19 01:00:00	36	20
1218	2026-05-19 01:00:00	37	28.47
1226	2026-05-19 01:00:00	39	20
1231	2026-05-19 01:00:00	38	198
1238	2026-05-19 01:00:00	40	20
1757	2026-05-19 12:00:00	38	283.8
1768	2026-05-19 12:00:00	40	20
1776	2026-05-19 12:00:00	36	46
1785	2026-05-19 12:00:00	37	41.37
1796	2026-05-19 12:00:00	39	20
1804	2026-05-19 13:00:00	17	28.36
1815	2026-05-19 13:00:00	16	20
1830	2026-05-19 13:00:00	19	20
1841	2026-05-19 13:00:00	18	198
1850	2026-05-19 13:00:00	20	20
1852	2026-05-19 14:00:00	5	20
1864	2026-05-19 14:00:00	3	171.6
1875	2026-05-19 14:00:00	2	24.23
1887	2026-05-19 14:00:00	1	12
1899	2026-05-19 14:00:00	4	20
1904	2026-05-19 15:00:00	20	20
1914	2026-05-19 15:00:00	17	28.35
1922	2026-05-19 15:00:00	16	20
1933	2026-05-19 15:00:00	19	20
1939	2026-05-19 15:00:00	18	198
1957	2026-05-19 16:00:00	35	20
1961	2026-05-19 16:00:00	33	198
1973	2026-05-19 16:00:00	32	28.39
1983	2026-05-19 16:00:00	31	20
1994	2026-05-19 16:00:00	34	20
2008	2026-05-19 17:00:00	28	198
2018	2026-05-19 17:00:00	29	20
2032	2026-05-19 17:00:00	26	20
2042	2026-05-19 17:00:00	30	20
2049	2026-05-19 17:00:00	27	28.45
2052	2026-05-19 18:00:00	10	20
2062	2026-05-19 18:00:00	6	12
2073	2026-05-19 18:00:00	9	20
2080	2026-05-19 18:00:00	7	24.45
2089	2026-05-19 18:00:00	8	171.6
2110	2026-05-19 19:00:00	42	28.24
2114	2026-05-19 19:00:00	43	198
2128	2026-05-19 19:00:00	44	20
2137	2026-05-19 19:00:00	45	20
2148	2026-05-19 19:00:00	41	20
2152	2026-05-19 20:00:00	7	24.44
2164	2026-05-19 20:00:00	8	171.6
2175	2026-05-19 20:00:00	10	20
2185	2026-05-19 20:00:00	6	12
2192	2026-05-19 20:00:00	9	20
2209	2026-05-19 21:00:00	41	20
2217	2026-05-19 21:00:00	42	28.37
2230	2026-05-19 21:00:00	43	198
2241	2026-05-19 21:00:00	44	20
2249	2026-05-19 21:00:00	45	20
3257	2026-05-20 18:00:00	30	20
3263	2026-05-20 18:00:00	26	40
3274	2026-05-20 18:00:00	27	38.48
3286	2026-05-20 18:00:00	28	264
3296	2026-05-20 18:00:00	29	20
3303	2026-05-20 19:00:00	19	20
3310	2026-05-20 19:00:00	18	264
3317	2026-05-20 19:00:00	20	20
3328	2026-05-20 19:00:00	17	38.3
3334	2026-05-20 19:00:00	16	40
3360	2026-05-20 20:00:00	44	20
3370	2026-05-20 20:00:00	45	20
3384	2026-05-20 20:00:00	42	38.25
3394	2026-05-20 20:00:00	41	40
3400	2026-05-20 20:00:00	43	264
3401	2026-05-20 21:00:00	4	20
3414	2026-05-20 21:00:00	1	12
3425	2026-05-20 21:00:00	5	20
3436	2026-05-20 21:00:00	3	171.6
3446	2026-05-20 21:00:00	2	24.26
3454	2026-05-20 22:00:00	21	40
3461	2026-05-20 22:00:00	25	20
3471	2026-05-20 22:00:00	22	38.27
3486	2026-05-20 22:00:00	23	264
3496	2026-05-20 22:00:00	24	20
3506	2026-05-20 23:00:00	27	38.45
3517	2026-05-20 23:00:00	28	264
3522	2026-05-20 23:00:00	29	20
3532	2026-05-20 23:00:00	30	20
3542	2026-05-20 23:00:00	26	40
3558	2026-05-21 00:00:00	41	40
3562	2026-05-21 00:00:00	43	264
3572	2026-05-21 00:00:00	44	20
3581	2026-05-21 00:00:00	45	20
3590	2026-05-21 00:00:00	42	38.3
3608	2026-05-21 01:00:00	37	38.42
3613	2026-05-21 01:00:00	39	20
3625	2026-05-21 01:00:00	36	40
3637	2026-05-21 01:00:00	38	264
3645	2026-05-21 01:00:00	40	20
3655	2026-05-21 02:00:00	28	264
3666	2026-05-21 02:00:00	29	20
3677	2026-05-21 02:00:00	30	20
3688	2026-05-21 02:00:00	26	40
3694	2026-05-21 02:00:00	27	38.42
853	2026-05-18 18:00:00	15	20
863	2026-05-18 18:00:00	13	198
871	2026-05-18 18:00:00	14	20
875	2026-05-18 18:00:00	12	28.35
884	2026-05-18 18:00:00	11	20
909	2026-05-18 19:00:00	48	198
918	2026-05-18 19:00:00	50	20
928	2026-05-18 19:00:00	46	20
939	2026-05-18 19:00:00	49	20
948	2026-05-18 19:00:00	47	28.3
952	2026-05-18 20:00:00	6	12
965	2026-05-18 20:00:00	9	20
978	2026-05-18 20:00:00	7	24.33
988	2026-05-18 20:00:00	8	171.6
994	2026-05-18 20:00:00	10	20
1008	2026-05-18 21:00:00	36	20
1012	2026-05-18 21:00:00	37	28.34
1025	2026-05-18 21:00:00	39	20
1035	2026-05-18 21:00:00	38	198
1039	2026-05-18 21:00:00	40	20
1059	2026-05-18 22:00:00	44	20
1069	2026-05-18 22:00:00	45	20
1083	2026-05-18 22:00:00	41	20
1093	2026-05-18 22:00:00	42	28.21
1099	2026-05-18 22:00:00	43	198
1104	2026-05-18 23:00:00	20	20
1116	2026-05-18 23:00:00	17	28.21
1125	2026-05-18 23:00:00	16	20
1131	2026-05-18 23:00:00	19	20
1137	2026-05-18 23:00:00	18	198
1160	2026-05-19 00:00:00	49	20
1168	2026-05-19 00:00:00	47	28.32
1182	2026-05-19 00:00:00	48	198
1193	2026-05-19 00:00:00	50	20
1200	2026-05-19 00:00:00	46	20
1201	2026-05-19 01:00:00	2	24.21
1215	2026-05-19 01:00:00	1	12
1225	2026-05-19 01:00:00	4	20
1235	2026-05-19 01:00:00	5	20
1245	2026-05-19 01:00:00	3	171.6
1760	2026-05-19 12:00:00	20	20
1763	2026-05-19 12:00:00	17	41.42
1774	2026-05-19 12:00:00	16	46
1784	2026-05-19 12:00:00	19	20
1794	2026-05-19 12:00:00	18	283.8
1807	2026-05-19 13:00:00	33	198
1820	2026-05-19 13:00:00	32	28.36
1828	2026-05-19 13:00:00	31	20
1837	2026-05-19 13:00:00	34	20
1847	2026-05-19 13:00:00	35	20
1856	2026-05-19 14:00:00	21	20
1861	2026-05-19 14:00:00	22	28.29
1870	2026-05-19 14:00:00	23	198
1878	2026-05-19 14:00:00	24	20
1890	2026-05-19 14:00:00	25	20
1909	2026-05-19 15:00:00	43	198
1917	2026-05-19 15:00:00	44	20
1925	2026-05-19 15:00:00	45	20
1936	2026-05-19 15:00:00	41	20
1942	2026-05-19 15:00:00	42	28.22
1960	2026-05-19 16:00:00	48	198
1968	2026-05-19 16:00:00	50	20
1976	2026-05-19 16:00:00	46	20
1984	2026-05-19 16:00:00	49	20
1992	2026-05-19 16:00:00	47	28.24
2005	2026-05-19 17:00:00	36	20
2016	2026-05-19 17:00:00	37	28.3
2030	2026-05-19 17:00:00	39	20
2037	2026-05-19 17:00:00	38	198
2045	2026-05-19 17:00:00	40	20
2058	2026-05-19 18:00:00	29	20
2063	2026-05-19 18:00:00	26	20
2074	2026-05-19 18:00:00	30	20
2085	2026-05-19 18:00:00	27	28.33
2094	2026-05-19 18:00:00	28	198
2108	2026-05-19 19:00:00	40	20
2119	2026-05-19 19:00:00	36	20
2131	2026-05-19 19:00:00	37	28.35
2135	2026-05-19 19:00:00	39	20
2143	2026-05-19 19:00:00	38	198
2158	2026-05-19 20:00:00	38	198
2163	2026-05-19 20:00:00	40	20
2172	2026-05-19 20:00:00	36	20
2183	2026-05-19 20:00:00	37	28.39
2193	2026-05-19 20:00:00	39	20
2208	2026-05-19 21:00:00	38	198
2220	2026-05-19 21:00:00	40	20
2228	2026-05-19 21:00:00	36	20
2236	2026-05-19 21:00:00	37	28.29
2250	2026-05-19 21:00:00	39	20
3258	2026-05-20 18:00:00	35	20
3269	2026-05-20 18:00:00	31	40
3278	2026-05-20 18:00:00	33	264
3287	2026-05-20 18:00:00	32	38.21
3297	2026-05-20 18:00:00	34	20
3307	2026-05-20 19:00:00	21	40
3314	2026-05-20 19:00:00	25	20
3326	2026-05-20 19:00:00	22	38.42
3337	2026-05-20 19:00:00	23	264
3346	2026-05-20 19:00:00	24	20
3353	2026-05-20 20:00:00	15	15
3361	2026-05-20 20:00:00	11	40
3376	2026-05-20 20:00:00	13	261
3387	2026-05-20 20:00:00	14	15
3395	2026-05-20 20:00:00	12	54.27
3404	2026-05-20 21:00:00	21	40
3415	2026-05-20 21:00:00	25	20
3423	2026-05-20 21:00:00	22	38.35
3434	2026-05-20 21:00:00	23	264
3444	2026-05-20 21:00:00	24	20
3458	2026-05-20 22:00:00	31	40
3465	2026-05-20 22:00:00	33	264
3474	2026-05-20 22:00:00	32	38.22
3483	2026-05-20 22:00:00	34	20
3493	2026-05-20 22:00:00	35	20
3508	2026-05-20 23:00:00	38	264
3519	2026-05-20 23:00:00	40	20
3530	2026-05-20 23:00:00	37	38.49
3540	2026-05-20 23:00:00	39	20
3549	2026-05-20 23:00:00	36	40
3554	2026-05-21 00:00:00	22	38.3
3566	2026-05-21 00:00:00	23	264
3577	2026-05-21 00:00:00	24	20
3583	2026-05-21 00:00:00	21	40
3597	2026-05-21 00:00:00	25	20
3602	2026-05-21 01:00:00	10	20
3615	2026-05-21 01:00:00	9	20
3628	2026-05-21 01:00:00	7	24.46
3633	2026-05-21 01:00:00	8	171.6
3644	2026-05-21 01:00:00	6	12
3658	2026-05-21 02:00:00	45	20
3668	2026-05-21 02:00:00	42	38.2
3682	2026-05-21 02:00:00	41	40
3689	2026-05-21 02:00:00	43	264
3696	2026-05-21 02:00:00	44	20
4203	2026-05-21 13:00:00	13	261
854	2026-05-18 18:00:00	25	20
868	2026-05-18 18:00:00	21	20
877	2026-05-18 18:00:00	22	28.29
887	2026-05-18 18:00:00	23	198
895	2026-05-18 18:00:00	24	20
903	2026-05-18 19:00:00	23	198
917	2026-05-18 19:00:00	24	20
927	2026-05-18 19:00:00	25	20
938	2026-05-18 19:00:00	21	20
949	2026-05-18 19:00:00	22	28.38
953	2026-05-18 20:00:00	15	20
964	2026-05-18 20:00:00	13	198
973	2026-05-18 20:00:00	14	20
980	2026-05-18 20:00:00	12	28.25
991	2026-05-18 20:00:00	11	20
1004	2026-05-18 21:00:00	32	28.31
1011	2026-05-18 21:00:00	31	20
1020	2026-05-18 21:00:00	34	20
1026	2026-05-18 21:00:00	35	20
1031	2026-05-18 21:00:00	33	198
1060	2026-05-18 22:00:00	50	20
1063	2026-05-18 22:00:00	46	20
1078	2026-05-18 22:00:00	49	20
1088	2026-05-18 22:00:00	47	28.47
1095	2026-05-18 22:00:00	48	198
1105	2026-05-18 23:00:00	25	20
1111	2026-05-18 23:00:00	21	20
1120	2026-05-18 23:00:00	22	28.23
1124	2026-05-18 23:00:00	23	198
1136	2026-05-18 23:00:00	24	20
1158	2026-05-19 00:00:00	36	20
1170	2026-05-19 00:00:00	37	28.46
1181	2026-05-19 00:00:00	39	20
1188	2026-05-19 00:00:00	38	198
1196	2026-05-19 00:00:00	40	20
1207	2026-05-19 01:00:00	31	20
1216	2026-05-19 01:00:00	34	20
1227	2026-05-19 01:00:00	35	20
1232	2026-05-19 01:00:00	33	198
1241	2026-05-19 01:00:00	32	28.32
2252	2026-05-19 22:00:00	1	12
2264	2026-05-19 22:00:00	4	20
2275	2026-05-19 22:00:00	5	20
2288	2026-05-19 22:00:00	3	171.6
2293	2026-05-19 22:00:00	2	24.49
2308	2026-05-19 23:00:00	33	198
2320	2026-05-19 23:00:00	32	28.4
2321	2026-05-19 23:00:00	31	20
2333	2026-05-19 23:00:00	34	20
2343	2026-05-19 23:00:00	35	20
2352	2026-05-20 00:00:00	7	24.21
2364	2026-05-20 00:00:00	8	171.6
2378	2026-05-20 00:00:00	10	20
2388	2026-05-20 00:00:00	6	12
2396	2026-05-20 00:00:00	9	20
2408	2026-05-20 01:00:00	28	198
2418	2026-05-20 01:00:00	29	20
2432	2026-05-20 01:00:00	26	20
2442	2026-05-20 01:00:00	30	20
2448	2026-05-20 01:00:00	27	28.34
2452	2026-05-20 02:00:00	15	20
2462	2026-05-20 02:00:00	13	198
2475	2026-05-20 02:00:00	14	20
2486	2026-05-20 02:00:00	12	28.42
2498	2026-05-20 02:00:00	11	20
2503	2026-05-20 03:00:00	10	20
2515	2026-05-20 03:00:00	6	12
2525	2026-05-20 03:00:00	9	20
2532	2026-05-20 03:00:00	7	24.47
2542	2026-05-20 03:00:00	8	171.6
2558	2026-05-20 04:00:00	40	20
2566	2026-05-20 04:00:00	37	38.2
2576	2026-05-20 04:00:00	39	20
2587	2026-05-20 04:00:00	36	40
2596	2026-05-20 04:00:00	38	264
2603	2026-05-20 05:00:00	14	20
2616	2026-05-20 05:00:00	12	38.38
2627	2026-05-20 05:00:00	15	20
2637	2026-05-20 05:00:00	11	40
2644	2026-05-20 05:00:00	13	264
2657	2026-05-20 06:00:00	34	20
2663	2026-05-20 06:00:00	35	20
2672	2026-05-20 06:00:00	31	40
2680	2026-05-20 06:00:00	33	264
2689	2026-05-20 06:00:00	32	38.27
2709	2026-05-20 07:00:00	45	20
2713	2026-05-20 07:00:00	42	38.41
2722	2026-05-20 07:00:00	41	40
2732	2026-05-20 07:00:00	43	264
2745	2026-05-20 07:00:00	44	20
3259	2026-05-20 18:00:00	41	40
3261	2026-05-20 18:00:00	43	264
3271	2026-05-20 18:00:00	44	20
3281	2026-05-20 18:00:00	45	20
3289	2026-05-20 18:00:00	42	38.42
3320	2026-05-20 19:00:00	43	264
3330	2026-05-20 19:00:00	44	20
3340	2026-05-20 19:00:00	45	20
3348	2026-05-20 19:00:00	42	38.22
3350	2026-05-20 19:00:00	41	40
3351	2026-05-20 20:00:00	1	12
3364	2026-05-20 20:00:00	5	20
3371	2026-05-20 20:00:00	3	171.6
3379	2026-05-20 20:00:00	2	24.48
3385	2026-05-20 20:00:00	4	20
3408	2026-05-20 21:00:00	46	40
3411	2026-05-20 21:00:00	50	20
3421	2026-05-20 21:00:00	49	20
3428	2026-05-20 21:00:00	47	38.44
3437	2026-05-20 21:00:00	48	264
3457	2026-05-20 22:00:00	45	20
3470	2026-05-20 22:00:00	42	38.24
3479	2026-05-20 22:00:00	41	40
3485	2026-05-20 22:00:00	43	264
3490	2026-05-20 22:00:00	44	20
3510	2026-05-20 23:00:00	46	40
3515	2026-05-20 23:00:00	50	20
3526	2026-05-20 23:00:00	49	20
3538	2026-05-20 23:00:00	47	38.31
3546	2026-05-20 23:00:00	48	264
3560	2026-05-21 00:00:00	15	15
3569	2026-05-21 00:00:00	11	40
3579	2026-05-21 00:00:00	13	261
3592	2026-05-21 00:00:00	14	15
3598	2026-05-21 00:00:00	12	54.15
3604	2026-05-21 01:00:00	14	15
3614	2026-05-21 01:00:00	12	54.12
3622	2026-05-21 01:00:00	15	15
3635	2026-05-21 01:00:00	11	40
3646	2026-05-21 01:00:00	13	261
3654	2026-05-21 02:00:00	18	264
3667	2026-05-21 02:00:00	20	20
3674	2026-05-21 02:00:00	17	38.39
3683	2026-05-21 02:00:00	16	40
3695	2026-05-21 02:00:00	19	20
4205	2026-05-21 13:00:00	20	20
855	2026-05-18 18:00:00	31	20
864	2026-05-18 18:00:00	34	20
879	2026-05-18 18:00:00	35	20
889	2026-05-18 18:00:00	33	198
894	2026-05-18 18:00:00	32	28.45
908	2026-05-18 19:00:00	32	28.29
911	2026-05-18 19:00:00	31	20
921	2026-05-18 19:00:00	34	20
929	2026-05-18 19:00:00	35	20
937	2026-05-18 19:00:00	33	198
959	2026-05-18 20:00:00	48	198
969	2026-05-18 20:00:00	50	20
982	2026-05-18 20:00:00	46	20
993	2026-05-18 20:00:00	49	20
999	2026-05-18 20:00:00	47	28.35
1002	2026-05-18 21:00:00	9	20
1014	2026-05-18 21:00:00	7	24.29
1027	2026-05-18 21:00:00	8	171.6
1037	2026-05-18 21:00:00	10	20
1046	2026-05-18 21:00:00	6	12
1056	2026-05-18 22:00:00	21	20
1061	2026-05-18 22:00:00	22	28.31
1071	2026-05-18 22:00:00	23	198
1075	2026-05-18 22:00:00	24	20
1085	2026-05-18 22:00:00	25	20
1110	2026-05-18 23:00:00	42	28.47
1121	2026-05-18 23:00:00	43	198
1128	2026-05-18 23:00:00	44	20
1135	2026-05-18 23:00:00	45	20
1140	2026-05-18 23:00:00	41	20
1159	2026-05-19 00:00:00	42	28.4
1167	2026-05-19 00:00:00	43	198
1174	2026-05-19 00:00:00	44	20
1184	2026-05-19 00:00:00	45	20
1195	2026-05-19 00:00:00	41	20
1205	2026-05-19 01:00:00	25	20
1220	2026-05-19 01:00:00	21	20
1230	2026-05-19 01:00:00	22	28.34
1242	2026-05-19 01:00:00	23	198
1250	2026-05-19 01:00:00	24	20
2251	2026-05-19 22:00:00	10	20
2262	2026-05-19 22:00:00	6	12
2272	2026-05-19 22:00:00	9	20
2287	2026-05-19 22:00:00	7	24.3
2294	2026-05-19 22:00:00	8	171.6
2306	2026-05-19 23:00:00	27	28.29
2317	2026-05-19 23:00:00	28	198
2328	2026-05-19 23:00:00	29	20
2339	2026-05-19 23:00:00	26	20
2349	2026-05-19 23:00:00	30	20
2351	2026-05-20 00:00:00	3	171.6
2363	2026-05-20 00:00:00	2	24.41
2375	2026-05-20 00:00:00	1	12
2385	2026-05-20 00:00:00	4	20
2394	2026-05-20 00:00:00	5	20
2407	2026-05-20 01:00:00	33	198
2414	2026-05-20 01:00:00	32	28.39
2421	2026-05-20 01:00:00	31	20
2428	2026-05-20 01:00:00	34	20
2436	2026-05-20 01:00:00	35	20
2460	2026-05-20 02:00:00	50	20
2464	2026-05-20 02:00:00	46	20
2472	2026-05-20 02:00:00	49	20
2481	2026-05-20 02:00:00	47	28.33
2489	2026-05-20 02:00:00	48	198
2508	2026-05-20 03:00:00	50	20
2516	2026-05-20 03:00:00	46	20
2527	2026-05-20 03:00:00	49	20
2535	2026-05-20 03:00:00	47	28.2
2545	2026-05-20 03:00:00	48	198
2556	2026-05-20 04:00:00	22	38.22
2567	2026-05-20 04:00:00	23	264
2577	2026-05-20 04:00:00	24	20
2588	2026-05-20 04:00:00	21	40
2597	2026-05-20 04:00:00	25	20
2606	2026-05-20 05:00:00	20	20
2611	2026-05-20 05:00:00	17	38.4
2624	2026-05-20 05:00:00	16	40
2635	2026-05-20 05:00:00	19	20
2648	2026-05-20 05:00:00	18	264
2652	2026-05-20 06:00:00	9	20
2665	2026-05-20 06:00:00	7	24.45
2677	2026-05-20 06:00:00	8	171.6
2691	2026-05-20 06:00:00	6	12
2698	2026-05-20 06:00:00	10	20
2702	2026-05-20 07:00:00	9	20
2712	2026-05-20 07:00:00	7	24.48
2725	2026-05-20 07:00:00	8	171.6
2734	2026-05-20 07:00:00	6	12
2747	2026-05-20 07:00:00	10	20
3260	2026-05-20 18:00:00	50	20
3270	2026-05-20 18:00:00	49	20
3282	2026-05-20 18:00:00	47	38.29
3293	2026-05-20 18:00:00	48	264
3299	2026-05-20 18:00:00	46	40
3304	2026-05-20 19:00:00	14	15
3313	2026-05-20 19:00:00	12	54.12
3323	2026-05-20 19:00:00	15	15
3335	2026-05-20 19:00:00	11	40
3343	2026-05-20 19:00:00	13	261
3358	2026-05-20 20:00:00	32	38.41
3362	2026-05-20 20:00:00	34	20
3375	2026-05-20 20:00:00	35	20
3386	2026-05-20 20:00:00	31	40
3396	2026-05-20 20:00:00	33	264
3407	2026-05-20 21:00:00	38	264
3418	2026-05-20 21:00:00	40	20
3429	2026-05-20 21:00:00	37	38.19
3439	2026-05-20 21:00:00	39	20
3447	2026-05-20 21:00:00	36	40
3451	2026-05-20 22:00:00	4	20
3462	2026-05-20 22:00:00	1	12
3472	2026-05-20 22:00:00	5	20
3481	2026-05-20 22:00:00	3	171.6
3491	2026-05-20 22:00:00	2	24.36
3507	2026-05-20 23:00:00	45	20
3516	2026-05-20 23:00:00	42	38.4
3523	2026-05-20 23:00:00	41	40
3533	2026-05-20 23:00:00	43	264
3543	2026-05-20 23:00:00	44	20
3556	2026-05-21 00:00:00	33	264
3565	2026-05-21 00:00:00	32	38.29
3574	2026-05-21 00:00:00	34	20
3586	2026-05-21 00:00:00	35	20
3595	2026-05-21 00:00:00	31	40
3609	2026-05-21 01:00:00	21	40
3616	2026-05-21 01:00:00	25	20
3624	2026-05-21 01:00:00	22	38.46
3634	2026-05-21 01:00:00	23	264
3649	2026-05-21 01:00:00	24	20
3653	2026-05-21 02:00:00	13	261
3663	2026-05-21 02:00:00	14	15
3673	2026-05-21 02:00:00	12	54.09
3685	2026-05-21 02:00:00	15	15
3697	2026-05-21 02:00:00	11	40
4204	2026-05-21 13:00:00	23	264
858	2026-05-18 18:00:00	27	28.23
859	2026-05-18 18:00:00	46	20
860	2026-05-18 18:00:00	42	28.2
866	2026-05-18 18:00:00	43	198
869	2026-05-18 18:00:00	28	198
870	2026-05-18 18:00:00	49	20
872	2026-05-18 18:00:00	44	20
876	2026-05-18 18:00:00	29	20
881	2026-05-18 18:00:00	45	20
882	2026-05-18 18:00:00	47	28.46
888	2026-05-18 18:00:00	26	20
891	2026-05-18 18:00:00	41	20
893	2026-05-18 18:00:00	48	198
898	2026-05-18 18:00:00	30	20
900	2026-05-18 18:00:00	50	20
902	2026-05-18 19:00:00	6	12
905	2026-05-18 19:00:00	15	20
910	2026-05-18 19:00:00	42	28.21
913	2026-05-18 19:00:00	13	198
916	2026-05-18 19:00:00	9	20
920	2026-05-18 19:00:00	43	198
923	2026-05-18 19:00:00	14	20
925	2026-05-18 19:00:00	7	24.25
931	2026-05-18 19:00:00	44	20
932	2026-05-18 19:00:00	8	171.6
936	2026-05-18 19:00:00	12	28.19
941	2026-05-18 19:00:00	10	20
942	2026-05-18 19:00:00	45	20
946	2026-05-18 19:00:00	11	20
950	2026-05-18 19:00:00	41	20
951	2026-05-18 20:00:00	3	171.6
958	2026-05-18 20:00:00	41	20
960	2026-05-18 20:00:00	36	20
961	2026-05-18 20:00:00	2	24.42
962	2026-05-18 20:00:00	42	28.38
970	2026-05-18 20:00:00	43	198
972	2026-05-18 20:00:00	37	28.44
974	2026-05-18 20:00:00	1	12
975	2026-05-18 20:00:00	44	20
983	2026-05-18 20:00:00	45	20
985	2026-05-18 20:00:00	39	20
987	2026-05-18 20:00:00	4	20
996	2026-05-18 20:00:00	5	20
997	2026-05-18 20:00:00	38	198
1000	2026-05-18 20:00:00	40	20
1001	2026-05-18 21:00:00	2	24.38
1005	2026-05-18 21:00:00	18	198
1010	2026-05-18 21:00:00	42	28.41
1013	2026-05-18 21:00:00	1	12
1017	2026-05-18 21:00:00	20	20
1018	2026-05-18 21:00:00	43	198
1024	2026-05-18 21:00:00	17	28.3
1028	2026-05-18 21:00:00	4	20
1029	2026-05-18 21:00:00	44	20
1036	2026-05-18 21:00:00	16	20
1038	2026-05-18 21:00:00	5	20
1041	2026-05-18 21:00:00	45	20
1045	2026-05-18 21:00:00	19	20
1047	2026-05-18 21:00:00	3	171.6
1048	2026-05-18 21:00:00	41	20
1053	2026-05-18 22:00:00	17	28.44
1054	2026-05-18 22:00:00	11	20
1057	2026-05-18 22:00:00	35	20
1062	2026-05-18 22:00:00	16	20
1068	2026-05-18 22:00:00	15	20
1070	2026-05-18 22:00:00	33	198
1072	2026-05-18 22:00:00	19	20
1076	2026-05-18 22:00:00	18	198
1082	2026-05-18 22:00:00	13	198
1084	2026-05-18 22:00:00	32	28.35
1086	2026-05-18 22:00:00	20	20
1092	2026-05-18 22:00:00	14	20
1094	2026-05-18 22:00:00	31	20
1098	2026-05-18 22:00:00	12	28.3
1100	2026-05-18 22:00:00	34	20
1101	2026-05-18 23:00:00	2	24.23
1102	2026-05-18 23:00:00	9	20
1109	2026-05-18 23:00:00	47	28.29
1113	2026-05-18 23:00:00	1	12
1115	2026-05-18 23:00:00	7	24.35
1118	2026-05-18 23:00:00	48	198
1123	2026-05-18 23:00:00	8	171.6
1127	2026-05-18 23:00:00	4	20
1130	2026-05-18 23:00:00	50	20
1134	2026-05-18 23:00:00	10	20
1139	2026-05-18 23:00:00	5	20
1142	2026-05-18 23:00:00	6	12
1145	2026-05-18 23:00:00	46	20
1148	2026-05-18 23:00:00	3	171.6
1149	2026-05-18 23:00:00	49	20
1152	2026-05-19 00:00:00	14	20
1154	2026-05-19 00:00:00	9	20
1157	2026-05-19 00:00:00	31	20
1161	2026-05-19 00:00:00	7	24.23
1163	2026-05-19 00:00:00	12	28.23
1169	2026-05-19 00:00:00	34	20
1171	2026-05-19 00:00:00	8	171.6
1177	2026-05-19 00:00:00	11	20
1180	2026-05-19 00:00:00	35	20
1183	2026-05-19 00:00:00	10	20
1187	2026-05-19 00:00:00	33	198
1189	2026-05-19 00:00:00	6	12
1190	2026-05-19 00:00:00	15	20
1197	2026-05-19 00:00:00	13	198
1199	2026-05-19 00:00:00	32	28.29
1202	2026-05-19 01:00:00	7	24.43
1203	2026-05-19 01:00:00	17	28.46
1210	2026-05-19 01:00:00	49	20
1212	2026-05-19 01:00:00	16	20
1213	2026-05-19 01:00:00	47	28.34
1214	2026-05-19 01:00:00	8	171.6
1222	2026-05-19 01:00:00	19	20
1223	2026-05-19 01:00:00	10	20
1224	2026-05-19 01:00:00	48	198
1234	2026-05-19 01:00:00	18	198
1236	2026-05-19 01:00:00	6	12
1237	2026-05-19 01:00:00	50	20
1244	2026-05-19 01:00:00	20	20
1246	2026-05-19 01:00:00	9	20
1247	2026-05-19 01:00:00	46	20
2253	2026-05-19 22:00:00	30	20
2254	2026-05-19 22:00:00	20	20
2263	2026-05-19 22:00:00	17	28.43
2265	2026-05-19 22:00:00	27	28.43
2274	2026-05-19 22:00:00	16	20
2277	2026-05-19 22:00:00	28	198
2285	2026-05-19 22:00:00	29	20
2286	2026-05-19 22:00:00	19	20
2296	2026-05-19 22:00:00	26	20
2297	2026-05-19 22:00:00	18	198
2303	2026-05-19 23:00:00	17	28.35
2305	2026-05-19 23:00:00	25	20
2312	2026-05-19 23:00:00	16	20
2313	2026-05-19 23:00:00	21	20
2322	2026-05-19 23:00:00	22	28.41
2323	2026-05-19 23:00:00	19	20
856	2026-05-18 18:00:00	17	28.47
867	2026-05-18 18:00:00	16	20
878	2026-05-18 18:00:00	19	20
886	2026-05-18 18:00:00	18	198
897	2026-05-18 18:00:00	20	20
904	2026-05-18 19:00:00	18	198
914	2026-05-18 19:00:00	20	20
924	2026-05-18 19:00:00	17	28.48
935	2026-05-18 19:00:00	16	20
945	2026-05-18 19:00:00	19	20
954	2026-05-18 20:00:00	23	198
966	2026-05-18 20:00:00	24	20
979	2026-05-18 20:00:00	25	20
989	2026-05-18 20:00:00	21	20
995	2026-05-18 20:00:00	22	28.26
1006	2026-05-18 21:00:00	24	20
1016	2026-05-18 21:00:00	25	20
1023	2026-05-18 21:00:00	21	20
1032	2026-05-18 21:00:00	22	28.24
1040	2026-05-18 21:00:00	23	198
1058	2026-05-18 22:00:00	39	20
1067	2026-05-18 22:00:00	38	198
1074	2026-05-18 22:00:00	40	20
1081	2026-05-18 22:00:00	36	20
1090	2026-05-18 22:00:00	37	28.37
1107	2026-05-18 23:00:00	36	20
1117	2026-05-18 23:00:00	37	28.46
1133	2026-05-18 23:00:00	39	20
1141	2026-05-18 23:00:00	38	198
1147	2026-05-18 23:00:00	40	20
1153	2026-05-19 00:00:00	20	20
1164	2026-05-19 00:00:00	17	28.48
1175	2026-05-19 00:00:00	16	20
1192	2026-05-19 00:00:00	19	20
1198	2026-05-19 00:00:00	18	198
1204	2026-05-19 01:00:00	11	20
1211	2026-05-19 01:00:00	15	20
1221	2026-05-19 01:00:00	13	198
1233	2026-05-19 01:00:00	14	20
1243	2026-05-19 01:00:00	12	28.31
2255	2026-05-19 22:00:00	11	20
2269	2026-05-19 22:00:00	15	20
2280	2026-05-19 22:00:00	13	198
2284	2026-05-19 22:00:00	14	20
2295	2026-05-19 22:00:00	12	28.24
2307	2026-05-19 23:00:00	40	20
2316	2026-05-19 23:00:00	36	20
2326	2026-05-19 23:00:00	37	28.49
2332	2026-05-19 23:00:00	39	20
2342	2026-05-19 23:00:00	38	198
2360	2026-05-20 00:00:00	44	20
2361	2026-05-20 00:00:00	45	20
2371	2026-05-20 00:00:00	41	20
2376	2026-05-20 00:00:00	42	28.26
2386	2026-05-20 00:00:00	43	198
2410	2026-05-20 01:00:00	46	20
2424	2026-05-20 01:00:00	49	20
2435	2026-05-20 01:00:00	47	28.31
2445	2026-05-20 01:00:00	48	198
2450	2026-05-20 01:00:00	50	20
2451	2026-05-20 02:00:00	4	20
2461	2026-05-20 02:00:00	5	20
2471	2026-05-20 02:00:00	3	171.6
2482	2026-05-20 02:00:00	2	24.47
2492	2026-05-20 02:00:00	1	12
2507	2026-05-20 03:00:00	38	198
2520	2026-05-20 03:00:00	40	20
2524	2026-05-20 03:00:00	36	20
2531	2026-05-20 03:00:00	37	28.45
2543	2026-05-20 03:00:00	39	20
2555	2026-05-20 04:00:00	29	20
2568	2026-05-20 04:00:00	30	20
2578	2026-05-20 04:00:00	26	40
2589	2026-05-20 04:00:00	27	38.32
2598	2026-05-20 04:00:00	28	264
2602	2026-05-20 05:00:00	8	171.6
2615	2026-05-20 05:00:00	6	12
2626	2026-05-20 05:00:00	10	20
2634	2026-05-20 05:00:00	9	20
2646	2026-05-20 05:00:00	7	24.34
2654	2026-05-20 06:00:00	23	264
2668	2026-05-20 06:00:00	24	20
2681	2026-05-20 06:00:00	21	40
2692	2026-05-20 06:00:00	25	20
2700	2026-05-20 06:00:00	22	38.28
2701	2026-05-20 07:00:00	4	20
2711	2026-05-20 07:00:00	1	12
2724	2026-05-20 07:00:00	5	20
2731	2026-05-20 07:00:00	3	171.6
2741	2026-05-20 07:00:00	2	24.22
3701	2026-05-21 03:00:00	5	20
3711	2026-05-21 03:00:00	3	171.6
3724	2026-05-21 03:00:00	2	24.27
3736	2026-05-21 03:00:00	4	20
3745	2026-05-21 03:00:00	1	12
3756	2026-05-21 04:00:00	18	264
3766	2026-05-21 04:00:00	20	20
3774	2026-05-21 04:00:00	17	38.47
3786	2026-05-21 04:00:00	16	40
3797	2026-05-21 04:00:00	19	20
3804	2026-05-21 05:00:00	17	38.4
3819	2026-05-21 05:00:00	16	40
3828	2026-05-21 05:00:00	19	20
3839	2026-05-21 05:00:00	18	264
3847	2026-05-21 05:00:00	20	20
3852	2026-05-21 06:00:00	5	20
3863	2026-05-21 06:00:00	3	171.6
3873	2026-05-21 06:00:00	2	24.39
3882	2026-05-21 06:00:00	4	20
3892	2026-05-21 06:00:00	1	12
3905	2026-05-21 07:00:00	44	20
3918	2026-05-21 07:00:00	45	20
3924	2026-05-21 07:00:00	42	38.41
3935	2026-05-21 07:00:00	41	40
3946	2026-05-21 07:00:00	43	264
3954	2026-05-21 08:00:00	18	264
3966	2026-05-21 08:00:00	20	20
3974	2026-05-21 08:00:00	17	38.4
3984	2026-05-21 08:00:00	16	40
3994	2026-05-21 08:00:00	19	20
4006	2026-05-21 09:00:00	35	20
4011	2026-05-21 09:00:00	31	40
4022	2026-05-21 09:00:00	33	264
4033	2026-05-21 09:00:00	32	38.42
4045	2026-05-21 09:00:00	34	20
4056	2026-05-21 10:00:00	23	264
4067	2026-05-21 10:00:00	24	20
4077	2026-05-21 10:00:00	21	40
4087	2026-05-21 10:00:00	25	20
4098	2026-05-21 10:00:00	22	38.4
4104	2026-05-21 11:00:00	22	38.34
4116	2026-05-21 11:00:00	23	264
4128	2026-05-21 11:00:00	24	20
4138	2026-05-21 11:00:00	21	40
4147	2026-05-21 11:00:00	25	20
4152	2026-05-21 12:00:00	15	15
2257	2026-05-19 22:00:00	50	20
2256	2026-05-19 22:00:00	35	20
2266	2026-05-19 22:00:00	33	198
2268	2026-05-19 22:00:00	46	20
2273	2026-05-19 22:00:00	32	28.47
2276	2026-05-19 22:00:00	49	20
2282	2026-05-19 22:00:00	31	20
2291	2026-05-19 22:00:00	47	28.3
2292	2026-05-19 22:00:00	34	20
2300	2026-05-19 22:00:00	48	198
2301	2026-05-19 23:00:00	4	20
2309	2026-05-19 23:00:00	43	198
2315	2026-05-19 23:00:00	5	20
2319	2026-05-19 23:00:00	44	20
2327	2026-05-19 23:00:00	3	171.6
2329	2026-05-19 23:00:00	45	20
2337	2026-05-19 23:00:00	2	24.49
2338	2026-05-19 23:00:00	41	20
2346	2026-05-19 23:00:00	1	12
2347	2026-05-19 23:00:00	42	28.35
2353	2026-05-20 00:00:00	29	20
2354	2026-05-20 00:00:00	14	20
2366	2026-05-20 00:00:00	12	28.37
2368	2026-05-20 00:00:00	26	20
2374	2026-05-20 00:00:00	30	20
2379	2026-05-20 00:00:00	11	20
2381	2026-05-20 00:00:00	27	28.45
2389	2026-05-20 00:00:00	15	20
2390	2026-05-20 00:00:00	28	198
2399	2026-05-20 00:00:00	13	198
2402	2026-05-20 01:00:00	6	12
2409	2026-05-20 01:00:00	43	198
2412	2026-05-20 01:00:00	9	20
2419	2026-05-20 01:00:00	7	24.38
2423	2026-05-20 01:00:00	44	20
2427	2026-05-20 01:00:00	8	171.6
2429	2026-05-20 01:00:00	45	20
2438	2026-05-20 01:00:00	10	20
2439	2026-05-20 01:00:00	41	20
2447	2026-05-20 01:00:00	42	28.45
2456	2026-05-20 02:00:00	25	20
2458	2026-05-20 02:00:00	43	198
2467	2026-05-20 02:00:00	21	20
2470	2026-05-20 02:00:00	44	20
2476	2026-05-20 02:00:00	22	28.39
2480	2026-05-20 02:00:00	45	20
2487	2026-05-20 02:00:00	23	198
2491	2026-05-20 02:00:00	41	20
2496	2026-05-20 02:00:00	24	20
2500	2026-05-20 02:00:00	42	28.48
2501	2026-05-20 03:00:00	5	20
2510	2026-05-20 03:00:00	25	20
2512	2026-05-20 03:00:00	21	20
2514	2026-05-20 03:00:00	3	171.6
2521	2026-05-20 03:00:00	22	28.22
2522	2026-05-20 03:00:00	2	24.2
2533	2026-05-20 03:00:00	23	198
2534	2026-05-20 03:00:00	1	12
2541	2026-05-20 03:00:00	24	20
2544	2026-05-20 03:00:00	4	20
2557	2026-05-20 04:00:00	34	20
2560	2026-05-20 04:00:00	49	20
2563	2026-05-20 04:00:00	35	20
2569	2026-05-20 04:00:00	47	38.36
2574	2026-05-20 04:00:00	31	40
2581	2026-05-20 04:00:00	48	264
2584	2026-05-20 04:00:00	33	264
2591	2026-05-20 04:00:00	46	40
2594	2026-05-20 04:00:00	32	38.39
2599	2026-05-20 04:00:00	50	20
2601	2026-05-20 05:00:00	1	12
2607	2026-05-20 05:00:00	39	20
2614	2026-05-20 05:00:00	5	20
2620	2026-05-20 05:00:00	36	40
2622	2026-05-20 05:00:00	3	171.6
2630	2026-05-20 05:00:00	2	24.3
2632	2026-05-20 05:00:00	38	264
2640	2026-05-20 05:00:00	4	20
2642	2026-05-20 05:00:00	40	20
2650	2026-05-20 05:00:00	37	38.22
2651	2026-05-20 06:00:00	4	20
2660	2026-05-20 06:00:00	47	38.28
2666	2026-05-20 06:00:00	1	12
2670	2026-05-20 06:00:00	48	264
2678	2026-05-20 06:00:00	5	20
2683	2026-05-20 06:00:00	46	40
2687	2026-05-20 06:00:00	3	171.6
2693	2026-05-20 06:00:00	50	20
2697	2026-05-20 06:00:00	2	24.38
2699	2026-05-20 06:00:00	49	20
2703	2026-05-20 07:00:00	19	20
2704	2026-05-20 07:00:00	11	40
2714	2026-05-20 07:00:00	13	264
2719	2026-05-20 07:00:00	18	264
2729	2026-05-20 07:00:00	20	20
2730	2026-05-20 07:00:00	14	20
2739	2026-05-20 07:00:00	12	38.32
2740	2026-05-20 07:00:00	17	38.26
2746	2026-05-20 07:00:00	16	40
2750	2026-05-20 07:00:00	15	20
3702	2026-05-21 03:00:00	8	171.6
3712	2026-05-21 03:00:00	6	12
3721	2026-05-21 03:00:00	10	20
3725	2026-05-21 03:00:00	9	20
3734	2026-05-21 03:00:00	7	24.48
3760	2026-05-21 04:00:00	46	40
3771	2026-05-21 04:00:00	50	20
3782	2026-05-21 04:00:00	49	20
3792	2026-05-21 04:00:00	47	38.37
3800	2026-05-21 04:00:00	48	264
3801	2026-05-21 05:00:00	2	24.26
3813	2026-05-21 05:00:00	4	20
3826	2026-05-21 05:00:00	1	12
3835	2026-05-21 05:00:00	5	20
3844	2026-05-21 05:00:00	3	171.6
3857	2026-05-21 06:00:00	28	264
3869	2026-05-21 06:00:00	29	20
3879	2026-05-21 06:00:00	30	20
3887	2026-05-21 06:00:00	26	40
3899	2026-05-21 06:00:00	27	38.48
3910	2026-05-21 07:00:00	32	38.28
3919	2026-05-21 07:00:00	34	20
3928	2026-05-21 07:00:00	35	20
3940	2026-05-21 07:00:00	31	40
3950	2026-05-21 07:00:00	33	264
3951	2026-05-21 08:00:00	5	20
3961	2026-05-21 08:00:00	3	171.6
3971	2026-05-21 08:00:00	2	24.4
3981	2026-05-21 08:00:00	4	20
3992	2026-05-21 08:00:00	1	12
4007	2026-05-21 09:00:00	38	264
4020	2026-05-21 09:00:00	40	20
4029	2026-05-21 09:00:00	37	38.37
4040	2026-05-21 09:00:00	39	20
4049	2026-05-21 09:00:00	36	40
4053	2026-05-21 10:00:00	16	40
857	2026-05-18 18:00:00	39	20
865	2026-05-18 18:00:00	38	198
880	2026-05-18 18:00:00	40	20
890	2026-05-18 18:00:00	36	20
899	2026-05-18 18:00:00	37	28.21
901	2026-05-18 19:00:00	3	171.6
915	2026-05-18 19:00:00	2	24.22
926	2026-05-18 19:00:00	1	12
933	2026-05-18 19:00:00	4	20
944	2026-05-18 19:00:00	5	20
955	2026-05-18 20:00:00	26	20
963	2026-05-18 20:00:00	30	20
971	2026-05-18 20:00:00	27	28.24
976	2026-05-18 20:00:00	28	198
984	2026-05-18 20:00:00	29	20
1009	2026-05-18 21:00:00	48	198
1019	2026-05-18 21:00:00	50	20
1030	2026-05-18 21:00:00	46	20
1042	2026-05-18 21:00:00	49	20
1049	2026-05-18 21:00:00	47	28.47
1052	2026-05-18 22:00:00	8	171.6
1065	2026-05-18 22:00:00	10	20
1079	2026-05-18 22:00:00	6	12
1087	2026-05-18 22:00:00	9	20
1097	2026-05-18 22:00:00	7	24.25
1103	2026-05-18 23:00:00	14	20
1112	2026-05-18 23:00:00	12	28.46
1126	2026-05-18 23:00:00	11	20
1138	2026-05-18 23:00:00	15	20
1146	2026-05-18 23:00:00	13	198
1155	2026-05-19 00:00:00	25	20
1166	2026-05-19 00:00:00	21	20
1173	2026-05-19 00:00:00	22	28.31
1179	2026-05-19 00:00:00	23	198
1191	2026-05-19 00:00:00	24	20
1208	2026-05-19 01:00:00	42	28.33
1219	2026-05-19 01:00:00	43	198
1228	2026-05-19 01:00:00	44	20
1239	2026-05-19 01:00:00	45	20
1249	2026-05-19 01:00:00	41	20
2258	2026-05-19 22:00:00	24	20
2261	2026-05-19 22:00:00	25	20
2271	2026-05-19 22:00:00	21	20
2278	2026-05-19 22:00:00	22	28.23
2283	2026-05-19 22:00:00	23	198
2310	2026-05-19 23:00:00	46	20
2318	2026-05-19 23:00:00	49	20
2330	2026-05-19 23:00:00	47	28.27
2340	2026-05-19 23:00:00	48	198
2350	2026-05-19 23:00:00	50	20
2356	2026-05-20 00:00:00	22	28.24
2365	2026-05-20 00:00:00	23	198
2377	2026-05-20 00:00:00	24	20
2387	2026-05-20 00:00:00	25	20
2398	2026-05-20 00:00:00	21	20
2403	2026-05-20 01:00:00	15	20
2416	2026-05-20 01:00:00	13	198
2426	2026-05-20 01:00:00	14	20
2437	2026-05-20 01:00:00	12	28.33
2446	2026-05-20 01:00:00	11	20
2453	2026-05-20 02:00:00	17	28.22
2463	2026-05-20 02:00:00	16	20
2473	2026-05-20 02:00:00	19	20
2483	2026-05-20 02:00:00	18	198
2495	2026-05-20 02:00:00	20	20
2505	2026-05-20 03:00:00	27	28.44
2517	2026-05-20 03:00:00	28	198
2529	2026-05-20 03:00:00	29	20
2537	2026-05-20 03:00:00	26	20
2546	2026-05-20 03:00:00	30	20
2559	2026-05-20 04:00:00	44	20
2570	2026-05-20 04:00:00	45	20
2580	2026-05-20 04:00:00	42	38.25
2590	2026-05-20 04:00:00	41	40
2600	2026-05-20 04:00:00	43	264
2608	2026-05-20 05:00:00	24	20
2612	2026-05-20 05:00:00	21	40
2621	2026-05-20 05:00:00	25	20
2633	2026-05-20 05:00:00	22	38.38
2643	2026-05-20 05:00:00	23	264
2658	2026-05-20 06:00:00	40	20
2664	2026-05-20 06:00:00	37	38.44
2673	2026-05-20 06:00:00	39	20
2682	2026-05-20 06:00:00	36	40
2688	2026-05-20 06:00:00	38	264
2708	2026-05-20 07:00:00	49	20
2717	2026-05-20 07:00:00	47	38.21
2728	2026-05-20 07:00:00	48	264
2736	2026-05-20 07:00:00	46	40
2742	2026-05-20 07:00:00	50	20
3703	2026-05-21 03:00:00	18	264
3713	2026-05-21 03:00:00	20	20
3722	2026-05-21 03:00:00	17	38.36
3732	2026-05-21 03:00:00	16	40
3741	2026-05-21 03:00:00	19	20
3758	2026-05-21 04:00:00	45	20
3761	2026-05-21 04:00:00	42	38.32
3770	2026-05-21 04:00:00	41	40
3777	2026-05-21 04:00:00	43	264
3788	2026-05-21 04:00:00	44	20
3810	2026-05-21 05:00:00	50	20
3818	2026-05-21 05:00:00	49	20
3830	2026-05-21 05:00:00	47	38.19
3841	2026-05-21 05:00:00	48	264
3849	2026-05-21 05:00:00	46	40
3853	2026-05-21 06:00:00	13	261
3866	2026-05-21 06:00:00	14	15
3877	2026-05-21 06:00:00	12	54.27
3886	2026-05-21 06:00:00	15	15
3897	2026-05-21 06:00:00	11	40
3903	2026-05-21 07:00:00	10	20
3913	2026-05-21 07:00:00	9	20
3923	2026-05-21 07:00:00	7	24.23
3933	2026-05-21 07:00:00	8	171.6
3943	2026-05-21 07:00:00	6	12
3959	2026-05-21 08:00:00	36	40
3969	2026-05-21 08:00:00	38	264
3980	2026-05-21 08:00:00	40	20
3990	2026-05-21 08:00:00	37	38.27
4000	2026-05-21 08:00:00	39	20
4001	2026-05-21 09:00:00	2	24.45
4012	2026-05-21 09:00:00	4	20
4024	2026-05-21 09:00:00	1	12
4032	2026-05-21 09:00:00	5	20
4042	2026-05-21 09:00:00	3	171.6
4057	2026-05-21 10:00:00	43	264
4070	2026-05-21 10:00:00	44	20
4079	2026-05-21 10:00:00	45	20
4089	2026-05-21 10:00:00	42	38.27
4100	2026-05-21 10:00:00	41	40
4102	2026-05-21 11:00:00	1	12
4115	2026-05-21 11:00:00	5	20
4124	2026-05-21 11:00:00	3	171.6
4133	2026-05-21 11:00:00	2	24.28
4143	2026-05-21 11:00:00	4	20
4157	2026-05-21 12:00:00	29	20
2259	2026-05-19 22:00:00	40	20
2270	2026-05-19 22:00:00	36	20
2279	2026-05-19 22:00:00	37	28.44
2289	2026-05-19 22:00:00	39	20
2298	2026-05-19 22:00:00	38	198
2304	2026-05-19 23:00:00	15	20
2314	2026-05-19 23:00:00	13	198
2325	2026-05-19 23:00:00	14	20
2336	2026-05-19 23:00:00	12	28.24
2345	2026-05-19 23:00:00	11	20
2357	2026-05-20 00:00:00	37	28.21
2370	2026-05-20 00:00:00	39	20
2382	2026-05-20 00:00:00	38	198
2392	2026-05-20 00:00:00	40	20
2397	2026-05-20 00:00:00	36	20
2404	2026-05-20 01:00:00	16	20
2417	2026-05-20 01:00:00	19	20
2430	2026-05-20 01:00:00	18	198
2440	2026-05-20 01:00:00	20	20
2449	2026-05-20 01:00:00	17	28.25
2455	2026-05-20 02:00:00	6	12
2465	2026-05-20 02:00:00	9	20
2477	2026-05-20 02:00:00	7	24.41
2485	2026-05-20 02:00:00	8	171.6
2497	2026-05-20 02:00:00	10	20
2502	2026-05-20 03:00:00	16	20
2519	2026-05-20 03:00:00	19	20
2528	2026-05-20 03:00:00	18	198
2539	2026-05-20 03:00:00	20	20
2549	2026-05-20 03:00:00	17	28.43
2551	2026-05-20 04:00:00	2	24.47
2565	2026-05-20 04:00:00	4	20
2573	2026-05-20 04:00:00	1	12
2585	2026-05-20 04:00:00	5	20
2595	2026-05-20 04:00:00	3	171.6
2604	2026-05-20 05:00:00	27	38.46
2618	2026-05-20 05:00:00	28	264
2629	2026-05-20 05:00:00	29	20
2638	2026-05-20 05:00:00	30	20
2649	2026-05-20 05:00:00	26	40
2653	2026-05-20 06:00:00	11	40
2667	2026-05-20 06:00:00	13	264
2675	2026-05-20 06:00:00	14	20
2685	2026-05-20 06:00:00	12	38.27
2695	2026-05-20 06:00:00	15	20
2710	2026-05-20 07:00:00	30	20
2715	2026-05-20 07:00:00	26	40
2723	2026-05-20 07:00:00	27	38.23
2735	2026-05-20 07:00:00	28	264
2744	2026-05-20 07:00:00	29	20
3707	2026-05-21 03:00:00	37	38.39
3718	2026-05-21 03:00:00	39	20
3731	2026-05-21 03:00:00	36	40
3740	2026-05-21 03:00:00	38	264
3749	2026-05-21 03:00:00	40	20
3755	2026-05-21 04:00:00	24	20
3768	2026-05-21 04:00:00	21	40
3779	2026-05-21 04:00:00	25	20
3787	2026-05-21 04:00:00	22	38.3
3795	2026-05-21 04:00:00	23	264
3806	2026-05-21 05:00:00	22	38.43
3816	2026-05-21 05:00:00	23	264
3823	2026-05-21 05:00:00	24	20
3832	2026-05-21 05:00:00	21	40
3837	2026-05-21 05:00:00	25	20
3860	2026-05-21 06:00:00	45	20
3867	2026-05-21 06:00:00	42	38.49
3872	2026-05-21 06:00:00	41	40
3884	2026-05-21 06:00:00	43	264
3894	2026-05-21 06:00:00	44	20
3906	2026-05-21 07:00:00	24	20
3920	2026-05-21 07:00:00	21	40
3930	2026-05-21 07:00:00	25	20
3942	2026-05-21 07:00:00	22	38.3
3949	2026-05-21 07:00:00	23	264
3953	2026-05-21 08:00:00	11	40
3964	2026-05-21 08:00:00	13	261
3973	2026-05-21 08:00:00	14	15
3983	2026-05-21 08:00:00	12	54.25
3993	2026-05-21 08:00:00	15	15
4010	2026-05-21 09:00:00	45	20
4014	2026-05-21 09:00:00	42	38.23
4026	2026-05-21 09:00:00	41	40
4035	2026-05-21 09:00:00	43	264
4044	2026-05-21 09:00:00	44	20
4052	2026-05-21 10:00:00	30	20
4062	2026-05-21 10:00:00	26	40
4074	2026-05-21 10:00:00	27	38.25
4083	2026-05-21 10:00:00	28	264
4093	2026-05-21 10:00:00	29	20
4109	2026-05-21 11:00:00	40	20
4118	2026-05-21 11:00:00	37	38.47
4127	2026-05-21 11:00:00	39	20
4137	2026-05-21 11:00:00	36	40
4148	2026-05-21 11:00:00	38	264
4151	2026-05-21 12:00:00	2	24.3
4163	2026-05-21 12:00:00	4	20
4173	2026-05-21 12:00:00	1	12
4188	2026-05-21 12:00:00	5	20
4199	2026-05-21 12:00:00	3	171.6
4206	2026-05-21 13:00:00	34	20
4212	2026-05-21 13:00:00	35	20
4221	2026-05-21 13:00:00	31	40
4231	2026-05-21 13:00:00	33	264
4241	2026-05-21 13:00:00	32	38.42
4242	2026-05-21 13:00:00	9	20
4258	2026-05-21 14:00:00	50	20
4259	2026-05-21 14:00:00	41	40
4264	2026-05-21 14:00:00	43	264
4265	2026-05-21 14:00:00	49	20
4271	2026-05-21 14:00:00	44	20
4275	2026-05-21 14:00:00	47	38.32
4279	2026-05-21 14:00:00	5	20
4280	2026-05-21 14:00:00	45	20
4284	2026-05-21 14:00:00	48	264
4288	2026-05-21 14:00:00	3	171.6
4290	2026-05-21 14:00:00	42	38.35
4291	2026-05-21 14:00:00	46	40
4299	2026-05-21 14:00:00	2	24.38
4302	2026-05-21 15:00:00	7	24.24
4304	2026-05-21 15:00:00	17	38.47
4306	2026-05-21 15:00:00	39	20
4308	2026-05-21 15:00:00	47	38.39
4311	2026-05-21 15:00:00	16	40
4314	2026-05-21 15:00:00	48	264
4317	2026-05-21 15:00:00	8	171.6
4318	2026-05-21 15:00:00	36	40
4321	2026-05-21 15:00:00	19	20
4324	2026-05-21 15:00:00	18	264
4328	2026-05-21 15:00:00	46	40
4329	2026-05-21 15:00:00	6	12
4330	2026-05-21 15:00:00	25	20
4332	2026-05-21 15:00:00	38	264
4334	2026-05-21 15:00:00	22	38.24
4336	2026-05-21 15:00:00	20	20
4338	2026-05-21 15:00:00	10	20
2260	2026-05-19 22:00:00	42	28.47
2267	2026-05-19 22:00:00	43	198
2281	2026-05-19 22:00:00	44	20
2290	2026-05-19 22:00:00	45	20
2299	2026-05-19 22:00:00	41	20
2302	2026-05-19 23:00:00	6	12
2311	2026-05-19 23:00:00	9	20
2324	2026-05-19 23:00:00	7	24.46
2334	2026-05-19 23:00:00	8	171.6
2348	2026-05-19 23:00:00	10	20
2359	2026-05-20 00:00:00	19	20
2367	2026-05-20 00:00:00	18	198
2373	2026-05-20 00:00:00	20	20
2380	2026-05-20 00:00:00	17	28.19
2391	2026-05-20 00:00:00	16	20
2406	2026-05-20 01:00:00	38	198
2415	2026-05-20 01:00:00	40	20
2422	2026-05-20 01:00:00	36	20
2431	2026-05-20 01:00:00	37	28.27
2443	2026-05-20 01:00:00	39	20
2459	2026-05-20 02:00:00	33	198
2468	2026-05-20 02:00:00	32	28.44
2479	2026-05-20 02:00:00	31	20
2490	2026-05-20 02:00:00	34	20
2499	2026-05-20 02:00:00	35	20
2504	2026-05-20 03:00:00	13	198
2511	2026-05-20 03:00:00	14	20
2523	2026-05-20 03:00:00	12	28.34
2536	2026-05-20 03:00:00	11	20
2547	2026-05-20 03:00:00	15	20
2553	2026-05-20 04:00:00	19	20
2562	2026-05-20 04:00:00	18	264
2572	2026-05-20 04:00:00	20	20
2583	2026-05-20 04:00:00	17	38.42
2593	2026-05-20 04:00:00	16	40
2605	2026-05-20 05:00:00	31	40
2617	2026-05-20 05:00:00	33	264
2628	2026-05-20 05:00:00	32	38.28
2639	2026-05-20 05:00:00	34	20
2645	2026-05-20 05:00:00	35	20
2656	2026-05-20 06:00:00	19	20
2662	2026-05-20 06:00:00	18	264
2674	2026-05-20 06:00:00	20	20
2684	2026-05-20 06:00:00	17	38.49
2694	2026-05-20 06:00:00	16	40
2707	2026-05-20 07:00:00	34	20
2718	2026-05-20 07:00:00	35	20
2726	2026-05-20 07:00:00	31	40
2738	2026-05-20 07:00:00	33	264
2748	2026-05-20 07:00:00	32	38.43
3704	2026-05-21 03:00:00	24	20
3706	2026-05-21 03:00:00	35	20
3714	2026-05-21 03:00:00	21	40
3717	2026-05-21 03:00:00	31	40
3723	2026-05-21 03:00:00	33	264
3726	2026-05-21 03:00:00	25	20
3733	2026-05-21 03:00:00	32	38.23
3735	2026-05-21 03:00:00	22	38.4
3743	2026-05-21 03:00:00	34	20
3747	2026-05-21 03:00:00	23	264
3757	2026-05-21 04:00:00	35	20
3759	2026-05-21 04:00:00	37	38.23
3767	2026-05-21 04:00:00	31	40
3769	2026-05-21 04:00:00	39	20
3778	2026-05-21 04:00:00	33	264
3780	2026-05-21 04:00:00	36	40
3789	2026-05-21 04:00:00	32	38.26
3791	2026-05-21 04:00:00	38	264
3798	2026-05-21 04:00:00	34	20
3799	2026-05-21 04:00:00	40	20
3802	2026-05-21 05:00:00	8	171.6
3803	2026-05-21 05:00:00	12	54.13
3812	2026-05-21 05:00:00	6	12
3814	2026-05-21 05:00:00	15	15
3825	2026-05-21 05:00:00	10	20
3827	2026-05-21 05:00:00	11	40
3836	2026-05-21 05:00:00	9	20
3838	2026-05-21 05:00:00	13	261
3845	2026-05-21 05:00:00	7	24.26
3846	2026-05-21 05:00:00	14	15
3856	2026-05-21 06:00:00	21	40
3858	2026-05-21 06:00:00	38	264
3861	2026-05-21 06:00:00	40	20
3868	2026-05-21 06:00:00	25	20
3874	2026-05-21 06:00:00	37	38.26
3878	2026-05-21 06:00:00	22	38.38
3883	2026-05-21 06:00:00	39	20
3889	2026-05-21 06:00:00	23	264
3893	2026-05-21 06:00:00	36	40
3896	2026-05-21 06:00:00	24	20
3904	2026-05-21 07:00:00	18	264
3908	2026-05-21 07:00:00	36	40
3916	2026-05-21 07:00:00	38	264
3917	2026-05-21 07:00:00	20	20
3927	2026-05-21 07:00:00	17	38.38
3929	2026-05-21 07:00:00	40	20
3936	2026-05-21 07:00:00	16	40
3938	2026-05-21 07:00:00	37	38.26
3947	2026-05-21 07:00:00	19	20
3948	2026-05-21 07:00:00	39	20
3952	2026-05-21 08:00:00	7	24.19
3955	2026-05-21 08:00:00	24	20
3962	2026-05-21 08:00:00	8	171.6
3967	2026-05-21 08:00:00	21	40
3977	2026-05-21 08:00:00	25	20
3978	2026-05-21 08:00:00	6	12
3986	2026-05-21 08:00:00	10	20
3988	2026-05-21 08:00:00	22	38.49
3996	2026-05-21 08:00:00	9	20
3998	2026-05-21 08:00:00	23	264
4003	2026-05-21 09:00:00	20	20
4009	2026-05-21 09:00:00	28	264
4016	2026-05-21 09:00:00	17	38.41
4019	2026-05-21 09:00:00	29	20
4028	2026-05-21 09:00:00	30	20
4030	2026-05-21 09:00:00	16	40
4037	2026-05-21 09:00:00	26	40
4039	2026-05-21 09:00:00	19	20
4048	2026-05-21 09:00:00	27	38.44
4050	2026-05-21 09:00:00	18	264
4051	2026-05-21 10:00:00	5	20
4054	2026-05-21 10:00:00	7	24.46
4061	2026-05-21 10:00:00	3	171.6
4065	2026-05-21 10:00:00	8	171.6
4075	2026-05-21 10:00:00	2	24.48
4078	2026-05-21 10:00:00	6	12
4084	2026-05-21 10:00:00	4	20
4086	2026-05-21 10:00:00	10	20
4091	2026-05-21 10:00:00	1	12
4094	2026-05-21 10:00:00	9	20
4106	2026-05-21 11:00:00	29	20
4110	2026-05-21 11:00:00	46	40
4112	2026-05-21 11:00:00	30	20
4119	2026-05-21 11:00:00	50	20
4121	2026-05-21 11:00:00	26	40
4123	2026-05-21 11:00:00	49	20
852	2026-05-18 18:00:00	7	24.26
861	2026-05-18 18:00:00	8	171.6
874	2026-05-18 18:00:00	10	20
885	2026-05-18 18:00:00	6	12
896	2026-05-18 18:00:00	9	20
906	2026-05-18 19:00:00	26	20
912	2026-05-18 19:00:00	30	20
922	2026-05-18 19:00:00	27	28.2
934	2026-05-18 19:00:00	28	198
943	2026-05-18 19:00:00	29	20
957	2026-05-18 20:00:00	32	28.26
968	2026-05-18 20:00:00	31	20
977	2026-05-18 20:00:00	34	20
986	2026-05-18 20:00:00	35	20
992	2026-05-18 20:00:00	33	198
1007	2026-05-18 21:00:00	30	20
1021	2026-05-18 21:00:00	27	28.31
1033	2026-05-18 21:00:00	28	198
1043	2026-05-18 21:00:00	29	20
1050	2026-05-18 21:00:00	26	20
1051	2026-05-18 22:00:00	4	20
1064	2026-05-18 22:00:00	5	20
1077	2026-05-18 22:00:00	3	171.6
1089	2026-05-18 22:00:00	2	24.38
1096	2026-05-18 22:00:00	1	12
1106	2026-05-18 23:00:00	27	28.26
1119	2026-05-18 23:00:00	28	198
1132	2026-05-18 23:00:00	29	20
1144	2026-05-18 23:00:00	26	20
1150	2026-05-18 23:00:00	30	20
1151	2026-05-19 00:00:00	3	171.6
1162	2026-05-19 00:00:00	2	24.34
1176	2026-05-19 00:00:00	1	12
1186	2026-05-19 00:00:00	4	20
1194	2026-05-19 00:00:00	5	20
1206	2026-05-19 01:00:00	30	20
1217	2026-05-19 01:00:00	27	28.43
1229	2026-05-19 01:00:00	28	198
1240	2026-05-19 01:00:00	29	20
1248	2026-05-19 01:00:00	26	20
2331	2026-05-19 23:00:00	23	198
2341	2026-05-19 23:00:00	24	20
2355	2026-05-20 00:00:00	31	20
2362	2026-05-20 00:00:00	34	20
2372	2026-05-20 00:00:00	35	20
2384	2026-05-20 00:00:00	33	198
2395	2026-05-20 00:00:00	32	28.29
2405	2026-05-20 01:00:00	25	20
2413	2026-05-20 01:00:00	21	20
2420	2026-05-20 01:00:00	22	28.32
2434	2026-05-20 01:00:00	23	198
2444	2026-05-20 01:00:00	24	20
2457	2026-05-20 02:00:00	27	28.45
2466	2026-05-20 02:00:00	28	198
2474	2026-05-20 02:00:00	29	20
2484	2026-05-20 02:00:00	26	20
2494	2026-05-20 02:00:00	30	20
2506	2026-05-20 03:00:00	33	198
2513	2026-05-20 03:00:00	32	28.44
2526	2026-05-20 03:00:00	31	20
2538	2026-05-20 03:00:00	34	20
2548	2026-05-20 03:00:00	35	20
2554	2026-05-20 04:00:00	11	40
2561	2026-05-20 04:00:00	13	264
2571	2026-05-20 04:00:00	14	20
2579	2026-05-20 04:00:00	12	38.29
2586	2026-05-20 04:00:00	15	20
2610	2026-05-20 05:00:00	48	264
2613	2026-05-20 05:00:00	46	40
2625	2026-05-20 05:00:00	50	20
2636	2026-05-20 05:00:00	49	20
2647	2026-05-20 05:00:00	47	38.25
2655	2026-05-20 06:00:00	30	20
2661	2026-05-20 06:00:00	26	40
2671	2026-05-20 06:00:00	27	38.34
2679	2026-05-20 06:00:00	28	264
2690	2026-05-20 06:00:00	29	20
2706	2026-05-20 07:00:00	40	20
2720	2026-05-20 07:00:00	37	38.34
2727	2026-05-20 07:00:00	39	20
2737	2026-05-20 07:00:00	36	40
2749	2026-05-20 07:00:00	38	264
3705	2026-05-21 03:00:00	13	261
3715	2026-05-21 03:00:00	14	15
3727	2026-05-21 03:00:00	12	54.36
3737	2026-05-21 03:00:00	15	15
3744	2026-05-21 03:00:00	11	40
3754	2026-05-21 04:00:00	28	264
3765	2026-05-21 04:00:00	29	20
3772	2026-05-21 04:00:00	30	20
3783	2026-05-21 04:00:00	26	40
3793	2026-05-21 04:00:00	27	38.34
3809	2026-05-21 05:00:00	41	40
3817	2026-05-21 05:00:00	43	264
3829	2026-05-21 05:00:00	44	20
3840	2026-05-21 05:00:00	45	20
3850	2026-05-21 05:00:00	42	38.47
3851	2026-05-21 06:00:00	9	20
3864	2026-05-21 06:00:00	7	24.35
3876	2026-05-21 06:00:00	8	171.6
3888	2026-05-21 06:00:00	6	12
3898	2026-05-21 06:00:00	10	20
3902	2026-05-21 07:00:00	11	40
3914	2026-05-21 07:00:00	13	261
3925	2026-05-21 07:00:00	14	15
3934	2026-05-21 07:00:00	12	54.16
3944	2026-05-21 07:00:00	15	15
3957	2026-05-21 08:00:00	27	38.2
3965	2026-05-21 08:00:00	28	264
3975	2026-05-21 08:00:00	29	20
3989	2026-05-21 08:00:00	30	20
3997	2026-05-21 08:00:00	26	40
4005	2026-05-21 09:00:00	14	15
4018	2026-05-21 09:00:00	12	54.34
4027	2026-05-21 09:00:00	15	15
4036	2026-05-21 09:00:00	11	40
4047	2026-05-21 09:00:00	13	261
4055	2026-05-21 10:00:00	11	40
4064	2026-05-21 10:00:00	13	261
4073	2026-05-21 10:00:00	14	15
4085	2026-05-21 10:00:00	12	54.36
4096	2026-05-21 10:00:00	15	15
4107	2026-05-21 11:00:00	32	38.35
4120	2026-05-21 11:00:00	34	20
4130	2026-05-21 11:00:00	35	20
4139	2026-05-21 11:00:00	31	40
4150	2026-05-21 11:00:00	33	264
4156	2026-05-21 12:00:00	17	64.3
4172	2026-05-21 12:00:00	16	92
4181	2026-05-21 12:00:00	19	20
4191	2026-05-21 12:00:00	18	435.6
4197	2026-05-21 12:00:00	20	20
4207	2026-05-21 13:00:00	37	38.22
4211	2026-05-21 13:00:00	39	20
4222	2026-05-21 13:00:00	36	40
4233	2026-05-21 13:00:00	38	264
4353	2026-05-21 16:00:00	11	40
4361	2026-05-21 16:00:00	13	261
4369	2026-05-21 16:00:00	14	15
4379	2026-05-21 16:00:00	12	54.16
4389	2026-05-21 16:00:00	15	15
4405	2026-05-21 17:00:00	41	40
4416	2026-05-21 17:00:00	43	264
4427	2026-05-21 17:00:00	44	20
4437	2026-05-21 17:00:00	45	20
4447	2026-05-21 17:00:00	42	38.28
4456	2026-05-21 18:00:00	19	20
4464	2026-05-21 18:00:00	18	264
4475	2026-05-21 18:00:00	20	20
4486	2026-05-21 18:00:00	17	38.34
4493	2026-05-21 18:00:00	16	40
4507	2026-05-21 19:00:00	40	20
4515	2026-05-21 19:00:00	37	38.32
4527	2026-05-21 19:00:00	39	20
4535	2026-05-21 19:00:00	36	40
4547	2026-05-21 19:00:00	38	264
4555	2026-05-21 20:00:00	29	20
4565	2026-05-21 20:00:00	30	20
4571	2026-05-21 20:00:00	26	40
4581	2026-05-21 20:00:00	27	38.38
4591	2026-05-21 20:00:00	28	264
4610	2026-05-21 21:00:00	48	264
4620	2026-05-21 21:00:00	46	40
4631	2026-05-21 21:00:00	50	20
4643	2026-05-21 21:00:00	49	20
4650	2026-05-21 21:00:00	47	38.2
4652	2026-05-21 22:00:00	3	171.6
4667	2026-05-21 22:00:00	4	20
4682	2026-05-21 22:00:00	2	24.3
4696	2026-05-21 22:00:00	5	20
4700	2026-05-21 22:00:00	1	12
4701	2026-05-21 23:00:00	3	171.6
4711	2026-05-21 23:00:00	1	12
4721	2026-05-21 23:00:00	4	20
4730	2026-05-21 23:00:00	2	24.22
4741	2026-05-21 23:00:00	5	20
4760	2026-05-22 01:00:00	50	20
4761	2026-05-22 01:00:00	49	20
4771	2026-05-22 01:00:00	47	38.35
4777	2026-05-22 01:00:00	48	264
4795	2026-05-22 01:00:00	46	40
4805	2026-05-22 02:00:00	22	38.28
4812	2026-05-22 02:00:00	23	264
4828	2026-05-22 02:00:00	24	20
4838	2026-05-22 02:00:00	21	40
4848	2026-05-22 02:00:00	25	20
4853	2026-05-22 03:00:00	13	261
4861	2026-05-22 03:00:00	14	15
4874	2026-05-22 03:00:00	11	40
4883	2026-05-22 03:00:00	15	15
4894	2026-05-22 03:00:00	12	54.2
4907	2026-05-22 04:00:00	36	40
4915	2026-05-22 04:00:00	38	264
4926	2026-05-22 04:00:00	40	20
4937	2026-05-22 04:00:00	37	38.48
4946	2026-05-22 04:00:00	39	20
4954	2026-05-22 05:00:00	21	40
4968	2026-05-22 05:00:00	25	20
4977	2026-05-22 05:00:00	22	38.34
4991	2026-05-22 05:00:00	23	264
4998	2026-05-22 05:00:00	24	20
5006	2026-05-22 06:00:00	21	40
5020	2026-05-22 06:00:00	24	20
5025	2026-05-22 06:00:00	25	20
5038	2026-05-22 06:00:00	22	38.25
5049	2026-05-22 06:00:00	23	264
5052	2026-05-22 07:00:00	9	20
5070	2026-05-22 07:00:00	7	24.31
5081	2026-05-22 07:00:00	8	171.6
5090	2026-05-22 07:00:00	6	12
5094	2026-05-22 07:00:00	10	20
5107	2026-05-22 08:00:00	32	38.35
5113	2026-05-22 08:00:00	34	20
5122	2026-05-22 08:00:00	35	20
5128	2026-05-22 08:00:00	31	40
5136	2026-05-22 08:00:00	33	264
5160	2026-05-22 09:00:00	50	20
5170	2026-05-22 09:00:00	49	20
5181	2026-05-22 09:00:00	47	38.27
5192	2026-05-22 09:00:00	48	264
5200	2026-05-22 09:00:00	46	40
5204	2026-05-22 10:00:00	8	171.6
5212	2026-05-22 10:00:00	31	40
5214	2026-05-22 10:00:00	6	12
5223	2026-05-22 10:00:00	33	264
5225	2026-05-22 10:00:00	7	24.35
5233	2026-05-22 10:00:00	32	38.2
5234	2026-05-22 10:00:00	10	20
5238	2026-05-22 10:00:00	34	20
5245	2026-05-22 10:00:00	9	20
5257	2026-05-22 11:00:00	26	40
5258	2026-05-22 11:00:00	50	20
5263	2026-05-22 11:00:00	27	38.26
5268	2026-05-22 11:00:00	49	20
5273	2026-05-22 11:00:00	28	264
5277	2026-05-22 11:00:00	47	38.29
5281	2026-05-22 11:00:00	29	20
5285	2026-05-22 11:00:00	48	264
5294	2026-05-22 11:00:00	30	20
5300	2026-05-22 11:00:00	46	40
5301	2026-05-22 12:00:00	2	24.23
5309	2026-05-22 12:00:00	50	20
5312	2026-05-22 12:00:00	5	20
5318	2026-05-22 12:00:00	49	20
5322	2026-05-22 12:00:00	1	12
5323	2026-05-22 12:00:00	47	64.28
5332	2026-05-22 12:00:00	48	435.6
5335	2026-05-22 12:00:00	3	171.6
5344	2026-05-22 12:00:00	4	20
5345	2026-05-22 12:00:00	46	92
5355	2026-05-22 13:00:00	25	20
5356	2026-05-22 13:00:00	28	264
5363	2026-05-22 13:00:00	22	38.44
5366	2026-05-22 13:00:00	29	20
5371	2026-05-22 13:00:00	30	20
5373	2026-05-22 13:00:00	23	264
5379	2026-05-22 13:00:00	26	40
5383	2026-05-22 13:00:00	21	40
5384	2026-05-22 13:00:00	27	38.34
5393	2026-05-22 13:00:00	24	20
5409	2026-05-22 14:00:00	33	264
5410	2026-05-22 14:00:00	49	20
5419	2026-05-22 14:00:00	32	38.37
5420	2026-05-22 14:00:00	46	40
5424	2026-05-22 14:00:00	34	20
5430	2026-05-22 14:00:00	50	20
5433	2026-05-22 14:00:00	35	20
5440	2026-05-22 14:00:00	47	38.44
5444	2026-05-22 14:00:00	31	40
5449	2026-05-22 14:00:00	48	264
5456	2026-05-22 15:00:00	25	20
5458	2026-05-22 15:00:00	40	20
4354	2026-05-21 16:00:00	30	20
4357	2026-05-21 16:00:00	26	40
4367	2026-05-21 16:00:00	27	38.46
4374	2026-05-21 16:00:00	28	264
4386	2026-05-21 16:00:00	29	20
4409	2026-05-21 17:00:00	38	264
4420	2026-05-21 17:00:00	40	20
4431	2026-05-21 17:00:00	37	38.29
4441	2026-05-21 17:00:00	39	20
4446	2026-05-21 17:00:00	36	40
4453	2026-05-21 18:00:00	21	40
4461	2026-05-21 18:00:00	25	20
4472	2026-05-21 18:00:00	22	38.44
4484	2026-05-21 18:00:00	23	264
4494	2026-05-21 18:00:00	24	20
4502	2026-05-21 19:00:00	26	40
4511	2026-05-21 19:00:00	27	38.33
4524	2026-05-21 19:00:00	28	264
4536	2026-05-21 19:00:00	29	20
4543	2026-05-21 19:00:00	30	20
4559	2026-05-21 20:00:00	35	20
4566	2026-05-21 20:00:00	31	40
4579	2026-05-21 20:00:00	33	264
4590	2026-05-21 20:00:00	32	38.2
4600	2026-05-21 20:00:00	34	20
4601	2026-05-21 21:00:00	2	24.23
4612	2026-05-21 21:00:00	5	20
4622	2026-05-21 21:00:00	3	171.6
4632	2026-05-21 21:00:00	4	20
4642	2026-05-21 21:00:00	1	12
4660	2026-05-21 22:00:00	41	40
4669	2026-05-21 22:00:00	43	264
4678	2026-05-21 22:00:00	45	20
4687	2026-05-21 22:00:00	42	38.41
4693	2026-05-21 22:00:00	44	20
4703	2026-05-21 23:00:00	21	40
4715	2026-05-21 23:00:00	25	20
4726	2026-05-21 23:00:00	22	38.44
4735	2026-05-21 23:00:00	23	264
4744	2026-05-21 23:00:00	24	20
4759	2026-05-22 01:00:00	37	38.21
4762	2026-05-22 01:00:00	39	20
4772	2026-05-22 01:00:00	36	40
4783	2026-05-22 01:00:00	38	264
4788	2026-05-22 01:00:00	40	20
4810	2026-05-22 02:00:00	50	20
4819	2026-05-22 02:00:00	49	20
4829	2026-05-22 02:00:00	47	38.28
4836	2026-05-22 02:00:00	48	264
4845	2026-05-22 02:00:00	46	40
4854	2026-05-22 03:00:00	22	38.47
4862	2026-05-22 03:00:00	23	264
4871	2026-05-22 03:00:00	24	20
4884	2026-05-22 03:00:00	21	40
4895	2026-05-22 03:00:00	25	20
4904	2026-05-22 04:00:00	21	40
4913	2026-05-22 04:00:00	25	20
4921	2026-05-22 04:00:00	22	38.34
4931	2026-05-22 04:00:00	23	264
4943	2026-05-22 04:00:00	24	20
4957	2026-05-22 05:00:00	26	40
4961	2026-05-22 05:00:00	27	38.23
4971	2026-05-22 05:00:00	28	264
4981	2026-05-22 05:00:00	29	20
4986	2026-05-22 05:00:00	30	20
5009	2026-05-22 06:00:00	41	40
5015	2026-05-22 06:00:00	43	264
5029	2026-05-22 06:00:00	45	20
5035	2026-05-22 06:00:00	42	38.23
5046	2026-05-22 06:00:00	44	20
5055	2026-05-22 07:00:00	26	40
5063	2026-05-22 07:00:00	27	38.42
5073	2026-05-22 07:00:00	28	264
5085	2026-05-22 07:00:00	29	20
5092	2026-05-22 07:00:00	30	20
5108	2026-05-22 08:00:00	37	38.36
5112	2026-05-22 08:00:00	39	20
5121	2026-05-22 08:00:00	36	40
5127	2026-05-22 08:00:00	38	264
5138	2026-05-22 08:00:00	40	20
5155	2026-05-22 09:00:00	38	264
5165	2026-05-22 09:00:00	40	20
5175	2026-05-22 09:00:00	37	38.41
5185	2026-05-22 09:00:00	39	20
5195	2026-05-22 09:00:00	36	40
5202	2026-05-22 10:00:00	22	38.27
5217	2026-05-22 10:00:00	23	264
5228	2026-05-22 10:00:00	21	40
5237	2026-05-22 10:00:00	24	20
5244	2026-05-22 10:00:00	25	20
5256	2026-05-22 11:00:00	33	264
5264	2026-05-22 11:00:00	32	38.24
5274	2026-05-22 11:00:00	34	20
5286	2026-05-22 11:00:00	35	20
5295	2026-05-22 11:00:00	31	40
5306	2026-05-22 12:00:00	30	20
5313	2026-05-22 12:00:00	26	92
5326	2026-05-22 12:00:00	27	64.28
5337	2026-05-22 12:00:00	28	435.6
5342	2026-05-22 12:00:00	29	20
5357	2026-05-22 13:00:00	40	20
5365	2026-05-22 13:00:00	37	38.23
5372	2026-05-22 13:00:00	39	20
5380	2026-05-22 13:00:00	36	40
5385	2026-05-22 13:00:00	38	264
5408	2026-05-22 14:00:00	43	264
5417	2026-05-22 14:00:00	45	20
5429	2026-05-22 14:00:00	42	38.36
5437	2026-05-22 14:00:00	44	20
5448	2026-05-22 14:00:00	41	40
5452	2026-05-22 15:00:00	10	20
5462	2026-05-22 15:00:00	22	38.24
5465	2026-05-22 15:00:00	9	20
5470	2026-05-22 15:00:00	23	264
5477	2026-05-22 15:00:00	8	171.6
5478	2026-05-22 15:00:00	21	40
5487	2026-05-22 15:00:00	7	24.32
5488	2026-05-22 15:00:00	24	20
5496	2026-05-22 15:00:00	6	12
5506	2026-05-22 16:00:00	22	38.41
5507	2026-05-22 16:00:00	46	40
5512	2026-05-22 16:00:00	50	20
5520	2026-05-22 16:00:00	23	264
5523	2026-05-22 16:00:00	47	38.47
5530	2026-05-22 16:00:00	21	40
5536	2026-05-22 16:00:00	48	264
5541	2026-05-22 16:00:00	24	20
5547	2026-05-22 16:00:00	49	20
5550	2026-05-22 16:00:00	25	20
5551	2026-05-22 17:00:00	5	20
5555	2026-05-22 17:00:00	16	40
5561	2026-05-22 17:00:00	1	12
5567	2026-05-22 17:00:00	19	20
5572	2026-05-22 17:00:00	3	171.6
5578	2026-05-22 17:00:00	18	264
5582	2026-05-22 17:00:00	4	20
4355	2026-05-21 16:00:00	4	20
4365	2026-05-21 16:00:00	1	12
4376	2026-05-21 16:00:00	5	20
4387	2026-05-21 16:00:00	3	171.6
4407	2026-05-21 17:00:00	34	20
4417	2026-05-21 17:00:00	35	20
4428	2026-05-21 17:00:00	31	40
4438	2026-05-21 17:00:00	33	264
4449	2026-05-21 17:00:00	32	38.45
4452	2026-05-21 18:00:00	10	20
4463	2026-05-21 18:00:00	9	20
4476	2026-05-21 18:00:00	7	24.47
4485	2026-05-21 18:00:00	8	171.6
4496	2026-05-21 18:00:00	6	12
4503	2026-05-21 19:00:00	13	261
4520	2026-05-21 19:00:00	14	15
4528	2026-05-21 19:00:00	12	54.31
4539	2026-05-21 19:00:00	15	15
4549	2026-05-21 19:00:00	11	40
4553	2026-05-21 20:00:00	12	54.1
4564	2026-05-21 20:00:00	15	15
4572	2026-05-21 20:00:00	11	40
4583	2026-05-21 20:00:00	13	261
4593	2026-05-21 20:00:00	14	15
4609	2026-05-21 21:00:00	37	38.21
4618	2026-05-21 21:00:00	39	20
4626	2026-05-21 21:00:00	36	40
4637	2026-05-21 21:00:00	38	264
4644	2026-05-21 21:00:00	40	20
4654	2026-05-21 22:00:00	35	20
4668	2026-05-21 22:00:00	31	40
4676	2026-05-21 22:00:00	33	264
4689	2026-05-21 22:00:00	32	38.4
4697	2026-05-21 22:00:00	34	20
4704	2026-05-21 23:00:00	10	20
4714	2026-05-21 23:00:00	6	12
4724	2026-05-21 23:00:00	9	20
4734	2026-05-21 23:00:00	7	24.44
4745	2026-05-21 23:00:00	8	171.6
4757	2026-05-22 01:00:00	29	20
4770	2026-05-22 01:00:00	30	20
4781	2026-05-22 01:00:00	26	40
4786	2026-05-22 01:00:00	27	38.32
4794	2026-05-22 01:00:00	28	264
4808	2026-05-22 02:00:00	36	40
4815	2026-05-22 02:00:00	38	264
4821	2026-05-22 02:00:00	40	20
4834	2026-05-22 02:00:00	37	38.45
4844	2026-05-22 02:00:00	39	20
4857	2026-05-22 03:00:00	36	40
4868	2026-05-22 03:00:00	38	264
4879	2026-05-22 03:00:00	40	20
4890	2026-05-22 03:00:00	37	38.33
4900	2026-05-22 03:00:00	39	20
4902	2026-05-22 04:00:00	9	20
4912	2026-05-22 04:00:00	7	24.42
4925	2026-05-22 04:00:00	8	171.6
4935	2026-05-22 04:00:00	10	20
4947	2026-05-22 04:00:00	6	12
4953	2026-05-22 05:00:00	13	261
4967	2026-05-22 05:00:00	14	15
4974	2026-05-22 05:00:00	11	40
4980	2026-05-22 05:00:00	15	15
4985	2026-05-22 05:00:00	12	54.36
5010	2026-05-22 06:00:00	50	20
5018	2026-05-22 06:00:00	49	20
5024	2026-05-22 06:00:00	47	38.45
5032	2026-05-22 06:00:00	48	264
5040	2026-05-22 06:00:00	46	40
5059	2026-05-22 07:00:00	50	20
5062	2026-05-22 07:00:00	49	20
5071	2026-05-22 07:00:00	47	38.42
5077	2026-05-22 07:00:00	48	264
5082	2026-05-22 07:00:00	46	40
5110	2026-05-22 08:00:00	50	20
5123	2026-05-22 08:00:00	49	20
5134	2026-05-22 08:00:00	47	38.45
5146	2026-05-22 08:00:00	48	264
5150	2026-05-22 08:00:00	46	40
5152	2026-05-22 09:00:00	2	24.22
5162	2026-05-22 09:00:00	5	20
5169	2026-05-22 09:00:00	1	12
5179	2026-05-22 09:00:00	3	171.6
5190	2026-05-22 09:00:00	4	20
5209	2026-05-22 10:00:00	50	20
5218	2026-05-22 10:00:00	49	20
5227	2026-05-22 10:00:00	47	38.47
5243	2026-05-22 10:00:00	48	264
5248	2026-05-22 10:00:00	46	40
5253	2026-05-22 11:00:00	21	40
5262	2026-05-22 11:00:00	24	20
5271	2026-05-22 11:00:00	25	20
5282	2026-05-22 11:00:00	22	38.28
5290	2026-05-22 11:00:00	23	264
5310	2026-05-22 12:00:00	45	20
5319	2026-05-22 12:00:00	42	64.36
5324	2026-05-22 12:00:00	44	20
5333	2026-05-22 12:00:00	41	92
5343	2026-05-22 12:00:00	43	435.6
5359	2026-05-22 13:00:00	43	264
5368	2026-05-22 13:00:00	45	20
5377	2026-05-22 13:00:00	42	38.22
5389	2026-05-22 13:00:00	44	20
5394	2026-05-22 13:00:00	41	40
5407	2026-05-22 14:00:00	40	20
5412	2026-05-22 14:00:00	37	38.4
5422	2026-05-22 14:00:00	39	20
5432	2026-05-22 14:00:00	36	40
5442	2026-05-22 14:00:00	38	264
5455	2026-05-22 15:00:00	33	264
5461	2026-05-22 15:00:00	32	38.37
5463	2026-05-22 15:00:00	37	38.29
5469	2026-05-22 15:00:00	34	20
5474	2026-05-22 15:00:00	39	20
5476	2026-05-22 15:00:00	35	20
5484	2026-05-22 15:00:00	36	40
5486	2026-05-22 15:00:00	31	40
5493	2026-05-22 15:00:00	38	264
5505	2026-05-22 16:00:00	30	20
5510	2026-05-22 16:00:00	45	20
5516	2026-05-22 16:00:00	42	38.21
5519	2026-05-22 16:00:00	26	40
5524	2026-05-22 16:00:00	44	20
5529	2026-05-22 16:00:00	27	38.31
5532	2026-05-22 16:00:00	41	40
5534	2026-05-22 16:00:00	28	264
5542	2026-05-22 16:00:00	43	264
5543	2026-05-22 16:00:00	29	20
5558	2026-05-22 17:00:00	38	264
5560	2026-05-22 17:00:00	41	40
5569	2026-05-22 17:00:00	40	20
5575	2026-05-22 17:00:00	43	264
5579	2026-05-22 17:00:00	37	38.4
5586	2026-05-22 17:00:00	45	20
5588	2026-05-22 17:00:00	39	20
5597	2026-05-22 17:00:00	42	38.25
4356	2026-05-21 16:00:00	10	20
4366	2026-05-21 16:00:00	9	20
4378	2026-05-21 16:00:00	7	24.37
4390	2026-05-21 16:00:00	8	171.6
4408	2026-05-21 17:00:00	30	20
4411	2026-05-21 17:00:00	26	40
4421	2026-05-21 17:00:00	27	38.47
4426	2026-05-21 17:00:00	28	264
4436	2026-05-21 17:00:00	29	20
4459	2026-05-21 18:00:00	47	38.22
4470	2026-05-21 18:00:00	48	264
4482	2026-05-21 18:00:00	46	40
4491	2026-05-21 18:00:00	50	20
4500	2026-05-21 18:00:00	49	20
4504	2026-05-21 19:00:00	7	24.31
4517	2026-05-21 19:00:00	8	171.6
4526	2026-05-21 19:00:00	6	12
4537	2026-05-21 19:00:00	10	20
4544	2026-05-21 19:00:00	9	20
4554	2026-05-21 20:00:00	19	20
4569	2026-05-21 20:00:00	18	264
4576	2026-05-21 20:00:00	20	20
4588	2026-05-21 20:00:00	17	38.22
4599	2026-05-21 20:00:00	16	40
4602	2026-05-21 21:00:00	10	20
4614	2026-05-21 21:00:00	8	171.6
4624	2026-05-21 21:00:00	6	12
4635	2026-05-21 21:00:00	9	20
4648	2026-05-21 21:00:00	7	24.34
4653	2026-05-21 22:00:00	10	20
4665	2026-05-21 22:00:00	6	12
4673	2026-05-21 22:00:00	9	20
4685	2026-05-21 22:00:00	7	24.46
4695	2026-05-21 22:00:00	8	171.6
4702	2026-05-21 23:00:00	14	15
4717	2026-05-21 23:00:00	11	40
4727	2026-05-21 23:00:00	15	15
4736	2026-05-21 23:00:00	12	54.22
4747	2026-05-21 23:00:00	13	261
4753	2026-05-22 01:00:00	22	38.48
4768	2026-05-22 01:00:00	23	264
4773	2026-05-22 01:00:00	24	20
4782	2026-05-22 01:00:00	21	40
4796	2026-05-22 01:00:00	25	20
4807	2026-05-22 02:00:00	29	20
4817	2026-05-22 02:00:00	30	20
4826	2026-05-22 02:00:00	26	40
4840	2026-05-22 02:00:00	27	38.21
4849	2026-05-22 02:00:00	28	264
4851	2026-05-22 03:00:00	8	171.6
4863	2026-05-22 03:00:00	10	20
4875	2026-05-22 03:00:00	6	12
4886	2026-05-22 03:00:00	9	20
4897	2026-05-22 03:00:00	7	24.4
4906	2026-05-22 04:00:00	29	20
4916	2026-05-22 04:00:00	30	20
4924	2026-05-22 04:00:00	26	40
4933	2026-05-22 04:00:00	27	38.44
4942	2026-05-22 04:00:00	28	264
4956	2026-05-22 05:00:00	35	20
4966	2026-05-22 05:00:00	31	40
4978	2026-05-22 05:00:00	33	264
4993	2026-05-22 05:00:00	32	38.3
5000	2026-05-22 05:00:00	34	20
5002	2026-05-22 06:00:00	6	12
5013	2026-05-22 06:00:00	10	20
5022	2026-05-22 06:00:00	9	20
5033	2026-05-22 06:00:00	7	24.46
5043	2026-05-22 06:00:00	8	171.6
5058	2026-05-22 07:00:00	37	38.2
5067	2026-05-22 07:00:00	39	20
5078	2026-05-22 07:00:00	36	40
5086	2026-05-22 07:00:00	38	264
5098	2026-05-22 07:00:00	40	20
5104	2026-05-22 08:00:00	28	264
5117	2026-05-22 08:00:00	29	20
5125	2026-05-22 08:00:00	30	20
5133	2026-05-22 08:00:00	26	40
5140	2026-05-22 08:00:00	27	38.32
5158	2026-05-22 09:00:00	31	40
5167	2026-05-22 09:00:00	33	264
5177	2026-05-22 09:00:00	32	38.23
5187	2026-05-22 09:00:00	34	20
5197	2026-05-22 09:00:00	35	20
5203	2026-05-22 10:00:00	13	261
5220	2026-05-22 10:00:00	14	15
5230	2026-05-22 10:00:00	11	40
5242	2026-05-22 10:00:00	15	15
5250	2026-05-22 10:00:00	12	54.28
5251	2026-05-22 11:00:00	1	12
5261	2026-05-22 11:00:00	3	171.6
5270	2026-05-22 11:00:00	4	20
5280	2026-05-22 11:00:00	2	24.3
5293	2026-05-22 11:00:00	5	20
5308	2026-05-22 12:00:00	36	92
5320	2026-05-22 12:00:00	38	435.6
5330	2026-05-22 12:00:00	40	20
5340	2026-05-22 12:00:00	37	64.47
5349	2026-05-22 12:00:00	39	20
5352	2026-05-22 13:00:00	10	20
5361	2026-05-22 13:00:00	9	20
5374	2026-05-22 13:00:00	8	171.6
5386	2026-05-22 13:00:00	7	24.44
5396	2026-05-22 13:00:00	6	12
5405	2026-05-22 14:00:00	25	20
5418	2026-05-22 14:00:00	22	38.33
5428	2026-05-22 14:00:00	23	264
5438	2026-05-22 14:00:00	21	40
5447	2026-05-22 14:00:00	24	20
5454	2026-05-22 15:00:00	19	20
5467	2026-05-22 15:00:00	18	264
5479	2026-05-22 15:00:00	17	38.47
5490	2026-05-22 15:00:00	20	20
5498	2026-05-22 15:00:00	16	40
5503	2026-05-22 16:00:00	8	171.6
5515	2026-05-22 16:00:00	7	24.23
5522	2026-05-22 16:00:00	6	12
5537	2026-05-22 16:00:00	10	20
5546	2026-05-22 16:00:00	9	20
5557	2026-05-22 17:00:00	32	38.4
5568	2026-05-22 17:00:00	34	20
5576	2026-05-22 17:00:00	35	20
5585	2026-05-22 17:00:00	31	40
5589	2026-05-22 17:00:00	17	38.21
5595	2026-05-22 17:00:00	33	264
5599	2026-05-22 17:00:00	20	20
5603	2026-05-22 18:00:00	14	15
5606	2026-05-22 18:00:00	24	20
5614	2026-05-22 18:00:00	11	40
5618	2026-05-22 18:00:00	25	20
5627	2026-05-22 18:00:00	15	15
5628	2026-05-22 18:00:00	22	38.22
5637	2026-05-22 18:00:00	12	54.08
5638	2026-05-22 18:00:00	23	264
5647	2026-05-22 18:00:00	21	40
5649	2026-05-22 18:00:00	13	261
4358	2026-05-21 16:00:00	40	20
4370	2026-05-21 16:00:00	37	38.45
4380	2026-05-21 16:00:00	39	20
4391	2026-05-21 16:00:00	36	40
4397	2026-05-21 16:00:00	38	264
4404	2026-05-21 17:00:00	19	20
4414	2026-05-21 17:00:00	18	264
4424	2026-05-21 17:00:00	20	20
4434	2026-05-21 17:00:00	17	38.19
4445	2026-05-21 17:00:00	16	40
4454	2026-05-21 18:00:00	30	20
4466	2026-05-21 18:00:00	26	40
4477	2026-05-21 18:00:00	27	38.23
4490	2026-05-21 18:00:00	28	264
4498	2026-05-21 18:00:00	29	20
4501	2026-05-21 19:00:00	1	12
4512	2026-05-21 19:00:00	5	20
4521	2026-05-21 19:00:00	3	171.6
4532	2026-05-21 19:00:00	2	24.47
4545	2026-05-21 19:00:00	4	20
4558	2026-05-21 20:00:00	36	40
4570	2026-05-21 20:00:00	38	264
4580	2026-05-21 20:00:00	40	20
4589	2026-05-21 20:00:00	37	38.3
4598	2026-05-21 20:00:00	39	20
4606	2026-05-21 21:00:00	21	40
4615	2026-05-21 21:00:00	25	20
4623	2026-05-21 21:00:00	22	38.22
4633	2026-05-21 21:00:00	23	264
4641	2026-05-21 21:00:00	24	20
4658	2026-05-21 22:00:00	37	38.2
4663	2026-05-21 22:00:00	39	20
4672	2026-05-21 22:00:00	36	40
4677	2026-05-21 22:00:00	38	264
4683	2026-05-21 22:00:00	40	20
4706	2026-05-21 23:00:00	19	20
4705	2026-05-21 23:00:00	41	40
4712	2026-05-21 23:00:00	43	264
4713	2026-05-21 23:00:00	18	264
4722	2026-05-21 23:00:00	45	20
4723	2026-05-21 23:00:00	17	38.48
4732	2026-05-21 23:00:00	16	40
4733	2026-05-21 23:00:00	42	38.44
4742	2026-05-21 23:00:00	20	20
4743	2026-05-21 23:00:00	44	20
4756	2026-05-22 01:00:00	35	20
4758	2026-05-22 01:00:00	41	40
4764	2026-05-22 01:00:00	31	40
4769	2026-05-22 01:00:00	43	264
4775	2026-05-22 01:00:00	33	264
4779	2026-05-22 01:00:00	45	20
4784	2026-05-22 01:00:00	32	38.33
4789	2026-05-22 01:00:00	34	20
4792	2026-05-22 01:00:00	42	38.45
4800	2026-05-22 01:00:00	44	20
4801	2026-05-22 02:00:00	2	24.28
4809	2026-05-22 02:00:00	41	40
4813	2026-05-22 02:00:00	43	264
4814	2026-05-22 02:00:00	5	20
4820	2026-05-22 02:00:00	1	12
4824	2026-05-22 02:00:00	45	20
4830	2026-05-22 02:00:00	3	171.6
4833	2026-05-22 02:00:00	42	38.46
4839	2026-05-22 02:00:00	4	20
4842	2026-05-22 02:00:00	44	20
4856	2026-05-22 03:00:00	35	20
4859	2026-05-22 03:00:00	50	20
4869	2026-05-22 03:00:00	31	40
4870	2026-05-22 03:00:00	49	20
4878	2026-05-22 03:00:00	33	264
4880	2026-05-22 03:00:00	47	38.22
4887	2026-05-22 03:00:00	32	38.46
4889	2026-05-22 03:00:00	48	264
4898	2026-05-22 03:00:00	34	20
4899	2026-05-22 03:00:00	46	40
4903	2026-05-22 04:00:00	13	261
4905	2026-05-22 04:00:00	18	264
4911	2026-05-22 04:00:00	14	15
4914	2026-05-22 04:00:00	17	38.37
4920	2026-05-22 04:00:00	11	40
4923	2026-05-22 04:00:00	16	40
4929	2026-05-22 04:00:00	15	15
4934	2026-05-22 04:00:00	20	20
4939	2026-05-22 04:00:00	12	54.17
4944	2026-05-22 04:00:00	19	20
4955	2026-05-22 05:00:00	36	40
4958	2026-05-22 05:00:00	50	20
4965	2026-05-22 05:00:00	49	20
4969	2026-05-22 05:00:00	38	264
4975	2026-05-22 05:00:00	47	38.31
4982	2026-05-22 05:00:00	40	20
4987	2026-05-22 05:00:00	37	38.31
4990	2026-05-22 05:00:00	48	264
4995	2026-05-22 05:00:00	39	20
4997	2026-05-22 05:00:00	46	40
5003	2026-05-22 06:00:00	13	261
5005	2026-05-22 06:00:00	26	40
5017	2026-05-22 06:00:00	27	38.36
5019	2026-05-22 06:00:00	14	15
5027	2026-05-22 06:00:00	28	264
5028	2026-05-22 06:00:00	11	40
5036	2026-05-22 06:00:00	15	15
5042	2026-05-22 06:00:00	29	20
5047	2026-05-22 06:00:00	12	54.12
5050	2026-05-22 06:00:00	30	20
5051	2026-05-22 07:00:00	2	24.33
5054	2026-05-22 07:00:00	16	40
5061	2026-05-22 07:00:00	5	20
5068	2026-05-22 07:00:00	18	264
5072	2026-05-22 07:00:00	3	171.6
5076	2026-05-22 07:00:00	17	38.38
5083	2026-05-22 07:00:00	1	12
5087	2026-05-22 07:00:00	20	20
5093	2026-05-22 07:00:00	4	20
5099	2026-05-22 07:00:00	19	20
5106	2026-05-22 08:00:00	17	38.21
5109	2026-05-22 08:00:00	41	40
5116	2026-05-22 08:00:00	20	20
5119	2026-05-22 08:00:00	43	264
5124	2026-05-22 08:00:00	16	40
5131	2026-05-22 08:00:00	45	20
5135	2026-05-22 08:00:00	19	20
5143	2026-05-22 08:00:00	42	38.46
5145	2026-05-22 08:00:00	18	264
5149	2026-05-22 08:00:00	44	20
5151	2026-05-22 09:00:00	6	12
5156	2026-05-22 09:00:00	23	264
5161	2026-05-22 09:00:00	7	24.2
5166	2026-05-22 09:00:00	21	40
5172	2026-05-22 09:00:00	10	20
5176	2026-05-22 09:00:00	24	20
5182	2026-05-22 09:00:00	9	20
5186	2026-05-22 09:00:00	25	20
5191	2026-05-22 09:00:00	8	171.6
5196	2026-05-22 09:00:00	22	38.22
5207	2026-05-22 10:00:00	35	20
4359	2026-05-21 16:00:00	46	40
4371	2026-05-21 16:00:00	50	20
4381	2026-05-21 16:00:00	49	20
4384	2026-05-21 16:00:00	47	38.42
4392	2026-05-21 16:00:00	48	264
4410	2026-05-21 17:00:00	47	38.27
4418	2026-05-21 17:00:00	48	264
4429	2026-05-21 17:00:00	46	40
4440	2026-05-21 17:00:00	50	20
4448	2026-05-21 17:00:00	49	20
4455	2026-05-21 18:00:00	11	40
4467	2026-05-21 18:00:00	13	261
4479	2026-05-21 18:00:00	14	15
4492	2026-05-21 18:00:00	12	54.14
4499	2026-05-21 18:00:00	15	15
4505	2026-05-21 19:00:00	22	38.37
4516	2026-05-21 19:00:00	23	264
4525	2026-05-21 19:00:00	24	20
4534	2026-05-21 19:00:00	21	40
4548	2026-05-21 19:00:00	25	20
4552	2026-05-21 20:00:00	10	20
4561	2026-05-21 20:00:00	9	20
4574	2026-05-21 20:00:00	7	24.38
4582	2026-05-21 20:00:00	8	171.6
4592	2026-05-21 20:00:00	6	12
4608	2026-05-21 21:00:00	45	20
4617	2026-05-21 21:00:00	42	38.39
4628	2026-05-21 21:00:00	41	40
4638	2026-05-21 21:00:00	43	264
4647	2026-05-21 21:00:00	44	20
4656	2026-05-21 22:00:00	19	20
4670	2026-05-21 22:00:00	18	264
4679	2026-05-21 22:00:00	17	38.24
4686	2026-05-21 22:00:00	16	40
4694	2026-05-21 22:00:00	20	20
4707	2026-05-21 23:00:00	29	20
4716	2026-05-21 23:00:00	30	20
4728	2026-05-21 23:00:00	26	40
4737	2026-05-21 23:00:00	27	38.48
4746	2026-05-21 23:00:00	28	264
4752	2026-05-22 01:00:00	10	20
4765	2026-05-22 01:00:00	6	12
4776	2026-05-22 01:00:00	9	20
4785	2026-05-22 01:00:00	7	24.43
4793	2026-05-22 01:00:00	8	171.6
4806	2026-05-22 02:00:00	35	20
4818	2026-05-22 02:00:00	31	40
4825	2026-05-22 02:00:00	33	264
4835	2026-05-22 02:00:00	32	38.44
4847	2026-05-22 02:00:00	34	20
4855	2026-05-22 03:00:00	17	38.47
4865	2026-05-22 03:00:00	16	40
4872	2026-05-22 03:00:00	20	20
4881	2026-05-22 03:00:00	19	20
4892	2026-05-22 03:00:00	18	264
4919	2026-05-22 04:00:00	41	40
4930	2026-05-22 04:00:00	43	264
4940	2026-05-22 04:00:00	45	20
4949	2026-05-22 04:00:00	42	38.26
4950	2026-05-22 04:00:00	44	20
4951	2026-05-22 05:00:00	1	12
4963	2026-05-22 05:00:00	3	171.6
4973	2026-05-22 05:00:00	4	20
4983	2026-05-22 05:00:00	2	24.33
4988	2026-05-22 05:00:00	5	20
5008	2026-05-22 06:00:00	37	38.47
5014	2026-05-22 06:00:00	39	20
5030	2026-05-22 06:00:00	36	40
5039	2026-05-22 06:00:00	38	264
5044	2026-05-22 06:00:00	40	20
5056	2026-05-22 07:00:00	24	20
5066	2026-05-22 07:00:00	22	38.21
5075	2026-05-22 07:00:00	25	20
5088	2026-05-22 07:00:00	23	264
5095	2026-05-22 07:00:00	21	40
5102	2026-05-22 08:00:00	7	24.2
5114	2026-05-22 08:00:00	8	171.6
5129	2026-05-22 08:00:00	6	12
5141	2026-05-22 08:00:00	10	20
5147	2026-05-22 08:00:00	9	20
5154	2026-05-22 09:00:00	16	40
5168	2026-05-22 09:00:00	19	20
5180	2026-05-22 09:00:00	18	264
5189	2026-05-22 09:00:00	17	38.29
5198	2026-05-22 09:00:00	20	20
5205	2026-05-22 10:00:00	20	20
5216	2026-05-22 10:00:00	16	40
5226	2026-05-22 10:00:00	19	20
5236	2026-05-22 10:00:00	18	264
5247	2026-05-22 10:00:00	17	38.41
5252	2026-05-22 11:00:00	19	20
5265	2026-05-22 11:00:00	18	264
5276	2026-05-22 11:00:00	17	38.22
5284	2026-05-22 11:00:00	20	20
5292	2026-05-22 11:00:00	16	40
5307	2026-05-22 12:00:00	35	20
5321	2026-05-22 12:00:00	31	92
5331	2026-05-22 12:00:00	33	435.6
5341	2026-05-22 12:00:00	32	64.36
5350	2026-05-22 12:00:00	34	20
5351	2026-05-22 13:00:00	4	20
5362	2026-05-22 13:00:00	2	24.35
5375	2026-05-22 13:00:00	5	20
5387	2026-05-22 13:00:00	1	12
5395	2026-05-22 13:00:00	3	171.6
5406	2026-05-22 14:00:00	28	264
5411	2026-05-22 14:00:00	29	20
5421	2026-05-22 14:00:00	30	20
5431	2026-05-22 14:00:00	26	40
5441	2026-05-22 14:00:00	27	38.36
5459	2026-05-22 15:00:00	49	20
5472	2026-05-22 15:00:00	46	40
5482	2026-05-22 15:00:00	50	20
5495	2026-05-22 15:00:00	47	38.42
5500	2026-05-22 15:00:00	48	264
5504	2026-05-22 16:00:00	18	264
5511	2026-05-22 16:00:00	17	38.41
5521	2026-05-22 16:00:00	20	20
5533	2026-05-22 16:00:00	16	40
5544	2026-05-22 16:00:00	19	20
5554	2026-05-22 17:00:00	24	20
5564	2026-05-22 17:00:00	25	20
5574	2026-05-22 17:00:00	22	38.31
5584	2026-05-22 17:00:00	23	264
5592	2026-05-22 17:00:00	2	24.28
5593	2026-05-22 17:00:00	21	40
5607	2026-05-22 18:00:00	36	40
5608	2026-05-22 18:00:00	32	38.37
5617	2026-05-22 18:00:00	38	264
5619	2026-05-22 18:00:00	34	20
5622	2026-05-22 18:00:00	40	20
5629	2026-05-22 18:00:00	35	20
5631	2026-05-22 18:00:00	37	38.2
5639	2026-05-22 18:00:00	31	40
5642	2026-05-22 18:00:00	39	20
5648	2026-05-22 18:00:00	33	264
4360	2026-05-21 16:00:00	43	264
4368	2026-05-21 16:00:00	44	20
4377	2026-05-21 16:00:00	45	20
4388	2026-05-21 16:00:00	42	38.37
4396	2026-05-21 16:00:00	41	40
4406	2026-05-21 17:00:00	21	40
4419	2026-05-21 17:00:00	25	20
4432	2026-05-21 17:00:00	22	38.27
4443	2026-05-21 17:00:00	23	264
4450	2026-05-21 17:00:00	24	20
4451	2026-05-21 18:00:00	2	24.48
4462	2026-05-21 18:00:00	4	20
4469	2026-05-21 18:00:00	1	12
4473	2026-05-21 18:00:00	5	20
4480	2026-05-21 18:00:00	3	171.6
4509	2026-05-21 19:00:00	48	264
4518	2026-05-21 19:00:00	46	40
4529	2026-05-21 19:00:00	50	20
4540	2026-05-21 19:00:00	49	20
4550	2026-05-21 19:00:00	47	38.44
4551	2026-05-21 20:00:00	2	24.22
4563	2026-05-21 20:00:00	4	20
4575	2026-05-21 20:00:00	1	12
4585	2026-05-21 20:00:00	5	20
4596	2026-05-21 20:00:00	3	171.6
4603	2026-05-21 21:00:00	12	54.3
4616	2026-05-21 21:00:00	15	15
4627	2026-05-21 21:00:00	13	261
4639	2026-05-21 21:00:00	14	15
4649	2026-05-21 21:00:00	11	40
4651	2026-05-21 22:00:00	12	54.28
4661	2026-05-21 22:00:00	13	261
4675	2026-05-21 22:00:00	14	15
4688	2026-05-21 22:00:00	11	40
4698	2026-05-21 22:00:00	15	15
4708	2026-05-21 23:00:00	37	38.21
4718	2026-05-21 23:00:00	39	20
4725	2026-05-21 23:00:00	36	40
4738	2026-05-21 23:00:00	38	264
4748	2026-05-21 23:00:00	40	20
4754	2026-05-22 01:00:00	14	15
4767	2026-05-22 01:00:00	11	40
4780	2026-05-22 01:00:00	15	15
4790	2026-05-22 01:00:00	12	54.24
4797	2026-05-22 01:00:00	13	261
4804	2026-05-22 02:00:00	19	20
4811	2026-05-22 02:00:00	18	264
4822	2026-05-22 02:00:00	17	38.25
4832	2026-05-22 02:00:00	16	40
4843	2026-05-22 02:00:00	20	20
4858	2026-05-22 03:00:00	41	40
4866	2026-05-22 03:00:00	43	264
4876	2026-05-22 03:00:00	45	20
4888	2026-05-22 03:00:00	42	38.3
4896	2026-05-22 03:00:00	44	20
4901	2026-05-22 04:00:00	1	12
4910	2026-05-22 04:00:00	3	171.6
4922	2026-05-22 04:00:00	4	20
4932	2026-05-22 04:00:00	2	24.2
4941	2026-05-22 04:00:00	5	20
4959	2026-05-22 05:00:00	41	40
4962	2026-05-22 05:00:00	43	264
4972	2026-05-22 05:00:00	45	20
4984	2026-05-22 05:00:00	42	38.44
4994	2026-05-22 05:00:00	44	20
5007	2026-05-22 06:00:00	32	38.32
5016	2026-05-22 06:00:00	34	20
5026	2026-05-22 06:00:00	35	20
5037	2026-05-22 06:00:00	31	40
5048	2026-05-22 06:00:00	33	264
5053	2026-05-22 07:00:00	14	15
5064	2026-05-22 07:00:00	11	40
5074	2026-05-22 07:00:00	15	15
5084	2026-05-22 07:00:00	12	54.27
5096	2026-05-22 07:00:00	13	261
5105	2026-05-22 08:00:00	25	20
5118	2026-05-22 08:00:00	23	264
5132	2026-05-22 08:00:00	21	40
5142	2026-05-22 08:00:00	24	20
5148	2026-05-22 08:00:00	22	38.33
5153	2026-05-22 09:00:00	14	15
5163	2026-05-22 09:00:00	11	40
5173	2026-05-22 09:00:00	15	15
5183	2026-05-22 09:00:00	12	54.31
5194	2026-05-22 09:00:00	13	261
5208	2026-05-22 10:00:00	29	20
5219	2026-05-22 10:00:00	30	20
5229	2026-05-22 10:00:00	26	40
5239	2026-05-22 10:00:00	27	38.45
5249	2026-05-22 10:00:00	28	264
5255	2026-05-22 11:00:00	14	15
5267	2026-05-22 11:00:00	11	40
5278	2026-05-22 11:00:00	15	15
5288	2026-05-22 11:00:00	12	54.24
5296	2026-05-22 11:00:00	13	261
5303	2026-05-22 12:00:00	20	20
5314	2026-05-22 12:00:00	16	92
5328	2026-05-22 12:00:00	19	20
5336	2026-05-22 12:00:00	18	435.6
5346	2026-05-22 12:00:00	17	64.41
5358	2026-05-22 13:00:00	32	38.39
5370	2026-05-22 13:00:00	34	20
5381	2026-05-22 13:00:00	35	20
5392	2026-05-22 13:00:00	31	40
5400	2026-05-22 13:00:00	33	264
5402	2026-05-22 14:00:00	4	20
5413	2026-05-22 14:00:00	2	24.37
5425	2026-05-22 14:00:00	5	20
5435	2026-05-22 14:00:00	1	12
5445	2026-05-22 14:00:00	3	171.6
5453	2026-05-22 15:00:00	14	15
5466	2026-05-22 15:00:00	11	40
5473	2026-05-22 15:00:00	15	15
5483	2026-05-22 15:00:00	12	54.36
5494	2026-05-22 15:00:00	13	261
5509	2026-05-22 16:00:00	35	20
5518	2026-05-22 16:00:00	31	40
5528	2026-05-22 16:00:00	33	264
5540	2026-05-22 16:00:00	32	38.46
5549	2026-05-22 16:00:00	34	20
5552	2026-05-22 17:00:00	14	15
5563	2026-05-22 17:00:00	11	40
5571	2026-05-22 17:00:00	15	15
5583	2026-05-22 17:00:00	12	54.32
5594	2026-05-22 17:00:00	13	261
5598	2026-05-22 17:00:00	36	40
5604	2026-05-22 18:00:00	20	20
5605	2026-05-22 18:00:00	29	20
5611	2026-05-22 18:00:00	16	40
5612	2026-05-22 18:00:00	30	20
5623	2026-05-22 18:00:00	19	20
5624	2026-05-22 18:00:00	26	40
5633	2026-05-22 18:00:00	18	264
5635	2026-05-22 18:00:00	27	38.26
5643	2026-05-22 18:00:00	17	38.42
5645	2026-05-22 18:00:00	28	264
4363	2026-05-21 16:00:00	20	20
4372	2026-05-21 16:00:00	17	38.38
4382	2026-05-21 16:00:00	16	40
4394	2026-05-21 16:00:00	19	20
4399	2026-05-21 16:00:00	18	264
4403	2026-05-21 17:00:00	11	40
4412	2026-05-21 17:00:00	13	261
4422	2026-05-21 17:00:00	14	15
4430	2026-05-21 17:00:00	12	54.19
4439	2026-05-21 17:00:00	15	15
4460	2026-05-21 18:00:00	41	40
4471	2026-05-21 18:00:00	43	264
4483	2026-05-21 18:00:00	44	20
4488	2026-05-21 18:00:00	45	20
4495	2026-05-21 18:00:00	42	38.42
4508	2026-05-21 19:00:00	35	20
4514	2026-05-21 19:00:00	31	40
4523	2026-05-21 19:00:00	33	264
4531	2026-05-21 19:00:00	32	38.31
4541	2026-05-21 19:00:00	34	20
4560	2026-05-21 20:00:00	50	20
4568	2026-05-21 20:00:00	49	20
4577	2026-05-21 20:00:00	47	38.26
4586	2026-05-21 20:00:00	48	264
4594	2026-05-21 20:00:00	46	40
4605	2026-05-21 21:00:00	29	20
4611	2026-05-21 21:00:00	30	20
4621	2026-05-21 21:00:00	26	40
4629	2026-05-21 21:00:00	27	38.35
4634	2026-05-21 21:00:00	28	264
4659	2026-05-21 22:00:00	50	20
4662	2026-05-21 22:00:00	49	20
4671	2026-05-21 22:00:00	47	38.22
4681	2026-05-21 22:00:00	48	264
4691	2026-05-21 22:00:00	46	40
4709	2026-05-21 23:00:00	35	20
4719	2026-05-21 23:00:00	31	40
4729	2026-05-21 23:00:00	33	264
4739	2026-05-21 23:00:00	32	38.33
4749	2026-05-21 23:00:00	34	20
4755	2026-05-22 01:00:00	19	20
4763	2026-05-22 01:00:00	18	264
4774	2026-05-22 01:00:00	17	38.38
4787	2026-05-22 01:00:00	16	40
4798	2026-05-22 01:00:00	20	20
4803	2026-05-22 02:00:00	11	40
4816	2026-05-22 02:00:00	15	15
4827	2026-05-22 02:00:00	12	54.14
4837	2026-05-22 02:00:00	13	261
4846	2026-05-22 02:00:00	14	15
4860	2026-05-22 03:00:00	29	20
4867	2026-05-22 03:00:00	30	20
4877	2026-05-22 03:00:00	26	40
4885	2026-05-22 03:00:00	27	38.27
4893	2026-05-22 03:00:00	28	264
4909	2026-05-22 04:00:00	35	20
4917	2026-05-22 04:00:00	31	40
4928	2026-05-22 04:00:00	33	264
4938	2026-05-22 04:00:00	32	38.26
4948	2026-05-22 04:00:00	34	20
4952	2026-05-22 05:00:00	6	12
4964	2026-05-22 05:00:00	9	20
4976	2026-05-22 05:00:00	7	24.49
4992	2026-05-22 05:00:00	8	171.6
4999	2026-05-22 05:00:00	10	20
5001	2026-05-22 06:00:00	3	171.6
5012	2026-05-22 06:00:00	4	20
5023	2026-05-22 06:00:00	2	24.25
5034	2026-05-22 06:00:00	5	20
5045	2026-05-22 06:00:00	1	12
5057	2026-05-22 07:00:00	32	38.46
5069	2026-05-22 07:00:00	34	20
5080	2026-05-22 07:00:00	35	20
5091	2026-05-22 07:00:00	31	40
5100	2026-05-22 07:00:00	33	264
5101	2026-05-22 08:00:00	1	12
5115	2026-05-22 08:00:00	4	20
5130	2026-05-22 08:00:00	2	24.22
5137	2026-05-22 08:00:00	5	20
5144	2026-05-22 08:00:00	3	171.6
5157	2026-05-22 09:00:00	30	20
5164	2026-05-22 09:00:00	26	40
5174	2026-05-22 09:00:00	27	38.34
5184	2026-05-22 09:00:00	28	264
5193	2026-05-22 09:00:00	29	20
5206	2026-05-22 10:00:00	41	40
5213	2026-05-22 10:00:00	43	264
5222	2026-05-22 10:00:00	45	20
5232	2026-05-22 10:00:00	42	38.27
5241	2026-05-22 10:00:00	44	20
5259	2026-05-22 11:00:00	37	38.34
5269	2026-05-22 11:00:00	39	20
5279	2026-05-22 11:00:00	36	40
5289	2026-05-22 11:00:00	38	264
5297	2026-05-22 11:00:00	40	20
5305	2026-05-22 12:00:00	22	64.49
5311	2026-05-22 12:00:00	23	435.6
5317	2026-05-22 12:00:00	21	92
5325	2026-05-22 12:00:00	24	20
5334	2026-05-22 12:00:00	25	20
5360	2026-05-22 13:00:00	46	40
5364	2026-05-22 13:00:00	50	20
5378	2026-05-22 13:00:00	49	20
5390	2026-05-22 13:00:00	47	38.26
5397	2026-05-22 13:00:00	48	264
5403	2026-05-22 14:00:00	13	261
5414	2026-05-22 14:00:00	14	15
5426	2026-05-22 14:00:00	11	40
5436	2026-05-22 14:00:00	15	15
5446	2026-05-22 14:00:00	12	54.32
5457	2026-05-22 15:00:00	29	20
5468	2026-05-22 15:00:00	30	20
5480	2026-05-22 15:00:00	26	40
5489	2026-05-22 15:00:00	27	38.39
5499	2026-05-22 15:00:00	28	264
5501	2026-05-22 16:00:00	1	12
5513	2026-05-22 16:00:00	3	171.6
5526	2026-05-22 16:00:00	4	20
5531	2026-05-22 16:00:00	2	24.24
5538	2026-05-22 16:00:00	5	20
5559	2026-05-22 17:00:00	48	264
5565	2026-05-22 17:00:00	49	20
5573	2026-05-22 17:00:00	46	40
5581	2026-05-22 17:00:00	50	20
5591	2026-05-22 17:00:00	47	38.19
5600	2026-05-22 17:00:00	44	20
5601	2026-05-22 18:00:00	5	20
5609	2026-05-22 18:00:00	48	264
5613	2026-05-22 18:00:00	1	12
5620	2026-05-22 18:00:00	49	20
5625	2026-05-22 18:00:00	3	171.6
5630	2026-05-22 18:00:00	46	40
5634	2026-05-22 18:00:00	4	20
5640	2026-05-22 18:00:00	50	20
5641	2026-05-22 18:00:00	2	24.4
5650	2026-05-22 18:00:00	47	38.2
4362	2026-05-21 16:00:00	31	40
4373	2026-05-21 16:00:00	33	264
4383	2026-05-21 16:00:00	32	38.33
4393	2026-05-21 16:00:00	34	20
4398	2026-05-21 16:00:00	35	20
4401	2026-05-21 17:00:00	6	12
4413	2026-05-21 17:00:00	10	20
4423	2026-05-21 17:00:00	9	20
4433	2026-05-21 17:00:00	7	24.41
4442	2026-05-21 17:00:00	8	171.6
4458	2026-05-21 18:00:00	34	20
4465	2026-05-21 18:00:00	35	20
4474	2026-05-21 18:00:00	31	40
4481	2026-05-21 18:00:00	33	264
4487	2026-05-21 18:00:00	32	38.34
4510	2026-05-21 19:00:00	43	264
4519	2026-05-21 19:00:00	44	20
4530	2026-05-21 19:00:00	45	20
4538	2026-05-21 19:00:00	42	38.37
4546	2026-05-21 19:00:00	41	40
4557	2026-05-21 20:00:00	21	40
4567	2026-05-21 20:00:00	25	20
4578	2026-05-21 20:00:00	22	38.31
4584	2026-05-21 20:00:00	23	264
4595	2026-05-21 20:00:00	24	20
4604	2026-05-21 21:00:00	19	20
4613	2026-05-21 21:00:00	18	264
4625	2026-05-21 21:00:00	17	38.21
4640	2026-05-21 21:00:00	16	40
4646	2026-05-21 21:00:00	20	20
4657	2026-05-21 22:00:00	29	20
4664	2026-05-21 22:00:00	30	20
4674	2026-05-21 22:00:00	26	40
4684	2026-05-21 22:00:00	27	38.32
4692	2026-05-21 22:00:00	28	264
4710	2026-05-21 23:00:00	50	20
4720	2026-05-21 23:00:00	49	20
4731	2026-05-21 23:00:00	47	38.48
4740	2026-05-21 23:00:00	48	264
4750	2026-05-21 23:00:00	46	40
4751	2026-05-22 01:00:00	1	12
4766	2026-05-22 01:00:00	4	20
4778	2026-05-22 01:00:00	2	24.31
4791	2026-05-22 01:00:00	5	20
4799	2026-05-22 01:00:00	3	171.6
4802	2026-05-22 02:00:00	9	20
4823	2026-05-22 02:00:00	7	24.46
4831	2026-05-22 02:00:00	8	171.6
4841	2026-05-22 02:00:00	10	20
4850	2026-05-22 02:00:00	6	12
4852	2026-05-22 03:00:00	3	171.6
4864	2026-05-22 03:00:00	4	20
4873	2026-05-22 03:00:00	2	24.28
4882	2026-05-22 03:00:00	5	20
4891	2026-05-22 03:00:00	1	12
4908	2026-05-22 04:00:00	50	20
4918	2026-05-22 04:00:00	49	20
4927	2026-05-22 04:00:00	47	38.23
4936	2026-05-22 04:00:00	48	264
4945	2026-05-22 04:00:00	46	40
4960	2026-05-22 05:00:00	20	20
4970	2026-05-22 05:00:00	19	20
4979	2026-05-22 05:00:00	18	264
4989	2026-05-22 05:00:00	17	38.41
4996	2026-05-22 05:00:00	16	40
5004	2026-05-22 06:00:00	20	20
5011	2026-05-22 06:00:00	19	20
5021	2026-05-22 06:00:00	16	40
5031	2026-05-22 06:00:00	18	264
5041	2026-05-22 06:00:00	17	38.37
5060	2026-05-22 07:00:00	41	40
5065	2026-05-22 07:00:00	43	264
5079	2026-05-22 07:00:00	45	20
5089	2026-05-22 07:00:00	42	38.24
5097	2026-05-22 07:00:00	44	20
5103	2026-05-22 08:00:00	15	15
5111	2026-05-22 08:00:00	12	54.3
5120	2026-05-22 08:00:00	13	261
5126	2026-05-22 08:00:00	14	15
5139	2026-05-22 08:00:00	11	40
5159	2026-05-22 09:00:00	41	40
5171	2026-05-22 09:00:00	43	264
5178	2026-05-22 09:00:00	45	20
5188	2026-05-22 09:00:00	42	38.3
5199	2026-05-22 09:00:00	44	20
5201	2026-05-22 10:00:00	4	20
5211	2026-05-22 10:00:00	2	24.44
5221	2026-05-22 10:00:00	5	20
5231	2026-05-22 10:00:00	1	12
5240	2026-05-22 10:00:00	3	171.6
5260	2026-05-22 11:00:00	41	40
5272	2026-05-22 11:00:00	43	264
5283	2026-05-22 11:00:00	45	20
5291	2026-05-22 11:00:00	42	38.28
5299	2026-05-22 11:00:00	44	20
5304	2026-05-22 12:00:00	15	15
5315	2026-05-22 12:00:00	12	80.9
5329	2026-05-22 12:00:00	13	432.6
5338	2026-05-22 12:00:00	14	15
5348	2026-05-22 12:00:00	11	92
5354	2026-05-22 13:00:00	18	264
5369	2026-05-22 13:00:00	17	38.37
5376	2026-05-22 13:00:00	20	20
5388	2026-05-22 13:00:00	16	40
5399	2026-05-22 13:00:00	19	20
5401	2026-05-22 14:00:00	10	20
5415	2026-05-22 14:00:00	9	20
5427	2026-05-22 14:00:00	8	171.6
5439	2026-05-22 14:00:00	7	24.45
5450	2026-05-22 14:00:00	6	12
5451	2026-05-22 15:00:00	2	24.22
5464	2026-05-22 15:00:00	5	20
5475	2026-05-22 15:00:00	1	12
5485	2026-05-22 15:00:00	3	171.6
5492	2026-05-22 15:00:00	4	20
5508	2026-05-22 16:00:00	39	20
5517	2026-05-22 16:00:00	36	40
5527	2026-05-22 16:00:00	38	264
5539	2026-05-22 16:00:00	40	20
5548	2026-05-22 16:00:00	37	38.2
5553	2026-05-22 17:00:00	10	20
5562	2026-05-22 17:00:00	9	20
5570	2026-05-22 17:00:00	8	171.6
5580	2026-05-22 17:00:00	7	24.37
5590	2026-05-22 17:00:00	6	12
5610	2026-05-22 18:00:00	44	20
5616	2026-05-22 18:00:00	41	40
5621	2026-05-22 18:00:00	43	264
5632	2026-05-22 18:00:00	45	20
5644	2026-05-22 18:00:00	42	38.22
5651	2026-05-22 19:00:00	1	12
5653	2026-05-22 19:00:00	14	15
5656	2026-05-22 19:00:00	24	20
5658	2026-05-22 19:00:00	32	38.42
5659	2026-05-22 19:00:00	44	20
5661	2026-05-22 19:00:00	3	171.6
4364	2026-05-21 16:00:00	22	38.46
4375	2026-05-21 16:00:00	23	264
4385	2026-05-21 16:00:00	24	20
4395	2026-05-21 16:00:00	21	40
4400	2026-05-21 16:00:00	25	20
4402	2026-05-21 17:00:00	2	24.32
4415	2026-05-21 17:00:00	4	20
4425	2026-05-21 17:00:00	1	12
4435	2026-05-21 17:00:00	5	20
4444	2026-05-21 17:00:00	3	171.6
4457	2026-05-21 18:00:00	38	264
4468	2026-05-21 18:00:00	40	20
4478	2026-05-21 18:00:00	37	38.2
4489	2026-05-21 18:00:00	39	20
4497	2026-05-21 18:00:00	36	40
4506	2026-05-21 19:00:00	20	20
4513	2026-05-21 19:00:00	17	38.45
4522	2026-05-21 19:00:00	16	40
4533	2026-05-21 19:00:00	19	20
4542	2026-05-21 19:00:00	18	264
4556	2026-05-21 20:00:00	42	38.47
4562	2026-05-21 20:00:00	41	40
4573	2026-05-21 20:00:00	43	264
4587	2026-05-21 20:00:00	44	20
4597	2026-05-21 20:00:00	45	20
4607	2026-05-21 21:00:00	35	20
4619	2026-05-21 21:00:00	31	40
4630	2026-05-21 21:00:00	33	264
4636	2026-05-21 21:00:00	32	38.39
4645	2026-05-21 21:00:00	34	20
4655	2026-05-21 22:00:00	21	40
4666	2026-05-21 22:00:00	25	20
4680	2026-05-21 22:00:00	22	38.26
4690	2026-05-21 22:00:00	23	264
4699	2026-05-21 22:00:00	24	20
5210	2026-05-22 10:00:00	38	264
5215	2026-05-22 10:00:00	40	20
5224	2026-05-22 10:00:00	37	38.42
5235	2026-05-22 10:00:00	39	20
5246	2026-05-22 10:00:00	36	40
5254	2026-05-22 11:00:00	7	24.2
5266	2026-05-22 11:00:00	10	20
5275	2026-05-22 11:00:00	9	20
5287	2026-05-22 11:00:00	8	171.6
5298	2026-05-22 11:00:00	6	12
5302	2026-05-22 12:00:00	8	171.6
5316	2026-05-22 12:00:00	7	24.27
5327	2026-05-22 12:00:00	6	12
5339	2026-05-22 12:00:00	10	20
5347	2026-05-22 12:00:00	9	20
5353	2026-05-22 13:00:00	14	15
5367	2026-05-22 13:00:00	11	40
5382	2026-05-22 13:00:00	15	15
5391	2026-05-22 13:00:00	12	54.16
5398	2026-05-22 13:00:00	13	261
5404	2026-05-22 14:00:00	19	20
5416	2026-05-22 14:00:00	18	264
5423	2026-05-22 14:00:00	17	38.24
5434	2026-05-22 14:00:00	20	20
5443	2026-05-22 14:00:00	16	40
5460	2026-05-22 15:00:00	43	264
5471	2026-05-22 15:00:00	45	20
5481	2026-05-22 15:00:00	42	38.34
5491	2026-05-22 15:00:00	44	20
5497	2026-05-22 15:00:00	41	40
5502	2026-05-22 16:00:00	15	15
5514	2026-05-22 16:00:00	12	54.19
5525	2026-05-22 16:00:00	13	261
5535	2026-05-22 16:00:00	14	15
5545	2026-05-22 16:00:00	11	40
5556	2026-05-22 17:00:00	29	20
5566	2026-05-22 17:00:00	30	20
5577	2026-05-22 17:00:00	26	40
5587	2026-05-22 17:00:00	27	38.26
5596	2026-05-22 17:00:00	28	264
5602	2026-05-22 18:00:00	10	20
5615	2026-05-22 18:00:00	9	20
5626	2026-05-22 18:00:00	8	171.6
5636	2026-05-22 18:00:00	7	24.25
5646	2026-05-22 18:00:00	6	12
5652	2026-05-22 19:00:00	7	24.42
5654	2026-05-22 19:00:00	20	20
5655	2026-05-22 19:00:00	29	20
5657	2026-05-22 19:00:00	36	40
5660	2026-05-22 19:00:00	48	264
5662	2026-05-22 19:00:00	30	20
5663	2026-05-22 19:00:00	34	20
5664	2026-05-22 19:00:00	49	20
5665	2026-05-22 19:00:00	38	264
5666	2026-05-22 19:00:00	6	12
5667	2026-05-22 19:00:00	11	40
5668	2026-05-22 19:00:00	4	20
5669	2026-05-22 19:00:00	16	40
5670	2026-05-22 19:00:00	41	40
5671	2026-05-22 19:00:00	25	20
5672	2026-05-22 19:00:00	26	40
5673	2026-05-22 19:00:00	35	20
5674	2026-05-22 19:00:00	46	40
5675	2026-05-22 19:00:00	2	24.48
5676	2026-05-22 19:00:00	27	38.43
5677	2026-05-22 19:00:00	40	20
5678	2026-05-22 19:00:00	15	15
5679	2026-05-22 19:00:00	10	20
5680	2026-05-22 19:00:00	5	20
5681	2026-05-22 19:00:00	31	40
5682	2026-05-22 19:00:00	19	20
5683	2026-05-22 19:00:00	43	264
5684	2026-05-22 19:00:00	22	38.46
5685	2026-05-22 19:00:00	28	264
5686	2026-05-22 19:00:00	50	20
5687	2026-05-22 19:00:00	33	264
5688	2026-05-22 19:00:00	37	38.22
5689	2026-05-22 19:00:00	12	54.1
5690	2026-05-22 19:00:00	9	20
5691	2026-05-22 19:00:00	18	264
5692	2026-05-22 19:00:00	45	20
5693	2026-05-22 19:00:00	23	264
5694	2026-05-22 19:00:00	47	38.45
5695	2026-05-22 19:00:00	17	38.33
5696	2026-05-22 19:00:00	39	20
5697	2026-05-22 19:00:00	8	171.6
5698	2026-05-22 19:00:00	13	261
5699	2026-05-22 19:00:00	21	40
5700	2026-05-22 19:00:00	42	38.31
5701	2026-05-22 20:00:00	2	24.44
5702	2026-05-22 20:00:00	16	40
5703	2026-05-22 20:00:00	25	20
5705	2026-05-22 20:00:00	6	12
5704	2026-05-22 20:00:00	11	40
5706	2026-05-22 20:00:00	40	20
5707	2026-05-22 20:00:00	26	40
5708	2026-05-22 20:00:00	35	20
5709	2026-05-22 20:00:00	41	40
5710	2026-05-22 20:00:00	46	40
5711	2026-05-22 20:00:00	31	40
5712	2026-05-22 20:00:00	37	38.19
5713	2026-05-22 20:00:00	43	264
5725	2026-05-22 20:00:00	45	20
5736	2026-05-22 20:00:00	42	38.38
5745	2026-05-22 20:00:00	44	20
5753	2026-05-22 21:00:00	27	38.33
5762	2026-05-22 21:00:00	28	264
5772	2026-05-22 21:00:00	29	20
5786	2026-05-22 21:00:00	30	20
5795	2026-05-22 21:00:00	26	40
5804	2026-05-22 22:00:00	17	38.41
5811	2026-05-22 22:00:00	20	20
5821	2026-05-22 22:00:00	16	40
5826	2026-05-22 22:00:00	19	20
5834	2026-05-22 22:00:00	18	264
5860	2026-05-22 23:00:00	46	40
5873	2026-05-22 23:00:00	50	20
5877	2026-05-22 23:00:00	47	38.2
5886	2026-05-22 23:00:00	48	264
5888	2026-05-22 23:00:00	49	20
5909	2026-05-23 00:00:00	37	38.43
5917	2026-05-23 00:00:00	39	20
5927	2026-05-23 00:00:00	36	40
5940	2026-05-23 00:00:00	38	264
5949	2026-05-23 00:00:00	40	20
5951	2026-05-23 01:00:00	6	12
5965	2026-05-23 01:00:00	10	20
5977	2026-05-23 01:00:00	9	20
5988	2026-05-23 01:00:00	8	171.6
5998	2026-05-23 01:00:00	7	24.41
6004	2026-05-23 02:00:00	20	20
6012	2026-05-23 02:00:00	16	40
6025	2026-05-23 02:00:00	19	20
6034	2026-05-23 02:00:00	18	264
6042	2026-05-23 02:00:00	17	38.28
6055	2026-05-23 03:00:00	35	20
6065	2026-05-23 03:00:00	31	40
6075	2026-05-23 03:00:00	33	264
6087	2026-05-23 03:00:00	32	38.29
6096	2026-05-23 03:00:00	34	20
6103	2026-05-23 04:00:00	11	40
6115	2026-05-23 04:00:00	15	15
6126	2026-05-23 04:00:00	12	54.16
6135	2026-05-23 04:00:00	13	261
6146	2026-05-23 04:00:00	14	15
6153	2026-05-23 05:00:00	21	40
6168	2026-05-23 05:00:00	24	20
6175	2026-05-23 05:00:00	25	20
6184	2026-05-23 05:00:00	22	38.32
6195	2026-05-23 05:00:00	23	264
6207	2026-05-23 06:00:00	35	20
6212	2026-05-23 06:00:00	31	40
6222	2026-05-23 06:00:00	33	264
6231	2026-05-23 06:00:00	32	38.38
6237	2026-05-23 06:00:00	34	20
6260	2026-05-23 07:00:00	47	38.22
6269	2026-05-23 07:00:00	48	264
6272	2026-05-23 07:00:00	49	20
6283	2026-05-23 07:00:00	46	40
6293	2026-05-23 07:00:00	50	20
6309	2026-05-23 08:00:00	41	40
6315	2026-05-23 08:00:00	43	264
6325	2026-05-23 08:00:00	45	20
6335	2026-05-23 08:00:00	42	38.3
6344	2026-05-23 08:00:00	44	20
6358	2026-05-23 09:00:00	42	38.33
6368	2026-05-23 09:00:00	44	20
6374	2026-05-23 09:00:00	41	40
6384	2026-05-23 09:00:00	43	264
6397	2026-05-23 09:00:00	45	20
6404	2026-05-23 10:00:00	15	15
6417	2026-05-23 10:00:00	12	54.13
6423	2026-05-23 10:00:00	13	261
6431	2026-05-23 10:00:00	14	15
6438	2026-05-23 10:00:00	11	40
6462	2026-05-23 11:00:00	47	38.31
6476	2026-05-23 11:00:00	48	264
6487	2026-05-23 11:00:00	49	20
6495	2026-05-23 11:00:00	46	40
6500	2026-05-23 11:00:00	50	20
6501	2026-05-23 12:00:00	1	12
6511	2026-05-23 12:00:00	3	171.6
6525	2026-05-23 12:00:00	4	20
6534	2026-05-23 12:00:00	2	24.33
6546	2026-05-23 12:00:00	5	20
6556	2026-05-23 13:00:00	21	40
6569	2026-05-23 13:00:00	24	20
6581	2026-05-23 13:00:00	25	20
6592	2026-05-23 13:00:00	22	38.47
6600	2026-05-23 13:00:00	23	264
6601	2026-05-23 14:00:00	4	20
6611	2026-05-23 14:00:00	2	24.48
6623	2026-05-23 14:00:00	5	20
6634	2026-05-23 14:00:00	1	12
6641	2026-05-23 14:00:00	3	171.6
6658	2026-05-23 15:00:00	35	20
6662	2026-05-23 15:00:00	31	40
6671	2026-05-23 15:00:00	33	264
6681	2026-05-23 15:00:00	32	38.2
6691	2026-05-23 15:00:00	34	20
7201	2026-05-24 02:00:00	2	24.44
7211	2026-05-24 02:00:00	5	20
7223	2026-05-24 02:00:00	1	12
7233	2026-05-24 02:00:00	3	171.6
7244	2026-05-24 02:00:00	4	20
7256	2026-05-24 03:00:00	30	20
7268	2026-05-24 03:00:00	26	40
7280	2026-05-24 03:00:00	27	38.22
7288	2026-05-24 03:00:00	28	264
7298	2026-05-24 03:00:00	29	20
7304	2026-05-24 04:00:00	14	15
7311	2026-05-24 04:00:00	11	40
7319	2026-05-24 04:00:00	15	15
7322	2026-05-24 04:00:00	12	54.31
7333	2026-05-24 04:00:00	13	261
7360	2026-05-24 05:00:00	48	264
7365	2026-05-24 05:00:00	49	20
7371	2026-05-24 05:00:00	46	40
7381	2026-05-24 05:00:00	50	20
7390	2026-05-24 05:00:00	47	38.25
7409	2026-05-24 06:00:00	48	264
7419	2026-05-24 06:00:00	49	20
7432	2026-05-24 06:00:00	46	40
7442	2026-05-24 06:00:00	50	20
7447	2026-05-24 06:00:00	47	38.45
7454	2026-05-24 07:00:00	15	15
7466	2026-05-24 07:00:00	12	54.1
7474	2026-05-24 07:00:00	13	261
7486	2026-05-24 07:00:00	14	15
7496	2026-05-24 07:00:00	11	40
7503	2026-05-24 08:00:00	14	15
7517	2026-05-24 08:00:00	11	40
7527	2026-05-24 08:00:00	15	15
7538	2026-05-24 08:00:00	12	54.2
7546	2026-05-24 08:00:00	13	261
7552	2026-05-24 09:00:00	6	12
7561	2026-05-24 09:00:00	10	20
5714	2026-05-22 20:00:00	5	20
5724	2026-05-22 20:00:00	1	12
5732	2026-05-22 20:00:00	3	171.6
5742	2026-05-22 20:00:00	4	20
5759	2026-05-22 21:00:00	43	264
5769	2026-05-22 21:00:00	45	20
5780	2026-05-22 21:00:00	42	38.34
5790	2026-05-22 21:00:00	44	20
5800	2026-05-22 21:00:00	41	40
5801	2026-05-22 22:00:00	3	171.6
5816	2026-05-22 22:00:00	4	20
5828	2026-05-22 22:00:00	2	24.39
5839	2026-05-22 22:00:00	5	20
5848	2026-05-22 22:00:00	1	12
5853	2026-05-22 23:00:00	18	264
5868	2026-05-22 23:00:00	17	38.23
5882	2026-05-22 23:00:00	20	20
5894	2026-05-22 23:00:00	16	40
5900	2026-05-22 23:00:00	19	20
5902	2026-05-23 00:00:00	2	24.44
5912	2026-05-23 00:00:00	5	20
5922	2026-05-23 00:00:00	1	12
5932	2026-05-23 00:00:00	3	171.6
5943	2026-05-23 00:00:00	4	20
5957	2026-05-23 01:00:00	25	20
5969	2026-05-23 01:00:00	22	38.19
5975	2026-05-23 01:00:00	23	264
5984	2026-05-23 01:00:00	21	40
5995	2026-05-23 01:00:00	24	20
6008	2026-05-23 02:00:00	27	38.43
6018	2026-05-23 02:00:00	28	264
6031	2026-05-23 02:00:00	29	20
6041	2026-05-23 02:00:00	30	20
6048	2026-05-23 02:00:00	26	40
6054	2026-05-23 03:00:00	15	15
6064	2026-05-23 03:00:00	12	54.11
6074	2026-05-23 03:00:00	13	261
6085	2026-05-23 03:00:00	14	15
6095	2026-05-23 03:00:00	11	40
6106	2026-05-23 04:00:00	34	20
6113	2026-05-23 04:00:00	35	20
6122	2026-05-23 04:00:00	31	40
6132	2026-05-23 04:00:00	33	264
6143	2026-05-23 04:00:00	32	38.4
6158	2026-05-23 05:00:00	40	20
6164	2026-05-23 05:00:00	37	38.32
6180	2026-05-23 05:00:00	39	20
6192	2026-05-23 05:00:00	36	40
6200	2026-05-23 05:00:00	38	264
6201	2026-05-23 06:00:00	7	24.36
6213	2026-05-23 06:00:00	6	12
6221	2026-05-23 06:00:00	10	20
6232	2026-05-23 06:00:00	9	20
6244	2026-05-23 06:00:00	8	171.6
6252	2026-05-23 07:00:00	12	54.29
6263	2026-05-23 07:00:00	13	261
6275	2026-05-23 07:00:00	14	15
6286	2026-05-23 07:00:00	11	40
6296	2026-05-23 07:00:00	15	15
6304	2026-05-23 08:00:00	26	40
6318	2026-05-23 08:00:00	27	38.22
6329	2026-05-23 08:00:00	28	264
6334	2026-05-23 08:00:00	29	20
6343	2026-05-23 08:00:00	30	20
6357	2026-05-23 09:00:00	40	20
6364	2026-05-23 09:00:00	37	38.22
6373	2026-05-23 09:00:00	39	20
6378	2026-05-23 09:00:00	36	40
6389	2026-05-23 09:00:00	38	264
6410	2026-05-23 10:00:00	42	38.47
6416	2026-05-23 10:00:00	44	20
6424	2026-05-23 10:00:00	41	40
6436	2026-05-23 10:00:00	43	264
6445	2026-05-23 10:00:00	45	20
6458	2026-05-23 11:00:00	42	38.43
6466	2026-05-23 11:00:00	44	20
6478	2026-05-23 11:00:00	41	40
6484	2026-05-23 11:00:00	43	264
6493	2026-05-23 11:00:00	45	20
6506	2026-05-23 12:00:00	26	92
6517	2026-05-23 12:00:00	27	64.33
6528	2026-05-23 12:00:00	28	435.6
6538	2026-05-23 12:00:00	29	20
6548	2026-05-23 12:00:00	30	20
6560	2026-05-23 13:00:00	14	15
6567	2026-05-23 13:00:00	11	40
6577	2026-05-23 13:00:00	15	15
6585	2026-05-23 13:00:00	12	54.36
6595	2026-05-23 13:00:00	13	261
6607	2026-05-23 14:00:00	27	38.42
6618	2026-05-23 14:00:00	28	264
6629	2026-05-23 14:00:00	29	20
6643	2026-05-23 14:00:00	30	20
6648	2026-05-23 14:00:00	26	40
6652	2026-05-23 15:00:00	13	261
6669	2026-05-23 15:00:00	14	15
6679	2026-05-23 15:00:00	11	40
6690	2026-05-23 15:00:00	15	15
6700	2026-05-23 15:00:00	12	54.23
7202	2026-05-24 02:00:00	10	20
7214	2026-05-24 02:00:00	9	20
7228	2026-05-24 02:00:00	8	171.6
7238	2026-05-24 02:00:00	7	24.21
7248	2026-05-24 02:00:00	6	12
7252	2026-05-24 03:00:00	8	171.6
7265	2026-05-24 03:00:00	7	24.34
7271	2026-05-24 03:00:00	6	12
7275	2026-05-24 03:00:00	10	20
7283	2026-05-24 03:00:00	9	20
7310	2026-05-24 04:00:00	47	38.43
7321	2026-05-24 04:00:00	48	264
7331	2026-05-24 04:00:00	49	20
7339	2026-05-24 04:00:00	46	40
7349	2026-05-24 04:00:00	50	20
7354	2026-05-24 05:00:00	17	38.34
7361	2026-05-24 05:00:00	20	20
7373	2026-05-24 05:00:00	16	40
7383	2026-05-24 05:00:00	19	20
7395	2026-05-24 05:00:00	18	264
7410	2026-05-24 06:00:00	45	20
7421	2026-05-24 06:00:00	42	38.42
7434	2026-05-24 06:00:00	44	20
7443	2026-05-24 06:00:00	41	40
7450	2026-05-24 06:00:00	43	264
7451	2026-05-24 07:00:00	2	24.4
7461	2026-05-24 07:00:00	5	20
7475	2026-05-24 07:00:00	1	12
7487	2026-05-24 07:00:00	3	171.6
7495	2026-05-24 07:00:00	4	20
7507	2026-05-24 08:00:00	28	264
7520	2026-05-24 08:00:00	29	20
7531	2026-05-24 08:00:00	30	20
7536	2026-05-24 08:00:00	26	40
7544	2026-05-24 08:00:00	27	38.46
7556	2026-05-24 09:00:00	22	38.22
7569	2026-05-24 09:00:00	23	264
5715	2026-05-22 20:00:00	27	38.3
5722	2026-05-22 20:00:00	28	264
5734	2026-05-22 20:00:00	29	20
5744	2026-05-22 20:00:00	30	20
5757	2026-05-22 21:00:00	31	40
5763	2026-05-22 21:00:00	33	264
5776	2026-05-22 21:00:00	32	38.3
5785	2026-05-22 21:00:00	34	20
5798	2026-05-22 21:00:00	35	20
5809	2026-05-22 22:00:00	36	40
5813	2026-05-22 22:00:00	38	264
5823	2026-05-22 22:00:00	40	20
5833	2026-05-22 22:00:00	37	38.46
5843	2026-05-22 22:00:00	39	20
5856	2026-05-22 23:00:00	37	38.45
5861	2026-05-22 23:00:00	39	20
5869	2026-05-22 23:00:00	36	40
5879	2026-05-22 23:00:00	38	264
5892	2026-05-22 23:00:00	40	20
5906	2026-05-23 00:00:00	33	264
5916	2026-05-23 00:00:00	32	38.19
5928	2026-05-23 00:00:00	34	20
5937	2026-05-23 00:00:00	35	20
5947	2026-05-23 00:00:00	31	40
5954	2026-05-23 01:00:00	15	15
5967	2026-05-23 01:00:00	12	54.35
5980	2026-05-23 01:00:00	13	261
5992	2026-05-23 01:00:00	14	15
6000	2026-05-23 01:00:00	11	40
6001	2026-05-23 02:00:00	2	24.25
6016	2026-05-23 02:00:00	5	20
6027	2026-05-23 02:00:00	1	12
6037	2026-05-23 02:00:00	3	171.6
6047	2026-05-23 02:00:00	4	20
6056	2026-05-23 03:00:00	21	40
6063	2026-05-23 03:00:00	24	20
6071	2026-05-23 03:00:00	25	20
6082	2026-05-23 03:00:00	22	38.3
6092	2026-05-23 03:00:00	23	264
6110	2026-05-23 04:00:00	41	40
6120	2026-05-23 04:00:00	43	264
6130	2026-05-23 04:00:00	45	20
6140	2026-05-23 04:00:00	42	38.34
6149	2026-05-23 04:00:00	44	20
6152	2026-05-23 05:00:00	5	20
6162	2026-05-23 05:00:00	1	12
6179	2026-05-23 05:00:00	3	171.6
6188	2026-05-23 05:00:00	4	20
6193	2026-05-23 05:00:00	2	24.45
6208	2026-05-23 06:00:00	37	38.24
6220	2026-05-23 06:00:00	39	20
6229	2026-05-23 06:00:00	36	40
6240	2026-05-23 06:00:00	38	264
6248	2026-05-23 06:00:00	40	20
6254	2026-05-23 07:00:00	20	20
6264	2026-05-23 07:00:00	16	40
6274	2026-05-23 07:00:00	19	20
6288	2026-05-23 07:00:00	18	264
6298	2026-05-23 07:00:00	17	38.41
6305	2026-05-23 08:00:00	19	20
6311	2026-05-23 08:00:00	18	264
6321	2026-05-23 08:00:00	17	38.38
6331	2026-05-23 08:00:00	20	20
6340	2026-05-23 08:00:00	16	40
6360	2026-05-23 09:00:00	47	38.37
6370	2026-05-23 09:00:00	48	264
6383	2026-05-23 09:00:00	49	20
6393	2026-05-23 09:00:00	46	40
6400	2026-05-23 09:00:00	50	20
6401	2026-05-23 10:00:00	3	171.6
6415	2026-05-23 10:00:00	4	20
6428	2026-05-23 10:00:00	2	24.36
6439	2026-05-23 10:00:00	5	20
6448	2026-05-23 10:00:00	1	12
6455	2026-05-23 11:00:00	15	15
6468	2026-05-23 11:00:00	12	54.25
6479	2026-05-23 11:00:00	13	261
6490	2026-05-23 11:00:00	14	15
6499	2026-05-23 11:00:00	11	40
6504	2026-05-23 12:00:00	19	20
6518	2026-05-23 12:00:00	18	435.6
6527	2026-05-23 12:00:00	17	64.49
6536	2026-05-23 12:00:00	20	20
6547	2026-05-23 12:00:00	16	92
6553	2026-05-23 13:00:00	38	264
6562	2026-05-23 13:00:00	40	20
6571	2026-05-23 13:00:00	37	38.28
6578	2026-05-23 13:00:00	39	20
6588	2026-05-23 13:00:00	36	40
6609	2026-05-23 14:00:00	46	40
6615	2026-05-23 14:00:00	50	20
6622	2026-05-23 14:00:00	47	38.23
6635	2026-05-23 14:00:00	48	264
6645	2026-05-23 14:00:00	49	20
6657	2026-05-23 15:00:00	27	38.47
6665	2026-05-23 15:00:00	28	264
6674	2026-05-23 15:00:00	29	20
6685	2026-05-23 15:00:00	30	20
6697	2026-05-23 15:00:00	26	40
7203	2026-05-24 02:00:00	13	261
7216	2026-05-24 02:00:00	14	15
7221	2026-05-24 02:00:00	11	40
7231	2026-05-24 02:00:00	15	15
7242	2026-05-24 02:00:00	12	54.25
7258	2026-05-24 03:00:00	39	20
7269	2026-05-24 03:00:00	36	40
7282	2026-05-24 03:00:00	38	264
7292	2026-05-24 03:00:00	40	20
7300	2026-05-24 03:00:00	37	38.21
7301	2026-05-24 04:00:00	2	24.2
7312	2026-05-24 04:00:00	5	20
7323	2026-05-24 04:00:00	1	12
7334	2026-05-24 04:00:00	3	171.6
7344	2026-05-24 04:00:00	4	20
7357	2026-05-24 05:00:00	28	264
7367	2026-05-24 05:00:00	29	20
7379	2026-05-24 05:00:00	30	20
7386	2026-05-24 05:00:00	26	40
7396	2026-05-24 05:00:00	27	38.27
7404	2026-05-24 06:00:00	21	40
7417	2026-05-24 06:00:00	24	20
7430	2026-05-24 06:00:00	25	20
7440	2026-05-24 06:00:00	22	38.43
7448	2026-05-24 06:00:00	23	264
7453	2026-05-24 07:00:00	16	40
7462	2026-05-24 07:00:00	19	20
7477	2026-05-24 07:00:00	18	264
7485	2026-05-24 07:00:00	17	38.29
7494	2026-05-24 07:00:00	20	20
7506	2026-05-24 08:00:00	22	38.43
7512	2026-05-24 08:00:00	23	264
7521	2026-05-24 08:00:00	21	40
7528	2026-05-24 08:00:00	24	20
7533	2026-05-24 08:00:00	25	20
7560	2026-05-24 09:00:00	47	38.2
7571	2026-05-24 09:00:00	48	264
5716	2026-05-22 20:00:00	22	38.32
5729	2026-05-22 20:00:00	23	264
5738	2026-05-22 20:00:00	21	40
5749	2026-05-22 20:00:00	24	20
5751	2026-05-22 21:00:00	5	20
5761	2026-05-22 21:00:00	1	12
5771	2026-05-22 21:00:00	3	171.6
5781	2026-05-22 21:00:00	4	20
5793	2026-05-22 21:00:00	2	24.42
5810	2026-05-22 22:00:00	47	38.44
5820	2026-05-22 22:00:00	48	264
5830	2026-05-22 22:00:00	49	20
5838	2026-05-22 22:00:00	46	40
5846	2026-05-22 22:00:00	50	20
5857	2026-05-22 23:00:00	27	38.19
5866	2026-05-22 23:00:00	28	264
5881	2026-05-22 23:00:00	29	20
5893	2026-05-22 23:00:00	30	20
5897	2026-05-22 23:00:00	26	40
5910	2026-05-23 00:00:00	16	40
5919	2026-05-23 00:00:00	19	20
5931	2026-05-23 00:00:00	18	264
5938	2026-05-23 00:00:00	17	38.27
5942	2026-05-23 00:00:00	20	20
5959	2026-05-23 01:00:00	37	38.43
5962	2026-05-23 01:00:00	39	20
5973	2026-05-23 01:00:00	36	40
5987	2026-05-23 01:00:00	38	264
5997	2026-05-23 01:00:00	40	20
6007	2026-05-23 02:00:00	22	38.4
6019	2026-05-23 02:00:00	23	264
6030	2026-05-23 02:00:00	21	40
6043	2026-05-23 02:00:00	24	20
6050	2026-05-23 02:00:00	25	20
6053	2026-05-23 03:00:00	8	171.6
6061	2026-05-23 03:00:00	7	24.39
6076	2026-05-23 03:00:00	6	12
6086	2026-05-23 03:00:00	10	20
6097	2026-05-23 03:00:00	9	20
6107	2026-05-23 04:00:00	28	264
6119	2026-05-23 04:00:00	29	20
6129	2026-05-23 04:00:00	30	20
6137	2026-05-23 04:00:00	26	40
6147	2026-05-23 04:00:00	27	38.44
6154	2026-05-23 05:00:00	11	40
6169	2026-05-23 05:00:00	15	15
6176	2026-05-23 05:00:00	12	54.09
6187	2026-05-23 05:00:00	13	261
6197	2026-05-23 05:00:00	14	15
6204	2026-05-23 06:00:00	30	20
6219	2026-05-23 06:00:00	26	40
6227	2026-05-23 06:00:00	27	38.43
6234	2026-05-23 06:00:00	28	264
6242	2026-05-23 06:00:00	29	20
6255	2026-05-23 07:00:00	42	38.43
6265	2026-05-23 07:00:00	44	20
6276	2026-05-23 07:00:00	41	40
6285	2026-05-23 07:00:00	43	264
6292	2026-05-23 07:00:00	45	20
6307	2026-05-23 08:00:00	36	40
6317	2026-05-23 08:00:00	38	264
6328	2026-05-23 08:00:00	40	20
6337	2026-05-23 08:00:00	37	38.35
6346	2026-05-23 08:00:00	39	20
6355	2026-05-23 09:00:00	29	20
6362	2026-05-23 09:00:00	30	20
6371	2026-05-23 09:00:00	26	40
6379	2026-05-23 09:00:00	27	38.28
6390	2026-05-23 09:00:00	28	264
6409	2026-05-23 10:00:00	40	20
6411	2026-05-23 10:00:00	37	38.48
6421	2026-05-23 10:00:00	39	20
6433	2026-05-23 10:00:00	36	40
6442	2026-05-23 10:00:00	38	264
6457	2026-05-23 11:00:00	29	20
6467	2026-05-23 11:00:00	30	20
6472	2026-05-23 11:00:00	26	40
6480	2026-05-23 11:00:00	27	38.39
6488	2026-05-23 11:00:00	28	264
6505	2026-05-23 12:00:00	41	92
6516	2026-05-23 12:00:00	43	435.6
6523	2026-05-23 12:00:00	45	20
6535	2026-05-23 12:00:00	42	64.3
6542	2026-05-23 12:00:00	44	20
6558	2026-05-23 13:00:00	42	38.43
6566	2026-05-23 13:00:00	44	20
6580	2026-05-23 13:00:00	41	40
6589	2026-05-23 13:00:00	43	264
6598	2026-05-23 13:00:00	45	20
6603	2026-05-23 14:00:00	13	261
6613	2026-05-23 14:00:00	14	15
6627	2026-05-23 14:00:00	11	40
6637	2026-05-23 14:00:00	15	15
6647	2026-05-23 14:00:00	12	54.23
6656	2026-05-23 15:00:00	18	264
6668	2026-05-23 15:00:00	17	38.43
6678	2026-05-23 15:00:00	20	20
6688	2026-05-23 15:00:00	16	40
6698	2026-05-23 15:00:00	19	20
7204	2026-05-24 02:00:00	21	40
7219	2026-05-24 02:00:00	24	20
7226	2026-05-24 02:00:00	25	20
7235	2026-05-24 02:00:00	22	38.24
7247	2026-05-24 02:00:00	23	264
7253	2026-05-24 03:00:00	11	40
7262	2026-05-24 03:00:00	15	15
7272	2026-05-24 03:00:00	12	54.25
7279	2026-05-24 03:00:00	13	261
7286	2026-05-24 03:00:00	14	15
7309	2026-05-24 04:00:00	42	38.23
7317	2026-05-24 04:00:00	44	20
7326	2026-05-24 04:00:00	41	40
7341	2026-05-24 04:00:00	43	264
7350	2026-05-24 04:00:00	45	20
7351	2026-05-24 05:00:00	4	20
7362	2026-05-24 05:00:00	2	24.42
7375	2026-05-24 05:00:00	5	20
7387	2026-05-24 05:00:00	1	12
7393	2026-05-24 05:00:00	3	171.6
7408	2026-05-24 06:00:00	36	40
7413	2026-05-24 06:00:00	38	264
7425	2026-05-24 06:00:00	40	20
7436	2026-05-24 06:00:00	37	38.44
7445	2026-05-24 06:00:00	39	20
7457	2026-05-24 07:00:00	30	20
7464	2026-05-24 07:00:00	26	40
7472	2026-05-24 07:00:00	27	38.3
7479	2026-05-24 07:00:00	28	264
7490	2026-05-24 07:00:00	29	20
7505	2026-05-24 08:00:00	37	38.44
7518	2026-05-24 08:00:00	39	20
7529	2026-05-24 08:00:00	36	40
7547	2026-05-24 08:00:00	38	264
7549	2026-05-24 08:00:00	40	20
7554	2026-05-24 09:00:00	19	20
7567	2026-05-24 09:00:00	18	264
5717	2026-05-22 20:00:00	19	20
5727	2026-05-22 20:00:00	18	264
5735	2026-05-22 20:00:00	17	38.48
5747	2026-05-22 20:00:00	20	20
5758	2026-05-22 21:00:00	22	38.27
5766	2026-05-22 21:00:00	23	264
5777	2026-05-22 21:00:00	21	40
5789	2026-05-22 21:00:00	24	20
5799	2026-05-22 21:00:00	25	20
5803	2026-05-22 22:00:00	9	20
5818	2026-05-22 22:00:00	8	171.6
5827	2026-05-22 22:00:00	7	24.32
5837	2026-05-22 22:00:00	6	12
5847	2026-05-22 22:00:00	10	20
5855	2026-05-22 23:00:00	12	54.3
5867	2026-05-22 23:00:00	13	261
5878	2026-05-22 23:00:00	14	15
5890	2026-05-22 23:00:00	11	40
5896	2026-05-22 23:00:00	15	15
5904	2026-05-23 00:00:00	25	20
5920	2026-05-23 00:00:00	22	38.26
5929	2026-05-23 00:00:00	23	264
5939	2026-05-23 00:00:00	21	40
5945	2026-05-23 00:00:00	24	20
5958	2026-05-23 01:00:00	42	38.21
5970	2026-05-23 01:00:00	44	20
5974	2026-05-23 01:00:00	41	40
5983	2026-05-23 01:00:00	43	264
5994	2026-05-23 01:00:00	45	20
6006	2026-05-23 02:00:00	32	38.48
6017	2026-05-23 02:00:00	34	20
6022	2026-05-23 02:00:00	35	20
6029	2026-05-23 02:00:00	31	40
6036	2026-05-23 02:00:00	33	264
6059	2026-05-23 03:00:00	43	264
6068	2026-05-23 03:00:00	45	20
6079	2026-05-23 03:00:00	42	38.43
6089	2026-05-23 03:00:00	44	20
6098	2026-05-23 03:00:00	41	40
6102	2026-05-23 04:00:00	9	20
6112	2026-05-23 04:00:00	8	171.6
6121	2026-05-23 04:00:00	7	24.45
6131	2026-05-23 04:00:00	6	12
6144	2026-05-23 04:00:00	10	20
6159	2026-05-23 05:00:00	34	20
6163	2026-05-23 05:00:00	35	20
6178	2026-05-23 05:00:00	31	40
6191	2026-05-23 05:00:00	33	264
6199	2026-05-23 05:00:00	32	38.28
6202	2026-05-23 06:00:00	1	12
6214	2026-05-23 06:00:00	3	171.6
6225	2026-05-23 06:00:00	4	20
6239	2026-05-23 06:00:00	2	24.44
6249	2026-05-23 06:00:00	5	20
6253	2026-05-23 07:00:00	6	12
6266	2026-05-23 07:00:00	10	20
6278	2026-05-23 07:00:00	9	20
6284	2026-05-23 07:00:00	8	171.6
6295	2026-05-23 07:00:00	7	24.21
6306	2026-05-23 08:00:00	25	20
6316	2026-05-23 08:00:00	22	38.44
6326	2026-05-23 08:00:00	23	264
6339	2026-05-23 08:00:00	21	40
6350	2026-05-23 08:00:00	24	20
6351	2026-05-23 09:00:00	3	171.6
6361	2026-05-23 09:00:00	4	20
6375	2026-05-23 09:00:00	2	24.49
6387	2026-05-23 09:00:00	5	20
6395	2026-05-23 09:00:00	1	12
6405	2026-05-23 10:00:00	21	40
6419	2026-05-23 10:00:00	24	20
6430	2026-05-23 10:00:00	25	20
6441	2026-05-23 10:00:00	22	38.34
6450	2026-05-23 10:00:00	23	264
6452	2026-05-23 11:00:00	6	12
6460	2026-05-23 11:00:00	10	20
6471	2026-05-23 11:00:00	9	20
6483	2026-05-23 11:00:00	8	171.6
6494	2026-05-23 11:00:00	7	24.35
6507	2026-05-23 12:00:00	32	64.49
6513	2026-05-23 12:00:00	34	20
6521	2026-05-23 12:00:00	35	20
6533	2026-05-23 12:00:00	31	92
6544	2026-05-23 12:00:00	33	435.6
6554	2026-05-23 13:00:00	28	264
6565	2026-05-23 13:00:00	29	20
6575	2026-05-23 13:00:00	30	20
6587	2026-05-23 13:00:00	26	40
6597	2026-05-23 13:00:00	27	38.35
6605	2026-05-23 14:00:00	22	38.48
6616	2026-05-23 14:00:00	23	264
6624	2026-05-23 14:00:00	21	40
6633	2026-05-23 14:00:00	24	20
6640	2026-05-23 14:00:00	25	20
6654	2026-05-23 15:00:00	38	264
6661	2026-05-23 15:00:00	40	20
6673	2026-05-23 15:00:00	37	38.48
6686	2026-05-23 15:00:00	39	20
6696	2026-05-23 15:00:00	36	40
7206	2026-05-24 02:00:00	31	40
7212	2026-05-24 02:00:00	33	264
7225	2026-05-24 02:00:00	32	38.42
7237	2026-05-24 02:00:00	34	20
7245	2026-05-24 02:00:00	35	20
7255	2026-05-24 03:00:00	41	40
7266	2026-05-24 03:00:00	43	264
7278	2026-05-24 03:00:00	45	20
7287	2026-05-24 03:00:00	42	38.45
7295	2026-05-24 03:00:00	44	20
7307	2026-05-24 04:00:00	35	20
7314	2026-05-24 04:00:00	31	40
7328	2026-05-24 04:00:00	33	264
7340	2026-05-24 04:00:00	32	38.2
7348	2026-05-24 04:00:00	34	20
7353	2026-05-24 05:00:00	14	15
7364	2026-05-24 05:00:00	11	40
7377	2026-05-24 05:00:00	15	15
7385	2026-05-24 05:00:00	12	54.13
7399	2026-05-24 05:00:00	13	261
7403	2026-05-24 06:00:00	14	15
7411	2026-05-24 06:00:00	11	40
7420	2026-05-24 06:00:00	15	15
7424	2026-05-24 06:00:00	12	54.08
7433	2026-05-24 06:00:00	13	261
7456	2026-05-24 07:00:00	49	20
7463	2026-05-24 07:00:00	46	40
7471	2026-05-24 07:00:00	50	20
7478	2026-05-24 07:00:00	47	38.47
7484	2026-05-24 07:00:00	48	264
7510	2026-05-24 08:00:00	48	264
7515	2026-05-24 08:00:00	49	20
7526	2026-05-24 08:00:00	46	40
7537	2026-05-24 08:00:00	50	20
7545	2026-05-24 08:00:00	47	38.35
7551	2026-05-24 09:00:00	3	171.6
7565	2026-05-24 09:00:00	4	20
5718	2026-05-22 20:00:00	15	15
5730	2026-05-22 20:00:00	12	54.24
5739	2026-05-22 20:00:00	13	261
5748	2026-05-22 20:00:00	14	15
5752	2026-05-22 21:00:00	6	12
5764	2026-05-22 21:00:00	10	20
5773	2026-05-22 21:00:00	9	20
5783	2026-05-22 21:00:00	8	171.6
5794	2026-05-22 21:00:00	7	24.22
5806	2026-05-22 22:00:00	32	38.4
5812	2026-05-22 22:00:00	34	20
5822	2026-05-22 22:00:00	35	20
5832	2026-05-22 22:00:00	31	40
5841	2026-05-22 22:00:00	33	264
5859	2026-05-22 23:00:00	41	40
5874	2026-05-22 23:00:00	43	264
5884	2026-05-22 23:00:00	45	20
5895	2026-05-22 23:00:00	42	38.31
5899	2026-05-22 23:00:00	44	20
5903	2026-05-23 00:00:00	15	15
5914	2026-05-23 00:00:00	12	54.11
5924	2026-05-23 00:00:00	13	261
5933	2026-05-23 00:00:00	14	15
5944	2026-05-23 00:00:00	11	40
5960	2026-05-23 01:00:00	26	40
5968	2026-05-23 01:00:00	27	38.49
5978	2026-05-23 01:00:00	28	264
5989	2026-05-23 01:00:00	29	20
5999	2026-05-23 01:00:00	30	20
6002	2026-05-23 02:00:00	10	20
6015	2026-05-23 02:00:00	9	20
6028	2026-05-23 02:00:00	8	171.6
6039	2026-05-23 02:00:00	7	24.42
6046	2026-05-23 02:00:00	6	12
6052	2026-05-23 03:00:00	18	264
6066	2026-05-23 03:00:00	17	38.44
6073	2026-05-23 03:00:00	20	20
6080	2026-05-23 03:00:00	16	40
6090	2026-05-23 03:00:00	19	20
6109	2026-05-23 04:00:00	46	40
6118	2026-05-23 04:00:00	50	20
6128	2026-05-23 04:00:00	47	38.35
6139	2026-05-23 04:00:00	48	264
6150	2026-05-23 04:00:00	49	20
6151	2026-05-23 05:00:00	9	20
6161	2026-05-23 05:00:00	8	171.6
6177	2026-05-23 05:00:00	7	24.45
6186	2026-05-23 05:00:00	6	12
6198	2026-05-23 05:00:00	10	20
6203	2026-05-23 06:00:00	15	15
6215	2026-05-23 06:00:00	12	54.21
6224	2026-05-23 06:00:00	13	261
6238	2026-05-23 06:00:00	14	15
6245	2026-05-23 06:00:00	11	40
6259	2026-05-23 07:00:00	39	20
6270	2026-05-23 07:00:00	36	40
6279	2026-05-23 07:00:00	38	264
6289	2026-05-23 07:00:00	40	20
6299	2026-05-23 07:00:00	37	38.39
6302	2026-05-23 08:00:00	9	20
6313	2026-05-23 08:00:00	8	171.6
6323	2026-05-23 08:00:00	7	24.44
6336	2026-05-23 08:00:00	6	12
6347	2026-05-23 08:00:00	10	20
6354	2026-05-23 09:00:00	16	40
6365	2026-05-23 09:00:00	19	20
6376	2026-05-23 09:00:00	18	264
6386	2026-05-23 09:00:00	17	38.38
6394	2026-05-23 09:00:00	20	20
6406	2026-05-23 10:00:00	29	20
6413	2026-05-23 10:00:00	30	20
6426	2026-05-23 10:00:00	26	40
6435	2026-05-23 10:00:00	27	38.39
6444	2026-05-23 10:00:00	28	264
6454	2026-05-23 11:00:00	21	40
6465	2026-05-23 11:00:00	24	20
6470	2026-05-23 11:00:00	25	20
6482	2026-05-23 11:00:00	22	38.45
6492	2026-05-23 11:00:00	23	264
6510	2026-05-23 12:00:00	39	20
6519	2026-05-23 12:00:00	36	92
6530	2026-05-23 12:00:00	38	435.6
6540	2026-05-23 12:00:00	40	20
6549	2026-05-23 12:00:00	37	64.43
6551	2026-05-23 13:00:00	2	24.21
6563	2026-05-23 13:00:00	5	20
6573	2026-05-23 13:00:00	1	12
6583	2026-05-23 13:00:00	3	171.6
6593	2026-05-23 13:00:00	4	20
6606	2026-05-23 14:00:00	38	264
6614	2026-05-23 14:00:00	40	20
6621	2026-05-23 14:00:00	37	38.22
6628	2026-05-23 14:00:00	39	20
6636	2026-05-23 14:00:00	36	40
6660	2026-05-23 15:00:00	46	40
6670	2026-05-23 15:00:00	50	20
6680	2026-05-23 15:00:00	47	38.35
6689	2026-05-23 15:00:00	48	264
6699	2026-05-23 15:00:00	49	20
7205	2026-05-24 02:00:00	28	264
7215	2026-05-24 02:00:00	29	20
7222	2026-05-24 02:00:00	30	20
7232	2026-05-24 02:00:00	26	40
7241	2026-05-24 02:00:00	27	38.38
7259	2026-05-24 03:00:00	49	20
7261	2026-05-24 03:00:00	46	40
7274	2026-05-24 03:00:00	50	20
7284	2026-05-24 03:00:00	47	38.22
7293	2026-05-24 03:00:00	48	264
7308	2026-05-24 04:00:00	38	264
7320	2026-05-24 04:00:00	40	20
7330	2026-05-24 04:00:00	37	38.35
7337	2026-05-24 04:00:00	39	20
7346	2026-05-24 04:00:00	36	40
7352	2026-05-24 05:00:00	9	20
7363	2026-05-24 05:00:00	8	171.6
7374	2026-05-24 05:00:00	7	24.27
7384	2026-05-24 05:00:00	6	12
7397	2026-05-24 05:00:00	10	20
7407	2026-05-24 06:00:00	28	264
7414	2026-05-24 06:00:00	29	20
7422	2026-05-24 06:00:00	30	20
7428	2026-05-24 06:00:00	26	40
7438	2026-05-24 06:00:00	27	38.29
7459	2026-05-24 07:00:00	42	38.41
7470	2026-05-24 07:00:00	44	20
7483	2026-05-24 07:00:00	41	40
7493	2026-05-24 07:00:00	43	264
7500	2026-05-24 07:00:00	45	20
7501	2026-05-24 08:00:00	3	171.6
7516	2026-05-24 08:00:00	4	20
7525	2026-05-24 08:00:00	2	24.42
7534	2026-05-24 08:00:00	5	20
7539	2026-05-24 08:00:00	1	12
7559	2026-05-24 09:00:00	42	38.24
7563	2026-05-24 09:00:00	44	20
5719	2026-05-22 20:00:00	10	20
5731	2026-05-22 20:00:00	9	20
5741	2026-05-22 20:00:00	8	171.6
5750	2026-05-22 20:00:00	7	24.26
5755	2026-05-22 21:00:00	12	54.23
5765	2026-05-22 21:00:00	13	261
5775	2026-05-22 21:00:00	14	15
5784	2026-05-22 21:00:00	11	40
5791	2026-05-22 21:00:00	15	15
5805	2026-05-22 22:00:00	29	20
5819	2026-05-22 22:00:00	30	20
5831	2026-05-22 22:00:00	26	40
5842	2026-05-22 22:00:00	27	38.36
5850	2026-05-22 22:00:00	28	264
5851	2026-05-22 23:00:00	5	20
5865	2026-05-22 23:00:00	1	12
5875	2026-05-22 23:00:00	3	171.6
5887	2026-05-22 23:00:00	4	20
5898	2026-05-22 23:00:00	2	24.27
5901	2026-05-23 00:00:00	6	12
5913	2026-05-23 00:00:00	10	20
5923	2026-05-23 00:00:00	9	20
5936	2026-05-23 00:00:00	8	171.6
5948	2026-05-23 00:00:00	7	24.27
5953	2026-05-23 01:00:00	16	40
5966	2026-05-23 01:00:00	19	20
5979	2026-05-23 01:00:00	18	264
5985	2026-05-23 01:00:00	17	38.32
5993	2026-05-23 01:00:00	20	20
6010	2026-05-23 02:00:00	44	20
6020	2026-05-23 02:00:00	41	40
6032	2026-05-23 02:00:00	43	264
6040	2026-05-23 02:00:00	45	20
6049	2026-05-23 02:00:00	42	38.24
6051	2026-05-23 03:00:00	1	12
6062	2026-05-23 03:00:00	3	171.6
6072	2026-05-23 03:00:00	4	20
6083	2026-05-23 03:00:00	2	24.22
6093	2026-05-23 03:00:00	5	20
6108	2026-05-23 04:00:00	40	20
6114	2026-05-23 04:00:00	37	38.21
6123	2026-05-23 04:00:00	39	20
6133	2026-05-23 04:00:00	36	40
6145	2026-05-23 04:00:00	38	264
6156	2026-05-23 05:00:00	28	264
6165	2026-05-23 05:00:00	29	20
6172	2026-05-23 05:00:00	30	20
6182	2026-05-23 05:00:00	26	40
6190	2026-05-23 05:00:00	27	38.31
6209	2026-05-23 06:00:00	50	20
6211	2026-05-23 06:00:00	47	38.45
6223	2026-05-23 06:00:00	48	264
6236	2026-05-23 06:00:00	49	20
6247	2026-05-23 06:00:00	46	40
6256	2026-05-23 07:00:00	24	20
6261	2026-05-23 07:00:00	25	20
6271	2026-05-23 07:00:00	22	38.25
6280	2026-05-23 07:00:00	23	264
6290	2026-05-23 07:00:00	21	40
6310	2026-05-23 08:00:00	49	20
6319	2026-05-23 08:00:00	46	40
6327	2026-05-23 08:00:00	50	20
6338	2026-05-23 08:00:00	47	38.31
6348	2026-05-23 08:00:00	48	264
6353	2026-05-23 09:00:00	12	54.26
6367	2026-05-23 09:00:00	13	261
6381	2026-05-23 09:00:00	14	15
6392	2026-05-23 09:00:00	11	40
6399	2026-05-23 09:00:00	15	15
6403	2026-05-23 10:00:00	6	12
6420	2026-05-23 10:00:00	10	20
6429	2026-05-23 10:00:00	9	20
6440	2026-05-23 10:00:00	8	171.6
6449	2026-05-23 10:00:00	7	24.26
6451	2026-05-23 11:00:00	4	20
6459	2026-05-23 11:00:00	2	24.32
6469	2026-05-23 11:00:00	5	20
6477	2026-05-23 11:00:00	1	12
6486	2026-05-23 11:00:00	3	171.6
6508	2026-05-23 12:00:00	48	435.6
6514	2026-05-23 12:00:00	49	20
6522	2026-05-23 12:00:00	46	92
6529	2026-05-23 12:00:00	50	20
6539	2026-05-23 12:00:00	47	64.22
6559	2026-05-23 13:00:00	50	20
6561	2026-05-23 13:00:00	47	38.28
6572	2026-05-23 13:00:00	48	264
6582	2026-05-23 13:00:00	49	20
6591	2026-05-23 13:00:00	46	40
6610	2026-05-23 14:00:00	41	40
6620	2026-05-23 14:00:00	43	264
6631	2026-05-23 14:00:00	45	20
6644	2026-05-23 14:00:00	42	38.42
6650	2026-05-23 14:00:00	44	20
6651	2026-05-23 15:00:00	2	24.35
6663	2026-05-23 15:00:00	5	20
6675	2026-05-23 15:00:00	1	12
6687	2026-05-23 15:00:00	3	171.6
6694	2026-05-23 15:00:00	4	20
7207	2026-05-24 02:00:00	37	38.49
7217	2026-05-24 02:00:00	39	20
7229	2026-05-24 02:00:00	36	40
7240	2026-05-24 02:00:00	38	264
7250	2026-05-24 02:00:00	40	20
7251	2026-05-24 03:00:00	1	12
7264	2026-05-24 03:00:00	3	171.6
7273	2026-05-24 03:00:00	4	20
7285	2026-05-24 03:00:00	2	24.3
7294	2026-05-24 03:00:00	5	20
7305	2026-05-24 04:00:00	28	264
7315	2026-05-24 04:00:00	29	20
7325	2026-05-24 04:00:00	30	20
7332	2026-05-24 04:00:00	26	40
7342	2026-05-24 04:00:00	27	38.47
7359	2026-05-24 05:00:00	45	20
7370	2026-05-24 05:00:00	42	38.34
7378	2026-05-24 05:00:00	44	20
7389	2026-05-24 05:00:00	41	40
7394	2026-05-24 05:00:00	43	264
7406	2026-05-24 06:00:00	34	20
7418	2026-05-24 06:00:00	35	20
7431	2026-05-24 06:00:00	31	40
7441	2026-05-24 06:00:00	33	264
7449	2026-05-24 06:00:00	32	38.26
7452	2026-05-24 07:00:00	8	171.6
7467	2026-05-24 07:00:00	7	24.28
7476	2026-05-24 07:00:00	6	12
7488	2026-05-24 07:00:00	10	20
7497	2026-05-24 07:00:00	9	20
7508	2026-05-24 08:00:00	34	20
7513	2026-05-24 08:00:00	35	20
7522	2026-05-24 08:00:00	31	40
7532	2026-05-24 08:00:00	33	264
7542	2026-05-24 08:00:00	32	38.49
7558	2026-05-24 09:00:00	38	264
7564	2026-05-24 09:00:00	40	20
5720	2026-05-22 20:00:00	33	264
5728	2026-05-22 20:00:00	32	38.38
5740	2026-05-22 20:00:00	34	20
5756	2026-05-22 21:00:00	46	40
5767	2026-05-22 21:00:00	50	20
5778	2026-05-22 21:00:00	47	38.33
5787	2026-05-22 21:00:00	48	264
5792	2026-05-22 21:00:00	49	20
5807	2026-05-22 22:00:00	45	20
5815	2026-05-22 22:00:00	42	38.23
5824	2026-05-22 22:00:00	44	20
5835	2026-05-22 22:00:00	41	40
5844	2026-05-22 22:00:00	43	264
5858	2026-05-22 23:00:00	33	264
5862	2026-05-22 23:00:00	32	38.36
5870	2026-05-22 23:00:00	34	20
5883	2026-05-22 23:00:00	35	20
5889	2026-05-22 23:00:00	31	40
5905	2026-05-23 00:00:00	42	38.25
5915	2026-05-23 00:00:00	44	20
5925	2026-05-23 00:00:00	41	40
5935	2026-05-23 00:00:00	43	264
5946	2026-05-23 00:00:00	45	20
5956	2026-05-23 01:00:00	33	264
5964	2026-05-23 01:00:00	32	38.3
5976	2026-05-23 01:00:00	34	20
5986	2026-05-23 01:00:00	35	20
5996	2026-05-23 01:00:00	31	40
6003	2026-05-23 02:00:00	12	54.19
6011	2026-05-23 02:00:00	13	261
6021	2026-05-23 02:00:00	14	15
6024	2026-05-23 02:00:00	11	40
6033	2026-05-23 02:00:00	15	15
6060	2026-05-23 03:00:00	46	40
6070	2026-05-23 03:00:00	50	20
6081	2026-05-23 03:00:00	47	38.2
6091	2026-05-23 03:00:00	48	264
6100	2026-05-23 03:00:00	49	20
6101	2026-05-23 04:00:00	5	20
6111	2026-05-23 04:00:00	1	12
6124	2026-05-23 04:00:00	3	171.6
6134	2026-05-23 04:00:00	4	20
6141	2026-05-23 04:00:00	2	24.36
6160	2026-05-23 05:00:00	46	40
6170	2026-05-23 05:00:00	50	20
6173	2026-05-23 05:00:00	47	38.33
6183	2026-05-23 05:00:00	48	264
6194	2026-05-23 05:00:00	49	20
6205	2026-05-23 06:00:00	17	38.2
6217	2026-05-23 06:00:00	20	20
6226	2026-05-23 06:00:00	16	40
6233	2026-05-23 06:00:00	19	20
6243	2026-05-23 06:00:00	18	264
6258	2026-05-23 07:00:00	31	40
6268	2026-05-23 07:00:00	33	264
6277	2026-05-23 07:00:00	32	38.28
6282	2026-05-23 07:00:00	34	20
6294	2026-05-23 07:00:00	35	20
6308	2026-05-23 08:00:00	32	38.41
6314	2026-05-23 08:00:00	34	20
6324	2026-05-23 08:00:00	35	20
6332	2026-05-23 08:00:00	31	40
6342	2026-05-23 08:00:00	33	264
6356	2026-05-23 09:00:00	33	264
6369	2026-05-23 09:00:00	32	38.2
6382	2026-05-23 09:00:00	34	20
6391	2026-05-23 09:00:00	35	20
6398	2026-05-23 09:00:00	31	40
6402	2026-05-23 10:00:00	16	40
6414	2026-05-23 10:00:00	19	20
6427	2026-05-23 10:00:00	18	264
6437	2026-05-23 10:00:00	17	38.23
6447	2026-05-23 10:00:00	20	20
6453	2026-05-23 11:00:00	19	20
6463	2026-05-23 11:00:00	18	264
6475	2026-05-23 11:00:00	17	38.4
6489	2026-05-23 11:00:00	20	20
6498	2026-05-23 11:00:00	16	40
6502	2026-05-23 12:00:00	9	20
6512	2026-05-23 12:00:00	8	171.6
6526	2026-05-23 12:00:00	7	24.35
6537	2026-05-23 12:00:00	6	12
6545	2026-05-23 12:00:00	10	20
6557	2026-05-23 13:00:00	33	264
6570	2026-05-23 13:00:00	32	38.35
6579	2026-05-23 13:00:00	34	20
6590	2026-05-23 13:00:00	35	20
6599	2026-05-23 13:00:00	31	40
6604	2026-05-23 14:00:00	18	264
6619	2026-05-23 14:00:00	17	38.27
6630	2026-05-23 14:00:00	20	20
6642	2026-05-23 14:00:00	16	40
6649	2026-05-23 14:00:00	19	20
6655	2026-05-23 15:00:00	7	24.37
6664	2026-05-23 15:00:00	6	12
6672	2026-05-23 15:00:00	10	20
6682	2026-05-23 15:00:00	9	20
6692	2026-05-23 15:00:00	8	171.6
7208	2026-05-24 02:00:00	44	20
7218	2026-05-24 02:00:00	41	40
7230	2026-05-24 02:00:00	43	264
7239	2026-05-24 02:00:00	45	20
7249	2026-05-24 02:00:00	42	38.2
7254	2026-05-24 03:00:00	19	20
7267	2026-05-24 03:00:00	18	264
7276	2026-05-24 03:00:00	17	38.29
7289	2026-05-24 03:00:00	20	20
7296	2026-05-24 03:00:00	16	40
7303	2026-05-24 04:00:00	20	20
7316	2026-05-24 04:00:00	16	40
7327	2026-05-24 04:00:00	19	20
7336	2026-05-24 04:00:00	18	264
7343	2026-05-24 04:00:00	17	38.27
7358	2026-05-24 05:00:00	21	40
7369	2026-05-24 05:00:00	24	20
7380	2026-05-24 05:00:00	25	20
7391	2026-05-24 05:00:00	22	38.25
7400	2026-05-24 05:00:00	23	264
7401	2026-05-24 06:00:00	4	20
7415	2026-05-24 06:00:00	2	24.39
7427	2026-05-24 06:00:00	5	20
7435	2026-05-24 06:00:00	1	12
7444	2026-05-24 06:00:00	3	171.6
7458	2026-05-24 07:00:00	35	20
7465	2026-05-24 07:00:00	31	40
7473	2026-05-24 07:00:00	33	264
7480	2026-05-24 07:00:00	32	38.25
7489	2026-05-24 07:00:00	34	20
7509	2026-05-24 08:00:00	41	40
7514	2026-05-24 08:00:00	43	264
7524	2026-05-24 08:00:00	45	20
7541	2026-05-24 08:00:00	42	38.36
7548	2026-05-24 08:00:00	44	20
7555	2026-05-24 09:00:00	27	38.28
7562	2026-05-24 09:00:00	28	264
7576	2026-05-24 09:00:00	29	20
5721	2026-05-22 20:00:00	50	20
5726	2026-05-22 20:00:00	47	38.26
5737	2026-05-22 20:00:00	48	264
5746	2026-05-22 20:00:00	49	20
5754	2026-05-22 21:00:00	19	20
5768	2026-05-22 21:00:00	18	264
5779	2026-05-22 21:00:00	17	38.3
5788	2026-05-22 21:00:00	20	20
5796	2026-05-22 21:00:00	16	40
5808	2026-05-22 22:00:00	23	264
5814	2026-05-22 22:00:00	21	40
5825	2026-05-22 22:00:00	24	20
5836	2026-05-22 22:00:00	25	20
5845	2026-05-22 22:00:00	22	38.29
5854	2026-05-22 23:00:00	25	20
5864	2026-05-22 23:00:00	22	38.44
5872	2026-05-22 23:00:00	23	264
5880	2026-05-22 23:00:00	21	40
5891	2026-05-22 23:00:00	24	20
5907	2026-05-23 00:00:00	26	40
5911	2026-05-23 00:00:00	27	38.46
5921	2026-05-23 00:00:00	28	264
5926	2026-05-23 00:00:00	29	20
5934	2026-05-23 00:00:00	30	20
5955	2026-05-23 01:00:00	50	20
5963	2026-05-23 01:00:00	47	38.29
5971	2026-05-23 01:00:00	48	264
5981	2026-05-23 01:00:00	49	20
5991	2026-05-23 01:00:00	46	40
6005	2026-05-23 02:00:00	36	40
6013	2026-05-23 02:00:00	38	264
6023	2026-05-23 02:00:00	40	20
6035	2026-05-23 02:00:00	37	38.4
6044	2026-05-23 02:00:00	39	20
6057	2026-05-23 03:00:00	37	38.4
6069	2026-05-23 03:00:00	39	20
6077	2026-05-23 03:00:00	36	40
6084	2026-05-23 03:00:00	38	264
6094	2026-05-23 03:00:00	40	20
6105	2026-05-23 04:00:00	21	40
6117	2026-05-23 04:00:00	24	20
6125	2026-05-23 04:00:00	25	20
6136	2026-05-23 04:00:00	22	38.23
6142	2026-05-23 04:00:00	23	264
6157	2026-05-23 05:00:00	41	40
6166	2026-05-23 05:00:00	43	264
6171	2026-05-23 05:00:00	45	20
6181	2026-05-23 05:00:00	42	38.33
6189	2026-05-23 05:00:00	44	20
6210	2026-05-23 06:00:00	45	20
6216	2026-05-23 06:00:00	42	38.42
6230	2026-05-23 06:00:00	44	20
6241	2026-05-23 06:00:00	41	40
6250	2026-05-23 06:00:00	43	264
6251	2026-05-23 07:00:00	3	171.6
6262	2026-05-23 07:00:00	4	20
6273	2026-05-23 07:00:00	2	24.27
6287	2026-05-23 07:00:00	5	20
6297	2026-05-23 07:00:00	1	12
6303	2026-05-23 08:00:00	14	15
6320	2026-05-23 08:00:00	11	40
6330	2026-05-23 08:00:00	15	15
6341	2026-05-23 08:00:00	12	54.27
6349	2026-05-23 08:00:00	13	261
6352	2026-05-23 09:00:00	6	12
6366	2026-05-23 09:00:00	10	20
6377	2026-05-23 09:00:00	9	20
6385	2026-05-23 09:00:00	8	171.6
6396	2026-05-23 09:00:00	7	24.3
6407	2026-05-23 10:00:00	31	40
6418	2026-05-23 10:00:00	33	264
6422	2026-05-23 10:00:00	32	38.46
6432	2026-05-23 10:00:00	34	20
6443	2026-05-23 10:00:00	35	20
6456	2026-05-23 11:00:00	31	40
6464	2026-05-23 11:00:00	33	264
6474	2026-05-23 11:00:00	32	38.33
6485	2026-05-23 11:00:00	34	20
6496	2026-05-23 11:00:00	35	20
6503	2026-05-23 12:00:00	25	20
6515	2026-05-23 12:00:00	22	64.41
6524	2026-05-23 12:00:00	23	435.6
6532	2026-05-23 12:00:00	21	92
6543	2026-05-23 12:00:00	24	20
6555	2026-05-23 13:00:00	17	38.39
6568	2026-05-23 13:00:00	20	20
6576	2026-05-23 13:00:00	16	40
6584	2026-05-23 13:00:00	19	20
6594	2026-05-23 13:00:00	18	264
6608	2026-05-23 14:00:00	35	20
6617	2026-05-23 14:00:00	31	40
6625	2026-05-23 14:00:00	33	264
6632	2026-05-23 14:00:00	32	38.19
6639	2026-05-23 14:00:00	34	20
6659	2026-05-23 15:00:00	41	40
6667	2026-05-23 15:00:00	43	264
6677	2026-05-23 15:00:00	45	20
6683	2026-05-23 15:00:00	42	38.23
6693	2026-05-23 15:00:00	44	20
7209	2026-05-24 02:00:00	47	38.39
7213	2026-05-24 02:00:00	48	264
7224	2026-05-24 02:00:00	49	20
7234	2026-05-24 02:00:00	46	40
7243	2026-05-24 02:00:00	50	20
7257	2026-05-24 03:00:00	32	38.21
7263	2026-05-24 03:00:00	34	20
7277	2026-05-24 03:00:00	35	20
7290	2026-05-24 03:00:00	31	40
7297	2026-05-24 03:00:00	33	264
7306	2026-05-24 04:00:00	24	20
7318	2026-05-24 04:00:00	25	20
7329	2026-05-24 04:00:00	22	38.33
7338	2026-05-24 04:00:00	23	264
7347	2026-05-24 04:00:00	21	40
7356	2026-05-24 05:00:00	34	20
7366	2026-05-24 05:00:00	35	20
7372	2026-05-24 05:00:00	31	40
7382	2026-05-24 05:00:00	33	264
7392	2026-05-24 05:00:00	32	38.44
7405	2026-05-24 06:00:00	17	38.4
7412	2026-05-24 06:00:00	20	20
7423	2026-05-24 06:00:00	16	40
7429	2026-05-24 06:00:00	19	20
7439	2026-05-24 06:00:00	18	264
7460	2026-05-24 07:00:00	38	264
7469	2026-05-24 07:00:00	40	20
7482	2026-05-24 07:00:00	37	38.24
7491	2026-05-24 07:00:00	39	20
7498	2026-05-24 07:00:00	36	40
7504	2026-05-24 08:00:00	17	38.36
7519	2026-05-24 08:00:00	20	20
7530	2026-05-24 08:00:00	16	40
7540	2026-05-24 08:00:00	19	20
7550	2026-05-24 08:00:00	18	264
7553	2026-05-24 09:00:00	13	261
7566	2026-05-24 09:00:00	14	15
5723	2026-05-22 20:00:00	39	20
5733	2026-05-22 20:00:00	36	40
5743	2026-05-22 20:00:00	38	264
5760	2026-05-22 21:00:00	37	38.47
5770	2026-05-22 21:00:00	39	20
5774	2026-05-22 21:00:00	36	40
5782	2026-05-22 21:00:00	38	264
5797	2026-05-22 21:00:00	40	20
5802	2026-05-22 22:00:00	14	15
5817	2026-05-22 22:00:00	11	40
5829	2026-05-22 22:00:00	15	15
5840	2026-05-22 22:00:00	12	54.19
5849	2026-05-22 22:00:00	13	261
5852	2026-05-22 23:00:00	6	12
5863	2026-05-22 23:00:00	10	20
5871	2026-05-22 23:00:00	9	20
5876	2026-05-22 23:00:00	8	171.6
5885	2026-05-22 23:00:00	7	24.39
5908	2026-05-23 00:00:00	50	20
5918	2026-05-23 00:00:00	47	38.49
5930	2026-05-23 00:00:00	48	264
5941	2026-05-23 00:00:00	49	20
5950	2026-05-23 00:00:00	46	40
5952	2026-05-23 01:00:00	4	20
5961	2026-05-23 01:00:00	2	24.29
5972	2026-05-23 01:00:00	5	20
5982	2026-05-23 01:00:00	1	12
5990	2026-05-23 01:00:00	3	171.6
6009	2026-05-23 02:00:00	48	264
6014	2026-05-23 02:00:00	49	20
6026	2026-05-23 02:00:00	46	40
6038	2026-05-23 02:00:00	50	20
6045	2026-05-23 02:00:00	47	38.2
6058	2026-05-23 03:00:00	29	20
6067	2026-05-23 03:00:00	30	20
6078	2026-05-23 03:00:00	26	40
6088	2026-05-23 03:00:00	27	38.31
6099	2026-05-23 03:00:00	28	264
6104	2026-05-23 04:00:00	18	264
6116	2026-05-23 04:00:00	17	38.29
6127	2026-05-23 04:00:00	20	20
6138	2026-05-23 04:00:00	16	40
6148	2026-05-23 04:00:00	19	20
6155	2026-05-23 05:00:00	18	264
6167	2026-05-23 05:00:00	17	38.43
6174	2026-05-23 05:00:00	20	20
6185	2026-05-23 05:00:00	16	40
6196	2026-05-23 05:00:00	19	20
6206	2026-05-23 06:00:00	24	20
6218	2026-05-23 06:00:00	25	20
6228	2026-05-23 06:00:00	22	38.31
6235	2026-05-23 06:00:00	23	264
6246	2026-05-23 06:00:00	21	40
6257	2026-05-23 07:00:00	30	20
6267	2026-05-23 07:00:00	26	40
6281	2026-05-23 07:00:00	27	38.29
6291	2026-05-23 07:00:00	28	264
6300	2026-05-23 07:00:00	29	20
6301	2026-05-23 08:00:00	2	24.44
6312	2026-05-23 08:00:00	5	20
6322	2026-05-23 08:00:00	1	12
6333	2026-05-23 08:00:00	3	171.6
6345	2026-05-23 08:00:00	4	20
6359	2026-05-23 09:00:00	21	40
6363	2026-05-23 09:00:00	24	20
6372	2026-05-23 09:00:00	25	20
6380	2026-05-23 09:00:00	22	38.44
6388	2026-05-23 09:00:00	23	264
6408	2026-05-23 10:00:00	50	20
6412	2026-05-23 10:00:00	47	38.23
6425	2026-05-23 10:00:00	48	264
6434	2026-05-23 10:00:00	49	20
6446	2026-05-23 10:00:00	46	40
6461	2026-05-23 11:00:00	37	38.41
6473	2026-05-23 11:00:00	39	20
6481	2026-05-23 11:00:00	36	40
6491	2026-05-23 11:00:00	38	264
6497	2026-05-23 11:00:00	40	20
6509	2026-05-23 12:00:00	12	80.91
6520	2026-05-23 12:00:00	13	432.6
6531	2026-05-23 12:00:00	14	15
6541	2026-05-23 12:00:00	11	92
6550	2026-05-23 12:00:00	15	15
6552	2026-05-23 13:00:00	6	12
6564	2026-05-23 13:00:00	10	20
6574	2026-05-23 13:00:00	9	20
6586	2026-05-23 13:00:00	8	171.6
6596	2026-05-23 13:00:00	7	24.41
6602	2026-05-23 14:00:00	7	24.33
6612	2026-05-23 14:00:00	6	12
6626	2026-05-23 14:00:00	10	20
6638	2026-05-23 14:00:00	9	20
6646	2026-05-23 14:00:00	8	171.6
6653	2026-05-23 15:00:00	22	38.23
6666	2026-05-23 15:00:00	23	264
6676	2026-05-23 15:00:00	21	40
6684	2026-05-23 15:00:00	24	20
6695	2026-05-23 15:00:00	25	20
6701	2026-05-23 16:00:00	5	20
6702	2026-05-23 16:00:00	17	38.2
6703	2026-05-23 16:00:00	6	12
6706	2026-05-23 16:00:00	23	264
6704	2026-05-23 16:00:00	40	20
6705	2026-05-23 16:00:00	28	264
6708	2026-05-23 16:00:00	43	264
6707	2026-05-23 16:00:00	31	40
6709	2026-05-23 16:00:00	46	40
6710	2026-05-23 16:00:00	14	15
6711	2026-05-23 16:00:00	1	12
6712	2026-05-23 16:00:00	10	20
6713	2026-05-23 16:00:00	37	38.41
6714	2026-05-23 16:00:00	33	264
6715	2026-05-23 16:00:00	20	20
6716	2026-05-23 16:00:00	11	40
6717	2026-05-23 16:00:00	21	40
6718	2026-05-23 16:00:00	50	20
6719	2026-05-23 16:00:00	29	20
6720	2026-05-23 16:00:00	45	20
6721	2026-05-23 16:00:00	32	38.42
6722	2026-05-23 16:00:00	16	40
6723	2026-05-23 16:00:00	15	15
6724	2026-05-23 16:00:00	24	20
6725	2026-05-23 16:00:00	3	171.6
6726	2026-05-23 16:00:00	9	20
6727	2026-05-23 16:00:00	47	38.37
6728	2026-05-23 16:00:00	39	20
6729	2026-05-23 16:00:00	19	20
6730	2026-05-23 16:00:00	30	20
6731	2026-05-23 16:00:00	42	38.38
6732	2026-05-23 16:00:00	4	20
6733	2026-05-23 16:00:00	8	171.6
6734	2026-05-23 16:00:00	12	54.22
6735	2026-05-23 16:00:00	34	20
6736	2026-05-23 16:00:00	25	20
6737	2026-05-23 16:00:00	26	40
6738	2026-05-23 16:00:00	48	264
6739	2026-05-23 16:00:00	36	40
6748	2026-05-23 16:00:00	38	264
6752	2026-05-23 17:00:00	7	24.21
6762	2026-05-23 17:00:00	6	12
6771	2026-05-23 17:00:00	10	20
6781	2026-05-23 17:00:00	9	20
6793	2026-05-23 17:00:00	8	171.6
6810	2026-05-23 18:00:00	47	38.45
6818	2026-05-23 18:00:00	48	264
6826	2026-05-23 18:00:00	49	20
6839	2026-05-23 18:00:00	46	40
6850	2026-05-23 18:00:00	50	20
6851	2026-05-23 19:00:00	1	12
6861	2026-05-23 19:00:00	3	171.6
6873	2026-05-23 19:00:00	4	20
6885	2026-05-23 19:00:00	2	24.24
6895	2026-05-23 19:00:00	5	20
6905	2026-05-23 20:00:00	22	38.28
6914	2026-05-23 20:00:00	23	264
6925	2026-05-23 20:00:00	21	40
6937	2026-05-23 20:00:00	24	20
6946	2026-05-23 20:00:00	25	20
6957	2026-05-23 21:00:00	28	264
6966	2026-05-23 21:00:00	29	20
6977	2026-05-23 21:00:00	30	20
6987	2026-05-23 21:00:00	26	40
6996	2026-05-23 21:00:00	27	38.29
7004	2026-05-23 22:00:00	17	38.34
7015	2026-05-23 22:00:00	20	20
7027	2026-05-23 22:00:00	16	40
7037	2026-05-23 22:00:00	19	20
7047	2026-05-23 22:00:00	18	264
7056	2026-05-23 23:00:00	16	40
7066	2026-05-23 23:00:00	19	20
7072	2026-05-23 23:00:00	18	264
7078	2026-05-23 23:00:00	17	38.39
7091	2026-05-23 23:00:00	20	20
7107	2026-05-24 00:00:00	42	38.37
7113	2026-05-24 00:00:00	44	20
7125	2026-05-24 00:00:00	41	40
7134	2026-05-24 00:00:00	43	264
7143	2026-05-24 00:00:00	45	20
7157	2026-05-24 01:00:00	37	38.29
7168	2026-05-24 01:00:00	39	20
7171	2026-05-24 01:00:00	36	40
7182	2026-05-24 01:00:00	38	264
7193	2026-05-24 01:00:00	40	20
7210	2026-05-24 02:00:00	20	20
7220	2026-05-24 02:00:00	16	40
7227	2026-05-24 02:00:00	19	20
7236	2026-05-24 02:00:00	18	264
7246	2026-05-24 02:00:00	17	38.3
7260	2026-05-24 03:00:00	23	264
7270	2026-05-24 03:00:00	21	40
7281	2026-05-24 03:00:00	24	20
7291	2026-05-24 03:00:00	25	20
7299	2026-05-24 03:00:00	22	38.38
7302	2026-05-24 04:00:00	8	171.6
7313	2026-05-24 04:00:00	7	24.38
7324	2026-05-24 04:00:00	6	12
7335	2026-05-24 04:00:00	10	20
7345	2026-05-24 04:00:00	9	20
7355	2026-05-24 05:00:00	36	40
7368	2026-05-24 05:00:00	38	264
7376	2026-05-24 05:00:00	40	20
7388	2026-05-24 05:00:00	37	38.19
7398	2026-05-24 05:00:00	39	20
7402	2026-05-24 06:00:00	9	20
7416	2026-05-24 06:00:00	8	171.6
7426	2026-05-24 06:00:00	7	24.44
7437	2026-05-24 06:00:00	6	12
7446	2026-05-24 06:00:00	10	20
7455	2026-05-24 07:00:00	24	20
7468	2026-05-24 07:00:00	25	20
7481	2026-05-24 07:00:00	22	38.4
7492	2026-05-24 07:00:00	23	264
7499	2026-05-24 07:00:00	21	40
7502	2026-05-24 08:00:00	10	20
7511	2026-05-24 08:00:00	9	20
7523	2026-05-24 08:00:00	8	171.6
7535	2026-05-24 08:00:00	7	24.42
7543	2026-05-24 08:00:00	6	12
7557	2026-05-24 09:00:00	32	38.4
7570	2026-05-24 09:00:00	34	20
7580	2026-05-24 09:00:00	35	20
7589	2026-05-24 09:00:00	31	40
7598	2026-05-24 09:00:00	33	264
7603	2026-05-24 10:00:00	12	54.13
7616	2026-05-24 10:00:00	13	261
7627	2026-05-24 10:00:00	14	15
7633	2026-05-24 10:00:00	11	40
7644	2026-05-24 10:00:00	15	15
7657	2026-05-24 11:00:00	26	40
7661	2026-05-24 11:00:00	27	38.39
7671	2026-05-24 11:00:00	28	264
7674	2026-05-24 11:00:00	29	20
7688	2026-05-24 11:00:00	30	20
7701	2026-05-24 12:00:00	4	20
7711	2026-05-24 12:00:00	2	24.28
7722	2026-05-24 12:00:00	5	20
7732	2026-05-24 12:00:00	1	12
7744	2026-05-24 12:00:00	3	171.6
7758	2026-05-24 13:00:00	34	20
7768	2026-05-24 13:00:00	35	20
7779	2026-05-24 13:00:00	31	40
7786	2026-05-24 13:00:00	33	264
7796	2026-05-24 13:00:00	32	38.45
7804	2026-05-24 14:00:00	25	20
7812	2026-05-24 14:00:00	22	38.27
7822	2026-05-24 14:00:00	23	264
7831	2026-05-24 14:00:00	21	40
7843	2026-05-24 14:00:00	24	20
7857	2026-05-24 15:00:00	34	20
7864	2026-05-24 15:00:00	35	20
7875	2026-05-24 15:00:00	31	40
7887	2026-05-24 15:00:00	33	264
7897	2026-05-24 15:00:00	32	38.4
7901	2026-05-24 16:00:00	3	171.6
7911	2026-05-24 16:00:00	4	20
7920	2026-05-24 16:00:00	2	24.32
7928	2026-05-24 16:00:00	5	20
7933	2026-05-24 16:00:00	1	12
7959	2026-05-24 17:00:00	50	20
7968	2026-05-24 17:00:00	47	38.47
7979	2026-05-24 17:00:00	48	264
7986	2026-05-24 17:00:00	49	20
7995	2026-05-24 17:00:00	46	40
8006	2026-05-24 18:00:00	23	264
8016	2026-05-24 18:00:00	21	40
8028	2026-05-24 18:00:00	24	20
8035	2026-05-24 18:00:00	25	20
8045	2026-05-24 18:00:00	22	38.4
8057	2026-05-24 19:00:00	30	20
8066	2026-05-24 19:00:00	26	40
8078	2026-05-24 19:00:00	27	38.44
8087	2026-05-24 19:00:00	28	264
6740	2026-05-23 16:00:00	18	264
6760	2026-05-23 17:00:00	50	20
6770	2026-05-23 17:00:00	47	38.48
6773	2026-05-23 17:00:00	48	264
6786	2026-05-23 17:00:00	49	20
6796	2026-05-23 17:00:00	46	40
6804	2026-05-23 18:00:00	25	20
6811	2026-05-23 18:00:00	22	38.43
6824	2026-05-23 18:00:00	23	264
6834	2026-05-23 18:00:00	21	40
6846	2026-05-23 18:00:00	24	20
6853	2026-05-23 19:00:00	20	20
6870	2026-05-23 19:00:00	16	40
6881	2026-05-23 19:00:00	19	20
6892	2026-05-23 19:00:00	18	264
6900	2026-05-23 19:00:00	17	38.44
6902	2026-05-23 20:00:00	5	20
6912	2026-05-23 20:00:00	1	12
6924	2026-05-23 20:00:00	3	171.6
6931	2026-05-23 20:00:00	4	20
6943	2026-05-23 20:00:00	2	24.41
6958	2026-05-23 21:00:00	40	20
6963	2026-05-23 21:00:00	37	38.25
6974	2026-05-23 21:00:00	39	20
6986	2026-05-23 21:00:00	36	40
6993	2026-05-23 21:00:00	38	264
7007	2026-05-23 22:00:00	43	264
7012	2026-05-23 22:00:00	45	20
7022	2026-05-23 22:00:00	42	38.28
7031	2026-05-23 22:00:00	44	20
7041	2026-05-23 22:00:00	41	40
7058	2026-05-23 23:00:00	36	40
7068	2026-05-23 23:00:00	38	264
7081	2026-05-23 23:00:00	40	20
7090	2026-05-23 23:00:00	37	38.28
7099	2026-05-23 23:00:00	39	20
7102	2026-05-24 00:00:00	10	20
7111	2026-05-24 00:00:00	9	20
7121	2026-05-24 00:00:00	8	171.6
7132	2026-05-24 00:00:00	7	24.39
7142	2026-05-24 00:00:00	6	12
7158	2026-05-24 01:00:00	42	38.48
7163	2026-05-24 01:00:00	44	20
7172	2026-05-24 01:00:00	41	40
7181	2026-05-24 01:00:00	43	264
7192	2026-05-24 01:00:00	45	20
7568	2026-05-24 09:00:00	9	20
7572	2026-05-24 09:00:00	8	171.6
7585	2026-05-24 09:00:00	7	24.45
7609	2026-05-24 10:00:00	46	40
7620	2026-05-24 10:00:00	50	20
7630	2026-05-24 10:00:00	47	38.42
7639	2026-05-24 10:00:00	48	264
7646	2026-05-24 10:00:00	49	20
7658	2026-05-24 11:00:00	33	264
7668	2026-05-24 11:00:00	32	38.4
7680	2026-05-24 11:00:00	34	20
7690	2026-05-24 11:00:00	35	20
7699	2026-05-24 11:00:00	31	40
7703	2026-05-24 12:00:00	8	171.6
7702	2026-05-24 12:00:00	14	15
7712	2026-05-24 12:00:00	11	92
7715	2026-05-24 12:00:00	7	24.3
7723	2026-05-24 12:00:00	6	12
7724	2026-05-24 12:00:00	15	15
7733	2026-05-24 12:00:00	10	20
7734	2026-05-24 12:00:00	12	80.95
7742	2026-05-24 12:00:00	9	20
7743	2026-05-24 12:00:00	13	432.6
7754	2026-05-24 13:00:00	41	40
7762	2026-05-24 13:00:00	37	38.26
7766	2026-05-24 13:00:00	43	264
7772	2026-05-24 13:00:00	39	20
7774	2026-05-24 13:00:00	45	20
7783	2026-05-24 13:00:00	36	40
7789	2026-05-24 13:00:00	42	38.47
7792	2026-05-24 13:00:00	38	264
7797	2026-05-24 13:00:00	44	20
7799	2026-05-24 13:00:00	40	20
7801	2026-05-24 14:00:00	10	20
7807	2026-05-24 14:00:00	19	20
7813	2026-05-24 14:00:00	18	264
7816	2026-05-24 14:00:00	9	20
7823	2026-05-24 14:00:00	17	38.43
7827	2026-05-24 14:00:00	8	171.6
7833	2026-05-24 14:00:00	20	20
7835	2026-05-24 14:00:00	7	24.26
7842	2026-05-24 14:00:00	16	40
7845	2026-05-24 14:00:00	6	12
7855	2026-05-24 15:00:00	28	264
7859	2026-05-24 15:00:00	45	20
7866	2026-05-24 15:00:00	42	38.27
7868	2026-05-24 15:00:00	29	20
7877	2026-05-24 15:00:00	44	20
7879	2026-05-24 15:00:00	30	20
7884	2026-05-24 15:00:00	41	40
7886	2026-05-24 15:00:00	26	40
7893	2026-05-24 15:00:00	43	264
7894	2026-05-24 15:00:00	27	38.41
7907	2026-05-24 16:00:00	34	20
7908	2026-05-24 16:00:00	40	20
7914	2026-05-24 16:00:00	37	38.44
7916	2026-05-24 16:00:00	35	20
7924	2026-05-24 16:00:00	39	20
7926	2026-05-24 16:00:00	31	40
7936	2026-05-24 16:00:00	36	40
7937	2026-05-24 16:00:00	33	264
7943	2026-05-24 16:00:00	32	38.39
7945	2026-05-24 16:00:00	38	264
7957	2026-05-24 17:00:00	37	38.29
7960	2026-05-24 17:00:00	29	20
7965	2026-05-24 17:00:00	39	20
7970	2026-05-24 17:00:00	30	20
7974	2026-05-24 17:00:00	36	40
7980	2026-05-24 17:00:00	26	40
7985	2026-05-24 17:00:00	38	264
7992	2026-05-24 17:00:00	27	38.47
7993	2026-05-24 17:00:00	40	20
8000	2026-05-24 17:00:00	28	264
8001	2026-05-24 18:00:00	5	20
8010	2026-05-24 18:00:00	36	40
8012	2026-05-24 18:00:00	1	12
8018	2026-05-24 18:00:00	38	264
8023	2026-05-24 18:00:00	3	171.6
8030	2026-05-24 18:00:00	40	20
8032	2026-05-24 18:00:00	4	20
8043	2026-05-24 18:00:00	37	38.34
8044	2026-05-24 18:00:00	2	24.4
8050	2026-05-24 18:00:00	39	20
8051	2026-05-24 19:00:00	2	24.34
8054	2026-05-24 19:00:00	33	264
8062	2026-05-24 19:00:00	5	20
8070	2026-05-24 19:00:00	32	38.49
8071	2026-05-24 19:00:00	1	12
8076	2026-05-24 19:00:00	3	171.6
8084	2026-05-24 19:00:00	34	20
6741	2026-05-23 16:00:00	7	24.49
6757	2026-05-23 17:00:00	43	264
6768	2026-05-23 17:00:00	45	20
6780	2026-05-23 17:00:00	42	38.27
6787	2026-05-23 17:00:00	44	20
6797	2026-05-23 17:00:00	41	40
6803	2026-05-23 18:00:00	15	15
6816	2026-05-23 18:00:00	12	54.18
6827	2026-05-23 18:00:00	13	261
6838	2026-05-23 18:00:00	14	15
6847	2026-05-23 18:00:00	11	40
6854	2026-05-23 19:00:00	14	15
6865	2026-05-23 19:00:00	11	40
6879	2026-05-23 19:00:00	15	15
6891	2026-05-23 19:00:00	12	54.21
6898	2026-05-23 19:00:00	13	261
6903	2026-05-23 20:00:00	18	264
6915	2026-05-23 20:00:00	17	38.3
6927	2026-05-23 20:00:00	20	20
6936	2026-05-23 20:00:00	16	40
6947	2026-05-23 20:00:00	19	20
6951	2026-05-23 21:00:00	8	171.6
6961	2026-05-23 21:00:00	7	24.23
6971	2026-05-23 21:00:00	6	12
6981	2026-05-23 21:00:00	10	20
6991	2026-05-23 21:00:00	9	20
7010	2026-05-23 22:00:00	46	40
7020	2026-05-23 22:00:00	50	20
7030	2026-05-23 22:00:00	47	38.34
7040	2026-05-23 22:00:00	48	264
7048	2026-05-23 22:00:00	49	20
7051	2026-05-23 23:00:00	2	24.22
7062	2026-05-23 23:00:00	5	20
7074	2026-05-23 23:00:00	1	12
7085	2026-05-23 23:00:00	3	171.6
7095	2026-05-23 23:00:00	4	20
7105	2026-05-24 00:00:00	28	264
7117	2026-05-24 00:00:00	29	20
7128	2026-05-24 00:00:00	30	20
7139	2026-05-24 00:00:00	26	40
7149	2026-05-24 00:00:00	27	38.32
7153	2026-05-24 01:00:00	10	20
7164	2026-05-24 01:00:00	9	20
7176	2026-05-24 01:00:00	8	171.6
7184	2026-05-24 01:00:00	7	24.42
7195	2026-05-24 01:00:00	6	12
7573	2026-05-24 09:00:00	11	40
7584	2026-05-24 09:00:00	15	15
7594	2026-05-24 09:00:00	12	54.17
7608	2026-05-24 10:00:00	33	264
7621	2026-05-24 10:00:00	32	38.34
7631	2026-05-24 10:00:00	34	20
7642	2026-05-24 10:00:00	35	20
7650	2026-05-24 10:00:00	31	40
7652	2026-05-24 11:00:00	9	20
7665	2026-05-24 11:00:00	8	171.6
7678	2026-05-24 11:00:00	7	24.48
7686	2026-05-24 11:00:00	6	12
7697	2026-05-24 11:00:00	10	20
7704	2026-05-24 12:00:00	18	435.6
7705	2026-05-24 12:00:00	32	64.22
7714	2026-05-24 12:00:00	17	64.34
7716	2026-05-24 12:00:00	34	20
7725	2026-05-24 12:00:00	35	20
7726	2026-05-24 12:00:00	20	20
7735	2026-05-24 12:00:00	31	92
7736	2026-05-24 12:00:00	16	92
7745	2026-05-24 12:00:00	33	435.6
7749	2026-05-24 12:00:00	19	20
7752	2026-05-24 13:00:00	7	24.22
7756	2026-05-24 13:00:00	29	20
7765	2026-05-24 13:00:00	30	20
7767	2026-05-24 13:00:00	6	12
7773	2026-05-24 13:00:00	26	40
7780	2026-05-24 13:00:00	10	20
7782	2026-05-24 13:00:00	27	38.27
7790	2026-05-24 13:00:00	9	20
7793	2026-05-24 13:00:00	28	264
7798	2026-05-24 13:00:00	8	171.6
7803	2026-05-24 14:00:00	11	40
7808	2026-05-24 14:00:00	39	20
7815	2026-05-24 14:00:00	15	15
7818	2026-05-24 14:00:00	36	40
7826	2026-05-24 14:00:00	12	54.21
7830	2026-05-24 14:00:00	38	264
7836	2026-05-24 14:00:00	13	261
7840	2026-05-24 14:00:00	40	20
7846	2026-05-24 14:00:00	14	15
7850	2026-05-24 14:00:00	37	38.25
7852	2026-05-24 15:00:00	6	12
7856	2026-05-24 15:00:00	24	20
7863	2026-05-24 15:00:00	10	20
7872	2026-05-24 15:00:00	25	20
7873	2026-05-24 15:00:00	9	20
7882	2026-05-24 15:00:00	22	38.21
7883	2026-05-24 15:00:00	8	171.6
7889	2026-05-24 15:00:00	23	264
7896	2026-05-24 15:00:00	7	24.29
7899	2026-05-24 15:00:00	21	40
7905	2026-05-24 16:00:00	24	20
7903	2026-05-24 16:00:00	13	261
7918	2026-05-24 16:00:00	14	15
7919	2026-05-24 16:00:00	25	20
7930	2026-05-24 16:00:00	22	38.36
7932	2026-05-24 16:00:00	11	40
7941	2026-05-24 16:00:00	23	264
7942	2026-05-24 16:00:00	15	15
7949	2026-05-24 16:00:00	12	54.18
7950	2026-05-24 16:00:00	21	40
7951	2026-05-24 17:00:00	4	20
7953	2026-05-24 17:00:00	14	15
7961	2026-05-24 17:00:00	2	24.49
7963	2026-05-24 17:00:00	11	40
7971	2026-05-24 17:00:00	15	15
7975	2026-05-24 17:00:00	5	20
7981	2026-05-24 17:00:00	12	54.07
7989	2026-05-24 17:00:00	1	12
7990	2026-05-24 17:00:00	13	261
7998	2026-05-24 17:00:00	3	171.6
8004	2026-05-24 18:00:00	12	54.08
8009	2026-05-24 18:00:00	48	264
8017	2026-05-24 18:00:00	13	261
8019	2026-05-24 18:00:00	49	20
8025	2026-05-24 18:00:00	14	15
8029	2026-05-24 18:00:00	46	40
8038	2026-05-24 18:00:00	11	40
8042	2026-05-24 18:00:00	50	20
8047	2026-05-24 18:00:00	15	15
8049	2026-05-24 18:00:00	47	38.29
8052	2026-05-24 19:00:00	8	171.6
8056	2026-05-24 19:00:00	17	38.23
8067	2026-05-24 19:00:00	20	20
8069	2026-05-24 19:00:00	7	24.25
8079	2026-05-24 19:00:00	16	40
8082	2026-05-24 19:00:00	6	12
8090	2026-05-24 19:00:00	10	20
6742	2026-05-23 16:00:00	2	24.25
6759	2026-05-23 17:00:00	37	38.46
6763	2026-05-23 17:00:00	39	20
6774	2026-05-23 17:00:00	36	40
6785	2026-05-23 17:00:00	38	264
6795	2026-05-23 17:00:00	40	20
6807	2026-05-23 18:00:00	30	20
6814	2026-05-23 18:00:00	26	40
6825	2026-05-23 18:00:00	27	38.45
6835	2026-05-23 18:00:00	28	264
6848	2026-05-23 18:00:00	29	20
6856	2026-05-23 19:00:00	21	40
6864	2026-05-23 19:00:00	24	20
6878	2026-05-23 19:00:00	25	20
6890	2026-05-23 19:00:00	22	38.44
6899	2026-05-23 19:00:00	23	264
6901	2026-05-23 20:00:00	8	171.6
6911	2026-05-23 20:00:00	7	24.21
6922	2026-05-23 20:00:00	6	12
6932	2026-05-23 20:00:00	10	20
6942	2026-05-23 20:00:00	9	20
6960	2026-05-23 21:00:00	43	264
6970	2026-05-23 21:00:00	45	20
6980	2026-05-23 21:00:00	42	38.41
6989	2026-05-23 21:00:00	44	20
6998	2026-05-23 21:00:00	41	40
7008	2026-05-23 22:00:00	23	264
7018	2026-05-23 22:00:00	21	40
7024	2026-05-23 22:00:00	24	20
7034	2026-05-23 22:00:00	25	20
7042	2026-05-23 22:00:00	22	38.39
7059	2026-05-23 23:00:00	44	20
7069	2026-05-23 23:00:00	41	40
7082	2026-05-23 23:00:00	43	264
7093	2026-05-23 23:00:00	45	20
7100	2026-05-23 23:00:00	42	38.3
7101	2026-05-24 00:00:00	4	20
7115	2026-05-24 00:00:00	2	24.28
7126	2026-05-24 00:00:00	5	20
7137	2026-05-24 00:00:00	1	12
7146	2026-05-24 00:00:00	3	171.6
7151	2026-05-24 01:00:00	4	20
7161	2026-05-24 01:00:00	2	24.3
7173	2026-05-24 01:00:00	5	20
7183	2026-05-24 01:00:00	1	12
7194	2026-05-24 01:00:00	3	171.6
7574	2026-05-24 09:00:00	41	40
7583	2026-05-24 09:00:00	43	264
7592	2026-05-24 09:00:00	45	20
7610	2026-05-24 10:00:00	36	40
7619	2026-05-24 10:00:00	38	264
7628	2026-05-24 10:00:00	40	20
7636	2026-05-24 10:00:00	37	38.29
7647	2026-05-24 10:00:00	39	20
7654	2026-05-24 11:00:00	16	40
7662	2026-05-24 11:00:00	19	20
7676	2026-05-24 11:00:00	18	264
7685	2026-05-24 11:00:00	17	38.43
7698	2026-05-24 11:00:00	20	20
7707	2026-05-24 12:00:00	28	435.6
7713	2026-05-24 12:00:00	29	20
7721	2026-05-24 12:00:00	30	20
7727	2026-05-24 12:00:00	26	92
7737	2026-05-24 12:00:00	27	64.32
7761	2026-05-24 13:00:00	50	20
7776	2026-05-24 13:00:00	47	38.19
7787	2026-05-24 13:00:00	48	264
7794	2026-05-24 13:00:00	49	20
7800	2026-05-24 13:00:00	46	40
7802	2026-05-24 14:00:00	3	171.6
7811	2026-05-24 14:00:00	4	20
7821	2026-05-24 14:00:00	2	24.48
7832	2026-05-24 14:00:00	5	20
7839	2026-05-24 14:00:00	1	12
7858	2026-05-24 15:00:00	46	40
7867	2026-05-24 15:00:00	50	20
7878	2026-05-24 15:00:00	47	38.28
7888	2026-05-24 15:00:00	48	264
7898	2026-05-24 15:00:00	49	20
7902	2026-05-24 16:00:00	6	12
7917	2026-05-24 16:00:00	10	20
7922	2026-05-24 16:00:00	9	20
7931	2026-05-24 16:00:00	8	171.6
7940	2026-05-24 16:00:00	7	24.21
7958	2026-05-24 17:00:00	45	20
7966	2026-05-24 17:00:00	42	38.31
7973	2026-05-24 17:00:00	44	20
7983	2026-05-24 17:00:00	41	40
7994	2026-05-24 17:00:00	43	264
8005	2026-05-24 18:00:00	26	40
8015	2026-05-24 18:00:00	27	38.25
8022	2026-05-24 18:00:00	28	264
8036	2026-05-24 18:00:00	29	20
8046	2026-05-24 18:00:00	30	20
8053	2026-05-24 19:00:00	22	38.44
8063	2026-05-24 19:00:00	23	264
8075	2026-05-24 19:00:00	21	40
8086	2026-05-24 19:00:00	24	20
8094	2026-05-24 19:00:00	35	20
8095	2026-05-24 19:00:00	25	20
8100	2026-05-24 19:00:00	31	40
8101	2026-05-24 20:00:00	1	12
8106	2026-05-24 20:00:00	30	20
8112	2026-05-24 20:00:00	3	171.6
8116	2026-05-24 20:00:00	26	40
8122	2026-05-24 20:00:00	4	20
8131	2026-05-24 20:00:00	27	38.28
8133	2026-05-24 20:00:00	2	24.21
8141	2026-05-24 20:00:00	28	264
8142	2026-05-24 20:00:00	5	20
8150	2026-05-24 20:00:00	29	20
8151	2026-05-24 21:00:00	3	171.6
8159	2026-05-24 21:00:00	39	20
8161	2026-05-24 21:00:00	4	20
8169	2026-05-24 21:00:00	36	40
8174	2026-05-24 21:00:00	2	24.23
8180	2026-05-24 21:00:00	38	264
8181	2026-05-24 21:00:00	5	20
8190	2026-05-24 21:00:00	40	20
8191	2026-05-24 21:00:00	1	12
8200	2026-05-24 21:00:00	37	38.4
8206	2026-05-24 22:00:00	14	15
8210	2026-05-24 22:00:00	47	38.32
8212	2026-05-24 22:00:00	11	40
8216	2026-05-24 22:00:00	48	264
8225	2026-05-24 22:00:00	15	15
8226	2026-05-24 22:00:00	49	20
8235	2026-05-24 22:00:00	12	54.07
8238	2026-05-24 22:00:00	46	40
8243	2026-05-24 22:00:00	13	261
8248	2026-05-24 22:00:00	50	20
8253	2026-05-24 23:00:00	15	15
8260	2026-05-24 23:00:00	49	20
8264	2026-05-24 23:00:00	12	54.1
8268	2026-05-24 23:00:00	46	40
8274	2026-05-24 23:00:00	50	20
6743	2026-05-23 16:00:00	44	20
6750	2026-05-23 16:00:00	41	40
6751	2026-05-23 17:00:00	1	12
6761	2026-05-23 17:00:00	3	171.6
6772	2026-05-23 17:00:00	4	20
6782	2026-05-23 17:00:00	2	24.2
6792	2026-05-23 17:00:00	5	20
6808	2026-05-23 18:00:00	36	40
6819	2026-05-23 18:00:00	38	264
6829	2026-05-23 18:00:00	40	20
6840	2026-05-23 18:00:00	37	38.31
6849	2026-05-23 18:00:00	39	20
6852	2026-05-23 19:00:00	7	24.43
6862	2026-05-23 19:00:00	6	12
6872	2026-05-23 19:00:00	10	20
6884	2026-05-23 19:00:00	9	20
6893	2026-05-23 19:00:00	8	171.6
6908	2026-05-23 20:00:00	49	20
6920	2026-05-23 20:00:00	46	40
6928	2026-05-23 20:00:00	50	20
6933	2026-05-23 20:00:00	47	38.23
6944	2026-05-23 20:00:00	48	264
6956	2026-05-23 21:00:00	31	40
6967	2026-05-23 21:00:00	33	264
6976	2026-05-23 21:00:00	32	38.21
6985	2026-05-23 21:00:00	34	20
6994	2026-05-23 21:00:00	35	20
7005	2026-05-23 22:00:00	33	264
7021	2026-05-23 22:00:00	32	38.19
7032	2026-05-23 22:00:00	34	20
7038	2026-05-23 22:00:00	35	20
7050	2026-05-23 22:00:00	31	40
7053	2026-05-23 23:00:00	11	40
7064	2026-05-23 23:00:00	15	15
7077	2026-05-23 23:00:00	12	54.31
7086	2026-05-23 23:00:00	13	261
7097	2026-05-23 23:00:00	14	15
7103	2026-05-24 00:00:00	20	20
7116	2026-05-24 00:00:00	16	40
7123	2026-05-24 00:00:00	19	20
7133	2026-05-24 00:00:00	18	264
7144	2026-05-24 00:00:00	17	38.3
7159	2026-05-24 01:00:00	31	40
7170	2026-05-24 01:00:00	33	264
7179	2026-05-24 01:00:00	32	38.41
7189	2026-05-24 01:00:00	34	20
7199	2026-05-24 01:00:00	35	20
7575	2026-05-24 09:00:00	2	24.43
7582	2026-05-24 09:00:00	5	20
7590	2026-05-24 09:00:00	1	12
7607	2026-05-24 10:00:00	42	38.27
7617	2026-05-24 10:00:00	44	20
7626	2026-05-24 10:00:00	41	40
7635	2026-05-24 10:00:00	43	264
7645	2026-05-24 10:00:00	45	20
7655	2026-05-24 11:00:00	25	20
7669	2026-05-24 11:00:00	22	38.21
7681	2026-05-24 11:00:00	23	264
7692	2026-05-24 11:00:00	21	40
7700	2026-05-24 11:00:00	24	20
7706	2026-05-24 12:00:00	22	64.31
7717	2026-05-24 12:00:00	23	435.6
7729	2026-05-24 12:00:00	21	92
7739	2026-05-24 12:00:00	24	20
7750	2026-05-24 12:00:00	25	20
7751	2026-05-24 13:00:00	2	24.24
7760	2026-05-24 13:00:00	5	20
7770	2026-05-24 13:00:00	1	12
7778	2026-05-24 13:00:00	3	171.6
7784	2026-05-24 13:00:00	4	20
7809	2026-05-24 14:00:00	45	20
7819	2026-05-24 14:00:00	42	38.21
7829	2026-05-24 14:00:00	44	20
7841	2026-05-24 14:00:00	41	40
7849	2026-05-24 14:00:00	43	264
7851	2026-05-24 15:00:00	3	171.6
7862	2026-05-24 15:00:00	4	20
7871	2026-05-24 15:00:00	2	24.27
7881	2026-05-24 15:00:00	5	20
7892	2026-05-24 15:00:00	1	12
7910	2026-05-24 16:00:00	45	20
7921	2026-05-24 16:00:00	42	38.27
7929	2026-05-24 16:00:00	44	20
7934	2026-05-24 16:00:00	41	40
7947	2026-05-24 16:00:00	43	264
7955	2026-05-24 17:00:00	19	20
7969	2026-05-24 17:00:00	18	264
7978	2026-05-24 17:00:00	17	38.41
7987	2026-05-24 17:00:00	20	20
7999	2026-05-24 17:00:00	16	40
8002	2026-05-24 18:00:00	8	171.6
8011	2026-05-24 18:00:00	7	24.25
8021	2026-05-24 18:00:00	6	12
8031	2026-05-24 18:00:00	10	20
8037	2026-05-24 18:00:00	9	20
8059	2026-05-24 19:00:00	50	20
8065	2026-05-24 19:00:00	47	38.2
8074	2026-05-24 19:00:00	48	264
8081	2026-05-24 19:00:00	49	20
8091	2026-05-24 19:00:00	46	40
8096	2026-05-24 19:00:00	29	20
8103	2026-05-24 20:00:00	22	38.26
8110	2026-05-24 20:00:00	50	20
8117	2026-05-24 20:00:00	23	264
8119	2026-05-24 20:00:00	47	38.28
8128	2026-05-24 20:00:00	48	264
8129	2026-05-24 20:00:00	21	40
8138	2026-05-24 20:00:00	24	20
8139	2026-05-24 20:00:00	49	20
8147	2026-05-24 20:00:00	25	20
8149	2026-05-24 20:00:00	46	40
8153	2026-05-24 21:00:00	14	15
8155	2026-05-24 21:00:00	20	20
8163	2026-05-24 21:00:00	11	40
8167	2026-05-24 21:00:00	16	40
8173	2026-05-24 21:00:00	15	15
8178	2026-05-24 21:00:00	19	20
8182	2026-05-24 21:00:00	12	54.35
8185	2026-05-24 21:00:00	18	264
8192	2026-05-24 21:00:00	13	261
8193	2026-05-24 21:00:00	17	38.38
8205	2026-05-24 22:00:00	39	20
8209	2026-05-24 22:00:00	45	20
8213	2026-05-24 22:00:00	36	40
8219	2026-05-24 22:00:00	42	38.41
8222	2026-05-24 22:00:00	38	264
8224	2026-05-24 22:00:00	44	20
8234	2026-05-24 22:00:00	40	20
8236	2026-05-24 22:00:00	41	40
8245	2026-05-24 22:00:00	43	264
8246	2026-05-24 22:00:00	37	38.42
8255	2026-05-24 23:00:00	19	20
8256	2026-05-24 23:00:00	38	264
8263	2026-05-24 23:00:00	40	20
8269	2026-05-24 23:00:00	18	264
8275	2026-05-24 23:00:00	17	38.27
6744	2026-05-23 16:00:00	27	38.48
6756	2026-05-23 17:00:00	33	264
6764	2026-05-23 17:00:00	32	38.42
6776	2026-05-23 17:00:00	34	20
6784	2026-05-23 17:00:00	35	20
6794	2026-05-23 17:00:00	31	40
6806	2026-05-23 18:00:00	34	20
6813	2026-05-23 18:00:00	35	20
6821	2026-05-23 18:00:00	31	40
6831	2026-05-23 18:00:00	33	264
6841	2026-05-23 18:00:00	32	38.23
6859	2026-05-23 19:00:00	33	264
6866	2026-05-23 19:00:00	32	38.46
6877	2026-05-23 19:00:00	34	20
6888	2026-05-23 19:00:00	35	20
6896	2026-05-23 19:00:00	31	40
6906	2026-05-23 20:00:00	28	264
6916	2026-05-23 20:00:00	29	20
6923	2026-05-23 20:00:00	30	20
6934	2026-05-23 20:00:00	26	40
6945	2026-05-23 20:00:00	27	38.21
6955	2026-05-23 21:00:00	22	38.38
6968	2026-05-23 21:00:00	23	264
6978	2026-05-23 21:00:00	21	40
6988	2026-05-23 21:00:00	24	20
7000	2026-05-23 21:00:00	25	20
7001	2026-05-23 22:00:00	3	171.6
7013	2026-05-23 22:00:00	4	20
7025	2026-05-23 22:00:00	2	24.19
7035	2026-05-23 22:00:00	5	20
7044	2026-05-23 22:00:00	1	12
7057	2026-05-23 23:00:00	34	20
7070	2026-05-23 23:00:00	35	20
7083	2026-05-23 23:00:00	31	40
7089	2026-05-23 23:00:00	33	264
7096	2026-05-23 23:00:00	32	38.25
7106	2026-05-24 00:00:00	21	40
7112	2026-05-24 00:00:00	24	20
7122	2026-05-24 00:00:00	25	20
7127	2026-05-24 00:00:00	22	38.36
7136	2026-05-24 00:00:00	23	264
7160	2026-05-24 01:00:00	47	38.27
7169	2026-05-24 01:00:00	48	264
7180	2026-05-24 01:00:00	49	20
7188	2026-05-24 01:00:00	46	40
7198	2026-05-24 01:00:00	50	20
7577	2026-05-24 09:00:00	37	38.21
7587	2026-05-24 09:00:00	39	20
7595	2026-05-24 09:00:00	36	40
7606	2026-05-24 10:00:00	26	40
7615	2026-05-24 10:00:00	27	38.28
7625	2026-05-24 10:00:00	28	264
7637	2026-05-24 10:00:00	29	20
7648	2026-05-24 10:00:00	30	20
7653	2026-05-24 11:00:00	12	54.2
7664	2026-05-24 11:00:00	13	261
7675	2026-05-24 11:00:00	14	15
7687	2026-05-24 11:00:00	11	40
7694	2026-05-24 11:00:00	15	15
7708	2026-05-24 12:00:00	50	20
7720	2026-05-24 12:00:00	47	64.22
7730	2026-05-24 12:00:00	48	435.6
7740	2026-05-24 12:00:00	49	20
7746	2026-05-24 12:00:00	46	92
7753	2026-05-24 13:00:00	17	38.46
7759	2026-05-24 13:00:00	20	20
7771	2026-05-24 13:00:00	16	40
7781	2026-05-24 13:00:00	19	20
7791	2026-05-24 13:00:00	18	264
7805	2026-05-24 14:00:00	31	40
7817	2026-05-24 14:00:00	33	264
7825	2026-05-24 14:00:00	32	38.32
7837	2026-05-24 14:00:00	34	20
7848	2026-05-24 14:00:00	35	20
7853	2026-05-24 15:00:00	16	40
7865	2026-05-24 15:00:00	19	20
7874	2026-05-24 15:00:00	18	264
7885	2026-05-24 15:00:00	17	38.29
7895	2026-05-24 15:00:00	20	20
7906	2026-05-24 16:00:00	28	264
7913	2026-05-24 16:00:00	29	20
7925	2026-05-24 16:00:00	30	20
7938	2026-05-24 16:00:00	26	40
7946	2026-05-24 16:00:00	27	38.35
7954	2026-05-24 17:00:00	24	20
7964	2026-05-24 17:00:00	25	20
7972	2026-05-24 17:00:00	22	38.36
7982	2026-05-24 17:00:00	23	264
7991	2026-05-24 17:00:00	21	40
8007	2026-05-24 18:00:00	44	20
8014	2026-05-24 18:00:00	41	40
8024	2026-05-24 18:00:00	43	264
8039	2026-05-24 18:00:00	45	20
8048	2026-05-24 18:00:00	42	38.4
8055	2026-05-24 19:00:00	11	40
8061	2026-05-24 19:00:00	15	15
8072	2026-05-24 19:00:00	12	54.28
8083	2026-05-24 19:00:00	13	261
8093	2026-05-24 19:00:00	14	15
8099	2026-05-24 19:00:00	9	20
8102	2026-05-24 20:00:00	8	171.6
8107	2026-05-24 20:00:00	37	38.26
8111	2026-05-24 20:00:00	39	20
8113	2026-05-24 20:00:00	7	24.23
8121	2026-05-24 20:00:00	36	40
8124	2026-05-24 20:00:00	6	12
8125	2026-05-24 20:00:00	38	264
8132	2026-05-24 20:00:00	40	20
8135	2026-05-24 20:00:00	10	20
8145	2026-05-24 20:00:00	9	20
8158	2026-05-24 21:00:00	32	38.2
8160	2026-05-24 21:00:00	47	38.3
8168	2026-05-24 21:00:00	34	20
8170	2026-05-24 21:00:00	48	264
8177	2026-05-24 21:00:00	35	20
8179	2026-05-24 21:00:00	49	20
8188	2026-05-24 21:00:00	31	40
8189	2026-05-24 21:00:00	46	40
8196	2026-05-24 21:00:00	33	264
8199	2026-05-24 21:00:00	50	20
8203	2026-05-24 22:00:00	20	20
8204	2026-05-24 22:00:00	23	264
8215	2026-05-24 22:00:00	21	40
8217	2026-05-24 22:00:00	16	40
8228	2026-05-24 22:00:00	19	20
8229	2026-05-24 22:00:00	24	20
8233	2026-05-24 22:00:00	18	264
8237	2026-05-24 22:00:00	25	20
8244	2026-05-24 22:00:00	17	38.43
8249	2026-05-24 22:00:00	22	38.28
8251	2026-05-24 23:00:00	8	171.6
8259	2026-05-24 23:00:00	34	20
8261	2026-05-24 23:00:00	7	24.36
8266	2026-05-24 23:00:00	35	20
8272	2026-05-24 23:00:00	31	40
8278	2026-05-24 23:00:00	6	12
6745	2026-05-23 16:00:00	13	261
6758	2026-05-23 17:00:00	29	20
6769	2026-05-23 17:00:00	30	20
6779	2026-05-23 17:00:00	26	40
6790	2026-05-23 17:00:00	27	38.47
6800	2026-05-23 17:00:00	28	264
6801	2026-05-23 18:00:00	4	20
6815	2026-05-23 18:00:00	2	24.36
6823	2026-05-23 18:00:00	5	20
6833	2026-05-23 18:00:00	1	12
6845	2026-05-23 18:00:00	3	171.6
6855	2026-05-23 19:00:00	28	264
6863	2026-05-23 19:00:00	29	20
6871	2026-05-23 19:00:00	30	20
6880	2026-05-23 19:00:00	26	40
6886	2026-05-23 19:00:00	27	38.27
6909	2026-05-23 20:00:00	43	264
6917	2026-05-23 20:00:00	45	20
6930	2026-05-23 20:00:00	42	38.41
6940	2026-05-23 20:00:00	44	20
6950	2026-05-23 20:00:00	41	40
6953	2026-05-23 21:00:00	1	12
6964	2026-05-23 21:00:00	3	171.6
6973	2026-05-23 21:00:00	4	20
6982	2026-05-23 21:00:00	2	24.37
6992	2026-05-23 21:00:00	5	20
7009	2026-05-23 22:00:00	29	20
7019	2026-05-23 22:00:00	30	20
7029	2026-05-23 22:00:00	26	40
7043	2026-05-23 22:00:00	27	38.42
7049	2026-05-23 22:00:00	28	264
7055	2026-05-23 23:00:00	24	20
7063	2026-05-23 23:00:00	25	20
7075	2026-05-23 23:00:00	22	38.44
7084	2026-05-23 23:00:00	23	264
7094	2026-05-23 23:00:00	21	40
7108	2026-05-24 00:00:00	33	264
7118	2026-05-24 00:00:00	32	38.41
7130	2026-05-24 00:00:00	34	20
7138	2026-05-24 00:00:00	35	20
7148	2026-05-24 00:00:00	31	40
7154	2026-05-24 01:00:00	13	261
7167	2026-05-24 01:00:00	14	15
7178	2026-05-24 01:00:00	11	40
7187	2026-05-24 01:00:00	15	15
7196	2026-05-24 01:00:00	12	54.36
7578	2026-05-24 09:00:00	17	38.25
7588	2026-05-24 09:00:00	20	20
7597	2026-05-24 09:00:00	16	40
7604	2026-05-24 10:00:00	16	40
7613	2026-05-24 10:00:00	19	20
7623	2026-05-24 10:00:00	18	264
7634	2026-05-24 10:00:00	17	38.46
7643	2026-05-24 10:00:00	20	20
7656	2026-05-24 11:00:00	36	40
7666	2026-05-24 11:00:00	38	264
7672	2026-05-24 11:00:00	40	20
7682	2026-05-24 11:00:00	37	38.38
7693	2026-05-24 11:00:00	39	20
7709	2026-05-24 12:00:00	40	20
7718	2026-05-24 12:00:00	37	64.49
7728	2026-05-24 12:00:00	39	20
7738	2026-05-24 12:00:00	36	92
7748	2026-05-24 12:00:00	38	435.6
7755	2026-05-24 13:00:00	23	264
7763	2026-05-24 13:00:00	21	40
7769	2026-05-24 13:00:00	24	20
7777	2026-05-24 13:00:00	25	20
7785	2026-05-24 13:00:00	22	38.34
7810	2026-05-24 14:00:00	47	38.47
7820	2026-05-24 14:00:00	48	264
7828	2026-05-24 14:00:00	49	20
7838	2026-05-24 14:00:00	46	40
7847	2026-05-24 14:00:00	50	20
7854	2026-05-24 15:00:00	13	261
7869	2026-05-24 15:00:00	14	15
7880	2026-05-24 15:00:00	11	40
7890	2026-05-24 15:00:00	15	15
7900	2026-05-24 15:00:00	12	54.1
7904	2026-05-24 16:00:00	16	40
7915	2026-05-24 16:00:00	19	20
7927	2026-05-24 16:00:00	18	264
7939	2026-05-24 16:00:00	17	38.38
7948	2026-05-24 16:00:00	20	20
7952	2026-05-24 17:00:00	10	20
7962	2026-05-24 17:00:00	9	20
7976	2026-05-24 17:00:00	8	171.6
7988	2026-05-24 17:00:00	7	24.29
7997	2026-05-24 17:00:00	6	12
8008	2026-05-24 18:00:00	32	38.3
8020	2026-05-24 18:00:00	34	20
8027	2026-05-24 18:00:00	35	20
8034	2026-05-24 18:00:00	31	40
8041	2026-05-24 18:00:00	33	264
8060	2026-05-24 19:00:00	43	264
8064	2026-05-24 19:00:00	45	20
8073	2026-05-24 19:00:00	42	38.37
8080	2026-05-24 19:00:00	44	20
8085	2026-05-24 19:00:00	41	40
8109	2026-05-24 20:00:00	43	264
8118	2026-05-24 20:00:00	45	20
8127	2026-05-24 20:00:00	42	38.35
8136	2026-05-24 20:00:00	44	20
8146	2026-05-24 20:00:00	41	40
8152	2026-05-24 21:00:00	7	24.46
8162	2026-05-24 21:00:00	6	12
8176	2026-05-24 21:00:00	10	20
8186	2026-05-24 21:00:00	9	20
8197	2026-05-24 21:00:00	8	171.6
8201	2026-05-24 22:00:00	3	171.6
8211	2026-05-24 22:00:00	4	20
8221	2026-05-24 22:00:00	2	24.36
8230	2026-05-24 22:00:00	5	20
8240	2026-05-24 22:00:00	1	12
8257	2026-05-24 23:00:00	42	38.25
8262	2026-05-24 23:00:00	44	20
8276	2026-05-24 23:00:00	41	40
8277	2026-05-24 23:00:00	37	38.45
8287	2026-05-24 23:00:00	39	20
8288	2026-05-24 23:00:00	20	20
8289	2026-05-24 23:00:00	43	264
8294	2026-05-24 23:00:00	36	40
8296	2026-05-24 23:00:00	16	40
8299	2026-05-24 23:00:00	45	20
6746	2026-05-23 16:00:00	35	20
6755	2026-05-23 17:00:00	21	40
6767	2026-05-23 17:00:00	24	20
6778	2026-05-23 17:00:00	25	20
6788	2026-05-23 17:00:00	22	38.23
6798	2026-05-23 17:00:00	23	264
6805	2026-05-23 18:00:00	19	20
6817	2026-05-23 18:00:00	18	264
6828	2026-05-23 18:00:00	17	38.28
6836	2026-05-23 18:00:00	20	20
6842	2026-05-23 18:00:00	16	40
6860	2026-05-23 19:00:00	46	40
6867	2026-05-23 19:00:00	50	20
6876	2026-05-23 19:00:00	47	38.46
6887	2026-05-23 19:00:00	48	264
6897	2026-05-23 19:00:00	49	20
6904	2026-05-23 20:00:00	12	54.32
6919	2026-05-23 20:00:00	13	261
6926	2026-05-23 20:00:00	14	15
6938	2026-05-23 20:00:00	11	40
6948	2026-05-23 20:00:00	15	15
6952	2026-05-23 21:00:00	12	54.14
6962	2026-05-23 21:00:00	13	261
6972	2026-05-23 21:00:00	14	15
6983	2026-05-23 21:00:00	11	40
6995	2026-05-23 21:00:00	15	15
7006	2026-05-23 22:00:00	37	38.47
7016	2026-05-23 22:00:00	39	20
7028	2026-05-23 22:00:00	36	40
7039	2026-05-23 22:00:00	38	264
7045	2026-05-23 22:00:00	40	20
7054	2026-05-23 23:00:00	29	20
7061	2026-05-23 23:00:00	30	20
7071	2026-05-23 23:00:00	26	40
7080	2026-05-23 23:00:00	27	38.19
7092	2026-05-23 23:00:00	28	264
7109	2026-05-24 00:00:00	37	38.36
7120	2026-05-24 00:00:00	39	20
7131	2026-05-24 00:00:00	36	40
7141	2026-05-24 00:00:00	38	264
7150	2026-05-24 00:00:00	40	20
7152	2026-05-24 01:00:00	21	40
7165	2026-05-24 01:00:00	24	20
7175	2026-05-24 01:00:00	25	20
7186	2026-05-24 01:00:00	22	38.36
7197	2026-05-24 01:00:00	23	264
7579	2026-05-24 09:00:00	21	40
7591	2026-05-24 09:00:00	24	20
7599	2026-05-24 09:00:00	25	20
7601	2026-05-24 10:00:00	3	171.6
7612	2026-05-24 10:00:00	4	20
7622	2026-05-24 10:00:00	2	24.29
7632	2026-05-24 10:00:00	5	20
7641	2026-05-24 10:00:00	1	12
7659	2026-05-24 11:00:00	42	38.41
7667	2026-05-24 11:00:00	44	20
7673	2026-05-24 11:00:00	41	40
7684	2026-05-24 11:00:00	43	264
7691	2026-05-24 11:00:00	45	20
7710	2026-05-24 12:00:00	41	92
7719	2026-05-24 12:00:00	43	435.6
7731	2026-05-24 12:00:00	45	20
7741	2026-05-24 12:00:00	42	64.29
7747	2026-05-24 12:00:00	44	20
7757	2026-05-24 13:00:00	13	261
7764	2026-05-24 13:00:00	14	15
7775	2026-05-24 13:00:00	11	40
7788	2026-05-24 13:00:00	15	15
7795	2026-05-24 13:00:00	12	54.36
7806	2026-05-24 14:00:00	29	20
7814	2026-05-24 14:00:00	30	20
7824	2026-05-24 14:00:00	26	40
7834	2026-05-24 14:00:00	27	38.39
7844	2026-05-24 14:00:00	28	264
7860	2026-05-24 15:00:00	40	20
7861	2026-05-24 15:00:00	37	38.37
7870	2026-05-24 15:00:00	39	20
7876	2026-05-24 15:00:00	36	40
7891	2026-05-24 15:00:00	38	264
7909	2026-05-24 16:00:00	46	40
7912	2026-05-24 16:00:00	50	20
7923	2026-05-24 16:00:00	47	38.42
7935	2026-05-24 16:00:00	48	264
7944	2026-05-24 16:00:00	49	20
7956	2026-05-24 17:00:00	35	20
7967	2026-05-24 17:00:00	31	40
7977	2026-05-24 17:00:00	33	264
7984	2026-05-24 17:00:00	32	38.29
7996	2026-05-24 17:00:00	34	20
8003	2026-05-24 18:00:00	17	38.21
8013	2026-05-24 18:00:00	20	20
8026	2026-05-24 18:00:00	16	40
8033	2026-05-24 18:00:00	19	20
8040	2026-05-24 18:00:00	18	264
8058	2026-05-24 19:00:00	37	38.46
8068	2026-05-24 19:00:00	39	20
8077	2026-05-24 19:00:00	36	40
8088	2026-05-24 19:00:00	38	264
8098	2026-05-24 19:00:00	40	20
8104	2026-05-24 20:00:00	11	40
8114	2026-05-24 20:00:00	15	15
8123	2026-05-24 20:00:00	12	54.29
8134	2026-05-24 20:00:00	13	261
8144	2026-05-24 20:00:00	14	15
8157	2026-05-24 21:00:00	45	20
8164	2026-05-24 21:00:00	42	38.45
8171	2026-05-24 21:00:00	44	20
8183	2026-05-24 21:00:00	41	40
8194	2026-05-24 21:00:00	43	264
8207	2026-05-24 22:00:00	32	38.35
8214	2026-05-24 22:00:00	34	20
8232	2026-05-24 22:00:00	35	20
8241	2026-05-24 22:00:00	31	40
8250	2026-05-24 22:00:00	33	264
8252	2026-05-24 23:00:00	2	24.38
8265	2026-05-24 23:00:00	5	20
8271	2026-05-24 23:00:00	1	12
8279	2026-05-24 23:00:00	13	261
8280	2026-05-24 23:00:00	3	171.6
8286	2026-05-24 23:00:00	4	20
8290	2026-05-24 23:00:00	10	20
8291	2026-05-24 23:00:00	14	15
8297	2026-05-24 23:00:00	11	40
8298	2026-05-24 23:00:00	9	20
6747	2026-05-23 16:00:00	22	38.35
6753	2026-05-23 17:00:00	20	20
6766	2026-05-23 17:00:00	16	40
6777	2026-05-23 17:00:00	19	20
6789	2026-05-23 17:00:00	18	264
6799	2026-05-23 17:00:00	17	38.22
6802	2026-05-23 18:00:00	10	20
6812	2026-05-23 18:00:00	9	20
6822	2026-05-23 18:00:00	8	171.6
6832	2026-05-23 18:00:00	7	24.21
6844	2026-05-23 18:00:00	6	12
6857	2026-05-23 19:00:00	37	38.25
6869	2026-05-23 19:00:00	39	20
6875	2026-05-23 19:00:00	36	40
6883	2026-05-23 19:00:00	38	264
6894	2026-05-23 19:00:00	40	20
6910	2026-05-23 20:00:00	31	40
6918	2026-05-23 20:00:00	33	264
6929	2026-05-23 20:00:00	32	38.39
6939	2026-05-23 20:00:00	34	20
6949	2026-05-23 20:00:00	35	20
6954	2026-05-23 21:00:00	18	264
6965	2026-05-23 21:00:00	17	38.33
6975	2026-05-23 21:00:00	20	20
6984	2026-05-23 21:00:00	16	40
6997	2026-05-23 21:00:00	19	20
7003	2026-05-23 22:00:00	13	261
7014	2026-05-23 22:00:00	14	15
7026	2026-05-23 22:00:00	11	40
7036	2026-05-23 22:00:00	15	15
7046	2026-05-23 22:00:00	12	54.3
7052	2026-05-23 23:00:00	8	171.6
7065	2026-05-23 23:00:00	7	24.21
7076	2026-05-23 23:00:00	6	12
7088	2026-05-23 23:00:00	10	20
7098	2026-05-23 23:00:00	9	20
7104	2026-05-24 00:00:00	13	261
7114	2026-05-24 00:00:00	14	15
7124	2026-05-24 00:00:00	11	40
7135	2026-05-24 00:00:00	15	15
7145	2026-05-24 00:00:00	12	54.24
7156	2026-05-24 01:00:00	28	264
7166	2026-05-24 01:00:00	29	20
7177	2026-05-24 01:00:00	30	20
7190	2026-05-24 01:00:00	26	40
7200	2026-05-24 01:00:00	27	38.47
7581	2026-05-24 09:00:00	49	20
7593	2026-05-24 09:00:00	46	40
7600	2026-05-24 09:00:00	50	20
7602	2026-05-24 10:00:00	6	12
7611	2026-05-24 10:00:00	10	20
7618	2026-05-24 10:00:00	9	20
7629	2026-05-24 10:00:00	8	171.6
7638	2026-05-24 10:00:00	7	24.36
7660	2026-05-24 11:00:00	46	40
7670	2026-05-24 11:00:00	50	20
7679	2026-05-24 11:00:00	47	38.33
7689	2026-05-24 11:00:00	48	264
7696	2026-05-24 11:00:00	49	20
8089	2026-05-24 19:00:00	4	20
8108	2026-05-24 20:00:00	33	264
8120	2026-05-24 20:00:00	32	38.19
8126	2026-05-24 20:00:00	34	20
8137	2026-05-24 20:00:00	35	20
8143	2026-05-24 20:00:00	31	40
8154	2026-05-24 21:00:00	23	264
8166	2026-05-24 21:00:00	21	40
8175	2026-05-24 21:00:00	24	20
8187	2026-05-24 21:00:00	25	20
8198	2026-05-24 21:00:00	22	38.41
8202	2026-05-24 22:00:00	9	20
8218	2026-05-24 22:00:00	8	171.6
8223	2026-05-24 22:00:00	7	24.39
8231	2026-05-24 22:00:00	6	12
8242	2026-05-24 22:00:00	10	20
8254	2026-05-24 23:00:00	25	20
8270	2026-05-24 23:00:00	22	38.32
8281	2026-05-24 23:00:00	33	264
8282	2026-05-24 23:00:00	23	264
8285	2026-05-24 23:00:00	32	38.49
8292	2026-05-24 23:00:00	21	40
8300	2026-05-24 23:00:00	24	20
6749	2026-05-23 16:00:00	49	20
6754	2026-05-23 17:00:00	14	15
6765	2026-05-23 17:00:00	11	40
6775	2026-05-23 17:00:00	15	15
6783	2026-05-23 17:00:00	12	54.26
6791	2026-05-23 17:00:00	13	261
6809	2026-05-23 18:00:00	45	20
6820	2026-05-23 18:00:00	42	38.2
6830	2026-05-23 18:00:00	44	20
6837	2026-05-23 18:00:00	41	40
6843	2026-05-23 18:00:00	43	264
6858	2026-05-23 19:00:00	44	20
6868	2026-05-23 19:00:00	41	40
6874	2026-05-23 19:00:00	43	264
6882	2026-05-23 19:00:00	45	20
6889	2026-05-23 19:00:00	42	38.42
6907	2026-05-23 20:00:00	40	20
6913	2026-05-23 20:00:00	37	38.22
6921	2026-05-23 20:00:00	39	20
6935	2026-05-23 20:00:00	36	40
6941	2026-05-23 20:00:00	38	264
6959	2026-05-23 21:00:00	49	20
6969	2026-05-23 21:00:00	46	40
6979	2026-05-23 21:00:00	50	20
6990	2026-05-23 21:00:00	47	38.34
6999	2026-05-23 21:00:00	48	264
7002	2026-05-23 22:00:00	7	24.31
7011	2026-05-23 22:00:00	6	12
7017	2026-05-23 22:00:00	10	20
7023	2026-05-23 22:00:00	9	20
7033	2026-05-23 22:00:00	8	171.6
7060	2026-05-23 23:00:00	47	38.48
7067	2026-05-23 23:00:00	48	264
7073	2026-05-23 23:00:00	49	20
7079	2026-05-23 23:00:00	46	40
7087	2026-05-23 23:00:00	50	20
7110	2026-05-24 00:00:00	47	38.34
7119	2026-05-24 00:00:00	48	264
7129	2026-05-24 00:00:00	49	20
7140	2026-05-24 00:00:00	46	40
7147	2026-05-24 00:00:00	50	20
7155	2026-05-24 01:00:00	20	20
7162	2026-05-24 01:00:00	16	40
7174	2026-05-24 01:00:00	19	20
7185	2026-05-24 01:00:00	18	264
7191	2026-05-24 01:00:00	17	38.47
7586	2026-05-24 09:00:00	30	20
7596	2026-05-24 09:00:00	26	40
7605	2026-05-24 10:00:00	25	20
7614	2026-05-24 10:00:00	22	38.43
7624	2026-05-24 10:00:00	23	264
7640	2026-05-24 10:00:00	21	40
7649	2026-05-24 10:00:00	24	20
7651	2026-05-24 11:00:00	3	171.6
7663	2026-05-24 11:00:00	4	20
7677	2026-05-24 11:00:00	2	24.38
7683	2026-05-24 11:00:00	5	20
7695	2026-05-24 11:00:00	1	12
8092	2026-05-24 19:00:00	19	20
8097	2026-05-24 19:00:00	18	264
8105	2026-05-24 20:00:00	17	38.47
8115	2026-05-24 20:00:00	20	20
8130	2026-05-24 20:00:00	16	40
8140	2026-05-24 20:00:00	19	20
8148	2026-05-24 20:00:00	18	264
8156	2026-05-24 21:00:00	26	40
8165	2026-05-24 21:00:00	27	38.2
8172	2026-05-24 21:00:00	28	264
8184	2026-05-24 21:00:00	29	20
8195	2026-05-24 21:00:00	30	20
8208	2026-05-24 22:00:00	26	40
8220	2026-05-24 22:00:00	27	38.25
8227	2026-05-24 22:00:00	28	264
8239	2026-05-24 22:00:00	29	20
8247	2026-05-24 22:00:00	30	20
8258	2026-05-24 23:00:00	28	264
8267	2026-05-24 23:00:00	29	20
8273	2026-05-24 23:00:00	30	20
8283	2026-05-24 23:00:00	26	40
8284	2026-05-24 23:00:00	47	38.22
8293	2026-05-24 23:00:00	48	264
8295	2026-05-24 23:00:00	27	38.48
\.


--
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.server (server_id, cluster_id, config_id, hostname, status, base_consumption_offset, created_at, is_master) FROM stdin;
1	1	1	marseille-marseille-zone-01-master-01	ON	850	2026-05-19 11:46:37.96	t
2	1	1	marseille-marseille-zone-01-master-02	ON	850	2026-05-19 11:46:37.974	t
3	1	1	marseille-marseille-zone-01-worker-01	ON	700	2026-05-19 11:46:37.986	f
4	1	1	marseille-marseille-zone-01-worker-02	ON	700	2026-05-19 11:46:38.002	f
5	1	1	marseille-marseille-zone-01-worker-03	ON	700	2026-05-19 11:46:38.017	f
6	1	1	marseille-marseille-zone-01-worker-04	ON	700	2026-05-19 11:46:38.032	f
7	1	1	marseille-marseille-zone-01-worker-05	ON	700	2026-05-19 11:46:38.055	f
8	1	1	marseille-marseille-zone-01-worker-06	ON	700	2026-05-19 11:46:38.073	f
9	1	1	marseille-marseille-zone-01-worker-07	ON	700	2026-05-19 11:46:38.093	f
10	1	1	marseille-marseille-zone-01-worker-08	ON	700	2026-05-19 11:46:38.111	f
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

\unrestrict EdXbVnfnWMqan7cTsPI8Pgpv8QBSXiIfVhVebJADDjiKjCdyIGwb2JwqbNfGsPA

