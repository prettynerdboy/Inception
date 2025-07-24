#!/bin/bash
set -e

# WordPressファイルが存在しなければダウンロード (bind mountの初回上書き対策)
if [ -z "$(ls -A /var/www/html)" ]; then
  echo "WordPressコアファイルを展開中..."
  wp core download --path=/var/www/html --allow-root
fi

# WordPressがすでにインストール済みか確認
if ! wp core is-installed --path=/var/www/html --allow-root; then
  echo "WordPress初期設定を開始します..."

  wp core config \
    --dbname=$WORDPRESS_DB_NAME \
    --dbuser=$WORDPRESS_DB_USER \
    --dbpass=$WORDPRESS_DB_PASSWORD \
    --dbhost=$WORDPRESS_DB_HOST \
    --path=/var/www/html \
    --allow-root
    
  echo "管理ユーザーを追加"
  wp core install \
    --url=$WORDPRESS_URL \
    --title=$WORDPRESS_TITLE \
    --admin_user=$WORDPRESS_ADMIN_USER \
    --admin_password=$WORDPRESS_ADMIN_PASS \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --path=/var/www/html \
    --skip-email \
    --allow-root

  # 一般ユーザーを追加
  echo "一般ユーザーを追加"
  wp user create \
    $WORDPRESS_USER_LOGIN \
    $WORDPRESS_USER_EMAIL \
    --user_pass=$WORDPRESS_USER_PASS \
    --role=author \
    --path=/var/www/html \
    --allow-root
else
  echo "WordPressは既インストール済みです"
fi

# php-fpm 起動
exec php-fpm7.4 -F