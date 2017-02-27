# HDP Install Checklist

* Get a list of all hostnames and IP addresses.

* Create a super user account (e.g., centos, do NOT use root account) and configure it to be able to password-less ssh to all other nodes from Ambari server node.

* Allow the super user account to run all commands without password on all nodes. E.g., on CentOS, Add the super user account to `wheel` groud. Allow it to run all commands without password. Run `sudo visudo`, then uncomment the below

```
usermod -a -G centos wheel

visudo

## Same thing without a password
# %wheel        ALL=(ALL)       NOPASSWD: ALL
```

* Enable "ssh hostname sudo <cmd>" on all nodes as required by pdsh.
```
$ visudo

#
# Disable "ssh hostname sudo <cmd>", because it will show the password in clear.
#         You have to run "ssh -t hostname sudo <cmd>".
#
#Defaults    requiretty   <-- comment out this

```

* Check FQDN: `hostname` and `hostname -f`. Desired output example:
```
$ hostname
pm2500                        # short hostname
$ hostname -f
pm2500.example.com            # FQDN
```

* Install local repo and confirm it work, try `yum repolist`. Make sure we have the following repos (HDP 2.5.3): RHEL OS, Epel, Ambari, HDP, HDP-Utils

* An easy test is to try to install pdsh (distributed shell – `yum install pdsh`) on ambari server node, included in HDP-Utils repo

* Check if java installed. JDK version 1.8.0_77 above required

* Check can we do passwordless ssh from Ambari node to all other nodes: you can use pdsh, and check for example time on all nodes:
`pdsh date`, this will also show is the time on all nodes in sync and is ntpd working (you can also try `ntpq -p` on all nodes)

* Using pdsh check all other OS settings. All these will be checked again by Ambari when we install the cluster, but it will be good to detect any misses early on.
```
selinux disabled
swappines=0
iptables disabled
THP disabled
ulimit (nofile, nproc) about 64k
```
