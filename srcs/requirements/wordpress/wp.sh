#On check si le fichier wp déjà download, attention a stocker dans vol wp

cd /var/www/html

wp core download --allow-root
wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci"
wp core install --url=lmasson.42.fr --title="LEMP" --admin_user=${MYSQL_ADMIN} --admin_password=${MYSQL_ADMIN_PASSWORD} --skip-email
wp user create user ${USER_WP} --role=author --user_pass=${USER_WP_PASS}
wp theme install twentysixteen --activate

php-fpm7.3 -F -R
