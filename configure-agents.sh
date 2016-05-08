#!/bin/bash
#

SCRIPT_DIR=`dirname $0`
SCRIPT_DIR=`cd $SCRIPT_DIR; pwd`

AMBARI_SERVER='ip-10-0-0-17.ap-northeast-1.compute.internal'

CONF_CMD="sed -i s/localhost/$AMBARI_SERVER/g /etc/ambari-agent/conf/ambari-agent.ini"
echo "Configuring Ambari Server..."
echo
$SCRIPT_DIR/exec -c "$CONF_CMD" -t all

echo "Restarting Ambari Agent..."
echo
RESTART_CMD="ambari-agent restart"
$SCRIPT_DIR/exec -c "$RESTART_CMD" -t all
