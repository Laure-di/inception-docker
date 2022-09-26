#On check si le fichier wp déjà download, attention a stocker dans vol wp

wp core download --allow-root
wp config create --dbname=wp_wordpress --dbuser=admin --dbpass=coucou --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci"
wp core install --url=lmasson.42.fr --title="LEMP" --admin_user=lmasson --admin_password=hello --skip-email
wp user create user user@student.42.fr --role=author --user_pass=yolo
wp theme install twentysixteen --activate
