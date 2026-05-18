--
-- PostgreSQL database dump
--

\restrict scMhpKbHfdxrHnqF1R4N9ADkaeR52wBAJAbpZlH9uVckL3XEubQbKLMlu3IgEDZ

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
1	Marseille-Zone-01	2026-05-18 21:57:17.875	1
\.


--
-- Data for Name: cluster_configuration; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.cluster_configuration (cluster_config_id, name, master, worker, consomation_per_master, consomation_per_worker, hardware_per_master, hardware_per_worker, pue, location_id, fan_id, fan_count, cpu_cooler_catalog_id, fan_catalog_id, load_profile_id) FROM stdin;
1	Config_Marseille-Zone-01	2	8	850	700	2×EPYC + 1×RTX, 256GB	2×EPYC + 1×RTX, 256GB	1.322	1	1	4	2	1	1
\.


--
-- Data for Name: cluster_location; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.cluster_location (location_id, name, location, env_factor, cluster_count, created_at, energy_cost_kwh) FROM stdin;
1	Marseille	Marseille Tech Hub	1.2	1	2026-05-18 21:57:17.871	0.18
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
11	3	1	1	AUTO	ON	20	2026-05-18 21:57:17.905
12	3	1	1	AUTO	ON	20	2026-05-18 21:57:17.907
9	3	1	1	AUTO	ON	20	2026-05-18 21:57:17.903
10	3	1	1	AUTO	ON	20	2026-05-18 21:57:17.904
13	4	1	1	AUTO	ON	20	2026-05-18 21:57:17.916
14	4	1	1	AUTO	ON	20	2026-05-18 21:57:17.917
15	4	1	1	AUTO	ON	20	2026-05-18 21:57:17.918
16	4	1	1	AUTO	ON	20	2026-05-18 21:57:17.919
17	5	1	1	AUTO	ON	20	2026-05-18 21:57:17.927
18	5	1	1	AUTO	ON	20	2026-05-18 21:57:17.928
19	5	1	1	AUTO	ON	20	2026-05-18 21:57:17.929
20	5	1	1	AUTO	ON	20	2026-05-18 21:57:17.93
21	6	1	1	AUTO	ON	20	2026-05-18 21:57:17.938
22	6	1	1	AUTO	ON	20	2026-05-18 21:57:17.939
23	6	1	1	AUTO	ON	20	2026-05-18 21:57:17.94
24	6	1	1	AUTO	ON	20	2026-05-18 21:57:17.941
25	7	1	1	AUTO	ON	20	2026-05-18 21:57:17.95
26	7	1	1	AUTO	ON	20	2026-05-18 21:57:17.951
27	7	1	1	AUTO	ON	20	2026-05-18 21:57:17.952
28	7	1	1	AUTO	ON	20	2026-05-18 21:57:17.953
30	8	1	1	AUTO	ON	20	2026-05-18 21:57:17.962
31	8	1	1	AUTO	ON	20	2026-05-18 21:57:17.963
32	8	1	1	AUTO	ON	20	2026-05-18 21:57:17.964
29	8	1	1	AUTO	ON	20	2026-05-18 21:57:17.961
33	9	1	1	AUTO	ON	20	2026-05-18 21:57:17.973
34	9	1	1	AUTO	ON	20	2026-05-18 21:57:17.974
2	1	1	1	AUTO	ON	20	2026-05-18 21:57:17.879
3	1	1	1	AUTO	ON	20	2026-05-18 21:57:17.88
4	1	1	1	AUTO	ON	20	2026-05-18 21:57:17.881
1	1	1	1	AUTO	ON	20	2026-05-18 21:57:17.877
5	2	1	1	AUTO	ON	20	2026-05-18 21:57:17.889
6	2	1	1	AUTO	ON	20	2026-05-18 21:57:17.891
7	2	1	1	AUTO	ON	20	2026-05-18 21:57:17.892
8	2	1	1	AUTO	ON	20	2026-05-18 21:57:17.893
35	9	1	1	AUTO	ON	20	2026-05-18 21:57:17.976
36	9	1	1	AUTO	ON	20	2026-05-18 21:57:17.977
40	10	1	1	AUTO	ON	20	2026-05-18 21:57:17.989
37	10	1	1	AUTO	ON	20	2026-05-18 21:57:17.986
38	10	1	1	AUTO	ON	20	2026-05-18 21:57:17.987
39	10	1	1	AUTO	ON	20	2026-05-18 21:57:17.988
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
1	Config_Auto_Paris-01	12	20	60	MEDIUM
\.


--
-- Data for Name: sensor; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.sensor (sensor_id, server_id, sensor_type, unit, last_value, created_at) FROM stdin;
33	7	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.957
34	7	FAN_SPEED_1	%	20	2026-05-18 21:57:17.958
35	7	FAN_SPEED_2	%	20	2026-05-18 21:57:17.959
31	7	LOAD	%	52.99	2026-05-18 21:57:17.955
32	7	CPU_TEMP	°C	45.62000975658706	2026-05-18 21:57:17.956
36	8	LOAD	%	52.99	2026-05-18 21:57:17.965
37	8	CPU_TEMP	°C	45.71568355804521	2026-05-18 21:57:17.966
38	8	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.968
39	8	FAN_SPEED_1	%	20	2026-05-18 21:57:17.969
40	8	FAN_SPEED_2	%	20	2026-05-18 21:57:17.97
43	9	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.981
44	9	FAN_SPEED_1	%	20	2026-05-18 21:57:17.982
45	9	FAN_SPEED_2	%	20	2026-05-18 21:57:17.983
41	9	LOAD	%	52.99	2026-05-18 21:57:17.979
42	9	CPU_TEMP	°C	45.50782639143585	2026-05-18 21:57:17.98
50	10	FAN_SPEED_2	%	20	2026-05-18 21:57:17.995
46	10	LOAD	%	52.99	2026-05-18 21:57:17.991
47	10	CPU_TEMP	°C	45.6808703862743	2026-05-18 21:57:17.992
48	10	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.993
49	10	FAN_SPEED_1	%	20	2026-05-18 21:57:17.994
2	1	CPU_TEMP	°C	30	2026-05-18 21:57:17.884
3	1	TOTAL_POWER	W	169.5	2026-05-18 21:57:17.885
4	1	FAN_SPEED_1	%	20	2026-05-18 21:57:17.886
5	1	FAN_SPEED_2	%	20	2026-05-18 21:57:17.887
1	1	LOAD	%	15	2026-05-18 21:57:17.882
10	2	FAN_SPEED_2	%	20	2026-05-18 21:57:17.899
6	2	LOAD	%	15	2026-05-18 21:57:17.894
7	2	CPU_TEMP	°C	30	2026-05-18 21:57:17.895
8	2	TOTAL_POWER	W	169.5	2026-05-18 21:57:17.896
9	2	FAN_SPEED_1	%	20	2026-05-18 21:57:17.898
11	3	LOAD	%	52.99	2026-05-18 21:57:17.908
12	3	CPU_TEMP	°C	45.47687824778747	2026-05-18 21:57:17.909
13	3	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.911
14	3	FAN_SPEED_1	%	20	2026-05-18 21:57:17.912
15	3	FAN_SPEED_2	%	20	2026-05-18 21:57:17.913
19	4	FAN_SPEED_1	%	20	2026-05-18 21:57:17.923
20	4	FAN_SPEED_2	%	20	2026-05-18 21:57:17.925
16	4	LOAD	%	52.99	2026-05-18 21:57:17.921
17	4	CPU_TEMP	°C	45.43599829984128	2026-05-18 21:57:17.922
18	4	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.922
22	5	CPU_TEMP	°C	45.644695013154326	2026-05-18 21:57:17.933
23	5	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.934
24	5	FAN_SPEED_1	%	20	2026-05-18 21:57:17.935
25	5	FAN_SPEED_2	%	20	2026-05-18 21:57:17.936
21	5	LOAD	%	52.99	2026-05-18 21:57:17.932
30	6	FAN_SPEED_2	%	20	2026-05-18 21:57:17.948
26	6	LOAD	%	52.99	2026-05-18 21:57:17.942
27	6	CPU_TEMP	°C	45.57902553312163	2026-05-18 21:57:17.943
28	6	TOTAL_POWER	W	264.475	2026-05-18 21:57:17.944
29	6	FAN_SPEED_1	%	20	2026-05-18 21:57:17.946
\.


--
-- Data for Name: sensor_data; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.sensor_data (id, "time", sensor_id, value) FROM stdin;
\.


--
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: tsuser
--

COPY public.server (server_id, cluster_id, config_id, hostname, status, base_consumption_offset, created_at, is_master) FROM stdin;
1	1	1	marseille-marseille-zone-01-master-01	ON	850	2026-05-18 21:57:17.876	t
2	1	1	marseille-marseille-zone-01-master-02	ON	850	2026-05-18 21:57:17.888	t
3	1	1	marseille-marseille-zone-01-worker-01	ON	700	2026-05-18 21:57:17.901	f
4	1	1	marseille-marseille-zone-01-worker-02	ON	700	2026-05-18 21:57:17.915	f
5	1	1	marseille-marseille-zone-01-worker-03	ON	700	2026-05-18 21:57:17.926	f
6	1	1	marseille-marseille-zone-01-worker-04	ON	700	2026-05-18 21:57:17.937	f
7	1	1	marseille-marseille-zone-01-worker-05	ON	700	2026-05-18 21:57:17.949	f
8	1	1	marseille-marseille-zone-01-worker-06	ON	700	2026-05-18 21:57:17.96	f
9	1	1	marseille-marseille-zone-01-worker-07	ON	700	2026-05-18 21:57:17.972	f
10	1	1	marseille-marseille-zone-01-worker-08	ON	700	2026-05-18 21:57:17.985	f
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

SELECT pg_catalog.setval('public.load_profile_id_seq', 1, true);


--
-- Name: sensor_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tsuser
--

SELECT pg_catalog.setval('public.sensor_data_id_seq', 2750, true);


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

\unrestrict scMhpKbHfdxrHnqF1R4N9ADkaeR52wBAJAbpZlH9uVckL3XEubQbKLMlu3IgEDZ

