# ambari-server.sh

yum install -y ambari-server
/sbin/ambari-server setup --silent
/sbin/ambari-server start

