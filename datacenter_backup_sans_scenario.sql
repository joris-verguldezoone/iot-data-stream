--
-- PostgreSQL database dump
--

\restrict 3ALzDdsEfK3YoX8RghUqx6rcxt8u0wIm8WQlIOvdEaVX3d7ifxfnZUNDnbLRrKG

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
1	Marseille-Zone-01	2026-05-19 11:50:44.131	1
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
1	Marseille	Marseille Tech Hub	1.2	1	2026-05-19 11:50:44.126	0.18
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
1	1	1	1	AUTO	ON	20	2026-05-19 11:50:44.136
2	1	1	1	AUTO	ON	20	2026-05-19 11:50:44.139
3	1	1	1	AUTO	ON	20	2026-05-19 11:50:44.142
4	1	1	1	AUTO	ON	20	2026-05-19 11:50:44.144
5	2	1	1	AUTO	ON	20	2026-05-19 11:50:44.159
6	2	1	1	AUTO	ON	20	2026-05-19 11:50:44.161
7	2	1	1	AUTO	ON	20	2026-05-19 11:50:44.163
8	2	1	1	AUTO	ON	20	2026-05-19 11:50:44.164
9	3	1	1	AUTO	ON	20	2026-05-19 11:50:44.177
10	3	1	1	AUTO	ON	20	2026-05-19 11:50:44.179
11	3	1	1	AUTO	ON	20	2026-05-19 11:50:44.181
12	3	1	1	AUTO	ON	20	2026-05-19 11:50:44.183
13	4	1	1	AUTO	ON	20	2026-05-19 11:50:44.196
14	4	1	1	AUTO	ON	20	2026-05-19 11:50:44.199
15	4	1	1	AUTO	ON	20	2026-05-19 11:50:44.201
16	4	1	1	AUTO	ON	20	2026-05-19 11:50:44.203
17	5	1	1	AUTO	ON	20	2026-05-19 11:50:44.213
18	5	1	1	AUTO	ON	20	2026-05-19 11:50:44.214
19	5	1	1	AUTO	ON	20	2026-05-19 11:50:44.216
20	5	1	1	AUTO	ON	20	2026-05-19 11:50:44.217
21	6	1	1	AUTO	ON	20	2026-05-19 11:50:44.229
22	6	1	1	AUTO	ON	20	2026-05-19 11:50:44.231
23	6	1	1	AUTO	ON	20	2026-05-19 11:50:44.233
24	6	1	1	AUTO	ON	20	2026-05-19 11:50:44.234
25	7	1	1	AUTO	ON	20	2026-05-19 11:50:44.248
26	7	1	1	AUTO	ON	20	2026-05-19 11:50:44.25
27	7	1	1	AUTO	ON	20	2026-05-19 11:50:44.252
28	7	1	1	AUTO	ON	20	2026-05-19 11:50:44.255
29	8	1	1	AUTO	ON	20	2026-05-19 11:50:44.269
30	8	1	1	AUTO	ON	20	2026-05-19 11:50:44.271
31	8	1	1	AUTO	ON	20	2026-05-19 11:50:44.273
32	8	1	1	AUTO	ON	20	2026-05-19 11:50:44.274
33	9	1	1	AUTO	ON	20	2026-05-19 11:50:44.288
34	9	1	1	AUTO	ON	20	2026-05-19 11:50:44.289
35	9	1	1	AUTO	ON	20	2026-05-19 11:50:44.291
36	9	1	1	AUTO	ON	20	2026-05-19 11:50:44.292
37	10	1	1	AUTO	ON	20	2026-05-19 11:50:44.3
38	10	1	1	AUTO	ON	20	2026-05-19 11:50:44.301
39	10	1	1	AUTO	ON	20	2026-05-19 11:50:44.303
40	10	1	1	AUTO	ON	20	2026-05-19 11:50:44.305
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
40	8	FAN_SPEED_2	%	20	2026-05-19 11:50:44.285
3	1	TOTAL_POWER	W	171.6	2026-05-19 11:50:44.151
38	8	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.281
36	8	LOAD	%	19.02	2026-05-19 11:50:44.276
37	8	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.279
9	2	FAN_SPEED_1	%	20	2026-05-19 11:50:44.171
43	9	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.296
41	9	LOAD	%	19.02	2026-05-19 11:50:44.294
6	2	LOAD	%	12	2026-05-19 11:50:44.166
42	9	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.295
44	9	FAN_SPEED_1	%	20	2026-05-19 11:50:44.297
45	9	FAN_SPEED_2	%	20	2026-05-19 11:50:44.298
49	10	FAN_SPEED_1	%	20	2026-05-19 11:50:44.311
48	10	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.309
10	2	FAN_SPEED_2	%	20	2026-05-19 11:50:44.173
47	10	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.308
50	10	FAN_SPEED_2	%	20	2026-05-19 11:50:44.312
46	10	LOAD	%	19.02	2026-05-19 11:50:44.306
7	2	CPU_TEMP	°C	26.5	2026-05-19 11:50:44.167
8	2	TOTAL_POWER	W	171.6	2026-05-19 11:50:44.169
2	1	CPU_TEMP	°C	24.26	2026-05-19 11:50:44.149
14	3	FAN_SPEED_1	%	20	2026-05-19 11:50:44.19
11	3	LOAD	%	19.02	2026-05-19 11:50:44.185
13	3	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.188
5	1	FAN_SPEED_2	%	20	2026-05-19 11:50:44.156
15	3	FAN_SPEED_2	%	20	2026-05-19 11:50:44.192
12	3	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.187
20	4	FAN_SPEED_2	%	20	2026-05-19 11:50:44.21
18	4	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.208
19	4	FAN_SPEED_1	%	20	2026-05-19 11:50:44.209
4	1	FAN_SPEED_1	%	20	2026-05-19 11:50:44.153
16	4	LOAD	%	19.02	2026-05-19 11:50:44.204
17	4	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.206
22	5	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.22
25	5	FAN_SPEED_2	%	20	2026-05-19 11:50:44.226
24	5	FAN_SPEED_1	%	20	2026-05-19 11:50:44.224
21	5	LOAD	%	19.02	2026-05-19 11:50:44.219
23	5	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.222
29	6	FAN_SPEED_1	%	20	2026-05-19 11:50:44.242
28	6	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.241
30	6	FAN_SPEED_2	%	20	2026-05-19 11:50:44.244
27	6	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.239
26	6	LOAD	%	19.02	2026-05-19 11:50:44.237
31	7	LOAD	%	19.02	2026-05-19 11:50:44.257
34	7	FAN_SPEED_1	%	20	2026-05-19 11:50:44.263
32	7	CPU_TEMP	°C	30.01	2026-05-19 11:50:44.259
35	7	FAN_SPEED_2	%	20	2026-05-19 11:50:44.265
33	7	TOTAL_POWER	W	194.76	2026-05-19 11:50:44.261
39	8	FAN_SPEED_1	%	20	2026-05-19 11:50:44.282
1	1	LOAD	%	12	2026-05-19 11:50:44.147
\.


--
-- Data for Name: sensor_data; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.sensor_data (id, "time", sensor_id, value) FROM stdin;
1	2026-05-18 00:00:00	21	20
3	2026-05-18 00:00:00	41	20
2	2026-05-18 00:00:00	26	20
4	2026-05-18 00:00:00	46	20
5	2026-05-18 00:00:00	16	20
6	2026-05-18 00:00:00	6	12
7	2026-05-18 00:00:00	31	20
8	2026-05-18 00:00:00	36	20
10	2026-05-18 00:00:00	11	20
9	2026-05-18 00:00:00	1	12
11	2026-05-18 00:00:00	22	28.46
12	2026-05-18 00:00:00	27	28.22
13	2026-05-18 00:00:00	17	28.46
14	2026-05-18 00:00:00	7	24.3
15	2026-05-18 00:00:00	42	28.48
16	2026-05-18 00:00:00	47	28.32
17	2026-05-18 00:00:00	32	28.2
18	2026-05-18 00:00:00	37	28.35
19	2026-05-18 00:00:00	12	28.25
20	2026-05-18 00:00:00	2	24.22
21	2026-05-18 00:00:00	23	198
22	2026-05-18 00:00:00	28	198
23	2026-05-18 00:00:00	8	171.6
24	2026-05-18 00:00:00	18	198
25	2026-05-18 00:00:00	38	198
26	2026-05-18 00:00:00	43	198
27	2026-05-18 00:00:00	48	198
28	2026-05-18 00:00:00	33	198
29	2026-05-18 00:00:00	3	171.6
30	2026-05-18 00:00:00	13	198
31	2026-05-18 00:00:00	24	20
32	2026-05-18 00:00:00	29	20
33	2026-05-18 00:00:00	19	20
34	2026-05-18 00:00:00	9	20
35	2026-05-18 00:00:00	49	20
36	2026-05-18 00:00:00	39	20
37	2026-05-18 00:00:00	44	20
38	2026-05-18 00:00:00	34	20
39	2026-05-18 00:00:00	4	20
40	2026-05-18 00:00:00	14	20
41	2026-05-18 00:00:00	25	20
42	2026-05-18 00:00:00	30	20
43	2026-05-18 00:00:00	50	20
44	2026-05-18 00:00:00	10	20
45	2026-05-18 00:00:00	20	20
46	2026-05-18 00:00:00	40	20
47	2026-05-18 00:00:00	45	20
48	2026-05-18 00:00:00	35	20
49	2026-05-18 00:00:00	15	20
50	2026-05-18 00:00:00	5	20
51	2026-05-18 01:00:00	1	12
52	2026-05-18 01:00:00	6	12
54	2026-05-18 01:00:00	16	20
53	2026-05-18 01:00:00	12	28.46
55	2026-05-18 01:00:00	21	20
56	2026-05-18 01:00:00	26	20
57	2026-05-18 01:00:00	36	20
58	2026-05-18 01:00:00	46	20
59	2026-05-18 01:00:00	41	20
60	2026-05-18 01:00:00	31	20
61	2026-05-18 01:00:00	2	24.31
62	2026-05-18 01:00:00	7	24.29
63	2026-05-18 01:00:00	47	28.29
64	2026-05-18 01:00:00	37	28.28
65	2026-05-18 01:00:00	32	28.43
66	2026-05-18 01:00:00	42	28.26
67	2026-05-18 01:00:00	22	28.34
68	2026-05-18 01:00:00	17	28.29
69	2026-05-18 01:00:00	27	28.3
70	2026-05-18 01:00:00	13	198
71	2026-05-18 01:00:00	48	198
72	2026-05-18 01:00:00	38	198
73	2026-05-18 01:00:00	43	198
74	2026-05-18 01:00:00	33	198
75	2026-05-18 01:00:00	3	171.6
76	2026-05-18 01:00:00	8	171.6
77	2026-05-18 01:00:00	28	198
78	2026-05-18 01:00:00	18	198
79	2026-05-18 01:00:00	23	198
80	2026-05-18 01:00:00	14	20
81	2026-05-18 01:00:00	49	20
82	2026-05-18 01:00:00	44	20
83	2026-05-18 01:00:00	39	20
84	2026-05-18 01:00:00	34	20
85	2026-05-18 01:00:00	4	20
86	2026-05-18 01:00:00	29	20
87	2026-05-18 01:00:00	9	20
88	2026-05-18 01:00:00	19	20
89	2026-05-18 01:00:00	24	20
90	2026-05-18 01:00:00	15	20
91	2026-05-18 01:00:00	50	20
92	2026-05-18 01:00:00	45	20
93	2026-05-18 01:00:00	20	20
94	2026-05-18 01:00:00	30	20
95	2026-05-18 01:00:00	5	20
96	2026-05-18 01:00:00	40	20
97	2026-05-18 01:00:00	35	20
98	2026-05-18 01:00:00	10	20
99	2026-05-18 01:00:00	25	20
100	2026-05-18 01:00:00	11	20
101	2026-05-18 02:00:00	3	171.6
103	2026-05-18 02:00:00	29	20
102	2026-05-18 02:00:00	33	198
104	2026-05-18 02:00:00	23	198
105	2026-05-18 02:00:00	8	171.6
107	2026-05-18 02:00:00	14	20
106	2026-05-18 02:00:00	18	198
109	2026-05-18 02:00:00	43	198
108	2026-05-18 02:00:00	38	198
110	2026-05-18 02:00:00	48	198
111	2026-05-18 02:00:00	4	20
112	2026-05-18 02:00:00	39	20
113	2026-05-18 02:00:00	9	20
114	2026-05-18 02:00:00	15	20
115	2026-05-18 02:00:00	34	20
116	2026-05-18 02:00:00	30	20
117	2026-05-18 02:00:00	19	20
118	2026-05-18 02:00:00	44	20
119	2026-05-18 02:00:00	24	20
120	2026-05-18 02:00:00	49	20
121	2026-05-18 02:00:00	40	20
122	2026-05-18 02:00:00	10	20
123	2026-05-18 02:00:00	26	20
124	2026-05-18 02:00:00	20	20
125	2026-05-18 02:00:00	45	20
126	2026-05-18 02:00:00	5	20
127	2026-05-18 02:00:00	36	20
128	2026-05-18 02:00:00	6	12
129	2026-05-18 02:00:00	11	20
130	2026-05-18 02:00:00	25	20
131	2026-05-18 02:00:00	35	20
132	2026-05-18 02:00:00	27	28.35
133	2026-05-18 02:00:00	50	20
134	2026-05-18 02:00:00	37	28.45
135	2026-05-18 02:00:00	7	24.28
136	2026-05-18 02:00:00	16	20
137	2026-05-18 02:00:00	1	12
145	2026-05-18 02:00:00	2	24.23
154	2026-05-18 03:00:00	28	198
162	2026-05-18 03:00:00	29	20
171	2026-05-18 03:00:00	30	20
175	2026-05-18 03:00:00	26	20
184	2026-05-18 03:00:00	27	28.34
206	2026-05-18 04:00:00	50	20
215	2026-05-18 04:00:00	46	20
227	2026-05-18 04:00:00	47	28.46
237	2026-05-18 04:00:00	48	198
247	2026-05-18 04:00:00	49	20
252	2026-05-18 05:00:00	12	28.43
268	2026-05-18 05:00:00	13	198
276	2026-05-18 05:00:00	14	20
285	2026-05-18 05:00:00	15	20
299	2026-05-18 05:00:00	11	20
1301	2026-05-19 02:00:00	2	24.25
1318	2026-05-19 02:00:00	3	171.6
1330	2026-05-19 02:00:00	4	20
1340	2026-05-19 02:00:00	5	20
1349	2026-05-19 02:00:00	1	12
1354	2026-05-19 03:00:00	14	20
1365	2026-05-19 03:00:00	15	20
1374	2026-05-19 03:00:00	11	20
1384	2026-05-19 03:00:00	12	28.41
1396	2026-05-19 03:00:00	13	198
1408	2026-05-19 04:00:00	23	198
1419	2026-05-19 04:00:00	24	20
1433	2026-05-19 04:00:00	25	20
1442	2026-05-19 04:00:00	21	20
1450	2026-05-19 04:00:00	22	28.36
1452	2026-05-19 05:00:00	3	171.6
1463	2026-05-19 05:00:00	4	20
1473	2026-05-19 05:00:00	5	20
1482	2026-05-19 05:00:00	1	12
1489	2026-05-19 05:00:00	2	24.47
1509	2026-05-19 06:00:00	41	20
1516	2026-05-19 06:00:00	42	28.47
1526	2026-05-19 06:00:00	43	198
1536	2026-05-19 06:00:00	44	20
1545	2026-05-19 06:00:00	45	20
1554	2026-05-19 07:00:00	17	28.34
1568	2026-05-19 07:00:00	18	198
1580	2026-05-19 07:00:00	19	20
1586	2026-05-19 07:00:00	20	20
1595	2026-05-19 07:00:00	16	20
1605	2026-05-19 08:00:00	25	20
1616	2026-05-19 08:00:00	21	20
1627	2026-05-19 08:00:00	22	28.46
1636	2026-05-19 08:00:00	23	198
1645	2026-05-19 08:00:00	24	20
1655	2026-05-19 09:00:00	22	28.35
1664	2026-05-19 09:00:00	23	198
1673	2026-05-19 09:00:00	24	20
1687	2026-05-19 09:00:00	25	20
1693	2026-05-19 09:00:00	21	20
1710	2026-05-19 10:00:00	31	20
1718	2026-05-19 10:00:00	32	28.42
1729	2026-05-19 10:00:00	33	198
1740	2026-05-19 10:00:00	34	20
1748	2026-05-19 10:00:00	35	20
1754	2026-05-19 11:00:00	16	20
1762	2026-05-19 11:00:00	17	28.41
1771	2026-05-19 11:00:00	18	198
1782	2026-05-19 11:00:00	19	20
1792	2026-05-19 11:00:00	20	20
2309	2026-05-19 22:00:00	40	20
2319	2026-05-19 22:00:00	36	20
2330	2026-05-19 22:00:00	37	28.25
2341	2026-05-19 22:00:00	38	198
2348	2026-05-19 22:00:00	39	20
2353	2026-05-19 23:00:00	16	20
2366	2026-05-19 23:00:00	17	28.44
2376	2026-05-19 23:00:00	18	198
2387	2026-05-19 23:00:00	19	20
2398	2026-05-19 23:00:00	20	20
2404	2026-05-20 00:00:00	13	198
2411	2026-05-20 00:00:00	14	20
2421	2026-05-20 00:00:00	15	20
2427	2026-05-20 00:00:00	11	20
2433	2026-05-20 00:00:00	12	28.42
2460	2026-05-20 01:00:00	46	20
2470	2026-05-20 01:00:00	47	28.25
2478	2026-05-20 01:00:00	48	198
2487	2026-05-20 01:00:00	49	20
2496	2026-05-20 01:00:00	50	20
2505	2026-05-20 02:00:00	26	20
2516	2026-05-20 02:00:00	27	28.22
2528	2026-05-20 02:00:00	28	198
2540	2026-05-20 02:00:00	29	20
2546	2026-05-20 02:00:00	30	20
2554	2026-05-20 03:00:00	19	20
2563	2026-05-20 03:00:00	20	20
2571	2026-05-20 03:00:00	16	20
2583	2026-05-20 03:00:00	17	28.35
2594	2026-05-20 03:00:00	18	198
2609	2026-05-20 04:00:00	36	20
2618	2026-05-20 04:00:00	37	28.24
2627	2026-05-20 04:00:00	38	198
2636	2026-05-20 04:00:00	39	20
2646	2026-05-20 04:00:00	40	20
2656	2026-05-20 05:00:00	26	20
2670	2026-05-20 05:00:00	27	28.48
2679	2026-05-20 05:00:00	28	198
2689	2026-05-20 05:00:00	29	20
2699	2026-05-20 05:00:00	30	20
2702	2026-05-20 06:00:00	10	20
2717	2026-05-20 06:00:00	6	12
2729	2026-05-20 06:00:00	7	24.33
2743	2026-05-20 06:00:00	8	171.6
2749	2026-05-20 06:00:00	9	20
2753	2026-05-20 07:00:00	10	20
2763	2026-05-20 07:00:00	6	12
2772	2026-05-20 07:00:00	7	24.22
2782	2026-05-20 07:00:00	8	171.6
2790	2026-05-20 07:00:00	9	20
2801	2026-05-20 08:00:00	2	24.27
2814	2026-05-20 08:00:00	3	171.6
2825	2026-05-20 08:00:00	4	20
2838	2026-05-20 08:00:00	5	20
2845	2026-05-20 08:00:00	1	12
2857	2026-05-20 09:00:00	16	20
2864	2026-05-20 09:00:00	17	28.32
2878	2026-05-20 09:00:00	18	198
2889	2026-05-20 09:00:00	19	20
2898	2026-05-20 09:00:00	20	20
2903	2026-05-20 10:00:00	15	20
2912	2026-05-20 10:00:00	13	198
2922	2026-05-20 10:00:00	11	20
2926	2026-05-20 10:00:00	14	20
2936	2026-05-20 10:00:00	12	28.35
2959	2026-05-20 11:00:00	42	28.24
2963	2026-05-20 11:00:00	45	20
2973	2026-05-20 11:00:00	43	198
2977	2026-05-20 11:00:00	44	20
138	2026-05-18 02:00:00	28	198
153	2026-05-18 03:00:00	38	198
166	2026-05-18 03:00:00	39	20
180	2026-05-18 03:00:00	40	20
188	2026-05-18 03:00:00	36	20
196	2026-05-18 03:00:00	37	28.32
202	2026-05-18 04:00:00	11	20
216	2026-05-18 04:00:00	12	28.49
225	2026-05-18 04:00:00	13	198
235	2026-05-18 04:00:00	14	20
243	2026-05-18 04:00:00	15	20
251	2026-05-18 05:00:00	21	20
267	2026-05-18 05:00:00	22	28.49
277	2026-05-18 05:00:00	23	198
290	2026-05-18 05:00:00	24	20
296	2026-05-18 05:00:00	25	20
1302	2026-05-19 02:00:00	25	20
1311	2026-05-19 02:00:00	21	20
1322	2026-05-19 02:00:00	22	28.29
1334	2026-05-19 02:00:00	23	198
1344	2026-05-19 02:00:00	24	20
1358	2026-05-19 03:00:00	27	28.25
1367	2026-05-19 03:00:00	28	198
1373	2026-05-19 03:00:00	29	20
1388	2026-05-19 03:00:00	30	20
1398	2026-05-19 03:00:00	26	20
1401	2026-05-19 04:00:00	5	20
1411	2026-05-19 04:00:00	1	12
1425	2026-05-19 04:00:00	2	24.37
1437	2026-05-19 04:00:00	3	171.6
1445	2026-05-19 04:00:00	4	20
1457	2026-05-19 05:00:00	32	28.47
1461	2026-05-19 05:00:00	33	198
1471	2026-05-19 05:00:00	34	20
1480	2026-05-19 05:00:00	35	20
1490	2026-05-19 05:00:00	31	20
1510	2026-05-19 06:00:00	46	20
1513	2026-05-19 06:00:00	47	28.22
1524	2026-05-19 06:00:00	48	198
1535	2026-05-19 06:00:00	49	20
1547	2026-05-19 06:00:00	50	20
1559	2026-05-19 07:00:00	36	20
1569	2026-05-19 07:00:00	37	28.39
1578	2026-05-19 07:00:00	38	198
1589	2026-05-19 07:00:00	39	20
1597	2026-05-19 07:00:00	40	20
1602	2026-05-19 08:00:00	10	20
1612	2026-05-19 08:00:00	6	12
1622	2026-05-19 08:00:00	7	24.45
1631	2026-05-19 08:00:00	8	171.6
1641	2026-05-19 08:00:00	9	20
1659	2026-05-19 09:00:00	44	20
1669	2026-05-19 09:00:00	45	20
1678	2026-05-19 09:00:00	41	20
1689	2026-05-19 09:00:00	42	28.33
1697	2026-05-19 09:00:00	43	198
1709	2026-05-19 10:00:00	25	20
1720	2026-05-19 10:00:00	21	20
1731	2026-05-19 10:00:00	22	28.38
1742	2026-05-19 10:00:00	23	198
1749	2026-05-19 10:00:00	24	20
1751	2026-05-19 11:00:00	4	20
1761	2026-05-19 11:00:00	5	20
1773	2026-05-19 11:00:00	1	12
1783	2026-05-19 11:00:00	2	24.46
1796	2026-05-19 11:00:00	3	171.6
2310	2026-05-19 22:00:00	33	198
2320	2026-05-19 22:00:00	34	20
2325	2026-05-19 22:00:00	35	20
2331	2026-05-19 22:00:00	31	20
2336	2026-05-19 22:00:00	32	28.23
2359	2026-05-19 23:00:00	40	20
2364	2026-05-19 23:00:00	36	20
2374	2026-05-19 23:00:00	37	28.25
2383	2026-05-19 23:00:00	38	198
2390	2026-05-19 23:00:00	39	20
2410	2026-05-20 00:00:00	42	28.2
2414	2026-05-20 00:00:00	43	198
2424	2026-05-20 00:00:00	44	20
2438	2026-05-20 00:00:00	45	20
2445	2026-05-20 00:00:00	41	20
2454	2026-05-20 01:00:00	26	20
2468	2026-05-20 01:00:00	27	28.4
2474	2026-05-20 01:00:00	28	198
2486	2026-05-20 01:00:00	29	20
2494	2026-05-20 01:00:00	30	20
2507	2026-05-20 02:00:00	40	20
2517	2026-05-20 02:00:00	36	20
2526	2026-05-20 02:00:00	37	28.2
2536	2026-05-20 02:00:00	38	198
2548	2026-05-20 02:00:00	39	20
2552	2026-05-20 03:00:00	6	12
2565	2026-05-20 03:00:00	7	24.4
2574	2026-05-20 03:00:00	8	171.6
2586	2026-05-20 03:00:00	9	20
2595	2026-05-20 03:00:00	10	20
2607	2026-05-20 04:00:00	28	198
2616	2026-05-20 04:00:00	29	20
2625	2026-05-20 04:00:00	30	20
2635	2026-05-20 04:00:00	26	20
2645	2026-05-20 04:00:00	27	28.26
2653	2026-05-20 05:00:00	22	28.34
2669	2026-05-20 05:00:00	23	198
2680	2026-05-20 05:00:00	24	20
2690	2026-05-20 05:00:00	25	20
2700	2026-05-20 05:00:00	21	20
2701	2026-05-20 06:00:00	1	12
2713	2026-05-20 06:00:00	2	24.42
2723	2026-05-20 06:00:00	3	171.6
2731	2026-05-20 06:00:00	4	20
2744	2026-05-20 06:00:00	5	20
2755	2026-05-20 07:00:00	30	20
2768	2026-05-20 07:00:00	26	20
2779	2026-05-20 07:00:00	27	28.44
2789	2026-05-20 07:00:00	28	198
2796	2026-05-20 07:00:00	29	20
2802	2026-05-20 08:00:00	6	12
2815	2026-05-20 08:00:00	9	20
2828	2026-05-20 08:00:00	7	24.34
2839	2026-05-20 08:00:00	8	171.6
2848	2026-05-20 08:00:00	10	20
2852	2026-05-20 09:00:00	14	20
2861	2026-05-20 09:00:00	12	28.48
2871	2026-05-20 09:00:00	15	20
2881	2026-05-20 09:00:00	13	198
2888	2026-05-20 09:00:00	11	20
2910	2026-05-20 10:00:00	49	20
2918	2026-05-20 10:00:00	48	198
2931	2026-05-20 10:00:00	50	20
2941	2026-05-20 10:00:00	46	20
2949	2026-05-20 10:00:00	47	28.38
2951	2026-05-20 11:00:00	8	171.6
2965	2026-05-20 11:00:00	10	20
2982	2026-05-20 11:00:00	6	12
2988	2026-05-20 11:00:00	9	20
2996	2026-05-20 11:00:00	7	24.41
139	2026-05-18 02:00:00	41	20
146	2026-05-18 02:00:00	42	28.32
155	2026-05-18 03:00:00	16	20
167	2026-05-18 03:00:00	17	28.37
178	2026-05-18 03:00:00	18	198
189	2026-05-18 03:00:00	19	20
198	2026-05-18 03:00:00	20	20
207	2026-05-18 04:00:00	28	198
213	2026-05-18 04:00:00	29	20
222	2026-05-18 04:00:00	30	20
231	2026-05-18 04:00:00	26	20
242	2026-05-18 04:00:00	27	28.29
256	2026-05-18 05:00:00	41	20
266	2026-05-18 05:00:00	42	28.22
278	2026-05-18 05:00:00	43	198
286	2026-05-18 05:00:00	44	20
300	2026-05-18 05:00:00	45	20
1305	2026-05-19 02:00:00	19	20
1313	2026-05-19 02:00:00	20	20
1325	2026-05-19 02:00:00	16	20
1337	2026-05-19 02:00:00	17	28.25
1347	2026-05-19 02:00:00	18	198
1353	2026-05-19 03:00:00	20	20
1363	2026-05-19 03:00:00	16	20
1375	2026-05-19 03:00:00	17	28.29
1383	2026-05-19 03:00:00	18	198
1397	2026-05-19 03:00:00	19	20
1404	2026-05-19 04:00:00	7	24.41
1415	2026-05-19 04:00:00	8	171.6
1421	2026-05-19 04:00:00	9	20
1429	2026-05-19 04:00:00	10	20
1441	2026-05-19 04:00:00	6	12
1454	2026-05-19 05:00:00	27	28.37
1469	2026-05-19 05:00:00	28	198
1481	2026-05-19 05:00:00	29	20
1492	2026-05-19 05:00:00	30	20
1500	2026-05-19 05:00:00	26	20
1501	2026-05-19 06:00:00	3	171.6
1514	2026-05-19 06:00:00	4	20
1521	2026-05-19 06:00:00	5	20
1531	2026-05-19 06:00:00	1	12
1541	2026-05-19 06:00:00	2	24.39
1560	2026-05-19 07:00:00	46	20
1567	2026-05-19 07:00:00	47	28.29
1576	2026-05-19 07:00:00	48	198
1584	2026-05-19 07:00:00	49	20
1587	2026-05-19 07:00:00	50	20
1609	2026-05-19 08:00:00	47	28.41
1615	2026-05-19 08:00:00	48	198
1625	2026-05-19 08:00:00	49	20
1637	2026-05-19 08:00:00	50	20
1649	2026-05-19 08:00:00	46	20
1651	2026-05-19 09:00:00	7	24.46
1665	2026-05-19 09:00:00	8	171.6
1674	2026-05-19 09:00:00	9	20
1686	2026-05-19 09:00:00	10	20
1692	2026-05-19 09:00:00	6	12
1707	2026-05-19 10:00:00	37	28.33
1712	2026-05-19 10:00:00	38	198
1725	2026-05-19 10:00:00	39	20
1736	2026-05-19 10:00:00	40	20
1745	2026-05-19 10:00:00	36	20
1753	2026-05-19 11:00:00	24	20
1765	2026-05-19 11:00:00	25	20
1775	2026-05-19 11:00:00	21	20
1784	2026-05-19 11:00:00	22	28.24
1793	2026-05-19 11:00:00	23	198
2803	2026-05-20 08:00:00	22	28.37
2820	2026-05-20 08:00:00	25	20
2832	2026-05-20 08:00:00	23	198
2843	2026-05-20 08:00:00	24	20
2850	2026-05-20 08:00:00	21	20
2853	2026-05-20 09:00:00	2	24.23
2863	2026-05-20 09:00:00	3	171.6
2876	2026-05-20 09:00:00	4	20
2886	2026-05-20 09:00:00	5	20
2895	2026-05-20 09:00:00	1	12
2907	2026-05-20 10:00:00	29	20
2919	2026-05-20 10:00:00	27	28.32
2933	2026-05-20 10:00:00	28	198
2945	2026-05-20 10:00:00	30	20
2950	2026-05-20 10:00:00	26	20
2952	2026-05-20 11:00:00	2	24.43
2964	2026-05-20 11:00:00	3	171.6
2980	2026-05-20 11:00:00	4	20
2991	2026-05-20 11:00:00	5	20
3000	2026-05-20 11:00:00	1	12
3002	2026-05-20 12:00:00	5	20
3012	2026-05-20 12:00:00	1	12
3024	2026-05-20 12:00:00	2	24.4
3034	2026-05-20 12:00:00	3	171.6
3044	2026-05-20 12:00:00	4	20
3058	2026-05-20 13:00:00	34	20
3061	2026-05-20 13:00:00	32	28.25
3072	2026-05-20 13:00:00	35	20
3082	2026-05-20 13:00:00	33	198
3090	2026-05-20 13:00:00	31	20
3108	2026-05-20 14:00:00	47	28.26
3121	2026-05-20 14:00:00	49	20
3132	2026-05-20 14:00:00	48	198
3142	2026-05-20 14:00:00	50	20
3148	2026-05-20 14:00:00	46	20
3153	2026-05-20 15:00:00	12	28.34
3163	2026-05-20 15:00:00	15	20
3171	2026-05-20 15:00:00	13	198
3175	2026-05-20 15:00:00	11	20
3183	2026-05-20 15:00:00	14	20
3209	2026-05-20 16:00:00	49	20
3217	2026-05-20 16:00:00	48	198
3226	2026-05-20 16:00:00	50	20
3234	2026-05-20 16:00:00	46	20
3244	2026-05-20 16:00:00	47	28.46
3733	2026-05-21 03:00:00	6	12
3742	2026-05-21 03:00:00	9	20
3974	2026-05-21 08:00:00	43	198
3986	2026-05-21 08:00:00	44	20
3993	2026-05-21 08:00:00	41	20
4009	2026-05-21 09:00:00	39	20
4021	2026-05-21 09:00:00	40	20
4033	2026-05-21 09:00:00	36	20
4043	2026-05-21 09:00:00	38	198
4049	2026-05-21 09:00:00	37	28.32
4051	2026-05-21 10:00:00	6	12
4063	2026-05-21 10:00:00	8	171.6
4076	2026-05-21 10:00:00	10	20
4085	2026-05-21 10:00:00	9	20
4095	2026-05-21 10:00:00	7	24.43
4104	2026-05-21 11:00:00	27	28.44
4112	2026-05-21 11:00:00	26	20
4121	2026-05-21 11:00:00	29	20
4125	2026-05-21 11:00:00	28	198
4134	2026-05-21 11:00:00	30	20
4160	2026-05-21 12:00:00	50	20
4172	2026-05-21 12:00:00	46	46
4184	2026-05-21 12:00:00	47	41.41
4192	2026-05-21 12:00:00	49	20
140	2026-05-18 02:00:00	17	28.32
158	2026-05-18 03:00:00	31	20
168	2026-05-18 03:00:00	32	28.24
176	2026-05-18 03:00:00	33	198
183	2026-05-18 03:00:00	34	20
194	2026-05-18 03:00:00	35	20
210	2026-05-18 04:00:00	38	198
221	2026-05-18 04:00:00	39	20
239	2026-05-18 04:00:00	40	20
249	2026-05-18 04:00:00	36	20
250	2026-05-18 04:00:00	37	28.47
259	2026-05-18 05:00:00	1	12
265	2026-05-18 05:00:00	2	24.27
275	2026-05-18 05:00:00	3	171.6
288	2026-05-18 05:00:00	4	20
294	2026-05-18 05:00:00	5	20
1303	2026-05-19 02:00:00	14	20
1319	2026-05-19 02:00:00	15	20
1327	2026-05-19 02:00:00	11	20
1336	2026-05-19 02:00:00	12	28.27
1345	2026-05-19 02:00:00	13	198
1355	2026-05-19 03:00:00	21	20
1364	2026-05-19 03:00:00	22	28.4
1371	2026-05-19 03:00:00	23	198
1382	2026-05-19 03:00:00	24	20
1392	2026-05-19 03:00:00	25	20
1406	2026-05-19 04:00:00	29	20
1418	2026-05-19 04:00:00	30	20
1424	2026-05-19 04:00:00	26	20
1436	2026-05-19 04:00:00	27	28.28
1443	2026-05-19 04:00:00	28	198
1458	2026-05-19 05:00:00	45	20
1468	2026-05-19 05:00:00	41	20
1478	2026-05-19 05:00:00	42	28.33
1484	2026-05-19 05:00:00	43	198
1494	2026-05-19 05:00:00	44	20
1508	2026-05-19 06:00:00	31	20
1519	2026-05-19 06:00:00	32	28.26
1530	2026-05-19 06:00:00	33	198
1540	2026-05-19 06:00:00	34	20
1549	2026-05-19 06:00:00	35	20
1553	2026-05-19 07:00:00	15	20
1565	2026-05-19 07:00:00	11	20
1574	2026-05-19 07:00:00	12	28.24
1598	2026-05-19 07:00:00	13	198
1600	2026-05-19 07:00:00	14	20
1601	2026-05-19 08:00:00	4	20
1611	2026-05-19 08:00:00	5	20
1623	2026-05-19 08:00:00	1	12
1635	2026-05-19 08:00:00	2	24.24
1644	2026-05-19 08:00:00	3	171.6
1657	2026-05-19 09:00:00	38	198
1667	2026-05-19 09:00:00	39	20
1676	2026-05-19 09:00:00	40	20
1685	2026-05-19 09:00:00	36	20
1696	2026-05-19 09:00:00	37	28.36
1708	2026-05-19 10:00:00	16	20
1716	2026-05-19 10:00:00	17	28.4
1728	2026-05-19 10:00:00	18	198
1738	2026-05-19 10:00:00	19	20
1744	2026-05-19 10:00:00	20	20
1760	2026-05-19 11:00:00	31	20
1770	2026-05-19 11:00:00	32	28.33
1779	2026-05-19 11:00:00	33	198
1785	2026-05-19 11:00:00	34	20
1798	2026-05-19 11:00:00	35	20
2804	2026-05-20 08:00:00	16	20
2811	2026-05-20 08:00:00	17	28.27
2821	2026-05-20 08:00:00	18	198
2827	2026-05-20 08:00:00	19	20
2840	2026-05-20 08:00:00	20	20
2855	2026-05-20 09:00:00	42	28.46
2862	2026-05-20 09:00:00	45	20
2874	2026-05-20 09:00:00	43	198
2884	2026-05-20 09:00:00	44	20
2890	2026-05-20 09:00:00	41	20
2909	2026-05-20 10:00:00	38	198
2916	2026-05-20 10:00:00	37	28.19
2923	2026-05-20 10:00:00	39	20
2930	2026-05-20 10:00:00	40	20
2942	2026-05-20 10:00:00	36	20
2956	2026-05-20 11:00:00	32	28.34
2968	2026-05-20 11:00:00	35	20
2981	2026-05-20 11:00:00	33	198
2990	2026-05-20 11:00:00	31	20
2998	2026-05-20 11:00:00	34	20
3004	2026-05-20 12:00:00	14	20
3018	2026-05-20 12:00:00	12	41.26
3027	2026-05-20 12:00:00	15	20
3035	2026-05-20 12:00:00	13	283.8
3045	2026-05-20 12:00:00	11	46
3052	2026-05-20 13:00:00	20	20
3066	2026-05-20 13:00:00	16	20
3075	2026-05-20 13:00:00	17	28.27
3088	2026-05-20 13:00:00	18	198
3098	2026-05-20 13:00:00	19	20
3106	2026-05-20 14:00:00	16	20
3115	2026-05-20 14:00:00	17	28.36
3123	2026-05-20 14:00:00	18	198
3131	2026-05-20 14:00:00	19	20
3136	2026-05-20 14:00:00	20	20
3160	2026-05-20 15:00:00	48	198
3165	2026-05-20 15:00:00	50	20
3178	2026-05-20 15:00:00	46	20
3187	2026-05-20 15:00:00	47	28.41
3195	2026-05-20 15:00:00	49	20
3205	2026-05-20 16:00:00	29	20
3214	2026-05-20 16:00:00	27	28.47
3225	2026-05-20 16:00:00	28	198
3235	2026-05-20 16:00:00	30	20
3245	2026-05-20 16:00:00	26	20
3738	2026-05-21 03:00:00	4	20
3748	2026-05-21 03:00:00	5	20
3983	2026-05-21 08:00:00	33	198
3995	2026-05-21 08:00:00	31	20
4007	2026-05-21 09:00:00	35	20
4015	2026-05-21 09:00:00	33	198
4030	2026-05-21 09:00:00	31	20
4041	2026-05-21 09:00:00	34	20
4046	2026-05-21 09:00:00	32	28.32
4053	2026-05-21 10:00:00	17	28.22
4061	2026-05-21 10:00:00	16	20
4071	2026-05-21 10:00:00	19	20
4084	2026-05-21 10:00:00	20	20
4094	2026-05-21 10:00:00	18	198
4106	2026-05-21 11:00:00	40	20
4113	2026-05-21 11:00:00	36	20
4123	2026-05-21 11:00:00	38	198
4133	2026-05-21 11:00:00	37	28.22
4144	2026-05-21 11:00:00	39	20
4158	2026-05-21 12:00:00	41	46
4171	2026-05-21 12:00:00	42	41.21
4183	2026-05-21 12:00:00	45	20
4193	2026-05-21 12:00:00	43	283.8
4200	2026-05-21 12:00:00	44	20
4201	2026-05-21 13:00:00	1	12
141	2026-05-18 02:00:00	12	28.4
147	2026-05-18 02:00:00	13	198
156	2026-05-18 03:00:00	21	20
164	2026-05-18 03:00:00	22	28.28
173	2026-05-18 03:00:00	23	198
185	2026-05-18 03:00:00	24	20
195	2026-05-18 03:00:00	25	20
208	2026-05-18 04:00:00	16	20
214	2026-05-18 04:00:00	17	28.23
224	2026-05-18 04:00:00	18	198
230	2026-05-18 04:00:00	19	20
240	2026-05-18 04:00:00	20	20
255	2026-05-18 05:00:00	46	20
270	2026-05-18 05:00:00	47	28.41
279	2026-05-18 05:00:00	48	198
289	2026-05-18 05:00:00	49	20
295	2026-05-18 05:00:00	50	20
1304	2026-05-19 02:00:00	26	20
1317	2026-05-19 02:00:00	27	28.23
1323	2026-05-19 02:00:00	28	198
1332	2026-05-19 02:00:00	29	20
1341	2026-05-19 02:00:00	30	20
1356	2026-05-19 03:00:00	39	20
1368	2026-05-19 03:00:00	40	20
1378	2026-05-19 03:00:00	36	20
1389	2026-05-19 03:00:00	37	28.36
1400	2026-05-19 03:00:00	38	198
1407	2026-05-19 04:00:00	20	20
1416	2026-05-19 04:00:00	16	20
1422	2026-05-19 04:00:00	17	28.22
1430	2026-05-19 04:00:00	18	198
1438	2026-05-19 04:00:00	19	20
1459	2026-05-19 05:00:00	37	28.2
1464	2026-05-19 05:00:00	38	198
1477	2026-05-19 05:00:00	39	20
1488	2026-05-19 05:00:00	40	20
1495	2026-05-19 05:00:00	36	20
1506	2026-05-19 06:00:00	24	20
1512	2026-05-19 06:00:00	25	20
1523	2026-05-19 06:00:00	21	20
1534	2026-05-19 06:00:00	22	28.19
1544	2026-05-19 06:00:00	23	198
1556	2026-05-19 07:00:00	24	20
1561	2026-05-19 07:00:00	25	20
1571	2026-05-19 07:00:00	21	20
1583	2026-05-19 07:00:00	22	28.34
1592	2026-05-19 07:00:00	23	198
1610	2026-05-19 08:00:00	42	28.22
1620	2026-05-19 08:00:00	43	198
1632	2026-05-19 08:00:00	44	20
1642	2026-05-19 08:00:00	45	20
1650	2026-05-19 08:00:00	41	20
1652	2026-05-19 09:00:00	1	12
1666	2026-05-19 09:00:00	2	24.44
1677	2026-05-19 09:00:00	3	171.6
1690	2026-05-19 09:00:00	4	20
1698	2026-05-19 09:00:00	5	20
1703	2026-05-19 10:00:00	15	20
1715	2026-05-19 10:00:00	11	20
1722	2026-05-19 10:00:00	12	28.2
1733	2026-05-19 10:00:00	13	198
1737	2026-05-19 10:00:00	14	20
1757	2026-05-19 11:00:00	42	28.26
1767	2026-05-19 11:00:00	43	198
1774	2026-05-19 11:00:00	44	20
1789	2026-05-19 11:00:00	45	20
1800	2026-05-19 11:00:00	41	20
2805	2026-05-20 08:00:00	26	20
2812	2026-05-20 08:00:00	29	20
2822	2026-05-20 08:00:00	27	28.47
2826	2026-05-20 08:00:00	28	198
2834	2026-05-20 08:00:00	30	20
2856	2026-05-20 09:00:00	46	20
2865	2026-05-20 09:00:00	47	28.28
2872	2026-05-20 09:00:00	49	20
2883	2026-05-20 09:00:00	48	198
2896	2026-05-20 09:00:00	50	20
2905	2026-05-20 10:00:00	25	20
2915	2026-05-20 10:00:00	23	198
2928	2026-05-20 10:00:00	24	20
2938	2026-05-20 10:00:00	21	20
2946	2026-05-20 10:00:00	22	28.39
2957	2026-05-20 11:00:00	21	20
2969	2026-05-20 11:00:00	22	28.4
2978	2026-05-20 11:00:00	25	20
2989	2026-05-20 11:00:00	23	198
2997	2026-05-20 11:00:00	24	20
3003	2026-05-20 12:00:00	20	20
3017	2026-05-20 12:00:00	16	46
3028	2026-05-20 12:00:00	17	41.32
3038	2026-05-20 12:00:00	18	283.8
3047	2026-05-20 12:00:00	19	20
3056	2026-05-20 13:00:00	28	198
3068	2026-05-20 13:00:00	30	20
3076	2026-05-20 13:00:00	26	20
3085	2026-05-20 13:00:00	29	20
3096	2026-05-20 13:00:00	27	28.21
3103	2026-05-20 14:00:00	15	20
3112	2026-05-20 14:00:00	13	198
3120	2026-05-20 14:00:00	11	20
3125	2026-05-20 14:00:00	14	20
3138	2026-05-20 14:00:00	12	28.32
3154	2026-05-20 15:00:00	37	28.39
3167	2026-05-20 15:00:00	39	20
3179	2026-05-20 15:00:00	40	20
3189	2026-05-20 15:00:00	36	20
3197	2026-05-20 15:00:00	38	198
3203	2026-05-20 16:00:00	12	28.39
3215	2026-05-20 16:00:00	15	20
3224	2026-05-20 16:00:00	13	198
3236	2026-05-20 16:00:00	11	20
3246	2026-05-20 16:00:00	14	20
3739	2026-05-21 03:00:00	21	20
3749	2026-05-21 03:00:00	22	28.28
3996	2026-05-21 08:00:00	4	20
4003	2026-05-21 09:00:00	24	20
4013	2026-05-21 09:00:00	23	198
4023	2026-05-21 09:00:00	22	28.28
4029	2026-05-21 09:00:00	21	20
4037	2026-05-21 09:00:00	25	20
4060	2026-05-21 10:00:00	43	198
4070	2026-05-21 10:00:00	44	20
4074	2026-05-21 10:00:00	41	20
4083	2026-05-21 10:00:00	42	28.46
4093	2026-05-21 10:00:00	45	20
4107	2026-05-21 11:00:00	41	20
4114	2026-05-21 11:00:00	42	28.38
4122	2026-05-21 11:00:00	45	20
4132	2026-05-21 11:00:00	43	198
4143	2026-05-21 11:00:00	44	20
4155	2026-05-21 12:00:00	27	41.44
4163	2026-05-21 12:00:00	26	46
4169	2026-05-21 12:00:00	29	20
4176	2026-05-21 12:00:00	28	283.8
4186	2026-05-21 12:00:00	30	20
4209	2026-05-21 13:00:00	42	28.31
142	2026-05-18 02:00:00	21	20
148	2026-05-18 02:00:00	22	28.19
157	2026-05-18 03:00:00	12	28.48
170	2026-05-18 03:00:00	13	198
181	2026-05-18 03:00:00	14	20
191	2026-05-18 03:00:00	15	20
200	2026-05-18 03:00:00	11	20
203	2026-05-18 04:00:00	8	171.6
212	2026-05-18 04:00:00	9	20
223	2026-05-18 04:00:00	10	20
232	2026-05-18 04:00:00	6	12
241	2026-05-18 04:00:00	7	24.48
254	2026-05-18 05:00:00	38	198
261	2026-05-18 05:00:00	39	20
271	2026-05-18 05:00:00	40	20
284	2026-05-18 05:00:00	36	20
297	2026-05-18 05:00:00	37	28.48
1306	2026-05-19 02:00:00	31	20
1312	2026-05-19 02:00:00	32	28.38
1321	2026-05-19 02:00:00	33	198
1331	2026-05-19 02:00:00	34	20
1339	2026-05-19 02:00:00	35	20
1357	2026-05-19 03:00:00	48	198
1366	2026-05-19 03:00:00	49	20
1376	2026-05-19 03:00:00	50	20
1386	2026-05-19 03:00:00	46	20
1394	2026-05-19 03:00:00	47	28.48
1403	2026-05-19 04:00:00	40	20
1412	2026-05-19 04:00:00	36	20
1426	2026-05-19 04:00:00	37	28.39
1435	2026-05-19 04:00:00	38	198
1447	2026-05-19 04:00:00	39	20
1456	2026-05-19 05:00:00	25	20
1470	2026-05-19 05:00:00	21	20
1476	2026-05-19 05:00:00	22	28.47
1485	2026-05-19 05:00:00	23	198
1499	2026-05-19 05:00:00	24	20
1505	2026-05-19 06:00:00	17	28.27
1518	2026-05-19 06:00:00	18	198
1527	2026-05-19 06:00:00	19	20
1537	2026-05-19 06:00:00	20	20
1548	2026-05-19 06:00:00	16	20
1552	2026-05-19 07:00:00	9	20
1564	2026-05-19 07:00:00	10	20
1575	2026-05-19 07:00:00	6	12
1585	2026-05-19 07:00:00	7	24.36
1594	2026-05-19 07:00:00	8	171.6
1606	2026-05-19 08:00:00	26	20
1619	2026-05-19 08:00:00	27	28.43
1626	2026-05-19 08:00:00	28	198
1633	2026-05-19 08:00:00	29	20
1643	2026-05-19 08:00:00	30	20
1658	2026-05-19 09:00:00	33	198
1663	2026-05-19 09:00:00	34	20
1683	2026-05-19 09:00:00	35	20
1694	2026-05-19 09:00:00	31	20
1700	2026-05-19 09:00:00	32	28.19
1702	2026-05-19 10:00:00	10	20
1714	2026-05-19 10:00:00	6	12
1726	2026-05-19 10:00:00	7	24.48
1735	2026-05-19 10:00:00	8	171.6
1746	2026-05-19 10:00:00	9	20
1756	2026-05-19 11:00:00	28	198
1768	2026-05-19 11:00:00	29	20
1780	2026-05-19 11:00:00	30	20
1790	2026-05-19 11:00:00	26	20
1797	2026-05-19 11:00:00	27	28.32
2806	2026-05-20 08:00:00	14	20
2817	2026-05-20 08:00:00	12	28.39
2829	2026-05-20 08:00:00	15	20
2836	2026-05-20 08:00:00	13	198
2844	2026-05-20 08:00:00	11	20
2860	2026-05-20 09:00:00	34	20
2869	2026-05-20 09:00:00	32	28.34
2880	2026-05-20 09:00:00	35	20
2891	2026-05-20 09:00:00	33	198
2899	2026-05-20 09:00:00	31	20
2901	2026-05-20 10:00:00	9	20
2913	2026-05-20 10:00:00	7	24.4
2929	2026-05-20 10:00:00	8	171.6
2937	2026-05-20 10:00:00	10	20
2943	2026-05-20 10:00:00	6	12
2955	2026-05-20 11:00:00	40	20
2961	2026-05-20 11:00:00	36	20
2971	2026-05-20 11:00:00	38	198
2975	2026-05-20 11:00:00	37	28.42
2992	2026-05-20 11:00:00	39	20
3007	2026-05-20 12:00:00	24	20
3014	2026-05-20 12:00:00	21	46
3025	2026-05-20 12:00:00	22	41.28
3032	2026-05-20 12:00:00	25	20
3040	2026-05-20 12:00:00	23	283.8
3059	2026-05-20 13:00:00	42	28.24
3069	2026-05-20 13:00:00	45	20
3078	2026-05-20 13:00:00	43	198
3087	2026-05-20 13:00:00	44	20
3099	2026-05-20 13:00:00	41	20
3102	2026-05-20 14:00:00	10	20
3111	2026-05-20 14:00:00	6	12
3119	2026-05-20 14:00:00	9	20
3124	2026-05-20 14:00:00	7	24.45
3135	2026-05-20 14:00:00	8	171.6
3159	2026-05-20 15:00:00	41	20
3166	2026-05-20 15:00:00	42	28.48
3177	2026-05-20 15:00:00	45	20
3186	2026-05-20 15:00:00	43	198
3196	2026-05-20 15:00:00	44	20
3206	2026-05-20 16:00:00	18	198
3216	2026-05-20 16:00:00	19	20
3227	2026-05-20 16:00:00	20	20
3239	2026-05-20 16:00:00	16	20
3248	2026-05-20 16:00:00	17	28.4
3741	2026-05-21 03:00:00	48	198
3750	2026-05-21 03:00:00	50	20
4012	2026-05-21 09:00:00	9	20
4022	2026-05-21 09:00:00	7	24.32
4028	2026-05-21 09:00:00	6	12
4038	2026-05-21 09:00:00	8	171.6
4058	2026-05-21 10:00:00	36	20
4068	2026-05-21 10:00:00	38	198
4072	2026-05-21 10:00:00	37	28.22
4081	2026-05-21 10:00:00	39	20
4091	2026-05-21 10:00:00	40	20
4108	2026-05-21 11:00:00	33	198
4116	2026-05-21 11:00:00	31	20
4127	2026-05-21 11:00:00	34	20
4136	2026-05-21 11:00:00	32	28.37
4141	2026-05-21 11:00:00	35	20
4157	2026-05-21 12:00:00	40	20
4165	2026-05-21 12:00:00	36	46
4173	2026-05-21 12:00:00	38	283.8
4182	2026-05-21 12:00:00	37	41.23
4191	2026-05-21 12:00:00	39	20
4207	2026-05-21 13:00:00	36	20
4211	2026-05-21 13:00:00	38	198
4219	2026-05-21 13:00:00	45	20
143	2026-05-18 02:00:00	31	20
149	2026-05-18 02:00:00	32	28.26
152	2026-05-18 03:00:00	8	171.6
161	2026-05-18 03:00:00	9	20
174	2026-05-18 03:00:00	10	20
187	2026-05-18 03:00:00	6	12
197	2026-05-18 03:00:00	7	24.43
209	2026-05-18 04:00:00	21	20
217	2026-05-18 04:00:00	22	28.46
226	2026-05-18 04:00:00	23	198
234	2026-05-18 04:00:00	24	20
245	2026-05-18 04:00:00	25	20
258	2026-05-18 05:00:00	28	198
263	2026-05-18 05:00:00	29	20
274	2026-05-18 05:00:00	30	20
282	2026-05-18 05:00:00	26	20
291	2026-05-18 05:00:00	27	28.24
1307	2026-05-19 02:00:00	7	24.24
1320	2026-05-19 02:00:00	8	171.6
1329	2026-05-19 02:00:00	9	20
1342	2026-05-19 02:00:00	10	20
1348	2026-05-19 02:00:00	6	12
1352	2026-05-19 03:00:00	10	20
1362	2026-05-19 03:00:00	6	12
1377	2026-05-19 03:00:00	7	24.29
1387	2026-05-19 03:00:00	8	171.6
1395	2026-05-19 03:00:00	9	20
1405	2026-05-19 04:00:00	33	198
1417	2026-05-19 04:00:00	34	20
1423	2026-05-19 04:00:00	35	20
1431	2026-05-19 04:00:00	31	20
1440	2026-05-19 04:00:00	32	28.22
1460	2026-05-19 05:00:00	47	28.27
1467	2026-05-19 05:00:00	48	198
1472	2026-05-19 05:00:00	49	20
1483	2026-05-19 05:00:00	50	20
1493	2026-05-19 05:00:00	46	20
1502	2026-05-19 06:00:00	36	20
1511	2026-05-19 06:00:00	37	28.34
1522	2026-05-19 06:00:00	38	198
1532	2026-05-19 06:00:00	39	20
1542	2026-05-19 06:00:00	40	20
1558	2026-05-19 07:00:00	41	20
1562	2026-05-19 07:00:00	42	28.4
1572	2026-05-19 07:00:00	43	198
1581	2026-05-19 07:00:00	44	20
1591	2026-05-19 07:00:00	45	20
1608	2026-05-19 08:00:00	31	20
1618	2026-05-19 08:00:00	32	28.44
1628	2026-05-19 08:00:00	33	198
1640	2026-05-19 08:00:00	34	20
1647	2026-05-19 08:00:00	35	20
1654	2026-05-19 09:00:00	11	20
1662	2026-05-19 09:00:00	12	28.29
1672	2026-05-19 09:00:00	13	198
1682	2026-05-19 09:00:00	14	20
1688	2026-05-19 09:00:00	15	20
1705	2026-05-19 10:00:00	42	28.25
1717	2026-05-19 10:00:00	43	198
1727	2026-05-19 10:00:00	44	20
1739	2026-05-19 10:00:00	45	20
1747	2026-05-19 10:00:00	41	20
1755	2026-05-19 11:00:00	15	20
1763	2026-05-19 11:00:00	11	20
1772	2026-05-19 11:00:00	12	28.33
1781	2026-05-19 11:00:00	13	198
1791	2026-05-19 11:00:00	14	20
2807	2026-05-20 08:00:00	36	20
2818	2026-05-20 08:00:00	38	198
2831	2026-05-20 08:00:00	37	28.45
2841	2026-05-20 08:00:00	39	20
2849	2026-05-20 08:00:00	40	20
2851	2026-05-20 09:00:00	6	12
2866	2026-05-20 09:00:00	9	20
2873	2026-05-20 09:00:00	7	24.24
2882	2026-05-20 09:00:00	8	171.6
2894	2026-05-20 09:00:00	10	20
2906	2026-05-20 10:00:00	32	28.22
2920	2026-05-20 10:00:00	35	20
2932	2026-05-20 10:00:00	33	198
2940	2026-05-20 10:00:00	31	20
2948	2026-05-20 10:00:00	34	20
2954	2026-05-20 11:00:00	20	20
2962	2026-05-20 11:00:00	16	20
2972	2026-05-20 11:00:00	17	28.26
2976	2026-05-20 11:00:00	18	198
2986	2026-05-20 11:00:00	19	20
3010	2026-05-20 12:00:00	46	46
3013	2026-05-20 12:00:00	47	41.28
3021	2026-05-20 12:00:00	49	20
3029	2026-05-20 12:00:00	48	283.8
3037	2026-05-20 12:00:00	50	20
3060	2026-05-20 13:00:00	46	20
3070	2026-05-20 13:00:00	47	28.3
3079	2026-05-20 13:00:00	49	20
3091	2026-05-20 13:00:00	48	198
3100	2026-05-20 13:00:00	50	20
3101	2026-05-20 14:00:00	2	24.22
3113	2026-05-20 14:00:00	3	171.6
3126	2026-05-20 14:00:00	4	20
3140	2026-05-20 14:00:00	5	20
3147	2026-05-20 14:00:00	1	12
3152	2026-05-20 15:00:00	8	171.6
3161	2026-05-20 15:00:00	10	20
3173	2026-05-20 15:00:00	6	12
3182	2026-05-20 15:00:00	9	20
3192	2026-05-20 15:00:00	7	24.23
3207	2026-05-20 16:00:00	44	20
3218	2026-05-20 16:00:00	41	20
3228	2026-05-20 16:00:00	42	28.19
3238	2026-05-20 16:00:00	45	20
3249	2026-05-20 16:00:00	43	198
3751	2026-05-21 04:00:00	10	20
3761	2026-05-21 04:00:00	7	24.27
3773	2026-05-21 04:00:00	6	12
3783	2026-05-21 04:00:00	9	20
3795	2026-05-21 04:00:00	8	171.6
3807	2026-05-21 05:00:00	27	28.41
3817	2026-05-21 05:00:00	28	198
3825	2026-05-21 05:00:00	30	20
3834	2026-05-21 05:00:00	26	20
3844	2026-05-21 05:00:00	29	20
3856	2026-05-21 06:00:00	38	198
3861	2026-05-21 06:00:00	37	28.39
3874	2026-05-21 06:00:00	39	20
3884	2026-05-21 06:00:00	40	20
3894	2026-05-21 06:00:00	36	20
3906	2026-05-21 07:00:00	28	198
3917	2026-05-21 07:00:00	30	20
3930	2026-05-21 07:00:00	26	20
3940	2026-05-21 07:00:00	29	20
3950	2026-05-21 07:00:00	27	28.38
3951	2026-05-21 08:00:00	5	20
3963	2026-05-21 08:00:00	1	12
3976	2026-05-21 08:00:00	3	171.6
3984	2026-05-21 08:00:00	2	24.22
144	2026-05-18 02:00:00	46	20
150	2026-05-18 02:00:00	47	28.34
151	2026-05-18 03:00:00	1	12
165	2026-05-18 03:00:00	2	24.39
179	2026-05-18 03:00:00	3	171.6
190	2026-05-18 03:00:00	4	20
199	2026-05-18 03:00:00	5	20
201	2026-05-18 04:00:00	5	20
211	2026-05-18 04:00:00	1	12
220	2026-05-18 04:00:00	2	24.24
233	2026-05-18 04:00:00	3	171.6
244	2026-05-18 04:00:00	4	20
257	2026-05-18 05:00:00	17	28.26
269	2026-05-18 05:00:00	18	198
280	2026-05-18 05:00:00	19	20
287	2026-05-18 05:00:00	20	20
293	2026-05-18 05:00:00	16	20
1308	2026-05-19 02:00:00	45	20
1309	2026-05-19 02:00:00	38	198
1314	2026-05-19 02:00:00	39	20
1315	2026-05-19 02:00:00	41	20
1324	2026-05-19 02:00:00	40	20
1326	2026-05-19 02:00:00	42	28.45
1333	2026-05-19 02:00:00	36	20
1335	2026-05-19 02:00:00	43	198
1343	2026-05-19 02:00:00	37	28.36
1346	2026-05-19 02:00:00	44	20
1359	2026-05-19 03:00:00	41	20
1360	2026-05-19 03:00:00	32	28.22
1369	2026-05-19 03:00:00	42	28.48
1370	2026-05-19 03:00:00	33	198
1379	2026-05-19 03:00:00	43	198
1380	2026-05-19 03:00:00	34	20
1385	2026-05-19 03:00:00	44	20
1390	2026-05-19 03:00:00	35	20
1393	2026-05-19 03:00:00	45	20
1399	2026-05-19 03:00:00	31	20
1402	2026-05-19 04:00:00	15	20
1410	2026-05-19 04:00:00	42	28.27
1413	2026-05-19 04:00:00	43	198
1420	2026-05-19 04:00:00	11	20
1427	2026-05-19 04:00:00	44	20
1432	2026-05-19 04:00:00	12	28.22
1434	2026-05-19 04:00:00	45	20
1444	2026-05-19 04:00:00	13	198
1446	2026-05-19 04:00:00	41	20
1449	2026-05-19 04:00:00	14	20
1451	2026-05-19 05:00:00	10	20
1455	2026-05-19 05:00:00	18	198
1462	2026-05-19 05:00:00	6	12
1465	2026-05-19 05:00:00	19	20
1474	2026-05-19 05:00:00	7	24.46
1475	2026-05-19 05:00:00	20	20
1486	2026-05-19 05:00:00	8	171.6
1487	2026-05-19 05:00:00	16	20
1496	2026-05-19 05:00:00	17	28.44
1497	2026-05-19 05:00:00	9	20
1504	2026-05-19 06:00:00	9	20
1507	2026-05-19 06:00:00	30	20
1517	2026-05-19 06:00:00	10	20
1520	2026-05-19 06:00:00	26	20
1528	2026-05-19 06:00:00	27	28.48
1529	2026-05-19 06:00:00	6	12
1538	2026-05-19 06:00:00	28	198
1539	2026-05-19 06:00:00	7	24.37
1546	2026-05-19 06:00:00	29	20
1550	2026-05-19 06:00:00	8	171.6
1551	2026-05-19 07:00:00	3	171.6
1557	2026-05-19 07:00:00	30	20
1563	2026-05-19 07:00:00	4	20
1566	2026-05-19 07:00:00	26	20
1573	2026-05-19 07:00:00	5	20
1577	2026-05-19 07:00:00	27	28.3
1582	2026-05-19 07:00:00	1	12
1588	2026-05-19 07:00:00	28	198
1593	2026-05-19 07:00:00	2	24.44
1596	2026-05-19 07:00:00	29	20
1604	2026-05-19 08:00:00	18	198
1607	2026-05-19 08:00:00	36	20
1614	2026-05-19 08:00:00	19	20
1617	2026-05-19 08:00:00	37	28.21
1621	2026-05-19 08:00:00	20	20
1629	2026-05-19 08:00:00	38	198
1630	2026-05-19 08:00:00	16	20
1638	2026-05-19 08:00:00	17	28.31
1639	2026-05-19 08:00:00	39	20
1648	2026-05-19 08:00:00	40	20
1653	2026-05-19 09:00:00	16	20
1660	2026-05-19 09:00:00	49	20
1661	2026-05-19 09:00:00	17	28.38
1668	2026-05-19 09:00:00	50	20
1671	2026-05-19 09:00:00	18	198
1675	2026-05-19 09:00:00	19	20
1679	2026-05-19 09:00:00	46	20
1681	2026-05-19 09:00:00	20	20
1691	2026-05-19 09:00:00	47	28.21
1699	2026-05-19 09:00:00	48	198
1701	2026-05-19 10:00:00	4	20
1706	2026-05-19 10:00:00	47	28.48
1711	2026-05-19 10:00:00	48	198
1713	2026-05-19 10:00:00	5	20
1721	2026-05-19 10:00:00	49	20
1723	2026-05-19 10:00:00	1	12
1724	2026-05-19 10:00:00	50	20
1732	2026-05-19 10:00:00	46	20
1734	2026-05-19 10:00:00	2	24.45
1743	2026-05-19 10:00:00	3	171.6
1758	2026-05-19 11:00:00	47	28.4
1759	2026-05-19 11:00:00	37	28.23
1766	2026-05-19 11:00:00	38	198
1769	2026-05-19 11:00:00	48	198
1777	2026-05-19 11:00:00	49	20
1778	2026-05-19 11:00:00	39	20
1786	2026-05-19 11:00:00	50	20
1787	2026-05-19 11:00:00	40	20
1795	2026-05-19 11:00:00	46	20
1799	2026-05-19 11:00:00	36	20
2808	2026-05-20 08:00:00	34	20
2819	2026-05-20 08:00:00	32	28.32
2830	2026-05-20 08:00:00	35	20
2837	2026-05-20 08:00:00	33	198
2847	2026-05-20 08:00:00	31	20
2858	2026-05-20 09:00:00	22	28.43
2868	2026-05-20 09:00:00	25	20
2877	2026-05-20 09:00:00	23	198
2887	2026-05-20 09:00:00	24	20
2897	2026-05-20 09:00:00	21	20
2904	2026-05-20 10:00:00	17	28.25
2914	2026-05-20 10:00:00	18	198
2927	2026-05-20 10:00:00	19	20
2939	2026-05-20 10:00:00	20	20
2947	2026-05-20 10:00:00	16	20
2953	2026-05-20 11:00:00	12	28.29
2966	2026-05-20 11:00:00	15	20
2974	2026-05-20 11:00:00	13	198
2984	2026-05-20 11:00:00	11	20
159	2026-05-18 03:00:00	41	20
163	2026-05-18 03:00:00	42	28.48
172	2026-05-18 03:00:00	43	198
182	2026-05-18 03:00:00	44	20
192	2026-05-18 03:00:00	45	20
204	2026-05-18 04:00:00	41	20
219	2026-05-18 04:00:00	42	28.25
229	2026-05-18 04:00:00	43	198
238	2026-05-18 04:00:00	44	20
246	2026-05-18 04:00:00	45	20
260	2026-05-18 05:00:00	31	20
264	2026-05-18 05:00:00	32	28.45
273	2026-05-18 05:00:00	33	198
283	2026-05-18 05:00:00	34	20
298	2026-05-18 05:00:00	35	20
1310	2026-05-19 02:00:00	47	28.22
1316	2026-05-19 02:00:00	48	198
1328	2026-05-19 02:00:00	49	20
1338	2026-05-19 02:00:00	50	20
1350	2026-05-19 02:00:00	46	20
1351	2026-05-19 03:00:00	3	171.6
1361	2026-05-19 03:00:00	4	20
1372	2026-05-19 03:00:00	5	20
1381	2026-05-19 03:00:00	1	12
1391	2026-05-19 03:00:00	2	24.43
1409	2026-05-19 04:00:00	50	20
1414	2026-05-19 04:00:00	46	20
1428	2026-05-19 04:00:00	47	28.22
1439	2026-05-19 04:00:00	48	198
1448	2026-05-19 04:00:00	49	20
1453	2026-05-19 05:00:00	12	28.38
1466	2026-05-19 05:00:00	13	198
1479	2026-05-19 05:00:00	14	20
1491	2026-05-19 05:00:00	15	20
1498	2026-05-19 05:00:00	11	20
1503	2026-05-19 06:00:00	15	20
1515	2026-05-19 06:00:00	11	20
1525	2026-05-19 06:00:00	12	28.33
1533	2026-05-19 06:00:00	13	198
1543	2026-05-19 06:00:00	14	20
1555	2026-05-19 07:00:00	31	20
1570	2026-05-19 07:00:00	32	28.19
1579	2026-05-19 07:00:00	33	198
1590	2026-05-19 07:00:00	34	20
1599	2026-05-19 07:00:00	35	20
1603	2026-05-19 08:00:00	14	20
1613	2026-05-19 08:00:00	15	20
1624	2026-05-19 08:00:00	11	20
1634	2026-05-19 08:00:00	12	28.32
1646	2026-05-19 08:00:00	13	198
1656	2026-05-19 09:00:00	30	20
1670	2026-05-19 09:00:00	26	20
1680	2026-05-19 09:00:00	27	28.2
1684	2026-05-19 09:00:00	28	198
1695	2026-05-19 09:00:00	29	20
1704	2026-05-19 10:00:00	29	20
1719	2026-05-19 10:00:00	30	20
1730	2026-05-19 10:00:00	26	20
1741	2026-05-19 10:00:00	27	28.43
1750	2026-05-19 10:00:00	28	198
1752	2026-05-19 11:00:00	10	20
1764	2026-05-19 11:00:00	6	12
1776	2026-05-19 11:00:00	7	24.2
1788	2026-05-19 11:00:00	8	171.6
1794	2026-05-19 11:00:00	9	20
2809	2026-05-20 08:00:00	42	28.45
2813	2026-05-20 08:00:00	45	20
2823	2026-05-20 08:00:00	43	198
2833	2026-05-20 08:00:00	44	20
2842	2026-05-20 08:00:00	41	20
2859	2026-05-20 09:00:00	36	20
2870	2026-05-20 09:00:00	38	198
2879	2026-05-20 09:00:00	37	28.45
2892	2026-05-20 09:00:00	39	20
2900	2026-05-20 09:00:00	40	20
2902	2026-05-20 10:00:00	3	171.6
2911	2026-05-20 10:00:00	4	20
2921	2026-05-20 10:00:00	5	20
2925	2026-05-20 10:00:00	1	12
2935	2026-05-20 10:00:00	2	24.39
2960	2026-05-20 11:00:00	50	20
2970	2026-05-20 11:00:00	46	20
2983	2026-05-20 11:00:00	47	28.49
2995	2026-05-20 11:00:00	49	20
2999	2026-05-20 11:00:00	48	198
3001	2026-05-20 12:00:00	7	24.41
3011	2026-05-20 12:00:00	8	171.6
3023	2026-05-20 12:00:00	10	20
3036	2026-05-20 12:00:00	6	12
3046	2026-05-20 12:00:00	9	20
3055	2026-05-20 13:00:00	24	20
3067	2026-05-20 13:00:00	21	20
3080	2026-05-20 13:00:00	22	28.47
3089	2026-05-20 13:00:00	25	20
3094	2026-05-20 13:00:00	23	198
3107	2026-05-20 14:00:00	35	20
3118	2026-05-20 14:00:00	33	198
3130	2026-05-20 14:00:00	31	20
3144	2026-05-20 14:00:00	34	20
3150	2026-05-20 14:00:00	32	28.32
3151	2026-05-20 15:00:00	5	20
3162	2026-05-20 15:00:00	1	12
3174	2026-05-20 15:00:00	2	24.41
3185	2026-05-20 15:00:00	3	171.6
3194	2026-05-20 15:00:00	4	20
3210	2026-05-20 16:00:00	31	20
3223	2026-05-20 16:00:00	34	20
3233	2026-05-20 16:00:00	32	28.37
3243	2026-05-20 16:00:00	35	20
3250	2026-05-20 16:00:00	33	198
3752	2026-05-21 04:00:00	5	20
3762	2026-05-21 04:00:00	1	12
3772	2026-05-21 04:00:00	3	171.6
3784	2026-05-21 04:00:00	4	20
3794	2026-05-21 04:00:00	2	24.23
3808	2026-05-21 05:00:00	34	20
3811	2026-05-21 05:00:00	32	28.44
3822	2026-05-21 05:00:00	35	20
3836	2026-05-21 05:00:00	33	198
3846	2026-05-21 05:00:00	31	20
3859	2026-05-21 06:00:00	28	198
3869	2026-05-21 06:00:00	30	20
3880	2026-05-21 06:00:00	26	20
3891	2026-05-21 06:00:00	29	20
3899	2026-05-21 06:00:00	27	28.29
3902	2026-05-21 07:00:00	10	20
3919	2026-05-21 07:00:00	7	24.22
3928	2026-05-21 07:00:00	6	12
3937	2026-05-21 07:00:00	8	171.6
3946	2026-05-21 07:00:00	9	20
3953	2026-05-21 08:00:00	11	20
3969	2026-05-21 08:00:00	14	20
3980	2026-05-21 08:00:00	13	198
3990	2026-05-21 08:00:00	12	28.4
3999	2026-05-21 08:00:00	15	20
4002	2026-05-21 09:00:00	10	20
160	2026-05-18 03:00:00	50	20
169	2026-05-18 03:00:00	46	20
177	2026-05-18 03:00:00	47	28.37
186	2026-05-18 03:00:00	48	198
193	2026-05-18 03:00:00	49	20
205	2026-05-18 04:00:00	31	20
218	2026-05-18 04:00:00	32	28.2
228	2026-05-18 04:00:00	33	198
236	2026-05-18 04:00:00	34	20
248	2026-05-18 04:00:00	35	20
253	2026-05-18 05:00:00	7	24.23
262	2026-05-18 05:00:00	8	171.6
272	2026-05-18 05:00:00	9	20
281	2026-05-18 05:00:00	10	20
292	2026-05-18 05:00:00	6	12
301	2026-05-18 06:00:00	14	20
303	2026-05-18 06:00:00	9	20
302	2026-05-18 06:00:00	3	171.6
304	2026-05-18 06:00:00	22	28.25
305	2026-05-18 06:00:00	40	20
307	2026-05-18 06:00:00	42	28.35
306	2026-05-18 06:00:00	17	28.29
308	2026-05-18 06:00:00	30	20
309	2026-05-18 06:00:00	33	198
310	2026-05-18 06:00:00	47	28.4
311	2026-05-18 06:00:00	15	20
312	2026-05-18 06:00:00	26	20
313	2026-05-18 06:00:00	10	20
314	2026-05-18 06:00:00	4	20
315	2026-05-18 06:00:00	23	198
316	2026-05-18 06:00:00	36	20
317	2026-05-18 06:00:00	18	198
318	2026-05-18 06:00:00	34	20
319	2026-05-18 06:00:00	43	198
320	2026-05-18 06:00:00	48	198
321	2026-05-18 06:00:00	27	28.38
322	2026-05-18 06:00:00	6	12
323	2026-05-18 06:00:00	37	28.23
324	2026-05-18 06:00:00	5	20
325	2026-05-18 06:00:00	24	20
326	2026-05-18 06:00:00	11	20
327	2026-05-18 06:00:00	44	20
328	2026-05-18 06:00:00	35	20
329	2026-05-18 06:00:00	1	12
330	2026-05-18 06:00:00	19	20
331	2026-05-18 06:00:00	45	20
332	2026-05-18 06:00:00	49	20
333	2026-05-18 06:00:00	7	24.22
334	2026-05-18 06:00:00	28	198
335	2026-05-18 06:00:00	38	198
336	2026-05-18 06:00:00	25	20
337	2026-05-18 06:00:00	12	28.31
338	2026-05-18 06:00:00	31	20
339	2026-05-18 06:00:00	2	24.46
340	2026-05-18 06:00:00	20	20
341	2026-05-18 06:00:00	41	20
342	2026-05-18 06:00:00	50	20
343	2026-05-18 06:00:00	29	20
344	2026-05-18 06:00:00	39	20
345	2026-05-18 06:00:00	8	171.6
346	2026-05-18 06:00:00	21	20
347	2026-05-18 06:00:00	13	198
348	2026-05-18 06:00:00	32	28.45
349	2026-05-18 06:00:00	46	20
350	2026-05-18 06:00:00	16	20
351	2026-05-18 07:00:00	1	12
352	2026-05-18 07:00:00	7	24.36
354	2026-05-18 07:00:00	19	20
353	2026-05-18 07:00:00	12	28.34
355	2026-05-18 07:00:00	25	20
356	2026-05-18 07:00:00	33	198
357	2026-05-18 07:00:00	28	198
358	2026-05-18 07:00:00	49	20
359	2026-05-18 07:00:00	45	20
360	2026-05-18 07:00:00	38	198
361	2026-05-18 07:00:00	50	20
362	2026-05-18 07:00:00	20	20
363	2026-05-18 07:00:00	2	24.42
364	2026-05-18 07:00:00	8	171.6
365	2026-05-18 07:00:00	41	20
366	2026-05-18 07:00:00	13	198
367	2026-05-18 07:00:00	34	20
368	2026-05-18 07:00:00	29	20
369	2026-05-18 07:00:00	46	20
370	2026-05-18 07:00:00	16	20
371	2026-05-18 07:00:00	21	20
372	2026-05-18 07:00:00	39	20
373	2026-05-18 07:00:00	42	28.42
374	2026-05-18 07:00:00	47	28.26
375	2026-05-18 07:00:00	17	28.4
376	2026-05-18 07:00:00	22	28.31
377	2026-05-18 07:00:00	3	171.6
378	2026-05-18 07:00:00	9	20
379	2026-05-18 07:00:00	43	198
380	2026-05-18 07:00:00	14	20
381	2026-05-18 07:00:00	30	20
382	2026-05-18 07:00:00	35	20
383	2026-05-18 07:00:00	48	198
384	2026-05-18 07:00:00	18	198
385	2026-05-18 07:00:00	40	20
386	2026-05-18 07:00:00	4	20
387	2026-05-18 07:00:00	10	20
388	2026-05-18 07:00:00	23	198
389	2026-05-18 07:00:00	44	20
390	2026-05-18 07:00:00	15	20
391	2026-05-18 07:00:00	26	20
392	2026-05-18 07:00:00	31	20
393	2026-05-18 07:00:00	36	20
394	2026-05-18 07:00:00	6	12
395	2026-05-18 07:00:00	5	20
396	2026-05-18 07:00:00	24	20
397	2026-05-18 07:00:00	11	20
398	2026-05-18 07:00:00	27	28.2
399	2026-05-18 07:00:00	37	28.22
400	2026-05-18 07:00:00	32	28.33
401	2026-05-18 08:00:00	5	20
402	2026-05-18 08:00:00	6	12
403	2026-05-18 08:00:00	19	20
404	2026-05-18 08:00:00	11	20
405	2026-05-18 08:00:00	31	20
406	2026-05-18 08:00:00	24	20
407	2026-05-18 08:00:00	27	28.24
408	2026-05-18 08:00:00	36	20
409	2026-05-18 08:00:00	45	20
410	2026-05-18 08:00:00	50	20
411	2026-05-18 08:00:00	1	12
412	2026-05-18 08:00:00	25	20
413	2026-05-18 08:00:00	12	28.41
414	2026-05-18 08:00:00	28	198
415	2026-05-18 08:00:00	32	28.42
416	2026-05-18 08:00:00	7	24.47
417	2026-05-18 08:00:00	46	20
418	2026-05-18 08:00:00	20	20
419	2026-05-18 08:00:00	37	28.27
420	2026-05-18 08:00:00	41	20
421	2026-05-18 08:00:00	29	20
422	2026-05-18 08:00:00	21	20
431	2026-05-18 08:00:00	22	28.34
441	2026-05-18 08:00:00	23	198
456	2026-05-18 09:00:00	31	20
469	2026-05-18 09:00:00	32	28.31
478	2026-05-18 09:00:00	33	198
491	2026-05-18 09:00:00	34	20
500	2026-05-18 09:00:00	35	20
503	2026-05-18 10:00:00	7	24.45
512	2026-05-18 10:00:00	8	171.6
521	2026-05-18 10:00:00	9	20
529	2026-05-18 10:00:00	10	20
535	2026-05-18 10:00:00	6	12
560	2026-05-18 11:00:00	48	198
566	2026-05-18 11:00:00	49	20
582	2026-05-18 11:00:00	50	20
593	2026-05-18 11:00:00	46	20
598	2026-05-18 11:00:00	47	28.27
603	2026-05-18 12:00:00	13	283.8
613	2026-05-18 12:00:00	14	20
623	2026-05-18 12:00:00	15	20
637	2026-05-18 12:00:00	11	46
646	2026-05-18 12:00:00	12	41.25
656	2026-05-18 13:00:00	22	28.21
662	2026-05-18 13:00:00	23	198
671	2026-05-18 13:00:00	24	20
682	2026-05-18 13:00:00	25	20
692	2026-05-18 13:00:00	21	20
708	2026-05-18 14:00:00	39	20
714	2026-05-18 14:00:00	40	20
724	2026-05-18 14:00:00	36	20
737	2026-05-18 14:00:00	37	28.27
747	2026-05-18 14:00:00	38	198
758	2026-05-18 15:00:00	12	28.38
765	2026-05-18 15:00:00	13	198
776	2026-05-18 15:00:00	14	20
786	2026-05-18 15:00:00	15	20
793	2026-05-18 15:00:00	11	20
1801	2026-05-19 12:00:00	5	20
1814	2026-05-19 12:00:00	1	12
1823	2026-05-19 12:00:00	2	24.23
1835	2026-05-19 12:00:00	3	171.6
1847	2026-05-19 12:00:00	4	20
1854	2026-05-19 13:00:00	15	20
1868	2026-05-19 13:00:00	11	20
1878	2026-05-19 13:00:00	12	28.37
1888	2026-05-19 13:00:00	13	198
1898	2026-05-19 13:00:00	14	20
1901	2026-05-19 14:00:00	5	20
1912	2026-05-19 14:00:00	1	12
1922	2026-05-19 14:00:00	2	24.31
1928	2026-05-19 14:00:00	3	171.6
1938	2026-05-19 14:00:00	4	20
1956	2026-05-19 15:00:00	42	28.24
1963	2026-05-19 15:00:00	43	198
1973	2026-05-19 15:00:00	44	20
1980	2026-05-19 15:00:00	45	20
1990	2026-05-19 15:00:00	41	20
2007	2026-05-19 16:00:00	32	28.25
2018	2026-05-19 16:00:00	33	198
2029	2026-05-19 16:00:00	34	20
2038	2026-05-19 16:00:00	35	20
2047	2026-05-19 16:00:00	31	20
2053	2026-05-19 17:00:00	14	20
2067	2026-05-19 17:00:00	15	20
2078	2026-05-19 17:00:00	11	20
2088	2026-05-19 17:00:00	12	28.45
2098	2026-05-19 17:00:00	13	198
2101	2026-05-19 18:00:00	12	28.36
2117	2026-05-19 18:00:00	13	198
2127	2026-05-19 18:00:00	14	20
2137	2026-05-19 18:00:00	15	20
2145	2026-05-19 18:00:00	11	20
2154	2026-05-19 19:00:00	21	20
2166	2026-05-19 19:00:00	22	28.34
2176	2026-05-19 19:00:00	23	198
2183	2026-05-19 19:00:00	24	20
2193	2026-05-19 19:00:00	25	20
2210	2026-05-19 20:00:00	40	20
2219	2026-05-19 20:00:00	36	20
2223	2026-05-19 20:00:00	37	28.32
2232	2026-05-19 20:00:00	38	198
2241	2026-05-19 20:00:00	39	20
2260	2026-05-19 21:00:00	48	198
2270	2026-05-19 21:00:00	49	20
2280	2026-05-19 21:00:00	50	20
2289	2026-05-19 21:00:00	46	20
2299	2026-05-19 21:00:00	47	28.3
2810	2026-05-20 08:00:00	46	20
2816	2026-05-20 08:00:00	47	28.38
2824	2026-05-20 08:00:00	49	20
2835	2026-05-20 08:00:00	48	198
2846	2026-05-20 08:00:00	50	20
2854	2026-05-20 09:00:00	26	20
2867	2026-05-20 09:00:00	29	20
2875	2026-05-20 09:00:00	27	28.26
2885	2026-05-20 09:00:00	28	198
2893	2026-05-20 09:00:00	30	20
2908	2026-05-20 10:00:00	43	198
2917	2026-05-20 10:00:00	44	20
2924	2026-05-20 10:00:00	41	20
2934	2026-05-20 10:00:00	42	28.27
2944	2026-05-20 10:00:00	45	20
2958	2026-05-20 11:00:00	28	198
2967	2026-05-20 11:00:00	30	20
2979	2026-05-20 11:00:00	26	20
2985	2026-05-20 11:00:00	29	20
2993	2026-05-20 11:00:00	27	28.25
3009	2026-05-20 12:00:00	42	41.25
3019	2026-05-20 12:00:00	45	20
3030	2026-05-20 12:00:00	43	283.8
3042	2026-05-20 12:00:00	44	20
3050	2026-05-20 12:00:00	41	46
3051	2026-05-20 13:00:00	5	20
3063	2026-05-20 13:00:00	1	12
3073	2026-05-20 13:00:00	2	24.27
3083	2026-05-20 13:00:00	3	171.6
3092	2026-05-20 13:00:00	4	20
3109	2026-05-20 14:00:00	45	20
3116	2026-05-20 14:00:00	43	198
3129	2026-05-20 14:00:00	44	20
3134	2026-05-20 14:00:00	41	20
3141	2026-05-20 14:00:00	42	28.28
3156	2026-05-20 15:00:00	31	20
3164	2026-05-20 15:00:00	34	20
3172	2026-05-20 15:00:00	32	28.2
3184	2026-05-20 15:00:00	35	20
3193	2026-05-20 15:00:00	33	198
3208	2026-05-20 16:00:00	38	198
3219	2026-05-20 16:00:00	37	28.43
3231	2026-05-20 16:00:00	39	20
3241	2026-05-20 16:00:00	40	20
3247	2026-05-20 16:00:00	36	20
3753	2026-05-21 04:00:00	15	20
3769	2026-05-21 04:00:00	11	20
3780	2026-05-21 04:00:00	14	20
423	2026-05-18 08:00:00	2	24.34
432	2026-05-18 08:00:00	3	171.6
443	2026-05-18 08:00:00	4	20
460	2026-05-18 09:00:00	36	20
465	2026-05-18 09:00:00	37	28.23
476	2026-05-18 09:00:00	38	198
486	2026-05-18 09:00:00	39	20
493	2026-05-18 09:00:00	40	20
510	2026-05-18 10:00:00	37	28.39
520	2026-05-18 10:00:00	38	198
533	2026-05-18 10:00:00	39	20
542	2026-05-18 10:00:00	40	20
550	2026-05-18 10:00:00	36	20
552	2026-05-18 11:00:00	5	20
569	2026-05-18 11:00:00	1	12
577	2026-05-18 11:00:00	2	24.47
591	2026-05-18 11:00:00	3	171.6
597	2026-05-18 11:00:00	4	20
608	2026-05-18 12:00:00	20	20
616	2026-05-18 12:00:00	16	46
624	2026-05-18 12:00:00	17	41.3
632	2026-05-18 12:00:00	18	283.8
642	2026-05-18 12:00:00	19	20
655	2026-05-18 13:00:00	44	20
663	2026-05-18 13:00:00	45	20
672	2026-05-18 13:00:00	41	20
678	2026-05-18 13:00:00	42	28.39
688	2026-05-18 13:00:00	43	198
710	2026-05-18 14:00:00	41	20
719	2026-05-18 14:00:00	42	28.47
727	2026-05-18 14:00:00	43	198
732	2026-05-18 14:00:00	44	20
742	2026-05-18 14:00:00	45	20
757	2026-05-18 15:00:00	44	20
763	2026-05-18 15:00:00	45	20
773	2026-05-18 15:00:00	41	20
784	2026-05-18 15:00:00	42	28.23
795	2026-05-18 15:00:00	43	198
1803	2026-05-19 12:00:00	6	12
1812	2026-05-19 12:00:00	7	24.2
1824	2026-05-19 12:00:00	8	171.6
1838	2026-05-19 12:00:00	9	20
1848	2026-05-19 12:00:00	10	20
1853	2026-05-19 13:00:00	19	20
1869	2026-05-19 13:00:00	20	20
1880	2026-05-19 13:00:00	16	20
1892	2026-05-19 13:00:00	17	28.26
1900	2026-05-19 13:00:00	18	198
1902	2026-05-19 14:00:00	7	24.41
1916	2026-05-19 14:00:00	8	171.6
1925	2026-05-19 14:00:00	9	20
1932	2026-05-19 14:00:00	10	20
1937	2026-05-19 14:00:00	6	12
1958	2026-05-19 15:00:00	47	28.43
1964	2026-05-19 15:00:00	48	198
1974	2026-05-19 15:00:00	49	20
1984	2026-05-19 15:00:00	50	20
1993	2026-05-19 15:00:00	46	20
2009	2026-05-19 16:00:00	43	198
2019	2026-05-19 16:00:00	44	20
2030	2026-05-19 16:00:00	45	20
2042	2026-05-19 16:00:00	41	20
2049	2026-05-19 16:00:00	42	28.24
2060	2026-05-19 17:00:00	23	198
2069	2026-05-19 17:00:00	24	20
2080	2026-05-19 17:00:00	25	20
2091	2026-05-19 17:00:00	21	20
2100	2026-05-19 17:00:00	22	28.41
2103	2026-05-19 18:00:00	2	24.2
2116	2026-05-19 18:00:00	3	171.6
2126	2026-05-19 18:00:00	4	20
2138	2026-05-19 18:00:00	5	20
2149	2026-05-19 18:00:00	1	12
2153	2026-05-19 19:00:00	2	24.48
2167	2026-05-19 19:00:00	3	171.6
2179	2026-05-19 19:00:00	4	20
2188	2026-05-19 19:00:00	5	20
2199	2026-05-19 19:00:00	1	12
2202	2026-05-19 20:00:00	14	20
2212	2026-05-19 20:00:00	15	20
2225	2026-05-19 20:00:00	11	20
2235	2026-05-19 20:00:00	12	28.21
2242	2026-05-19 20:00:00	13	198
2259	2026-05-19 21:00:00	41	20
2262	2026-05-19 21:00:00	42	28.31
2274	2026-05-19 21:00:00	43	198
2282	2026-05-19 21:00:00	44	20
2291	2026-05-19 21:00:00	45	20
2987	2026-05-20 11:00:00	41	20
3008	2026-05-20 12:00:00	39	20
3020	2026-05-20 12:00:00	40	20
3031	2026-05-20 12:00:00	36	46
3041	2026-05-20 12:00:00	38	283.8
3049	2026-05-20 12:00:00	37	41.36
3053	2026-05-20 13:00:00	8	171.6
3065	2026-05-20 13:00:00	10	20
3077	2026-05-20 13:00:00	6	12
3086	2026-05-20 13:00:00	9	20
3097	2026-05-20 13:00:00	7	24.46
3104	2026-05-20 14:00:00	22	28.42
3114	2026-05-20 14:00:00	25	20
3127	2026-05-20 14:00:00	23	198
3137	2026-05-20 14:00:00	24	20
3145	2026-05-20 14:00:00	21	20
3158	2026-05-20 15:00:00	27	28.31
3168	2026-05-20 15:00:00	28	198
3176	2026-05-20 15:00:00	30	20
3188	2026-05-20 15:00:00	26	20
3199	2026-05-20 15:00:00	29	20
3201	2026-05-20 16:00:00	4	20
3211	2026-05-20 16:00:00	5	20
3220	2026-05-20 16:00:00	1	12
3232	2026-05-20 16:00:00	2	24.39
3242	2026-05-20 16:00:00	3	171.6
3754	2026-05-21 04:00:00	21	20
3755	2026-05-21 04:00:00	38	198
3763	2026-05-21 04:00:00	37	28.23
3766	2026-05-21 04:00:00	22	28.32
3771	2026-05-21 04:00:00	39	20
3775	2026-05-21 04:00:00	23	198
3776	2026-05-21 04:00:00	40	20
3785	2026-05-21 04:00:00	25	20
3786	2026-05-21 04:00:00	36	20
3790	2026-05-21 04:00:00	24	20
3809	2026-05-21 05:00:00	42	28.29
3810	2026-05-21 05:00:00	46	20
3816	2026-05-21 05:00:00	47	28.43
3818	2026-05-21 05:00:00	45	20
3821	2026-05-21 05:00:00	49	20
3823	2026-05-21 05:00:00	43	198
3829	2026-05-21 05:00:00	48	198
3832	2026-05-21 05:00:00	44	20
3835	2026-05-21 05:00:00	50	20
3838	2026-05-21 05:00:00	41	20
3858	2026-05-21 06:00:00	46	20
3863	2026-05-21 06:00:00	42	28.41
424	2026-05-18 08:00:00	13	198
436	2026-05-18 08:00:00	14	20
444	2026-05-18 08:00:00	15	20
458	2026-05-18 09:00:00	24	20
470	2026-05-18 09:00:00	25	20
479	2026-05-18 09:00:00	21	20
488	2026-05-18 09:00:00	22	28.48
499	2026-05-18 09:00:00	23	198
501	2026-05-18 10:00:00	1	12
511	2026-05-18 10:00:00	2	24.35
515	2026-05-18 10:00:00	3	171.6
524	2026-05-18 10:00:00	4	20
532	2026-05-18 10:00:00	5	20
558	2026-05-18 11:00:00	44	20
561	2026-05-18 11:00:00	45	20
571	2026-05-18 11:00:00	41	20
578	2026-05-18 11:00:00	42	28.46
585	2026-05-18 11:00:00	43	198
607	2026-05-18 12:00:00	44	20
615	2026-05-18 12:00:00	45	20
627	2026-05-18 12:00:00	41	46
635	2026-05-18 12:00:00	42	41.44
645	2026-05-18 12:00:00	43	283.8
659	2026-05-18 13:00:00	38	198
669	2026-05-18 13:00:00	39	20
680	2026-05-18 13:00:00	40	20
685	2026-05-18 13:00:00	36	20
694	2026-05-18 13:00:00	37	28.37
703	2026-05-18 14:00:00	24	20
717	2026-05-18 14:00:00	25	20
728	2026-05-18 14:00:00	21	20
733	2026-05-18 14:00:00	22	28.45
748	2026-05-18 14:00:00	23	198
755	2026-05-18 15:00:00	16	20
766	2026-05-18 15:00:00	17	28.38
777	2026-05-18 15:00:00	18	198
788	2026-05-18 15:00:00	19	20
797	2026-05-18 15:00:00	20	20
1802	2026-05-19 12:00:00	13	283.8
1813	2026-05-19 12:00:00	14	20
1821	2026-05-19 12:00:00	15	20
1830	2026-05-19 12:00:00	11	46
1839	2026-05-19 12:00:00	12	41.28
1855	2026-05-19 13:00:00	40	20
1864	2026-05-19 13:00:00	36	20
1874	2026-05-19 13:00:00	37	28.22
1882	2026-05-19 13:00:00	38	198
1891	2026-05-19 13:00:00	39	20
1904	2026-05-19 14:00:00	43	198
1918	2026-05-19 14:00:00	44	20
1931	2026-05-19 14:00:00	45	20
1942	2026-05-19 14:00:00	41	20
1950	2026-05-19 14:00:00	42	28.49
1951	2026-05-19 15:00:00	5	20
1967	2026-05-19 15:00:00	1	12
1979	2026-05-19 15:00:00	2	24.41
1991	2026-05-19 15:00:00	3	171.6
1997	2026-05-19 15:00:00	4	20
2004	2026-05-19 16:00:00	17	28.24
2012	2026-05-19 16:00:00	18	198
2022	2026-05-19 16:00:00	19	20
2025	2026-05-19 16:00:00	20	20
2036	2026-05-19 16:00:00	16	20
2058	2026-05-19 17:00:00	49	20
2066	2026-05-19 17:00:00	50	20
2074	2026-05-19 17:00:00	46	20
2085	2026-05-19 17:00:00	47	28.27
2096	2026-05-19 17:00:00	48	198
2106	2026-05-19 18:00:00	21	20
2115	2026-05-19 18:00:00	22	28.37
2125	2026-05-19 18:00:00	23	198
2136	2026-05-19 18:00:00	24	20
2144	2026-05-19 18:00:00	25	20
2156	2026-05-19 19:00:00	26	20
2169	2026-05-19 19:00:00	27	28.44
2178	2026-05-19 19:00:00	28	198
2190	2026-05-19 19:00:00	29	20
2198	2026-05-19 19:00:00	30	20
2203	2026-05-19 20:00:00	9	20
2213	2026-05-19 20:00:00	10	20
2227	2026-05-19 20:00:00	6	12
2236	2026-05-19 20:00:00	7	24.45
2248	2026-05-19 20:00:00	8	171.6
2251	2026-05-19 21:00:00	6	12
2266	2026-05-19 21:00:00	7	24.36
2277	2026-05-19 21:00:00	8	171.6
2285	2026-05-19 21:00:00	9	20
2295	2026-05-19 21:00:00	10	20
2994	2026-05-20 11:00:00	14	20
3005	2026-05-20 12:00:00	28	283.8
3015	2026-05-20 12:00:00	30	20
3026	2026-05-20 12:00:00	26	46
3039	2026-05-20 12:00:00	29	20
3048	2026-05-20 12:00:00	27	41.24
3054	2026-05-20 13:00:00	14	20
3064	2026-05-20 13:00:00	12	28.22
3074	2026-05-20 13:00:00	15	20
3084	2026-05-20 13:00:00	13	198
3095	2026-05-20 13:00:00	11	20
3105	2026-05-20 14:00:00	30	20
3117	2026-05-20 14:00:00	26	20
3128	2026-05-20 14:00:00	29	20
3139	2026-05-20 14:00:00	27	28.3
3146	2026-05-20 14:00:00	28	198
3155	2026-05-20 15:00:00	24	20
3169	2026-05-20 15:00:00	21	20
3180	2026-05-20 15:00:00	22	28.22
3191	2026-05-20 15:00:00	25	20
3200	2026-05-20 15:00:00	23	198
3202	2026-05-20 16:00:00	8	171.6
3212	2026-05-20 16:00:00	10	20
3221	2026-05-20 16:00:00	6	12
3230	2026-05-20 16:00:00	9	20
3240	2026-05-20 16:00:00	7	24.46
3756	2026-05-21 04:00:00	19	20
3768	2026-05-21 04:00:00	20	20
3781	2026-05-21 04:00:00	16	20
3792	2026-05-21 04:00:00	18	198
3796	2026-05-21 04:00:00	17	28.21
3806	2026-05-21 05:00:00	22	28.46
3819	2026-05-21 05:00:00	23	198
3830	2026-05-21 05:00:00	25	20
3841	2026-05-21 05:00:00	24	20
3850	2026-05-21 05:00:00	21	20
3853	2026-05-21 06:00:00	9	20
3862	2026-05-21 06:00:00	10	20
3872	2026-05-21 06:00:00	7	24.29
3881	2026-05-21 06:00:00	6	12
3890	2026-05-21 06:00:00	8	171.6
3910	2026-05-21 07:00:00	46	20
3913	2026-05-21 07:00:00	47	28.46
3922	2026-05-21 07:00:00	49	20
3933	2026-05-21 07:00:00	48	198
3942	2026-05-21 07:00:00	50	20
3957	2026-05-21 08:00:00	42	28.47
3961	2026-05-21 08:00:00	45	20
425	2026-05-18 08:00:00	33	198
434	2026-05-18 08:00:00	34	20
445	2026-05-18 08:00:00	35	20
457	2026-05-18 09:00:00	27	28.49
466	2026-05-18 09:00:00	28	198
474	2026-05-18 09:00:00	29	20
482	2026-05-18 09:00:00	30	20
492	2026-05-18 09:00:00	26	20
508	2026-05-18 10:00:00	42	28.24
518	2026-05-18 10:00:00	43	198
527	2026-05-18 10:00:00	44	20
538	2026-05-18 10:00:00	45	20
546	2026-05-18 10:00:00	41	20
557	2026-05-18 11:00:00	22	28.28
568	2026-05-18 11:00:00	23	198
575	2026-05-18 11:00:00	24	20
583	2026-05-18 11:00:00	25	20
588	2026-05-18 11:00:00	21	20
609	2026-05-18 12:00:00	47	41.36
620	2026-05-18 12:00:00	48	283.8
626	2026-05-18 12:00:00	49	20
634	2026-05-18 12:00:00	50	20
643	2026-05-18 12:00:00	46	46
654	2026-05-18 13:00:00	31	20
665	2026-05-18 13:00:00	32	28.22
675	2026-05-18 13:00:00	33	198
689	2026-05-18 13:00:00	34	20
698	2026-05-18 13:00:00	35	20
702	2026-05-18 14:00:00	14	20
711	2026-05-18 14:00:00	15	20
722	2026-05-18 14:00:00	11	20
731	2026-05-18 14:00:00	12	28.23
741	2026-05-18 14:00:00	13	198
759	2026-05-18 15:00:00	46	20
768	2026-05-18 15:00:00	47	28.43
779	2026-05-18 15:00:00	48	198
790	2026-05-18 15:00:00	49	20
799	2026-05-18 15:00:00	50	20
1804	2026-05-19 12:00:00	31	46
1805	2026-05-19 12:00:00	47	41.37
1811	2026-05-19 12:00:00	48	283.8
1815	2026-05-19 12:00:00	32	41.36
1822	2026-05-19 12:00:00	49	20
1826	2026-05-19 12:00:00	33	283.8
1833	2026-05-19 12:00:00	50	20
1834	2026-05-19 12:00:00	34	20
1840	2026-05-19 12:00:00	35	20
1845	2026-05-19 12:00:00	46	46
1857	2026-05-19 13:00:00	26	20
1859	2026-05-19 13:00:00	49	20
1861	2026-05-19 13:00:00	27	28.48
1867	2026-05-19 13:00:00	28	198
1870	2026-05-19 13:00:00	50	20
1873	2026-05-19 13:00:00	29	20
1879	2026-05-19 13:00:00	46	20
1887	2026-05-19 13:00:00	30	20
1889	2026-05-19 13:00:00	47	28.29
1899	2026-05-19 13:00:00	48	198
1908	2026-05-19 14:00:00	13	198
1910	2026-05-19 14:00:00	47	28.26
1915	2026-05-19 14:00:00	48	198
1917	2026-05-19 14:00:00	14	20
1926	2026-05-19 14:00:00	15	20
1927	2026-05-19 14:00:00	49	20
1935	2026-05-19 14:00:00	11	20
1939	2026-05-19 14:00:00	50	20
1945	2026-05-19 14:00:00	12	28.38
1948	2026-05-19 14:00:00	46	20
1952	2026-05-19 15:00:00	7	24.2
1957	2026-05-19 15:00:00	32	28.43
1966	2026-05-19 15:00:00	33	198
1968	2026-05-19 15:00:00	8	171.6
1977	2026-05-19 15:00:00	34	20
1978	2026-05-19 15:00:00	9	20
1987	2026-05-19 15:00:00	35	20
1988	2026-05-19 15:00:00	10	20
1996	2026-05-19 15:00:00	31	20
1998	2026-05-19 15:00:00	6	12
2003	2026-05-19 16:00:00	12	28.22
2006	2026-05-19 16:00:00	25	20
2011	2026-05-19 16:00:00	21	20
2017	2026-05-19 16:00:00	13	198
2021	2026-05-19 16:00:00	22	28.26
2028	2026-05-19 16:00:00	14	20
2031	2026-05-19 16:00:00	23	198
2039	2026-05-19 16:00:00	15	20
2040	2026-05-19 16:00:00	24	20
2048	2026-05-19 16:00:00	11	20
2052	2026-05-19 17:00:00	10	20
2057	2026-05-19 17:00:00	45	20
2064	2026-05-19 17:00:00	6	12
2070	2026-05-19 17:00:00	41	20
2075	2026-05-19 17:00:00	7	24.26
2077	2026-05-19 17:00:00	42	28.25
2086	2026-05-19 17:00:00	8	171.6
2087	2026-05-19 17:00:00	43	198
2095	2026-05-19 17:00:00	9	20
2097	2026-05-19 17:00:00	44	20
2104	2026-05-19 18:00:00	18	198
2107	2026-05-19 18:00:00	44	20
2112	2026-05-19 18:00:00	45	20
2119	2026-05-19 18:00:00	19	20
2122	2026-05-19 18:00:00	41	20
2130	2026-05-19 18:00:00	42	28.28
2132	2026-05-19 18:00:00	20	20
2139	2026-05-19 18:00:00	43	198
2141	2026-05-19 18:00:00	16	20
2147	2026-05-19 18:00:00	17	28.3
2155	2026-05-19 19:00:00	18	198
2159	2026-05-19 19:00:00	44	20
2162	2026-05-19 19:00:00	19	20
2164	2026-05-19 19:00:00	45	20
2171	2026-05-19 19:00:00	20	20
2173	2026-05-19 19:00:00	41	20
2180	2026-05-19 19:00:00	16	20
2184	2026-05-19 19:00:00	42	28.4
2189	2026-05-19 19:00:00	17	28.46
2194	2026-05-19 19:00:00	43	198
2205	2026-05-19 20:00:00	26	20
2207	2026-05-19 20:00:00	47	28.42
2216	2026-05-19 20:00:00	27	28.31
2220	2026-05-19 20:00:00	48	198
2228	2026-05-19 20:00:00	28	198
2230	2026-05-19 20:00:00	49	20
2239	2026-05-19 20:00:00	50	20
2240	2026-05-19 20:00:00	29	20
2249	2026-05-19 20:00:00	46	20
2250	2026-05-19 20:00:00	30	20
2252	2026-05-19 21:00:00	5	20
2253	2026-05-19 21:00:00	11	20
2265	2026-05-19 21:00:00	1	12
2267	2026-05-19 21:00:00	12	28.19
2271	2026-05-19 21:00:00	13	198
2275	2026-05-19 21:00:00	2	24.2
2283	2026-05-19 21:00:00	14	20
2287	2026-05-19 21:00:00	3	171.6
426	2026-05-18 08:00:00	16	20
438	2026-05-18 08:00:00	17	28.45
447	2026-05-18 08:00:00	18	198
454	2026-05-18 09:00:00	19	20
461	2026-05-18 09:00:00	20	20
472	2026-05-18 09:00:00	16	20
483	2026-05-18 09:00:00	17	28.2
496	2026-05-18 09:00:00	18	198
504	2026-05-18 10:00:00	25	20
519	2026-05-18 10:00:00	21	20
530	2026-05-18 10:00:00	22	28.23
539	2026-05-18 10:00:00	23	198
547	2026-05-18 10:00:00	24	20
556	2026-05-18 11:00:00	33	198
570	2026-05-18 11:00:00	34	20
584	2026-05-18 11:00:00	35	20
595	2026-05-18 11:00:00	31	20
600	2026-05-18 11:00:00	32	28.23
601	2026-05-18 12:00:00	4	20
612	2026-05-18 12:00:00	5	20
622	2026-05-18 12:00:00	1	12
638	2026-05-18 12:00:00	2	24.29
647	2026-05-18 12:00:00	3	171.6
653	2026-05-18 13:00:00	13	198
666	2026-05-18 13:00:00	14	20
674	2026-05-18 13:00:00	15	20
687	2026-05-18 13:00:00	11	20
696	2026-05-18 13:00:00	12	28.21
709	2026-05-18 14:00:00	27	28.45
720	2026-05-18 14:00:00	28	198
729	2026-05-18 14:00:00	29	20
734	2026-05-18 14:00:00	30	20
749	2026-05-18 14:00:00	26	20
751	2026-05-18 15:00:00	2	24.21
761	2026-05-18 15:00:00	3	171.6
772	2026-05-18 15:00:00	4	20
783	2026-05-18 15:00:00	5	20
794	2026-05-18 15:00:00	1	12
1806	2026-05-19 12:00:00	17	41.4
1816	2026-05-19 12:00:00	18	283.8
1827	2026-05-19 12:00:00	19	20
1837	2026-05-19 12:00:00	20	20
1846	2026-05-19 12:00:00	16	46
1858	2026-05-19 13:00:00	22	28.42
1871	2026-05-19 13:00:00	23	198
1881	2026-05-19 13:00:00	24	20
1890	2026-05-19 13:00:00	25	20
1894	2026-05-19 13:00:00	21	20
1906	2026-05-19 14:00:00	25	20
1919	2026-05-19 14:00:00	21	20
1933	2026-05-19 14:00:00	22	28.29
1943	2026-05-19 14:00:00	23	198
1949	2026-05-19 14:00:00	24	20
1953	2026-05-19 15:00:00	13	198
1961	2026-05-19 15:00:00	14	20
1971	2026-05-19 15:00:00	15	20
1976	2026-05-19 15:00:00	11	20
1986	2026-05-19 15:00:00	12	28.44
2008	2026-05-19 16:00:00	40	20
2020	2026-05-19 16:00:00	36	20
2033	2026-05-19 16:00:00	37	28.45
2043	2026-05-19 16:00:00	38	198
2050	2026-05-19 16:00:00	39	20
2051	2026-05-19 17:00:00	3	171.6
2061	2026-05-19 17:00:00	4	20
2073	2026-05-19 17:00:00	5	20
2084	2026-05-19 17:00:00	1	12
2094	2026-05-19 17:00:00	2	24.35
2105	2026-05-19 18:00:00	27	28.24
2120	2026-05-19 18:00:00	28	198
2131	2026-05-19 18:00:00	29	20
2142	2026-05-19 18:00:00	30	20
2150	2026-05-19 18:00:00	26	20
2151	2026-05-19 19:00:00	8	171.6
2161	2026-05-19 19:00:00	9	20
2172	2026-05-19 19:00:00	10	20
2182	2026-05-19 19:00:00	6	12
2191	2026-05-19 19:00:00	7	24.21
2208	2026-05-19 20:00:00	44	20
2218	2026-05-19 20:00:00	45	20
2229	2026-05-19 20:00:00	41	20
2238	2026-05-19 20:00:00	42	28.46
2246	2026-05-19 20:00:00	43	198
2254	2026-05-19 21:00:00	16	20
2268	2026-05-19 21:00:00	17	28.19
2272	2026-05-19 21:00:00	18	198
2281	2026-05-19 21:00:00	19	20
2292	2026-05-19 21:00:00	20	20
3006	2026-05-20 12:00:00	34	20
3016	2026-05-20 12:00:00	32	41.31
3022	2026-05-20 12:00:00	35	20
3033	2026-05-20 12:00:00	33	283.8
3043	2026-05-20 12:00:00	31	46
3057	2026-05-20 13:00:00	39	20
3062	2026-05-20 13:00:00	40	20
3071	2026-05-20 13:00:00	36	20
3081	2026-05-20 13:00:00	38	198
3093	2026-05-20 13:00:00	37	28.3
3110	2026-05-20 14:00:00	36	20
3122	2026-05-20 14:00:00	38	198
3133	2026-05-20 14:00:00	37	28.47
3143	2026-05-20 14:00:00	39	20
3149	2026-05-20 14:00:00	40	20
3157	2026-05-20 15:00:00	19	20
3170	2026-05-20 15:00:00	20	20
3181	2026-05-20 15:00:00	16	20
3190	2026-05-20 15:00:00	17	28.22
3198	2026-05-20 15:00:00	18	198
3204	2026-05-20 16:00:00	23	198
3213	2026-05-20 16:00:00	24	20
3222	2026-05-20 16:00:00	21	20
3229	2026-05-20 16:00:00	22	28.48
3237	2026-05-20 16:00:00	25	20
3757	2026-05-21 04:00:00	34	20
3764	2026-05-21 04:00:00	32	28.22
3778	2026-05-21 04:00:00	35	20
3788	2026-05-21 04:00:00	33	198
3799	2026-05-21 04:00:00	31	20
3801	2026-05-21 05:00:00	13	198
3812	2026-05-21 05:00:00	12	28.42
3824	2026-05-21 05:00:00	15	20
3833	2026-05-21 05:00:00	11	20
3843	2026-05-21 05:00:00	14	20
3857	2026-05-21 06:00:00	34	20
3867	2026-05-21 06:00:00	32	28.49
3878	2026-05-21 06:00:00	35	20
3887	2026-05-21 06:00:00	33	198
3895	2026-05-21 06:00:00	31	20
3905	2026-05-21 07:00:00	23	198
3916	2026-05-21 07:00:00	22	28.24
3925	2026-05-21 07:00:00	25	20
3935	2026-05-21 07:00:00	24	20
3945	2026-05-21 07:00:00	21	20
3955	2026-05-21 08:00:00	34	20
3966	2026-05-21 08:00:00	32	28.3
3972	2026-05-21 08:00:00	35	20
427	2026-05-18 08:00:00	47	28.29
435	2026-05-18 08:00:00	48	198
446	2026-05-18 08:00:00	49	20
455	2026-05-18 09:00:00	45	20
462	2026-05-18 09:00:00	41	20
471	2026-05-18 09:00:00	42	28.29
481	2026-05-18 09:00:00	43	198
487	2026-05-18 09:00:00	44	20
509	2026-05-18 10:00:00	46	20
523	2026-05-18 10:00:00	47	28.26
534	2026-05-18 10:00:00	48	198
543	2026-05-18 10:00:00	49	20
549	2026-05-18 10:00:00	50	20
551	2026-05-18 11:00:00	10	20
565	2026-05-18 11:00:00	6	12
579	2026-05-18 11:00:00	7	24.42
586	2026-05-18 11:00:00	8	171.6
594	2026-05-18 11:00:00	9	20
604	2026-05-18 12:00:00	26	46
617	2026-05-18 12:00:00	27	41.26
630	2026-05-18 12:00:00	28	283.8
640	2026-05-18 12:00:00	29	20
648	2026-05-18 12:00:00	30	20
652	2026-05-18 13:00:00	9	20
661	2026-05-18 13:00:00	10	20
673	2026-05-18 13:00:00	6	12
684	2026-05-18 13:00:00	7	24.44
697	2026-05-18 13:00:00	8	171.6
704	2026-05-18 14:00:00	19	20
716	2026-05-18 14:00:00	20	20
725	2026-05-18 14:00:00	16	20
739	2026-05-18 14:00:00	17	28.41
744	2026-05-18 14:00:00	18	198
756	2026-05-18 15:00:00	36	20
769	2026-05-18 15:00:00	37	28.47
775	2026-05-18 15:00:00	38	198
780	2026-05-18 15:00:00	39	20
789	2026-05-18 15:00:00	40	20
1808	2026-05-19 12:00:00	28	283.8
1817	2026-05-19 12:00:00	29	20
1825	2026-05-19 12:00:00	30	20
1832	2026-05-19 12:00:00	26	46
1841	2026-05-19 12:00:00	27	41.43
1860	2026-05-19 13:00:00	44	20
1863	2026-05-19 13:00:00	45	20
1877	2026-05-19 13:00:00	41	20
1884	2026-05-19 13:00:00	42	28.31
1897	2026-05-19 13:00:00	43	198
1909	2026-05-19 14:00:00	32	28.48
1913	2026-05-19 14:00:00	33	198
1923	2026-05-19 14:00:00	34	20
1929	2026-05-19 14:00:00	35	20
1940	2026-05-19 14:00:00	31	20
1954	2026-05-19 15:00:00	39	20
1962	2026-05-19 15:00:00	40	20
1972	2026-05-19 15:00:00	36	20
1981	2026-05-19 15:00:00	37	28.24
1989	2026-05-19 15:00:00	38	198
2005	2026-05-19 16:00:00	30	20
2013	2026-05-19 16:00:00	26	20
2023	2026-05-19 16:00:00	27	28.49
2032	2026-05-19 16:00:00	28	198
2044	2026-05-19 16:00:00	29	20
2055	2026-05-19 17:00:00	34	20
2063	2026-05-19 17:00:00	35	20
2072	2026-05-19 17:00:00	31	20
2082	2026-05-19 17:00:00	32	28.43
2092	2026-05-19 17:00:00	33	198
2108	2026-05-19 18:00:00	40	20
2113	2026-05-19 18:00:00	36	20
2124	2026-05-19 18:00:00	37	28.27
2134	2026-05-19 18:00:00	38	198
2143	2026-05-19 18:00:00	39	20
2157	2026-05-19 19:00:00	33	198
2163	2026-05-19 19:00:00	34	20
2175	2026-05-19 19:00:00	35	20
2185	2026-05-19 19:00:00	31	20
2195	2026-05-19 19:00:00	32	28.19
2209	2026-05-19 20:00:00	33	198
2215	2026-05-19 20:00:00	34	20
2226	2026-05-19 20:00:00	35	20
2237	2026-05-19 20:00:00	31	20
2247	2026-05-19 20:00:00	32	28.23
2257	2026-05-19 21:00:00	24	20
2261	2026-05-19 21:00:00	25	20
2273	2026-05-19 21:00:00	21	20
2286	2026-05-19 21:00:00	22	28.36
2294	2026-05-19 21:00:00	23	198
3251	2026-05-20 17:00:00	4	20
3261	2026-05-20 17:00:00	5	20
3272	2026-05-20 17:00:00	1	12
3278	2026-05-20 17:00:00	2	24.21
3289	2026-05-20 17:00:00	3	171.6
3302	2026-05-20 18:00:00	15	20
3317	2026-05-20 18:00:00	13	198
3327	2026-05-20 18:00:00	11	20
3334	2026-05-20 18:00:00	14	20
3344	2026-05-20 18:00:00	12	28.37
3355	2026-05-20 19:00:00	26	20
3366	2026-05-20 19:00:00	29	20
3378	2026-05-20 19:00:00	27	28.25
3390	2026-05-20 19:00:00	28	198
3399	2026-05-20 19:00:00	30	20
3402	2026-05-20 20:00:00	6	12
3417	2026-05-20 20:00:00	9	20
3428	2026-05-20 20:00:00	7	24.49
3438	2026-05-20 20:00:00	8	171.6
3444	2026-05-20 20:00:00	10	20
3457	2026-05-20 21:00:00	30	20
3463	2026-05-20 21:00:00	26	20
3471	2026-05-20 21:00:00	29	20
3481	2026-05-20 21:00:00	27	28.29
3492	2026-05-20 21:00:00	28	198
3507	2026-05-20 22:00:00	38	198
3518	2026-05-20 22:00:00	37	28.28
3530	2026-05-20 22:00:00	39	20
3543	2026-05-20 22:00:00	40	20
3549	2026-05-20 22:00:00	36	20
3552	2026-05-20 23:00:00	9	20
3564	2026-05-20 23:00:00	6	12
3575	2026-05-20 23:00:00	8	171.6
3588	2026-05-20 23:00:00	10	20
3597	2026-05-20 23:00:00	7	24.25
3603	2026-05-21 00:00:00	14	20
3614	2026-05-21 00:00:00	13	198
3625	2026-05-21 00:00:00	12	28.33
3638	2026-05-21 00:00:00	15	20
3645	2026-05-21 00:00:00	11	20
3657	2026-05-21 02:00:00	27	28.19
3664	2026-05-21 02:00:00	28	198
3672	2026-05-21 02:00:00	30	20
3681	2026-05-21 02:00:00	26	20
3687	2026-05-21 02:00:00	29	20
3710	2026-05-21 03:00:00	46	20
3720	2026-05-21 03:00:00	47	28.36
3732	2026-05-21 03:00:00	49	20
428	2026-05-18 08:00:00	38	198
439	2026-05-18 08:00:00	39	20
450	2026-05-18 08:00:00	40	20
453	2026-05-18 09:00:00	11	20
468	2026-05-18 09:00:00	12	28.47
477	2026-05-18 09:00:00	13	198
489	2026-05-18 09:00:00	14	20
495	2026-05-18 09:00:00	15	20
505	2026-05-18 10:00:00	28	198
516	2026-05-18 10:00:00	29	20
525	2026-05-18 10:00:00	30	20
536	2026-05-18 10:00:00	26	20
544	2026-05-18 10:00:00	27	28.36
555	2026-05-18 11:00:00	26	20
562	2026-05-18 11:00:00	27	28.41
572	2026-05-18 11:00:00	28	198
580	2026-05-18 11:00:00	29	20
589	2026-05-18 11:00:00	30	20
610	2026-05-18 12:00:00	38	283.8
618	2026-05-18 12:00:00	39	20
631	2026-05-18 12:00:00	40	20
641	2026-05-18 12:00:00	36	46
650	2026-05-18 12:00:00	37	41.31
651	2026-05-18 13:00:00	3	171.6
664	2026-05-18 13:00:00	4	20
676	2026-05-18 13:00:00	5	20
690	2026-05-18 13:00:00	1	12
699	2026-05-18 13:00:00	2	24.46
705	2026-05-18 14:00:00	10	20
713	2026-05-18 14:00:00	6	12
726	2026-05-18 14:00:00	7	24.47
738	2026-05-18 14:00:00	8	171.6
743	2026-05-18 14:00:00	9	20
754	2026-05-18 15:00:00	31	20
764	2026-05-18 15:00:00	32	28.36
774	2026-05-18 15:00:00	33	198
785	2026-05-18 15:00:00	34	20
796	2026-05-18 15:00:00	35	20
1807	2026-05-19 12:00:00	25	20
1819	2026-05-19 12:00:00	21	46
1828	2026-05-19 12:00:00	22	41.25
1844	2026-05-19 12:00:00	23	283.8
1850	2026-05-19 12:00:00	24	20
1851	2026-05-19 13:00:00	2	24.35
1862	2026-05-19 13:00:00	3	171.6
1872	2026-05-19 13:00:00	4	20
1886	2026-05-19 13:00:00	5	20
1896	2026-05-19 13:00:00	1	12
1905	2026-05-19 14:00:00	30	20
1911	2026-05-19 14:00:00	26	20
1921	2026-05-19 14:00:00	27	28.29
1934	2026-05-19 14:00:00	28	198
1944	2026-05-19 14:00:00	29	20
1959	2026-05-19 15:00:00	30	20
1969	2026-05-19 15:00:00	26	20
1983	2026-05-19 15:00:00	27	28.22
1995	2026-05-19 15:00:00	28	198
2000	2026-05-19 15:00:00	29	20
2001	2026-05-19 16:00:00	1	12
2015	2026-05-19 16:00:00	2	24.32
2026	2026-05-19 16:00:00	3	171.6
2035	2026-05-19 16:00:00	4	20
2045	2026-05-19 16:00:00	5	20
2059	2026-05-19 17:00:00	28	198
2068	2026-05-19 17:00:00	29	20
2079	2026-05-19 17:00:00	30	20
2083	2026-05-19 17:00:00	26	20
2089	2026-05-19 17:00:00	27	28.26
2109	2026-05-19 18:00:00	47	28.19
2118	2026-05-19 18:00:00	48	198
2129	2026-05-19 18:00:00	49	20
2140	2026-05-19 18:00:00	50	20
2148	2026-05-19 18:00:00	46	20
2152	2026-05-19 19:00:00	12	28.3
2165	2026-05-19 19:00:00	13	198
2174	2026-05-19 19:00:00	14	20
2186	2026-05-19 19:00:00	15	20
2196	2026-05-19 19:00:00	11	20
2206	2026-05-19 20:00:00	22	28.22
2217	2026-05-19 20:00:00	23	198
2222	2026-05-19 20:00:00	24	20
2231	2026-05-19 20:00:00	25	20
2243	2026-05-19 20:00:00	21	20
2256	2026-05-19 21:00:00	37	28.42
2264	2026-05-19 21:00:00	38	198
2276	2026-05-19 21:00:00	39	20
2284	2026-05-19 21:00:00	40	20
2293	2026-05-19 21:00:00	36	20
3252	2026-05-20 17:00:00	9	20
3262	2026-05-20 17:00:00	7	24.48
3276	2026-05-20 17:00:00	8	171.6
3286	2026-05-20 17:00:00	10	20
3295	2026-05-20 17:00:00	6	12
3307	2026-05-20 18:00:00	34	20
3316	2026-05-20 18:00:00	32	28.38
3328	2026-05-20 18:00:00	35	20
3339	2026-05-20 18:00:00	33	198
3346	2026-05-20 18:00:00	31	20
3354	2026-05-20 19:00:00	18	198
3365	2026-05-20 19:00:00	19	20
3371	2026-05-20 19:00:00	20	20
3380	2026-05-20 19:00:00	16	20
3388	2026-05-20 19:00:00	17	28.31
3409	2026-05-20 20:00:00	50	20
3414	2026-05-20 20:00:00	46	20
3423	2026-05-20 20:00:00	47	28.47
3436	2026-05-20 20:00:00	49	20
3446	2026-05-20 20:00:00	48	198
3455	2026-05-20 21:00:00	24	20
3468	2026-05-20 21:00:00	21	20
3479	2026-05-20 21:00:00	22	28.4
3486	2026-05-20 21:00:00	23	198
3496	2026-05-20 21:00:00	25	20
3505	2026-05-20 22:00:00	29	20
3512	2026-05-20 22:00:00	27	28.27
3522	2026-05-20 22:00:00	28	198
3531	2026-05-20 22:00:00	30	20
3535	2026-05-20 22:00:00	26	20
3560	2026-05-20 23:00:00	46	20
3567	2026-05-20 23:00:00	47	28.2
3580	2026-05-20 23:00:00	49	20
3586	2026-05-20 23:00:00	48	198
3592	2026-05-20 23:00:00	50	20
3607	2026-05-21 00:00:00	34	20
3610	2026-05-21 00:00:00	32	28.38
3620	2026-05-21 00:00:00	35	20
3627	2026-05-21 00:00:00	33	198
3634	2026-05-21 00:00:00	31	20
3658	2026-05-21 02:00:00	46	20
3666	2026-05-21 02:00:00	47	28.42
3674	2026-05-21 02:00:00	49	20
3686	2026-05-21 02:00:00	48	198
3697	2026-05-21 02:00:00	50	20
3705	2026-05-21 03:00:00	23	198
3713	2026-05-21 03:00:00	25	20
3727	2026-05-21 03:00:00	24	20
429	2026-05-18 08:00:00	8	171.6
437	2026-05-18 08:00:00	9	20
449	2026-05-18 08:00:00	10	20
451	2026-05-18 09:00:00	4	20
463	2026-05-18 09:00:00	5	20
473	2026-05-18 09:00:00	1	12
485	2026-05-18 09:00:00	2	24.49
497	2026-05-18 09:00:00	3	171.6
507	2026-05-18 10:00:00	18	198
513	2026-05-18 10:00:00	19	20
522	2026-05-18 10:00:00	20	20
531	2026-05-18 10:00:00	16	20
541	2026-05-18 10:00:00	17	28.2
559	2026-05-18 11:00:00	39	20
564	2026-05-18 11:00:00	40	20
576	2026-05-18 11:00:00	36	20
590	2026-05-18 11:00:00	37	28.29
599	2026-05-18 11:00:00	38	198
602	2026-05-18 12:00:00	9	20
614	2026-05-18 12:00:00	10	20
628	2026-05-18 12:00:00	6	12
639	2026-05-18 12:00:00	7	24.46
649	2026-05-18 12:00:00	8	171.6
657	2026-05-18 13:00:00	20	20
668	2026-05-18 13:00:00	16	20
679	2026-05-18 13:00:00	17	28.23
686	2026-05-18 13:00:00	18	198
695	2026-05-18 13:00:00	19	20
706	2026-05-18 14:00:00	32	28.22
718	2026-05-18 14:00:00	33	198
730	2026-05-18 14:00:00	34	20
740	2026-05-18 14:00:00	35	20
750	2026-05-18 14:00:00	31	20
752	2026-05-18 15:00:00	7	24.37
762	2026-05-18 15:00:00	8	171.6
770	2026-05-18 15:00:00	9	20
782	2026-05-18 15:00:00	10	20
791	2026-05-18 15:00:00	6	12
1809	2026-05-19 12:00:00	38	283.8
1818	2026-05-19 12:00:00	39	20
1829	2026-05-19 12:00:00	40	20
1836	2026-05-19 12:00:00	36	46
1843	2026-05-19 12:00:00	37	41.41
1856	2026-05-19 13:00:00	33	198
1865	2026-05-19 13:00:00	34	20
1875	2026-05-19 13:00:00	35	20
1883	2026-05-19 13:00:00	31	20
1893	2026-05-19 13:00:00	32	28.44
1907	2026-05-19 14:00:00	17	28.31
1920	2026-05-19 14:00:00	18	198
1930	2026-05-19 14:00:00	19	20
1941	2026-05-19 14:00:00	20	20
1947	2026-05-19 14:00:00	16	20
1955	2026-05-19 15:00:00	25	20
1965	2026-05-19 15:00:00	21	20
1975	2026-05-19 15:00:00	22	28.29
1982	2026-05-19 15:00:00	23	198
1992	2026-05-19 15:00:00	24	20
2010	2026-05-19 16:00:00	47	28.25
2014	2026-05-19 16:00:00	48	198
2027	2026-05-19 16:00:00	49	20
2037	2026-05-19 16:00:00	50	20
2046	2026-05-19 16:00:00	46	20
2054	2026-05-19 17:00:00	20	20
2065	2026-05-19 17:00:00	16	20
2076	2026-05-19 17:00:00	17	28.36
2090	2026-05-19 17:00:00	18	198
2099	2026-05-19 17:00:00	19	20
2102	2026-05-19 18:00:00	8	171.6
2111	2026-05-19 18:00:00	9	20
2121	2026-05-19 18:00:00	10	20
2128	2026-05-19 18:00:00	6	12
2133	2026-05-19 18:00:00	7	24.45
2158	2026-05-19 19:00:00	47	28.22
2170	2026-05-19 19:00:00	48	198
2181	2026-05-19 19:00:00	49	20
2192	2026-05-19 19:00:00	50	20
2200	2026-05-19 19:00:00	46	20
2201	2026-05-19 20:00:00	3	171.6
2211	2026-05-19 20:00:00	4	20
2221	2026-05-19 20:00:00	5	20
2233	2026-05-19 20:00:00	1	12
2244	2026-05-19 20:00:00	2	24.26
2255	2026-05-19 21:00:00	28	198
2263	2026-05-19 21:00:00	29	20
2278	2026-05-19 21:00:00	30	20
2288	2026-05-19 21:00:00	26	20
2298	2026-05-19 21:00:00	27	28.45
3253	2026-05-20 17:00:00	18	198
3263	2026-05-20 17:00:00	19	20
3275	2026-05-20 17:00:00	20	20
3287	2026-05-20 17:00:00	16	20
3299	2026-05-20 17:00:00	17	28.47
3303	2026-05-20 18:00:00	8	171.6
3319	2026-05-20 18:00:00	10	20
3330	2026-05-20 18:00:00	6	12
3340	2026-05-20 18:00:00	9	20
3348	2026-05-20 18:00:00	7	24.33
3357	2026-05-20 19:00:00	21	20
3370	2026-05-20 19:00:00	22	28.33
3381	2026-05-20 19:00:00	25	20
3391	2026-05-20 19:00:00	23	198
3400	2026-05-20 19:00:00	24	20
3401	2026-05-20 20:00:00	3	171.6
3418	2026-05-20 20:00:00	4	20
3429	2026-05-20 20:00:00	5	20
3443	2026-05-20 20:00:00	1	12
3449	2026-05-20 20:00:00	2	24.26
3451	2026-05-20 21:00:00	2	24.26
3462	2026-05-20 21:00:00	3	171.6
3473	2026-05-20 21:00:00	4	20
3482	2026-05-20 21:00:00	5	20
3491	2026-05-20 21:00:00	1	12
3510	2026-05-20 22:00:00	41	20
3513	2026-05-20 22:00:00	42	28.2
3527	2026-05-20 22:00:00	45	20
3534	2026-05-20 22:00:00	43	198
3542	2026-05-20 22:00:00	44	20
3559	2026-05-20 23:00:00	42	28.26
3569	2026-05-20 23:00:00	45	20
3573	2026-05-20 23:00:00	43	198
3583	2026-05-20 23:00:00	44	20
3594	2026-05-20 23:00:00	41	20
3609	2026-05-21 00:00:00	38	198
3616	2026-05-21 00:00:00	37	28.2
3622	2026-05-21 00:00:00	39	20
3631	2026-05-21 00:00:00	40	20
3637	2026-05-21 00:00:00	36	20
3660	2026-05-21 02:00:00	38	198
3669	2026-05-21 02:00:00	37	28.28
3678	2026-05-21 02:00:00	39	20
3692	2026-05-21 02:00:00	40	20
3699	2026-05-21 02:00:00	36	20
3701	2026-05-21 03:00:00	2	24.43
3714	2026-05-21 03:00:00	1	12
3726	2026-05-21 03:00:00	3	171.6
430	2026-05-18 08:00:00	42	28.32
440	2026-05-18 08:00:00	43	198
448	2026-05-18 08:00:00	44	20
452	2026-05-18 09:00:00	6	12
464	2026-05-18 09:00:00	7	24.45
475	2026-05-18 09:00:00	8	171.6
484	2026-05-18 09:00:00	9	20
498	2026-05-18 09:00:00	10	20
502	2026-05-18 10:00:00	12	28.42
514	2026-05-18 10:00:00	13	198
528	2026-05-18 10:00:00	14	20
540	2026-05-18 10:00:00	15	20
548	2026-05-18 10:00:00	11	20
554	2026-05-18 11:00:00	14	20
563	2026-05-18 11:00:00	15	20
573	2026-05-18 11:00:00	11	20
581	2026-05-18 11:00:00	12	28.27
592	2026-05-18 11:00:00	13	198
606	2026-05-18 12:00:00	31	46
619	2026-05-18 12:00:00	32	41.24
625	2026-05-18 12:00:00	33	283.8
633	2026-05-18 12:00:00	34	20
644	2026-05-18 12:00:00	35	20
658	2026-05-18 13:00:00	26	20
670	2026-05-18 13:00:00	27	28.22
677	2026-05-18 13:00:00	28	198
683	2026-05-18 13:00:00	29	20
691	2026-05-18 13:00:00	30	20
707	2026-05-18 14:00:00	48	198
715	2026-05-18 14:00:00	49	20
721	2026-05-18 14:00:00	50	20
735	2026-05-18 14:00:00	46	20
745	2026-05-18 14:00:00	47	28.32
760	2026-05-18 15:00:00	22	28.27
767	2026-05-18 15:00:00	23	198
778	2026-05-18 15:00:00	24	20
787	2026-05-18 15:00:00	25	20
798	2026-05-18 15:00:00	21	20
1810	2026-05-19 12:00:00	42	41.2
1820	2026-05-19 12:00:00	43	283.8
1831	2026-05-19 12:00:00	44	20
1842	2026-05-19 12:00:00	45	20
1849	2026-05-19 12:00:00	41	46
1852	2026-05-19 13:00:00	8	171.6
1866	2026-05-19 13:00:00	9	20
1876	2026-05-19 13:00:00	10	20
1885	2026-05-19 13:00:00	6	12
1895	2026-05-19 13:00:00	7	24.24
1903	2026-05-19 14:00:00	39	20
1914	2026-05-19 14:00:00	40	20
1924	2026-05-19 14:00:00	36	20
1936	2026-05-19 14:00:00	37	28.35
1946	2026-05-19 14:00:00	38	198
1960	2026-05-19 15:00:00	17	28.33
1970	2026-05-19 15:00:00	18	198
1985	2026-05-19 15:00:00	19	20
1994	2026-05-19 15:00:00	20	20
1999	2026-05-19 15:00:00	16	20
2002	2026-05-19 16:00:00	8	171.6
2016	2026-05-19 16:00:00	9	20
2024	2026-05-19 16:00:00	10	20
2034	2026-05-19 16:00:00	6	12
2041	2026-05-19 16:00:00	7	24.42
2056	2026-05-19 17:00:00	36	20
2062	2026-05-19 17:00:00	37	28.22
2071	2026-05-19 17:00:00	38	198
2081	2026-05-19 17:00:00	39	20
2093	2026-05-19 17:00:00	40	20
2110	2026-05-19 18:00:00	33	198
2114	2026-05-19 18:00:00	34	20
2123	2026-05-19 18:00:00	35	20
2135	2026-05-19 18:00:00	31	20
2146	2026-05-19 18:00:00	32	28.37
2160	2026-05-19 19:00:00	40	20
2168	2026-05-19 19:00:00	36	20
2177	2026-05-19 19:00:00	37	28.23
2187	2026-05-19 19:00:00	38	198
2197	2026-05-19 19:00:00	39	20
2204	2026-05-19 20:00:00	19	20
2214	2026-05-19 20:00:00	20	20
2224	2026-05-19 20:00:00	16	20
2234	2026-05-19 20:00:00	17	28.34
2245	2026-05-19 20:00:00	18	198
2258	2026-05-19 21:00:00	35	20
2269	2026-05-19 21:00:00	31	20
2279	2026-05-19 21:00:00	32	28.22
2290	2026-05-19 21:00:00	33	198
2300	2026-05-19 21:00:00	34	20
3254	2026-05-20 17:00:00	44	20
3264	2026-05-20 17:00:00	41	20
3271	2026-05-20 17:00:00	42	28.21
3277	2026-05-20 17:00:00	45	20
3284	2026-05-20 17:00:00	43	198
3308	2026-05-20 18:00:00	48	198
3313	2026-05-20 18:00:00	50	20
3321	2026-05-20 18:00:00	46	20
3329	2026-05-20 18:00:00	47	28.31
3337	2026-05-20 18:00:00	49	20
3359	2026-05-20 19:00:00	49	20
3364	2026-05-20 19:00:00	48	198
3372	2026-05-20 19:00:00	50	20
3382	2026-05-20 19:00:00	46	20
3395	2026-05-20 19:00:00	47	28.22
3405	2026-05-20 20:00:00	30	20
3416	2026-05-20 20:00:00	26	20
3425	2026-05-20 20:00:00	29	20
3439	2026-05-20 20:00:00	27	28.46
3447	2026-05-20 20:00:00	28	198
3454	2026-05-20 21:00:00	18	198
3466	2026-05-20 21:00:00	19	20
3477	2026-05-20 21:00:00	20	20
3488	2026-05-20 21:00:00	16	20
3499	2026-05-20 21:00:00	17	28.3
3501	2026-05-20 22:00:00	3	171.6
3514	2026-05-20 22:00:00	4	20
3524	2026-05-20 22:00:00	2	24.42
3538	2026-05-20 22:00:00	5	20
3548	2026-05-20 22:00:00	1	12
3554	2026-05-20 23:00:00	14	20
3563	2026-05-20 23:00:00	13	198
3572	2026-05-20 23:00:00	12	28.41
3582	2026-05-20 23:00:00	15	20
3591	2026-05-20 23:00:00	11	20
3608	2026-05-21 00:00:00	42	28.33
3611	2026-05-21 00:00:00	45	20
3624	2026-05-21 00:00:00	43	198
3635	2026-05-21 00:00:00	44	20
3644	2026-05-21 00:00:00	41	20
3654	2026-05-21 02:00:00	20	20
3667	2026-05-21 02:00:00	16	20
3679	2026-05-21 02:00:00	18	198
3691	2026-05-21 02:00:00	17	28.24
3698	2026-05-21 02:00:00	19	20
3704	2026-05-21 03:00:00	8	171.6
3716	2026-05-21 03:00:00	10	20
3724	2026-05-21 03:00:00	7	24.47
433	2026-05-18 08:00:00	30	20
442	2026-05-18 08:00:00	26	20
459	2026-05-18 09:00:00	50	20
467	2026-05-18 09:00:00	46	20
480	2026-05-18 09:00:00	47	28.22
490	2026-05-18 09:00:00	48	198
494	2026-05-18 09:00:00	49	20
506	2026-05-18 10:00:00	32	28.3
517	2026-05-18 10:00:00	33	198
526	2026-05-18 10:00:00	34	20
537	2026-05-18 10:00:00	35	20
545	2026-05-18 10:00:00	31	20
553	2026-05-18 11:00:00	16	20
567	2026-05-18 11:00:00	17	28.3
574	2026-05-18 11:00:00	18	198
587	2026-05-18 11:00:00	19	20
596	2026-05-18 11:00:00	20	20
605	2026-05-18 12:00:00	22	41.37
611	2026-05-18 12:00:00	23	283.8
621	2026-05-18 12:00:00	24	20
629	2026-05-18 12:00:00	25	20
636	2026-05-18 12:00:00	21	46
660	2026-05-18 13:00:00	47	28.26
667	2026-05-18 13:00:00	48	198
681	2026-05-18 13:00:00	49	20
693	2026-05-18 13:00:00	50	20
700	2026-05-18 13:00:00	46	20
701	2026-05-18 14:00:00	4	20
712	2026-05-18 14:00:00	5	20
723	2026-05-18 14:00:00	1	12
736	2026-05-18 14:00:00	2	24.41
746	2026-05-18 14:00:00	3	171.6
753	2026-05-18 15:00:00	30	20
771	2026-05-18 15:00:00	26	20
781	2026-05-18 15:00:00	27	28.38
792	2026-05-18 15:00:00	28	198
800	2026-05-18 15:00:00	29	20
801	2026-05-18 16:00:00	1	12
802	2026-05-18 16:00:00	21	20
803	2026-05-18 16:00:00	35	20
806	2026-05-18 16:00:00	28	198
808	2026-05-18 16:00:00	49	20
807	2026-05-18 16:00:00	36	20
804	2026-05-18 16:00:00	20	20
809	2026-05-18 16:00:00	43	198
805	2026-05-18 16:00:00	7	24.47
810	2026-05-18 16:00:00	11	20
811	2026-05-18 16:00:00	2	24.33
812	2026-05-18 16:00:00	22	28.46
813	2026-05-18 16:00:00	50	20
814	2026-05-18 16:00:00	37	28.4
815	2026-05-18 16:00:00	12	28.2
816	2026-05-18 16:00:00	8	171.6
817	2026-05-18 16:00:00	31	20
818	2026-05-18 16:00:00	29	20
819	2026-05-18 16:00:00	44	20
820	2026-05-18 16:00:00	3	171.6
821	2026-05-18 16:00:00	16	20
822	2026-05-18 16:00:00	38	198
823	2026-05-18 16:00:00	13	198
824	2026-05-18 16:00:00	23	198
825	2026-05-18 16:00:00	46	20
826	2026-05-18 16:00:00	9	20
827	2026-05-18 16:00:00	45	20
828	2026-05-18 16:00:00	30	20
829	2026-05-18 16:00:00	32	28.26
830	2026-05-18 16:00:00	39	20
831	2026-05-18 16:00:00	17	28.41
832	2026-05-18 16:00:00	4	20
833	2026-05-18 16:00:00	14	20
834	2026-05-18 16:00:00	47	28.2
835	2026-05-18 16:00:00	24	20
836	2026-05-18 16:00:00	10	20
837	2026-05-18 16:00:00	41	20
838	2026-05-18 16:00:00	26	20
839	2026-05-18 16:00:00	40	20
840	2026-05-18 16:00:00	18	198
841	2026-05-18 16:00:00	33	198
842	2026-05-18 16:00:00	5	20
843	2026-05-18 16:00:00	15	20
844	2026-05-18 16:00:00	48	198
845	2026-05-18 16:00:00	42	28.3
846	2026-05-18 16:00:00	6	12
847	2026-05-18 16:00:00	27	28.42
848	2026-05-18 16:00:00	25	20
849	2026-05-18 16:00:00	19	20
850	2026-05-18 16:00:00	34	20
853	2026-05-18 17:00:00	2	24.43
852	2026-05-18 17:00:00	8	171.6
851	2026-05-18 17:00:00	13	198
854	2026-05-18 17:00:00	20	20
855	2026-05-18 17:00:00	22	28.31
857	2026-05-18 17:00:00	29	20
856	2026-05-18 17:00:00	31	20
858	2026-05-18 17:00:00	37	28.46
859	2026-05-18 17:00:00	44	20
860	2026-05-18 17:00:00	50	20
861	2026-05-18 17:00:00	3	171.6
862	2026-05-18 17:00:00	9	20
863	2026-05-18 17:00:00	16	20
864	2026-05-18 17:00:00	14	20
865	2026-05-18 17:00:00	46	20
866	2026-05-18 17:00:00	32	28.3
867	2026-05-18 17:00:00	38	198
868	2026-05-18 17:00:00	23	198
869	2026-05-18 17:00:00	45	20
870	2026-05-18 17:00:00	30	20
871	2026-05-18 17:00:00	33	198
872	2026-05-18 17:00:00	47	28.28
873	2026-05-18 17:00:00	4	20
874	2026-05-18 17:00:00	17	28.28
875	2026-05-18 17:00:00	10	20
876	2026-05-18 17:00:00	15	20
877	2026-05-18 17:00:00	26	20
878	2026-05-18 17:00:00	39	20
879	2026-05-18 17:00:00	24	20
880	2026-05-18 17:00:00	41	20
881	2026-05-18 17:00:00	34	20
882	2026-05-18 17:00:00	27	28.44
883	2026-05-18 17:00:00	48	198
884	2026-05-18 17:00:00	35	20
885	2026-05-18 17:00:00	6	12
886	2026-05-18 17:00:00	18	198
887	2026-05-18 17:00:00	11	20
888	2026-05-18 17:00:00	5	20
889	2026-05-18 17:00:00	25	20
890	2026-05-18 17:00:00	42	28.24
891	2026-05-18 17:00:00	40	20
892	2026-05-18 17:00:00	49	20
893	2026-05-18 17:00:00	28	198
894	2026-05-18 17:00:00	7	24.26
895	2026-05-18 17:00:00	19	20
896	2026-05-18 17:00:00	12	28.27
897	2026-05-18 17:00:00	1	12
898	2026-05-18 17:00:00	43	198
899	2026-05-18 17:00:00	21	20
900	2026-05-18 17:00:00	36	20
902	2026-05-18 18:00:00	4	20
911	2026-05-18 18:00:00	5	20
921	2026-05-18 18:00:00	1	12
930	2026-05-18 18:00:00	2	24.48
941	2026-05-18 18:00:00	3	171.6
955	2026-05-18 19:00:00	32	28.47
964	2026-05-18 19:00:00	33	198
974	2026-05-18 19:00:00	34	20
983	2026-05-18 19:00:00	35	20
991	2026-05-18 19:00:00	31	20
1006	2026-05-18 20:00:00	39	20
1013	2026-05-18 20:00:00	40	20
1022	2026-05-18 20:00:00	36	20
1030	2026-05-18 20:00:00	37	28.26
1037	2026-05-18 20:00:00	38	198
1060	2026-05-18 21:00:00	44	20
1066	2026-05-18 21:00:00	45	20
1080	2026-05-18 21:00:00	41	20
1093	2026-05-18 21:00:00	42	28.47
1099	2026-05-18 21:00:00	43	198
1103	2026-05-18 22:00:00	14	20
1113	2026-05-18 22:00:00	15	20
1123	2026-05-18 22:00:00	11	20
1134	2026-05-18 22:00:00	12	28.24
1143	2026-05-18 22:00:00	13	198
1157	2026-05-18 23:00:00	36	20
1162	2026-05-18 23:00:00	37	28.23
1172	2026-05-18 23:00:00	38	198
1183	2026-05-18 23:00:00	39	20
1192	2026-05-18 23:00:00	40	20
1208	2026-05-19 00:00:00	36	20
1220	2026-05-19 00:00:00	37	28.28
1227	2026-05-19 00:00:00	38	198
1237	2026-05-19 00:00:00	39	20
1246	2026-05-19 00:00:00	40	20
1258	2026-05-19 01:00:00	30	20
1270	2026-05-19 01:00:00	26	20
1280	2026-05-19 01:00:00	27	28.26
1289	2026-05-19 01:00:00	28	198
1300	2026-05-19 01:00:00	29	20
2296	2026-05-19 21:00:00	15	20
3255	2026-05-20 17:00:00	23	198
3266	2026-05-20 17:00:00	24	20
3274	2026-05-20 17:00:00	21	20
3285	2026-05-20 17:00:00	22	28.47
3294	2026-05-20 17:00:00	25	20
3309	2026-05-20 18:00:00	37	28.47
3312	2026-05-20 18:00:00	39	20
3323	2026-05-20 18:00:00	40	20
3336	2026-05-20 18:00:00	36	20
3347	2026-05-20 18:00:00	38	198
3352	2026-05-20 19:00:00	14	20
3362	2026-05-20 19:00:00	12	28.25
3374	2026-05-20 19:00:00	15	20
3386	2026-05-20 19:00:00	13	198
3397	2026-05-20 19:00:00	11	20
3406	2026-05-20 20:00:00	24	20
3415	2026-05-20 20:00:00	21	20
3424	2026-05-20 20:00:00	22	28.4
3435	2026-05-20 20:00:00	25	20
3441	2026-05-20 20:00:00	23	198
3456	2026-05-20 21:00:00	32	28.33
3465	2026-05-20 21:00:00	35	20
3476	2026-05-20 21:00:00	33	198
3489	2026-05-20 21:00:00	31	20
3500	2026-05-20 21:00:00	34	20
3503	2026-05-20 22:00:00	9	20
3515	2026-05-20 22:00:00	6	12
3525	2026-05-20 22:00:00	8	171.6
3540	2026-05-20 22:00:00	10	20
3547	2026-05-20 22:00:00	7	24.25
3555	2026-05-20 23:00:00	18	198
3565	2026-05-20 23:00:00	17	28.34
3578	2026-05-20 23:00:00	19	20
3587	2026-05-20 23:00:00	20	20
3595	2026-05-20 23:00:00	16	20
3604	2026-05-21 00:00:00	18	198
3615	2026-05-21 00:00:00	17	28.44
3621	2026-05-21 00:00:00	19	20
3630	2026-05-21 00:00:00	20	20
3636	2026-05-21 00:00:00	16	20
3659	2026-05-21 02:00:00	42	28.41
3665	2026-05-21 02:00:00	45	20
3673	2026-05-21 02:00:00	43	198
3685	2026-05-21 02:00:00	44	20
3693	2026-05-21 02:00:00	41	20
3708	2026-05-21 03:00:00	38	198
3719	2026-05-21 03:00:00	37	28.41
3731	2026-05-21 03:00:00	39	20
3737	2026-05-21 03:00:00	40	20
3744	2026-05-21 03:00:00	36	20
3758	2026-05-21 04:00:00	46	20
3770	2026-05-21 04:00:00	47	28.22
3779	2026-05-21 04:00:00	49	20
3789	2026-05-21 04:00:00	48	198
3800	2026-05-21 04:00:00	50	20
3802	2026-05-21 05:00:00	2	24.24
3814	2026-05-21 05:00:00	5	20
3827	2026-05-21 05:00:00	1	12
3839	2026-05-21 05:00:00	3	171.6
3847	2026-05-21 05:00:00	4	20
3854	2026-05-21 06:00:00	13	198
3866	2026-05-21 06:00:00	12	28.24
3871	2026-05-21 06:00:00	15	20
3882	2026-05-21 06:00:00	11	20
3892	2026-05-21 06:00:00	14	20
3907	2026-05-21 07:00:00	34	20
3918	2026-05-21 07:00:00	32	28.3
3929	2026-05-21 07:00:00	35	20
3939	2026-05-21 07:00:00	33	198
3948	2026-05-21 07:00:00	31	20
3954	2026-05-21 08:00:00	17	28.31
3967	2026-05-21 08:00:00	19	20
3978	2026-05-21 08:00:00	20	20
3989	2026-05-21 08:00:00	18	198
4000	2026-05-21 08:00:00	16	20
4006	2026-05-21 09:00:00	20	20
4020	2026-05-21 09:00:00	18	198
4032	2026-05-21 09:00:00	17	28.32
4042	2026-05-21 09:00:00	16	20
4050	2026-05-21 09:00:00	19	20
4054	2026-05-21 10:00:00	14	20
4067	2026-05-21 10:00:00	13	198
4078	2026-05-21 10:00:00	15	20
4087	2026-05-21 10:00:00	12	28.48
4098	2026-05-21 10:00:00	11	20
4102	2026-05-21 11:00:00	6	12
4117	2026-05-21 11:00:00	7	24.23
4129	2026-05-21 11:00:00	8	171.6
4135	2026-05-21 11:00:00	10	20
4145	2026-05-21 11:00:00	9	20
4156	2026-05-21 12:00:00	33	283.8
4162	2026-05-21 12:00:00	31	46
4168	2026-05-21 12:00:00	34	20
4175	2026-05-21 12:00:00	32	41.21
901	2026-05-18 18:00:00	10	20
912	2026-05-18 18:00:00	6	12
923	2026-05-18 18:00:00	7	24.27
934	2026-05-18 18:00:00	8	171.6
943	2026-05-18 18:00:00	9	20
959	2026-05-18 19:00:00	40	20
970	2026-05-18 19:00:00	36	20
984	2026-05-18 19:00:00	37	28.36
993	2026-05-18 19:00:00	38	198
997	2026-05-18 19:00:00	39	20
1002	2026-05-18 20:00:00	13	198
1017	2026-05-18 20:00:00	14	20
1028	2026-05-18 20:00:00	15	20
1040	2026-05-18 20:00:00	11	20
1048	2026-05-18 20:00:00	12	28.36
1057	2026-05-18 21:00:00	19	20
1070	2026-05-18 21:00:00	20	20
1082	2026-05-18 21:00:00	16	20
1092	2026-05-18 21:00:00	17	28.2
1100	2026-05-18 21:00:00	18	198
1102	2026-05-18 22:00:00	5	20
1111	2026-05-18 22:00:00	1	12
1121	2026-05-18 22:00:00	2	24.39
1131	2026-05-18 22:00:00	3	171.6
1141	2026-05-18 22:00:00	4	20
1155	2026-05-18 23:00:00	46	20
1163	2026-05-18 23:00:00	47	28.36
1175	2026-05-18 23:00:00	48	198
1182	2026-05-18 23:00:00	49	20
1195	2026-05-18 23:00:00	50	20
1206	2026-05-19 00:00:00	35	20
1214	2026-05-19 00:00:00	31	20
1230	2026-05-19 00:00:00	32	28.37
1241	2026-05-19 00:00:00	33	198
1249	2026-05-19 00:00:00	34	20
1251	2026-05-19 01:00:00	10	20
1264	2026-05-19 01:00:00	6	12
1273	2026-05-19 01:00:00	7	24.41
1283	2026-05-19 01:00:00	8	171.6
1295	2026-05-19 01:00:00	9	20
2297	2026-05-19 21:00:00	4	20
3256	2026-05-20 17:00:00	12	28.28
3268	2026-05-20 17:00:00	15	20
3281	2026-05-20 17:00:00	13	198
3291	2026-05-20 17:00:00	11	20
3297	2026-05-20 17:00:00	14	20
3305	2026-05-20 18:00:00	28	198
3320	2026-05-20 18:00:00	30	20
3331	2026-05-20 18:00:00	26	20
3341	2026-05-20 18:00:00	29	20
3350	2026-05-20 18:00:00	27	28.44
3353	2026-05-20 19:00:00	9	20
3363	2026-05-20 19:00:00	7	24.3
3375	2026-05-20 19:00:00	8	171.6
3383	2026-05-20 19:00:00	10	20
3394	2026-05-20 19:00:00	6	12
3408	2026-05-20 20:00:00	40	20
3420	2026-05-20 20:00:00	36	20
3432	2026-05-20 20:00:00	38	198
3445	2026-05-20 20:00:00	37	28.38
3450	2026-05-20 20:00:00	39	20
3452	2026-05-20 21:00:00	9	20
3461	2026-05-20 21:00:00	7	24.2
3474	2026-05-20 21:00:00	6	12
3485	2026-05-20 21:00:00	8	171.6
3495	2026-05-20 21:00:00	10	20
3506	2026-05-20 22:00:00	21	20
3520	2026-05-20 22:00:00	22	28.43
3528	2026-05-20 22:00:00	23	198
3537	2026-05-20 22:00:00	25	20
3546	2026-05-20 22:00:00	24	20
3553	2026-05-20 23:00:00	27	28.22
3568	2026-05-20 23:00:00	28	198
3579	2026-05-20 23:00:00	30	20
3589	2026-05-20 23:00:00	26	20
3598	2026-05-20 23:00:00	29	20
3602	2026-05-21 00:00:00	8	171.6
3613	2026-05-21 00:00:00	10	20
3628	2026-05-21 00:00:00	7	24.48
3641	2026-05-21 00:00:00	9	20
3647	2026-05-21 00:00:00	6	12
3653	2026-05-21 02:00:00	15	20
3663	2026-05-21 02:00:00	11	20
3671	2026-05-21 02:00:00	14	20
3682	2026-05-21 02:00:00	13	198
3688	2026-05-21 02:00:00	12	28.26
3709	2026-05-21 03:00:00	42	28.31
3711	2026-05-21 03:00:00	45	20
3721	2026-05-21 03:00:00	43	198
3728	2026-05-21 03:00:00	44	20
3740	2026-05-21 03:00:00	41	20
3759	2026-05-21 04:00:00	27	28.43
3767	2026-05-21 04:00:00	28	198
3777	2026-05-21 04:00:00	30	20
3787	2026-05-21 04:00:00	26	20
3797	2026-05-21 04:00:00	29	20
3804	2026-05-21 05:00:00	8	171.6
3815	2026-05-21 05:00:00	10	20
3828	2026-05-21 05:00:00	7	24.27
3840	2026-05-21 05:00:00	6	12
3848	2026-05-21 05:00:00	9	20
3852	2026-05-21 06:00:00	16	20
3864	2026-05-21 06:00:00	18	198
3870	2026-05-21 06:00:00	17	28.4
3879	2026-05-21 06:00:00	19	20
3889	2026-05-21 06:00:00	20	20
3909	2026-05-21 07:00:00	42	28.3
3914	2026-05-21 07:00:00	45	20
3923	2026-05-21 07:00:00	43	198
3927	2026-05-21 07:00:00	44	20
3936	2026-05-21 07:00:00	41	20
3960	2026-05-21 08:00:00	50	20
3968	2026-05-21 08:00:00	46	20
3973	2026-05-21 08:00:00	47	28.31
3987	2026-05-21 08:00:00	49	20
3994	2026-05-21 08:00:00	48	198
4010	2026-05-21 09:00:00	42	28.47
4019	2026-05-21 09:00:00	45	20
4025	2026-05-21 09:00:00	43	198
4034	2026-05-21 09:00:00	44	20
4044	2026-05-21 09:00:00	41	20
4057	2026-05-21 10:00:00	31	20
4064	2026-05-21 10:00:00	34	20
4077	2026-05-21 10:00:00	32	28.2
4086	2026-05-21 10:00:00	35	20
4097	2026-05-21 10:00:00	33	198
4103	2026-05-21 11:00:00	23	198
4118	2026-05-21 11:00:00	21	20
4128	2026-05-21 11:00:00	22	28.24
4138	2026-05-21 11:00:00	25	20
4147	2026-05-21 11:00:00	24	20
4159	2026-05-21 12:00:00	23	283.8
4170	2026-05-21 12:00:00	21	46
4179	2026-05-21 12:00:00	22	41.38
4181	2026-05-21 12:00:00	35	20
4190	2026-05-21 12:00:00	25	20
903	2026-05-18 18:00:00	15	20
913	2026-05-18 18:00:00	11	20
926	2026-05-18 18:00:00	12	28.3
937	2026-05-18 18:00:00	13	198
947	2026-05-18 18:00:00	14	20
954	2026-05-18 19:00:00	20	20
967	2026-05-18 19:00:00	16	20
980	2026-05-18 19:00:00	17	28.45
989	2026-05-18 19:00:00	18	198
999	2026-05-18 19:00:00	19	20
1003	2026-05-18 20:00:00	8	171.6
1016	2026-05-18 20:00:00	9	20
1026	2026-05-18 20:00:00	10	20
1036	2026-05-18 20:00:00	6	12
1045	2026-05-18 20:00:00	7	24.24
1055	2026-05-18 21:00:00	30	20
1067	2026-05-18 21:00:00	26	20
1073	2026-05-18 21:00:00	27	28.31
1081	2026-05-18 21:00:00	28	198
1090	2026-05-18 21:00:00	29	20
1109	2026-05-18 22:00:00	41	20
1115	2026-05-18 22:00:00	42	28.39
1125	2026-05-18 22:00:00	43	198
1136	2026-05-18 22:00:00	44	20
1146	2026-05-18 22:00:00	45	20
1160	2026-05-18 23:00:00	30	20
1169	2026-05-18 23:00:00	26	20
1180	2026-05-18 23:00:00	27	28.2
1187	2026-05-18 23:00:00	28	198
1194	2026-05-18 23:00:00	29	20
1210	2026-05-19 00:00:00	43	198
1219	2026-05-19 00:00:00	44	20
1226	2026-05-19 00:00:00	45	20
1236	2026-05-19 00:00:00	41	20
1247	2026-05-19 00:00:00	42	28.44
1256	2026-05-19 01:00:00	17	28.36
1266	2026-05-19 01:00:00	18	198
1275	2026-05-19 01:00:00	19	20
1282	2026-05-19 01:00:00	20	20
1292	2026-05-19 01:00:00	16	20
2301	2026-05-19 22:00:00	3	171.6
2313	2026-05-19 22:00:00	4	20
2324	2026-05-19 22:00:00	5	20
2334	2026-05-19 22:00:00	1	12
2343	2026-05-19 22:00:00	2	24.23
2358	2026-05-19 23:00:00	27	28.38
2370	2026-05-19 23:00:00	28	198
2381	2026-05-19 23:00:00	29	20
2393	2026-05-19 23:00:00	30	20
2400	2026-05-19 23:00:00	26	20
2402	2026-05-20 00:00:00	1	12
2416	2026-05-20 00:00:00	2	24.47
2426	2026-05-20 00:00:00	3	171.6
2440	2026-05-20 00:00:00	4	20
2449	2026-05-20 00:00:00	5	20
2456	2026-05-20 01:00:00	12	28.37
2467	2026-05-20 01:00:00	13	198
2479	2026-05-20 01:00:00	14	20
2489	2026-05-20 01:00:00	15	20
2497	2026-05-20 01:00:00	11	20
2503	2026-05-20 02:00:00	19	20
2511	2026-05-20 02:00:00	20	20
2522	2026-05-20 02:00:00	16	20
2531	2026-05-20 02:00:00	17	28.33
2543	2026-05-20 02:00:00	18	198
2560	2026-05-20 03:00:00	44	20
2572	2026-05-20 03:00:00	45	20
2582	2026-05-20 03:00:00	41	20
2591	2026-05-20 03:00:00	42	28.26
2599	2026-05-20 03:00:00	43	198
2604	2026-05-20 04:00:00	16	20
2614	2026-05-20 04:00:00	17	28.27
2626	2026-05-20 04:00:00	18	198
2637	2026-05-20 04:00:00	19	20
2647	2026-05-20 04:00:00	20	20
2654	2026-05-20 05:00:00	11	20
2668	2026-05-20 05:00:00	12	28.21
2678	2026-05-20 05:00:00	13	198
2688	2026-05-20 05:00:00	14	20
2697	2026-05-20 05:00:00	15	20
2710	2026-05-20 06:00:00	40	20
2719	2026-05-20 06:00:00	36	20
2732	2026-05-20 06:00:00	37	28.23
2737	2026-05-20 06:00:00	38	198
2747	2026-05-20 06:00:00	39	20
2754	2026-05-20 07:00:00	19	20
2761	2026-05-20 07:00:00	20	20
2770	2026-05-20 07:00:00	16	20
2774	2026-05-20 07:00:00	17	28.4
2784	2026-05-20 07:00:00	18	198
3257	2026-05-20 17:00:00	29	20
3269	2026-05-20 17:00:00	27	28.39
3273	2026-05-20 17:00:00	28	198
3282	2026-05-20 17:00:00	30	20
3288	2026-05-20 17:00:00	26	20
3310	2026-05-20 18:00:00	42	28.36
3311	2026-05-20 18:00:00	45	20
3322	2026-05-20 18:00:00	43	198
3332	2026-05-20 18:00:00	44	20
3343	2026-05-20 18:00:00	41	20
3356	2026-05-20 19:00:00	35	20
3367	2026-05-20 19:00:00	33	198
3376	2026-05-20 19:00:00	31	20
3385	2026-05-20 19:00:00	34	20
3398	2026-05-20 19:00:00	32	28.34
3403	2026-05-20 20:00:00	11	20
3411	2026-05-20 20:00:00	14	20
3426	2026-05-20 20:00:00	12	28.41
3434	2026-05-20 20:00:00	15	20
3440	2026-05-20 20:00:00	13	198
3459	2026-05-20 21:00:00	40	20
3464	2026-05-20 21:00:00	36	20
3472	2026-05-20 21:00:00	38	198
3483	2026-05-20 21:00:00	37	28.44
3493	2026-05-20 21:00:00	39	20
3509	2026-05-20 22:00:00	46	20
3519	2026-05-20 22:00:00	47	28.19
3532	2026-05-20 22:00:00	49	20
3544	2026-05-20 22:00:00	48	198
3550	2026-05-20 22:00:00	50	20
3551	2026-05-20 23:00:00	2	24.36
3562	2026-05-20 23:00:00	5	20
3574	2026-05-20 23:00:00	1	12
3585	2026-05-20 23:00:00	4	20
3593	2026-05-20 23:00:00	3	171.6
3605	2026-05-21 00:00:00	27	28.36
3619	2026-05-21 00:00:00	28	198
3633	2026-05-21 00:00:00	30	20
3643	2026-05-21 00:00:00	26	20
3649	2026-05-21 00:00:00	29	20
3652	2026-05-21 02:00:00	9	20
3662	2026-05-21 02:00:00	6	12
3676	2026-05-21 02:00:00	8	171.6
3683	2026-05-21 02:00:00	10	20
3694	2026-05-21 02:00:00	7	24.2
3707	2026-05-21 03:00:00	34	20
904	2026-05-18 18:00:00	27	28.47
917	2026-05-18 18:00:00	28	198
927	2026-05-18 18:00:00	29	20
938	2026-05-18 18:00:00	30	20
948	2026-05-18 18:00:00	26	20
953	2026-05-18 19:00:00	13	198
962	2026-05-18 19:00:00	14	20
971	2026-05-18 19:00:00	15	20
977	2026-05-18 19:00:00	11	20
986	2026-05-18 19:00:00	12	28.22
1010	2026-05-18 20:00:00	46	20
1020	2026-05-18 20:00:00	47	28.37
1033	2026-05-18 20:00:00	48	198
1044	2026-05-18 20:00:00	49	20
1050	2026-05-18 20:00:00	50	20
1051	2026-05-18 21:00:00	3	171.6
1061	2026-05-18 21:00:00	4	20
1072	2026-05-18 21:00:00	5	20
1084	2026-05-18 21:00:00	1	12
1095	2026-05-18 21:00:00	2	24.4
1105	2026-05-18 22:00:00	27	28.47
1119	2026-05-18 22:00:00	28	198
1126	2026-05-18 22:00:00	29	20
1133	2026-05-18 22:00:00	30	20
1144	2026-05-18 22:00:00	26	20
1153	2026-05-18 23:00:00	25	20
1168	2026-05-18 23:00:00	21	20
1179	2026-05-18 23:00:00	22	28.28
1189	2026-05-18 23:00:00	23	198
1198	2026-05-18 23:00:00	24	20
1201	2026-05-19 00:00:00	4	20
1212	2026-05-19 00:00:00	5	20
1224	2026-05-19 00:00:00	1	12
1235	2026-05-19 00:00:00	2	24.32
1243	2026-05-19 00:00:00	3	171.6
1259	2026-05-19 01:00:00	43	198
1261	2026-05-19 01:00:00	44	20
1271	2026-05-19 01:00:00	45	20
1285	2026-05-19 01:00:00	41	20
1293	2026-05-19 01:00:00	42	28.4
2302	2026-05-19 22:00:00	9	20
2318	2026-05-19 22:00:00	10	20
2328	2026-05-19 22:00:00	6	12
2338	2026-05-19 22:00:00	7	24.37
2350	2026-05-19 22:00:00	8	171.6
2352	2026-05-19 23:00:00	9	20
2368	2026-05-19 23:00:00	10	20
2377	2026-05-19 23:00:00	6	12
2388	2026-05-19 23:00:00	7	24.19
2397	2026-05-19 23:00:00	8	171.6
2406	2026-05-20 00:00:00	25	20
2419	2026-05-20 00:00:00	21	20
2432	2026-05-20 00:00:00	22	28.23
2443	2026-05-20 00:00:00	23	198
2450	2026-05-20 00:00:00	24	20
2451	2026-05-20 01:00:00	3	171.6
2462	2026-05-20 01:00:00	4	20
2472	2026-05-20 01:00:00	5	20
2482	2026-05-20 01:00:00	1	12
2493	2026-05-20 01:00:00	2	24.26
2502	2026-05-20 02:00:00	9	20
2513	2026-05-20 02:00:00	10	20
2523	2026-05-20 02:00:00	6	12
2533	2026-05-20 02:00:00	7	24.32
2544	2026-05-20 02:00:00	8	171.6
2556	2026-05-20 03:00:00	32	28.2
2564	2026-05-20 03:00:00	33	198
2573	2026-05-20 03:00:00	34	20
2581	2026-05-20 03:00:00	35	20
2590	2026-05-20 03:00:00	31	20
2608	2026-05-20 04:00:00	45	20
2620	2026-05-20 04:00:00	41	20
2630	2026-05-20 04:00:00	42	28.3
2640	2026-05-20 04:00:00	43	198
2650	2026-05-20 04:00:00	44	20
2652	2026-05-20 05:00:00	6	12
2662	2026-05-20 05:00:00	7	24.2
2677	2026-05-20 05:00:00	8	171.6
2687	2026-05-20 05:00:00	9	20
2698	2026-05-20 05:00:00	10	20
2703	2026-05-20 06:00:00	11	20
2711	2026-05-20 06:00:00	12	28.32
2721	2026-05-20 06:00:00	13	198
2725	2026-05-20 06:00:00	14	20
2738	2026-05-20 06:00:00	15	20
2757	2026-05-20 07:00:00	31	20
2769	2026-05-20 07:00:00	32	28.44
2781	2026-05-20 07:00:00	33	198
2792	2026-05-20 07:00:00	34	20
2799	2026-05-20 07:00:00	35	20
3258	2026-05-20 17:00:00	31	20
3267	2026-05-20 17:00:00	34	20
3280	2026-05-20 17:00:00	32	28.22
3290	2026-05-20 17:00:00	35	20
3296	2026-05-20 17:00:00	33	198
3306	2026-05-20 18:00:00	20	20
3314	2026-05-20 18:00:00	16	20
3325	2026-05-20 18:00:00	17	28.31
3335	2026-05-20 18:00:00	18	198
3349	2026-05-20 18:00:00	19	20
3351	2026-05-20 19:00:00	4	20
3361	2026-05-20 19:00:00	5	20
3373	2026-05-20 19:00:00	1	12
3384	2026-05-20 19:00:00	2	24.46
3393	2026-05-20 19:00:00	3	171.6
3407	2026-05-20 20:00:00	32	28.35
3419	2026-05-20 20:00:00	35	20
3431	2026-05-20 20:00:00	33	198
3442	2026-05-20 20:00:00	31	20
3448	2026-05-20 20:00:00	34	20
3453	2026-05-20 21:00:00	11	20
3467	2026-05-20 21:00:00	14	20
3475	2026-05-20 21:00:00	13	198
3487	2026-05-20 21:00:00	12	28.42
3497	2026-05-20 21:00:00	15	20
3504	2026-05-20 22:00:00	17	28.38
3516	2026-05-20 22:00:00	18	198
3526	2026-05-20 22:00:00	19	20
3533	2026-05-20 22:00:00	20	20
3541	2026-05-20 22:00:00	16	20
3558	2026-05-20 23:00:00	38	198
3566	2026-05-20 23:00:00	37	28.21
3576	2026-05-20 23:00:00	39	20
3599	2026-05-20 23:00:00	40	20
3600	2026-05-20 23:00:00	36	20
3601	2026-05-21 00:00:00	3	171.6
3612	2026-05-21 00:00:00	2	24.23
3626	2026-05-21 00:00:00	5	20
3639	2026-05-21 00:00:00	1	12
3646	2026-05-21 00:00:00	4	20
3655	2026-05-21 02:00:00	21	20
3670	2026-05-21 02:00:00	22	28.29
3677	2026-05-21 02:00:00	23	198
3690	2026-05-21 02:00:00	25	20
3700	2026-05-21 02:00:00	24	20
3703	2026-05-21 03:00:00	15	20
905	2026-05-18 18:00:00	17	28.41
918	2026-05-18 18:00:00	18	198
925	2026-05-18 18:00:00	19	20
936	2026-05-18 18:00:00	20	20
945	2026-05-18 18:00:00	16	20
957	2026-05-18 19:00:00	22	28.38
965	2026-05-18 19:00:00	23	198
975	2026-05-18 19:00:00	24	20
985	2026-05-18 19:00:00	25	20
995	2026-05-18 19:00:00	21	20
1005	2026-05-18 20:00:00	30	20
1015	2026-05-18 20:00:00	26	20
1027	2026-05-18 20:00:00	27	28.3
1034	2026-05-18 20:00:00	28	198
1043	2026-05-18 20:00:00	29	20
1058	2026-05-18 21:00:00	32	28.25
1068	2026-05-18 21:00:00	33	198
1078	2026-05-18 21:00:00	34	20
1085	2026-05-18 21:00:00	35	20
1094	2026-05-18 21:00:00	31	20
1104	2026-05-18 22:00:00	33	198
1117	2026-05-18 22:00:00	34	20
1128	2026-05-18 22:00:00	35	20
1139	2026-05-18 22:00:00	31	20
1150	2026-05-18 22:00:00	32	28.43
1154	2026-05-18 23:00:00	12	28.44
1164	2026-05-18 23:00:00	13	198
1174	2026-05-18 23:00:00	14	20
1184	2026-05-18 23:00:00	15	20
1193	2026-05-18 23:00:00	11	20
1205	2026-05-19 00:00:00	24	20
1213	2026-05-19 00:00:00	25	20
1228	2026-05-19 00:00:00	21	20
1239	2026-05-19 00:00:00	22	28.32
1248	2026-05-19 00:00:00	23	198
1257	2026-05-19 01:00:00	35	20
1268	2026-05-19 01:00:00	31	20
1279	2026-05-19 01:00:00	32	28.26
1288	2026-05-19 01:00:00	33	198
1299	2026-05-19 01:00:00	34	20
2303	2026-05-19 22:00:00	15	20
2316	2026-05-19 22:00:00	11	20
2326	2026-05-19 22:00:00	12	28.29
2337	2026-05-19 22:00:00	13	198
2347	2026-05-19 22:00:00	14	20
2354	2026-05-19 23:00:00	23	198
2365	2026-05-19 23:00:00	24	20
2378	2026-05-19 23:00:00	25	20
2386	2026-05-19 23:00:00	21	20
2394	2026-05-19 23:00:00	22	28.3
2408	2026-05-20 00:00:00	28	198
2417	2026-05-20 00:00:00	29	20
2429	2026-05-20 00:00:00	30	20
2435	2026-05-20 00:00:00	26	20
2442	2026-05-20 00:00:00	27	28.25
2459	2026-05-20 01:00:00	45	20
2466	2026-05-20 01:00:00	41	20
2477	2026-05-20 01:00:00	42	28.4
2490	2026-05-20 01:00:00	43	198
2500	2026-05-20 01:00:00	44	20
2506	2026-05-20 02:00:00	21	20
2518	2026-05-20 02:00:00	22	28.35
2525	2026-05-20 02:00:00	23	198
2535	2026-05-20 02:00:00	24	20
2549	2026-05-20 02:00:00	25	20
2551	2026-05-20 03:00:00	2	24.48
2561	2026-05-20 03:00:00	3	171.6
2575	2026-05-20 03:00:00	4	20
2585	2026-05-20 03:00:00	5	20
2593	2026-05-20 03:00:00	1	12
2605	2026-05-20 04:00:00	34	20
2613	2026-05-20 04:00:00	35	20
2623	2026-05-20 04:00:00	31	20
2634	2026-05-20 04:00:00	32	28.19
2644	2026-05-20 04:00:00	33	198
2660	2026-05-20 05:00:00	42	28.46
2663	2026-05-20 05:00:00	43	198
2673	2026-05-20 05:00:00	44	20
2685	2026-05-20 05:00:00	45	20
2694	2026-05-20 05:00:00	41	20
2708	2026-05-20 06:00:00	41	20
2720	2026-05-20 06:00:00	42	28.36
2734	2026-05-20 06:00:00	43	198
2745	2026-05-20 06:00:00	44	20
2750	2026-05-20 06:00:00	45	20
2751	2026-05-20 07:00:00	5	20
2762	2026-05-20 07:00:00	1	12
2771	2026-05-20 07:00:00	2	24.23
2775	2026-05-20 07:00:00	3	171.6
2785	2026-05-20 07:00:00	4	20
3259	2026-05-20 17:00:00	38	198
3265	2026-05-20 17:00:00	37	28.45
3279	2026-05-20 17:00:00	39	20
3292	2026-05-20 17:00:00	40	20
3298	2026-05-20 17:00:00	36	20
3304	2026-05-20 18:00:00	25	20
3318	2026-05-20 18:00:00	23	198
3326	2026-05-20 18:00:00	24	20
3338	2026-05-20 18:00:00	21	20
3345	2026-05-20 18:00:00	22	28.34
3358	2026-05-20 19:00:00	44	20
3369	2026-05-20 19:00:00	41	20
3379	2026-05-20 19:00:00	42	28.42
3389	2026-05-20 19:00:00	45	20
3392	2026-05-20 19:00:00	43	198
3410	2026-05-20 20:00:00	44	20
3413	2026-05-20 20:00:00	41	20
3422	2026-05-20 20:00:00	42	28.26
3430	2026-05-20 20:00:00	45	20
3437	2026-05-20 20:00:00	43	198
3458	2026-05-20 21:00:00	44	20
3469	2026-05-20 21:00:00	41	20
3478	2026-05-20 21:00:00	42	28.36
3484	2026-05-20 21:00:00	45	20
3494	2026-05-20 21:00:00	43	198
3508	2026-05-20 22:00:00	35	20
3517	2026-05-20 22:00:00	33	198
3529	2026-05-20 22:00:00	31	20
3536	2026-05-20 22:00:00	34	20
3545	2026-05-20 22:00:00	32	28.34
3556	2026-05-20 23:00:00	21	20
3561	2026-05-20 23:00:00	22	28.21
3571	2026-05-20 23:00:00	23	198
3577	2026-05-20 23:00:00	25	20
3584	2026-05-20 23:00:00	24	20
3618	2026-05-21 00:00:00	46	20
3629	2026-05-21 00:00:00	47	28.35
3642	2026-05-21 00:00:00	49	20
3648	2026-05-21 00:00:00	48	198
3650	2026-05-21 00:00:00	50	20
3651	2026-05-21 02:00:00	5	20
3661	2026-05-21 02:00:00	1	12
3675	2026-05-21 02:00:00	3	171.6
3684	2026-05-21 02:00:00	4	20
3695	2026-05-21 02:00:00	2	24.21
3706	2026-05-21 03:00:00	27	28.25
906	2026-05-18 18:00:00	24	20
915	2026-05-18 18:00:00	25	20
928	2026-05-18 18:00:00	21	20
939	2026-05-18 18:00:00	22	28.31
949	2026-05-18 18:00:00	23	198
952	2026-05-18 19:00:00	9	20
966	2026-05-18 19:00:00	10	20
981	2026-05-18 19:00:00	6	12
994	2026-05-18 19:00:00	7	24.31
1000	2026-05-18 19:00:00	8	171.6
1001	2026-05-18 20:00:00	2	24.43
1011	2026-05-18 20:00:00	3	171.6
1023	2026-05-18 20:00:00	4	20
1032	2026-05-18 20:00:00	5	20
1042	2026-05-18 20:00:00	1	12
1059	2026-05-18 21:00:00	39	20
1064	2026-05-18 21:00:00	40	20
1074	2026-05-18 21:00:00	36	20
1083	2026-05-18 21:00:00	37	28.32
1091	2026-05-18 21:00:00	38	198
1106	2026-05-18 22:00:00	36	20
1116	2026-05-18 22:00:00	37	28.33
1129	2026-05-18 22:00:00	38	198
1135	2026-05-18 22:00:00	39	20
1145	2026-05-18 22:00:00	40	20
1156	2026-05-18 23:00:00	31	20
1170	2026-05-18 23:00:00	32	28.29
1181	2026-05-18 23:00:00	33	198
1191	2026-05-18 23:00:00	34	20
1200	2026-05-18 23:00:00	35	20
1202	2026-05-19 00:00:00	7	24.4
1211	2026-05-19 00:00:00	8	171.6
1221	2026-05-19 00:00:00	9	20
1231	2026-05-19 00:00:00	10	20
1242	2026-05-19 00:00:00	6	12
1254	2026-05-19 01:00:00	36	20
1265	2026-05-19 01:00:00	37	28.49
1277	2026-05-19 01:00:00	38	198
1286	2026-05-19 01:00:00	39	20
1297	2026-05-19 01:00:00	40	20
2305	2026-05-19 22:00:00	20	20
2317	2026-05-19 22:00:00	16	20
2329	2026-05-19 22:00:00	17	28.42
2340	2026-05-19 22:00:00	18	198
2346	2026-05-19 22:00:00	19	20
2356	2026-05-19 23:00:00	11	20
2363	2026-05-19 23:00:00	12	28.37
2373	2026-05-19 23:00:00	13	198
2384	2026-05-19 23:00:00	14	20
2395	2026-05-19 23:00:00	15	20
2403	2026-05-20 00:00:00	35	20
2413	2026-05-20 00:00:00	31	20
2423	2026-05-20 00:00:00	32	28.29
2436	2026-05-20 00:00:00	33	198
2446	2026-05-20 00:00:00	34	20
2455	2026-05-20 01:00:00	22	28.47
2463	2026-05-20 01:00:00	23	198
2473	2026-05-20 01:00:00	24	20
2485	2026-05-20 01:00:00	25	20
2499	2026-05-20 01:00:00	21	20
2501	2026-05-20 02:00:00	2	24.44
2512	2026-05-20 02:00:00	3	171.6
2521	2026-05-20 02:00:00	4	20
2532	2026-05-20 02:00:00	5	20
2542	2026-05-20 02:00:00	1	12
2558	2026-05-20 03:00:00	40	20
2568	2026-05-20 03:00:00	36	20
2579	2026-05-20 03:00:00	37	28.35
2588	2026-05-20 03:00:00	38	198
2598	2026-05-20 03:00:00	39	20
2603	2026-05-20 04:00:00	12	28.37
2612	2026-05-20 04:00:00	13	198
2621	2026-05-20 04:00:00	14	20
2631	2026-05-20 04:00:00	15	20
2641	2026-05-20 04:00:00	11	20
2658	2026-05-20 05:00:00	48	198
2667	2026-05-20 05:00:00	49	20
2672	2026-05-20 05:00:00	50	20
2681	2026-05-20 05:00:00	46	20
2692	2026-05-20 05:00:00	47	28.4
2709	2026-05-20 06:00:00	49	20
2712	2026-05-20 06:00:00	50	20
2722	2026-05-20 06:00:00	46	20
2726	2026-05-20 06:00:00	47	28.19
2736	2026-05-20 06:00:00	48	198
2759	2026-05-20 07:00:00	49	20
2773	2026-05-20 07:00:00	50	20
2780	2026-05-20 07:00:00	46	20
2788	2026-05-20 07:00:00	47	28.48
2795	2026-05-20 07:00:00	48	198
3260	2026-05-20 17:00:00	49	20
3270	2026-05-20 17:00:00	48	198
3283	2026-05-20 17:00:00	50	20
3293	2026-05-20 17:00:00	46	20
3300	2026-05-20 17:00:00	47	28.22
3301	2026-05-20 18:00:00	1	12
3315	2026-05-20 18:00:00	2	24.29
3324	2026-05-20 18:00:00	3	171.6
3333	2026-05-20 18:00:00	4	20
3342	2026-05-20 18:00:00	5	20
3360	2026-05-20 19:00:00	36	20
3368	2026-05-20 19:00:00	38	198
3377	2026-05-20 19:00:00	37	28.42
3387	2026-05-20 19:00:00	39	20
3396	2026-05-20 19:00:00	40	20
3404	2026-05-20 20:00:00	18	198
3412	2026-05-20 20:00:00	19	20
3421	2026-05-20 20:00:00	20	20
3427	2026-05-20 20:00:00	16	20
3433	2026-05-20 20:00:00	17	28.36
3460	2026-05-20 21:00:00	50	20
3470	2026-05-20 21:00:00	46	20
3480	2026-05-20 21:00:00	47	28.39
3490	2026-05-20 21:00:00	49	20
3498	2026-05-20 21:00:00	48	198
3502	2026-05-20 22:00:00	14	20
3511	2026-05-20 22:00:00	13	198
3521	2026-05-20 22:00:00	12	28.36
3523	2026-05-20 22:00:00	15	20
3539	2026-05-20 22:00:00	11	20
3557	2026-05-20 23:00:00	34	20
3570	2026-05-20 23:00:00	32	28.39
3581	2026-05-20 23:00:00	35	20
3590	2026-05-20 23:00:00	33	198
3596	2026-05-20 23:00:00	31	20
3606	2026-05-21 00:00:00	21	20
3617	2026-05-21 00:00:00	22	28.37
3623	2026-05-21 00:00:00	23	198
3632	2026-05-21 00:00:00	25	20
3640	2026-05-21 00:00:00	24	20
3656	2026-05-21 02:00:00	34	20
3668	2026-05-21 02:00:00	32	28.38
3680	2026-05-21 02:00:00	35	20
3689	2026-05-21 02:00:00	33	198
3696	2026-05-21 02:00:00	31	20
3702	2026-05-21 03:00:00	19	20
907	2026-05-18 18:00:00	33	198
908	2026-05-18 18:00:00	41	20
909	2026-05-18 18:00:00	39	20
910	2026-05-18 18:00:00	47	28.43
914	2026-05-18 18:00:00	40	20
916	2026-05-18 18:00:00	48	198
919	2026-05-18 18:00:00	34	20
920	2026-05-18 18:00:00	42	28.41
922	2026-05-18 18:00:00	35	20
924	2026-05-18 18:00:00	49	20
929	2026-05-18 18:00:00	31	20
931	2026-05-18 18:00:00	43	198
932	2026-05-18 18:00:00	36	20
933	2026-05-18 18:00:00	50	20
935	2026-05-18 18:00:00	32	28.3
940	2026-05-18 18:00:00	44	20
942	2026-05-18 18:00:00	37	28.42
944	2026-05-18 18:00:00	46	20
946	2026-05-18 18:00:00	45	20
950	2026-05-18 18:00:00	38	198
951	2026-05-18 19:00:00	3	171.6
956	2026-05-18 19:00:00	30	20
958	2026-05-18 19:00:00	46	20
960	2026-05-18 19:00:00	44	20
961	2026-05-18 19:00:00	4	20
963	2026-05-18 19:00:00	26	20
968	2026-05-18 19:00:00	47	28.48
969	2026-05-18 19:00:00	45	20
972	2026-05-18 19:00:00	27	28.49
973	2026-05-18 19:00:00	48	198
976	2026-05-18 19:00:00	5	20
978	2026-05-18 19:00:00	28	198
979	2026-05-18 19:00:00	41	20
982	2026-05-18 19:00:00	49	20
987	2026-05-18 19:00:00	29	20
988	2026-05-18 19:00:00	42	28.25
990	2026-05-18 19:00:00	1	12
992	2026-05-18 19:00:00	50	20
996	2026-05-18 19:00:00	43	198
998	2026-05-18 19:00:00	2	24.32
1004	2026-05-18 20:00:00	22	28.3
1007	2026-05-18 20:00:00	19	20
1008	2026-05-18 20:00:00	32	28.43
1009	2026-05-18 20:00:00	44	20
1012	2026-05-18 20:00:00	23	198
1014	2026-05-18 20:00:00	20	20
1018	2026-05-18 20:00:00	33	198
1019	2026-05-18 20:00:00	45	20
1021	2026-05-18 20:00:00	24	20
1024	2026-05-18 20:00:00	16	20
1025	2026-05-18 20:00:00	34	20
1029	2026-05-18 20:00:00	25	20
1031	2026-05-18 20:00:00	41	20
1035	2026-05-18 20:00:00	17	28.36
1038	2026-05-18 20:00:00	21	20
1039	2026-05-18 20:00:00	35	20
1041	2026-05-18 20:00:00	42	28.29
1046	2026-05-18 20:00:00	18	198
1047	2026-05-18 20:00:00	31	20
1049	2026-05-18 20:00:00	43	198
1052	2026-05-18 21:00:00	8	171.6
1053	2026-05-18 21:00:00	13	198
1054	2026-05-18 21:00:00	22	28.25
1056	2026-05-18 21:00:00	46	20
1062	2026-05-18 21:00:00	9	20
1063	2026-05-18 21:00:00	23	198
1065	2026-05-18 21:00:00	47	28.4
1069	2026-05-18 21:00:00	14	20
1071	2026-05-18 21:00:00	24	20
1075	2026-05-18 21:00:00	10	20
1076	2026-05-18 21:00:00	25	20
1077	2026-05-18 21:00:00	15	20
1079	2026-05-18 21:00:00	48	198
1086	2026-05-18 21:00:00	21	20
1087	2026-05-18 21:00:00	6	12
1088	2026-05-18 21:00:00	11	20
1089	2026-05-18 21:00:00	49	20
1096	2026-05-18 21:00:00	12	28.3
1097	2026-05-18 21:00:00	7	24.33
1098	2026-05-18 21:00:00	50	20
1101	2026-05-18 22:00:00	10	20
1108	2026-05-18 22:00:00	22	28.4
1107	2026-05-18 22:00:00	20	20
1110	2026-05-18 22:00:00	48	198
1112	2026-05-18 22:00:00	6	12
1114	2026-05-18 22:00:00	23	198
1118	2026-05-18 22:00:00	16	20
1120	2026-05-18 22:00:00	49	20
1122	2026-05-18 22:00:00	7	24.27
1124	2026-05-18 22:00:00	24	20
1127	2026-05-18 22:00:00	50	20
1130	2026-05-18 22:00:00	17	28.38
1132	2026-05-18 22:00:00	8	171.6
1137	2026-05-18 22:00:00	25	20
1138	2026-05-18 22:00:00	46	20
1140	2026-05-18 22:00:00	18	198
1142	2026-05-18 22:00:00	9	20
1147	2026-05-18 22:00:00	21	20
1148	2026-05-18 22:00:00	19	20
1149	2026-05-18 22:00:00	47	28.34
1151	2026-05-18 23:00:00	4	20
1152	2026-05-18 23:00:00	8	171.6
1158	2026-05-18 23:00:00	44	20
1159	2026-05-18 23:00:00	18	198
1161	2026-05-18 23:00:00	5	20
1165	2026-05-18 23:00:00	9	20
1166	2026-05-18 23:00:00	45	20
1167	2026-05-18 23:00:00	19	20
1171	2026-05-18 23:00:00	1	12
1173	2026-05-18 23:00:00	10	20
1176	2026-05-18 23:00:00	20	20
1177	2026-05-18 23:00:00	41	20
1178	2026-05-18 23:00:00	2	24.43
1185	2026-05-18 23:00:00	16	20
1186	2026-05-18 23:00:00	6	12
1188	2026-05-18 23:00:00	3	171.6
1190	2026-05-18 23:00:00	42	28.32
1196	2026-05-18 23:00:00	7	24.2
1197	2026-05-18 23:00:00	17	28.25
1199	2026-05-18 23:00:00	43	198
1203	2026-05-19 00:00:00	12	28.32
1204	2026-05-19 00:00:00	17	28.2
1207	2026-05-19 00:00:00	30	20
1209	2026-05-19 00:00:00	46	20
1215	2026-05-19 00:00:00	13	198
1216	2026-05-19 00:00:00	26	20
1217	2026-05-19 00:00:00	47	28.45
1218	2026-05-19 00:00:00	18	198
1222	2026-05-19 00:00:00	48	198
1223	2026-05-19 00:00:00	14	20
1225	2026-05-19 00:00:00	19	20
1229	2026-05-19 00:00:00	27	28.49
1232	2026-05-19 00:00:00	15	20
1233	2026-05-19 00:00:00	49	20
1234	2026-05-19 00:00:00	20	20
1238	2026-05-19 00:00:00	28	198
1240	2026-05-19 00:00:00	11	20
1260	2026-05-19 01:00:00	46	20
1267	2026-05-19 01:00:00	47	28.26
1276	2026-05-19 01:00:00	48	198
1287	2026-05-19 01:00:00	49	20
1294	2026-05-19 01:00:00	50	20
2306	2026-05-19 22:00:00	26	20
2312	2026-05-19 22:00:00	27	28.23
2322	2026-05-19 22:00:00	28	198
2333	2026-05-19 22:00:00	29	20
2345	2026-05-19 22:00:00	30	20
2355	2026-05-19 23:00:00	34	20
2369	2026-05-19 23:00:00	35	20
2379	2026-05-19 23:00:00	31	20
2391	2026-05-19 23:00:00	32	28.33
2399	2026-05-19 23:00:00	33	198
2401	2026-05-20 00:00:00	6	12
2415	2026-05-20 00:00:00	7	24.36
2425	2026-05-20 00:00:00	8	171.6
2439	2026-05-20 00:00:00	9	20
2448	2026-05-20 00:00:00	10	20
2452	2026-05-20 01:00:00	9	20
2461	2026-05-20 01:00:00	10	20
2471	2026-05-20 01:00:00	6	12
2481	2026-05-20 01:00:00	7	24.47
2491	2026-05-20 01:00:00	8	171.6
2510	2026-05-20 02:00:00	49	20
2519	2026-05-20 02:00:00	50	20
2530	2026-05-20 02:00:00	46	20
2539	2026-05-20 02:00:00	47	28.3
2545	2026-05-20 02:00:00	48	198
2555	2026-05-20 03:00:00	21	20
2567	2026-05-20 03:00:00	22	28.25
2578	2026-05-20 03:00:00	23	198
2592	2026-05-20 03:00:00	24	20
2600	2026-05-20 03:00:00	25	20
2601	2026-05-20 04:00:00	4	20
2619	2026-05-20 04:00:00	5	20
2628	2026-05-20 04:00:00	1	12
2638	2026-05-20 04:00:00	2	24.39
2648	2026-05-20 04:00:00	3	171.6
2655	2026-05-20 05:00:00	19	20
2664	2026-05-20 05:00:00	20	20
2675	2026-05-20 05:00:00	16	20
2683	2026-05-20 05:00:00	17	28.41
2696	2026-05-20 05:00:00	18	198
2704	2026-05-20 06:00:00	19	20
2714	2026-05-20 06:00:00	20	20
2724	2026-05-20 06:00:00	16	20
2733	2026-05-20 06:00:00	17	28.38
2741	2026-05-20 06:00:00	18	198
2760	2026-05-20 07:00:00	40	20
2765	2026-05-20 07:00:00	36	20
2776	2026-05-20 07:00:00	37	28.47
2791	2026-05-20 07:00:00	38	198
2798	2026-05-20 07:00:00	39	20
3712	2026-05-21 03:00:00	20	20
3722	2026-05-21 03:00:00	16	20
3729	2026-05-21 03:00:00	18	198
3743	2026-05-21 03:00:00	17	28.34
3760	2026-05-21 04:00:00	42	28.39
3765	2026-05-21 04:00:00	45	20
3774	2026-05-21 04:00:00	43	198
3782	2026-05-21 04:00:00	44	20
3791	2026-05-21 04:00:00	41	20
3805	2026-05-21 05:00:00	38	198
3820	2026-05-21 05:00:00	37	28.33
3831	2026-05-21 05:00:00	39	20
3842	2026-05-21 05:00:00	40	20
3849	2026-05-21 05:00:00	36	20
3851	2026-05-21 06:00:00	4	20
3860	2026-05-21 06:00:00	2	24.3
3873	2026-05-21 06:00:00	5	20
3883	2026-05-21 06:00:00	1	12
3893	2026-05-21 06:00:00	3	171.6
3908	2026-05-21 07:00:00	38	198
3915	2026-05-21 07:00:00	37	28.36
3924	2026-05-21 07:00:00	39	20
3934	2026-05-21 07:00:00	40	20
3944	2026-05-21 07:00:00	36	20
3958	2026-05-21 08:00:00	30	20
3970	2026-05-21 08:00:00	26	20
3979	2026-05-21 08:00:00	29	20
3988	2026-05-21 08:00:00	28	198
3998	2026-05-21 08:00:00	27	28.42
4004	2026-05-21 09:00:00	15	20
4018	2026-05-21 09:00:00	11	20
4027	2026-05-21 09:00:00	14	20
4040	2026-05-21 09:00:00	13	198
4048	2026-05-21 09:00:00	12	28.38
4052	2026-05-21 10:00:00	4	20
4062	2026-05-21 10:00:00	1	12
4075	2026-05-21 10:00:00	3	171.6
4088	2026-05-21 10:00:00	2	24.47
4096	2026-05-21 10:00:00	5	20
4105	2026-05-21 11:00:00	18	198
4120	2026-05-21 11:00:00	17	28.35
4131	2026-05-21 11:00:00	16	20
4140	2026-05-21 11:00:00	19	20
4146	2026-05-21 11:00:00	20	20
4154	2026-05-21 12:00:00	14	20
4167	2026-05-21 12:00:00	11	46
4178	2026-05-21 12:00:00	13	283.8
4188	2026-05-21 12:00:00	15	20
4196	2026-05-21 12:00:00	12	41.26
4198	2026-05-21 12:00:00	24	20
4203	2026-05-21 13:00:00	11	20
4208	2026-05-21 13:00:00	26	20
4216	2026-05-21 13:00:00	29	20
4218	2026-05-21 13:00:00	13	198
4221	2026-05-21 13:00:00	37	28.36
4225	2026-05-21 13:00:00	28	198
4228	2026-05-21 13:00:00	15	20
4231	2026-05-21 13:00:00	39	20
4234	2026-05-21 13:00:00	30	20
4235	2026-05-21 13:00:00	12	28.32
4241	2026-05-21 13:00:00	40	20
4242	2026-05-21 13:00:00	27	28.44
4244	2026-05-21 13:00:00	14	20
4254	2026-05-21 14:00:00	20	20
4258	2026-05-21 14:00:00	28	198
4267	2026-05-21 14:00:00	30	20
4270	2026-05-21 14:00:00	18	198
4277	2026-05-21 14:00:00	27	28.4
4283	2026-05-21 14:00:00	17	28.38
4287	2026-05-21 14:00:00	26	20
4291	2026-05-21 14:00:00	16	20
4295	2026-05-21 14:00:00	29	20
4296	2026-05-21 14:00:00	19	20
4302	2026-05-21 15:00:00	30	20
4308	2026-05-21 15:00:00	24	20
4314	2026-05-21 15:00:00	27	28.32
4318	2026-05-21 15:00:00	23	198
4323	2026-05-21 15:00:00	26	20
4328	2026-05-21 15:00:00	21	20
4334	2026-05-21 15:00:00	29	20
1244	2026-05-19 00:00:00	50	20
1255	2026-05-19 01:00:00	24	20
1269	2026-05-19 01:00:00	25	20
1278	2026-05-19 01:00:00	21	20
1290	2026-05-19 01:00:00	22	28.28
1298	2026-05-19 01:00:00	23	198
2304	2026-05-19 22:00:00	22	28.44
2314	2026-05-19 22:00:00	23	198
2323	2026-05-19 22:00:00	24	20
2335	2026-05-19 22:00:00	25	20
2344	2026-05-19 22:00:00	21	20
2360	2026-05-19 23:00:00	46	20
2362	2026-05-19 23:00:00	47	28.22
2371	2026-05-19 23:00:00	48	198
2380	2026-05-19 23:00:00	49	20
2392	2026-05-19 23:00:00	50	20
2407	2026-05-20 00:00:00	37	28.42
2420	2026-05-20 00:00:00	38	198
2428	2026-05-20 00:00:00	39	20
2434	2026-05-20 00:00:00	40	20
2444	2026-05-20 00:00:00	36	20
2457	2026-05-20 01:00:00	33	198
2469	2026-05-20 01:00:00	34	20
2480	2026-05-20 01:00:00	35	20
2488	2026-05-20 01:00:00	31	20
2498	2026-05-20 01:00:00	32	28.44
2504	2026-05-20 02:00:00	11	20
2514	2026-05-20 02:00:00	12	28.46
2524	2026-05-20 02:00:00	13	198
2537	2026-05-20 02:00:00	14	20
2547	2026-05-20 02:00:00	15	20
2557	2026-05-20 03:00:00	26	20
2562	2026-05-20 03:00:00	27	28.48
2570	2026-05-20 03:00:00	28	198
2576	2026-05-20 03:00:00	29	20
2584	2026-05-20 03:00:00	30	20
2610	2026-05-20 04:00:00	50	20
2615	2026-05-20 04:00:00	46	20
2624	2026-05-20 04:00:00	47	28.31
2633	2026-05-20 04:00:00	48	198
2642	2026-05-20 04:00:00	49	20
2659	2026-05-20 05:00:00	40	20
2666	2026-05-20 05:00:00	36	20
2674	2026-05-20 05:00:00	37	28.23
2686	2026-05-20 05:00:00	38	198
2693	2026-05-20 05:00:00	39	20
2707	2026-05-20 06:00:00	31	20
2715	2026-05-20 06:00:00	32	28.34
2727	2026-05-20 06:00:00	33	198
2735	2026-05-20 06:00:00	34	20
2740	2026-05-20 06:00:00	35	20
2758	2026-05-20 07:00:00	41	20
2764	2026-05-20 07:00:00	42	28.46
2777	2026-05-20 07:00:00	43	198
2787	2026-05-20 07:00:00	44	20
2794	2026-05-20 07:00:00	45	20
3715	2026-05-21 03:00:00	28	198
3725	2026-05-21 03:00:00	30	20
3735	2026-05-21 03:00:00	26	20
3745	2026-05-21 03:00:00	29	20
3793	2026-05-21 04:00:00	13	198
3798	2026-05-21 04:00:00	12	28.3
3803	2026-05-21 05:00:00	18	198
3813	2026-05-21 05:00:00	17	28.27
3826	2026-05-21 05:00:00	19	20
3837	2026-05-21 05:00:00	20	20
3845	2026-05-21 05:00:00	16	20
3855	2026-05-21 06:00:00	21	20
3865	2026-05-21 06:00:00	22	28.34
3876	2026-05-21 06:00:00	23	198
3886	2026-05-21 06:00:00	25	20
3898	2026-05-21 06:00:00	24	20
3903	2026-05-21 07:00:00	18	198
3920	2026-05-21 07:00:00	17	28.37
3931	2026-05-21 07:00:00	19	20
3943	2026-05-21 07:00:00	20	20
3949	2026-05-21 07:00:00	16	20
3952	2026-05-21 08:00:00	7	24.19
3962	2026-05-21 08:00:00	6	12
3971	2026-05-21 08:00:00	8	171.6
3981	2026-05-21 08:00:00	10	20
3991	2026-05-21 08:00:00	9	20
4008	2026-05-21 09:00:00	50	20
4014	2026-05-21 09:00:00	46	20
4026	2026-05-21 09:00:00	47	28.47
4036	2026-05-21 09:00:00	49	20
4045	2026-05-21 09:00:00	48	198
4055	2026-05-21 10:00:00	21	20
4065	2026-05-21 10:00:00	25	20
4079	2026-05-21 10:00:00	24	20
4090	2026-05-21 10:00:00	23	198
4100	2026-05-21 10:00:00	22	28.41
4101	2026-05-21 11:00:00	4	20
4111	2026-05-21 11:00:00	5	20
4124	2026-05-21 11:00:00	1	12
4137	2026-05-21 11:00:00	3	171.6
4148	2026-05-21 11:00:00	2	24.31
4153	2026-05-21 12:00:00	18	283.8
4166	2026-05-21 12:00:00	17	41.35
4180	2026-05-21 12:00:00	16	46
4189	2026-05-21 12:00:00	19	20
4195	2026-05-21 12:00:00	20	20
4199	2026-05-21 12:00:00	48	283.8
4202	2026-05-21 13:00:00	7	24.23
4205	2026-05-21 13:00:00	21	20
4213	2026-05-21 13:00:00	8	171.6
4214	2026-05-21 13:00:00	22	28.4
4223	2026-05-21 13:00:00	25	20
4226	2026-05-21 13:00:00	10	20
4230	2026-05-21 13:00:00	43	198
4236	2026-05-21 13:00:00	24	20
4238	2026-05-21 13:00:00	9	20
4240	2026-05-21 13:00:00	44	20
4245	2026-05-21 13:00:00	23	198
4247	2026-05-21 13:00:00	6	12
4248	2026-05-21 13:00:00	41	20
4255	2026-05-21 14:00:00	15	20
4259	2026-05-21 14:00:00	10	20
4261	2026-05-21 14:00:00	9	20
4268	2026-05-21 14:00:00	12	28.22
4271	2026-05-21 14:00:00	6	12
4275	2026-05-21 14:00:00	7	24.28
4278	2026-05-21 14:00:00	14	20
4285	2026-05-21 14:00:00	8	171.6
4288	2026-05-21 14:00:00	11	20
4297	2026-05-21 14:00:00	13	198
4304	2026-05-21 15:00:00	18	198
4306	2026-05-21 15:00:00	46	20
4312	2026-05-21 15:00:00	49	20
4319	2026-05-21 15:00:00	17	28.3
4327	2026-05-21 15:00:00	16	20
4329	2026-05-21 15:00:00	48	198
4335	2026-05-21 15:00:00	19	20
4338	2026-05-21 15:00:00	47	28.25
4342	2026-05-21 15:00:00	20	20
4347	2026-05-21 15:00:00	28	198
1245	2026-05-19 00:00:00	16	20
1253	2026-05-19 01:00:00	12	28.37
1263	2026-05-19 01:00:00	13	198
1274	2026-05-19 01:00:00	14	20
1284	2026-05-19 01:00:00	15	20
1296	2026-05-19 01:00:00	11	20
2307	2026-05-19 22:00:00	45	20
2311	2026-05-19 22:00:00	41	20
2321	2026-05-19 22:00:00	42	28.48
2332	2026-05-19 22:00:00	43	198
2342	2026-05-19 22:00:00	44	20
2357	2026-05-19 23:00:00	41	20
2367	2026-05-19 23:00:00	42	28.21
2375	2026-05-19 23:00:00	43	198
2382	2026-05-19 23:00:00	44	20
2389	2026-05-19 23:00:00	45	20
2409	2026-05-20 00:00:00	48	198
2412	2026-05-20 00:00:00	49	20
2422	2026-05-20 00:00:00	50	20
2431	2026-05-20 00:00:00	46	20
2441	2026-05-20 00:00:00	47	28.34
2458	2026-05-20 01:00:00	40	20
2465	2026-05-20 01:00:00	36	20
2476	2026-05-20 01:00:00	37	28.3
2484	2026-05-20 01:00:00	38	198
2495	2026-05-20 01:00:00	39	20
2509	2026-05-20 02:00:00	44	20
2515	2026-05-20 02:00:00	45	20
2527	2026-05-20 02:00:00	41	20
2534	2026-05-20 02:00:00	42	28.38
2541	2026-05-20 02:00:00	43	198
2559	2026-05-20 03:00:00	49	20
2569	2026-05-20 03:00:00	50	20
2580	2026-05-20 03:00:00	46	20
2589	2026-05-20 03:00:00	47	28.27
2597	2026-05-20 03:00:00	48	198
2602	2026-05-20 04:00:00	8	171.6
2611	2026-05-20 04:00:00	9	20
2622	2026-05-20 04:00:00	10	20
2632	2026-05-20 04:00:00	6	12
2643	2026-05-20 04:00:00	7	24.41
2657	2026-05-20 05:00:00	32	28.34
2665	2026-05-20 05:00:00	33	198
2676	2026-05-20 05:00:00	34	20
2682	2026-05-20 05:00:00	35	20
2691	2026-05-20 05:00:00	31	20
2706	2026-05-20 06:00:00	21	20
2718	2026-05-20 06:00:00	22	28.3
2730	2026-05-20 06:00:00	23	198
2742	2026-05-20 06:00:00	24	20
2748	2026-05-20 06:00:00	25	20
2752	2026-05-20 07:00:00	11	20
2767	2026-05-20 07:00:00	12	28.29
2783	2026-05-20 07:00:00	13	198
2793	2026-05-20 07:00:00	14	20
2800	2026-05-20 07:00:00	15	20
3717	2026-05-21 03:00:00	11	20
3723	2026-05-21 03:00:00	14	20
3734	2026-05-21 03:00:00	13	198
3746	2026-05-21 03:00:00	12	28.41
3868	2026-05-21 06:00:00	47	28.42
3877	2026-05-21 06:00:00	49	20
3888	2026-05-21 06:00:00	48	198
3896	2026-05-21 06:00:00	50	20
3904	2026-05-21 07:00:00	12	28.36
3912	2026-05-21 07:00:00	15	20
3921	2026-05-21 07:00:00	11	20
3932	2026-05-21 07:00:00	14	20
3941	2026-05-21 07:00:00	13	198
3959	2026-05-21 08:00:00	38	198
3965	2026-05-21 08:00:00	37	28.42
3975	2026-05-21 08:00:00	39	20
3982	2026-05-21 08:00:00	40	20
3992	2026-05-21 08:00:00	36	20
4005	2026-05-21 09:00:00	29	20
4016	2026-05-21 09:00:00	28	198
4031	2026-05-21 09:00:00	30	20
4039	2026-05-21 09:00:00	27	28.27
4047	2026-05-21 09:00:00	26	20
4056	2026-05-21 10:00:00	26	20
4066	2026-05-21 10:00:00	28	198
4080	2026-05-21 10:00:00	30	20
4092	2026-05-21 10:00:00	27	28.28
4099	2026-05-21 10:00:00	29	20
4110	2026-05-21 11:00:00	14	20
4119	2026-05-21 11:00:00	11	20
4130	2026-05-21 11:00:00	13	198
4142	2026-05-21 11:00:00	15	20
4149	2026-05-21 11:00:00	12	28.23
4152	2026-05-21 12:00:00	6	12
4164	2026-05-21 12:00:00	7	24.28
4177	2026-05-21 12:00:00	8	171.6
4187	2026-05-21 12:00:00	10	20
4197	2026-05-21 12:00:00	9	20
4204	2026-05-21 13:00:00	17	28.29
4210	2026-05-21 13:00:00	47	28.23
4217	2026-05-21 13:00:00	16	20
4220	2026-05-21 13:00:00	50	20
4224	2026-05-21 13:00:00	19	20
4229	2026-05-21 13:00:00	46	20
4233	2026-05-21 13:00:00	20	20
4239	2026-05-21 13:00:00	49	20
4246	2026-05-21 13:00:00	18	198
4250	2026-05-21 13:00:00	48	198
4251	2026-05-21 14:00:00	4	20
4257	2026-05-21 14:00:00	39	20
4260	2026-05-21 14:00:00	46	20
4262	2026-05-21 14:00:00	40	20
4263	2026-05-21 14:00:00	5	20
4266	2026-05-21 14:00:00	49	20
4272	2026-05-21 14:00:00	36	20
4273	2026-05-21 14:00:00	1	12
4274	2026-05-21 14:00:00	48	198
4276	2026-05-21 14:00:00	38	198
4281	2026-05-21 14:00:00	47	28.23
4282	2026-05-21 14:00:00	3	171.6
4286	2026-05-21 14:00:00	37	28.37
4292	2026-05-21 14:00:00	50	20
4293	2026-05-21 14:00:00	2	24.42
4305	2026-05-21 15:00:00	35	20
4309	2026-05-21 15:00:00	40	20
4310	2026-05-21 15:00:00	43	198
4311	2026-05-21 15:00:00	33	198
4315	2026-05-21 15:00:00	36	20
4320	2026-05-21 15:00:00	31	20
4321	2026-05-21 15:00:00	44	20
4324	2026-05-21 15:00:00	38	198
4330	2026-05-21 15:00:00	34	20
4331	2026-05-21 15:00:00	41	20
4336	2026-05-21 15:00:00	37	28.2
4341	2026-05-21 15:00:00	32	28.22
4343	2026-05-21 15:00:00	39	20
4345	2026-05-21 15:00:00	42	28.39
4348	2026-05-21 15:00:00	50	20
4350	2026-05-21 15:00:00	45	20
4352	2026-05-21 16:00:00	7	24.31
1250	2026-05-19 00:00:00	29	20
1252	2026-05-19 01:00:00	5	20
1262	2026-05-19 01:00:00	1	12
1272	2026-05-19 01:00:00	2	24.28
1281	2026-05-19 01:00:00	3	171.6
1291	2026-05-19 01:00:00	4	20
2308	2026-05-19 22:00:00	46	20
2315	2026-05-19 22:00:00	47	28.24
2327	2026-05-19 22:00:00	48	198
2339	2026-05-19 22:00:00	49	20
2349	2026-05-19 22:00:00	50	20
2351	2026-05-19 23:00:00	4	20
2361	2026-05-19 23:00:00	5	20
2372	2026-05-19 23:00:00	1	12
2385	2026-05-19 23:00:00	2	24.47
2396	2026-05-19 23:00:00	3	171.6
2405	2026-05-20 00:00:00	18	198
2418	2026-05-20 00:00:00	19	20
2430	2026-05-20 00:00:00	20	20
2437	2026-05-20 00:00:00	16	20
2447	2026-05-20 00:00:00	17	28.3
2453	2026-05-20 01:00:00	20	20
2464	2026-05-20 01:00:00	16	20
2475	2026-05-20 01:00:00	17	28.23
2483	2026-05-20 01:00:00	18	198
2492	2026-05-20 01:00:00	19	20
2508	2026-05-20 02:00:00	32	28.39
2520	2026-05-20 02:00:00	33	198
2529	2026-05-20 02:00:00	34	20
2538	2026-05-20 02:00:00	35	20
2550	2026-05-20 02:00:00	31	20
2553	2026-05-20 03:00:00	11	20
2566	2026-05-20 03:00:00	12	28.34
2577	2026-05-20 03:00:00	13	198
2587	2026-05-20 03:00:00	14	20
2596	2026-05-20 03:00:00	15	20
2606	2026-05-20 04:00:00	24	20
2617	2026-05-20 04:00:00	25	20
2629	2026-05-20 04:00:00	21	20
2639	2026-05-20 04:00:00	22	28.35
2649	2026-05-20 04:00:00	23	198
2651	2026-05-20 05:00:00	2	24.23
2661	2026-05-20 05:00:00	3	171.6
2671	2026-05-20 05:00:00	4	20
2684	2026-05-20 05:00:00	5	20
2695	2026-05-20 05:00:00	1	12
2705	2026-05-20 06:00:00	30	20
2716	2026-05-20 06:00:00	26	20
2728	2026-05-20 06:00:00	27	28.47
2739	2026-05-20 06:00:00	28	198
2746	2026-05-20 06:00:00	29	20
2756	2026-05-20 07:00:00	21	20
2766	2026-05-20 07:00:00	22	28.34
2778	2026-05-20 07:00:00	23	198
2786	2026-05-20 07:00:00	24	20
2797	2026-05-20 07:00:00	25	20
3718	2026-05-21 03:00:00	32	28.26
3730	2026-05-21 03:00:00	35	20
3736	2026-05-21 03:00:00	33	198
3747	2026-05-21 03:00:00	31	20
3875	2026-05-21 06:00:00	45	20
3885	2026-05-21 06:00:00	43	198
3897	2026-05-21 06:00:00	44	20
3900	2026-05-21 06:00:00	41	20
3901	2026-05-21 07:00:00	2	24.31
3911	2026-05-21 07:00:00	5	20
3926	2026-05-21 07:00:00	1	12
3938	2026-05-21 07:00:00	3	171.6
3947	2026-05-21 07:00:00	4	20
3956	2026-05-21 08:00:00	22	28.26
3964	2026-05-21 08:00:00	25	20
3977	2026-05-21 08:00:00	24	20
3985	2026-05-21 08:00:00	23	198
3997	2026-05-21 08:00:00	21	20
4001	2026-05-21 09:00:00	3	171.6
4011	2026-05-21 09:00:00	2	24.49
4017	2026-05-21 09:00:00	5	20
4024	2026-05-21 09:00:00	4	20
4035	2026-05-21 09:00:00	1	12
4059	2026-05-21 10:00:00	47	28.39
4069	2026-05-21 10:00:00	49	20
4073	2026-05-21 10:00:00	48	198
4082	2026-05-21 10:00:00	50	20
4089	2026-05-21 10:00:00	46	20
4109	2026-05-21 11:00:00	50	20
4115	2026-05-21 11:00:00	46	20
4126	2026-05-21 11:00:00	47	28.25
4139	2026-05-21 11:00:00	49	20
4150	2026-05-21 11:00:00	48	198
4151	2026-05-21 12:00:00	5	20
4161	2026-05-21 12:00:00	1	12
4174	2026-05-21 12:00:00	3	171.6
4185	2026-05-21 12:00:00	2	24.22
4194	2026-05-21 12:00:00	4	20
4206	2026-05-21 13:00:00	31	20
4212	2026-05-21 13:00:00	3	171.6
4215	2026-05-21 13:00:00	34	20
4222	2026-05-21 13:00:00	2	24.35
4227	2026-05-21 13:00:00	32	28.46
4232	2026-05-21 13:00:00	4	20
4237	2026-05-21 13:00:00	35	20
4243	2026-05-21 13:00:00	5	20
4249	2026-05-21 13:00:00	33	198
4252	2026-05-21 14:00:00	25	20
4253	2026-05-21 14:00:00	32	28.21
4256	2026-05-21 14:00:00	43	198
4264	2026-05-21 14:00:00	24	20
4265	2026-05-21 14:00:00	35	20
4269	2026-05-21 14:00:00	44	20
4279	2026-05-21 14:00:00	23	198
4280	2026-05-21 14:00:00	33	198
4284	2026-05-21 14:00:00	41	20
4289	2026-05-21 14:00:00	31	20
4290	2026-05-21 14:00:00	21	20
4294	2026-05-21 14:00:00	42	28.25
4298	2026-05-21 14:00:00	22	28.32
4299	2026-05-21 14:00:00	34	20
4300	2026-05-21 14:00:00	45	20
4301	2026-05-21 15:00:00	5	20
4303	2026-05-21 15:00:00	11	20
4307	2026-05-21 15:00:00	9	20
4313	2026-05-21 15:00:00	1	12
4316	2026-05-21 15:00:00	13	198
4317	2026-05-21 15:00:00	6	12
4322	2026-05-21 15:00:00	3	171.6
4325	2026-05-21 15:00:00	15	20
4326	2026-05-21 15:00:00	7	24.28
4332	2026-05-21 15:00:00	12	28.36
4333	2026-05-21 15:00:00	2	24.34
4337	2026-05-21 15:00:00	8	171.6
4339	2026-05-21 15:00:00	22	28.4
4340	2026-05-21 15:00:00	14	20
4344	2026-05-21 15:00:00	10	20
4346	2026-05-21 15:00:00	4	20
4349	2026-05-21 15:00:00	25	20
4351	2026-05-21 16:00:00	3	171.6
4353	2026-05-21 16:00:00	15	20
4367	2026-05-21 16:00:00	12	28.33
4378	2026-05-21 16:00:00	14	20
4387	2026-05-21 16:00:00	11	20
4398	2026-05-21 16:00:00	13	198
4405	2026-05-21 17:00:00	21	20
4411	2026-05-21 17:00:00	22	28.45
4421	2026-05-21 17:00:00	25	20
4431	2026-05-21 17:00:00	24	20
4444	2026-05-21 17:00:00	23	198
4473	2026-05-21 18:00:00	41	20
4482	2026-05-21 18:00:00	42	28.38
4494	2026-05-21 18:00:00	45	20
4499	2026-05-21 18:00:00	43	198
4500	2026-05-21 18:00:00	44	20
4501	2026-05-21 19:00:00	3	171.6
4511	2026-05-21 19:00:00	2	24.39
4521	2026-05-21 19:00:00	4	20
4531	2026-05-21 19:00:00	5	20
4541	2026-05-21 19:00:00	1	12
4560	2026-05-21 20:00:00	37	28.43
4569	2026-05-21 20:00:00	39	20
4576	2026-05-21 20:00:00	40	20
4586	2026-05-21 20:00:00	36	20
4593	2026-05-21 20:00:00	38	198
4610	2026-05-21 21:00:00	42	28.48
4617	2026-05-21 21:00:00	45	20
4628	2026-05-21 21:00:00	43	198
4638	2026-05-21 21:00:00	44	20
4645	2026-05-21 21:00:00	41	20
4659	2026-05-21 22:00:00	31	20
4663	2026-05-21 22:00:00	34	20
4672	2026-05-21 22:00:00	32	28.43
4677	2026-05-21 22:00:00	35	20
4684	2026-05-21 22:00:00	33	198
4706	2026-05-21 23:00:00	42	28.35
4719	2026-05-21 23:00:00	45	20
4733	2026-05-21 23:00:00	43	198
4746	2026-05-21 23:00:00	44	20
4750	2026-05-21 23:00:00	41	20
4751	2026-05-22 00:00:00	1	12
4763	2026-05-22 00:00:00	3	171.6
4773	2026-05-22 00:00:00	2	24.21
4783	2026-05-22 00:00:00	4	20
4789	2026-05-22 00:00:00	5	20
4809	2026-05-22 01:00:00	43	198
4813	2026-05-22 01:00:00	44	20
4825	2026-05-22 01:00:00	41	20
4838	2026-05-22 01:00:00	42	28.33
4848	2026-05-22 01:00:00	45	20
4853	2026-05-22 02:00:00	20	20
4864	2026-05-22 02:00:00	18	198
4877	2026-05-22 02:00:00	17	28.36
4892	2026-05-22 02:00:00	16	20
4899	2026-05-22 02:00:00	19	20
4901	2026-05-22 03:00:00	3	171.6
4912	2026-05-22 03:00:00	2	24.46
4923	2026-05-22 03:00:00	4	20
4935	2026-05-22 03:00:00	5	20
4944	2026-05-22 03:00:00	1	12
4953	2026-05-22 04:00:00	32	28.25
4962	2026-05-22 04:00:00	35	20
4972	2026-05-22 04:00:00	33	198
4982	2026-05-22 04:00:00	31	20
4991	2026-05-22 04:00:00	34	20
5010	2026-05-22 05:00:00	45	20
5016	2026-05-22 05:00:00	43	198
5025	2026-05-22 05:00:00	44	20
5035	2026-05-22 05:00:00	41	20
5045	2026-05-22 05:00:00	42	28.44
5053	2026-05-22 06:00:00	26	20
5065	2026-05-22 06:00:00	29	20
5075	2026-05-22 06:00:00	28	198
5086	2026-05-22 06:00:00	30	20
5096	2026-05-22 06:00:00	27	28.28
5107	2026-05-22 07:00:00	30	20
5112	2026-05-22 07:00:00	27	28.22
5122	2026-05-22 07:00:00	26	20
5130	2026-05-22 07:00:00	29	20
5143	2026-05-22 07:00:00	28	198
5154	2026-05-22 08:00:00	18	198
5161	2026-05-22 08:00:00	17	28.28
5171	2026-05-22 08:00:00	16	20
5176	2026-05-22 08:00:00	19	20
5185	2026-05-22 08:00:00	20	20
5208	2026-05-22 09:00:00	48	198
5214	2026-05-22 09:00:00	47	28.25
5221	2026-05-22 09:00:00	50	20
5230	2026-05-22 09:00:00	46	20
5234	2026-05-22 09:00:00	49	20
5243	2026-05-22 09:00:00	37	28.41
5250	2026-05-22 09:00:00	39	20
5251	2026-05-22 10:00:00	2	24.46
5259	2026-05-22 10:00:00	45	20
5263	2026-05-22 10:00:00	4	20
5270	2026-05-22 10:00:00	43	198
5275	2026-05-22 10:00:00	5	20
5280	2026-05-22 10:00:00	44	20
5287	2026-05-22 10:00:00	1	12
5292	2026-05-22 10:00:00	41	20
5296	2026-05-22 10:00:00	3	171.6
5299	2026-05-22 10:00:00	42	28.28
5302	2026-05-22 11:00:00	8	171.6
5304	2026-05-22 11:00:00	11	20
5313	2026-05-22 11:00:00	10	20
5317	2026-05-22 11:00:00	13	198
5327	2026-05-22 11:00:00	9	20
5332	2026-05-22 11:00:00	15	20
5338	2026-05-22 11:00:00	6	12
5340	2026-05-22 11:00:00	12	28.23
5346	2026-05-22 11:00:00	7	24.29
5347	2026-05-22 11:00:00	14	20
5354	2026-05-22 12:00:00	18	283.8
5360	2026-05-22 12:00:00	21	46
5369	2026-05-22 12:00:00	17	41.25
5370	2026-05-22 12:00:00	22	41.3
5376	2026-05-22 12:00:00	25	20
5379	2026-05-22 12:00:00	16	46
5384	2026-05-22 12:00:00	24	20
5389	2026-05-22 12:00:00	19	20
5394	2026-05-22 12:00:00	23	283.8
5398	2026-05-22 12:00:00	20	20
5402	2026-05-22 13:00:00	10	20
5408	2026-05-22 13:00:00	29	20
5415	2026-05-22 13:00:00	9	20
5417	2026-05-22 13:00:00	28	198
5426	2026-05-22 13:00:00	6	12
5428	2026-05-22 13:00:00	30	20
5435	2026-05-22 13:00:00	27	28.33
5437	2026-05-22 13:00:00	7	24.43
5445	2026-05-22 13:00:00	26	20
5447	2026-05-22 13:00:00	8	171.6
5456	2026-05-22 14:00:00	23	198
5455	2026-05-22 14:00:00	29	20
5463	2026-05-22 14:00:00	21	20
5464	2026-05-22 14:00:00	28	198
4354	2026-05-21 16:00:00	21	20
4362	2026-05-21 16:00:00	22	28.27
4372	2026-05-21 16:00:00	25	20
4381	2026-05-21 16:00:00	24	20
4385	2026-05-21 16:00:00	23	198
4410	2026-05-21 17:00:00	46	20
4419	2026-05-21 17:00:00	49	20
4429	2026-05-21 17:00:00	48	198
4440	2026-05-21 17:00:00	47	28.23
4450	2026-05-21 17:00:00	50	20
4452	2026-05-21 18:00:00	1	12
4460	2026-05-21 18:00:00	3	171.6
4471	2026-05-21 18:00:00	2	24.45
4481	2026-05-21 18:00:00	4	20
4491	2026-05-21 18:00:00	5	20
4506	2026-05-21 19:00:00	36	20
4519	2026-05-21 19:00:00	38	198
4528	2026-05-21 19:00:00	37	28.38
4538	2026-05-21 19:00:00	39	20
4548	2026-05-21 19:00:00	40	20
4558	2026-05-21 20:00:00	16	20
4562	2026-05-21 20:00:00	19	20
4571	2026-05-21 20:00:00	20	20
4582	2026-05-21 20:00:00	18	198
4592	2026-05-21 20:00:00	17	28.39
4607	2026-05-21 21:00:00	36	20
4616	2026-05-21 21:00:00	38	198
4626	2026-05-21 21:00:00	37	28.27
4633	2026-05-21 21:00:00	39	20
4642	2026-05-21 21:00:00	40	20
4658	2026-05-21 22:00:00	42	28.42
4670	2026-05-21 22:00:00	45	20
4682	2026-05-21 22:00:00	43	198
4692	2026-05-21 22:00:00	44	20
4700	2026-05-21 22:00:00	41	20
4701	2026-05-21 23:00:00	4	20
4716	2026-05-21 23:00:00	5	20
4726	2026-05-21 23:00:00	1	12
4738	2026-05-21 23:00:00	3	171.6
4748	2026-05-21 23:00:00	2	24.46
4752	2026-05-22 00:00:00	9	20
4761	2026-05-22 00:00:00	6	12
4770	2026-05-22 00:00:00	7	24.43
4777	2026-05-22 00:00:00	8	171.6
4787	2026-05-22 00:00:00	10	20
4810	2026-05-22 01:00:00	47	28.24
4812	2026-05-22 01:00:00	50	20
4821	2026-05-22 01:00:00	46	20
4830	2026-05-22 01:00:00	49	20
4840	2026-05-22 01:00:00	48	198
4859	2026-05-22 02:00:00	49	20
4869	2026-05-22 02:00:00	48	198
4885	2026-05-22 02:00:00	47	28.33
4894	2026-05-22 02:00:00	50	20
4898	2026-05-22 02:00:00	46	20
4906	2026-05-22 03:00:00	13	198
4914	2026-05-22 03:00:00	15	20
4924	2026-05-22 03:00:00	12	28.42
4933	2026-05-22 03:00:00	14	20
4942	2026-05-22 03:00:00	11	20
4960	2026-05-22 04:00:00	45	20
4967	2026-05-22 04:00:00	43	198
4978	2026-05-22 04:00:00	44	20
4990	2026-05-22 04:00:00	41	20
4999	2026-05-22 04:00:00	42	28.26
5003	2026-05-22 05:00:00	17	28.24
5012	2026-05-22 05:00:00	16	20
5022	2026-05-22 05:00:00	19	20
5033	2026-05-22 05:00:00	20	20
5043	2026-05-22 05:00:00	18	198
5060	2026-05-22 06:00:00	44	20
5070	2026-05-22 06:00:00	41	20
5080	2026-05-22 06:00:00	42	28.36
5081	2026-05-22 06:00:00	45	20
5091	2026-05-22 06:00:00	43	198
5110	2026-05-22 07:00:00	50	20
5120	2026-05-22 07:00:00	46	20
5134	2026-05-22 07:00:00	49	20
5147	2026-05-22 07:00:00	48	198
5150	2026-05-22 07:00:00	47	28.31
5151	2026-05-22 08:00:00	1	12
5166	2026-05-22 08:00:00	3	171.6
5180	2026-05-22 08:00:00	2	24.37
5192	2026-05-22 08:00:00	4	20
5200	2026-05-22 08:00:00	5	20
5207	2026-05-22 09:00:00	1	12
5218	2026-05-22 09:00:00	3	171.6
5224	2026-05-22 09:00:00	2	24.42
5238	2026-05-22 09:00:00	4	20
5246	2026-05-22 09:00:00	5	20
5252	2026-05-22 10:00:00	15	20
5268	2026-05-22 10:00:00	12	28.23
5279	2026-05-22 10:00:00	14	20
5284	2026-05-22 10:00:00	11	20
5293	2026-05-22 10:00:00	13	198
5306	2026-05-22 11:00:00	35	20
5315	2026-05-22 11:00:00	33	198
5323	2026-05-22 11:00:00	31	20
5329	2026-05-22 11:00:00	34	20
5342	2026-05-22 11:00:00	32	28.31
5357	2026-05-22 12:00:00	39	20
5361	2026-05-22 12:00:00	40	20
5372	2026-05-22 12:00:00	36	46
5382	2026-05-22 12:00:00	38	283.8
5393	2026-05-22 12:00:00	37	41.23
5410	2026-05-22 13:00:00	37	28.31
5419	2026-05-22 13:00:00	39	20
5429	2026-05-22 13:00:00	40	20
5440	2026-05-22 13:00:00	36	20
5450	2026-05-22 13:00:00	38	198
5451	2026-05-22 14:00:00	4	20
5461	2026-05-22 14:00:00	5	20
5473	2026-05-22 14:00:00	1	12
5474	2026-05-22 14:00:00	22	28.38
5484	2026-05-22 14:00:00	25	20
5486	2026-05-22 14:00:00	3	171.6
5496	2026-05-22 14:00:00	24	20
5499	2026-05-22 14:00:00	2	24.24
5502	2026-05-22 15:00:00	7	24.25
5506	2026-05-22 15:00:00	28	198
5512	2026-05-22 15:00:00	30	20
5518	2026-05-22 15:00:00	8	171.6
5521	2026-05-22 15:00:00	27	28.25
5528	2026-05-22 15:00:00	26	20
5533	2026-05-22 15:00:00	10	20
5538	2026-05-22 15:00:00	29	20
5546	2026-05-22 15:00:00	9	20
5550	2026-05-22 15:00:00	6	12
5551	2026-05-22 16:00:00	3	171.6
5557	2026-05-22 16:00:00	37	28.21
5562	2026-05-22 16:00:00	39	20
5563	2026-05-22 16:00:00	4	20
5574	2026-05-22 16:00:00	40	20
5577	2026-05-22 16:00:00	2	24.29
5586	2026-05-22 16:00:00	36	20
5587	2026-05-22 16:00:00	5	20
4355	2026-05-21 16:00:00	16	20
4369	2026-05-21 16:00:00	19	20
4380	2026-05-21 16:00:00	20	20
4392	2026-05-21 16:00:00	18	198
4400	2026-05-21 16:00:00	17	28.31
4403	2026-05-21 17:00:00	1	12
4414	2026-05-21 17:00:00	3	171.6
4428	2026-05-21 17:00:00	2	24.24
4441	2026-05-21 17:00:00	4	20
4449	2026-05-21 17:00:00	5	20
4451	2026-05-21 18:00:00	9	20
4461	2026-05-21 18:00:00	6	12
4472	2026-05-21 18:00:00	7	24.36
4483	2026-05-21 18:00:00	8	171.6
4495	2026-05-21 18:00:00	10	20
4503	2026-05-21 19:00:00	22	28.34
4513	2026-05-21 19:00:00	25	20
4524	2026-05-21 19:00:00	24	20
4535	2026-05-21 19:00:00	23	198
4545	2026-05-21 19:00:00	21	20
4556	2026-05-21 20:00:00	32	28.32
4563	2026-05-21 20:00:00	35	20
4577	2026-05-21 20:00:00	33	198
4587	2026-05-21 20:00:00	31	20
4597	2026-05-21 20:00:00	34	20
4604	2026-05-21 21:00:00	17	28.27
4620	2026-05-21 21:00:00	16	20
4629	2026-05-21 21:00:00	19	20
4640	2026-05-21 21:00:00	20	20
4650	2026-05-21 21:00:00	18	198
4651	2026-05-21 22:00:00	2	24.46
4664	2026-05-21 22:00:00	4	20
4675	2026-05-21 22:00:00	5	20
4691	2026-05-21 22:00:00	1	12
4699	2026-05-21 22:00:00	3	171.6
4703	2026-05-21 23:00:00	11	20
4712	2026-05-21 23:00:00	13	198
4722	2026-05-21 23:00:00	15	20
4732	2026-05-21 23:00:00	12	28.44
4744	2026-05-21 23:00:00	14	20
4753	2026-05-22 00:00:00	15	20
4764	2026-05-22 00:00:00	12	28.26
4776	2026-05-22 00:00:00	14	20
4786	2026-05-22 00:00:00	11	20
4796	2026-05-22 00:00:00	13	198
4805	2026-05-22 01:00:00	23	198
4818	2026-05-22 01:00:00	21	20
4832	2026-05-22 01:00:00	22	28.24
4841	2026-05-22 01:00:00	25	20
4850	2026-05-22 01:00:00	24	20
4855	2026-05-22 02:00:00	21	20
4868	2026-05-22 02:00:00	22	28.28
4884	2026-05-22 02:00:00	25	20
4895	2026-05-22 02:00:00	24	20
4900	2026-05-22 02:00:00	23	198
4903	2026-05-22 03:00:00	9	20
4919	2026-05-22 03:00:00	6	12
4929	2026-05-22 03:00:00	7	24.46
4940	2026-05-22 03:00:00	8	171.6
4949	2026-05-22 03:00:00	10	20
4954	2026-05-22 04:00:00	13	198
4963	2026-05-22 04:00:00	15	20
4973	2026-05-22 04:00:00	12	28.36
4981	2026-05-22 04:00:00	14	20
4992	2026-05-22 04:00:00	11	20
5009	2026-05-22 05:00:00	40	20
5015	2026-05-22 05:00:00	36	20
5026	2026-05-22 05:00:00	38	198
5034	2026-05-22 05:00:00	37	28.48
5044	2026-05-22 05:00:00	39	20
5057	2026-05-22 06:00:00	35	20
5068	2026-05-22 06:00:00	33	198
5079	2026-05-22 06:00:00	31	20
5090	2026-05-22 06:00:00	34	20
5099	2026-05-22 06:00:00	32	28.22
5102	2026-05-22 07:00:00	10	20
5113	2026-05-22 07:00:00	9	20
5121	2026-05-22 07:00:00	6	12
5138	2026-05-22 07:00:00	7	24.21
5148	2026-05-22 07:00:00	8	171.6
5152	2026-05-22 08:00:00	8	171.6
5165	2026-05-22 08:00:00	10	20
5179	2026-05-22 08:00:00	9	20
5191	2026-05-22 08:00:00	6	12
5198	2026-05-22 08:00:00	7	24.26
5201	2026-05-22 09:00:00	6	12
5212	2026-05-22 09:00:00	7	24.25
5223	2026-05-22 09:00:00	8	171.6
5232	2026-05-22 09:00:00	10	20
5242	2026-05-22 09:00:00	9	20
5258	2026-05-22 10:00:00	36	20
5267	2026-05-22 10:00:00	38	198
5277	2026-05-22 10:00:00	37	28.34
5286	2026-05-22 10:00:00	39	20
5297	2026-05-22 10:00:00	40	20
5303	2026-05-22 11:00:00	24	20
5316	2026-05-22 11:00:00	23	198
5331	2026-05-22 11:00:00	21	20
5341	2026-05-22 11:00:00	22	28.38
5350	2026-05-22 11:00:00	25	20
5353	2026-05-22 12:00:00	15	20
5364	2026-05-22 12:00:00	12	41.41
5375	2026-05-22 12:00:00	14	20
5388	2026-05-22 12:00:00	11	46
5399	2026-05-22 12:00:00	13	283.8
5401	2026-05-22 13:00:00	11	20
5412	2026-05-22 13:00:00	13	198
5421	2026-05-22 13:00:00	15	20
5431	2026-05-22 13:00:00	12	28.28
5441	2026-05-22 13:00:00	14	20
5459	2026-05-22 14:00:00	42	28.36
5469	2026-05-22 14:00:00	45	20
5476	2026-05-22 14:00:00	30	20
5480	2026-05-22 14:00:00	43	198
5487	2026-05-22 14:00:00	27	28.37
5490	2026-05-22 14:00:00	44	20
5493	2026-05-22 14:00:00	26	20
5500	2026-05-22 14:00:00	41	20
5501	2026-05-22 15:00:00	5	20
5510	2026-05-22 15:00:00	38	198
5514	2026-05-22 15:00:00	1	12
5523	2026-05-22 15:00:00	3	171.6
5524	2026-05-22 15:00:00	37	28.48
5531	2026-05-22 15:00:00	4	20
5536	2026-05-22 15:00:00	39	20
5544	2026-05-22 15:00:00	2	24.22
5545	2026-05-22 15:00:00	40	20
5548	2026-05-22 15:00:00	36	20
5552	2026-05-22 16:00:00	8	171.6
5556	2026-05-22 16:00:00	27	28.33
5565	2026-05-22 16:00:00	10	20
5566	2026-05-22 16:00:00	26	20
5572	2026-05-22 16:00:00	29	20
5573	2026-05-22 16:00:00	9	20
5581	2026-05-22 16:00:00	6	12
5583	2026-05-22 16:00:00	28	198
4356	2026-05-21 16:00:00	28	198
4364	2026-05-21 16:00:00	30	20
4374	2026-05-21 16:00:00	27	28.24
4384	2026-05-21 16:00:00	26	20
4394	2026-05-21 16:00:00	29	20
4408	2026-05-21 17:00:00	33	198
4418	2026-05-21 17:00:00	31	20
4425	2026-05-21 17:00:00	34	20
4437	2026-05-21 17:00:00	32	28.32
4446	2026-05-21 17:00:00	35	20
4457	2026-05-21 18:00:00	18	198
4468	2026-05-21 18:00:00	17	28.47
4479	2026-05-21 18:00:00	16	20
4490	2026-05-21 18:00:00	19	20
4493	2026-05-21 18:00:00	20	20
4508	2026-05-21 19:00:00	31	20
4517	2026-05-21 19:00:00	34	20
4525	2026-05-21 19:00:00	32	28.27
4533	2026-05-21 19:00:00	35	20
4543	2026-05-21 19:00:00	33	198
4552	2026-05-21 20:00:00	24	20
4568	2026-05-21 20:00:00	23	198
4579	2026-05-21 20:00:00	21	20
4589	2026-05-21 20:00:00	22	28.23
4599	2026-05-21 20:00:00	25	20
4601	2026-05-21 21:00:00	2	24.27
4615	2026-05-21 21:00:00	4	20
4627	2026-05-21 21:00:00	5	20
4634	2026-05-21 21:00:00	1	12
4647	2026-05-21 21:00:00	3	171.6
4652	2026-05-21 22:00:00	11	20
4662	2026-05-21 22:00:00	13	198
4674	2026-05-21 22:00:00	15	20
4687	2026-05-21 22:00:00	12	28.25
4698	2026-05-21 22:00:00	14	20
4705	2026-05-21 23:00:00	22	28.31
4713	2026-05-21 23:00:00	25	20
4723	2026-05-21 23:00:00	24	20
4731	2026-05-21 23:00:00	23	198
4743	2026-05-21 23:00:00	21	20
4754	2026-05-22 00:00:00	32	28.35
4755	2026-05-22 00:00:00	48	198
4762	2026-05-22 00:00:00	35	20
4767	2026-05-22 00:00:00	47	28.42
4774	2026-05-22 00:00:00	33	198
4779	2026-05-22 00:00:00	50	20
4785	2026-05-22 00:00:00	31	20
4792	2026-05-22 00:00:00	46	20
4795	2026-05-22 00:00:00	34	20
4798	2026-05-22 00:00:00	49	20
4803	2026-05-22 01:00:00	11	20
4807	2026-05-22 01:00:00	26	20
4815	2026-05-22 01:00:00	13	198
4819	2026-05-22 01:00:00	29	20
4824	2026-05-22 01:00:00	15	20
4828	2026-05-22 01:00:00	28	198
4831	2026-05-22 01:00:00	12	28.39
4837	2026-05-22 01:00:00	30	20
4843	2026-05-22 01:00:00	14	20
4847	2026-05-22 01:00:00	27	28.39
4857	2026-05-22 02:00:00	15	20
4858	2026-05-22 02:00:00	39	20
4865	2026-05-22 02:00:00	12	28.41
4870	2026-05-22 02:00:00	40	20
4872	2026-05-22 02:00:00	14	20
4878	2026-05-22 02:00:00	11	20
4883	2026-05-22 02:00:00	36	20
4886	2026-05-22 02:00:00	13	198
4893	2026-05-22 02:00:00	38	198
4896	2026-05-22 02:00:00	37	28.28
4902	2026-05-22 03:00:00	25	20
4910	2026-05-22 03:00:00	47	28.42
4920	2026-05-22 03:00:00	24	20
4921	2026-05-22 03:00:00	50	20
4930	2026-05-22 03:00:00	23	198
4931	2026-05-22 03:00:00	46	20
4938	2026-05-22 03:00:00	49	20
4941	2026-05-22 03:00:00	21	20
4947	2026-05-22 03:00:00	48	198
4950	2026-05-22 03:00:00	22	28.33
4952	2026-05-22 04:00:00	10	20
4956	2026-05-22 04:00:00	22	28.45
4965	2026-05-22 04:00:00	9	20
4966	2026-05-22 04:00:00	25	20
4975	2026-05-22 04:00:00	24	20
4977	2026-05-22 04:00:00	6	12
4985	2026-05-22 04:00:00	7	24.23
4986	2026-05-22 04:00:00	23	198
4995	2026-05-22 04:00:00	8	171.6
4996	2026-05-22 04:00:00	21	20
5005	2026-05-22 05:00:00	13	198
5006	2026-05-22 05:00:00	27	28.26
5019	2026-05-22 05:00:00	15	20
5020	2026-05-22 05:00:00	26	20
5028	2026-05-22 05:00:00	12	28.22
5030	2026-05-22 05:00:00	29	20
5037	2026-05-22 05:00:00	14	20
5041	2026-05-22 05:00:00	28	198
5047	2026-05-22 05:00:00	11	20
5049	2026-05-22 05:00:00	30	20
5055	2026-05-22 06:00:00	19	20
5054	2026-05-22 06:00:00	15	20
5063	2026-05-22 06:00:00	20	20
5064	2026-05-22 06:00:00	12	28.25
5072	2026-05-22 06:00:00	14	20
5073	2026-05-22 06:00:00	18	198
5085	2026-05-22 06:00:00	11	20
5087	2026-05-22 06:00:00	17	28.25
5095	2026-05-22 06:00:00	13	198
5097	2026-05-22 06:00:00	16	20
5103	2026-05-22 07:00:00	11	20
5104	2026-05-22 07:00:00	21	20
5116	2026-05-22 07:00:00	13	198
5118	2026-05-22 07:00:00	22	28.32
5124	2026-05-22 07:00:00	25	20
5126	2026-05-22 07:00:00	15	20
5132	2026-05-22 07:00:00	24	20
5136	2026-05-22 07:00:00	12	28.24
5140	2026-05-22 07:00:00	23	198
5145	2026-05-22 07:00:00	14	20
5156	2026-05-22 08:00:00	40	20
5160	2026-05-22 08:00:00	48	198
5162	2026-05-22 08:00:00	47	28.48
5167	2026-05-22 08:00:00	36	20
5172	2026-05-22 08:00:00	50	20
5175	2026-05-22 08:00:00	38	198
5177	2026-05-22 08:00:00	46	20
5187	2026-05-22 08:00:00	37	28.28
5189	2026-05-22 08:00:00	49	20
5195	2026-05-22 08:00:00	39	20
5202	2026-05-22 09:00:00	28	198
5209	2026-05-22 09:00:00	40	20
5219	2026-05-22 09:00:00	30	20
5225	2026-05-22 09:00:00	27	28.47
5226	2026-05-22 09:00:00	36	20
5239	2026-05-22 09:00:00	38	198
4357	2026-05-21 16:00:00	34	20
4358	2026-05-21 16:00:00	44	20
4359	2026-05-21 16:00:00	38	198
4360	2026-05-21 16:00:00	48	198
4361	2026-05-21 16:00:00	2	24.23
4363	2026-05-21 16:00:00	41	20
4365	2026-05-21 16:00:00	32	28.29
4366	2026-05-21 16:00:00	8	171.6
4368	2026-05-21 16:00:00	4	20
4370	2026-05-21 16:00:00	37	28.25
4371	2026-05-21 16:00:00	47	28.46
4373	2026-05-21 16:00:00	42	28.2
4375	2026-05-21 16:00:00	5	20
4376	2026-05-21 16:00:00	10	20
4377	2026-05-21 16:00:00	35	20
4379	2026-05-21 16:00:00	50	20
4382	2026-05-21 16:00:00	39	20
4383	2026-05-21 16:00:00	45	20
4386	2026-05-21 16:00:00	40	20
4388	2026-05-21 16:00:00	9	20
4389	2026-05-21 16:00:00	1	12
4390	2026-05-21 16:00:00	46	20
4391	2026-05-21 16:00:00	33	198
4393	2026-05-21 16:00:00	43	198
4395	2026-05-21 16:00:00	6	12
4396	2026-05-21 16:00:00	36	20
4397	2026-05-21 16:00:00	49	20
4399	2026-05-21 16:00:00	31	20
4401	2026-05-21 17:00:00	11	20
4404	2026-05-21 17:00:00	18	198
4402	2026-05-21 17:00:00	9	20
4406	2026-05-21 17:00:00	40	20
4407	2026-05-21 17:00:00	29	20
4409	2026-05-21 17:00:00	41	20
4412	2026-05-21 17:00:00	13	198
4413	2026-05-21 17:00:00	17	28.36
4415	2026-05-21 17:00:00	6	12
4416	2026-05-21 17:00:00	28	198
4417	2026-05-21 17:00:00	42	28.34
4420	2026-05-21 17:00:00	36	20
4422	2026-05-21 17:00:00	30	20
4423	2026-05-21 17:00:00	15	20
4424	2026-05-21 17:00:00	45	20
4426	2026-05-21 17:00:00	16	20
4427	2026-05-21 17:00:00	7	24.32
4430	2026-05-21 17:00:00	38	198
4432	2026-05-21 17:00:00	19	20
4433	2026-05-21 17:00:00	27	28.35
4434	2026-05-21 17:00:00	37	28.31
4435	2026-05-21 17:00:00	8	171.6
4436	2026-05-21 17:00:00	12	28.31
4438	2026-05-21 17:00:00	43	198
4439	2026-05-21 17:00:00	20	20
4442	2026-05-21 17:00:00	39	20
4443	2026-05-21 17:00:00	10	20
4445	2026-05-21 17:00:00	26	20
4447	2026-05-21 17:00:00	14	20
4448	2026-05-21 17:00:00	44	20
4453	2026-05-21 18:00:00	29	20
4455	2026-05-21 18:00:00	11	20
4458	2026-05-21 18:00:00	40	20
4456	2026-05-21 18:00:00	33	198
4454	2026-05-21 18:00:00	21	20
4459	2026-05-21 18:00:00	46	20
4462	2026-05-21 18:00:00	49	20
4463	2026-05-21 18:00:00	13	198
4464	2026-05-21 18:00:00	31	20
4465	2026-05-21 18:00:00	28	198
4466	2026-05-21 18:00:00	36	20
4467	2026-05-21 18:00:00	22	28.21
4469	2026-05-21 18:00:00	48	198
4470	2026-05-21 18:00:00	15	20
4474	2026-05-21 18:00:00	34	20
4475	2026-05-21 18:00:00	30	20
4476	2026-05-21 18:00:00	38	198
4477	2026-05-21 18:00:00	12	28.45
4478	2026-05-21 18:00:00	25	20
4480	2026-05-21 18:00:00	47	28.39
4484	2026-05-21 18:00:00	32	28.35
4485	2026-05-21 18:00:00	14	20
4486	2026-05-21 18:00:00	37	28.21
4487	2026-05-21 18:00:00	24	20
4488	2026-05-21 18:00:00	27	28.25
4489	2026-05-21 18:00:00	50	20
4492	2026-05-21 18:00:00	35	20
4496	2026-05-21 18:00:00	23	198
4497	2026-05-21 18:00:00	39	20
4498	2026-05-21 18:00:00	26	20
4502	2026-05-21 19:00:00	6	12
4504	2026-05-21 19:00:00	12	28.23
4505	2026-05-21 19:00:00	18	198
4507	2026-05-21 19:00:00	28	198
4509	2026-05-21 19:00:00	49	20
4510	2026-05-21 19:00:00	41	20
4512	2026-05-21 19:00:00	48	198
4514	2026-05-21 19:00:00	14	20
4515	2026-05-21 19:00:00	17	28.27
4516	2026-05-21 19:00:00	42	28.4
4518	2026-05-21 19:00:00	7	24.25
4520	2026-05-21 19:00:00	11	20
4522	2026-05-21 19:00:00	47	28.21
4523	2026-05-21 19:00:00	45	20
4526	2026-05-21 19:00:00	30	20
4527	2026-05-21 19:00:00	16	20
4529	2026-05-21 19:00:00	13	198
4530	2026-05-21 19:00:00	8	171.6
4532	2026-05-21 19:00:00	50	20
4534	2026-05-21 19:00:00	43	198
4536	2026-05-21 19:00:00	27	28.25
4537	2026-05-21 19:00:00	19	20
4539	2026-05-21 19:00:00	15	20
4540	2026-05-21 19:00:00	46	20
4542	2026-05-21 19:00:00	10	20
4544	2026-05-21 19:00:00	44	20
4546	2026-05-21 19:00:00	26	20
4547	2026-05-21 19:00:00	20	20
4549	2026-05-21 19:00:00	9	20
4550	2026-05-21 19:00:00	29	20
4551	2026-05-21 20:00:00	4	20
4554	2026-05-21 20:00:00	13	198
4553	2026-05-21 20:00:00	26	20
4555	2026-05-21 20:00:00	8	171.6
4557	2026-05-21 20:00:00	45	20
4559	2026-05-21 20:00:00	47	28.23
4561	2026-05-21 20:00:00	5	20
4564	2026-05-21 20:00:00	43	198
4565	2026-05-21 20:00:00	10	20
4566	2026-05-21 20:00:00	15	20
4567	2026-05-21 20:00:00	29	20
4570	2026-05-21 20:00:00	50	20
4572	2026-05-21 20:00:00	44	20
4573	2026-05-21 20:00:00	1	12
4574	2026-05-21 20:00:00	28	198
4575	2026-05-21 20:00:00	12	28.4
4578	2026-05-21 20:00:00	9	20
4580	2026-05-21 20:00:00	46	20
4581	2026-05-21 20:00:00	3	171.6
4588	2026-05-21 20:00:00	2	24.33
4609	2026-05-21 21:00:00	49	20
4618	2026-05-21 21:00:00	48	198
4621	2026-05-21 21:00:00	47	28.41
4631	2026-05-21 21:00:00	50	20
4641	2026-05-21 21:00:00	46	20
4660	2026-05-21 22:00:00	49	20
4666	2026-05-21 22:00:00	48	198
4679	2026-05-21 22:00:00	47	28.3
4689	2026-05-21 22:00:00	50	20
4695	2026-05-21 22:00:00	46	20
4704	2026-05-21 23:00:00	18	198
4714	2026-05-21 23:00:00	17	28.21
4724	2026-05-21 23:00:00	16	20
4735	2026-05-21 23:00:00	19	20
4742	2026-05-21 23:00:00	20	20
4757	2026-05-22 00:00:00	24	20
4766	2026-05-22 00:00:00	23	198
4775	2026-05-22 00:00:00	21	20
4784	2026-05-22 00:00:00	22	28.38
4794	2026-05-22 00:00:00	25	20
4808	2026-05-22 01:00:00	35	20
4820	2026-05-22 01:00:00	33	198
4829	2026-05-22 01:00:00	31	20
4839	2026-05-22 01:00:00	34	20
4849	2026-05-22 01:00:00	32	28.28
4851	2026-05-22 02:00:00	4	20
4861	2026-05-22 02:00:00	5	20
4871	2026-05-22 02:00:00	1	12
4882	2026-05-22 02:00:00	3	171.6
4890	2026-05-22 02:00:00	2	24.43
4905	2026-05-22 03:00:00	26	20
4916	2026-05-22 03:00:00	29	20
4926	2026-05-22 03:00:00	28	198
4934	2026-05-22 03:00:00	30	20
4943	2026-05-22 03:00:00	27	28.34
4955	2026-05-22 04:00:00	40	20
4970	2026-05-22 04:00:00	36	20
4983	2026-05-22 04:00:00	38	198
4993	2026-05-22 04:00:00	37	28.32
5000	2026-05-22 04:00:00	39	20
5001	2026-05-22 05:00:00	1	12
5013	2026-05-22 05:00:00	3	171.6
5023	2026-05-22 05:00:00	2	24.22
5032	2026-05-22 05:00:00	4	20
5040	2026-05-22 05:00:00	5	20
5058	2026-05-22 06:00:00	36	20
5066	2026-05-22 06:00:00	38	198
5077	2026-05-22 06:00:00	37	28.4
5083	2026-05-22 06:00:00	39	20
5093	2026-05-22 06:00:00	40	20
5109	2026-05-22 07:00:00	40	20
5119	2026-05-22 07:00:00	36	20
5129	2026-05-22 07:00:00	38	198
5135	2026-05-22 07:00:00	37	28.45
5144	2026-05-22 07:00:00	39	20
5159	2026-05-22 08:00:00	42	28.3
5170	2026-05-22 08:00:00	45	20
5184	2026-05-22 08:00:00	43	198
5194	2026-05-22 08:00:00	44	20
5197	2026-05-22 08:00:00	41	20
5210	2026-05-22 09:00:00	18	198
5216	2026-05-22 09:00:00	17	28.29
5229	2026-05-22 09:00:00	16	20
5241	2026-05-22 09:00:00	19	20
5249	2026-05-22 09:00:00	20	20
5260	2026-05-22 10:00:00	8	171.6
5271	2026-05-22 10:00:00	10	20
5283	2026-05-22 10:00:00	9	20
5294	2026-05-22 10:00:00	6	12
5300	2026-05-22 10:00:00	7	24.41
5301	2026-05-22 11:00:00	4	20
5312	2026-05-22 11:00:00	5	20
5324	2026-05-22 11:00:00	1	12
5333	2026-05-22 11:00:00	3	171.6
5344	2026-05-22 11:00:00	2	24.43
5355	2026-05-22 12:00:00	31	46
5365	2026-05-22 12:00:00	34	20
5371	2026-05-22 12:00:00	32	41.46
5381	2026-05-22 12:00:00	35	20
5391	2026-05-22 12:00:00	33	283.8
5407	2026-05-22 13:00:00	42	28.29
5413	2026-05-22 13:00:00	45	20
5425	2026-05-22 13:00:00	43	198
5433	2026-05-22 13:00:00	44	20
5443	2026-05-22 13:00:00	41	20
5458	2026-05-22 14:00:00	38	198
5467	2026-05-22 14:00:00	37	28.42
5479	2026-05-22 14:00:00	39	20
5489	2026-05-22 14:00:00	40	20
5498	2026-05-22 14:00:00	36	20
5504	2026-05-22 15:00:00	11	20
5516	2026-05-22 15:00:00	13	198
5525	2026-05-22 15:00:00	15	20
5534	2026-05-22 15:00:00	12	28.27
5541	2026-05-22 15:00:00	14	20
5558	2026-05-22 16:00:00	31	20
5567	2026-05-22 16:00:00	34	20
5579	2026-05-22 16:00:00	32	28.35
5584	2026-05-22 16:00:00	35	20
5591	2026-05-22 16:00:00	33	198
5592	2026-05-22 16:00:00	30	20
5608	2026-05-22 17:00:00	46	20
5610	2026-05-22 17:00:00	42	28.37
5614	2026-05-22 17:00:00	49	20
5620	2026-05-22 17:00:00	45	20
5625	2026-05-22 17:00:00	48	198
5630	2026-05-22 17:00:00	43	198
5638	2026-05-22 17:00:00	47	28.41
5642	2026-05-22 17:00:00	44	20
5647	2026-05-22 17:00:00	50	20
5649	2026-05-22 17:00:00	41	20
5652	2026-05-22 18:00:00	11	20
5654	2026-05-22 18:00:00	19	20
5662	2026-05-22 18:00:00	20	20
5667	2026-05-22 18:00:00	13	198
5671	2026-05-22 18:00:00	18	198
5677	2026-05-22 18:00:00	17	28.25
5683	2026-05-22 18:00:00	15	20
5687	2026-05-22 18:00:00	16	20
5692	2026-05-22 18:00:00	12	28.27
5698	2026-05-22 18:00:00	14	20
5706	2026-05-22 19:00:00	11	20
5710	2026-05-22 19:00:00	41	20
5711	2026-05-22 19:00:00	13	198
5719	2026-05-22 19:00:00	42	28.31
5720	2026-05-22 19:00:00	15	20
5731	2026-05-22 19:00:00	12	28.21
5732	2026-05-22 19:00:00	45	20
5740	2026-05-22 19:00:00	14	20
5743	2026-05-22 19:00:00	43	198
5750	2026-05-22 19:00:00	44	20
5756	2026-05-22 20:00:00	42	28.44
5755	2026-05-22 20:00:00	22	28.21
5759	2026-05-22 20:00:00	46	20
4583	2026-05-21 20:00:00	30	20
4595	2026-05-21 20:00:00	27	28.26
4605	2026-05-21 21:00:00	22	28.21
4613	2026-05-21 21:00:00	25	20
4624	2026-05-21 21:00:00	24	20
4636	2026-05-21 21:00:00	23	198
4644	2026-05-21 21:00:00	21	20
4657	2026-05-21 22:00:00	27	28.47
4661	2026-05-21 22:00:00	26	20
4671	2026-05-21 22:00:00	29	20
4676	2026-05-21 22:00:00	28	198
4683	2026-05-21 22:00:00	30	20
4710	2026-05-21 23:00:00	49	20
4718	2026-05-21 23:00:00	48	198
4729	2026-05-21 23:00:00	47	28.31
4736	2026-05-21 23:00:00	50	20
4745	2026-05-21 23:00:00	46	20
4756	2026-05-22 00:00:00	16	20
4768	2026-05-22 00:00:00	19	20
4780	2026-05-22 00:00:00	20	20
4790	2026-05-22 00:00:00	18	198
4797	2026-05-22 00:00:00	17	28.38
4804	2026-05-22 01:00:00	19	20
4817	2026-05-22 01:00:00	20	20
4827	2026-05-22 01:00:00	18	198
4834	2026-05-22 01:00:00	17	28.2
4842	2026-05-22 01:00:00	16	20
4856	2026-05-22 02:00:00	31	20
4866	2026-05-22 02:00:00	34	20
4873	2026-05-22 02:00:00	32	28.39
4879	2026-05-22 02:00:00	35	20
4887	2026-05-22 02:00:00	33	198
4909	2026-05-22 03:00:00	43	198
4918	2026-05-22 03:00:00	44	20
4925	2026-05-22 03:00:00	41	20
4937	2026-05-22 03:00:00	42	28.39
4946	2026-05-22 03:00:00	45	20
4957	2026-05-22 04:00:00	17	28.45
4969	2026-05-22 04:00:00	16	20
4979	2026-05-22 04:00:00	19	20
4987	2026-05-22 04:00:00	20	20
4997	2026-05-22 04:00:00	18	198
5002	2026-05-22 05:00:00	9	20
5011	2026-05-22 05:00:00	6	12
5021	2026-05-22 05:00:00	7	24.44
5031	2026-05-22 05:00:00	8	171.6
5042	2026-05-22 05:00:00	10	20
5059	2026-05-22 06:00:00	49	20
5062	2026-05-22 06:00:00	48	198
5074	2026-05-22 06:00:00	47	28.4
5088	2026-05-22 06:00:00	50	20
5098	2026-05-22 06:00:00	46	20
5105	2026-05-22 07:00:00	17	28.45
5115	2026-05-22 07:00:00	16	20
5128	2026-05-22 07:00:00	19	20
5139	2026-05-22 07:00:00	20	20
5149	2026-05-22 07:00:00	18	198
5153	2026-05-22 08:00:00	11	20
5169	2026-05-22 08:00:00	13	198
5182	2026-05-22 08:00:00	15	20
5188	2026-05-22 08:00:00	12	28.47
5196	2026-05-22 08:00:00	14	20
5203	2026-05-22 09:00:00	21	20
5211	2026-05-22 09:00:00	22	28.29
5220	2026-05-22 09:00:00	25	20
5231	2026-05-22 09:00:00	24	20
5235	2026-05-22 09:00:00	23	198
5257	2026-05-22 10:00:00	50	20
5266	2026-05-22 10:00:00	46	20
5276	2026-05-22 10:00:00	49	20
5285	2026-05-22 10:00:00	48	198
5295	2026-05-22 10:00:00	47	28.2
5305	2026-05-22 11:00:00	16	20
5311	2026-05-22 11:00:00	19	20
5318	2026-05-22 11:00:00	20	20
5325	2026-05-22 11:00:00	18	198
5335	2026-05-22 11:00:00	17	28.24
5358	2026-05-22 12:00:00	48	283.8
5366	2026-05-22 12:00:00	47	41.27
5378	2026-05-22 12:00:00	50	20
5387	2026-05-22 12:00:00	46	46
5396	2026-05-22 12:00:00	49	20
5405	2026-05-22 13:00:00	23	198
5418	2026-05-22 13:00:00	21	20
5424	2026-05-22 13:00:00	22	28.37
5434	2026-05-22 13:00:00	25	20
5442	2026-05-22 13:00:00	24	20
5460	2026-05-22 14:00:00	46	20
5462	2026-05-22 14:00:00	49	20
5471	2026-05-22 14:00:00	48	198
5481	2026-05-22 14:00:00	47	28.2
5491	2026-05-22 14:00:00	50	20
5507	2026-05-22 15:00:00	49	20
5519	2026-05-22 15:00:00	48	198
5532	2026-05-22 15:00:00	47	28.38
5542	2026-05-22 15:00:00	50	20
5549	2026-05-22 15:00:00	46	20
5553	2026-05-22 16:00:00	15	20
5564	2026-05-22 16:00:00	12	28.4
5576	2026-05-22 16:00:00	14	20
5585	2026-05-22 16:00:00	11	20
5593	2026-05-22 16:00:00	7	24.31
5595	2026-05-22 16:00:00	13	198
5605	2026-05-22 17:00:00	24	20
5609	2026-05-22 17:00:00	39	20
5618	2026-05-22 17:00:00	23	198
5619	2026-05-22 17:00:00	40	20
5629	2026-05-22 17:00:00	21	20
5633	2026-05-22 17:00:00	36	20
5639	2026-05-22 17:00:00	22	28.33
5643	2026-05-22 17:00:00	38	198
5646	2026-05-22 17:00:00	25	20
5650	2026-05-22 17:00:00	37	28.48
5653	2026-05-22 18:00:00	5	20
5656	2026-05-22 18:00:00	28	198
5663	2026-05-22 18:00:00	30	20
5666	2026-05-22 18:00:00	1	12
5672	2026-05-22 18:00:00	27	28.3
5678	2026-05-22 18:00:00	26	20
5682	2026-05-22 18:00:00	3	171.6
5690	2026-05-22 18:00:00	29	20
5693	2026-05-22 18:00:00	4	20
5699	2026-05-22 18:00:00	2	24.19
5702	2026-05-22 19:00:00	9	20
5708	2026-05-22 19:00:00	35	20
5714	2026-05-22 19:00:00	6	12
5718	2026-05-22 19:00:00	33	198
5724	2026-05-22 19:00:00	7	24.43
5726	2026-05-22 19:00:00	31	20
5733	2026-05-22 19:00:00	34	20
5737	2026-05-22 19:00:00	8	171.6
5742	2026-05-22 19:00:00	32	28.4
5748	2026-05-22 19:00:00	10	20
5754	2026-05-22 20:00:00	15	20
5763	2026-05-22 20:00:00	25	20
5770	2026-05-22 20:00:00	12	28.29
4584	2026-05-21 20:00:00	14	20
4596	2026-05-21 20:00:00	11	20
4606	2026-05-21 21:00:00	27	28.22
4614	2026-05-21 21:00:00	26	20
4623	2026-05-21 21:00:00	29	20
4632	2026-05-21 21:00:00	28	198
4643	2026-05-21 21:00:00	30	20
4656	2026-05-21 22:00:00	36	20
4669	2026-05-21 22:00:00	38	198
4673	2026-05-21 22:00:00	37	28.48
4685	2026-05-21 22:00:00	39	20
4693	2026-05-21 22:00:00	40	20
4708	2026-05-21 23:00:00	31	20
4711	2026-05-21 23:00:00	34	20
4721	2026-05-21 23:00:00	32	28.26
4728	2026-05-21 23:00:00	35	20
4741	2026-05-21 23:00:00	33	198
4758	2026-05-22 00:00:00	26	20
4769	2026-05-22 00:00:00	29	20
4778	2026-05-22 00:00:00	28	198
4788	2026-05-22 00:00:00	30	20
4800	2026-05-22 00:00:00	27	28.22
4801	2026-05-22 01:00:00	3	171.6
4811	2026-05-22 01:00:00	2	24.39
4823	2026-05-22 01:00:00	4	20
4835	2026-05-22 01:00:00	5	20
4845	2026-05-22 01:00:00	1	12
4854	2026-05-22 02:00:00	28	198
4862	2026-05-22 02:00:00	30	20
4875	2026-05-22 02:00:00	27	28.4
4881	2026-05-22 02:00:00	26	20
4889	2026-05-22 02:00:00	29	20
4908	2026-05-22 03:00:00	36	20
4913	2026-05-22 03:00:00	38	198
4927	2026-05-22 03:00:00	37	28.35
4939	2026-05-22 03:00:00	39	20
4948	2026-05-22 03:00:00	40	20
4951	2026-05-22 04:00:00	1	12
4964	2026-05-22 04:00:00	3	171.6
4974	2026-05-22 04:00:00	2	24.37
4984	2026-05-22 04:00:00	4	20
4994	2026-05-22 04:00:00	5	20
5007	2026-05-22 05:00:00	32	28.2
5017	2026-05-22 05:00:00	35	20
5024	2026-05-22 05:00:00	33	198
5036	2026-05-22 05:00:00	31	20
5048	2026-05-22 05:00:00	34	20
5051	2026-05-22 06:00:00	2	24.2
5061	2026-05-22 06:00:00	4	20
5071	2026-05-22 06:00:00	5	20
5084	2026-05-22 06:00:00	1	12
5094	2026-05-22 06:00:00	3	171.6
5106	2026-05-22 07:00:00	31	20
5114	2026-05-22 07:00:00	34	20
5125	2026-05-22 07:00:00	32	28.42
5133	2026-05-22 07:00:00	35	20
5142	2026-05-22 07:00:00	33	198
5158	2026-05-22 08:00:00	31	20
5168	2026-05-22 08:00:00	34	20
5183	2026-05-22 08:00:00	32	28.33
5193	2026-05-22 08:00:00	35	20
5199	2026-05-22 08:00:00	33	198
5205	2026-05-22 09:00:00	11	20
5215	2026-05-22 09:00:00	13	198
5227	2026-05-22 09:00:00	15	20
5236	2026-05-22 09:00:00	12	28.26
5245	2026-05-22 09:00:00	14	20
5255	2026-05-22 10:00:00	25	20
5265	2026-05-22 10:00:00	24	20
5273	2026-05-22 10:00:00	23	198
5282	2026-05-22 10:00:00	21	20
5290	2026-05-22 10:00:00	22	28.25
5308	2026-05-22 11:00:00	46	20
5314	2026-05-22 11:00:00	49	20
5322	2026-05-22 11:00:00	48	198
5328	2026-05-22 11:00:00	47	28.24
5337	2026-05-22 11:00:00	50	20
5359	2026-05-22 12:00:00	43	283.8
5367	2026-05-22 12:00:00	44	20
5377	2026-05-22 12:00:00	41	46
5385	2026-05-22 12:00:00	42	41.33
5395	2026-05-22 12:00:00	45	20
5406	2026-05-22 13:00:00	33	198
5420	2026-05-22 13:00:00	31	20
5430	2026-05-22 13:00:00	34	20
5439	2026-05-22 13:00:00	32	28.2
5449	2026-05-22 13:00:00	35	20
5452	2026-05-22 14:00:00	10	20
5470	2026-05-22 14:00:00	9	20
5478	2026-05-22 14:00:00	6	12
5483	2026-05-22 14:00:00	7	24.21
5492	2026-05-22 14:00:00	8	171.6
5503	2026-05-22 15:00:00	20	20
5515	2026-05-22 15:00:00	18	198
5529	2026-05-22 15:00:00	17	28.41
5539	2026-05-22 15:00:00	16	20
5547	2026-05-22 15:00:00	19	20
5554	2026-05-22 16:00:00	18	198
5570	2026-05-22 16:00:00	17	28.31
5571	2026-05-22 16:00:00	16	20
5582	2026-05-22 16:00:00	19	20
5594	2026-05-22 16:00:00	20	20
5597	2026-05-22 16:00:00	38	198
5603	2026-05-22 17:00:00	19	20
5606	2026-05-22 17:00:00	33	198
5613	2026-05-22 17:00:00	20	20
5617	2026-05-22 17:00:00	31	20
5621	2026-05-22 17:00:00	18	198
5628	2026-05-22 17:00:00	17	28.33
5631	2026-05-22 17:00:00	34	20
5635	2026-05-22 17:00:00	16	20
5637	2026-05-22 17:00:00	32	28.26
5648	2026-05-22 17:00:00	35	20
5651	2026-05-22 18:00:00	6	12
5660	2026-05-22 18:00:00	50	20
5661	2026-05-22 18:00:00	7	24.23
5668	2026-05-22 18:00:00	8	171.6
5670	2026-05-22 18:00:00	46	20
5676	2026-05-22 18:00:00	10	20
5681	2026-05-22 18:00:00	49	20
5684	2026-05-22 18:00:00	9	20
5689	2026-05-22 18:00:00	48	198
5696	2026-05-22 18:00:00	47	28.36
5703	2026-05-22 19:00:00	37	28.49
5705	2026-05-22 19:00:00	19	20
5712	2026-05-22 19:00:00	20	20
5717	2026-05-22 19:00:00	39	20
5721	2026-05-22 19:00:00	18	198
5727	2026-05-22 19:00:00	17	28.26
5729	2026-05-22 19:00:00	40	20
5735	2026-05-22 19:00:00	16	20
5739	2026-05-22 19:00:00	36	20
5747	2026-05-22 19:00:00	38	198
5753	2026-05-22 20:00:00	18	198
5764	2026-05-22 20:00:00	45	20
5768	2026-05-22 20:00:00	17	28.23
4585	2026-05-21 20:00:00	41	20
4594	2026-05-21 20:00:00	42	28.27
4608	2026-05-21 21:00:00	31	20
4619	2026-05-21 21:00:00	34	20
4630	2026-05-21 21:00:00	32	28.49
4639	2026-05-21 21:00:00	35	20
4648	2026-05-21 21:00:00	33	198
4653	2026-05-21 22:00:00	9	20
4667	2026-05-21 22:00:00	6	12
4680	2026-05-21 22:00:00	7	24.28
4688	2026-05-21 22:00:00	8	171.6
4697	2026-05-21 22:00:00	10	20
4702	2026-05-21 23:00:00	8	171.6
4715	2026-05-21 23:00:00	10	20
4725	2026-05-21 23:00:00	9	20
4734	2026-05-21 23:00:00	6	12
4739	2026-05-21 23:00:00	7	24.33
4759	2026-05-22 00:00:00	45	20
4765	2026-05-22 00:00:00	43	198
4772	2026-05-22 00:00:00	44	20
4781	2026-05-22 00:00:00	41	20
4791	2026-05-22 00:00:00	42	28.42
4806	2026-05-22 01:00:00	38	198
4814	2026-05-22 01:00:00	37	28.37
4822	2026-05-22 01:00:00	39	20
4833	2026-05-22 01:00:00	40	20
4844	2026-05-22 01:00:00	36	20
4860	2026-05-22 02:00:00	41	20
4867	2026-05-22 02:00:00	42	28.43
4874	2026-05-22 02:00:00	45	20
4880	2026-05-22 02:00:00	43	198
4888	2026-05-22 02:00:00	44	20
4907	2026-05-22 03:00:00	35	20
4915	2026-05-22 03:00:00	33	198
4928	2026-05-22 03:00:00	31	20
4936	2026-05-22 03:00:00	34	20
4945	2026-05-22 03:00:00	32	28.38
4958	2026-05-22 04:00:00	27	28.39
4968	2026-05-22 04:00:00	26	20
4980	2026-05-22 04:00:00	29	20
4989	2026-05-22 04:00:00	28	198
4998	2026-05-22 04:00:00	30	20
5004	2026-05-22 05:00:00	22	28.26
5014	2026-05-22 05:00:00	25	20
5027	2026-05-22 05:00:00	24	20
5038	2026-05-22 05:00:00	23	198
5050	2026-05-22 05:00:00	21	20
5056	2026-05-22 06:00:00	7	24.29
5069	2026-05-22 06:00:00	8	171.6
5078	2026-05-22 06:00:00	10	20
5089	2026-05-22 06:00:00	9	20
5100	2026-05-22 06:00:00	6	12
5101	2026-05-22 07:00:00	1	12
5111	2026-05-22 07:00:00	3	171.6
5127	2026-05-22 07:00:00	2	24.38
5137	2026-05-22 07:00:00	4	20
5146	2026-05-22 07:00:00	5	20
5157	2026-05-22 08:00:00	28	198
5163	2026-05-22 08:00:00	30	20
5173	2026-05-22 08:00:00	27	28.37
5178	2026-05-22 08:00:00	26	20
5190	2026-05-22 08:00:00	29	20
5204	2026-05-22 09:00:00	31	20
5213	2026-05-22 09:00:00	34	20
5222	2026-05-22 09:00:00	32	28.24
5233	2026-05-22 09:00:00	35	20
5248	2026-05-22 09:00:00	33	198
5253	2026-05-22 10:00:00	17	28.38
5262	2026-05-22 10:00:00	16	20
5274	2026-05-22 10:00:00	19	20
5288	2026-05-22 10:00:00	20	20
5298	2026-05-22 10:00:00	18	198
5309	2026-05-22 11:00:00	26	20
5320	2026-05-22 11:00:00	29	20
5330	2026-05-22 11:00:00	28	198
5339	2026-05-22 11:00:00	30	20
5348	2026-05-22 11:00:00	27	28.39
5352	2026-05-22 12:00:00	9	20
5362	2026-05-22 12:00:00	6	12
5373	2026-05-22 12:00:00	7	24.4
5383	2026-05-22 12:00:00	8	171.6
5392	2026-05-22 12:00:00	10	20
5409	2026-05-22 13:00:00	46	20
5416	2026-05-22 13:00:00	49	20
5427	2026-05-22 13:00:00	48	198
5438	2026-05-22 13:00:00	47	28.25
5448	2026-05-22 13:00:00	50	20
5453	2026-05-22 14:00:00	11	20
5468	2026-05-22 14:00:00	13	198
5477	2026-05-22 14:00:00	15	20
5488	2026-05-22 14:00:00	12	28.34
5497	2026-05-22 14:00:00	14	20
5505	2026-05-22 15:00:00	35	20
5517	2026-05-22 15:00:00	33	198
5526	2026-05-22 15:00:00	31	20
5535	2026-05-22 15:00:00	34	20
5540	2026-05-22 15:00:00	32	28.3
5560	2026-05-22 16:00:00	48	198
5561	2026-05-22 16:00:00	47	28.34
5575	2026-05-22 16:00:00	50	20
5588	2026-05-22 16:00:00	46	20
5596	2026-05-22 16:00:00	49	20
5598	2026-05-22 16:00:00	1	12
5601	2026-05-22 17:00:00	6	12
5607	2026-05-22 17:00:00	28	198
5612	2026-05-22 17:00:00	30	20
5615	2026-05-22 17:00:00	7	24.34
5623	2026-05-22 17:00:00	27	28.44
5624	2026-05-22 17:00:00	8	171.6
5632	2026-05-22 17:00:00	10	20
5634	2026-05-22 17:00:00	26	20
5641	2026-05-22 17:00:00	9	20
5644	2026-05-22 17:00:00	29	20
5657	2026-05-22 18:00:00	35	20
5659	2026-05-22 18:00:00	41	20
5664	2026-05-22 18:00:00	33	198
5669	2026-05-22 18:00:00	42	28.36
5673	2026-05-22 18:00:00	31	20
5679	2026-05-22 18:00:00	34	20
5680	2026-05-22 18:00:00	45	20
5686	2026-05-22 18:00:00	32	28.32
5688	2026-05-22 18:00:00	43	198
5694	2026-05-22 18:00:00	44	20
5707	2026-05-22 19:00:00	28	198
5709	2026-05-22 19:00:00	50	20
5716	2026-05-22 19:00:00	30	20
5722	2026-05-22 19:00:00	46	20
5728	2026-05-22 19:00:00	49	20
5730	2026-05-22 19:00:00	27	28.25
5736	2026-05-22 19:00:00	48	198
5741	2026-05-22 19:00:00	26	20
5746	2026-05-22 19:00:00	47	28.19
5749	2026-05-22 19:00:00	29	20
5757	2026-05-22 20:00:00	33	198
5766	2026-05-22 20:00:00	49	20
5769	2026-05-22 20:00:00	31	20
4590	2026-05-21 20:00:00	6	12
4598	2026-05-21 20:00:00	7	24.36
4603	2026-05-21 21:00:00	11	20
4611	2026-05-21 21:00:00	13	198
4622	2026-05-21 21:00:00	15	20
4635	2026-05-21 21:00:00	12	28.25
4646	2026-05-21 21:00:00	14	20
4654	2026-05-21 22:00:00	22	28.32
4668	2026-05-21 22:00:00	25	20
4681	2026-05-21 22:00:00	24	20
4690	2026-05-21 22:00:00	23	198
4696	2026-05-21 22:00:00	21	20
4707	2026-05-21 23:00:00	27	28.39
4717	2026-05-21 23:00:00	26	20
4727	2026-05-21 23:00:00	29	20
4740	2026-05-21 23:00:00	28	198
4749	2026-05-21 23:00:00	30	20
4760	2026-05-22 00:00:00	38	198
4771	2026-05-22 00:00:00	37	28.41
4782	2026-05-22 00:00:00	39	20
4793	2026-05-22 00:00:00	40	20
4799	2026-05-22 00:00:00	36	20
4802	2026-05-22 01:00:00	6	12
4816	2026-05-22 01:00:00	7	24.48
4826	2026-05-22 01:00:00	8	171.6
4836	2026-05-22 01:00:00	10	20
4846	2026-05-22 01:00:00	9	20
4852	2026-05-22 02:00:00	8	171.6
4863	2026-05-22 02:00:00	10	20
4876	2026-05-22 02:00:00	9	20
4891	2026-05-22 02:00:00	6	12
4897	2026-05-22 02:00:00	7	24.47
4904	2026-05-22 03:00:00	17	28.33
4911	2026-05-22 03:00:00	16	20
4917	2026-05-22 03:00:00	19	20
4922	2026-05-22 03:00:00	20	20
4932	2026-05-22 03:00:00	18	198
4959	2026-05-22 04:00:00	46	20
4961	2026-05-22 04:00:00	49	20
4971	2026-05-22 04:00:00	48	198
4976	2026-05-22 04:00:00	47	28.27
4988	2026-05-22 04:00:00	50	20
5008	2026-05-22 05:00:00	46	20
5018	2026-05-22 05:00:00	49	20
5029	2026-05-22 05:00:00	48	198
5039	2026-05-22 05:00:00	47	28.2
5046	2026-05-22 05:00:00	50	20
5052	2026-05-22 06:00:00	25	20
5067	2026-05-22 06:00:00	24	20
5076	2026-05-22 06:00:00	23	198
5082	2026-05-22 06:00:00	21	20
5092	2026-05-22 06:00:00	22	28.31
5108	2026-05-22 07:00:00	45	20
5117	2026-05-22 07:00:00	43	198
5123	2026-05-22 07:00:00	44	20
5131	2026-05-22 07:00:00	41	20
5141	2026-05-22 07:00:00	42	28.2
5155	2026-05-22 08:00:00	21	20
5164	2026-05-22 08:00:00	22	28.2
5174	2026-05-22 08:00:00	25	20
5181	2026-05-22 08:00:00	24	20
5186	2026-05-22 08:00:00	23	198
5206	2026-05-22 09:00:00	42	28.42
5217	2026-05-22 09:00:00	45	20
5228	2026-05-22 09:00:00	43	198
5237	2026-05-22 09:00:00	44	20
5244	2026-05-22 09:00:00	41	20
5256	2026-05-22 10:00:00	32	28.31
5261	2026-05-22 10:00:00	35	20
5269	2026-05-22 10:00:00	33	198
5278	2026-05-22 10:00:00	31	20
5291	2026-05-22 10:00:00	34	20
5307	2026-05-22 11:00:00	38	198
5319	2026-05-22 11:00:00	37	28.27
5326	2026-05-22 11:00:00	39	20
5336	2026-05-22 11:00:00	40	20
5345	2026-05-22 11:00:00	36	20
5356	2026-05-22 12:00:00	30	20
5368	2026-05-22 12:00:00	27	41.36
5380	2026-05-22 12:00:00	26	46
5390	2026-05-22 12:00:00	29	20
5400	2026-05-22 12:00:00	28	283.8
5404	2026-05-22 13:00:00	19	20
5411	2026-05-22 13:00:00	20	20
5423	2026-05-22 13:00:00	18	198
5436	2026-05-22 13:00:00	17	28.23
5446	2026-05-22 13:00:00	16	20
5454	2026-05-22 14:00:00	19	20
5465	2026-05-22 14:00:00	20	20
5472	2026-05-22 14:00:00	18	198
5482	2026-05-22 14:00:00	17	28.48
5494	2026-05-22 14:00:00	16	20
5508	2026-05-22 15:00:00	42	28.35
5511	2026-05-22 15:00:00	45	20
5520	2026-05-22 15:00:00	43	198
5527	2026-05-22 15:00:00	44	20
5537	2026-05-22 15:00:00	41	20
5559	2026-05-22 16:00:00	43	198
5569	2026-05-22 16:00:00	44	20
5580	2026-05-22 16:00:00	41	20
5590	2026-05-22 16:00:00	42	28.39
5600	2026-05-22 16:00:00	45	20
5602	2026-05-22 17:00:00	5	20
5611	2026-05-22 17:00:00	1	12
5622	2026-05-22 17:00:00	3	171.6
5627	2026-05-22 17:00:00	4	20
5640	2026-05-22 17:00:00	2	24.22
5655	2026-05-22 18:00:00	37	28.22
5675	2026-05-22 18:00:00	39	20
5691	2026-05-22 18:00:00	40	20
5697	2026-05-22 18:00:00	36	20
5700	2026-05-22 18:00:00	38	198
5701	2026-05-22 19:00:00	1	12
5715	2026-05-22 19:00:00	3	171.6
5725	2026-05-22 19:00:00	4	20
5738	2026-05-22 19:00:00	2	24.24
5745	2026-05-22 19:00:00	5	20
5751	2026-05-22 20:00:00	4	20
5758	2026-05-22 20:00:00	30	20
5761	2026-05-22 20:00:00	2	24.3
5762	2026-05-22 20:00:00	27	28.48
5771	2026-05-22 20:00:00	16	20
5773	2026-05-22 20:00:00	26	20
5774	2026-05-22 20:00:00	24	20
5775	2026-05-22 20:00:00	5	20
5777	2026-05-22 20:00:00	48	198
5782	2026-05-22 20:00:00	19	20
5783	2026-05-22 20:00:00	29	20
5784	2026-05-22 20:00:00	23	198
5786	2026-05-22 20:00:00	1	12
5789	2026-05-22 20:00:00	47	28.44
5792	2026-05-22 20:00:00	20	20
5794	2026-05-22 20:00:00	28	198
5796	2026-05-22 20:00:00	21	20
5797	2026-05-22 20:00:00	3	171.6
5798	2026-05-22 20:00:00	50	20
4591	2026-05-21 20:00:00	49	20
4600	2026-05-21 20:00:00	48	198
4602	2026-05-21 21:00:00	6	12
4612	2026-05-21 21:00:00	7	24.23
4625	2026-05-21 21:00:00	8	171.6
4637	2026-05-21 21:00:00	10	20
4649	2026-05-21 21:00:00	9	20
4655	2026-05-21 22:00:00	18	198
4665	2026-05-21 22:00:00	17	28.43
4678	2026-05-21 22:00:00	16	20
4686	2026-05-21 22:00:00	19	20
4694	2026-05-21 22:00:00	20	20
4709	2026-05-21 23:00:00	36	20
4720	2026-05-21 23:00:00	38	198
4730	2026-05-21 23:00:00	37	28.37
4737	2026-05-21 23:00:00	39	20
4747	2026-05-21 23:00:00	40	20
5240	2026-05-22 09:00:00	26	20
5247	2026-05-22 09:00:00	29	20
5254	2026-05-22 10:00:00	27	28.43
5264	2026-05-22 10:00:00	26	20
5272	2026-05-22 10:00:00	29	20
5281	2026-05-22 10:00:00	28	198
5289	2026-05-22 10:00:00	30	20
5310	2026-05-22 11:00:00	45	20
5321	2026-05-22 11:00:00	43	198
5334	2026-05-22 11:00:00	44	20
5343	2026-05-22 11:00:00	41	20
5349	2026-05-22 11:00:00	42	28.45
5351	2026-05-22 12:00:00	1	12
5363	2026-05-22 12:00:00	3	171.6
5374	2026-05-22 12:00:00	2	24.23
5386	2026-05-22 12:00:00	4	20
5397	2026-05-22 12:00:00	5	20
5403	2026-05-22 13:00:00	4	20
5414	2026-05-22 13:00:00	5	20
5422	2026-05-22 13:00:00	1	12
5432	2026-05-22 13:00:00	3	171.6
5444	2026-05-22 13:00:00	2	24.34
5457	2026-05-22 14:00:00	35	20
5466	2026-05-22 14:00:00	33	198
5475	2026-05-22 14:00:00	31	20
5485	2026-05-22 14:00:00	34	20
5495	2026-05-22 14:00:00	32	28.25
5509	2026-05-22 15:00:00	21	20
5513	2026-05-22 15:00:00	22	28.36
5522	2026-05-22 15:00:00	25	20
5530	2026-05-22 15:00:00	24	20
5543	2026-05-22 15:00:00	23	198
5555	2026-05-22 16:00:00	21	20
5568	2026-05-22 16:00:00	22	28.48
5578	2026-05-22 16:00:00	25	20
5589	2026-05-22 16:00:00	24	20
5599	2026-05-22 16:00:00	23	198
5604	2026-05-22 17:00:00	11	20
5616	2026-05-22 17:00:00	13	198
5626	2026-05-22 17:00:00	15	20
5636	2026-05-22 17:00:00	12	28.42
5645	2026-05-22 17:00:00	14	20
5658	2026-05-22 18:00:00	24	20
5665	2026-05-22 18:00:00	23	198
5674	2026-05-22 18:00:00	21	20
5685	2026-05-22 18:00:00	22	28.44
5695	2026-05-22 18:00:00	25	20
5704	2026-05-22 19:00:00	24	20
5713	2026-05-22 19:00:00	23	198
5723	2026-05-22 19:00:00	21	20
5734	2026-05-22 19:00:00	22	28.37
5744	2026-05-22 19:00:00	25	20
5752	2026-05-22 20:00:00	7	24.37
5760	2026-05-22 20:00:00	40	20
5765	2026-05-22 20:00:00	8	171.6
5767	2026-05-22 20:00:00	36	20
5772	2026-05-22 20:00:00	34	20
5776	2026-05-22 20:00:00	43	198
5778	2026-05-22 20:00:00	10	20
5779	2026-05-22 20:00:00	38	198
5780	2026-05-22 20:00:00	14	20
5781	2026-05-22 20:00:00	32	28.24
5785	2026-05-22 20:00:00	37	28.27
5787	2026-05-22 20:00:00	9	20
5788	2026-05-22 20:00:00	44	20
5790	2026-05-22 20:00:00	11	20
5791	2026-05-22 20:00:00	35	20
5793	2026-05-22 20:00:00	6	12
5795	2026-05-22 20:00:00	39	20
5799	2026-05-22 20:00:00	13	198
5800	2026-05-22 20:00:00	41	20
5801	2026-05-22 21:00:00	1	12
5802	2026-05-22 21:00:00	9	20
5803	2026-05-22 21:00:00	19	20
5804	2026-05-22 21:00:00	14	20
5807	2026-05-22 21:00:00	29	20
5805	2026-05-22 21:00:00	23	198
5806	2026-05-22 21:00:00	37	28.37
5808	2026-05-22 21:00:00	33	198
5809	2026-05-22 21:00:00	47	28.34
5810	2026-05-22 21:00:00	44	20
5811	2026-05-22 21:00:00	20	20
5812	2026-05-22 21:00:00	28	198
5813	2026-05-22 21:00:00	21	20
5814	2026-05-22 21:00:00	6	12
5815	2026-05-22 21:00:00	3	171.6
5816	2026-05-22 21:00:00	39	20
5817	2026-05-22 21:00:00	11	20
5818	2026-05-22 21:00:00	31	20
5819	2026-05-22 21:00:00	50	20
5820	2026-05-22 21:00:00	18	198
5821	2026-05-22 21:00:00	41	20
5822	2026-05-22 21:00:00	22	28.24
5823	2026-05-22 21:00:00	30	20
5824	2026-05-22 21:00:00	13	198
5825	2026-05-22 21:00:00	4	20
5826	2026-05-22 21:00:00	7	24.25
5827	2026-05-22 21:00:00	42	28.43
5828	2026-05-22 21:00:00	34	20
5829	2026-05-22 21:00:00	46	20
5830	2026-05-22 21:00:00	40	20
5831	2026-05-22 21:00:00	17	28.42
5832	2026-05-22 21:00:00	45	20
5833	2026-05-22 21:00:00	25	20
5834	2026-05-22 21:00:00	27	28.24
5835	2026-05-22 21:00:00	2	24.28
5836	2026-05-22 21:00:00	32	28.48
5837	2026-05-22 21:00:00	15	20
5838	2026-05-22 21:00:00	8	171.6
5839	2026-05-22 21:00:00	49	20
5840	2026-05-22 21:00:00	36	20
5841	2026-05-22 21:00:00	16	20
5842	2026-05-22 21:00:00	43	198
5843	2026-05-22 21:00:00	24	20
5844	2026-05-22 21:00:00	26	20
5845	2026-05-22 21:00:00	35	20
5846	2026-05-22 21:00:00	48	198
5847	2026-05-22 21:00:00	5	20
5848	2026-05-22 21:00:00	12	28.25
5849	2026-05-22 21:00:00	10	20
5851	2026-05-22 22:00:00	5	20
5864	2026-05-22 22:00:00	1	12
5874	2026-05-22 22:00:00	3	171.6
5884	2026-05-22 22:00:00	4	20
5894	2026-05-22 22:00:00	2	24.24
5903	2026-05-22 23:00:00	26	20
5915	2026-05-22 23:00:00	29	20
5922	2026-05-22 23:00:00	28	198
5933	2026-05-22 23:00:00	30	20
5944	2026-05-22 23:00:00	27	28.23
5957	2026-05-23 00:00:00	28	198
5963	2026-05-23 00:00:00	30	20
5974	2026-05-23 00:00:00	27	28.43
5984	2026-05-23 00:00:00	26	20
5994	2026-05-23 00:00:00	29	20
6008	2026-05-23 01:00:00	42	28.2
6020	2026-05-23 01:00:00	45	20
6031	2026-05-23 01:00:00	43	198
6038	2026-05-23 01:00:00	44	20
6047	2026-05-23 01:00:00	41	20
6056	2026-05-23 02:00:00	20	20
6064	2026-05-23 02:00:00	18	198
6074	2026-05-23 02:00:00	17	28.19
6086	2026-05-23 02:00:00	16	20
6094	2026-05-23 02:00:00	19	20
6109	2026-05-23 03:00:00	39	20
6117	2026-05-23 03:00:00	40	20
6126	2026-05-23 03:00:00	36	20
6141	2026-05-23 03:00:00	38	198
6149	2026-05-23 03:00:00	37	28.24
6154	2026-05-23 04:00:00	6	12
6167	2026-05-23 04:00:00	7	24.32
6179	2026-05-23 04:00:00	8	171.6
6189	2026-05-23 04:00:00	10	20
6197	2026-05-23 04:00:00	9	20
6202	2026-05-23 05:00:00	8	171.6
6216	2026-05-23 05:00:00	10	20
6228	2026-05-23 05:00:00	9	20
6240	2026-05-23 05:00:00	6	12
6248	2026-05-23 05:00:00	7	24.39
6254	2026-05-23 06:00:00	13	198
6261	2026-05-23 06:00:00	15	20
6267	2026-05-23 06:00:00	12	28.25
6275	2026-05-23 06:00:00	14	20
6288	2026-05-23 06:00:00	11	20
6310	2026-05-23 07:00:00	48	198
6321	2026-05-23 07:00:00	47	28.36
6334	2026-05-23 07:00:00	50	20
6344	2026-05-23 07:00:00	46	20
6350	2026-05-23 07:00:00	49	20
6351	2026-05-23 08:00:00	10	20
6363	2026-05-23 08:00:00	9	20
6378	2026-05-23 08:00:00	6	12
6388	2026-05-23 08:00:00	7	24.45
6396	2026-05-23 08:00:00	8	171.6
6404	2026-05-23 09:00:00	29	20
6418	2026-05-23 09:00:00	28	198
6427	2026-05-23 09:00:00	30	20
6436	2026-05-23 09:00:00	27	28.4
6446	2026-05-23 09:00:00	26	20
6454	2026-05-23 10:00:00	21	20
6465	2026-05-23 10:00:00	22	28.23
6476	2026-05-23 10:00:00	25	20
6481	2026-05-23 10:00:00	24	20
6491	2026-05-23 10:00:00	23	198
6510	2026-05-23 11:00:00	48	198
6520	2026-05-23 11:00:00	47	28.23
6532	2026-05-23 11:00:00	50	20
6545	2026-05-23 11:00:00	46	20
6550	2026-05-23 11:00:00	49	20
6551	2026-05-23 12:00:00	1	12
6561	2026-05-23 12:00:00	3	171.6
6574	2026-05-23 12:00:00	4	20
6585	2026-05-23 12:00:00	2	24.33
6595	2026-05-23 12:00:00	5	20
6604	2026-05-23 13:00:00	26	20
6614	2026-05-23 13:00:00	29	20
6626	2026-05-23 13:00:00	28	198
6636	2026-05-23 13:00:00	30	20
6643	2026-05-23 13:00:00	27	28.43
6659	2026-05-23 14:00:00	44	20
6669	2026-05-23 14:00:00	43	198
6678	2026-05-23 14:00:00	41	20
6685	2026-05-23 14:00:00	42	28.41
6695	2026-05-23 14:00:00	45	20
6703	2026-05-23 15:00:00	26	20
6721	2026-05-23 15:00:00	29	20
6727	2026-05-23 15:00:00	28	198
6736	2026-05-23 15:00:00	30	20
6742	2026-05-23 15:00:00	27	28.3
7251	2026-05-24 02:00:00	3	171.6
7263	2026-05-24 02:00:00	4	20
7274	2026-05-24 02:00:00	2	24.34
7283	2026-05-24 02:00:00	5	20
7291	2026-05-24 02:00:00	1	12
7308	2026-05-24 03:00:00	36	20
7315	2026-05-24 03:00:00	38	198
7330	2026-05-24 03:00:00	37	28.37
7344	2026-05-24 03:00:00	39	20
7350	2026-05-24 03:00:00	40	20
7353	2026-05-24 04:00:00	8	171.6
7363	2026-05-24 04:00:00	10	20
7372	2026-05-24 04:00:00	9	20
7381	2026-05-24 04:00:00	6	12
7393	2026-05-24 04:00:00	7	24.24
7407	2026-05-24 05:00:00	26	20
7415	2026-05-24 05:00:00	29	20
7427	2026-05-24 05:00:00	28	198
7437	2026-05-24 05:00:00	30	20
7446	2026-05-24 05:00:00	27	28.36
7457	2026-05-24 06:00:00	33	198
7470	2026-05-24 06:00:00	31	20
7480	2026-05-24 06:00:00	34	20
7491	2026-05-24 06:00:00	32	28.43
7500	2026-05-24 06:00:00	35	20
7502	2026-05-24 07:00:00	1	12
7520	2026-05-24 07:00:00	3	171.6
7532	2026-05-24 07:00:00	4	20
7544	2026-05-24 07:00:00	2	24.38
7550	2026-05-24 07:00:00	5	20
7559	2026-05-24 08:00:00	2	24.33
7567	2026-05-24 08:00:00	5	20
7577	2026-05-24 08:00:00	1	12
7588	2026-05-24 08:00:00	3	171.6
7594	2026-05-24 08:00:00	4	20
7607	2026-05-24 09:00:00	34	20
7617	2026-05-24 09:00:00	32	28.36
7628	2026-05-24 09:00:00	35	20
7640	2026-05-24 09:00:00	33	198
7649	2026-05-24 09:00:00	31	20
7653	2026-05-24 10:00:00	6	12
7669	2026-05-24 10:00:00	7	24.21
7678	2026-05-24 10:00:00	8	171.6
7691	2026-05-24 10:00:00	10	20
7700	2026-05-24 10:00:00	9	20
5850	2026-05-22 21:00:00	38	198
5852	2026-05-22 22:00:00	10	20
5865	2026-05-22 22:00:00	9	20
5876	2026-05-22 22:00:00	6	12
5886	2026-05-22 22:00:00	7	24.23
5892	2026-05-22 22:00:00	8	171.6
5909	2026-05-22 23:00:00	43	198
5914	2026-05-22 23:00:00	44	20
5923	2026-05-22 23:00:00	41	20
5932	2026-05-22 23:00:00	42	28.31
5943	2026-05-22 23:00:00	45	20
5956	2026-05-23 00:00:00	23	198
5962	2026-05-23 00:00:00	21	20
5971	2026-05-23 00:00:00	22	28.33
5982	2026-05-23 00:00:00	25	20
5992	2026-05-23 00:00:00	24	20
6009	2026-05-23 01:00:00	40	20
6018	2026-05-23 01:00:00	36	20
6027	2026-05-23 01:00:00	38	198
6034	2026-05-23 01:00:00	37	28.37
6041	2026-05-23 01:00:00	39	20
6060	2026-05-23 02:00:00	45	20
6071	2026-05-23 02:00:00	43	198
6077	2026-05-23 02:00:00	44	20
6090	2026-05-23 02:00:00	41	20
6096	2026-05-23 02:00:00	42	28.3
6104	2026-05-23 03:00:00	25	20
6115	2026-05-23 03:00:00	24	20
6123	2026-05-23 03:00:00	23	198
6136	2026-05-23 03:00:00	21	20
6146	2026-05-23 03:00:00	22	28.32
6153	2026-05-23 04:00:00	24	20
6161	2026-05-23 04:00:00	23	198
6171	2026-05-23 04:00:00	21	20
6176	2026-05-23 04:00:00	22	28.19
6186	2026-05-23 04:00:00	25	20
6209	2026-05-23 05:00:00	47	28.46
6220	2026-05-23 05:00:00	50	20
6231	2026-05-23 05:00:00	46	20
6239	2026-05-23 05:00:00	49	20
6249	2026-05-23 05:00:00	48	198
6252	2026-05-23 06:00:00	1	12
6265	2026-05-23 06:00:00	3	171.6
6276	2026-05-23 06:00:00	4	20
6286	2026-05-23 06:00:00	2	24.31
6296	2026-05-23 06:00:00	5	20
6303	2026-05-23 07:00:00	15	20
6317	2026-05-23 07:00:00	12	28.43
6329	2026-05-23 07:00:00	14	20
6340	2026-05-23 07:00:00	11	20
6347	2026-05-23 07:00:00	13	198
6354	2026-05-23 08:00:00	20	20
6364	2026-05-23 08:00:00	18	198
6380	2026-05-23 08:00:00	17	28.34
6393	2026-05-23 08:00:00	16	20
6400	2026-05-23 08:00:00	19	20
6401	2026-05-23 09:00:00	4	20
6411	2026-05-23 09:00:00	2	24.22
6424	2026-05-23 09:00:00	5	20
6437	2026-05-23 09:00:00	1	12
6445	2026-05-23 09:00:00	3	171.6
6453	2026-05-23 10:00:00	31	20
6467	2026-05-23 10:00:00	34	20
6477	2026-05-23 10:00:00	32	28.29
6486	2026-05-23 10:00:00	35	20
6492	2026-05-23 10:00:00	33	198
6509	2026-05-23 11:00:00	41	20
6515	2026-05-23 11:00:00	42	28.46
6522	2026-05-23 11:00:00	45	20
6533	2026-05-23 11:00:00	44	20
6544	2026-05-23 11:00:00	43	198
6556	2026-05-23 12:00:00	30	20
6569	2026-05-23 12:00:00	27	41.25
6582	2026-05-23 12:00:00	26	46
6593	2026-05-23 12:00:00	29	20
6599	2026-05-23 12:00:00	28	283.8
6602	2026-05-23 13:00:00	6	12
6612	2026-05-23 13:00:00	7	24.36
6625	2026-05-23 13:00:00	8	171.6
6638	2026-05-23 13:00:00	10	20
6647	2026-05-23 13:00:00	9	20
6654	2026-05-23 14:00:00	22	28.39
6668	2026-05-23 14:00:00	25	20
6679	2026-05-23 14:00:00	24	20
6686	2026-05-23 14:00:00	23	198
6694	2026-05-23 14:00:00	21	20
6707	2026-05-23 15:00:00	38	198
6722	2026-05-23 15:00:00	37	28.38
6738	2026-05-23 15:00:00	39	20
6743	2026-05-23 15:00:00	40	20
6747	2026-05-23 15:00:00	36	20
7252	2026-05-24 02:00:00	6	12
7261	2026-05-24 02:00:00	7	24.28
7273	2026-05-24 02:00:00	8	171.6
7285	2026-05-24 02:00:00	10	20
7296	2026-05-24 02:00:00	9	20
7303	2026-05-24 03:00:00	22	28.21
7312	2026-05-24 03:00:00	25	20
7320	2026-05-24 03:00:00	24	20
7326	2026-05-24 03:00:00	23	198
7337	2026-05-24 03:00:00	21	20
7359	2026-05-24 04:00:00	49	20
7364	2026-05-24 04:00:00	48	198
7373	2026-05-24 04:00:00	47	28.45
7383	2026-05-24 04:00:00	50	20
7395	2026-05-24 04:00:00	46	20
7405	2026-05-24 05:00:00	22	28.42
7418	2026-05-24 05:00:00	25	20
7429	2026-05-24 05:00:00	24	20
7440	2026-05-24 05:00:00	23	198
7445	2026-05-24 05:00:00	21	20
7455	2026-05-24 06:00:00	19	20
7461	2026-05-24 06:00:00	20	20
7471	2026-05-24 06:00:00	18	198
7479	2026-05-24 06:00:00	16	20
7488	2026-05-24 06:00:00	17	28.19
7510	2026-05-24 07:00:00	46	20
7513	2026-05-24 07:00:00	49	20
7524	2026-05-24 07:00:00	48	198
7536	2026-05-24 07:00:00	47	28.29
7543	2026-05-24 07:00:00	50	20
7551	2026-05-24 08:00:00	34	20
7564	2026-05-24 08:00:00	32	28.3
7574	2026-05-24 08:00:00	35	20
7585	2026-05-24 08:00:00	33	198
7596	2026-05-24 08:00:00	31	20
7605	2026-05-24 09:00:00	18	198
7619	2026-05-24 09:00:00	16	20
7621	2026-05-24 09:00:00	17	28.46
7631	2026-05-24 09:00:00	19	20
7638	2026-05-24 09:00:00	20	20
7659	2026-05-24 10:00:00	46	20
7668	2026-05-24 10:00:00	49	20
7673	2026-05-24 10:00:00	48	198
7681	2026-05-24 10:00:00	47	28.44
7688	2026-05-24 10:00:00	50	20
5854	2026-05-22 22:00:00	16	20
5862	2026-05-22 22:00:00	19	20
5871	2026-05-22 22:00:00	20	20
5881	2026-05-22 22:00:00	18	198
5891	2026-05-22 22:00:00	17	28.2
5910	2026-05-22 23:00:00	48	198
5913	2026-05-22 23:00:00	47	28.31
5925	2026-05-22 23:00:00	50	20
5935	2026-05-22 23:00:00	46	20
5945	2026-05-22 23:00:00	49	20
5954	2026-05-23 00:00:00	37	28.46
5967	2026-05-23 00:00:00	39	20
5978	2026-05-23 00:00:00	40	20
5990	2026-05-23 00:00:00	36	20
5999	2026-05-23 00:00:00	38	198
6002	2026-05-23 01:00:00	7	24.22
6016	2026-05-23 01:00:00	8	171.6
6029	2026-05-23 01:00:00	10	20
6043	2026-05-23 01:00:00	9	20
6049	2026-05-23 01:00:00	6	12
6052	2026-05-23 02:00:00	13	198
6065	2026-05-23 02:00:00	15	20
6079	2026-05-23 02:00:00	12	28.24
6088	2026-05-23 02:00:00	14	20
6095	2026-05-23 02:00:00	11	20
6106	2026-05-23 03:00:00	27	28.32
6112	2026-05-23 03:00:00	26	20
6122	2026-05-23 03:00:00	29	20
6127	2026-05-23 03:00:00	28	198
6133	2026-05-23 03:00:00	30	20
6155	2026-05-23 04:00:00	46	20
6163	2026-05-23 04:00:00	49	20
6173	2026-05-23 04:00:00	48	198
6180	2026-05-23 04:00:00	47	28.27
6187	2026-05-23 04:00:00	50	20
6206	2026-05-23 05:00:00	38	198
6218	2026-05-23 05:00:00	37	28.28
6223	2026-05-23 05:00:00	39	20
6229	2026-05-23 05:00:00	40	20
6234	2026-05-23 05:00:00	36	20
6259	2026-05-23 06:00:00	49	20
6266	2026-05-23 06:00:00	48	198
6278	2026-05-23 06:00:00	47	28.44
6285	2026-05-23 06:00:00	50	20
6293	2026-05-23 06:00:00	46	20
6305	2026-05-23 07:00:00	31	20
6316	2026-05-23 07:00:00	34	20
6325	2026-05-23 07:00:00	32	28.42
6337	2026-05-23 07:00:00	35	20
6345	2026-05-23 07:00:00	33	198
6356	2026-05-23 08:00:00	30	20
6368	2026-05-23 08:00:00	27	28.28
6376	2026-05-23 08:00:00	26	20
6386	2026-05-23 08:00:00	29	20
6398	2026-05-23 08:00:00	28	198
6405	2026-05-23 09:00:00	12	28.25
6412	2026-05-23 09:00:00	14	20
6421	2026-05-23 09:00:00	11	20
6425	2026-05-23 09:00:00	13	198
6434	2026-05-23 09:00:00	15	20
6458	2026-05-23 10:00:00	48	198
6462	2026-05-23 10:00:00	47	28.49
6475	2026-05-23 10:00:00	50	20
6488	2026-05-23 10:00:00	46	20
6499	2026-05-23 10:00:00	49	20
6502	2026-05-23 11:00:00	9	20
6512	2026-05-23 11:00:00	6	12
6525	2026-05-23 11:00:00	7	24.36
6536	2026-05-23 11:00:00	8	171.6
6546	2026-05-23 11:00:00	10	20
6554	2026-05-23 12:00:00	24	20
6564	2026-05-23 12:00:00	23	283.8
6578	2026-05-23 12:00:00	21	46
6591	2026-05-23 12:00:00	22	41.26
6598	2026-05-23 12:00:00	25	20
6603	2026-05-23 13:00:00	12	28.26
6613	2026-05-23 13:00:00	14	20
6627	2026-05-23 13:00:00	11	20
6635	2026-05-23 13:00:00	13	198
6646	2026-05-23 13:00:00	15	20
6656	2026-05-23 14:00:00	17	28.21
6661	2026-05-23 14:00:00	19	20
6670	2026-05-23 14:00:00	20	20
6683	2026-05-23 14:00:00	18	198
6691	2026-05-23 14:00:00	16	20
6709	2026-05-23 15:00:00	44	20
6717	2026-05-23 15:00:00	43	198
6732	2026-05-23 15:00:00	41	20
6745	2026-05-23 15:00:00	42	28.35
6749	2026-05-23 15:00:00	45	20
7254	2026-05-24 02:00:00	11	20
7265	2026-05-24 02:00:00	13	198
7276	2026-05-24 02:00:00	15	20
7282	2026-05-24 02:00:00	12	28.47
7290	2026-05-24 02:00:00	14	20
7309	2026-05-24 03:00:00	43	198
7317	2026-05-24 03:00:00	41	20
7323	2026-05-24 03:00:00	42	28.29
7332	2026-05-24 03:00:00	45	20
7339	2026-05-24 03:00:00	44	20
7358	2026-05-24 04:00:00	40	20
7361	2026-05-24 04:00:00	36	20
7371	2026-05-24 04:00:00	38	198
7382	2026-05-24 04:00:00	37	28.35
7390	2026-05-24 04:00:00	39	20
7408	2026-05-24 05:00:00	49	20
7413	2026-05-24 05:00:00	48	198
7423	2026-05-24 05:00:00	47	28.31
7436	2026-05-24 05:00:00	50	20
7447	2026-05-24 05:00:00	46	20
7456	2026-05-24 06:00:00	25	20
7464	2026-05-24 06:00:00	24	20
7475	2026-05-24 06:00:00	23	198
7486	2026-05-24 06:00:00	21	20
7497	2026-05-24 06:00:00	22	28.33
7509	2026-05-24 07:00:00	15	20
7519	2026-05-24 07:00:00	12	28.27
7531	2026-05-24 07:00:00	14	20
7541	2026-05-24 07:00:00	11	20
7549	2026-05-24 07:00:00	13	198
7555	2026-05-24 08:00:00	24	20
7569	2026-05-24 08:00:00	23	198
7578	2026-05-24 08:00:00	21	20
7587	2026-05-24 08:00:00	22	28.26
7597	2026-05-24 08:00:00	25	20
7608	2026-05-24 09:00:00	30	20
7620	2026-05-24 09:00:00	27	28.23
7626	2026-05-24 09:00:00	26	20
7634	2026-05-24 09:00:00	29	20
7643	2026-05-24 09:00:00	28	198
7657	2026-05-24 10:00:00	39	20
7665	2026-05-24 10:00:00	40	20
7680	2026-05-24 10:00:00	36	20
7690	2026-05-24 10:00:00	38	198
7697	2026-05-24 10:00:00	37	28.43
7707	2026-05-24 11:00:00	45	20
5855	2026-05-22 22:00:00	26	20
5867	2026-05-22 22:00:00	29	20
5879	2026-05-22 22:00:00	28	198
5890	2026-05-22 22:00:00	30	20
5900	2026-05-22 22:00:00	27	28.21
5906	2026-05-22 23:00:00	16	20
5919	2026-05-22 23:00:00	19	20
5930	2026-05-22 23:00:00	20	20
5941	2026-05-22 23:00:00	18	198
5950	2026-05-22 23:00:00	17	28.38
5951	2026-05-23 00:00:00	2	24.38
5965	2026-05-23 00:00:00	5	20
5976	2026-05-23 00:00:00	1	12
5987	2026-05-23 00:00:00	3	171.6
5997	2026-05-23 00:00:00	4	20
6005	2026-05-23 01:00:00	26	20
6019	2026-05-23 01:00:00	29	20
6032	2026-05-23 01:00:00	28	198
6039	2026-05-23 01:00:00	30	20
6045	2026-05-23 01:00:00	27	28.39
6054	2026-05-23 02:00:00	25	20
6068	2026-05-23 02:00:00	24	20
6081	2026-05-23 02:00:00	23	198
6091	2026-05-23 02:00:00	21	20
6099	2026-05-23 02:00:00	22	28.39
6105	2026-05-23 03:00:00	20	20
6116	2026-05-23 03:00:00	18	198
6124	2026-05-23 03:00:00	17	28.19
6137	2026-05-23 03:00:00	16	20
6145	2026-05-23 03:00:00	19	20
6157	2026-05-23 04:00:00	26	20
6165	2026-05-23 04:00:00	29	20
6175	2026-05-23 04:00:00	28	198
6182	2026-05-23 04:00:00	30	20
6193	2026-05-23 04:00:00	27	28.39
6208	2026-05-23 05:00:00	44	20
6219	2026-05-23 05:00:00	41	20
6230	2026-05-23 05:00:00	42	28.42
6241	2026-05-23 05:00:00	45	20
6250	2026-05-23 05:00:00	43	198
6251	2026-05-23 06:00:00	6	12
6264	2026-05-23 06:00:00	7	24.24
6277	2026-05-23 06:00:00	8	171.6
6287	2026-05-23 06:00:00	10	20
6298	2026-05-23 06:00:00	9	20
6304	2026-05-23 07:00:00	22	28.31
6319	2026-05-23 07:00:00	25	20
6333	2026-05-23 07:00:00	24	20
6342	2026-05-23 07:00:00	23	198
6349	2026-05-23 07:00:00	21	20
6353	2026-05-23 08:00:00	2	24.31
6362	2026-05-23 08:00:00	5	20
6371	2026-05-23 08:00:00	1	12
6375	2026-05-23 08:00:00	3	171.6
6385	2026-05-23 08:00:00	4	20
6410	2026-05-23 09:00:00	44	20
6419	2026-05-23 09:00:00	41	20
6431	2026-05-23 09:00:00	42	28.34
6442	2026-05-23 09:00:00	45	20
6449	2026-05-23 09:00:00	43	198
6459	2026-05-23 10:00:00	7	24.35
6469	2026-05-23 10:00:00	8	171.6
6480	2026-05-23 10:00:00	10	20
6490	2026-05-23 10:00:00	9	20
6500	2026-05-23 10:00:00	6	12
6501	2026-05-23 11:00:00	2	24.3
6513	2026-05-23 11:00:00	5	20
6526	2026-05-23 11:00:00	1	12
6534	2026-05-23 11:00:00	3	171.6
6537	2026-05-23 11:00:00	4	20
6566	2026-05-23 12:00:00	47	41.24
6579	2026-05-23 12:00:00	50	20
6590	2026-05-23 12:00:00	46	46
6596	2026-05-23 12:00:00	49	20
6600	2026-05-23 12:00:00	48	283.8
6601	2026-05-23 13:00:00	2	24.28
6611	2026-05-23 13:00:00	5	20
6623	2026-05-23 13:00:00	1	12
6633	2026-05-23 13:00:00	3	171.6
6645	2026-05-23 13:00:00	4	20
6652	2026-05-23 14:00:00	26	20
6665	2026-05-23 14:00:00	29	20
6674	2026-05-23 14:00:00	28	198
6688	2026-05-23 14:00:00	30	20
6697	2026-05-23 14:00:00	27	28.21
6706	2026-05-23 15:00:00	22	28.48
6713	2026-05-23 15:00:00	25	20
6724	2026-05-23 15:00:00	24	20
6731	2026-05-23 15:00:00	23	198
6740	2026-05-23 15:00:00	21	20
7253	2026-05-24 02:00:00	25	20
7266	2026-05-24 02:00:00	24	20
7271	2026-05-24 02:00:00	23	198
7279	2026-05-24 02:00:00	21	20
7287	2026-05-24 02:00:00	22	28.32
7310	2026-05-24 03:00:00	48	198
7321	2026-05-24 03:00:00	47	28.24
7335	2026-05-24 03:00:00	50	20
7345	2026-05-24 03:00:00	46	20
7349	2026-05-24 03:00:00	49	20
7351	2026-05-24 04:00:00	5	20
7365	2026-05-24 04:00:00	1	12
7376	2026-05-24 04:00:00	3	171.6
7386	2026-05-24 04:00:00	4	20
7396	2026-05-24 04:00:00	2	24.26
7404	2026-05-24 05:00:00	14	20
7417	2026-05-24 05:00:00	11	20
7425	2026-05-24 05:00:00	13	198
7433	2026-05-24 05:00:00	15	20
7441	2026-05-24 05:00:00	12	28.46
7459	2026-05-24 06:00:00	47	28.37
7466	2026-05-24 06:00:00	50	20
7476	2026-05-24 06:00:00	46	20
7484	2026-05-24 06:00:00	49	20
7492	2026-05-24 06:00:00	48	198
7506	2026-05-24 07:00:00	44	20
7516	2026-05-24 07:00:00	43	198
7529	2026-05-24 07:00:00	41	20
7539	2026-05-24 07:00:00	42	28.21
7548	2026-05-24 07:00:00	45	20
7558	2026-05-24 08:00:00	18	198
7565	2026-05-24 08:00:00	16	20
7575	2026-05-24 08:00:00	17	28.29
7584	2026-05-24 08:00:00	19	20
7593	2026-05-24 08:00:00	20	20
7604	2026-05-24 09:00:00	24	20
7612	2026-05-24 09:00:00	23	198
7624	2026-05-24 09:00:00	21	20
7636	2026-05-24 09:00:00	22	28.24
7645	2026-05-24 09:00:00	25	20
7655	2026-05-24 10:00:00	23	198
7670	2026-05-24 10:00:00	21	20
7679	2026-05-24 10:00:00	22	28.26
7689	2026-05-24 10:00:00	25	20
7698	2026-05-24 10:00:00	24	20
7704	2026-05-24 11:00:00	15	20
5857	2026-05-22 22:00:00	24	20
5863	2026-05-22 22:00:00	23	198
5875	2026-05-22 22:00:00	21	20
5888	2026-05-22 22:00:00	22	28.38
5898	2026-05-22 22:00:00	25	20
5901	2026-05-22 23:00:00	4	20
5911	2026-05-22 23:00:00	2	24.46
5924	2026-05-22 23:00:00	5	20
5936	2026-05-22 23:00:00	1	12
5947	2026-05-22 23:00:00	3	171.6
5955	2026-05-23 00:00:00	14	20
5966	2026-05-23 00:00:00	11	20
5973	2026-05-23 00:00:00	13	198
5985	2026-05-23 00:00:00	15	20
5995	2026-05-23 00:00:00	12	28.23
6006	2026-05-23 01:00:00	25	20
6014	2026-05-23 01:00:00	24	20
6024	2026-05-23 01:00:00	23	198
6030	2026-05-23 01:00:00	21	20
6037	2026-05-23 01:00:00	22	28.19
6058	2026-05-23 02:00:00	39	20
6061	2026-05-23 02:00:00	40	20
6069	2026-05-23 02:00:00	36	20
6076	2026-05-23 02:00:00	38	198
6083	2026-05-23 02:00:00	37	28.46
6110	2026-05-23 03:00:00	45	20
6119	2026-05-23 03:00:00	43	198
6129	2026-05-23 03:00:00	44	20
6135	2026-05-23 03:00:00	41	20
6143	2026-05-23 03:00:00	42	28.36
6158	2026-05-23 04:00:00	35	20
6169	2026-05-23 04:00:00	33	198
6177	2026-05-23 04:00:00	31	20
6188	2026-05-23 04:00:00	34	20
6196	2026-05-23 04:00:00	32	28.39
6207	2026-05-23 05:00:00	29	20
6212	2026-05-23 05:00:00	28	198
6224	2026-05-23 05:00:00	30	20
6235	2026-05-23 05:00:00	27	28.27
6246	2026-05-23 05:00:00	26	20
6258	2026-05-23 06:00:00	26	20
6271	2026-05-23 06:00:00	29	20
6282	2026-05-23 06:00:00	28	198
6294	2026-05-23 06:00:00	30	20
6300	2026-05-23 06:00:00	27	28.48
6302	2026-05-23 07:00:00	3	171.6
6314	2026-05-23 07:00:00	4	20
6324	2026-05-23 07:00:00	2	24.45
6332	2026-05-23 07:00:00	5	20
6339	2026-05-23 07:00:00	1	12
6358	2026-05-23 08:00:00	40	20
6367	2026-05-23 08:00:00	36	20
6379	2026-05-23 08:00:00	38	198
6387	2026-05-23 08:00:00	37	28.48
6395	2026-05-23 08:00:00	39	20
6408	2026-05-23 09:00:00	37	28.48
6420	2026-05-23 09:00:00	39	20
6432	2026-05-23 09:00:00	40	20
6443	2026-05-23 09:00:00	36	20
6450	2026-05-23 09:00:00	38	198
6451	2026-05-23 10:00:00	4	20
6461	2026-05-23 10:00:00	2	24.3
6472	2026-05-23 10:00:00	5	20
6483	2026-05-23 10:00:00	1	12
6494	2026-05-23 10:00:00	3	171.6
6508	2026-05-23 11:00:00	31	20
6516	2026-05-23 11:00:00	34	20
6524	2026-05-23 11:00:00	32	28.21
6535	2026-05-23 11:00:00	35	20
6542	2026-05-23 11:00:00	33	198
6559	2026-05-23 12:00:00	45	20
6565	2026-05-23 12:00:00	44	20
6576	2026-05-23 12:00:00	43	283.8
6589	2026-05-23 12:00:00	41	46
6597	2026-05-23 12:00:00	42	41.44
6605	2026-05-23 13:00:00	17	28.48
6616	2026-05-23 13:00:00	19	20
6622	2026-05-23 13:00:00	20	20
6632	2026-05-23 13:00:00	18	198
6640	2026-05-23 13:00:00	16	20
6658	2026-05-23 14:00:00	38	198
6663	2026-05-23 14:00:00	37	28.38
6675	2026-05-23 14:00:00	39	20
6690	2026-05-23 14:00:00	40	20
6699	2026-05-23 14:00:00	36	20
6702	2026-05-23 15:00:00	15	20
6715	2026-05-23 15:00:00	12	28.32
6723	2026-05-23 15:00:00	14	20
6730	2026-05-23 15:00:00	11	20
6739	2026-05-23 15:00:00	13	198
7255	2026-05-24 02:00:00	18	198
7264	2026-05-24 02:00:00	16	20
7275	2026-05-24 02:00:00	17	28.27
7289	2026-05-24 02:00:00	19	20
7298	2026-05-24 02:00:00	20	20
7306	2026-05-24 03:00:00	19	20
7316	2026-05-24 03:00:00	20	20
7322	2026-05-24 03:00:00	18	198
7331	2026-05-24 03:00:00	16	20
7340	2026-05-24 03:00:00	17	28.47
7360	2026-05-24 04:00:00	43	198
7367	2026-05-24 04:00:00	41	20
7379	2026-05-24 04:00:00	42	28.44
7391	2026-05-24 04:00:00	45	20
7399	2026-05-24 04:00:00	44	20
7402	2026-05-24 05:00:00	6	12
7412	2026-05-24 05:00:00	7	24.27
7422	2026-05-24 05:00:00	8	171.6
7432	2026-05-24 05:00:00	10	20
7444	2026-05-24 05:00:00	9	20
7454	2026-05-24 06:00:00	28	198
7467	2026-05-24 06:00:00	30	20
7477	2026-05-24 06:00:00	27	28.47
7487	2026-05-24 06:00:00	26	20
7495	2026-05-24 06:00:00	29	20
7507	2026-05-24 07:00:00	27	28.42
7512	2026-05-24 07:00:00	26	20
7522	2026-05-24 07:00:00	29	20
7530	2026-05-24 07:00:00	28	198
7540	2026-05-24 07:00:00	30	20
7557	2026-05-24 08:00:00	37	28.3
7561	2026-05-24 08:00:00	39	20
7570	2026-05-24 08:00:00	40	20
7581	2026-05-24 08:00:00	36	20
7590	2026-05-24 08:00:00	38	198
7609	2026-05-24 09:00:00	43	198
7613	2026-05-24 09:00:00	41	20
7623	2026-05-24 09:00:00	42	28.2
7633	2026-05-24 09:00:00	45	20
7646	2026-05-24 09:00:00	44	20
7656	2026-05-24 10:00:00	27	28.49
7666	2026-05-24 10:00:00	26	20
7674	2026-05-24 10:00:00	29	20
7683	2026-05-24 10:00:00	28	198
7694	2026-05-24 10:00:00	30	20
7706	2026-05-24 11:00:00	22	28.43
5856	2026-05-22 22:00:00	35	20
5861	2026-05-22 22:00:00	33	198
5872	2026-05-22 22:00:00	31	20
5882	2026-05-22 22:00:00	34	20
5893	2026-05-22 22:00:00	32	28.31
5904	2026-05-22 23:00:00	24	20
5918	2026-05-22 23:00:00	23	198
5928	2026-05-22 23:00:00	21	20
5939	2026-05-22 23:00:00	22	28.45
5948	2026-05-22 23:00:00	25	20
5958	2026-05-23 00:00:00	33	198
5968	2026-05-23 00:00:00	31	20
5977	2026-05-23 00:00:00	34	20
5983	2026-05-23 00:00:00	32	28.44
5991	2026-05-23 00:00:00	35	20
6010	2026-05-23 01:00:00	49	20
6017	2026-05-23 01:00:00	48	198
6028	2026-05-23 01:00:00	47	28.44
6042	2026-05-23 01:00:00	50	20
6050	2026-05-23 01:00:00	46	20
6053	2026-05-23 02:00:00	9	20
6067	2026-05-23 02:00:00	6	12
6078	2026-05-23 02:00:00	7	24.19
6085	2026-05-23 02:00:00	8	171.6
6093	2026-05-23 02:00:00	10	20
6108	2026-05-23 03:00:00	35	20
6120	2026-05-23 03:00:00	33	198
6131	2026-05-23 03:00:00	31	20
6139	2026-05-23 03:00:00	34	20
6147	2026-05-23 03:00:00	32	28.4
6156	2026-05-23 04:00:00	18	198
6168	2026-05-23 04:00:00	17	28.35
6183	2026-05-23 04:00:00	16	20
6191	2026-05-23 04:00:00	19	20
6199	2026-05-23 04:00:00	20	20
6210	2026-05-23 05:00:00	16	20
6213	2026-05-23 05:00:00	19	20
6227	2026-05-23 05:00:00	20	20
6237	2026-05-23 05:00:00	18	198
6244	2026-05-23 05:00:00	17	28.19
6256	2026-05-23 06:00:00	33	198
6270	2026-05-23 06:00:00	31	20
6279	2026-05-23 06:00:00	34	20
6289	2026-05-23 06:00:00	32	28.47
6297	2026-05-23 06:00:00	35	20
6306	2026-05-23 07:00:00	16	20
6312	2026-05-23 07:00:00	19	20
6322	2026-05-23 07:00:00	20	20
6328	2026-05-23 07:00:00	18	198
6341	2026-05-23 07:00:00	17	28.47
6357	2026-05-23 08:00:00	32	28.47
6370	2026-05-23 08:00:00	35	20
6384	2026-05-23 08:00:00	33	198
6392	2026-05-23 08:00:00	31	20
6397	2026-05-23 08:00:00	34	20
6403	2026-05-23 09:00:00	16	20
6416	2026-05-23 09:00:00	19	20
6428	2026-05-23 09:00:00	20	20
6440	2026-05-23 09:00:00	18	198
6448	2026-05-23 09:00:00	17	28.19
6455	2026-05-23 10:00:00	12	28.33
6464	2026-05-23 10:00:00	14	20
6471	2026-05-23 10:00:00	11	20
6482	2026-05-23 10:00:00	13	198
6496	2026-05-23 10:00:00	15	20
6503	2026-05-23 11:00:00	12	28.23
6511	2026-05-23 11:00:00	14	20
6523	2026-05-23 11:00:00	11	20
6531	2026-05-23 11:00:00	13	198
6543	2026-05-23 11:00:00	15	20
6557	2026-05-23 12:00:00	32	41.37
6560	2026-05-23 12:00:00	35	20
6573	2026-05-23 12:00:00	33	283.8
6584	2026-05-23 12:00:00	31	46
6592	2026-05-23 12:00:00	34	20
6609	2026-05-23 13:00:00	37	28.2
6619	2026-05-23 13:00:00	39	20
6630	2026-05-23 13:00:00	40	20
6639	2026-05-23 13:00:00	36	20
6648	2026-05-23 13:00:00	38	198
6655	2026-05-23 14:00:00	15	20
6662	2026-05-23 14:00:00	12	28.27
6671	2026-05-23 14:00:00	14	20
6677	2026-05-23 14:00:00	11	20
6684	2026-05-23 14:00:00	13	198
6710	2026-05-23 15:00:00	48	198
6718	2026-05-23 15:00:00	47	28.37
6733	2026-05-23 15:00:00	50	20
6746	2026-05-23 15:00:00	46	20
6750	2026-05-23 15:00:00	49	20
7256	2026-05-24 02:00:00	31	20
7262	2026-05-24 02:00:00	34	20
7272	2026-05-24 02:00:00	32	28.36
7284	2026-05-24 02:00:00	35	20
7294	2026-05-24 02:00:00	33	198
7307	2026-05-24 03:00:00	35	20
7313	2026-05-24 03:00:00	33	198
7325	2026-05-24 03:00:00	31	20
7334	2026-05-24 03:00:00	34	20
7346	2026-05-24 03:00:00	32	28.43
7355	2026-05-24 04:00:00	22	28.21
7370	2026-05-24 04:00:00	25	20
7378	2026-05-24 04:00:00	24	20
7385	2026-05-24 04:00:00	23	198
7397	2026-05-24 04:00:00	21	20
7406	2026-05-24 05:00:00	35	20
7419	2026-05-24 05:00:00	33	198
7430	2026-05-24 05:00:00	31	20
7439	2026-05-24 05:00:00	34	20
7450	2026-05-24 05:00:00	32	28.44
7451	2026-05-24 06:00:00	4	20
7462	2026-05-24 06:00:00	2	24.27
7472	2026-05-24 06:00:00	5	20
7482	2026-05-24 06:00:00	1	12
7494	2026-05-24 06:00:00	3	171.6
7504	2026-05-24 07:00:00	34	20
7511	2026-05-24 07:00:00	32	28.48
7521	2026-05-24 07:00:00	35	20
7527	2026-05-24 07:00:00	33	198
7533	2026-05-24 07:00:00	31	20
7556	2026-05-24 08:00:00	50	20
7562	2026-05-24 08:00:00	46	20
7571	2026-05-24 08:00:00	49	20
7579	2026-05-24 08:00:00	48	198
7589	2026-05-24 08:00:00	47	28.23
7610	2026-05-24 09:00:00	50	20
7618	2026-05-24 09:00:00	46	20
7630	2026-05-24 09:00:00	49	20
7641	2026-05-24 09:00:00	48	198
7648	2026-05-24 09:00:00	47	28.27
7654	2026-05-24 10:00:00	18	198
7662	2026-05-24 10:00:00	16	20
7672	2026-05-24 10:00:00	17	28.27
7686	2026-05-24 10:00:00	19	20
7699	2026-05-24 10:00:00	20	20
7702	2026-05-24 11:00:00	8	171.6
5853	2026-05-22 22:00:00	12	28.35
5870	2026-05-22 22:00:00	14	20
5878	2026-05-22 22:00:00	11	20
5883	2026-05-22 22:00:00	13	198
5895	2026-05-22 22:00:00	15	20
5907	2026-05-22 23:00:00	38	198
5917	2026-05-22 23:00:00	37	28.24
5927	2026-05-22 23:00:00	39	20
5938	2026-05-22 23:00:00	40	20
5949	2026-05-22 23:00:00	36	20
5952	2026-05-23 00:00:00	17	28.46
5961	2026-05-23 00:00:00	16	20
5970	2026-05-23 00:00:00	19	20
5981	2026-05-23 00:00:00	20	20
5993	2026-05-23 00:00:00	18	198
6007	2026-05-23 01:00:00	33	198
6013	2026-05-23 01:00:00	31	20
6022	2026-05-23 01:00:00	34	20
6035	2026-05-23 01:00:00	32	28.4
6044	2026-05-23 01:00:00	35	20
6057	2026-05-23 02:00:00	27	28.47
6066	2026-05-23 02:00:00	26	20
6080	2026-05-23 02:00:00	29	20
6089	2026-05-23 02:00:00	28	198
6098	2026-05-23 02:00:00	30	20
6102	2026-05-23 03:00:00	9	20
6114	2026-05-23 03:00:00	6	12
6128	2026-05-23 03:00:00	7	24.22
6134	2026-05-23 03:00:00	8	171.6
6142	2026-05-23 03:00:00	10	20
6160	2026-05-23 04:00:00	40	20
6170	2026-05-23 04:00:00	36	20
6184	2026-05-23 04:00:00	38	198
6194	2026-05-23 04:00:00	37	28.28
6200	2026-05-23 04:00:00	39	20
6201	2026-05-23 05:00:00	4	20
6215	2026-05-23 05:00:00	2	24.46
6225	2026-05-23 05:00:00	5	20
6238	2026-05-23 05:00:00	1	12
6247	2026-05-23 05:00:00	3	171.6
6253	2026-05-23 06:00:00	17	28.25
6262	2026-05-23 06:00:00	16	20
6273	2026-05-23 06:00:00	19	20
6283	2026-05-23 06:00:00	20	20
6292	2026-05-23 06:00:00	18	198
6307	2026-05-23 07:00:00	37	28.45
6318	2026-05-23 07:00:00	39	20
6330	2026-05-23 07:00:00	40	20
6343	2026-05-23 07:00:00	36	20
6348	2026-05-23 07:00:00	38	198
6352	2026-05-23 08:00:00	14	20
6361	2026-05-23 08:00:00	11	20
6374	2026-05-23 08:00:00	13	198
6383	2026-05-23 08:00:00	15	20
6394	2026-05-23 08:00:00	12	28.35
6406	2026-05-23 09:00:00	21	20
6415	2026-05-23 09:00:00	22	28.41
6426	2026-05-23 09:00:00	25	20
6435	2026-05-23 09:00:00	24	20
6444	2026-05-23 09:00:00	23	198
6456	2026-05-23 10:00:00	29	20
6468	2026-05-23 10:00:00	28	198
6478	2026-05-23 10:00:00	30	20
6487	2026-05-23 10:00:00	27	28.23
6493	2026-05-23 10:00:00	26	20
6504	2026-05-23 11:00:00	22	28.39
6519	2026-05-23 11:00:00	25	20
6527	2026-05-23 11:00:00	24	20
6540	2026-05-23 11:00:00	23	198
6549	2026-05-23 11:00:00	21	20
6553	2026-05-23 12:00:00	11	46
6562	2026-05-23 12:00:00	13	283.8
6572	2026-05-23 12:00:00	15	20
6581	2026-05-23 12:00:00	12	41.25
6588	2026-05-23 12:00:00	14	20
6608	2026-05-23 13:00:00	50	20
6618	2026-05-23 13:00:00	46	20
6631	2026-05-23 13:00:00	49	20
6642	2026-05-23 13:00:00	48	198
6650	2026-05-23 13:00:00	47	28.47
6651	2026-05-23 14:00:00	4	20
6664	2026-05-23 14:00:00	2	24.32
6673	2026-05-23 14:00:00	5	20
6682	2026-05-23 14:00:00	1	12
6693	2026-05-23 14:00:00	3	171.6
6708	2026-05-23 15:00:00	34	20
6716	2026-05-23 15:00:00	32	28.49
6728	2026-05-23 15:00:00	35	20
6737	2026-05-23 15:00:00	33	198
6744	2026-05-23 15:00:00	31	20
7257	2026-05-24 02:00:00	30	20
7268	2026-05-24 02:00:00	27	28.2
7278	2026-05-24 02:00:00	26	20
7286	2026-05-24 02:00:00	29	20
7293	2026-05-24 02:00:00	28	198
7305	2026-05-24 03:00:00	29	20
7319	2026-05-24 03:00:00	28	198
7327	2026-05-24 03:00:00	30	20
7338	2026-05-24 03:00:00	27	28.37
7347	2026-05-24 03:00:00	26	20
7352	2026-05-24 04:00:00	19	20
7369	2026-05-24 04:00:00	20	20
7377	2026-05-24 04:00:00	18	198
7388	2026-05-24 04:00:00	16	20
7398	2026-05-24 04:00:00	17	28.38
7403	2026-05-24 05:00:00	19	20
7416	2026-05-24 05:00:00	20	20
7426	2026-05-24 05:00:00	18	198
7435	2026-05-24 05:00:00	16	20
7448	2026-05-24 05:00:00	17	28.29
7453	2026-05-24 06:00:00	8	171.6
7463	2026-05-24 06:00:00	10	20
7473	2026-05-24 06:00:00	9	20
7483	2026-05-24 06:00:00	6	12
7493	2026-05-24 06:00:00	7	24.39
7508	2026-05-24 07:00:00	39	20
7514	2026-05-24 07:00:00	40	20
7523	2026-05-24 07:00:00	36	20
7535	2026-05-24 07:00:00	38	198
7545	2026-05-24 07:00:00	37	28.39
7552	2026-05-24 08:00:00	30	20
7568	2026-05-24 08:00:00	27	28.31
7580	2026-05-24 08:00:00	26	20
7592	2026-05-24 08:00:00	29	20
7599	2026-05-24 08:00:00	28	198
7602	2026-05-24 09:00:00	11	20
7614	2026-05-24 09:00:00	13	198
7622	2026-05-24 09:00:00	15	20
7632	2026-05-24 09:00:00	12	28.26
7642	2026-05-24 09:00:00	14	20
7660	2026-05-24 10:00:00	41	20
7667	2026-05-24 10:00:00	42	28.44
7675	2026-05-24 10:00:00	45	20
7682	2026-05-24 10:00:00	44	20
7693	2026-05-24 10:00:00	43	198
7703	2026-05-24 11:00:00	33	198
5858	2026-05-22 22:00:00	43	198
5866	2026-05-22 22:00:00	44	20
5877	2026-05-22 22:00:00	41	20
5887	2026-05-22 22:00:00	42	28.48
5899	2026-05-22 22:00:00	45	20
5902	2026-05-22 23:00:00	12	28.42
5912	2026-05-22 23:00:00	14	20
5921	2026-05-22 23:00:00	11	20
5931	2026-05-22 23:00:00	13	198
5942	2026-05-22 23:00:00	15	20
5960	2026-05-23 00:00:00	44	20
5972	2026-05-23 00:00:00	41	20
5980	2026-05-23 00:00:00	42	28.31
5988	2026-05-23 00:00:00	45	20
5996	2026-05-23 00:00:00	43	198
6003	2026-05-23 01:00:00	15	20
6012	2026-05-23 01:00:00	12	28.36
6023	2026-05-23 01:00:00	14	20
6036	2026-05-23 01:00:00	11	20
6048	2026-05-23 01:00:00	13	198
6051	2026-05-23 02:00:00	5	20
6063	2026-05-23 02:00:00	1	12
6073	2026-05-23 02:00:00	3	171.6
6087	2026-05-23 02:00:00	4	20
6097	2026-05-23 02:00:00	2	24.22
6103	2026-05-23 03:00:00	13	198
6118	2026-05-23 03:00:00	15	20
6132	2026-05-23 03:00:00	12	28.35
6144	2026-05-23 03:00:00	14	20
6150	2026-05-23 03:00:00	11	20
6151	2026-05-23 04:00:00	1	12
6166	2026-05-23 04:00:00	3	171.6
6178	2026-05-23 04:00:00	4	20
6190	2026-05-23 04:00:00	2	24.33
6198	2026-05-23 04:00:00	5	20
6203	2026-05-23 05:00:00	15	20
6217	2026-05-23 05:00:00	12	28.26
6226	2026-05-23 05:00:00	14	20
6236	2026-05-23 05:00:00	11	20
6245	2026-05-23 05:00:00	13	198
6255	2026-05-23 06:00:00	21	20
6263	2026-05-23 06:00:00	22	28.45
6272	2026-05-23 06:00:00	25	20
6281	2026-05-23 06:00:00	24	20
6291	2026-05-23 06:00:00	23	198
6308	2026-05-23 07:00:00	45	20
6313	2026-05-23 07:00:00	43	198
6323	2026-05-23 07:00:00	44	20
6331	2026-05-23 07:00:00	41	20
6336	2026-05-23 07:00:00	42	28.23
6359	2026-05-23 08:00:00	44	20
6365	2026-05-23 08:00:00	41	20
6372	2026-05-23 08:00:00	42	28.42
6381	2026-05-23 08:00:00	45	20
6391	2026-05-23 08:00:00	43	198
6407	2026-05-23 09:00:00	31	20
6414	2026-05-23 09:00:00	34	20
6423	2026-05-23 09:00:00	32	28.27
6430	2026-05-23 09:00:00	35	20
6439	2026-05-23 09:00:00	33	198
6460	2026-05-23 10:00:00	44	20
6463	2026-05-23 10:00:00	41	20
6473	2026-05-23 10:00:00	42	28.27
6489	2026-05-23 10:00:00	45	20
6498	2026-05-23 10:00:00	43	198
6505	2026-05-23 11:00:00	19	20
6518	2026-05-23 11:00:00	20	20
6528	2026-05-23 11:00:00	18	198
6539	2026-05-23 11:00:00	16	20
6548	2026-05-23 11:00:00	17	28.21
6552	2026-05-23 12:00:00	7	24.41
6563	2026-05-23 12:00:00	8	171.6
6570	2026-05-23 12:00:00	10	20
6575	2026-05-23 12:00:00	9	20
6583	2026-05-23 12:00:00	6	12
6610	2026-05-23 13:00:00	41	20
6620	2026-05-23 13:00:00	42	28.24
6624	2026-05-23 13:00:00	45	20
6634	2026-05-23 13:00:00	44	20
6644	2026-05-23 13:00:00	43	198
6657	2026-05-23 14:00:00	34	20
6667	2026-05-23 14:00:00	32	28.3
6681	2026-05-23 14:00:00	35	20
6692	2026-05-23 14:00:00	33	198
6700	2026-05-23 14:00:00	31	20
6701	2026-05-23 15:00:00	5	20
6714	2026-05-23 15:00:00	1	12
6729	2026-05-23 15:00:00	3	171.6
6741	2026-05-23 15:00:00	4	20
6748	2026-05-23 15:00:00	2	24.28
7258	2026-05-24 02:00:00	40	20
7259	2026-05-24 02:00:00	50	20
7267	2026-05-24 02:00:00	36	20
7269	2026-05-24 02:00:00	46	20
7277	2026-05-24 02:00:00	38	198
7280	2026-05-24 02:00:00	49	20
7288	2026-05-24 02:00:00	48	198
7292	2026-05-24 02:00:00	37	28.34
7297	2026-05-24 02:00:00	39	20
7299	2026-05-24 02:00:00	47	28.45
7302	2026-05-24 03:00:00	14	20
7304	2026-05-24 03:00:00	10	20
7314	2026-05-24 03:00:00	9	20
7318	2026-05-24 03:00:00	11	20
7328	2026-05-24 03:00:00	13	198
7329	2026-05-24 03:00:00	6	12
7336	2026-05-24 03:00:00	15	20
7341	2026-05-24 03:00:00	12	28.32
7343	2026-05-24 03:00:00	7	24.44
7348	2026-05-24 03:00:00	8	171.6
7356	2026-05-24 04:00:00	14	20
7357	2026-05-24 04:00:00	26	20
7362	2026-05-24 04:00:00	11	20
7366	2026-05-24 04:00:00	29	20
7374	2026-05-24 04:00:00	13	198
7375	2026-05-24 04:00:00	28	198
7380	2026-05-24 04:00:00	15	20
7384	2026-05-24 04:00:00	30	20
7389	2026-05-24 04:00:00	12	28.23
7392	2026-05-24 04:00:00	27	28.4
7409	2026-05-24 05:00:00	40	20
7410	2026-05-24 05:00:00	43	198
7414	2026-05-24 05:00:00	36	20
7420	2026-05-24 05:00:00	41	20
7421	2026-05-24 05:00:00	38	198
7428	2026-05-24 05:00:00	42	28.33
7431	2026-05-24 05:00:00	37	28.49
7438	2026-05-24 05:00:00	45	20
7442	2026-05-24 05:00:00	39	20
7449	2026-05-24 05:00:00	44	20
7452	2026-05-24 06:00:00	11	20
7458	2026-05-24 06:00:00	38	198
7468	2026-05-24 06:00:00	37	28.25
7469	2026-05-24 06:00:00	13	198
7478	2026-05-24 06:00:00	39	20
7481	2026-05-24 06:00:00	15	20
6751	2026-05-23 16:00:00	1	12
6765	2026-05-23 16:00:00	3	171.6
6775	2026-05-23 16:00:00	4	20
6787	2026-05-23 16:00:00	2	24.24
6796	2026-05-23 16:00:00	5	20
6805	2026-05-23 17:00:00	24	20
6813	2026-05-23 17:00:00	23	198
6822	2026-05-23 17:00:00	21	20
6830	2026-05-23 17:00:00	22	28.27
6842	2026-05-23 17:00:00	25	20
6856	2026-05-23 18:00:00	27	28.29
6863	2026-05-23 18:00:00	26	20
6875	2026-05-23 18:00:00	29	20
6887	2026-05-23 18:00:00	28	198
6899	2026-05-23 18:00:00	30	20
6902	2026-05-23 19:00:00	4	20
6915	2026-05-23 19:00:00	2	24.24
6923	2026-05-23 19:00:00	5	20
6933	2026-05-23 19:00:00	1	12
6940	2026-05-23 19:00:00	3	171.6
6960	2026-05-23 20:00:00	48	198
6972	2026-05-23 20:00:00	47	28.25
6984	2026-05-23 20:00:00	50	20
6993	2026-05-23 20:00:00	46	20
6998	2026-05-23 20:00:00	49	20
7007	2026-05-23 21:00:00	23	198
7016	2026-05-23 21:00:00	21	20
7026	2026-05-23 21:00:00	22	28.36
7037	2026-05-23 21:00:00	25	20
7046	2026-05-23 21:00:00	24	20
7055	2026-05-23 22:00:00	27	28.21
7066	2026-05-23 22:00:00	26	20
7080	2026-05-23 22:00:00	29	20
7092	2026-05-23 22:00:00	28	198
7095	2026-05-23 22:00:00	30	20
7105	2026-05-23 23:00:00	24	20
7114	2026-05-23 23:00:00	23	198
7124	2026-05-23 23:00:00	21	20
7133	2026-05-23 23:00:00	22	28.4
7145	2026-05-23 23:00:00	25	20
7157	2026-05-24 00:00:00	29	20
7166	2026-05-24 00:00:00	28	198
7178	2026-05-24 00:00:00	30	20
7189	2026-05-24 00:00:00	27	28.32
7198	2026-05-24 00:00:00	26	20
7203	2026-05-24 01:00:00	19	20
7214	2026-05-24 01:00:00	20	20
7223	2026-05-24 01:00:00	18	198
7234	2026-05-24 01:00:00	16	20
7241	2026-05-24 01:00:00	17	28.23
7260	2026-05-24 02:00:00	45	20
7270	2026-05-24 02:00:00	44	20
7281	2026-05-24 02:00:00	43	198
7295	2026-05-24 02:00:00	41	20
7300	2026-05-24 02:00:00	42	28.25
7301	2026-05-24 03:00:00	5	20
7311	2026-05-24 03:00:00	1	12
7324	2026-05-24 03:00:00	3	171.6
7333	2026-05-24 03:00:00	4	20
7342	2026-05-24 03:00:00	2	24.29
7354	2026-05-24 04:00:00	35	20
7368	2026-05-24 04:00:00	33	198
7387	2026-05-24 04:00:00	31	20
7394	2026-05-24 04:00:00	34	20
7400	2026-05-24 04:00:00	32	28.37
7401	2026-05-24 05:00:00	1	12
7411	2026-05-24 05:00:00	3	171.6
7424	2026-05-24 05:00:00	4	20
7434	2026-05-24 05:00:00	2	24.47
7443	2026-05-24 05:00:00	5	20
7460	2026-05-24 06:00:00	41	20
7465	2026-05-24 06:00:00	42	28.22
7474	2026-05-24 06:00:00	45	20
7485	2026-05-24 06:00:00	44	20
7496	2026-05-24 06:00:00	43	198
7503	2026-05-24 07:00:00	16	20
7515	2026-05-24 07:00:00	17	28.31
7526	2026-05-24 07:00:00	19	20
7538	2026-05-24 07:00:00	20	20
7547	2026-05-24 07:00:00	18	198
7554	2026-05-24 08:00:00	11	20
7566	2026-05-24 08:00:00	13	198
7573	2026-05-24 08:00:00	15	20
7582	2026-05-24 08:00:00	12	28.34
7591	2026-05-24 08:00:00	14	20
7606	2026-05-24 09:00:00	37	28.43
7611	2026-05-24 09:00:00	39	20
7625	2026-05-24 09:00:00	40	20
7637	2026-05-24 09:00:00	36	20
7644	2026-05-24 09:00:00	38	198
7658	2026-05-24 10:00:00	32	28.41
7664	2026-05-24 10:00:00	35	20
7677	2026-05-24 10:00:00	33	198
7684	2026-05-24 10:00:00	31	20
7692	2026-05-24 10:00:00	34	20
7708	2026-05-24 11:00:00	36	20
7711	2026-05-24 11:00:00	38	198
7721	2026-05-24 11:00:00	18	198
7729	2026-05-24 11:00:00	16	20
7739	2026-05-24 11:00:00	17	28.22
7758	2026-05-24 12:00:00	36	46
7770	2026-05-24 12:00:00	38	283.8
7775	2026-05-24 12:00:00	37	41.37
7784	2026-05-24 12:00:00	39	20
7792	2026-05-24 12:00:00	40	20
7809	2026-05-24 13:00:00	31	20
7821	2026-05-24 13:00:00	34	20
7835	2026-05-24 13:00:00	32	28.34
7843	2026-05-24 13:00:00	35	20
7850	2026-05-24 13:00:00	33	198
7851	2026-05-24 14:00:00	10	20
7863	2026-05-24 14:00:00	9	20
7876	2026-05-24 14:00:00	6	12
7885	2026-05-24 14:00:00	7	24.33
7895	2026-05-24 14:00:00	8	171.6
7908	2026-05-24 15:00:00	38	198
7922	2026-05-24 15:00:00	37	28.34
7932	2026-05-24 15:00:00	39	20
7941	2026-05-24 15:00:00	40	20
7949	2026-05-24 15:00:00	36	20
7951	2026-05-24 16:00:00	2	24.36
7964	2026-05-24 16:00:00	5	20
7978	2026-05-24 16:00:00	1	12
7988	2026-05-24 16:00:00	3	171.6
7997	2026-05-24 16:00:00	4	20
8004	2026-05-24 17:00:00	19	20
8017	2026-05-24 17:00:00	20	20
8027	2026-05-24 17:00:00	18	198
8038	2026-05-24 17:00:00	16	20
8046	2026-05-24 17:00:00	17	28.24
8057	2026-05-24 18:00:00	21	20
8069	2026-05-24 18:00:00	22	28.36
8080	2026-05-24 18:00:00	25	20
8090	2026-05-24 18:00:00	24	20
8100	2026-05-24 18:00:00	23	198
8101	2026-05-24 19:00:00	2	24.29
6752	2026-05-23 16:00:00	6	12
6766	2026-05-23 16:00:00	7	24.32
6778	2026-05-23 16:00:00	8	171.6
6789	2026-05-23 16:00:00	10	20
6797	2026-05-23 16:00:00	9	20
6804	2026-05-23 17:00:00	20	20
6814	2026-05-23 17:00:00	18	198
6825	2026-05-23 17:00:00	16	20
6839	2026-05-23 17:00:00	17	28.49
6847	2026-05-23 17:00:00	19	20
6857	2026-05-23 18:00:00	11	20
6867	2026-05-23 18:00:00	13	198
6879	2026-05-23 18:00:00	15	20
6889	2026-05-23 18:00:00	12	28.32
6900	2026-05-23 18:00:00	14	20
6901	2026-05-23 19:00:00	7	24.23
6914	2026-05-23 19:00:00	8	171.6
6925	2026-05-23 19:00:00	10	20
6937	2026-05-23 19:00:00	9	20
6950	2026-05-23 19:00:00	6	12
6951	2026-05-23 20:00:00	4	20
6965	2026-05-23 20:00:00	2	24.38
6978	2026-05-23 20:00:00	5	20
6988	2026-05-23 20:00:00	1	12
6997	2026-05-23 20:00:00	3	171.6
7004	2026-05-23 21:00:00	20	20
7020	2026-05-23 21:00:00	18	198
7028	2026-05-23 21:00:00	16	20
7035	2026-05-23 21:00:00	17	28.21
7040	2026-05-23 21:00:00	19	20
7059	2026-05-23 22:00:00	42	28.4
7061	2026-05-23 22:00:00	45	20
7074	2026-05-23 22:00:00	44	20
7079	2026-05-23 22:00:00	43	198
7088	2026-05-23 22:00:00	41	20
7107	2026-05-23 23:00:00	31	20
7120	2026-05-23 23:00:00	34	20
7130	2026-05-23 23:00:00	32	28.42
7137	2026-05-23 23:00:00	35	20
7149	2026-05-23 23:00:00	33	198
7152	2026-05-24 00:00:00	10	20
7168	2026-05-24 00:00:00	9	20
7176	2026-05-24 00:00:00	6	12
7183	2026-05-24 00:00:00	7	24.32
7187	2026-05-24 00:00:00	8	171.6
7209	2026-05-24 01:00:00	48	198
7213	2026-05-24 01:00:00	47	28.42
7224	2026-05-24 01:00:00	50	20
7235	2026-05-24 01:00:00	46	20
7245	2026-05-24 01:00:00	49	20
7489	2026-05-24 06:00:00	40	20
7498	2026-05-24 06:00:00	36	20
7501	2026-05-24 07:00:00	6	12
7518	2026-05-24 07:00:00	7	24.24
7528	2026-05-24 07:00:00	8	171.6
7534	2026-05-24 07:00:00	10	20
7542	2026-05-24 07:00:00	9	20
7560	2026-05-24 08:00:00	43	198
7563	2026-05-24 08:00:00	41	20
7576	2026-05-24 08:00:00	42	28.29
7586	2026-05-24 08:00:00	45	20
7598	2026-05-24 08:00:00	44	20
7603	2026-05-24 09:00:00	9	20
7616	2026-05-24 09:00:00	6	12
7629	2026-05-24 09:00:00	7	24.36
7639	2026-05-24 09:00:00	8	171.6
7650	2026-05-24 09:00:00	10	20
7651	2026-05-24 10:00:00	1	12
7661	2026-05-24 10:00:00	3	171.6
7671	2026-05-24 10:00:00	4	20
7687	2026-05-24 10:00:00	2	24.27
7696	2026-05-24 10:00:00	5	20
7705	2026-05-24 11:00:00	19	20
7713	2026-05-24 11:00:00	20	20
7722	2026-05-24 11:00:00	26	20
7732	2026-05-24 11:00:00	29	20
7741	2026-05-24 11:00:00	28	198
7749	2026-05-24 11:00:00	30	20
7753	2026-05-24 12:00:00	6	12
7761	2026-05-24 12:00:00	7	24.31
7768	2026-05-24 12:00:00	8	171.6
7773	2026-05-24 12:00:00	10	20
7782	2026-05-24 12:00:00	9	20
7810	2026-05-24 13:00:00	50	20
7814	2026-05-24 13:00:00	46	20
7823	2026-05-24 13:00:00	49	20
7832	2026-05-24 13:00:00	48	198
7844	2026-05-24 13:00:00	47	28.41
7856	2026-05-24 14:00:00	28	198
7862	2026-05-24 14:00:00	30	20
7871	2026-05-24 14:00:00	27	28.47
7882	2026-05-24 14:00:00	26	20
7892	2026-05-24 14:00:00	29	20
7910	2026-05-24 15:00:00	49	20
7923	2026-05-24 15:00:00	48	198
7935	2026-05-24 15:00:00	47	28.42
7944	2026-05-24 15:00:00	50	20
7946	2026-05-24 15:00:00	46	20
7955	2026-05-24 16:00:00	17	28.45
7972	2026-05-24 16:00:00	19	20
7983	2026-05-24 16:00:00	20	20
7992	2026-05-24 16:00:00	18	198
7999	2026-05-24 16:00:00	16	20
8002	2026-05-24 17:00:00	10	20
8012	2026-05-24 17:00:00	9	20
8022	2026-05-24 17:00:00	6	12
8031	2026-05-24 17:00:00	7	24.28
8034	2026-05-24 17:00:00	8	171.6
8060	2026-05-24 18:00:00	46	20
8070	2026-05-24 18:00:00	49	20
8078	2026-05-24 18:00:00	48	198
8085	2026-05-24 18:00:00	47	28.36
8096	2026-05-24 18:00:00	50	20
8104	2026-05-24 19:00:00	23	198
8113	2026-05-24 19:00:00	21	20
8124	2026-05-24 19:00:00	22	28.42
8134	2026-05-24 19:00:00	25	20
8143	2026-05-24 19:00:00	24	20
8156	2026-05-24 20:00:00	34	20
8164	2026-05-24 20:00:00	32	28.29
8176	2026-05-24 20:00:00	35	20
8189	2026-05-24 20:00:00	33	198
8193	2026-05-24 20:00:00	31	20
8208	2026-05-24 21:00:00	44	20
8215	2026-05-24 21:00:00	43	198
8227	2026-05-24 21:00:00	41	20
8238	2026-05-24 21:00:00	42	28.23
8247	2026-05-24 21:00:00	45	20
8253	2026-05-24 22:00:00	15	20
8265	2026-05-24 22:00:00	12	28.49
8271	2026-05-24 22:00:00	14	20
8282	2026-05-24 22:00:00	11	20
8293	2026-05-24 22:00:00	13	198
8309	2026-05-24 23:00:00	37	28.42
8317	2026-05-24 23:00:00	39	20
8327	2026-05-24 23:00:00	40	20
6753	2026-05-23 16:00:00	12	28.42
6767	2026-05-23 16:00:00	14	20
6779	2026-05-23 16:00:00	11	20
6788	2026-05-23 16:00:00	13	198
6794	2026-05-23 16:00:00	15	20
6808	2026-05-23 17:00:00	35	20
6816	2026-05-23 17:00:00	33	198
6824	2026-05-23 17:00:00	31	20
6834	2026-05-23 17:00:00	34	20
6844	2026-05-23 17:00:00	32	28.22
6859	2026-05-23 18:00:00	42	28.41
6862	2026-05-23 18:00:00	45	20
6871	2026-05-23 18:00:00	44	20
6882	2026-05-23 18:00:00	43	198
6893	2026-05-23 18:00:00	41	20
6905	2026-05-23 19:00:00	18	198
6918	2026-05-23 19:00:00	16	20
6928	2026-05-23 19:00:00	17	28.35
6938	2026-05-23 19:00:00	19	20
6947	2026-05-23 19:00:00	20	20
6952	2026-05-23 20:00:00	6	12
6963	2026-05-23 20:00:00	7	24.3
6974	2026-05-23 20:00:00	8	171.6
6983	2026-05-23 20:00:00	10	20
6994	2026-05-23 20:00:00	9	20
7009	2026-05-23 21:00:00	32	28.44
7018	2026-05-23 21:00:00	35	20
7034	2026-05-23 21:00:00	33	198
7045	2026-05-23 21:00:00	31	20
7050	2026-05-23 21:00:00	34	20
7051	2026-05-23 22:00:00	3	171.6
7062	2026-05-23 22:00:00	4	20
7075	2026-05-23 22:00:00	2	24.4
7086	2026-05-23 22:00:00	5	20
7097	2026-05-23 22:00:00	1	12
7106	2026-05-23 23:00:00	28	198
7119	2026-05-23 23:00:00	30	20
7132	2026-05-23 23:00:00	27	28.47
7143	2026-05-23 23:00:00	26	20
7150	2026-05-23 23:00:00	29	20
7151	2026-05-24 00:00:00	5	20
7167	2026-05-24 00:00:00	1	12
7177	2026-05-24 00:00:00	3	171.6
7188	2026-05-24 00:00:00	4	20
7197	2026-05-24 00:00:00	2	24.22
7208	2026-05-24 01:00:00	12	28.23
7215	2026-05-24 01:00:00	14	20
7229	2026-05-24 01:00:00	11	20
7237	2026-05-24 01:00:00	13	198
7246	2026-05-24 01:00:00	15	20
7490	2026-05-24 06:00:00	12	28.38
7499	2026-05-24 06:00:00	14	20
7505	2026-05-24 07:00:00	21	20
7517	2026-05-24 07:00:00	22	28.4
7525	2026-05-24 07:00:00	25	20
7537	2026-05-24 07:00:00	24	20
7546	2026-05-24 07:00:00	23	198
7553	2026-05-24 08:00:00	9	20
7572	2026-05-24 08:00:00	6	12
7583	2026-05-24 08:00:00	7	24.43
7595	2026-05-24 08:00:00	8	171.6
7600	2026-05-24 08:00:00	10	20
7601	2026-05-24 09:00:00	5	20
7615	2026-05-24 09:00:00	1	12
7627	2026-05-24 09:00:00	3	171.6
7635	2026-05-24 09:00:00	4	20
7647	2026-05-24 09:00:00	2	24.37
7652	2026-05-24 10:00:00	11	20
7663	2026-05-24 10:00:00	13	198
7676	2026-05-24 10:00:00	15	20
7685	2026-05-24 10:00:00	12	28.37
7695	2026-05-24 10:00:00	14	20
7710	2026-05-24 11:00:00	27	28.33
7723	2026-05-24 11:00:00	50	20
7733	2026-05-24 11:00:00	46	20
7743	2026-05-24 11:00:00	49	20
7750	2026-05-24 11:00:00	48	198
7752	2026-05-24 12:00:00	2	24.2
7763	2026-05-24 12:00:00	5	20
7777	2026-05-24 12:00:00	1	12
7789	2026-05-24 12:00:00	3	171.6
7797	2026-05-24 12:00:00	4	20
7804	2026-05-24 13:00:00	20	20
7815	2026-05-24 13:00:00	18	198
7824	2026-05-24 13:00:00	16	20
7829	2026-05-24 13:00:00	17	28.41
7836	2026-05-24 13:00:00	19	20
7858	2026-05-24 14:00:00	44	20
7861	2026-05-24 14:00:00	43	198
7872	2026-05-24 14:00:00	41	20
7883	2026-05-24 14:00:00	42	28.27
7894	2026-05-24 14:00:00	45	20
7907	2026-05-24 15:00:00	34	20
7921	2026-05-24 15:00:00	32	28.43
7931	2026-05-24 15:00:00	35	20
7943	2026-05-24 15:00:00	33	198
7950	2026-05-24 15:00:00	31	20
7952	2026-05-24 16:00:00	7	24.43
7965	2026-05-24 16:00:00	8	171.6
7977	2026-05-24 16:00:00	10	20
7987	2026-05-24 16:00:00	9	20
7995	2026-05-24 16:00:00	6	12
8007	2026-05-24 17:00:00	27	28.31
8018	2026-05-24 17:00:00	26	20
8030	2026-05-24 17:00:00	29	20
8040	2026-05-24 17:00:00	28	198
8050	2026-05-24 17:00:00	30	20
8051	2026-05-24 18:00:00	2	24.27
8064	2026-05-24 18:00:00	5	20
8075	2026-05-24 18:00:00	1	12
8084	2026-05-24 18:00:00	3	171.6
8093	2026-05-24 18:00:00	4	20
8108	2026-05-24 19:00:00	34	20
8117	2026-05-24 19:00:00	32	28.38
8126	2026-05-24 19:00:00	35	20
8139	2026-05-24 19:00:00	33	198
8149	2026-05-24 19:00:00	31	20
8154	2026-05-24 20:00:00	11	20
8163	2026-05-24 20:00:00	13	198
8175	2026-05-24 20:00:00	15	20
8185	2026-05-24 20:00:00	12	28.4
8196	2026-05-24 20:00:00	14	20
8204	2026-05-24 21:00:00	25	20
8212	2026-05-24 21:00:00	24	20
8224	2026-05-24 21:00:00	23	198
8233	2026-05-24 21:00:00	21	20
8242	2026-05-24 21:00:00	22	28.36
8259	2026-05-24 22:00:00	44	20
8270	2026-05-24 22:00:00	45	20
8280	2026-05-24 22:00:00	43	198
8292	2026-05-24 22:00:00	41	20
8300	2026-05-24 22:00:00	42	28.4
8301	2026-05-24 23:00:00	4	20
8314	2026-05-24 23:00:00	1	12
8328	2026-05-24 23:00:00	3	171.6
8337	2026-05-24 23:00:00	2	24.26
6754	2026-05-23 16:00:00	25	20
6761	2026-05-23 16:00:00	24	20
6770	2026-05-23 16:00:00	23	198
6776	2026-05-23 16:00:00	21	20
6782	2026-05-23 16:00:00	22	28.24
6810	2026-05-23 17:00:00	47	28.42
6823	2026-05-23 17:00:00	50	20
6833	2026-05-23 17:00:00	46	20
6840	2026-05-23 17:00:00	49	20
6846	2026-05-23 17:00:00	48	198
6854	2026-05-23 18:00:00	22	28.36
6864	2026-05-23 18:00:00	25	20
6874	2026-05-23 18:00:00	24	20
6884	2026-05-23 18:00:00	23	198
6897	2026-05-23 18:00:00	21	20
6904	2026-05-23 19:00:00	23	198
6911	2026-05-23 19:00:00	21	20
6926	2026-05-23 19:00:00	22	28.41
6935	2026-05-23 19:00:00	25	20
6945	2026-05-23 19:00:00	24	20
6956	2026-05-23 20:00:00	32	28.44
6967	2026-05-23 20:00:00	35	20
6980	2026-05-23 20:00:00	33	198
6990	2026-05-23 20:00:00	31	20
6996	2026-05-23 20:00:00	34	20
7003	2026-05-23 21:00:00	12	28.31
7012	2026-05-23 21:00:00	14	20
7022	2026-05-23 21:00:00	11	20
7030	2026-05-23 21:00:00	13	198
7043	2026-05-23 21:00:00	15	20
7054	2026-05-23 22:00:00	35	20
7069	2026-05-23 22:00:00	33	198
7083	2026-05-23 22:00:00	31	20
7094	2026-05-23 22:00:00	34	20
7100	2026-05-23 22:00:00	32	28.29
7101	2026-05-23 23:00:00	5	20
7111	2026-05-23 23:00:00	1	12
7117	2026-05-23 23:00:00	3	171.6
7125	2026-05-23 23:00:00	4	20
7138	2026-05-23 23:00:00	2	24.41
7160	2026-05-24 00:00:00	48	198
7165	2026-05-24 00:00:00	47	28.49
7174	2026-05-24 00:00:00	50	20
7185	2026-05-24 00:00:00	46	20
7195	2026-05-24 00:00:00	49	20
7204	2026-05-24 01:00:00	29	20
7216	2026-05-24 01:00:00	28	198
7227	2026-05-24 01:00:00	30	20
7238	2026-05-24 01:00:00	27	28.37
7248	2026-05-24 01:00:00	26	20
7701	2026-05-24 11:00:00	2	24.45
7714	2026-05-24 11:00:00	5	20
7724	2026-05-24 11:00:00	24	20
7734	2026-05-24 11:00:00	23	198
7744	2026-05-24 11:00:00	21	20
7757	2026-05-24 12:00:00	27	41.29
7766	2026-05-24 12:00:00	26	46
7780	2026-05-24 12:00:00	29	20
7790	2026-05-24 12:00:00	28	283.8
7796	2026-05-24 12:00:00	30	20
7806	2026-05-24 13:00:00	22	28.49
7818	2026-05-24 13:00:00	25	20
7833	2026-05-24 13:00:00	24	20
7842	2026-05-24 13:00:00	23	198
7848	2026-05-24 13:00:00	21	20
7855	2026-05-24 14:00:00	19	20
7870	2026-05-24 14:00:00	20	20
7880	2026-05-24 14:00:00	18	198
7890	2026-05-24 14:00:00	16	20
7900	2026-05-24 14:00:00	17	28.26
7903	2026-05-24 15:00:00	10	20
7912	2026-05-24 15:00:00	9	20
7919	2026-05-24 15:00:00	6	12
7927	2026-05-24 15:00:00	7	24.4
7936	2026-05-24 15:00:00	8	171.6
7959	2026-05-24 16:00:00	44	20
7969	2026-05-24 16:00:00	43	198
7981	2026-05-24 16:00:00	41	20
7991	2026-05-24 16:00:00	42	28.48
7996	2026-05-24 16:00:00	45	20
8003	2026-05-24 17:00:00	12	28.2
8014	2026-05-24 17:00:00	14	20
8023	2026-05-24 17:00:00	11	20
8037	2026-05-24 17:00:00	13	198
8047	2026-05-24 17:00:00	15	20
8053	2026-05-24 18:00:00	16	20
8065	2026-05-24 18:00:00	17	28.43
8077	2026-05-24 18:00:00	19	20
8088	2026-05-24 18:00:00	20	20
8099	2026-05-24 18:00:00	18	198
8102	2026-05-24 19:00:00	7	24.35
8111	2026-05-24 19:00:00	8	171.6
8122	2026-05-24 19:00:00	10	20
8131	2026-05-24 19:00:00	9	20
8141	2026-05-24 19:00:00	6	12
8158	2026-05-24 20:00:00	45	20
8168	2026-05-24 20:00:00	44	20
8180	2026-05-24 20:00:00	43	198
8191	2026-05-24 20:00:00	41	20
8199	2026-05-24 20:00:00	42	28.25
8202	2026-05-24 21:00:00	6	12
8216	2026-05-24 21:00:00	7	24.46
8228	2026-05-24 21:00:00	8	171.6
8236	2026-05-24 21:00:00	10	20
8243	2026-05-24 21:00:00	9	20
8257	2026-05-24 22:00:00	38	198
8266	2026-05-24 22:00:00	36	20
8272	2026-05-24 22:00:00	37	28.4
8281	2026-05-24 22:00:00	39	20
8290	2026-05-24 22:00:00	40	20
8308	2026-05-24 23:00:00	46	20
8318	2026-05-24 23:00:00	49	20
8332	2026-05-24 23:00:00	48	198
8338	2026-05-24 23:00:00	38	198
8339	2026-05-24 23:00:00	47	28.31
8345	2026-05-24 23:00:00	36	20
8346	2026-05-24 23:00:00	50	20
6755	2026-05-23 16:00:00	32	28.28
6768	2026-05-23 16:00:00	35	20
6780	2026-05-23 16:00:00	33	198
6790	2026-05-23 16:00:00	31	20
6798	2026-05-23 16:00:00	34	20
6802	2026-05-23 17:00:00	15	20
6811	2026-05-23 17:00:00	12	28.49
6820	2026-05-23 17:00:00	14	20
6828	2026-05-23 17:00:00	11	20
6836	2026-05-23 17:00:00	13	198
6860	2026-05-23 18:00:00	50	20
6870	2026-05-23 18:00:00	46	20
6880	2026-05-23 18:00:00	49	20
6890	2026-05-23 18:00:00	48	198
6896	2026-05-23 18:00:00	47	28.3
6908	2026-05-23 19:00:00	28	198
6913	2026-05-23 19:00:00	30	20
6921	2026-05-23 19:00:00	27	28.2
6930	2026-05-23 19:00:00	26	20
6941	2026-05-23 19:00:00	29	20
6959	2026-05-23 20:00:00	41	20
6962	2026-05-23 20:00:00	42	28.24
6971	2026-05-23 20:00:00	45	20
6977	2026-05-23 20:00:00	44	20
6987	2026-05-23 20:00:00	43	198
7005	2026-05-23 21:00:00	39	20
7013	2026-05-23 21:00:00	40	20
7023	2026-05-23 21:00:00	36	20
7033	2026-05-23 21:00:00	38	198
7042	2026-05-23 21:00:00	37	28.31
7058	2026-05-23 22:00:00	21	20
7068	2026-05-23 22:00:00	22	28.22
7082	2026-05-23 22:00:00	25	20
7089	2026-05-23 22:00:00	24	20
7098	2026-05-23 22:00:00	23	198
7102	2026-05-23 23:00:00	14	20
7115	2026-05-23 23:00:00	11	20
7127	2026-05-23 23:00:00	13	198
7140	2026-05-23 23:00:00	15	20
7146	2026-05-23 23:00:00	12	28.39
7153	2026-05-24 00:00:00	19	20
7163	2026-05-24 00:00:00	20	20
7173	2026-05-24 00:00:00	18	198
7184	2026-05-24 00:00:00	16	20
7194	2026-05-24 00:00:00	17	28.43
7210	2026-05-24 01:00:00	37	28.43
7212	2026-05-24 01:00:00	39	20
7225	2026-05-24 01:00:00	40	20
7236	2026-05-24 01:00:00	36	20
7244	2026-05-24 01:00:00	38	198
7709	2026-05-24 11:00:00	47	28.37
7725	2026-05-24 11:00:00	1	12
7736	2026-05-24 11:00:00	3	171.6
7746	2026-05-24 11:00:00	4	20
7754	2026-05-24 12:00:00	22	41.22
7764	2026-05-24 12:00:00	25	20
7772	2026-05-24 12:00:00	24	20
7778	2026-05-24 12:00:00	23	283.8
7786	2026-05-24 12:00:00	21	46
7808	2026-05-24 13:00:00	43	198
7813	2026-05-24 13:00:00	41	20
7822	2026-05-24 13:00:00	42	28.47
7830	2026-05-24 13:00:00	45	20
7840	2026-05-24 13:00:00	44	20
7857	2026-05-24 14:00:00	38	198
7869	2026-05-24 14:00:00	37	28.21
7874	2026-05-24 14:00:00	39	20
7884	2026-05-24 14:00:00	40	20
7893	2026-05-24 14:00:00	36	20
7906	2026-05-24 15:00:00	28	198
7915	2026-05-24 15:00:00	30	20
7928	2026-05-24 15:00:00	27	28.38
7940	2026-05-24 15:00:00	26	20
7948	2026-05-24 15:00:00	29	20
7954	2026-05-24 16:00:00	13	198
7961	2026-05-24 16:00:00	15	20
7970	2026-05-24 16:00:00	12	28.22
7975	2026-05-24 16:00:00	14	20
7985	2026-05-24 16:00:00	11	20
8009	2026-05-24 17:00:00	43	198
8016	2026-05-24 17:00:00	41	20
8028	2026-05-24 17:00:00	42	28.35
8039	2026-05-24 17:00:00	45	20
8045	2026-05-24 17:00:00	44	20
8058	2026-05-24 18:00:00	45	20
8068	2026-05-24 18:00:00	44	20
8079	2026-05-24 18:00:00	43	198
8089	2026-05-24 18:00:00	41	20
8095	2026-05-24 18:00:00	42	28.4
8109	2026-05-24 19:00:00	47	28.46
8115	2026-05-24 19:00:00	50	20
8121	2026-05-24 19:00:00	46	20
8128	2026-05-24 19:00:00	49	20
8137	2026-05-24 19:00:00	48	198
8159	2026-05-24 20:00:00	47	28.33
8170	2026-05-24 20:00:00	50	20
8179	2026-05-24 20:00:00	46	20
8187	2026-05-24 20:00:00	49	20
8195	2026-05-24 20:00:00	48	198
8205	2026-05-24 21:00:00	32	28.3
8217	2026-05-24 21:00:00	35	20
8226	2026-05-24 21:00:00	33	198
8237	2026-05-24 21:00:00	31	20
8246	2026-05-24 21:00:00	34	20
8254	2026-05-24 22:00:00	25	20
8261	2026-05-24 22:00:00	24	20
8273	2026-05-24 22:00:00	23	198
8285	2026-05-24 22:00:00	21	20
8295	2026-05-24 22:00:00	22	28.48
8305	2026-05-24 23:00:00	14	20
8320	2026-05-24 23:00:00	11	20
8333	2026-05-24 23:00:00	13	198
8343	2026-05-24 23:00:00	15	20
8348	2026-05-24 23:00:00	5	20
8350	2026-05-24 23:00:00	12	28.37
5859	2026-05-22 22:00:00	38	198
5868	2026-05-22 22:00:00	37	28.32
5873	2026-05-22 22:00:00	39	20
5885	2026-05-22 22:00:00	40	20
5896	2026-05-22 22:00:00	36	20
5905	2026-05-22 23:00:00	10	20
5920	2026-05-22 23:00:00	9	20
5929	2026-05-22 23:00:00	6	12
5937	2026-05-22 23:00:00	7	24.23
5946	2026-05-22 23:00:00	8	171.6
5953	2026-05-23 00:00:00	9	20
5969	2026-05-23 00:00:00	6	12
5979	2026-05-23 00:00:00	7	24.4
5989	2026-05-23 00:00:00	8	171.6
6000	2026-05-23 00:00:00	10	20
6001	2026-05-23 01:00:00	1	12
6015	2026-05-23 01:00:00	3	171.6
6025	2026-05-23 01:00:00	4	20
6040	2026-05-23 01:00:00	2	24.43
6046	2026-05-23 01:00:00	5	20
6055	2026-05-23 02:00:00	35	20
6072	2026-05-23 02:00:00	33	198
6082	2026-05-23 02:00:00	31	20
6092	2026-05-23 02:00:00	34	20
6100	2026-05-23 02:00:00	32	28.4
6101	2026-05-23 03:00:00	5	20
6113	2026-05-23 03:00:00	1	12
6125	2026-05-23 03:00:00	3	171.6
6140	2026-05-23 03:00:00	4	20
6148	2026-05-23 03:00:00	2	24.3
6152	2026-05-23 04:00:00	11	20
6162	2026-05-23 04:00:00	13	198
6172	2026-05-23 04:00:00	15	20
6185	2026-05-23 04:00:00	12	28.37
6195	2026-05-23 04:00:00	14	20
6205	2026-05-23 05:00:00	22	28.27
6214	2026-05-23 05:00:00	25	20
6222	2026-05-23 05:00:00	24	20
6232	2026-05-23 05:00:00	23	198
6242	2026-05-23 05:00:00	21	20
6257	2026-05-23 06:00:00	38	198
6269	2026-05-23 06:00:00	37	28.38
6280	2026-05-23 06:00:00	39	20
6290	2026-05-23 06:00:00	40	20
6299	2026-05-23 06:00:00	36	20
6301	2026-05-23 07:00:00	7	24.23
6315	2026-05-23 07:00:00	8	171.6
6326	2026-05-23 07:00:00	10	20
6338	2026-05-23 07:00:00	9	20
6346	2026-05-23 07:00:00	6	12
6355	2026-05-23 08:00:00	25	20
6369	2026-05-23 08:00:00	24	20
6377	2026-05-23 08:00:00	23	198
6390	2026-05-23 08:00:00	21	20
6399	2026-05-23 08:00:00	22	28.25
6402	2026-05-23 09:00:00	7	24.39
6417	2026-05-23 09:00:00	8	171.6
6429	2026-05-23 09:00:00	10	20
6438	2026-05-23 09:00:00	9	20
6447	2026-05-23 09:00:00	6	12
6452	2026-05-23 10:00:00	16	20
6470	2026-05-23 10:00:00	19	20
6479	2026-05-23 10:00:00	20	20
6484	2026-05-23 10:00:00	18	198
6497	2026-05-23 10:00:00	17	28.29
6506	2026-05-23 11:00:00	29	20
6514	2026-05-23 11:00:00	28	198
6521	2026-05-23 11:00:00	30	20
6530	2026-05-23 11:00:00	27	28.25
6541	2026-05-23 11:00:00	26	20
6558	2026-05-23 12:00:00	39	20
6567	2026-05-23 12:00:00	40	20
6571	2026-05-23 12:00:00	36	46
6580	2026-05-23 12:00:00	38	283.8
6586	2026-05-23 12:00:00	37	41.45
6606	2026-05-23 13:00:00	35	20
6617	2026-05-23 13:00:00	33	198
6629	2026-05-23 13:00:00	31	20
6641	2026-05-23 13:00:00	34	20
6649	2026-05-23 13:00:00	32	28.43
6653	2026-05-23 14:00:00	9	20
6666	2026-05-23 14:00:00	6	12
6676	2026-05-23 14:00:00	7	24.31
6689	2026-05-23 14:00:00	8	171.6
6698	2026-05-23 14:00:00	10	20
6704	2026-05-23 15:00:00	9	20
6711	2026-05-23 15:00:00	6	12
6719	2026-05-23 15:00:00	7	24.48
6725	2026-05-23 15:00:00	8	171.6
6734	2026-05-23 15:00:00	10	20
7712	2026-05-24 11:00:00	10	20
7726	2026-05-24 11:00:00	14	20
7737	2026-05-24 11:00:00	11	20
7747	2026-05-24 11:00:00	13	198
7755	2026-05-24 12:00:00	19	20
7767	2026-05-24 12:00:00	20	20
7781	2026-05-24 12:00:00	18	283.8
7791	2026-05-24 12:00:00	16	46
7795	2026-05-24 12:00:00	17	41.25
7807	2026-05-24 13:00:00	38	198
7816	2026-05-24 13:00:00	37	28.39
7826	2026-05-24 13:00:00	39	20
7838	2026-05-24 13:00:00	40	20
7846	2026-05-24 13:00:00	36	20
7853	2026-05-24 14:00:00	15	20
7865	2026-05-24 14:00:00	12	28.22
7875	2026-05-24 14:00:00	14	20
7888	2026-05-24 14:00:00	11	20
7899	2026-05-24 14:00:00	13	198
7902	2026-05-24 15:00:00	2	24.22
7913	2026-05-24 15:00:00	5	20
7920	2026-05-24 15:00:00	1	12
7929	2026-05-24 15:00:00	3	171.6
7939	2026-05-24 15:00:00	4	20
7957	2026-05-24 16:00:00	34	20
7962	2026-05-24 16:00:00	32	28.23
7971	2026-05-24 16:00:00	35	20
7976	2026-05-24 16:00:00	33	198
7986	2026-05-24 16:00:00	31	20
8010	2026-05-24 17:00:00	48	198
8019	2026-05-24 17:00:00	47	28.25
8024	2026-05-24 17:00:00	50	20
8032	2026-05-24 17:00:00	46	20
8042	2026-05-24 17:00:00	49	20
8059	2026-05-24 18:00:00	38	198
8062	2026-05-24 18:00:00	37	28.4
8072	2026-05-24 18:00:00	39	20
8082	2026-05-24 18:00:00	40	20
8094	2026-05-24 18:00:00	36	20
8107	2026-05-24 19:00:00	18	198
8120	2026-05-24 19:00:00	16	20
8132	2026-05-24 19:00:00	17	28.28
8142	2026-05-24 19:00:00	19	20
8150	2026-05-24 19:00:00	20	20
8151	2026-05-24 20:00:00	2	24.47
8162	2026-05-24 20:00:00	5	20
6756	2026-05-23 16:00:00	19	20
6764	2026-05-23 16:00:00	20	20
6773	2026-05-23 16:00:00	18	198
6786	2026-05-23 16:00:00	16	20
6792	2026-05-23 16:00:00	17	28.28
6806	2026-05-23 17:00:00	39	20
6812	2026-05-23 17:00:00	40	20
6821	2026-05-23 17:00:00	36	20
6827	2026-05-23 17:00:00	38	198
6838	2026-05-23 17:00:00	37	28.43
6855	2026-05-23 18:00:00	38	198
6868	2026-05-23 18:00:00	37	28.39
6878	2026-05-23 18:00:00	39	20
6886	2026-05-23 18:00:00	40	20
6894	2026-05-23 18:00:00	36	20
6906	2026-05-23 19:00:00	35	20
6917	2026-05-23 19:00:00	33	198
6927	2026-05-23 19:00:00	31	20
6936	2026-05-23 19:00:00	34	20
6948	2026-05-23 19:00:00	32	28.47
6955	2026-05-23 20:00:00	20	20
6969	2026-05-23 20:00:00	18	198
6981	2026-05-23 20:00:00	16	20
6991	2026-05-23 20:00:00	17	28.32
7000	2026-05-23 20:00:00	19	20
7001	2026-05-23 21:00:00	2	24.25
7011	2026-05-23 21:00:00	5	20
7021	2026-05-23 21:00:00	1	12
7027	2026-05-23 21:00:00	3	171.6
7039	2026-05-23 21:00:00	4	20
7056	2026-05-23 22:00:00	36	20
7064	2026-05-23 22:00:00	38	198
7072	2026-05-23 22:00:00	37	28.45
7077	2026-05-23 22:00:00	39	20
7087	2026-05-23 22:00:00	40	20
7108	2026-05-23 23:00:00	41	20
7118	2026-05-23 23:00:00	42	28.42
7128	2026-05-23 23:00:00	45	20
7135	2026-05-23 23:00:00	44	20
7141	2026-05-23 23:00:00	43	198
7156	2026-05-24 00:00:00	33	198
7161	2026-05-24 00:00:00	31	20
7171	2026-05-24 00:00:00	34	20
7180	2026-05-24 00:00:00	32	28.36
7190	2026-05-24 00:00:00	35	20
7207	2026-05-24 01:00:00	41	20
7217	2026-05-24 01:00:00	42	28.45
7222	2026-05-24 01:00:00	45	20
7233	2026-05-24 01:00:00	44	20
7242	2026-05-24 01:00:00	43	198
7715	2026-05-24 11:00:00	25	20
7730	2026-05-24 11:00:00	34	20
7740	2026-05-24 11:00:00	32	28.35
7745	2026-05-24 11:00:00	35	20
7756	2026-05-24 12:00:00	33	283.8
7765	2026-05-24 12:00:00	31	46
7779	2026-05-24 12:00:00	34	20
7788	2026-05-24 12:00:00	32	41.48
7798	2026-05-24 12:00:00	35	20
7803	2026-05-24 13:00:00	14	20
7819	2026-05-24 13:00:00	11	20
7828	2026-05-24 13:00:00	13	198
7839	2026-05-24 13:00:00	15	20
7847	2026-05-24 13:00:00	12	28.39
7854	2026-05-24 14:00:00	24	20
7867	2026-05-24 14:00:00	23	198
7878	2026-05-24 14:00:00	21	20
7889	2026-05-24 14:00:00	22	28.26
7898	2026-05-24 14:00:00	25	20
7905	2026-05-24 15:00:00	25	20
7916	2026-05-24 15:00:00	24	20
7925	2026-05-24 15:00:00	23	198
7933	2026-05-24 15:00:00	21	20
7942	2026-05-24 15:00:00	22	28.49
7958	2026-05-24 16:00:00	38	198
7967	2026-05-24 16:00:00	37	28.3
7980	2026-05-24 16:00:00	39	20
7990	2026-05-24 16:00:00	40	20
7998	2026-05-24 16:00:00	36	20
8006	2026-05-24 17:00:00	25	20
8013	2026-05-24 17:00:00	24	20
8029	2026-05-24 17:00:00	23	198
8041	2026-05-24 17:00:00	21	20
8049	2026-05-24 17:00:00	22	28.27
8052	2026-05-24 18:00:00	8	171.6
8066	2026-05-24 18:00:00	10	20
8076	2026-05-24 18:00:00	9	20
8087	2026-05-24 18:00:00	6	12
8098	2026-05-24 18:00:00	7	24.22
8103	2026-05-24 19:00:00	11	20
8114	2026-05-24 19:00:00	13	198
8125	2026-05-24 19:00:00	15	20
8135	2026-05-24 19:00:00	12	28.44
8144	2026-05-24 19:00:00	14	20
8157	2026-05-24 20:00:00	28	198
8166	2026-05-24 20:00:00	30	20
8171	2026-05-24 20:00:00	27	28.45
8177	2026-05-24 20:00:00	26	20
8186	2026-05-24 20:00:00	29	20
8207	2026-05-24 21:00:00	50	20
8214	2026-05-24 21:00:00	46	20
8225	2026-05-24 21:00:00	49	20
8234	2026-05-24 21:00:00	48	198
8244	2026-05-24 21:00:00	47	28.48
8256	2026-05-24 22:00:00	27	28.44
8268	2026-05-24 22:00:00	26	20
8279	2026-05-24 22:00:00	29	20
8289	2026-05-24 22:00:00	28	198
8298	2026-05-24 22:00:00	30	20
8310	2026-05-24 23:00:00	26	20
8319	2026-05-24 23:00:00	29	20
8331	2026-05-24 23:00:00	28	198
8344	2026-05-24 23:00:00	30	20
8349	2026-05-24 23:00:00	27	28.41
6758	2026-05-23 16:00:00	37	28.34
6762	2026-05-23 16:00:00	39	20
6771	2026-05-23 16:00:00	40	20
6777	2026-05-23 16:00:00	36	20
6783	2026-05-23 16:00:00	38	198
6809	2026-05-23 17:00:00	41	20
6819	2026-05-23 17:00:00	42	28.33
6832	2026-05-23 17:00:00	45	20
6841	2026-05-23 17:00:00	44	20
6849	2026-05-23 17:00:00	43	198
6853	2026-05-23 18:00:00	16	20
6866	2026-05-23 18:00:00	17	28.32
6873	2026-05-23 18:00:00	19	20
6883	2026-05-23 18:00:00	20	20
6891	2026-05-23 18:00:00	18	198
6909	2026-05-23 19:00:00	41	20
6916	2026-05-23 19:00:00	42	28.32
6922	2026-05-23 19:00:00	45	20
6931	2026-05-23 19:00:00	44	20
6942	2026-05-23 19:00:00	43	198
6958	2026-05-23 20:00:00	39	20
6966	2026-05-23 20:00:00	40	20
6973	2026-05-23 20:00:00	36	20
6986	2026-05-23 20:00:00	38	198
6995	2026-05-23 20:00:00	37	28.37
7006	2026-05-23 21:00:00	28	198
7015	2026-05-23 21:00:00	30	20
7024	2026-05-23 21:00:00	27	28.28
7032	2026-05-23 21:00:00	26	20
7036	2026-05-23 21:00:00	29	20
7060	2026-05-23 22:00:00	47	28.35
7065	2026-05-23 22:00:00	50	20
7073	2026-05-23 22:00:00	46	20
7078	2026-05-23 22:00:00	49	20
7090	2026-05-23 22:00:00	48	198
7110	2026-05-23 23:00:00	37	28.44
7121	2026-05-23 23:00:00	39	20
7129	2026-05-23 23:00:00	40	20
7136	2026-05-23 23:00:00	36	20
7147	2026-05-23 23:00:00	38	198
7155	2026-05-24 00:00:00	24	20
7164	2026-05-24 00:00:00	23	198
7175	2026-05-24 00:00:00	21	20
7179	2026-05-24 00:00:00	22	28.21
7191	2026-05-24 00:00:00	25	20
7206	2026-05-24 01:00:00	33	198
7219	2026-05-24 01:00:00	31	20
7231	2026-05-24 01:00:00	34	20
7240	2026-05-24 01:00:00	32	28.26
7250	2026-05-24 01:00:00	35	20
7716	2026-05-24 11:00:00	12	28.49
7731	2026-05-24 11:00:00	43	198
7742	2026-05-24 11:00:00	41	20
7748	2026-05-24 11:00:00	42	28.36
7751	2026-05-24 12:00:00	15	20
7762	2026-05-24 12:00:00	12	41.38
7776	2026-05-24 12:00:00	14	20
7787	2026-05-24 12:00:00	11	46
7799	2026-05-24 12:00:00	13	283.8
7802	2026-05-24 13:00:00	10	20
7811	2026-05-24 13:00:00	9	20
7820	2026-05-24 13:00:00	6	12
7825	2026-05-24 13:00:00	7	24.25
7834	2026-05-24 13:00:00	8	171.6
7859	2026-05-24 14:00:00	48	198
7866	2026-05-24 14:00:00	47	28.21
7877	2026-05-24 14:00:00	50	20
7887	2026-05-24 14:00:00	46	20
7896	2026-05-24 14:00:00	49	20
7901	2026-05-24 15:00:00	13	198
7911	2026-05-24 15:00:00	15	20
7918	2026-05-24 15:00:00	12	28.26
7926	2026-05-24 15:00:00	14	20
7937	2026-05-24 15:00:00	11	20
7960	2026-05-24 16:00:00	49	20
7968	2026-05-24 16:00:00	48	198
7979	2026-05-24 16:00:00	47	28.34
7989	2026-05-24 16:00:00	50	20
8000	2026-05-24 16:00:00	46	20
8001	2026-05-24 17:00:00	1	12
8011	2026-05-24 17:00:00	3	171.6
8021	2026-05-24 17:00:00	4	20
8033	2026-05-24 17:00:00	2	24.42
8044	2026-05-24 17:00:00	5	20
8055	2026-05-24 18:00:00	28	198
8061	2026-05-24 18:00:00	30	20
8071	2026-05-24 18:00:00	27	28.2
8081	2026-05-24 18:00:00	26	20
8091	2026-05-24 18:00:00	29	20
8110	2026-05-24 19:00:00	45	20
8116	2026-05-24 19:00:00	44	20
8127	2026-05-24 19:00:00	43	198
8138	2026-05-24 19:00:00	41	20
8148	2026-05-24 19:00:00	42	28.29
8155	2026-05-24 20:00:00	23	198
8165	2026-05-24 20:00:00	21	20
8174	2026-05-24 20:00:00	22	28.38
8188	2026-05-24 20:00:00	25	20
8197	2026-05-24 20:00:00	24	20
8203	2026-05-24 21:00:00	16	20
8219	2026-05-24 21:00:00	17	28.3
8230	2026-05-24 21:00:00	19	20
8241	2026-05-24 21:00:00	20	20
8250	2026-05-24 21:00:00	18	198
8251	2026-05-24 22:00:00	1	12
8262	2026-05-24 22:00:00	3	171.6
8276	2026-05-24 22:00:00	4	20
8283	2026-05-24 22:00:00	2	24.26
8291	2026-05-24 22:00:00	5	20
8307	2026-05-24 23:00:00	45	20
8311	2026-05-24 23:00:00	43	198
8321	2026-05-24 23:00:00	41	20
8324	2026-05-24 23:00:00	42	28.4
8334	2026-05-24 23:00:00	44	20
6757	2026-05-23 16:00:00	29	20
6769	2026-05-23 16:00:00	28	198
6781	2026-05-23 16:00:00	30	20
6791	2026-05-23 16:00:00	27	28.39
6799	2026-05-23 16:00:00	26	20
6803	2026-05-23 17:00:00	7	24.35
6818	2026-05-23 17:00:00	8	171.6
6831	2026-05-23 17:00:00	10	20
6843	2026-05-23 17:00:00	9	20
6850	2026-05-23 17:00:00	6	12
6851	2026-05-23 18:00:00	2	24.25
6861	2026-05-23 18:00:00	5	20
6872	2026-05-23 18:00:00	1	12
6881	2026-05-23 18:00:00	3	171.6
6892	2026-05-23 18:00:00	4	20
6907	2026-05-23 19:00:00	39	20
6912	2026-05-23 19:00:00	40	20
6924	2026-05-23 19:00:00	36	20
6934	2026-05-23 19:00:00	38	198
6944	2026-05-23 19:00:00	37	28.37
6957	2026-05-23 20:00:00	28	198
6968	2026-05-23 20:00:00	30	20
6979	2026-05-23 20:00:00	27	28.33
6992	2026-05-23 20:00:00	26	20
6999	2026-05-23 20:00:00	29	20
7002	2026-05-23 21:00:00	6	12
7014	2026-05-23 21:00:00	7	24.37
7025	2026-05-23 21:00:00	8	171.6
7038	2026-05-23 21:00:00	10	20
7048	2026-05-23 21:00:00	9	20
7053	2026-05-23 22:00:00	8	171.6
7070	2026-05-23 22:00:00	10	20
7084	2026-05-23 22:00:00	9	20
7093	2026-05-23 22:00:00	6	12
7096	2026-05-23 22:00:00	7	24.38
7104	2026-05-23 23:00:00	19	20
7112	2026-05-23 23:00:00	20	20
7122	2026-05-23 23:00:00	18	198
7131	2026-05-23 23:00:00	16	20
7142	2026-05-23 23:00:00	17	28.42
7158	2026-05-24 00:00:00	37	28.24
7170	2026-05-24 00:00:00	39	20
7182	2026-05-24 00:00:00	40	20
7192	2026-05-24 00:00:00	36	20
7199	2026-05-24 00:00:00	38	198
7201	2026-05-24 01:00:00	1	12
7218	2026-05-24 01:00:00	3	171.6
7228	2026-05-24 01:00:00	4	20
7239	2026-05-24 01:00:00	2	24.36
7249	2026-05-24 01:00:00	5	20
7717	2026-05-24 11:00:00	31	20
8112	2026-05-24 19:00:00	5	20
8123	2026-05-24 19:00:00	1	12
8133	2026-05-24 19:00:00	3	171.6
8146	2026-05-24 19:00:00	4	20
8153	2026-05-24 20:00:00	18	198
8167	2026-05-24 20:00:00	16	20
8181	2026-05-24 20:00:00	17	28.4
8190	2026-05-24 20:00:00	19	20
8200	2026-05-24 20:00:00	20	20
8201	2026-05-24 21:00:00	1	12
8211	2026-05-24 21:00:00	3	171.6
8218	2026-05-24 21:00:00	4	20
8222	2026-05-24 21:00:00	2	24.26
8231	2026-05-24 21:00:00	5	20
8260	2026-05-24 22:00:00	50	20
8269	2026-05-24 22:00:00	46	20
8278	2026-05-24 22:00:00	49	20
8287	2026-05-24 22:00:00	48	198
8296	2026-05-24 22:00:00	47	28.38
8303	2026-05-24 23:00:00	21	20
8315	2026-05-24 23:00:00	22	28.35
8329	2026-05-24 23:00:00	25	20
8335	2026-05-24 23:00:00	24	20
8342	2026-05-24 23:00:00	23	198
6759	2026-05-23 16:00:00	43	198
6763	2026-05-23 16:00:00	41	20
6774	2026-05-23 16:00:00	42	28.24
6784	2026-05-23 16:00:00	45	20
6793	2026-05-23 16:00:00	44	20
6807	2026-05-23 17:00:00	29	20
6817	2026-05-23 17:00:00	28	198
6829	2026-05-23 17:00:00	30	20
6837	2026-05-23 17:00:00	27	28.49
6848	2026-05-23 17:00:00	26	20
6852	2026-05-23 18:00:00	10	20
6865	2026-05-23 18:00:00	9	20
6876	2026-05-23 18:00:00	6	12
6888	2026-05-23 18:00:00	7	24.47
6895	2026-05-23 18:00:00	8	171.6
6910	2026-05-23 19:00:00	48	198
6919	2026-05-23 19:00:00	47	28.46
6929	2026-05-23 19:00:00	50	20
6939	2026-05-23 19:00:00	46	20
6946	2026-05-23 19:00:00	49	20
6954	2026-05-23 20:00:00	23	198
6961	2026-05-23 20:00:00	21	20
6970	2026-05-23 20:00:00	22	28.2
6976	2026-05-23 20:00:00	25	20
6982	2026-05-23 20:00:00	24	20
7008	2026-05-23 21:00:00	48	198
7017	2026-05-23 21:00:00	47	28.32
7029	2026-05-23 21:00:00	50	20
7041	2026-05-23 21:00:00	46	20
7047	2026-05-23 21:00:00	49	20
7057	2026-05-23 22:00:00	18	198
7067	2026-05-23 22:00:00	16	20
7081	2026-05-23 22:00:00	17	28.4
7091	2026-05-23 22:00:00	19	20
7099	2026-05-23 22:00:00	20	20
7103	2026-05-23 23:00:00	9	20
7116	2026-05-23 23:00:00	6	12
7126	2026-05-23 23:00:00	7	24.34
7139	2026-05-23 23:00:00	8	171.6
7148	2026-05-23 23:00:00	10	20
7154	2026-05-24 00:00:00	12	28.32
7169	2026-05-24 00:00:00	14	20
7181	2026-05-24 00:00:00	11	20
7193	2026-05-24 00:00:00	13	198
7200	2026-05-24 00:00:00	15	20
7202	2026-05-24 01:00:00	10	20
7211	2026-05-24 01:00:00	9	20
7221	2026-05-24 01:00:00	6	12
7226	2026-05-24 01:00:00	7	24.36
7232	2026-05-24 01:00:00	8	171.6
7718	2026-05-24 11:00:00	44	20
8172	2026-05-24 20:00:00	1	12
8182	2026-05-24 20:00:00	3	171.6
8192	2026-05-24 20:00:00	4	20
8206	2026-05-24 21:00:00	27	28.44
8213	2026-05-24 21:00:00	26	20
8223	2026-05-24 21:00:00	29	20
8235	2026-05-24 21:00:00	28	198
8245	2026-05-24 21:00:00	30	20
8258	2026-05-24 22:00:00	32	28.4
8264	2026-05-24 22:00:00	35	20
8274	2026-05-24 22:00:00	33	198
8284	2026-05-24 22:00:00	31	20
8294	2026-05-24 22:00:00	34	20
8306	2026-05-24 23:00:00	33	198
8313	2026-05-24 23:00:00	31	20
8323	2026-05-24 23:00:00	34	20
8330	2026-05-24 23:00:00	32	28.23
8341	2026-05-24 23:00:00	35	20
6760	2026-05-23 16:00:00	47	28.32
6772	2026-05-23 16:00:00	50	20
6785	2026-05-23 16:00:00	46	20
6795	2026-05-23 16:00:00	49	20
6800	2026-05-23 16:00:00	48	198
6801	2026-05-23 17:00:00	3	171.6
6815	2026-05-23 17:00:00	4	20
6826	2026-05-23 17:00:00	2	24.36
6835	2026-05-23 17:00:00	5	20
6845	2026-05-23 17:00:00	1	12
6858	2026-05-23 18:00:00	31	20
6869	2026-05-23 18:00:00	34	20
6877	2026-05-23 18:00:00	32	28.33
6885	2026-05-23 18:00:00	35	20
6898	2026-05-23 18:00:00	33	198
6903	2026-05-23 19:00:00	12	28.41
6920	2026-05-23 19:00:00	14	20
6932	2026-05-23 19:00:00	11	20
6943	2026-05-23 19:00:00	13	198
6949	2026-05-23 19:00:00	15	20
6953	2026-05-23 20:00:00	15	20
6964	2026-05-23 20:00:00	12	28.36
6975	2026-05-23 20:00:00	14	20
6985	2026-05-23 20:00:00	11	20
6989	2026-05-23 20:00:00	13	198
7010	2026-05-23 21:00:00	41	20
7019	2026-05-23 21:00:00	42	28.31
7031	2026-05-23 21:00:00	45	20
7044	2026-05-23 21:00:00	44	20
7049	2026-05-23 21:00:00	43	198
7052	2026-05-23 22:00:00	11	20
7063	2026-05-23 22:00:00	13	198
7071	2026-05-23 22:00:00	15	20
7076	2026-05-23 22:00:00	12	28.24
7085	2026-05-23 22:00:00	14	20
7109	2026-05-23 23:00:00	48	198
7113	2026-05-23 23:00:00	47	28.27
7123	2026-05-23 23:00:00	50	20
7134	2026-05-23 23:00:00	46	20
7144	2026-05-23 23:00:00	49	20
7159	2026-05-24 00:00:00	41	20
7162	2026-05-24 00:00:00	42	28.49
7172	2026-05-24 00:00:00	45	20
7186	2026-05-24 00:00:00	44	20
7196	2026-05-24 00:00:00	43	198
7205	2026-05-24 01:00:00	24	20
7220	2026-05-24 01:00:00	23	198
7230	2026-05-24 01:00:00	21	20
7243	2026-05-24 01:00:00	22	28.34
7247	2026-05-24 01:00:00	25	20
7719	2026-05-24 11:00:00	37	28.32
7728	2026-05-24 11:00:00	39	20
7738	2026-05-24 11:00:00	40	20
7759	2026-05-24 12:00:00	45	20
7769	2026-05-24 12:00:00	44	20
7774	2026-05-24 12:00:00	43	283.8
7783	2026-05-24 12:00:00	41	46
7793	2026-05-24 12:00:00	42	41.25
7805	2026-05-24 13:00:00	26	20
7817	2026-05-24 13:00:00	29	20
7831	2026-05-24 13:00:00	28	198
7841	2026-05-24 13:00:00	30	20
7849	2026-05-24 13:00:00	27	28.46
7852	2026-05-24 14:00:00	2	24.29
7864	2026-05-24 14:00:00	5	20
7873	2026-05-24 14:00:00	1	12
7881	2026-05-24 14:00:00	3	171.6
7891	2026-05-24 14:00:00	4	20
7909	2026-05-24 15:00:00	44	20
7914	2026-05-24 15:00:00	43	198
7924	2026-05-24 15:00:00	41	20
7934	2026-05-24 15:00:00	42	28.28
7945	2026-05-24 15:00:00	45	20
7956	2026-05-24 16:00:00	28	198
7966	2026-05-24 16:00:00	30	20
7973	2026-05-24 16:00:00	27	28.43
7982	2026-05-24 16:00:00	26	20
7993	2026-05-24 16:00:00	29	20
8005	2026-05-24 17:00:00	37	28.24
8020	2026-05-24 17:00:00	39	20
8025	2026-05-24 17:00:00	40	20
8036	2026-05-24 17:00:00	36	20
8048	2026-05-24 17:00:00	38	198
8054	2026-05-24 18:00:00	13	198
8063	2026-05-24 18:00:00	15	20
8074	2026-05-24 18:00:00	12	28.24
8086	2026-05-24 18:00:00	14	20
8097	2026-05-24 18:00:00	11	20
8105	2026-05-24 19:00:00	28	198
8119	2026-05-24 19:00:00	30	20
8130	2026-05-24 19:00:00	27	28.25
8140	2026-05-24 19:00:00	26	20
8145	2026-05-24 19:00:00	29	20
8160	2026-05-24 20:00:00	36	20
8169	2026-05-24 20:00:00	38	198
8178	2026-05-24 20:00:00	37	28.36
8183	2026-05-24 20:00:00	7	24.44
8184	2026-05-24 20:00:00	39	20
8194	2026-05-24 20:00:00	40	20
8198	2026-05-24 20:00:00	8	171.6
8209	2026-05-24 21:00:00	15	20
8210	2026-05-24 21:00:00	38	198
8220	2026-05-24 21:00:00	12	28.33
8221	2026-05-24 21:00:00	37	28.22
8229	2026-05-24 21:00:00	14	20
8232	2026-05-24 21:00:00	39	20
8239	2026-05-24 21:00:00	40	20
8240	2026-05-24 21:00:00	11	20
8248	2026-05-24 21:00:00	36	20
8249	2026-05-24 21:00:00	13	198
8252	2026-05-24 22:00:00	10	20
8255	2026-05-24 22:00:00	16	20
8263	2026-05-24 22:00:00	17	28.49
8267	2026-05-24 22:00:00	9	20
8275	2026-05-24 22:00:00	19	20
8277	2026-05-24 22:00:00	6	12
8286	2026-05-24 22:00:00	20	20
8288	2026-05-24 22:00:00	7	24.3
8297	2026-05-24 22:00:00	18	198
8299	2026-05-24 22:00:00	8	171.6
8304	2026-05-24 23:00:00	9	20
8302	2026-05-24 23:00:00	20	20
8312	2026-05-24 23:00:00	6	12
8316	2026-05-24 23:00:00	18	198
8322	2026-05-24 23:00:00	10	20
8325	2026-05-24 23:00:00	7	24.47
8326	2026-05-24 23:00:00	19	20
8336	2026-05-24 23:00:00	8	171.6
8340	2026-05-24 23:00:00	16	20
8347	2026-05-24 23:00:00	17	28.28
5860	2026-05-22 22:00:00	48	198
5869	2026-05-22 22:00:00	47	28.41
5880	2026-05-22 22:00:00	50	20
5889	2026-05-22 22:00:00	46	20
5897	2026-05-22 22:00:00	49	20
5908	2026-05-22 23:00:00	35	20
5916	2026-05-22 23:00:00	33	198
5926	2026-05-22 23:00:00	31	20
5934	2026-05-22 23:00:00	34	20
5940	2026-05-22 23:00:00	32	28.41
5959	2026-05-23 00:00:00	47	28.42
5964	2026-05-23 00:00:00	50	20
5975	2026-05-23 00:00:00	46	20
5986	2026-05-23 00:00:00	49	20
5998	2026-05-23 00:00:00	48	198
6004	2026-05-23 01:00:00	20	20
6011	2026-05-23 01:00:00	18	198
6021	2026-05-23 01:00:00	17	28.33
6026	2026-05-23 01:00:00	16	20
6033	2026-05-23 01:00:00	19	20
6059	2026-05-23 02:00:00	50	20
6062	2026-05-23 02:00:00	46	20
6070	2026-05-23 02:00:00	49	20
6075	2026-05-23 02:00:00	48	198
6084	2026-05-23 02:00:00	47	28.32
6107	2026-05-23 03:00:00	50	20
6111	2026-05-23 03:00:00	46	20
6121	2026-05-23 03:00:00	49	20
6130	2026-05-23 03:00:00	48	198
6138	2026-05-23 03:00:00	47	28.23
6159	2026-05-23 04:00:00	45	20
6164	2026-05-23 04:00:00	43	198
6174	2026-05-23 04:00:00	44	20
6181	2026-05-23 04:00:00	41	20
6192	2026-05-23 04:00:00	42	28.35
6204	2026-05-23 05:00:00	31	20
6211	2026-05-23 05:00:00	34	20
6221	2026-05-23 05:00:00	32	28.34
6233	2026-05-23 05:00:00	35	20
6243	2026-05-23 05:00:00	33	198
6260	2026-05-23 06:00:00	45	20
6268	2026-05-23 06:00:00	43	198
6274	2026-05-23 06:00:00	44	20
6284	2026-05-23 06:00:00	41	20
6295	2026-05-23 06:00:00	42	28.32
6309	2026-05-23 07:00:00	26	20
6311	2026-05-23 07:00:00	29	20
6320	2026-05-23 07:00:00	28	198
6327	2026-05-23 07:00:00	30	20
6335	2026-05-23 07:00:00	27	28.34
6360	2026-05-23 08:00:00	47	28.42
6366	2026-05-23 08:00:00	50	20
6373	2026-05-23 08:00:00	46	20
6382	2026-05-23 08:00:00	49	20
6389	2026-05-23 08:00:00	48	198
6409	2026-05-23 09:00:00	48	198
6413	2026-05-23 09:00:00	47	28.21
6422	2026-05-23 09:00:00	50	20
6433	2026-05-23 09:00:00	46	20
6441	2026-05-23 09:00:00	49	20
6457	2026-05-23 10:00:00	38	198
6466	2026-05-23 10:00:00	37	28.23
6474	2026-05-23 10:00:00	39	20
6485	2026-05-23 10:00:00	40	20
6495	2026-05-23 10:00:00	36	20
6507	2026-05-23 11:00:00	37	28.25
6517	2026-05-23 11:00:00	39	20
6529	2026-05-23 11:00:00	40	20
6538	2026-05-23 11:00:00	36	20
6547	2026-05-23 11:00:00	38	198
6555	2026-05-23 12:00:00	20	20
6568	2026-05-23 12:00:00	18	283.8
6577	2026-05-23 12:00:00	16	46
6587	2026-05-23 12:00:00	17	41.27
6594	2026-05-23 12:00:00	19	20
6607	2026-05-23 13:00:00	22	28.42
6615	2026-05-23 13:00:00	25	20
6621	2026-05-23 13:00:00	24	20
6628	2026-05-23 13:00:00	23	198
6637	2026-05-23 13:00:00	21	20
6660	2026-05-23 14:00:00	48	198
6672	2026-05-23 14:00:00	47	28.25
6680	2026-05-23 14:00:00	50	20
6687	2026-05-23 14:00:00	46	20
6696	2026-05-23 14:00:00	49	20
6705	2026-05-23 15:00:00	17	28.19
6712	2026-05-23 15:00:00	19	20
6720	2026-05-23 15:00:00	20	20
6726	2026-05-23 15:00:00	18	198
6735	2026-05-23 15:00:00	16	20
7720	2026-05-24 11:00:00	9	20
7727	2026-05-24 11:00:00	6	12
7735	2026-05-24 11:00:00	7	24.27
7760	2026-05-24 12:00:00	47	41.38
7771	2026-05-24 12:00:00	50	20
7785	2026-05-24 12:00:00	46	46
7794	2026-05-24 12:00:00	49	20
7800	2026-05-24 12:00:00	48	283.8
7801	2026-05-24 13:00:00	1	12
7812	2026-05-24 13:00:00	3	171.6
7827	2026-05-24 13:00:00	4	20
7837	2026-05-24 13:00:00	2	24.41
7845	2026-05-24 13:00:00	5	20
7860	2026-05-24 14:00:00	32	28.46
7868	2026-05-24 14:00:00	35	20
7879	2026-05-24 14:00:00	33	198
7886	2026-05-24 14:00:00	31	20
7897	2026-05-24 14:00:00	34	20
7904	2026-05-24 15:00:00	17	28.32
7917	2026-05-24 15:00:00	19	20
7930	2026-05-24 15:00:00	20	20
7938	2026-05-24 15:00:00	18	198
7947	2026-05-24 15:00:00	16	20
7953	2026-05-24 16:00:00	25	20
7963	2026-05-24 16:00:00	24	20
7974	2026-05-24 16:00:00	23	198
7984	2026-05-24 16:00:00	21	20
7994	2026-05-24 16:00:00	22	28.37
8008	2026-05-24 17:00:00	35	20
8015	2026-05-24 17:00:00	33	198
8026	2026-05-24 17:00:00	31	20
8035	2026-05-24 17:00:00	34	20
8043	2026-05-24 17:00:00	32	28.21
8056	2026-05-24 18:00:00	34	20
8067	2026-05-24 18:00:00	32	28.27
8073	2026-05-24 18:00:00	35	20
8083	2026-05-24 18:00:00	33	198
8092	2026-05-24 18:00:00	31	20
8106	2026-05-24 19:00:00	36	20
8118	2026-05-24 19:00:00	38	198
8129	2026-05-24 19:00:00	37	28.43
8136	2026-05-24 19:00:00	39	20
8147	2026-05-24 19:00:00	40	20
8152	2026-05-24 20:00:00	10	20
8161	2026-05-24 20:00:00	9	20
8173	2026-05-24 20:00:00	6	12
\.


--
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.server (server_id, cluster_id, config_id, hostname, status, base_consumption_offset, created_at, is_master) FROM stdin;
1	1	1	marseille-marseille-zone-01-master-01	ON	850	2026-05-19 11:50:44.133	t
2	1	1	marseille-marseille-zone-01-master-02	ON	850	2026-05-19 11:50:44.158	t
3	1	1	marseille-marseille-zone-01-worker-01	ON	700	2026-05-19 11:50:44.175	f
4	1	1	marseille-marseille-zone-01-worker-02	ON	700	2026-05-19 11:50:44.194	f
5	1	1	marseille-marseille-zone-01-worker-03	ON	700	2026-05-19 11:50:44.212	f
6	1	1	marseille-marseille-zone-01-worker-04	ON	700	2026-05-19 11:50:44.227	f
7	1	1	marseille-marseille-zone-01-worker-05	ON	700	2026-05-19 11:50:44.246	f
8	1	1	marseille-marseille-zone-01-worker-06	ON	700	2026-05-19 11:50:44.267	f
9	1	1	marseille-marseille-zone-01-worker-07	ON	700	2026-05-19 11:50:44.286	f
10	1	1	marseille-marseille-zone-01-worker-08	ON	700	2026-05-19 11:50:44.299	f
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

SELECT pg_catalog.setval('public.sensor_data_id_seq', 8350, true);


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

\unrestrict 3ALzDdsEfK3YoX8RghUqx6rcxt8u0wIm8WQlIOvdEaVX3d7ifxfnZUNDnbLRrKG

