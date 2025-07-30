.PHONY: build up down shell clean logs restart

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

shell:
	docker-compose exec libft-dev bash

run:
	docker-compose run --rm libft-dev bash

logs:
	docker-compose logs -f libft-dev

restart:
	docker-compose restart

clean:
	docker-compose down --volumes --rmi all

rebuild: clean build up

dev: build run
