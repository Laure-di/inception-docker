NAME = inception

WP_VOL = /home/lmasson/data/wp_vol/

DB_VOL = /home/lmasson/data/db_vol/

all:
	mkdir -p $(WP_VOL)
	mkdir -p $(DB_VOL)
	docker-compose -f ./srcs/docker-compose.yml up -d --build

up:
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a;

fclean: clean
		rm -rf $(WP_VOL)
		rm -rf $(DB_VOL)
