#!/usr/bin/env bash
# Quick script to initialize the Hermes Agent environment

if [ -f ".env" ]; then
    echo "⚠️  .env file already exists! Aborting to prevent overwriting."
    exit 1
fi

echo "🚀 Initializing Hermes Agent configuration..."

# Copy the example file
cp .env.example .env

# Ensure the data directory exists with correct permissions
mkdir -p data
# Set ownership to 1000:1000 (default HERMES_UID/GID)
sudo chown -R 1000:1000 data 2>/dev/null || echo "Note: Run 'sudo chown -R 1000:1000 data' if you encounter permission issues."

echo "✅ Successfully created .env file and data directory!"
echo "👉 Next steps:"
echo "   1. Edit .env and add your OPENROUTER_API_KEY"
echo "   2. Run 'docker compose up -d' to start the agent"
echo "   3. Open http://localhost:9119 in your browser"
