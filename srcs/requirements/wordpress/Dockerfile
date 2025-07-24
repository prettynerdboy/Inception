FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php php-fpm php-mysql curl unzip

# WordPressダウンロード
RUN curl -o /tmp/latest.zip https://wordpress.org/latest.zip

# 解凍
RUN unzip /tmp/latest.zip -d /tmp

# HTML ディレクトリの作成
RUN mkdir -p /var/www/html

# WordPress ファイルの移動
RUN mv /tmp/wordpress/* /var/www/html

# 所有者変更
RUN chown -R www-data:www-data /var/www/html

# phpfpmの通信をソケットからポートに切り替え、
RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php
# 同一マシン内ならソケットの方が早いからデフォルトではソケット

#立ち上げの自動化も必要

# WP-CLIインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]

