#!/bin/bash

H_ACCEEPT="Accept: application/json"
H_CONTENT="Content-Type: application/json"

EVENT_PASSWORD=
URL_EVENT_MGR=http://objectserver-route-xxxxxxxxx.appdomain.cloud/objectserver/restapi/alerts/status

# METRICS VM
METRICS_VM=scadmin@1.1.1.1

# Params
NAMESAPCE=aiops31
APPLICATION_GROUP_ID=1000
APPLICATION_ID=1000

### AI-Ops OCP env
OCP_TOKEN=""
OCP_SERVER="https://c111-e.us-south.containers.cloud.ibm.com:11111"


### IKS (Managed env)
IBMCLOUD_API_KEY=
IKS_CLUSTER_ID=c28l30id09dvqt32n3e0
NAMESAPCE_APP=bookinfo
APP_URL=http://2.2.2.2:31010/productpage?u=normal