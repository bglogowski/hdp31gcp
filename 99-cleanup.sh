#!/bin/bash

. common.sh

gcloud compute \
	instances remove-metadata ambari \
	--zone=us-west1-a \
	--keys=startup-script
