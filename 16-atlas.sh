#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create atlas \
        --zone=us-west1-b \
        --machine-type=n1-standard-4 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=atlas \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
