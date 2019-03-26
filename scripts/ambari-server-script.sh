# selinux.sh

sudo setenforce 0
sed -i -e"s/^SELINUX=.*$/SELINUX=disabled/" /etc/selinux/config

# firewalld.sh

/bin/systemctl stop firewalld.service
/bin/systemctl disable firewalld

# epel.sh

yum install -y wget
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum update -y

# pgdg.sh

yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm

# postgresql.sh

yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96 postgresql96-libs postgresql96-server

mkdir -p /opt/postgresql
chmod 0755 /opt/postgresql
wget -nv https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -O /opt/postgresql/postgresql-42.2.5.jar
chmod 0644 /opt/postgresql/postgresql-42.2.5.jar

# ambari.sh

wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.3.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

# ambari-server.sh

yum install -y ambari-server
/sbin/ambari-server setup \
	--jdbc-db=postgres \
	--jdbc-driver=/opt/postgresql/postgresql-42.2.5.jar
/sbin/ambari-server setup \
	--silent \
	--database=postgres \
	--databasehost=postgres \
	--databaseport=5432 \
	--databasename=ambari \
	--postgresschema=ambari \
	--databaseusername=ambari \
	--databasepassword=++++++++++++++
/sbin/ambari-server start

