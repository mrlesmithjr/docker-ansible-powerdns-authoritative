Repo Info
=========
Builds [Docker] images for the following and links them together using `docker-compose`.
* `MySQL`
  * `tcp/33306`
* `PowerDNS-Authoritative`
  * `tcp/53`
  * `udp/53`
  * `tcp/8081` - PDNS API
* `PowerDNS-Recursor`

Environment settings for Authoritative Server
---------------------------------------------
Below are the defaults in the `Authoritative/Dockerfile` for Authoritative Server.
```
# Define environment variables
ENV PDNS_ALLOW_DDNS_UPDATE=yes \
    PDNS_ALLOW_DDNS_UPDATE_FROM=0.0.0.0/0 \
    PDNS_API_KEY=changeme \
    PDNS_GMYSQL_DBNAME=powerdns \
    PDNS_GMYSQL_HOST=db \
    PDNS_GMYSQL_PASSWORD=powerdns \
    PDNS_GMYSQL_USER=powerdns \
    PDNS_JSON_INTERFACE=yes \
    PDNS_LOG_DNS_QUERIES=yes \
    PDNS_RECURSOR_SERVER=pdns_recursor \
    PDNS_WEBSERVER_ADDRESS=0.0.0.0 \
    PDNS_WEBSERVER_PASSWORD=changeme \
    PDNS_WEBSERVER_PORT=8081 \
    PDNS_WEBSERVER=yes
```

Usage
-----
* Spin up containers
```
docker-compose up -d --build
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
