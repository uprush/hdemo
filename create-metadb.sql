-- for hive
CREATE USER hive WITH PASSWORD 'myPassword';
CREATE DATABASE hive;
GRANT ALL PRIVILEGES ON DATABASE hive to hive;

-- for oozie
CREATE USER oozie WITH PASSWORD 'myPassword';
CREATE DATABASE oozie;
GRANT ALL PRIVILEGES ON DATABASE oozie to oozie;

-- for ranger
CREATE USER rangeradmin WITH PASSWORD 'myPassword';
CREATE DATABASE ranger;
GRANT ALL PRIVILEGES ON DATABASE ranger to rangeradmin;

-- for Druid
CREATE USER druid WITH PASSWORD 'myPassword';
CREATE DATABASE druid;
GRANT ALL PRIVILEGES ON DATABASE druid to druid;

-- for Superset
CREATE USER superset WITH PASSWORD 'myPassword';
CREATE DATABASE superset;
GRANT ALL PRIVILEGES ON DATABASE superset to superset;

-- for ranger KMS
CREATE USER rangerkms WITH PASSWORD 'myPassword';
CREATE DATABASE rangerkms;
GRANT ALL PRIVILEGES ON DATABASE rangerkms to rangerkms;

