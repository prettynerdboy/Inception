FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./tools/setup.sh /usr/local/bin/setup.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /usr/local/bin/setup.sh


EXPOSE 3306

CMD ["/usr/local/bin/setup.sh"]
