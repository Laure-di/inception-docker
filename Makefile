NAME = inception

WP_VOL = /home/lmasson/data/wp_vol/

DB_VOL = /home/lmasson/data/db_vol/

all:
	docker-compose -f ./srcs/docker-compose.yml up -d --build
	mkdir -p $(WP_VOL)
	mkdir -p $(DB_VOL)

up:
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

clear: down
	docker container prune -y;

fclean: clean
		rm -rf $(WP_VOL)
		rm -rf $(DB_VOL)
