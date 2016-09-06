#!/bin/bash

AMBARI_VERSION="2.4.0.1"
AMBARI_SERVER="ip-10-0-0-178.ap-northeast-1.compute.internal"

OS_FAMILY="DEBIAN"
if [ -f /etc/redhat-release ]; then
  OS_FAMILY="REDHAT"
fi

## HDP repository
if [[ "$OS_FAMILY" == "REDHAT" ]]; then
  HDP_REPO="http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/$AMBARI_VERSION/ambari.repo"
else
  HDP_REPO="http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/$AMBARI_VERSION/ambari.list"
fi


if [[ "$OS_FAMILY" == "REDHAT" ]]; then
  SSH_USER="centos"
else
  SSH_USER="ubuntu"
fi

HDEMO_REMOTE_HOME=/home/$SSH_USER/hdemo


echo "==== Environment Variables ===="

echo "AMBARI_VERSION: $AMBARI_VERSION"
echo "AMBARI_SERVER: $AMBARI_SERVER"
echo "HDP_REPO: $HDP_REPO"
echo "OS_FAMILY: $OS_FAMILY"
echo "SSH_USER: $SSH_USER"
echo "HDEMO_REMOTE_HOME: $HDEMO_REMOTE_HOME"

echo "==== Environment Variables ===="
