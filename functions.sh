#!/bin/bash

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/conf/env.sh

function escape_path() {
  IN_PATH=$1
  if [[ "x$IN_PATH" == "x" ]]; then
    echo ""
  else
    echo "$IN_PATH" | sed -e 's/\//\\\//g' > /tmp/escaped
    cat /tmp/escaped
  fi
}

function setup_open_jdk() {
  apt-get install -y openjdk-7-jdk
  mkdir /usr/java
  ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/java/default
  rm /usr/bin/java
  ln -s /usr/java/default/bin/java /usr/bin/java

  export JAVA_HOME=/usr/java/default
  export PATH=$JAVA_HOME/bin:$PATH

  echo "Using Java:"
  java -version
}

