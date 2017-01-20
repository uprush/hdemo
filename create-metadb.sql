# for hive
CREATE USER hive WITH PASSWORD 'myPassword';
CREATE DATABASE hive;
GRANT ALL PRIVILEGES ON DATABASE hive to hive;

# for oozie
CREATE USER oozie WITH PASSWORD 'myPassword';
CREATE DATABASE oozie;
GRANT ALL PRIVILEGES ON DATABASE oozie to oozie;

# for ranger
CREATE USER rangeradmin WITH PASSWORD 'myPassword';
CREATE DATABASE ranger;
GRANT ALL PRIVILEGES ON DATABASE ranger to rangeradmin;
