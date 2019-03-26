#!/bin/bash

. common.sh

gcloud compute \
        --project=${PROJECT} \
        instances create ambari \
        --zone=us-west1-a \
        --machine-type=n1-standard-4 \
        --subnet=default \
        --network-tier=PREMIUM \
        --maintenance-policy=MIGRATE \
        --service-account=${SVC_ACCT} \
        ${SCOPES} \
        --tags=ambari \
        --image=${OS_IMAGE} \
        --image-project=${OS_PROJECT} \
        --boot-disk-size=${BOOT_DISK} \
        --boot-disk-type=pd-standard \
	--metadata-from-file startup-script=scripts/ambari-server-script.sh

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
        --boot-disk-device-name=hst \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh
 
gcloud compute \
        --project=${PROJECT} \
        instances create analyzer \
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
        --boot-disk-device-name=analyzer \
	--metadata-from-file startup-script=scripts/hadoop-node-script.sh

gcloud compute \
        --project=${PROJECT} \
        instances create metrics1 \
        --zone=us-west1-a \
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
        --zone=us-west1-a \
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

