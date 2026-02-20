#!/bin/sh
set -e

echo "🚀 Lancement de l'initialisation Prisma..."

# Vérifie si la DB est prête avant migration
echo "⏳ Attente de la base de données..."
npx prisma db push --accept-data-loss || {
  echo "❌ Échec du push, tentative de migration..."
  npx prisma migrate deploy || npx prisma migrate dev --name init
}

echo "✅ Prisma migration terminée, démarrage du serveur..."

# Lancer ton serveur Node
exec node dist/server.js
