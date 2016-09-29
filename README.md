Repo Info
=========
This repo contains PowerDNS Authoritative for the following
versions..  
`3.4.10` - latest
`3.4.9`
`3.4.8`
`3.4.7`
`4.x` - development

Each of these are available separately using [Docker] hub as:
`mrlesmithjr/powerdns-authoritative:3.4.10`
`mrlesmithjr/powerdns-authoritative:3.4.9`
`mrlesmithjr/powerdns-authoritative:3.4.8`
`mrlesmithjr/powerdns-authoritative:3.4.7`
`mrlesmithjr/powerdns-authoritative:4.x`

Environment settings for Authoritative Server
---------------------------------------------
Below are the defaults in the `Authoritative/Dockerfile` for Authoritative Server.
```
# Define environment variables
ENV PDNS_ALLOW_DDNS_UPDATE="yes" \
    PDNS_ALLOW_DDNS_UPDATE_FROM="0.0.0.0/0" \
    PDNS_API_KEY="changeme" \
    PDNS_GMYSQL_DBNAME="powerdns" \
    PDNS_GMYSQL_HOST="pdns-db" \
    PDNS_GMYSQL_PASSWORD="powerdns" \
    PDNS_GMYSQL_USER="powerdns" \
    PDNS_JSON_INTERFACE="yes" \
    PDNS_LOG_DNS_QUERIES="yes" \
    PDNS_RECURSOR_SERVER="pdns-recursor" \
    PDNS_RECURSOR_SERVER_PORT="5300"
    PDNS_WEBSERVER_ADDRESS="0.0.0.0" \
    PDNS_WEBSERVER_PASSWORD="changeme" \
    PDNS_WEBSERVER_PORT="8081" \
    PDNS_WEBSERVER="yes"
```

Consuming from command line:
----------------------------
Spin up DB:
```
docker run -d --name db -p 33306:3306 \
  -e MYSQL_ROOT_PASSWORD="powerdns" \
  -e MYSQL_DATABASE="powerdns" \
  -e MYSQL_USER="powerdns" \
  -e MYSQL_PASSWORD="powerdns" \
  mrlesmithjr/mysql
```

Spin up PDNS Recursor:
```
docker run -d --name pdns-recursor \
  -e PDNS_RECURSOR_LOCAL_ADDRESS="0.0.0.0" \
  -e PDNS_RECURSOR_LISTEN_PORT="5300" \
  mrlesmithjr/powerdns-recursor:3.7.3
```

Spin up PDNS Authoritative:
```
docker run -d --name pdns-authoritative \
  -p 53:53 -p 53:53/udp -p 8081:8081 \
  --link db:db --link pdns-recursor:pdns-recursor \
  -e PDNS_ALLOW_DDNS_UPDATE="yes" \
  -e PDNS_ALLOW_DDNS_UPDATE_FROM="0.0.0.0/0" \
  -e PDNS_API_KEY="changeme" \
  -e PDNS_GMYSQL_DBNAME="powerdns" \
  -e PDNS_GMYSQL_HOST="db" \
  -e PDNS_GMYSQL_PASSWORD="powerdns" \
  -e PDNS_GMYSQL_USER="powerdns" \
  -e PDNS_JSON_INTERFACE="yes" \
  -e PDNS_LOG_DNS_QUERIES="yes" \
  -e PDNS_RECURSOR_SERVER="pdns-recursor" \
  -e PDNS_RECURSOR_SERVER_PORT="5300" \
  -e PDNS_WEBSERVER_ADDRESS="0.0.0.0" \
  -e PDNS_WEBSERVER_PASSWORD="changeme" \
  -e PDNS_WEBSERVER_PORT="8081" \
  -e PDNS_WEBSERVER="yes" \
  mrlesmithjr/powerdns-authoritative:3.4.9
```

Consuming using `docker-compose`
--------------------------------
* Spin up containers
```
docker-compose up -d
```

The DB port `33306` is exposed so that you COULD spin up
[phpIPAM] and manage your DNS using
phpIPAM if you configure the integration within [phpIPAM] PowerDNS settings.

* Validate
`dig @127.0.0.1 google.com`
Now configure some of your devices to use the `DockerHostIP` for DNS.

* Python fun
Within the `python-powerdns-management` folder you will find a Python script
I had created a while back to manage PDNS.
http://everythingshouldbevirtual.com/python-manage-powerdns-zonesrecords

Backing up DB data
------------------
If you find yourself in need of backing up your DB data in order to migrate to
another host or just to backup the data in general. You can do that as simple as
below:
* Requirements
  * Destination mountpoint to backup to `/backups`

We will use the method of backing up using the `--volumes-from` [Docker] volume
option. This process will spin up a temporary container, mount the
`/var/lib/mysql` folder, and then back it all up to a `tar.gz` file in our
`/backups` folder.
```
docker run --rm --volumes-from dockeransiblepowerdns_db_1 \
-v /backups:/backup ubuntu tar cvzf /backup/dockeransiblepowerdns_db_1.backup.tar.gz \
/var/lib/mysql
```
And to validate that the backup exists:
```
ll /backups
total 550
drwxrwxrwx  2 root root      3 Aug 11 01:01 ./
drwxr-xr-x 24 root root   4096 Aug 11 00:47 ../
-rw-r--r--  1 root root 811475 Aug 11 01:01 dockeransiblepowerdns_db_1.backup.tar.gz
```
Now you can copy/move that anywhere and extract it with all of your data intact.

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- [@mrlesmithjr]
- [everythingshouldbevirtual.com]
- [mrlesmithjr@gmail.com]


[Ansible]: <https://www.ansible.com/>
[Docker]: <https://www.docker.com>
[phpIPAM]: <https://github.com/mrlesmithjr/docker-phpipam>
[@mrlesmithjr]: <https://twitter.com/mrlesmithjr>
[everythingshouldbevirtual.com]: <http://everythingshouldbevirtual.com>
[mrlesmithjr@gmail.com]: <mailto:mrlesmithjr@gmail.com>
