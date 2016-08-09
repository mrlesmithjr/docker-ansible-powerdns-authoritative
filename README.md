Repo Info
=========
Builds [Docker] images for the following and links them together using `docker-compose`.
* `MySQL`
  * `tcp/33306`
* `PowerDNS-Authoritative`
  * `tcp/53`
  * `udp/53`
* `PowerDNS-Recursor`

Usage
-----
* Spin up
```
docker-compose up -d --build
```

The DB port `33306` is exposed so that you COULD spin up
https://github.com/mrlesmithjr/docker-phpipam and manage your DNS using
phpIPAM if you configure the integration.

* Validate
`dig @127.0.0.1 google.com`

* Python fun
Within the `python-powerdns-management` folder you will find a Python script
I have created a while back to manage PDNS.
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
[@mrlesmithjr]: <https://twitter.com/mrlesmithjr>
[everythingshouldbevirtual.com]: <http://everythingshouldbevirtual.com>
[mrlesmithjr@gmail.com]: <mailto:mrlesmithjr@gmail.com>
