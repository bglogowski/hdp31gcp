#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create oozie \
        --zone=us-west1-a \
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
        --boot-disk-device-name=oozie \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
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
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create kms \
        --zone=us-west1-c \
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
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

gcloud compute \
        --project=${PROJECT} \
        instances create graphana \
        --zone=us-west1-a \
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
        --boot-disk-device-name=graphana \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create hst \
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
        --boot-disk-device-name=hst \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create analyzer \
        --zone=us-west1-c \
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
        --boot-disk-device-name=analyzer \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

