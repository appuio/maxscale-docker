# MaxScale in Docker

![Docker](https://github.com/kheekdotcom/maxscale-docker/workflows/Docker/badge.svg)

Dockerized MariaDB MaxScale with default config for a three node galera cluster. Various settings can be configured with environemnt variables.

## Run
You need to specify the addresses for DB1 through DB3 as well as passwords for service and monitoring users:
```
docker run -e DB1_ADDRESS=127.0.0.1 -e DB2_ADDRESS=127.0.0.2 -e DB3_ADDRESS=127.0.0.3 -e SERVICE_PWD="SuperSecret1234" -e MONITOR_PWD="EvenMoreSecret" maxscale:2.1.1
```
## Configuration
Config is done through env vars:

| Name                          | Default value       | Description                             |
|-------------------------------|---------------------|-----------------------------------------|
| `THREADS`                     | `2`                 | Thread count to run MaxScale            |
| `SERVICE_USER`                | `maxscale`          | Service user                            |
| `SERVICE_PWD`                 |                     | Password for the service user           |
| `READ_WRITE_LISTEN_ADDRESS`   | `127.0.0.1`         | Listen address for read/write service   |
| `READ_WRITE_PORT`             | `3307`              | Listen port for read/write service      |
| `READ_WRITE_PROTOCOL`         | `MariaDBClient`     | Protocol for read/write service         |
| `MASTER_ONLY_LISTEN_ADDRESS`  | `127.0.0.1`         | Listen address for master only service  |
| `MASTER_ONLY_PORT`            | `3306`              | Listen port for master only service     |
| `MASTER_ONLY_PROTOCOL`        | `MariaDBClient`     | Protocol for master onyl service        |
| `MONITOR_USER`                | `maxscale`          | Monitoring user                         |
| `MONITOR_PWD`                 |                     | Password for the monitoring user        |
| `AUTH_CONNECT_TIMEOUT`        | `10`                | Value for [`auth_connect_timeout`][]    |
| `AUTH_READ_TIMEOUT`           | `10`                | Value for [`auth_read_timeout`][]       |
| `DB1_ADDRESS`                 |                     | Address for backend DB1                 |
| `DB1_PORT`                    | `3306`              | Port for backend DB1                    |
| `DB1_PRIO`                    | `1`                 | Priority for backend DB1                |
| `DB2_ADDRESS`                 |                     | Address for backend DB2                 |
| `DB2_PORT`                    | `3306`              | Port for backend DB2                    |
| `DB2_PRIO`                    | `2`                 | Priority for backend DB2                |
| `DB3_ADDRESS`                 |                     | Address for backend DB3                 |
| `DB3_PORT`                    | `3306`              | Port for backend DB3                    |
| `DB3_PRIO`                    | `3`                 | Priority for bakcend DB3                |

### Custom configuration
To use a complete custom config, mount your own config file to `/etc/maxscale.cnf`:

```
docker run -v /home/customfile.cnf:/etc/maxscale.cnf maxscale:2.1.1
```

## Build
```
docker build --rm -t docker.pkg.github.com/kheekdotcom/maxscale-docker/maxscale:latest .
docker push docker.pkg.github.com/kheekdotcom/maxscale-docker/maxscale:latest
```

[auth_connect_timeout]: https://github.com/mariadb-corporation/MaxScale/blob/develop/Documentation/Getting-Started/Configuration-Guide.md#auth_connect_timeout
[auth_read_timeout]: https://github.com/mariadb-corporation/MaxScale/blob/develop/Documentation/Getting-Started/Configuration-Guide.md#auth_read_timeout
