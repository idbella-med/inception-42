NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml
LOGIN = mohidbel

all: up

up:
	mkdir -p /home/$(LOGIN)/data/mariadb
	mkdir -p /home/$(LOGIN)/data/wordpress
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

restart: down up

clean: down
	docker system prune -af

fclean: clean
	sudo rm -rf /home/$(LOGIN)/data/mariadb/*
	sudo rm -rf /home/$(LOGIN)/data/wordpress/*
	docker volume prune -f

re: fclean all

.PHONY: all up down stop start restart clean fclean re