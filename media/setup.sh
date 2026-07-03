#!/usr/bin/env bash

if [ -f ".env" ]; then
    echo "⚠️  .env file already exists! Aborting to prevent overwriting."
    exit 1
fi

echo "🚀 Initializing Media Stack configuration..."

cp .env.example .env

# Generate a random JWT secret for Jellystat
RANDOM_SECRET=$(openssl rand -hex 32)
sed -i '' "s/JELLYSTAT_JWT_SECRET=.*/JELLYSTAT_JWT_SECRET=${RANDOM_SECRET}/" .env 2>/dev/null || sed -i "s/JELLYSTAT_JWT_SECRET=.*/JELLYSTAT_JWT_SECRET=${RANDOM_SECRET}/" .env

echo "✅ Created .env file and generated Jellystat secret!"
echo "👉 Edit .env to verify your PUID and PGID before running 'docker compose up -d'."
