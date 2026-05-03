import "dotenv/config";
import process from "node:process"; // L'import magique pour l'ESM
import { defineConfig } from "prisma/config";

export default defineConfig({
  // Chemin vers ton fichier SOURCE
  schema: "./src/prisma/schema.prisma", 
  
  datasource: {
    // Plus de "process is not defined" ici
    url: process.env.DATABASE_URL || "postgresql://tsuser:tspassword@localhost:5432/tsdb",
  },
});