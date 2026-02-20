import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/schema.prisma",
  migrations: {
    path: "prisma/migrations",
  },
  // engine: "classic",
  datasource: {
    // url: env("DATABASE_URL"),
    // url: "postgresql://tsuser:tspassword@timescaledb:5432/tsdb"
    url: "postgresql://tsuser:tspassword@localhost:5432/tsdb"
  },
});
