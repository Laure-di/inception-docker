NAME = inception

WP_VOL = /home/lmasson/data/wp_vol/

DB_VOL = /home/lmasson/data/db_vol/

all:
#mkdir -p $(WP_VOL)
#	mkdir -p $(DB_VOL)
	docker-compose -f ./srcs/docker-compose.yaml up -d --build

up:
	docker-compose -f ./srcs/docker-compose.yaml up -d

down:
	docker-compose -f ./srcs/docker-compose.yaml down

clear: down
	docker container prune -y;

fclean: clean
		rm -rf $(WP_VOL)
		rm -rf $(DB_VOL)
