chmod o+w /dev/stdout
chmod o+w /dev/stderr
if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
    echo "First run"
    mysqld&
    until mysqladmin ping; do
        sleep 2
    done
    mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE};"
    mysql -u root -e "SET GLOBAL general_log_file='mariadb.log';"
    mysql -u root -e "CREATE USER '${MYSQL_ADMIN}'@'%' IDENTIFIED BY '${MYSQL_ADMIN}';"
    mysql -u root -e "GRANT ALL ON *.* TO '${MYSQL_DATABASE}'@'%';"
    mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL ON db_wordpress.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
    mysql -e "DELETE FROM mysql.user WHERE user=''"
    mysql -e "DELETE FROM mysql.user WHERE user='root'"
    mysql -e "FLUSH PRIVILEGES"
    killall mysqld
    echo "End first run"
    else
        echo "database already created"
fi
mysqld --slow-query-log-file=/dev/stderr --slow-query-log
