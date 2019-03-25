# epel.sh

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# ambari.sh

yum install -y wget

wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.3.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

# ambari-agent.sh

yum install -y ambari-agent

sed -i -e"s/hostname=localhost/hostname=ambari/" /etc/ambari-agent/conf/ambari-agent.ini

service ambari-agent start

