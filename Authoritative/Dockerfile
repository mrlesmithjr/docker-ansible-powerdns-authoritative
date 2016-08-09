FROM ubuntu:14.04

MAINTAINER Larry Smith Jr. <mrlesmithjr@gmail.com>

# Update apt-cache
RUN apt-get update

# Install Ansible
RUN apt-get -y install git software-properties-common && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get -y install ansible

# Copy Ansible Playbook
COPY playbook.yml /playbook.yml

# Run Ansible playbook
RUN ansible-playbook -i "localhost," -c local /playbook.yml

# Cleanup
RUN apt-get -y clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose port(s)
EXPOSE 53 53/udp 8081

# Define environment variables
ENV PDNS_ALLOW_DDNS_UPDATE yes
ENV PDNS_ALLOW_DDNS_UPDATE_FROM 0.0.0.0/0
ENV PDNS_API_KEY changeme
ENV PDNS_GMYSQL_DBNAME powerdns
ENV PDNS_GMYSQL_HOST db
ENV PDNS_GMYSQL_PASSWORD powerdns
ENV PDNS_GMYSQL_USER powerdns
ENV PDNS_JSON_INTERFACE yes
ENV PDNS_RECURSOR_SERVER pdns_recursor
ENV PDNS_WEBSERVER_ADDRESS 0.0.0.0
ENV PDNS_WEBSERVER_PASSWORD changeme
ENV PDNS_WEBSERVER_PORT 8081
ENV PDNS_WEBSERVER yes

# Copy PDNS SQL file
COPY config/pdns.sql /

# Copy entrypoint script and make executable
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Execute
CMD ["docker-entrypoint.sh"]
