#!/usr/bin/env bash
# Quick script to generate secure secrets and create a .env file

if [ -f ".env" ]; then
  echo "⚠️  .env file already exists! Aborting to prevent overwriting."
  exit 1
fi

echo "🚀 Generating secure secrets for Huly..."

# Generate 32-byte hex strings
SECRET=$(openssl rand -hex 32)
CR_PASSWORD=$(openssl rand -hex 32)
REDPANDA_PASSWORD=$(openssl rand -hex 32)

# Copy the example and replace the placeholder secrets
cp .env.example .env

# Replace placeholders with the generated secrets (macOS compatible sed)
sed -i '' "s/^SECRET=.*/SECRET=${SECRET}/" .env
sed -i '' "s/^CR_USER_PASSWORD=.*/CR_USER_PASSWORD=${CR_PASSWORD}/" .env
sed -i '' "s/^REDPANDA_ADMIN_PWD=.*/REDPANDA_ADMIN_PWD=${REDPANDA_PASSWORD}/" .env

echo "✅ Successfully created .env file with generated secrets!"
echo "👉 Next steps:"
echo "   1. Edit .env to set your FRONT_URL (if not running on localhost)"
echo "   2. Run 'docker compose up -d' to start Huly"
