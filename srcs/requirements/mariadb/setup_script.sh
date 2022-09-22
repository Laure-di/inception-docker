#!/bin/sh

chmod o+w /dev/stdout
chmod o+w /dev/stderr

mysql_install_db
service mysql start

if [ -d /var/lib/mysql/wp_wordpress ]; then
	echo "The database already exist!"
else
	mysql_secure_installation <<_EOF_

	Y
	coucou4ll
	coucou4ll
	Y
	n
	Y
	Y
_EOF_

	until mysqladmin ping;do
		sleep 2
	done
	mysql -u root -e "CREATE DATABASE wp_wordpress;"
	mysql -u root -e "SET GLOBAL general_log=1; SET GLOBAL general_log_file='mariadb.log';"
	mysql -u root -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'coucou';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';"
	mysql -u root -e "CREATE USER 'lmasson'@'localhost' IDENTIFIED BY 'salut'; GRANT ALL ON wp_wordpress.* TO 'lmasson'@'localhost'"
	mysql -u root -e "FLUSH PRIVILEGES;"
	echo "Database created!"
	fi
mysqld --slow-query-log-file=/dev/stderr --slow-query-log
