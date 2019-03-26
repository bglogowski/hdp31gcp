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

