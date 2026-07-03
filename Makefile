.PHONY: help up-% down-% logs-% restart-% down-all up-all

help: ## Show this help message
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@echo "  up-<stack>      Start a specific stack (e.g., make up-media)"
	@echo "  down-<stack>    Stop a specific stack (e.g., make down-huly)"
	@echo "  logs-<stack>    Tail logs for a specific stack (e.g., make logs-localstack)"
	@echo "  restart-<stack> Restart a specific stack"
	@echo "  down-all        Stop ALL running stacks in this repo"
	@echo ""
	@echo "Available Stacks: explorer, hermes-agent, huly, localstack, media, openvpn, proxy"

up-%:
	@echo "Starting $*..."
	@cd $* && docker compose up -d

down-%:
	@echo "Stopping $*..."
	@cd $* && docker compose down

logs-%:
	@cd $* && docker compose logs -f

restart-%:
	@echo "Restarting $*..."
	@cd $* && docker compose restart

down-all:
	@echo "Stopping all stacks..."
	-cd explorer && docker compose down
	-cd hermes-agent && docker compose down
	-cd huly && docker compose down
	-cd localstack && docker compose down
	-cd media && docker compose down
	-cd openvpn && docker compose down
	-cd proxy && docker compose down
