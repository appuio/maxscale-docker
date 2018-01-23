FROM debian:stretch-slim

ENV MAXSCALE_VERSION=2.2.1

RUN apt-get update && apt-get install --no-install-recommends -y \
        curl \
        ca-certificates \
        dumb-init \
        libcurl4-openssl-dev \
        curl \
        libaio1 \
        openssl \
        libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/* &&\
    mkdir /app /etc/maxscale.cnf.d && \
    groupadd maxscale && \
    useradd -r -u 1001 -g maxscale maxscale

WORKDIR /app

COPY entrypoint.sh .
COPY maxscale.cnf /etc/maxscale.cnf

RUN chmod +x entrypoint.sh && \
    curl https://downloads.mariadb.com/MaxScale/${MAXSCALE_VERSION}/debian/dists/stretch/main/binary-amd64/maxscale-${MAXSCALE_VERSION}-1.debian.stretch.x86_64.deb -o maxscale.deb --location && \
    dpkg -i maxscale.deb && \
    apt-get install -f -y && \
    rm maxscale.deb && \
    chown maxscale:maxscale -R . && \
    chgrp -R 0 . && \
    chmod -R g=u . /etc/passwd

USER 1001

ENTRYPOINT ["dumb-init", "/app/entrypoint.sh"]
CMD [ "/usr/bin/maxscale", "--nodaemon", "--log=stdout" ]

EXPOSE 6603 3306 3307

ENV THREADS=2 \
    SERVICE_USER=maxscale \
    READ_WRITE_PORT=3307 \
    READ_WRITE_PROTOCOL=MySQLClient \
    MASTER_ONLY_PORT=3306 \
    MONITOR_USER=maxscale \
    CLI_ADDR=localhost \
    CLI_PORT=6603 \
    DB1_PORT=3306 \
    DB2_PORT=3306 \
    DB3_PORT=3306 \
    DB1_PRIO=1 \
    DB2_PRIO=2 \
    DB3_PRIO=3
