#!/bin/bash
#
# Block device optimization for Hadoop use case
#

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

for DEVICE in {b..g};
do
  echo "Optimizing block device: $DEVICE"
  echo 512 > /sys/block/sd${DEVICE}/queue/nr_requests
  echo 256 > /sys/block/sd${DEVICE}/device/queue_depth
  /sbin/blockdev --setra 1024 /dev/sd${DEVICE}
done

echo "DONE"
