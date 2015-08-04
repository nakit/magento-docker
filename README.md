# About this Repo

This is a fork of https://github.com/paimpozhil/docker-magento, with an emphasis on less dependecies and smaller image.

## Requirements

This container requires two other containers. One is a MySQL container linked as `db`, the other is a Memcached container linked as `cache`. For example:
```
docker run --name mysqldb -e MYSQL_ROOT_PASSWORD="roopass" -e MYSQL_DATABASE="magento" -e MYSQL_USER="magento" -e MYSQL_PASSWORD="magentopass" --detach mysql
```
And:
```
docker run --name memcache --detach memcached
```

Note: changing `MYSQL_ROOT_PASSWORD`, `MYSQL_USER`, and `MYSQL_PASSWORD` to something more secure is recommended.

## Building this container

```
docker build --tag nakit/magento https://github.com/nakit/magento-docker.git
```

## Starting this container

```
docker run --publish 80:80 --link mysqldb:db --link memcache:cache --detach nakit/magento
```

### Container environment variables

`DB_ENV_MYSQL_DATABASE`, imported from `db`, defaults to `magento`
`DB_ENV_MYSQL_USER`, imported from `db`
`DB_ENV_MYSQL_PASSWORD`, imported from `db`

`MAGENTO_LOCALE`, defaults to `pt_BR`
`MAGENTO_TIMEZONE`, defaults to `America/Sao_Paulo`
`MAGENTO_CURRENCY`, defaults to `BRL`

`MAGENTO_ADMIN_USER`, defaults to `admin`
`MAGENTO_ADMIN_PASS`, defaults to `admin25`
`MAGENTO_ADMIN_EMAIL`, defaults to `admin@localhost`
`MAGENTO_ADMIN_FIRSTNAME`, defaults to `Admin`
`MAGENTO_ADMIN_LASTNAME`, defaults to `Admin`
