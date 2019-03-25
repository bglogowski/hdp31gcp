# ambari-server.sh

yum install -y ambari-server
/sbin/ambari-server setup --silent --jdbc-db=postgres --jdbc-driver=/opt/postgresql/postgresql-42.2.5.jar
/sbin/ambari-server start

