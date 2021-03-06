#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create zk1 \
        --zone=us-west1-a \
        --machine-type=n1-standard-1 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=zk1 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create zk2 \
        --zone=us-west1-b \
        --machine-type=n1-standard-1 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=zk2 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create zk3 \
        --zone=us-west1-c \
        --machine-type=n1-standard-1 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=zk3 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

gcloud compute \
        --project=${PROJECT} \
        instances create zk4 \
        --zone=us-west1-c \
        --machine-type=n1-standard-1 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=zk4 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

gcloud compute \
        --project=${PROJECT} \
        instances create zk5 \
        --zone=us-west1-c \
        --machine-type=n1-standard-1 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
        --boot-disk-device-name=zk5 \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

