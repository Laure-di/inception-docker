#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

if [ -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
echo "The database already exist"
else
mysql_secure_installation <<EOF

Y
hellocoucou
hellocoucou
Y
Y
Y
Y
EOF
until mysqladmin ping;do
sleep 2
done
mysql -uroot -e "CREATE DATABASE ${MYSQL_DATABASE};"
mysql -uroot -e "CREATE USER '${MYSQL_ADMIN}'@'localhost' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN}'@'localhost';"
mysql -uroot -e "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT ALL ON wp_wordpress.* TO '${MYSQL_USER}'@'localhost'"
mysql -uroot -e "FLUSH PRIVILEGES;"
echo "Database created!"
fi
/etc/init.d/mysql stop
exec "$@"
