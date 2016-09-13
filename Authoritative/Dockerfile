FROM mrlesmithjr/ubuntu-ansible:14.04

MAINTAINER Larry Smith Jr. <mrlesmithjr@gmail.com>

# Copy Ansible Related Files
COPY config/ansible/ /

# Run Ansible playbook
RUN ansible-playbook -i "localhost," -c local /playbook.yml && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose port(s)
EXPOSE 53 53/udp 8081

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

# Copy entrypoint script and make executable
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Execute
CMD ["docker-entrypoint.sh"]
