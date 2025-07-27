.PHONY: help build start stop shell clean setup teardown

help: ## Show this help message
	@echo "Gaming Container Management"
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

setup: ## Allow X11 connections and create directories
	@echo "Setting up gaming environment..."
	@xhost +local:docker
	@mkdir -p game-data steam-data wine-data
	@echo "Setup complete!"

build: ## Build the gaming container
	@echo "Building gaming container..."
	@docker-compose build

start: setup build ## Start the gaming container
	@echo "Starting gaming container..."
	@docker-compose up -d
	@echo "Container started! Use 'make shell' to access it."

stop: ## Stop the gaming container
	@echo "Stopping gaming container..."
	@docker-compose down

shell: ## Access the gaming container shell
	@docker-compose exec gaming-container bash

restart: stop start ## Restart the gaming container

clean: ## Remove container and images
	@echo "Cleaning up..."
	@docker-compose down --rmi all --volumes
	@docker system prune -f

teardown: clean ## Complete cleanup including X11 permissions
	@echo "Performing complete teardown..."
	@xhost -local:docker
	@echo "Teardown complete!"

logs: ## Show container logs
	@docker-compose logs -f

status: ## Show container status
	@docker-compose ps

steam: ## Launch Steam directly
	@docker-compose exec gaming-container sudo -u gamer steam

wine: ## Configure Wine
	@docker-compose exec gaming-container sudo -u gamer winecfg