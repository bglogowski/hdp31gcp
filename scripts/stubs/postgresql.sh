# postgresql.sh

yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96 postgresql96-libs postgresql96-server

mkdir -p /opt/postgresql
chmod 0755 /opt/postgresql
wget -nv https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -O /opt/postgresql/postgresql-42.2.5.jar
chmod 0644 /opt/postgresql/postgresql-42.2.5.jar

