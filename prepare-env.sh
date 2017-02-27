#!/bin/bash
#
# Prepare HDP environment
#

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

function config_repo() {
  if [[ "$OS_FAMILY" == "REDHAT" ]]; then
    wget -nv $HDP_REPO -O /etc/yum.repos.d/ambari.repo
  else
    wget $HDP_REPO -O /etc/apt/sources.list.d/ambari.list
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
    apt-get update
  fi
}

function prepare() {

  if [[ "$OS_FAMILY" == "REDHAT" ]]; then
    yum -y install wget
    yum -y install ntp
    chkconfig ntpd on
    service ntpd start
#    chkconfig iptables off
#    service iptables stop
    setenforce 0
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    echo never > /sys/kernel/mm/transparent_hugepage/defrag
    echo never > /sys/kernel/mm/transparent_hugepage/enabled

  else
    # setup_open_jdk

    # install dependencies and utilities
    apt-get install -y chkconfig

    # install hadoop packages
    apt-get install -y openssl
    apt-get install -y ntp

    # disable THP
    echo never > /sys/kernel/mm/transparent_hugepage/enabled

    # install Snappy and LZO
    # apt-get install -y libsnappy1 libsnappy-dev
    # ln -sf /usr/lib64/libsnappy.so /usr/lib/hadoop/lib/native/.
    # apt-get install -y liblzo2-2 liblzo2-dev hadoop-lzo
  fi

}

prepare
config_repo

