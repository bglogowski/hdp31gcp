# puppet.sh

yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y puppet-agent

/opt/puppetlabs/bin/puppet agent --test

