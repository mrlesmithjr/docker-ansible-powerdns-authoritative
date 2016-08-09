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
