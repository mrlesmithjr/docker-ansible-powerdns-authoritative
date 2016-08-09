#!/bin/bash

# Configure powerdns
cat > /etc/powerdns/recursor.conf <<EOF
local-address=$PDNS_RECURSOR_LOCAL_ADDRESS
EOF

# sleep 20
#
# # Check if DB imported
# if [[ ! -f /db_imported ]]; then
#   mysql --host=$PDNS_GMYSQL_HOST --user=$PDNS_GMYSQL_USER \
#   --password=$PDNS_GMYSQL_PASSWORD --database=$PDNS_GMYSQL_DBNAME < /pdns.sql && \
#   touch /db_imported
# fi
if [ "$#" -gt 0 ]; then
  exec /usr/sbin/pdns_recursor "$@"
else
  exec /usr/sbin/pdns_recursor --daemon=no --loglevel=9
fi
