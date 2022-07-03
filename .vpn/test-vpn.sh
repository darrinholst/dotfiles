#!/usr/bin/env bash

set -e

function clean_up {
  cat ./password | sudo -S pkill -f "acvc.*test.conf" || true
}

export VPN_HOST="cvpn-endpoint-01353e4930b3f0ca1.prod.clientvpn.us-east-1.amazonaws.com"
export VPN_CONF="test.conf"

trap clean_up SIGTERM
clean_up

./vpn.sh

