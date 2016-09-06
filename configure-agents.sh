#!/bin/bash
#

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

CONF_CMD="sed -i s/localhost/$AMBARI_SERVER/g /etc/ambari-agent/conf/ambari-agent.ini"
echo "Configuring Ambari Server..."
echo
$SCRIPT_DIR/exec -c "$CONF_CMD" -t all

echo "Restarting Ambari Agent..."
echo
RESTART_CMD="ambari-agent restart"
$SCRIPT_DIR/exec -c "$RESTART_CMD" -t all
