# HDP Install Checklist

* Get a list of all hostnames and IP addresses.

* Create a super user account (e.g., centos, do NOT use root account) and configure it to be able to password-less ssh to all other nodes from Ambari server node.

* Allow the super user account to run all commands without password on all nodes. E.g., on CentOS, Add the super user account to `wheel` groud. Allow it to run all commands without password. Run `sudo visudo`, then uncomment the below

```
usermod -a -G wheel centos

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

* Install local repo and confirm it work, try `yum repolist`. Make sure we have the following repos (HDP 2.6.x): RHEL OS, Epel, Ambari, HDP, HDP-Utils

* An easy test is to try to install pdsh (distributed shell – `yum install pdsh`) on ambari server node, included in HDP-Utils repo

* Check if java installed. JDK version 1.8.0_77 above required

* Check can we do passwordless ssh from Ambari node to all other nodes: you can use pdsh, and check for example time on all nodes:
`pdsh date`, this will also show is the time on all nodes in sync and is ntpd working (you can also try `ntpq -p` on all nodes)

* Using pdsh check all other OS settings. All these will be checked again by Ambari when we install the cluster, but it will be good to detect any misses early on. We will show how to change these settings below on RHEL/CentOS.
```
selinux disabled
swappines=1
iptables disabled
Transparent Huge Pages (THP) disabled
ulimit (nofile, nproc) about 64k
NTP enabled
```

* Disable SELinux
To disable the runtime SELinux.
```
setenforce 0
```

To ensure the SELinux is set appropriately on reboot, use the following command:
```
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
```

* Swappiness setting recommendation

Virtual Memory swapping can have a large impact on the performance of a Hadoop system. Because of the memory requirements of YARN containers and processes running on the nodes in a cluster, swapping process out of memory to disk can cause serious performance limitations. As such, the historical recommendations for setting the swappiness, or propensity to swap out a process, on a Hadoop system has been to disable swap altogether. With newer versions of the Linux kernel, Out Of Memory (OOM) situations can be more likely to indiscriminately kill important processes to reclaim valuable physical memory on the system with a swappiness of 0.

In order to prevent the system from swapping processes too frequently, but still allow for emergency swapping (instead of killing processes), the recommendation is now to set swappiness to 1 on Linux systems. This will still allow swapping, but with the least possible aggressiveness (for comparison, the default value for swappiness is 60).

To change the swappiness on a running machine, use the following command:
```
echo "1" > /proc/sys/vm/swappiness
```

To ensure the swappiness is set appropriately on reboot, use the following command:
```
echo "vm.swappiness=1" >> /etc/sysctl.conf
```

* Disable iptables
It is recommended to allow all traffics between the nodes in a HDP cluster.
```
service firewalld stop
```

* Disabled Transparent Huge Pages
It is recommended to disable THP on a HDP cluster.
```
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled
```

* Increase ulimit
The recommended maximum number of open file descriptors is 10000, or more.
```
ulimit -n 10000
```

During HDP installation, Ambari will generate ulimit configuration file for system users under `/etc/security/limits.d/` such as the below.
```
ls /etc/security/limits.d/

20-nproc.conf  hbase.conf  hive.conf       oozie.conf  yarn.conf
ams.conf       hdfs.conf   mapreduce.conf  storm.conf
```

* Enable NTP
The clocks of all the nodes in your cluster must be able to synchronize with each other.
```
yum install -y ntp
systemctl is-enabled ntpd
systemctl enable ntpd
systemctl start ntpd
```

# Local Storages
Make sure local storages (HDDs, SSDs) are correctly formated and mounted to the OS. XFS is recommended.

Here is an [example storage setup](https://github.com/uprush/hdemo/blob/master/mount-storages.sh).

# Advanced Kernel and Network Settings
Here is an [example of advanced kernel and network settings](https://github.com/uprush/hdemo/blob/master/setup-kernel.sh). Use it carefully and adjust to your environment.

