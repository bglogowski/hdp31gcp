#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create metrics1 \
        --zone=us-west1-b \
        --machine-type=n1-standard-2 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=metrics1 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create metrics2 \
        --zone=us-west1-c \
        --machine-type=n1-standard-2 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=metrics2 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

