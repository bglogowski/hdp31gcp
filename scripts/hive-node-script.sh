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

# ambari.sh

wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.3.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

# ambari-agent.sh

yum install -y ambari-agent
sed -i -e"s/hostname=localhost/hostname=ambari/" /etc/ambari-agent/conf/ambari-agent.ini
service ambari-agent start

# mysql-server.sh

yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm

yum install -y yum-utils
yum-config-manager --disable mysql80-community
yum-config-manager --enable mysql57-community

# Replace MariaDB with MySQL
yum update -y

yum install -y mysql-community-client mysql-community-server
/bin/systemctl enable mysqld
/bin/systemctl start mysqld.service

