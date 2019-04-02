#!/bin/bash

#./01-firewall.sh
#./10-postgresql.sh &
./05-puppet.sh
sleep 720
./12-ambari.sh &
./20-namenodes.sh &
./22-resourcemanagers.sh &
./24-hbasemasters.sh &
./30-zookeepers.sh &
./40-kafkabrokers.sh &
./50-misc.sh &
./80-datanodes.sh
./99-cleanup.sh 

