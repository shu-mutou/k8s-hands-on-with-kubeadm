#!/bin/bash

STAGE=${STAGE:-"../libvirt/dist/stage1-minimum"}

CD="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PJ_ROOT_DIR="$( cd ${SCRIPT_DIR}/../ && pwd )"

# Run ansible-playbook in ansible container.
STEP="kubeadm" ../ansible/ansible-playbook.sh -i ${STAGE} bootstrap.yaml
