FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

# SSL証明書のディレクトリを作成し、自己署名証明書を生成
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=JP/ST=Tokyo/L=Shinjyuku/O=42Tokyo/OU=Inception/CN=localhost"

COPY ./config/default.conf /etc/nginx/conf.d/default.conf


CMD ["nginx", "-g", "daemon off;"]