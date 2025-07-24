#!/bin/bash
set -e

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

# DBが存在しない場合のみ初期化
if [ ! -d /var/lib/mysql/mysql ]; then
  echo "Initializing MariaDB..."
  mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
fi

# mysqldをバックグラウンドで起動
mysqld_safe &
sleep 5

# 初期データベースとユーザー作成
mysql -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# フォアグラウンドで実行
wait

