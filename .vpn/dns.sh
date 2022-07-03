#!/usr/bin/env bash

set -e

test_dns_server=10.2.0.2

if host -W3 -t A redis.advancedagtest.com ${test_dns_server} > /dev/null
then
  echo "Connected to ${test_dns_server}"
else
  echo "No connection to ${test_dns_server}"
  exit 0
fi

function get_ip {
  hostname="${1}"
  query_type="A"
  echo "$(host -t A ${1} ${test_dns_server} | awk '/has.*address/ {print $NF; exit}')"
}

cat >hosts <<EOF
127.0.0.1 localhost
127.0.0.1 terraframing-local.advancedagrilytics.com
127.0.0.1 local.farmgate.ag
127.0.0.1 qa-portal.farmgate.localhost
10.2.9.45 cloud.dev

$(get_ip redis.advancedagtest.com) redis.advancedagtest.com
$(get_ip postgres.advancedagtest.com) postgres.advancedagtest.com
$(get_ip mssql.advancedagtest.com) mssql.advancedagtest.com
$(get_ip farmgate-mysql.advancedagtest.com) farmgate-mysql.advancedagtest.com
$(get_ip grafana.advancedagrilytics.com) grafana.advancedagrilytics.com
$(get_ip sonar.advancedagrilytics.com) sonar.advancedagrilytics.com

172.31.148.55 redis.advancedag.com
172.31.146.228 postgres.advancedag.com
172.31.153.19 mssql.advancedag.com
172.31.17.158 farmgate-mysql.advancedag.com
172.31.137.82 ds.bayes.advancedag.com
EOF

cat hosts
cat ./password | sudo -S mv -f hosts /etc/hosts
