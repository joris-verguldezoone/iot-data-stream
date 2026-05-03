# --- Étape 1 : Build ---
FROM node:20-alpine AS builder

WORKDIR /app

# On installe les dépendances (y compris devDeps pour compiler)
COPY package*.json ./
RUN npm install

# Copie du code source
COPY . .

# Génération du client Prisma (chemin spécifique)
RUN npx prisma generate --schema=./src/prisma/schema.prisma

# Compilation TS -> JS (vérifie que ton script 'build' est bien 'tsc')
RUN npm run build

# --- Étape 2 : Runtime ---
FROM node:20-alpine
WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# AJOUT CRUCIAL : On copie le client généré dans le dossier dist
# pour que le require relatif de prisma.js fonctionne
COPY --from=builder /app/src/prisma/generated /app/dist/prisma/generated

# On garde aussi la config et le schéma à la racine pour les outils CLI (prisma push)
COPY --from=builder /app/src/prisma.config.js ./prisma.config.js
COPY --from=builder /app/src/prisma ./src/prisma
COPY --from=builder /app/entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh
EXPOSE 3333
ENTRYPOINT ["/bin/sh", "./entrypoint.sh"]