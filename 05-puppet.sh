#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create puppet \
        --zone=us-west1-a \
        --machine-type=n1-standard-4 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
	--tags=https-server \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
	--boot-disk-device-name=puppet \
	--metadata-from-file startup-script=scripts/puppet-server-script.sh

