"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.prisma = void 0;
const client_1 = require("@prisma/client");
const adapter_pg_1 = require("@prisma/adapter-pg");
const pg_1 = __importDefault(require("pg"));
// 1. On crée le pool de connexion natif PostgreSQL
const pool = new pg_1.default.Pool({
    connectionString: process.env.DATABASE_URL
});
// 2. On initialise l'adapter Prisma pour Postgres
const adapter = new adapter_pg_1.PrismaPg(pool);
// 3. On instancie le client avec l'adapter
// Plus besoin de chemins relatifs vers "generated" !
exports.prisma = new client_1.PrismaClient({ adapter });
