# ambari-server.sh

# Download the PostgreSQL Java driver
mkdir -p /opt/postgresql-42.2.5
chmod 0755 /opt/postgresql-42.2.5
wget -nv https://jdbc.postgresql.org/download/postgresql-42.2.5.jar \
	-O /opt/postgresql-42.2.5/postgresql-42.2.5.jar
chmod 0644 /opt/postgresql-42.2.5/postgresql-42.2.5.jar


# Download the MySQL Java driver
wget -nv https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.15.tar.gz \
	-O /opt/mysql-connector-java-8.0.15.tar.gz
cd /opt
tar xvf mysql-connector-java-8.0.15.tar.gz
/bin/rm -f mysql-connector-java-8.0.15.tar.gz
cd -

# Install Ambari Server
yum install -y ambari-server

# Provide Ambari with the MySQL Java driver
/sbin/ambari-server setup \
	--jdbc-db=mysql \
	--jdbc-driver=/opt/mysql-connector-java-8.0.15/mysql-connector-java-8.0.15.jar

# Provide Ambari with the PostgreSQL Java driver
/sbin/ambari-server setup \
	--jdbc-db=postgres \
	--jdbc-driver=/opt/postgresql-42.2.5/postgresql-42.2.5.jar

# Use external PostgreSQL server
#/sbin/ambari-server setup \
#	--silent \
#	--database=postgres \
#	--databasehost=postgres \
#	--databaseport=5432 \
#	--databasename=ambari \
#	--postgresschema=ambari \
#	--databaseusername=ambari \
#	--databasepassword=++++++++++++++

/sbin/ambari-server setup \
	--silent

/sbin/ambari-server start

