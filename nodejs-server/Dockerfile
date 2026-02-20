# Étape 1 : Build
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npx prisma generate
RUN npm run build

# Étape 2 : Runtime
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app /app

# Copier ton script d’entrée
COPY entrypoint.sh .

EXPOSE 3333

RUN npm install -g prisma ts-node 
# remplacer ts-node par npx tsc

ENTRYPOINT ["./entrypoint.sh"]
