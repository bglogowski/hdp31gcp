#!/bin/bash

/bin/rm  ambari-server-script.sh
for i in epel.sh pgdg.sh postgresql.sh ambari.sh ambari-server.sh
do
  cat stubs/${i} >> ambari-server-script.sh
done


/bin/rm  hadoop-node-script.sh
for i in epel.sh ambari.sh ambari-agent.sh
do
  cat stubs/${i} >> hadoop-node-script.sh
done
