#!/bin/sh

chmod o+w /dev/stdout
chmod o+w /dev/stderr


if [ -d /var/lib/mysql/wp_word ]; then
	echo "The database already exist!"
else
#	service mysql start
#	mysql_secure_installation


	mysqld&
	until mysqladmin ping;do
		echo "sleep"
		sleep 2
	done
	mysql -u root -e "CREATE DATABASE wp_wordpress;"
	mysql -u root -e "SET GLOBAL general_log=1; SET GLOBAL general_log_file='mariadb.log';"
	mysql -u root -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'coucou';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';"
	mysql -u root -e "CREATE USER 'lmasson'@'localhost' IDENTIFIED BY 'salut'; GRANT ALL ON wp_wordpress.* TO 'lmasson'@'localhost';"
	mysql -u root -e "FLUSH PRIVILEGES;"
	killall mysqld
	echo "Database created!"
	fi
	mysqld --slow-query-log-file=/dev/stderr --slow-query-log
