.PHONY: build run stop clean shell steam help

all: build

build:
	docker-compose build

run:
	docker-compose up -d
	docker-compose exec gaming-benchmark /bin/bash

stop:
	docker-compose down

clean:
	docker-compose down --rmi all --volumes --remove-orphans
	docker system prune -f

shell:
	docker-compose exec gaming-benchmark /bin/bash

steam:
	@echo "Launching Steam with AMD RX 6500 GPU..."
	docker-compose exec --user benchuser gaming-benchmark bash -c 'export DRI_PRIME=1; export AMD_VULKAN_ICD=RADV; export RADV_PERFTEST=gpl; export DISPLAY=:0; export QT_X11_NO_MITSHM=1; steam'

gpu-check:
	@echo "Checking AMD GPU status..."
	docker-compose exec gaming-benchmark bash -c 'export DRI_PRIME=1; lspci | grep -i "vga\|amd\|radeon"'

logs:
	docker-compose logs -f gaming-benchmark

help:
	@echo "Available commands:"
	@echo "  build      - Build the Docker image"
	@echo "  run        - Run container interactively"
	@echo "  stop       - Stop the container"
	@echo "  clean      - Clean up Docker resources"
	@echo "  shell      - Get shell in running container"
	@echo "  steam      - Launch Steam with AMD GPU"
	@echo "  gpu-check  - Check AMD GPU status"
	@echo "  logs       - Show container logs"
	@echo "  help       - Show this help"
