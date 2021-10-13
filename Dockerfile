FROM docker.io/library/centos:8@sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177

ENV MAXSCALE_VERSION=6.1.3

COPY entrypoint.sh /entrypoint.sh

RUN yum install -y https://downloads.mariadb.com/MaxScale/${MAXSCALE_VERSION}/centos/8/x86_64/maxscale-${MAXSCALE_VERSION}-1.rhel.8.x86_64.rpm && \
    yum clean all -y && \
    chmod g=u /etc/passwd && \
    chmod +x entrypoint.sh && \
    chmod -R g=u /var/{lib,run,log,cache}/maxscale && \
    chgrp -R 0 /var/{lib,run,log,cache}/maxscale


COPY maxscale.cnf /etc/maxscale.cnf

USER 1001

ENTRYPOINT ["/entrypoint.sh"]
CMD ["maxscale", "--nodaemon", "--log=stdout"]

EXPOSE 6603 3306 3307 8003

ENV SERVICE_USER=maxscale \
    SERVICE_PWD=asdf1234 \
    READ_WRITE_LISTEN_ADDRESS=127.0.0.1 \
    READ_WRITE_PORT=3307 \
    READ_WRITE_PROTOCOL=MariaDBClient \
    MASTER_ONLY_LISTEN_ADDRESS=127.0.0.1 \
    MASTER_ONLY_PORT=3306 \
    MASTER_ONLY_PROTOCOL=MariaDBClient \
    MONITOR_USER=maxscale \
    MONITOR_PWD=asdf123 \
    AUTH_CONNECT_TIMEOUT=10s \
    AUTH_READ_TIMEOUT=10s \
    DB1_ADDRESS=db1.example.org \
    DB2_ADDRESS=db2.example.org \
    DB3_ADDRESS=db3.example.org \
    DB1_PORT=3306 \
    DB2_PORT=3306 \
    DB3_PORT=3306 \
    DB1_PRIO=1 \
    DB2_PRIO=2 \
    DB3_PRIO=3
