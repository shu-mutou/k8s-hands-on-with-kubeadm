#!/bin/bash

CD="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PJ_ROOT_DIR="$( cd ${SCRIPT_DIR}/../ && pwd )"
WORK_DIR="/ansible"
SSH_DIR=${SSH_DIR:-"$( cd ~/.ssh && pwd )"}

# Run shell in ansible container.
docker run \
  --network ansible \
  -v ${PJ_ROOT_DIR}:${WORK_DIR} \
  -v ${SSH_DIR}:/root/.ssh:ro \
  -e ANSIBLE_CONFIG=${WORK_DIR}/ansible/ansible.cfg \
  -it --entrypoint sh ansible

