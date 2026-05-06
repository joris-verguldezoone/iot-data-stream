"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const node_process_1 = __importDefault(require("node:process")); // L'import magique pour l'ESM
const config_1 = require("prisma/config");
exports.default = (0, config_1.defineConfig)({
    // Chemin vers ton fichier SOURCE
    schema: "./src/prisma/schema.prisma",
    datasource: {
        // Plus de "process is not defined" ici
        url: node_process_1.default.env.DATABASE_URL || "postgresql://tsuser:tspassword@localhost:5432/tsdb",
    },
});
