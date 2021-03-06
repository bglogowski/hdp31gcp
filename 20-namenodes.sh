#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create nn1 \
        --zone=us-west1-b \
        --machine-type=n1-highmem-2 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=nn1 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create nn2 \
        --zone=us-west1-c \
        --machine-type=n1-highmem-2 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=nn2 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

