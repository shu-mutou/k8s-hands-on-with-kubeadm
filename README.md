Kubernetes Cluster Sandbox
==========================

Constructing Kubernetes Cluster with ansible and kubeadm.

### `./ansible/`

Build and run ansible container.
The following playbooks are designed with the assumption that you will be using this ansible container.
At first, build ansible container using `./ansible/build-ansible-container.sh`.
Set up sshd into your host. Ansible in this container accesses your host to control libvirt, etc.

Ansible Playbooks
-----------------

### `./ansible-playbook-template/`

Boilerplate for ansible-playbook.

### `./libvirt/`

Manage VMs for kubernetes clusters using `libvirt`.

To create VMs, run `cd ./libvirt && ./create_vms.sh`.
This creates VMs with reference to `./libvirt/stage1`.
if you want to use another flavor, copy `./libvirt/stage1`, edit it and set env `STAGE=<customized stage file>` before running `./libvirt/create_vms.sh`.
This script will requires `SSH password:` for sshd on your host.
Also, `./libvirt/dist/<stage name>-<cluster_type>` file will be created for bootstrapping kubernetes cluster.

The created VMs will be running. To stop the VMs, run `cd ./libvirt && ./shutdown.sh`.
If you use customized stage file, set env `STAGE=<customized stage file>` before.

To start the VMs again, run 'cd ./libvirt && ./start.sh'. You can also your stage file with env `STAGE`.

### `./kubeadm/`

To setup components for kubernetes cluster into VMs created by `libvirt` playbook for `single` and `multi` settings, run `cd ./kubeadm && ./install.sh`.
To specify your flavored VMs, set `./libvirt/dist/<stage name>-<cluster_type>` into evn `STAGE`.

To bootstrap kubernetes cluster, run `cd ./kubeadm && ./bootstrap.sh`.
Also, set `./libvirt/dist/<stage name>-<cluster_type>` for your flavored VMs.



