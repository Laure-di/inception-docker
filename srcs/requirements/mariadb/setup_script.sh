#!/bin/sh

mysql_install_db

etc/init.d/mysql start

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
echo "& y y abc abc y y y y" | ./usr/bin/mysql_secure_installation
until mysqladmin ping;do
sleep 2
done
mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE};"
mysql -u root -e "CREATE USER '${MYSQL_ADMIN}'@'localhost' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN}'@'localhost';"
mysql -u root -e "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT ALL ON wp_wordpress.* TO '${MYSQL_USER}'@'localhost'"
mysql -u root -e "FLUSH PRIVILEGES;"
echo "Database created!"
else
echo "The database already exist!"
fi
#etc/init.d/mysql stop
chmod 777 /var/run/mysqld/mysqld.sock
exec "$@"
