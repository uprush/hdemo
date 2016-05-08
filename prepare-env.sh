#!/bin/bash
#
# Prepare HDP environment
#

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

function config_repo() {
  wget $HDP_REPO -O /etc/apt/sources.list.d/ambari.list
  apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
  apt-get update
}


function prepare() {
  # setup_open_jdk

  # install dependencies and utilities
  apt-get install -y chkconfig

  # install hadoop packages
  apt-get install -y openssl ntp

  # disable THP
  echo never > /sys/kernel/mm/transparent_hugepage/enabled

  # install Snappy and LZO
  # apt-get install -y libsnappy1 libsnappy-dev
  # ln -sf /usr/lib64/libsnappy.so /usr/lib/hadoop/lib/native/.
  # apt-get install -y liblzo2-2 liblzo2-dev hadoop-lzo
}

config_repo
prepare
