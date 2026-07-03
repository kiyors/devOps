#!/usr/bin/env bash

echo "==============================================="
echo "🚀 INTERACTIVE HERMES AGENT SETUP"
echo "==============================================="

if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "✅ Copied .env.example to .env"
else
    echo "✅ Found existing .env file. We will update it."
fi

# Prompt for OpenRouter API Key
read -p "Enter your OpenRouter API Key (or press enter to skip): " OPENROUTER_KEY
if [ -n "$OPENROUTER_KEY" ]; then
    # Use sed to replace the key in the .env file.
    sed -i '' "s|OPENROUTER_API_KEY=.*|OPENROUTER_API_KEY=$OPENROUTER_KEY|" .env 2>/dev/null || sed -i "s|OPENROUTER_API_KEY=.*|OPENROUTER_API_KEY=$OPENROUTER_KEY|" .env
    echo "✅ OpenRouter API Key saved!"
fi

# Prompt for Dashboard Domain
echo ""
echo "Which domain would you like to use for the dashboard?"
echo "  1) hermes.localhost (Recommended - No configuration required on Mac/Chrome)"
echo "  2) hermes.local (Requires editing /etc/hosts manually)"
read -p "Select option [1 or 2, default 1]: " DOMAIN_OPT

if [ "$DOMAIN_OPT" == "2" ]; then
    DOMAIN="hermes.local"
else
    DOMAIN="hermes.localhost"
fi

if grep -q "^DASHBOARD_DOMAIN" .env; then
    sed -i '' "s|DASHBOARD_DOMAIN=.*|DASHBOARD_DOMAIN=$DOMAIN|" .env 2>/dev/null || sed -i "s|DASHBOARD_DOMAIN=.*|DASHBOARD_DOMAIN=$DOMAIN|" .env
else
    echo -e "\n# Dashboard domain for Traefik Proxy\nDASHBOARD_DOMAIN=$DOMAIN" >> .env
fi
echo "✅ Dashboard domain set to: $DOMAIN"

# Ensure the data directory exists with correct permissions
mkdir -p data
sudo chown -R 1000:1000 data 2>/dev/null || echo "⚠️ Note: Could not change ownership to 1000:1000 automatically. You may need to run 'sudo chown -R 1000:1000 data' if you hit permission issues."

echo ""
echo "==============================================="
echo "✅ Hermes is fully configured!"
echo "The agent stack will now boot up in the background..."
echo "==============================================="
