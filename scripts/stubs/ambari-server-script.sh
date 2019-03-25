# epel.sh

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# pgdg.sh

yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm

# postgresql.sh

yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm

yum install -y postgresql96 postgresql96-libs postgresql96-server

# ambari.sh

yum install -y wget

wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.3.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

# ambari-server.sh

yum install -y ambari-server

