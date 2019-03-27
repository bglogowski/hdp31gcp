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

# puppet.sh

yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y puppet-agent

/opt/puppetlabs/bin/puppet agent --test

