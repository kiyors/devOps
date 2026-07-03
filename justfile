# Available Stacks: explorer, hermes-agent, huly, localstack, media, openvpn, proxy

# Show available commands
default:
    @just --list

# Start a specific stack (e.g., 'just up media')
up stack:
    @echo "Starting {{stack}}..."
    cd {{stack}} && docker compose up -d

# Stop a specific stack (e.g., 'just down huly')
down stack:
    @echo "Stopping {{stack}}..."
    cd {{stack}} && docker compose down

# Tail logs for a specific stack (e.g., 'just logs localstack')
logs stack:
    cd {{stack}} && docker compose logs -f

# Restart a specific stack (e.g., 'just restart openvpn')
restart stack:
    @echo "Restarting {{stack}}..."
    cd {{stack}} && docker compose restart

# Stop all running stacks in this repository
down-all:
    @echo "Stopping all stacks..."
    -cd explorer && docker compose down
    -cd hermes-agent && docker compose down
    -cd huly && docker compose down
    -cd localstack && docker compose down
    -cd media && docker compose down
    -cd openvpn && docker compose down
    -cd proxy && docker compose down
