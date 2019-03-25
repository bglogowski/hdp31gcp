# ambari-agent.sh

yum install -y ambari-agent

sed -i -e"s/hostname=localhost/hostname=ambari/" /etc/ambari-agent/conf/ambari-agent.ini

service ambari-agent start

