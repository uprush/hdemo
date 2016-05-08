#!/bin/bash

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

function install_ambari_server() {
  apt-get -y install ambari-server
}

install_ambari_server

echo "Execute <ambari-server setup> on Ambari server"
