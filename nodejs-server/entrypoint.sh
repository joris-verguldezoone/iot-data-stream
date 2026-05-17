#!/sh
echo "🚀 Lancement de l'initialisation du DataCenter..."

# Boucle d'attente : tant que Prisma ne peut pas se connecter à la DB, on patine
until npx prisma db push --accept-data-loss; do
  echo "⏳ PostgreSQL initialise ses volumes, nouvelle tentative dans 2 secondes..."
  sleep 2
done

echo "✅ Schéma mis à jour avec succès dans PostgreSQL !"

# Génération obligatoire du client Prisma mis à jour
npx prisma generate

echo "🏃 Exec de la commande finale..."
exec "$@"