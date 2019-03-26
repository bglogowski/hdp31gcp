#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create ranger \
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
        --boot-disk-device-name=ranger \
	--metadata-from-file startup-script=scripts/ranger-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create kms \
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
        --boot-disk-device-name=kms \
	--metadata-from-file startup-script=scripts/kms-node-script.sh

