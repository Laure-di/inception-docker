#On check si le fichier wp déjà download, attention a stocker dans vol wp
if [ ! -f /var/www/html/wp-config.php ]; then
 	cd /var/www/html/
	wp core download --allow-root
	wp config create --dbname=${DB_WORDPRESS} --dbuser=${DB_USER} --dbpass=${DB_USER_PASSWORD} --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url=${WP_URL} --title="${WP_TITLE}" --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_MAIL} --skip-email --allow-root
	wp user create ${WP_USER} ${WP_USER_MAIL} --role=author --user_pass=${WP_USER_PASSWORD} --allow-root
	wp theme install "teluro" --activate --allow-root
	else
		echo "wordpress already created"
fi

php-fpm7.3 -F -R
