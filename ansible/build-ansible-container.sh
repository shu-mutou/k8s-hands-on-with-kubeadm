#!/bin/bash

CD="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

docker build -t ansible .
docker network create ansible \
  -d=bridge \
  -o com.docker.network.bridge.enable_ip_masquerade=true \
  -o com.docker.network.driver.mtu=1500

GW="$(docker network inspect --format='{{(index .IPAM.Config 0).Gateway}}' ansible)"
echo "Set ${GW} into libvirt-hosts in stage file."

cd ${CD}
