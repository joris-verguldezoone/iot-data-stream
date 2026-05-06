# --- Étape 1 : Build ---
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

# On copie tout (sauf ce qui est dans .dockerignore)
COPY . .

# On génère Prisma
RUN npx prisma generate --schema=./src/prisma/schema.prisma

# On compile (ça crée le dossier /app/dist/ sans le sous-dossier src)
RUN npm run build

# --- Étape 2 : Runtime ---
FROM node:20-alpine
WORKDIR /app

# On ne récupère que le nécessaire
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# On place ton fichier de config à la racine de /app
# Note : Vérifie si c'est .ts ou .js sur ton disque
COPY --from=builder /app/prisma.config.ts ./prisma.config.ts

# On garde le dossier prisma pour les outils CLI, mais on le met dans /app/prisma
COPY --from=builder /app/src/prisma ./prisma

COPY --from=builder /app/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

EXPOSE 3333
ENTRYPOINT ["/bin/sh", "./entrypoint.sh"]