# ambari-server.sh

yum install -y ambari-server
/sbin/ambari-server setup \
	--jdbc-db=postgres \
	--jdbc-driver=/opt/postgresql/postgresql-42.2.5.jar \
/sbin/ambari-server setup \
	--silent \
	--database=postgres \
	--databasehost=postgres \
	--databaseport=5432 \
	--databasename=ambaridb \
	--postgresschema=ambarischema \
	--databaseusername=ambari \
	--databasepassword=++++++++++++++
/sbin/ambari-server start

