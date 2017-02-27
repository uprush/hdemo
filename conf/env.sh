#!/bin/bash

AMBARI_VERSION="2.4.2.0"
AMBARI_SERVER="node1.example.com"
MASTER_PWD="changeME"

OS_FAMILY="REDHAT"
#OS_FAMILY="DEBIAN"
#if [ -f /etc/redhat-release ]; then
#  OS_FAMILY="REDHAT"
#fi

## HDP repository
if [[ "$OS_FAMILY" == "REDHAT" ]]; then
  HDP_REPO="http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/$AMBARI_VERSION/ambari.repo"
else
  HDP_REPO="http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/$AMBARI_VERSION/ambari.list"
fi


if [[ "$OS_FAMILY" == "REDHAT" ]]; then
  #SSH_USER="ec2-user"
  SSH_USER="centos"
else
  SSH_USER="ubuntu"
fi

SSH_USER="centos"
HD_SSH_PORT="22"
HD_SSH_KEY="~/.ssh/id_rsa"

HDEMO_REMOTE_HOME=/home/$SSH_USER/hdemo


echo "==== Environment Variables ===="

echo "AMBARI_VERSION: $AMBARI_VERSION"
echo "AMBARI_SERVER: $AMBARI_SERVER"
echo "HDP_REPO: $HDP_REPO"
echo "OS_FAMILY: $OS_FAMILY"
echo "SSH_USER: $SSH_USER"
echo "SSH_PORT: $HD_SSH_PORT"
echo "SSH_KEY: $HD_SSH_KEY"
echo "HDEMO_REMOTE_HOME: $HDEMO_REMOTE_HOME"

echo "==== Environment Variables ===="
