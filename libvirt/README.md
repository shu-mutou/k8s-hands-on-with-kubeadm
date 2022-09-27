Create VMs using libvirt
========================

This scripts create Ubuntu VMs from cloud image using libvirt.

## Reference

* https://youth2009.org/post/kvm-with-ubuntu-cloud-image/
* https://help.ubuntu.com/community/CloudInit
* https://cloudinit.readthedocs.io/en/latest/topics/examples.html#yaml-examples
* https://cloudinit.readthedocs.io/en/latest/topics/network-config-format-v2.html#examples

## Pre-requicites

### On libvirt host

```
sudo apt install qemu-kvm libvirt0 virtinst bridge-utils cloud-image-utils whois
```

### Create virtual network with libvirt

* Name: `staticnat`
* CIDR: `192.168.100.0/24`
* DHCP: Disabled
* Forwarding: NAT
* IP address for this bridge: `192.168.100.1`

> **Notice: This means the VMs, i.e. k8s nodes, that would be created with these scripts should have IP address in the above CIDR.**

## Cloud Init

Cloud init does not create swap as default.
Create cloud init CD image using `cloud-localds`

## VMs

To manage libvirt VMs, the role uses `virt` module.
To connect libvirt, the `libvirt_uri` variable should be set.
If VM is existing by name, role will not re-create the VM.
To define VM, use `define` command on `virt` module.
To start VM, use `start` command on `virt` module.

## How to use

Before run playbook, access your `libvirt_host` via ssh to add record for accessing from ansible container by attaching `.ssh/known_hosts`.

To create
```
STAGE=<stage1(default)|stage2> ./create_vms.sh
```
or run playbook with `-k` option for input ssh passphrase and `-K` option for `sudo`.
```
STEP=libvirt ./run-ansible.sh -i <stage> site.yaml -k -K
```

* `sites.yaml`: `libvirt-hosts`
  + `stage`: Environments to be managed
    - `stage1`: For machine 1
    - `stage2`: For machine 2
  + `cluster_type`: Kubernetes cluster type
    - `single`: For single master and workers
    - `minimum`: For multi tainted masters
    - `medium`: For multi masters and workers

Inventory file for bootstrapping k8s cluster with created VMs will be generated into this directory as `./dist/{{stage}}-{{cluster_type}}`.

## Start/Stop/Restart VMs

When you stop k8s cluster nodes, you need to run followings for tainted masters and workers to prevent rescheduling pods.

Befor stop:
```
kubectl drain --ignore-daemonsets <node>
```

Then run stop:
To stop:
```
STAGE=<stage1(default)|stage2> ./shutdown.sh
```
or
```
../ansible/ansible-playbook.sh -i <stage> <stop.yaml|restart.yaml>
```

After start k8s cluster nodes, you need to `uncordon` for tainted masters and workers.

To start:
```
STAGE=<stage1(default)|stage2> ./start.sh
```
or
```
../ansible/ansible-playbook.sh -i <stage> start.yaml
```

After start:
```
kubectl uncordon <node>
```
