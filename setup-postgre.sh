#!/bin/bash
#
# Set up PostgreSql for Hive, Ranger and other meta database.
# Run this script on Ambari Server.
#

DEMO_HOME=`dirname $0`
DEMO_HOME=`cd $DEMO_HOME; pwd`

source $DEMO_HOME/functions.sh

# backup config
PG_CONF=/etc/postgresql/9.3/main/pg_hba.conf
if [[ "$OS_FAMILY" == "REDHAT" ]]; then
  PG_CONF=/var/lib/pgsql/data/pg_hba.conf
fi

cp ${PG_CONF} ${PG_CONF}.backup

# create DB and user for Hive, Ranger and Oozie
sed 's/myPassword/${MASTER_PWD}/g' $DEMO_HOME/create-metadb.sql > /tmp/hdemo-create-metadb.sql
su -u postgres psql -a -f /tmp/hdemo-create-metadb.sql
rm -f /tmp/hdemo-create-metadb.sql

echo 'host  ranger   rangeradmin 0.0.0.0/0  md5' >> ${PG_CONF}
echo 'host  hive   hive 0.0.0.0/0  md5' >> ${PG_CONF}
echo 'host  oozie   oozie 0.0.0.0/0  md5' >> ${PG_CONF}


# allow postgres user to connect using password
su -u postgres psql -c "alter user postgres password '${MASTER_PWD}';"

sed -i 's/host\s*all\s*postgres\s*127\.0\.0\.1\/32\s*ident/host    all   postgres             127.0.0.1\/32            md5/' /var/lib/pgsql/data/pg_hba.conf
sed -i 's/host\s*all\s*postgres\s*::1\/128\s*ident/host    all   postgres             ::1\/128                 md5/' /var/lib/pgsql/data/pg_hba.conf
service postgresql reload
