# postgresql-server.sh

/usr/pgsql-9.6/bin/postgresql96-setup initdb

cat > /var/lib/pgsql/9.6/data/pg_hba.conf <<EOF
local   all   postgres                                                           peer
host    all   postgres                                         127.0.0.1/32      ident
host    all   postgres                                         ::1/128           ident
local   all   ambari,mapred,oozie,hive,ranger,rangerkms                          md5
host    all   ambari,mapred,oozie,hive,ranger,rangerkms        0.0.0.0/0         md5
host    all   ambari,mapred,oozie,hive,ranger,rangerkms        ::/0              md5
EOF

sed -i -e"s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.6/data/postgresql.conf
sed -i -e"s/#port = 5432/port = 5432/" /var/lib/pgsql/9.6/data/postgresql.conf

/bin/systemctl enable postgresql-9.6
/bin/systemctl start postgresql-9.6.service

for app in ambari mapred oozie hive ranger rangerkms
do

  sudo -u postgres createuser $app
  sudo -u postgres createdb -O $app $app
  sudo -u postgres psql -c "ALTER USER $app PASSWORD '++++++++++++++';"

done

