# puppet-server.sh

yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

yum install -y puppetserver
/bin/systemctl enable puppetserver
/bin/systemctl start puppetserver.service

/opt/puppetlabs/bin/puppet agent --test

/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib --version 5.2.0
/opt/puppetlabs/bin/puppet module install puppetlabs-java --version 3.3.0
/opt/puppetlabs/bin/puppet module install puppetlabs-concat --version 5.3.0
/opt/puppetlabs/bin/puppet module install puppetlabs-puppet_agent --version 2.1.0
/opt/puppetlabs/bin/puppet module install puppetlabs-augeas_core --version 1.0.4
/opt/puppetlabs/bin/puppet module install puppetlabs-sshkeys_core --version 1.0.2
/opt/puppetlabs/bin/puppet module install puppetlabs-host_core --version 1.0.2

yum install -y puppetdb
/opt/puppetlabs/bin/puppetdb ssl-setup -f

cat > /etc/puppetlabs/puppetdb/conf.d/database.ini <<EOF
[database]
subname = //127.0.0.1:5432/puppetdb
username = puppetdb
password = ++++++++++++++
gc-interval = 60
EOF

/bin/systemctl enable puppetdb
/bin/systemctl start puppetdb.service

/bin/systemctl restart puppetserver.service
/opt/puppetlabs/bin/puppet agent --test

yum -y install https://yum.theforeman.org/releases/1.21/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer

