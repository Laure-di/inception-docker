#!/bin/sh

mysql_install_db
service mysql start

if [ ! -d /var/lib/mysql/wp_wordpress ]; then
mysql_secure_installation<<EOF

y
secret
secret
y
y
y
y
EOF

until mysqladmin ping;do
sleep 2
done
mysql -u root -e "CREATE DATABASE '${MYSQL_DATABAS}';"
mysql -u root -e "CREATE USER '${MYSQL_ADMIN}'@'localhost' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'localhost';"
mysql -u root -e "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT ALL ON wp_wordpress.* TO '${MYSQL_USER}'@'localhost'"
mysql -u root -e "FLUSH PRIVILEGES;"
echo "Database created!"
else
echo "The database already exist!"
fi
service mysql stop
