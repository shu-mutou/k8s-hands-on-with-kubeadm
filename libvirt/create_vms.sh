#!/bin/bash

STAGE=${STAGE:-"stage1"}

CD="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PJ_ROOT_DIR="$( cd ${SCRIPT_DIR}/../ && pwd )"

# Run ansible-playbook in ansible container.
STEP="libvirt" ../ansible/ansible-playbook.sh -i ${STAGE} site.yaml
