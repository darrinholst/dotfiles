#!/usr/bin/env bash

set -e

VPN_BIN="./acvc-openvpn"
VPN_PORT=443
VPN_PROTO=udp

wait_file() {
  local file="$1"; shift
  local wait_seconds="${1:-10}"; shift # 10 seconds as default timeout
  until test $((wait_seconds--)) -eq 0 -o -f "$file" ; do sleep 1; done
  ((++wait_seconds))
}

# create random hostname prefix for the vpn gw
prefix=$(openssl rand -hex 12)

# cleanup
rm -f saml-response.txt

# resolve manually hostname to IP, as we have to keep persistent ip address
host=$(dig a +short "${prefix}.${VPN_HOST}"|head -n1)

echo "Getting SAML redirect URL from $host"

# Have openvpn connect with user N/A and Password ACS:35001. This will fail,
# And the error payload will contain the SAML redirect URL
initial_response=$("${VPN_BIN}" \
  --config "${VPN_CONF}" \
  --verb 3 \
  --proto "$VPN_PROTO" \
  --remote "${host}" "$VPN_PORT" \
  --auth-retry none \
  --auth-user-pass <( printf "%s\n%s\n" "N/A" "ACS::35001" ) \
    2>&1 | grep AUTH_FAILED,CRV1)

redirect_url=$(echo "$initial_response" | grep -Eo 'https://.+')
vpn_sid=$(echo "$initial_response" | awk -F : '{print $7}')

echo "Opening a browser to perform SAML signin"
open "$redirect_url"

wait_file "saml-response.txt" 30 || {
  echo "SAML Authentication time out"
  exit 1
}

echo "Got the SAML token, connecting to the VPN..."

cat ./password | sudo -S bash -c "$VPN_BIN \
    --config "${VPN_CONF}" \
    --verb 3 \
    --proto \"$VPN_PROTO\" \
    --remote \"${host}\" \"$VPN_PORT\" \
    --script-security 2 \
    --route-up '/usr/bin/env rm saml-response.txt' \
    --auth-retry none \
    --auth-user-pass <( printf \"%s\n%s\n\" \"N/A\" \"CRV1::${vpn_sid}::$(cat saml-response.txt)\" )"
    "$@"

# Need the 🔨 since we needed to start it with sudo
cat ./password | sudo -S kill $BASHPID