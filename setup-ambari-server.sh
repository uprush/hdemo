#!/bin/bash

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

function install_ambari_server() {
  if [[ "$OS_FAMILY" == "REDHAT" ]]; then
    yum -y install ambari-server
  else
    apt-get -y install ambari-server
  fi
}

install_ambari_server

echo "Execute <ambari-server setup> on Ambari server"
