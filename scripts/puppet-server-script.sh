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

# puppet-server.sh

# Install the Puppet repo
yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

# Install and start the Puppet Master
yum install -y puppetserver

# Configure the Puppet Master to auto-sign certs
hostname -d > /etc/puppetlabs/puppet/autosign.conf
sed -i -e"s/^/*./" /etc/puppetlabs/puppet/autosign.conf
chmod 0644 /etc/puppetlabs/puppet/autosign.conf

# Enable and start Puppet Master service
/bin/systemctl enable puppetserver
/bin/systemctl start puppetserver.service

# Install Puppet modules
#/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib --version 5.2.0
#/opt/puppetlabs/bin/puppet module install puppetlabs-java --version 3.3.0
#/opt/puppetlabs/bin/puppet module install puppetlabs-concat --version 5.3.0
#/opt/puppetlabs/bin/puppet module install puppetlabs-puppet_agent --version 2.1.0
#/opt/puppetlabs/bin/puppet module install puppetlabs-augeas_core --version 1.0.4
#/opt/puppetlabs/bin/puppet module install puppetlabs-sshkeys_core --version 1.0.2
#/opt/puppetlabs/bin/puppet module install puppetlabs-host_core --version 1.0.2
#/opt/puppetlabs/bin/puppet module install puppetlabs-firewall --version 1.15.2
#/opt/puppetlabs/bin/puppet module install puppetlabs-ntp --version 7.4.0
#/opt/puppetlabs/bin/puppet module install puppet-yum --version 3.1.1
#/opt/puppetlabs/bin/puppet module install puppet-selinux --version 1.6.1
#/opt/puppetlabs/bin/puppet module install puppet-python --version 2.2.2
#/opt/puppetlabs/bin/puppet module install puppet-alternatives --version 3.0.0
#/opt/puppetlabs/bin/puppet module install puppet-logrotate --version 3.4.0
#/opt/puppetlabs/bin/puppet module install puppet-hiera --version 3.3.4
#/opt/puppetlabs/bin/puppet module install puppet-puppetserver --version 3.0.1
#/opt/puppetlabs/bin/puppet module install puppet-nrpe --version 3.0.0
#/opt/puppetlabs/bin/puppet module install dalen-puppetdbquery --version 3.0.1


# Install Foreman with defaults
yum -y install https://yum.theforeman.org/releases/1.21/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer
foreman-installer

# Stop Foreman
/bin/systemctl stop foreman.service

# Backup the Foreman database to import into PGDG database
cd /tmp
su postgres -c "pg_dump -Fc foreman > foreman.dump"

# Stop the PostgreSQL 9.2 service and disable it
/bin/systemctl stop postgresql.service
/bin/systemctl disable postgresql

# Install the PostgreSQL 9.6 PGDG repo for PuppetDB
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96 postgresql96-libs postgresql96-server

# Setup PostgreSQL 9.6
/usr/pgsql-9.6/bin/postgresql96-setup initdb

cat > /var/lib/pgsql/9.6/data/pg_hba.conf <<EOF
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             postgres                                peer
host    all             postgres        127.0.0.1/32            ident
host    all             postgres        ::1/128                 ident
local   all             puppetdb                                md5
host    all             puppetdb        127.0.0.1/32            md5
host    all             puppetdb        ::1/128                 md5
host    all             puppetdb        10.0.0.0/8              md5
local   all             foreman                                 md5
host    all             foreman         127.0.0.1/32            md5
host    all             foreman         ::1/128                 md5
host    all             foreman         10.0.0.0/8              md5
EOF

sed -i -e"s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.6/data/postgresql.conf
sed -i -e"s/#port = 5432/port = 5432/" /var/lib/pgsql/9.6/data/postgresql.conf

/bin/systemctl enable postgresql-9.6
/bin/systemctl start postgresql-9.6.service


# Configure PostgreSQL for PuppetDB
PUPPETDB_PASSWORD=`date +%s | sha256sum | base64 | head -c 32`

{ cat | sudo -u postgres psql; } << EOF
CREATE EXTENSION pg_trgm;
CREATE DATABASE puppetdb;
CREATE USER puppetdb WITH PASSWORD '${PUPPETDB_PASSWORD}';
GRANT ALL PRIVILEGES ON DATABASE puppetdb TO puppetdb;
\connect puppetdb;
CREATE SCHEMA puppetdb AUTHORIZATION puppetdb;
ALTER SCHEMA puppetdb OWNER TO puppetdb;
ALTER ROLE puppetdb SET search_path to 'puppetdb', 'public';
EOF

# Install PuppetDB
yum install -y puppetdb
/opt/puppetlabs/bin/puppetdb ssl-setup -f

cat > /etc/puppetlabs/puppetdb/conf.d/database.ini <<EOF
[database]
subname = //127.0.0.1:5432/puppetdb
username = puppetdb
password = ${PUPPETDB_PASSWORD}
gc-interval = 60
EOF

/bin/systemctl enable puppetdb
/bin/systemctl start puppetdb.service

/bin/systemctl restart puppetserver.service


FOREMAN_DB_PASSWORD=`grep password /etc/foreman/database.yml | cut -f2 -d\"`
cd /tmp
{ cat | sudo -u postgres psql; } << EOF
CREATE USER foreman WITH PASSWORD '${FOREMAN_DB_PASSWORD}';
EOF
su postgres -c "pg_restore -C -d postgres foreman.dump"

/bin/systemctl start foreman.service

yum remove -y postgresql postgresql-libs postgresql-server
/bin/rm -rf /var/lib/pgsql/data
ln -s /usr/pgsql-9.6/bin/* /usr/bin/


grep admin /var/log/messages | sed -e"s/^.*Initial credentials are //" > /root/.the_foreman


/opt/puppetlabs/bin/puppet agent --test

