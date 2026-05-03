-- CreateTable
CREATE TABLE "cluster_location" (
    "location_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "location" TEXT,
    "env_factor" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "cluster_count" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cluster_location_pkey" PRIMARY KEY ("location_id")
);

-- CreateTable
CREATE TABLE "load_profile" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "hour" INTEGER NOT NULL,
    "expected_load_percent" DOUBLE PRECISION NOT NULL,
    "target_temp_celsius" DOUBLE PRECISION NOT NULL,
    "standard_fan_speed" TEXT NOT NULL DEFAULT 'MEDIUM',

    CONSTRAINT "load_profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fan_configuration" (
    "fan_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "consomation" DOUBLE PRECISION,

    CONSTRAINT "fan_configuration_pkey" PRIMARY KEY ("fan_id")
);

-- CreateTable
CREATE TABLE "fan_catalog" (
    "fan_catalog_id" SERIAL NOT NULL,
    "model_name" TEXT NOT NULL,
    "consomation" DOUBLE PRECISION,

    CONSTRAINT "fan_catalog_pkey" PRIMARY KEY ("fan_catalog_id")
);

-- CreateTable
CREATE TABLE "cpucooler_catalog" (
    "cpu_cooler_catalog_id" SERIAL NOT NULL,
    "model_name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "thermal_capacity" INTEGER NOT NULL,

    CONSTRAINT "cpucooler_catalog_pkey" PRIMARY KEY ("cpu_cooler_catalog_id")
);

-- CreateTable
CREATE TABLE "cluster_configuration" (
    "cluster_config_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "master" INTEGER NOT NULL,
    "worker" INTEGER NOT NULL,
    "consomation_per_master" DOUBLE PRECISION,
    "consomation_per_worker" DOUBLE PRECISION,
    "hardware_per_master" TEXT,
    "hardware_per_worker" TEXT,
    "pue" DOUBLE PRECISION,
    "location_id" INTEGER,
    "fan_id" INTEGER,
    "fan_count" INTEGER NOT NULL DEFAULT 1,
    "cpu_cooler_catalog_id" INTEGER NOT NULL,
    "fan_catalog_id" INTEGER NOT NULL,
    "load_profile_id" INTEGER,

    CONSTRAINT "cluster_configuration_pkey" PRIMARY KEY ("cluster_config_id")
);

-- CreateTable
CREATE TABLE "cluster" (
    "cluster_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cluster_location_id" INTEGER NOT NULL,

    CONSTRAINT "cluster_pkey" PRIMARY KEY ("cluster_id")
);

-- CreateTable
CREATE TABLE "server" (
    "server_id" SERIAL NOT NULL,
    "cluster_id" INTEGER NOT NULL,
    "config_id" INTEGER,
    "hostname" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ON',
    "base_consumption_offset" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "server_pkey" PRIMARY KEY ("server_id")
);

-- CreateTable
CREATE TABLE "fan" (
    "fan_id" SERIAL NOT NULL,
    "server_id" INTEGER NOT NULL,
    "fan_catalog_id" INTEGER,
    "fan_config_id" INTEGER,
    "control_mode" TEXT NOT NULL DEFAULT 'AUTO',
    "status" TEXT NOT NULL DEFAULT 'OFF',
    "speed_percent" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "fan_pkey" PRIMARY KEY ("fan_id")
);

-- CreateTable
CREATE TABLE "sensor" (
    "sensor_id" SERIAL NOT NULL,
    "server_id" INTEGER NOT NULL,
    "sensor_type" TEXT NOT NULL,
    "unit" TEXT NOT NULL,
    "last_value" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "sensor_pkey" PRIMARY KEY ("sensor_id")
);

-- CreateTable
CREATE TABLE "sensor_data" (
    "id" SERIAL NOT NULL,
    "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sensor_id" INTEGER NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "sensor_data_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "cluster_location_name_key" ON "cluster_location"("name");

-- CreateIndex
CREATE UNIQUE INDEX "load_profile_name_hour_key" ON "load_profile"("name", "hour");

-- CreateIndex
CREATE UNIQUE INDEX "fan_configuration_name_key" ON "fan_configuration"("name");

-- CreateIndex
CREATE UNIQUE INDEX "fan_catalog_model_name_key" ON "fan_catalog"("model_name");

-- CreateIndex
CREATE UNIQUE INDEX "cpucooler_catalog_model_name_key" ON "cpucooler_catalog"("model_name");

-- CreateIndex
CREATE UNIQUE INDEX "cluster_configuration_name_key" ON "cluster_configuration"("name");

-- CreateIndex
CREATE UNIQUE INDEX "cluster_name_key" ON "cluster"("name");

-- AddForeignKey
ALTER TABLE "cluster_configuration" ADD CONSTRAINT "cluster_configuration_load_profile_id_fkey" FOREIGN KEY ("load_profile_id") REFERENCES "load_profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cluster_configuration" ADD CONSTRAINT "cluster_configuration_cpu_cooler_catalog_id_fkey" FOREIGN KEY ("cpu_cooler_catalog_id") REFERENCES "cpucooler_catalog"("cpu_cooler_catalog_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cluster_configuration" ADD CONSTRAINT "cluster_configuration_fan_catalog_id_fkey" FOREIGN KEY ("fan_catalog_id") REFERENCES "fan_catalog"("fan_catalog_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cluster_configuration" ADD CONSTRAINT "cluster_configuration_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "cluster_location"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cluster_configuration" ADD CONSTRAINT "cluster_configuration_fan_id_fkey" FOREIGN KEY ("fan_id") REFERENCES "fan_configuration"("fan_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cluster" ADD CONSTRAINT "cluster_cluster_location_id_fkey" FOREIGN KEY ("cluster_location_id") REFERENCES "cluster_location"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "server" ADD CONSTRAINT "server_cluster_id_fkey" FOREIGN KEY ("cluster_id") REFERENCES "cluster"("cluster_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "server" ADD CONSTRAINT "server_config_id_fkey" FOREIGN KEY ("config_id") REFERENCES "cluster_configuration"("cluster_config_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fan" ADD CONSTRAINT "fan_server_id_fkey" FOREIGN KEY ("server_id") REFERENCES "server"("server_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fan" ADD CONSTRAINT "fan_fan_catalog_id_fkey" FOREIGN KEY ("fan_catalog_id") REFERENCES "fan_catalog"("fan_catalog_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fan" ADD CONSTRAINT "fan_fan_config_id_fkey" FOREIGN KEY ("fan_config_id") REFERENCES "fan_configuration"("fan_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sensor" ADD CONSTRAINT "sensor_server_id_fkey" FOREIGN KEY ("server_id") REFERENCES "server"("server_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sensor_data" ADD CONSTRAINT "sensor_data_sensor_id_fkey" FOREIGN KEY ("sensor_id") REFERENCES "sensor"("sensor_id") ON DELETE RESTRICT ON UPDATE CASCADE;
