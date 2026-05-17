# --- Étape 1 : Build ---
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

# On copie l'intégralité des fichiers (y compris le dossier public)
COPY . .

# On génère Prisma et on build le TypeScript
RUN npx prisma generate --schema=./src/prisma/schema.prisma
RUN npm run build

# --- Étape 2 : Runtime ---
FROM node:20-alpine
WORKDIR /app

# On ne récupère que le strict nécessaire pour l'exécution
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/prisma.config.ts ./prisma.config.ts

# 🌟 LA CORRECTION EST ICI : On rapatrie le dossier public dans le conteneur final !
COPY --from=builder /app/public ./public

# On copie dans ./src/prisma pour garder le dossier "src" nécessaire aux migrations
COPY --from=builder /app/src/prisma ./src/prisma

COPY --from=builder /app/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

EXPOSE 3333
ENTRYPOINT ["/bin/sh", "./entrypoint.sh"]