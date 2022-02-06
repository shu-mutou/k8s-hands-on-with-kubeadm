Kubernetes Cluster Sandbox
==========================

Constructing Kubernetes Cluster with ansible and kubeadm.

### `./ansible/`

Build and run ansible container.
The following playbooks are designed with the assumption that you will be using this ansible container.
At first, build ansible container using `./ansible/build-ansible-container.sh`.

Ansible Playbooks
-----------------

### `./ansible-playbook-template/`

Boilerplate for ansible-playbook.

### `./libvirt/`

Manage VMs for kubernetes clusters using `libvirt`.

### `./k8s-cluster/`

Setup `kubeadm` into VMs created by `libvirt` playbook for `single`, `multi`settings.
And bootstrap VMs as kubernetes cluster.
