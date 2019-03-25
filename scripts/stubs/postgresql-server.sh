# postgresql-server.sh

cat > /var/lib/pgsql/9.6/data/pg_hba.conf <<EOF
local   all   postgres                                                           peer
host    all   postgres                                   127.0.0.1/32            ident
host    all   postgres                                   ::1/128                 ident
local   all   ambari,mapred,hive,ranger,rangerkms                                md5
host    all   ambari,mapred,hive,ranger,rangerkms        0.0.0.0/0               md5
host    all   ambari,mapred,hive,ranger,rangerkms        ::/0                    md5
EOF

/bin/systemctl enable postgresql-9.6
/bin/systemctl start postgresql-9.6.service

for app in ambari mapred hive ranger rangerkms
do

  sudo -u postgres createuser $app
  sudo -u postgres createdb -O $app $app
  sudo -u postgres psql -c "ALTER USER $app PASSWORD '++++++++++++++';"

done

