# MaxScale in Docker

Dockerized MariaDB MaxScale with default config for a three node galera cluster. Various settings can be configured with environemnt variables.

## Run
You need to specify the addresses for DB1 through DB3 as well as passwords for service and monitoring users:
```
docker run -e DB1_ADDRESS=127.0.0.1 -e DB2_ADDRESS=127.0.0.2 -e DB3_ADDRESS=127.0.0.3 -e SERVICE_PWD="SuperSecret1234" -e MONITOR_PWD="EvenMoreSecret" quay.io/maxscale:6.1.3
```
## Configuration
Config is done through env vars:

| Name                          | Default value       | Description                             |
|-------------------------------|---------------------|-----------------------------------------|
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
| `DB1_ADDRESS`                 | `db1.example.org`   | Address for backend DB1                 |
| `DB1_PORT`                    | `3306`              | Port for backend DB1                    |
| `DB1_PRIO`                    | `1`                 | Priority for backend DB1                |
| `DB2_ADDRESS`                 | `db2.example.org`   | Address for backend DB2                 |
| `DB2_PORT`                    | `3306`              | Port for backend DB2                    |
| `DB2_PRIO`                    | `2`                 | Priority for backend DB2                |
| `DB3_ADDRESS`                 | `db3.example.org`   | Address for backend DB3                 |
| `DB3_PORT`                    | `3306`              | Port for backend DB3                    |
| `DB3_PRIO`                    | `3`                 | Priority for bakcend DB3                |

### Custom configuration
To use a complete custom config, mount your own config file to `/etc/maxscale.cnf`:

```
docker run -v /home/customfile.cnf:/etc/maxscale.cnf maxscale:6.1.3
```

### Build

A plain build will use the defaults from the table above:

```
docker build .
```

## OpenShift
To run this image as a sidecar container in OpenShift, see the [sidecar_template.yaml](openshift/sidecar_template.yaml) in the folder `openshift`. The [standalone_template.yaml](openshift/standalone_template.yaml) can be used to run a standalone instance of MaxScale. The templates need the parameters `MAXSCALE_SERVICE_PW`, `MAXSCALE_MONITOR_PW`, `DB1_ADDRESS`, `DB2_ADDRESS`, `DB3_ADDRESS` and `DATABASE_NAME` to connect to the galera cluster.


[auth_connect_timeout]: https://github.com/mariadb-corporation/MaxScale/blob/develop/Documentation/Getting-Started/Configuration-Guide.md#auth_connect_timeout
[auth_read_timeout]: https://github.com/mariadb-corporation/MaxScale/blob/develop/Documentation/Getting-Started/Configuration-Guide.md#auth_read_timeout


> [APPUiO](https://appuio.ch) -
> GitHub [@appuio](https://github.com/appuio) -
> Twitter [@appuio](https://twitter.com/appuio)
