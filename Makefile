.PHONY: build up down shell clean logs restart install

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

shell:
	docker-compose exec dev-env bash

run:
	docker-compose run --rm dev-env bash

logs:
	docker-compose logs -f dev-env

restart:
	docker-compose restart

clean:
	docker-compose down --volumes --rmi all

rebuild: clean build up

dev: build run

install-node:
	docker-compose exec dev-env npm install

install-python:
	docker-compose exec dev-env pip3 install -r requirements.txt

create-react:
	docker-compose exec dev-env npx create-react-app $(name)

create-vue:
	docker-compose exec dev-env vue create $(name)

create-angular:
	docker-compose exec dev-env ng new $(name)

jupyter:
	docker-compose exec dev-env jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
