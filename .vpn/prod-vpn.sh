#!/usr/bin/env bash

set -e

function clean_up {
  cat ./password | sudo -S pkill -f "acvc.*prod.conf" || true
}

export VPN_HOST="cvpn-endpoint-022d7eb676972a623.prod.clientvpn.us-east-1.amazonaws.com"
export VPN_CONF="prod.conf"

trap clean_up SIGTERM
clean_up

./vpn.sh

