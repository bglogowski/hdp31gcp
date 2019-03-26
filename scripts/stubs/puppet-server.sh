# puppet-server.sh

yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

yum install -y puppetserver
/bin/systemctl enable puppetserver
/bin/systemctl start puppetserver.service

/opt/puppetlabs/bin/puppet agent --test


/usr/pgsql-9.6/bin/postgresql96-setup initdb

cat > /var/lib/pgsql/9.6/data/pg_hba.conf <<EOF
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             postgres                                peer
host    all             postgres        127.0.0.1/32            ident
host    all             postgres        ::1/128                 ident
host    all             puppetdb        127.0.0.1/32            md5
host    all             puppetdb        ::1/128                 md5
host    all             puppetdb        10.0.0.0/8              md5
host    all             foreman         127.0.0.1/32            md5
host    all             foreman         ::1/128                 md5
host    all             foreman         10.0.0.0/8              md5
EOF
EOF

sed -i -e"s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.6/data/postgresql.conf
sed -i -e"s/#port = 5432/port = 5432/" /var/lib/pgsql/9.6/data/postgresql.conf

/bin/systemctl enable postgresql-9.6
/bin/systemctl start postgresql-9.6.service

{ cat | sudo -u postgres psql; } << EOF
CREATE DATABASE puppetdb;
CREATE USER puppetdb WITH PASSWORD '++++++++++++++';
GRANT ALL PRIVILEGES ON DATABASE puppetdb TO puppetdb;
\connect puppetdb;
CREATE SCHEMA puppetdb AUTHORIZATION puppetdb;
ALTER SCHEMA puppetdb OWNER TO puppetdb;
ALTER ROLE puppetdb SET search_path to 'puppetdb', 'public';
EOF

{ cat | sudo -u postgres psql; } << EOF
CREATE DATABASE foreman;
CREATE USER foreman WITH PASSWORD '++++++++++++++';
GRANT ALL PRIVILEGES ON DATABASE foreman TO foreman;
\connect foreman;
CREATE SCHEMA foreman AUTHORIZATION foreman;
ALTER SCHEMA foreman OWNER TO foreman;
ALTER ROLE foreman SET search_path to 'foreman', 'public';
EOF



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

