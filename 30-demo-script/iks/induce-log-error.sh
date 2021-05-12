#!/bin/bash

echo "scale-down started ..... $(date)"

source ./config.sh

# # ##### scale down
kubectl scale --replicas=0 deployment/ratings-v1 -n $NAMESAPCE_APP

# curl $START_ERROR_URL

echo "scale-down completed ..... $(date)"

