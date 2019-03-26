#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        firewall-rules create ambari \
        --direction=INGRESS \
        --priority=1000 \
        --network=default \
        --action=ALLOW \
        --rules=tcp:8080

gcloud compute \
        --project=${PROJECT} \
        firewall-rules create foreman \
        --direction=INGRESS \
        --priority=1000 \
        --network=default \
        --action=ALLOW \
        --rules=tcp:8443

