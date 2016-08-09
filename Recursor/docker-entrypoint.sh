#!/bin/bash

# Configure powerdns
cat > /etc/powerdns/recursor.conf <<EOF
local-address=$PDNS_RECURSOR_LOCAL_ADDRESS
EOF

if [ "$#" -gt 0 ]; then
  exec /usr/sbin/pdns_recursor "$@"
else
  exec /usr/sbin/pdns_recursor --daemon=no --loglevel=9
fi
