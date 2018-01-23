# MaxScale in Docker
Dockerized MariaDB MaxScale with default config for a three node galera cluster. Various settings can be configured with environemnt variables.

## Run
You need to specify the addresses for DB1 through DB3 as well as passwords for service and monitoring users:
```
docker run -e DB1_ADDRESS=127.0.0.1 -e DB2_ADDRESS=127.0.0.2 -e DB3_ADDRESS=127.0.0.3 -e SERVICE_PWD="SuperSecret1234" -e MONITOR_PWD="EvenMoreSecret" maxscale:2.1.1
```
## Configuration
Config is done through env vars:

| Name                | Default value       | Description                         |
|---------------------|---------------------|-------------------------------------|
| THREADS             | 2                   | Thread count to run MaxScale        |
| SERVICE_USER        | maxscale            | Service user                        |
| SERVICE_PWD         | `None`              | Password for the service user       |
| READ_WRITE_PORT     | 3307                | Listen port for read7write service  |
| READ_WRITE_PROTOCOL | MySQLClient         | Protocol for read/write service     |
| MASTER_ONLY_PORT    | 3306                | Listen port for master only service |
| MONITOR_USER        | maxscale            | Monitoring user                     |
| MONITOR_PWD         | `None`              | Password for the monitoring user    |
| DB1_ADDRESS         | `None`              | Address for backend DB1             |
| DB1_PORT            | 3306                | Port for backend DB1                |
| DB1_PRIO            | 1                   | Priority for backend DB1            |
| DB2_ADDRESS         | `None`              | Address for backend DB2             |
| DB2_PORT            | 3306                | Port for backend DB2                |
| DB2_PRIO            | 2                   | Priority for backend DB2            |
| DB3_ADDRESS         | `None`              | Address for backend DB3             |
| DB3_PORT            | 3306                | Port for backend DB3                |
| DB3_PRIO            | 3                   | Priority for bakcend DB3            |

### Custom configuration
To use a complete custom config, mount your own config file to `/etc/maxscale.cnf`:

```
docker run -v /home/customfile.cnf:/etc/maxscale.cnf maxscale:2.1.1
```

## Build
```
docker build --rm -t registry.vshn.net/vshn-docker/maxscale:2.2.1 .
docker push registry.vshn.net/vshn-docker/maxscale:2.2.1
```
