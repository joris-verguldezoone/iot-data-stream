#!/bin/sh
# On lance la synchro Prisma
echo "🚀 Lancement de l'initialisation Prisma..."
npx prisma db push --accept-data-loss

echo "✅ Schéma synchronisé. Exécution de la commande demandée..."

# Le "exec $@" est CRUCIAL : il lance la commande définie dans le docker-compose
exec "$@"