#!/bin/bash

PDNS_RECURSOR_SERVER_IP="$(ping -q -c 1 -t 1 $PDNS_RECURSOR_SERVER | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")"

# Configure powerdns
ansible-playbook -i "localhost," -c local \
  --extra-vars="pdns_allow_ddns_update_from=$PDNS_ALLOW_DDNS_UPDATE_FROM \
  pdns_api_key=$PDNS_API_KEY pdns_allow_ddns_update=$PDNS_ALLOW_DDNS_UPDATE \
  pdns_json_interface=$PDNS_JSON_INTERFACE pdns_gmysql_dbname=$PDNS_GMYSQL_DBNAME \
  pdns_gmysql_host=$PDNS_GMYSQL_HOST pdns_gmysql_password=$PDNS_GMYSQL_PASSWORD \
  pdns_gmysql_user=$PDNS_GMYSQL_USER pdns_log_dns_queries=$PDNS_LOG_DNS_QUERIES \
  pdns_recursor_server_ip=$PDNS_RECURSOR_SERVER_IP pdns_webserver_address=$PDNS_WEBSERVER_ADDRESS \
  pdns_webserver_password=$PDNS_WEBSERVER_PASSWORD pdns_webserver_port=$PDNS_WEBSERVER_PORT \
  pdns_webserver=$PDNS_WEBSERVER" /pdns_config.yml

# Check if DB imported
# if [[ ! -f /db_imported ]]; then
#   mysql --host=$PDNS_GMYSQL_HOST --user=$PDNS_GMYSQL_USER \
#   --password=$PDNS_GMYSQL_PASSWORD --database=$PDNS_GMYSQL_DBNAME < /pdns.sql && \
#   touch /db_imported
# fi

# Wait for DB and Recursor to start
sleep 10

if [ "$#" -gt 0 ]; then
  exec /usr/sbin/pdns_server "$@"
else
  exec /usr/sbin/pdns_server --daemon=no --guardian=no --control-console --loglevel=9
fi
