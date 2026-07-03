#!/usr/bin/env bash

if [ -f ".env" ]; then
    echo "⚠️  .env file already exists! Aborting."
    exit 1
fi

echo "🚀 Initializing LocalStack configuration..."

cp .env.example .env
mkdir -p volume

echo "✅ Created .env and volume directory!"
echo "👉 Run 'docker compose up -d' to start LocalStack."
