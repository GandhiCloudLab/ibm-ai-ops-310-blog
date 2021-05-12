#!/bin/bash

echo "process started ..... $(date)"

oc extract secret/strimzi-cluster-cluster-ca-cert --keys=ca.crt --to=- > ca.crt
export SASL_PASSWORD=$(oc get secret token --template={{.data.password}} | base64 --decode)
export SEC="-X security.protocol=SSL -X ssl.ca.location=ca.crt -X sasl.mechanisms=SCRAM-SHA-512 -X sasl.username=token -X sasl.password=$SASL_PASSWORD"
export BROKER=$(oc get routes strimzi-cluster-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}'):443

kafkacat $SEC -b $BROKER -P -t alerts-noi-1000-1000 -l ./02-noi-alerts.json

echo "process completed ..... $(date)"
