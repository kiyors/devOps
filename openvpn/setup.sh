#!/usr/bin/env bash

if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "⚠️  Created .env file. Please edit it to set your VPN_DOMAIN before continuing."
    exit 1
fi

source .env

if [ -z "$VPN_DOMAIN" ] || [ "$VPN_DOMAIN" == "vpn.yourdomain.com" ]; then
    echo "❌ Error: You must change VPN_DOMAIN in the .env file to your actual public IP or domain."
    exit 1
fi

echo "🚀 Initializing OpenVPN configuration for $VPN_DOMAIN..."

# Generate config
docker compose run --rm openvpn ovpn_genconfig -u udp://$VPN_DOMAIN

# Init PKI (Will prompt for CA passphrase)
docker compose run --rm openvpn ovpn_initpki

echo "✅ Initialization complete! Run 'docker compose up -d' to start the server."
