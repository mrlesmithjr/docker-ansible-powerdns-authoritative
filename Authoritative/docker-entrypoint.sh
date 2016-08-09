#!/bin/bash

PDNS_RECURSOR_SERVER_IP="$(ping -q -c 1 -t 1 $PDNS_RECURSOR_SERVER | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")"

# Configure powerdns
cat > /etc/powerdns/pdns.conf <<EOF
allow-dnsupdate-from=$PDNS_ALLOW_DDNS_UPDATE_FROM
experimental-api-key=$PDNS_API_KEY
experimental-dnsupdate=$PDNS_ALLOW_DDNS_UPDATE
experimental-json-interface=$PDNS_JSON_INTERFACE
gmysql-dbname=$PDNS_GMYSQL_DBNAME
gmysql-host=$PDNS_GMYSQL_HOST
gmysql-password=$PDNS_GMYSQL_PASSWORD
gmysql-user=$PDNS_GMYSQL_USER
launch=gmysql
recursor=$PDNS_RECURSOR_SERVER_IP
webserver-address=$PDNS_WEBSERVER_ADDRESS
webserver-password=$PDNS_WEBSERVER_PASSWORD
webserver-port=$PDNS_WEBSERVER_PORT
webserver=$PDNS_WEBSERVER
EOF

# Wait for DB to start
sleep 20

# Check if DB imported
if [[ ! -f /db_imported ]]; then
  mysql --host=$PDNS_GMYSQL_HOST --user=$PDNS_GMYSQL_USER \
  --password=$PDNS_GMYSQL_PASSWORD --database=$PDNS_GMYSQL_DBNAME < /pdns.sql && \
  touch /db_imported
fi

# Wait for DB and Recursor to start
sleep 10

if [ "$#" -gt 0 ]; then
  exec /usr/sbin/pdns_server "$@"
else
  exec /usr/sbin/pdns_server --daemon=no --guardian=no --control-console --loglevel=9
fi
