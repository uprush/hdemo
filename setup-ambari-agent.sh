#!/bin/bash

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

function install_ambari_agent() {
  echo "Installing Ambari Agent..."
  apt-get -y install ambari-agent
}

function configure_ambari_agent() {
  echo "Configuring Ambari Agent..."
  sed -i s/localhost/$AMBARI_SERVER/g /etc/ambari-agent/conf/ambari-agent.ini
  echo

  echo "Restarting Ambari Agent..."
  echo
  ambari-agent restart
}

install_ambari_agent
configure_ambari_agent

echo "Completed successfully: setup-ambari-agent"
