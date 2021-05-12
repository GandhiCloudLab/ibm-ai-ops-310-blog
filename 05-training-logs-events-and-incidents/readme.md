# Training Logs, Events and Incidents

This article explains about how to do Training for the following in Watson AIOps.

- Log Anomaly detection
- Event Grouping
- Similar Incidents

## 1. Training - Log Amomaly Detection

This section explains about how to do Training of Log Amomaly Detection in Watson AIOps.

### Application

Here is the application page looks like.

And assume that app is accessible via link http://1.1.1.1:31600/productpage?u=normal

<img src="images/1-1-app.png">

### Generate Load

The below script can be used for generating load.

Run this script and Generate load.

```bash
#!/bin/bash

while (true)
do
    ab -n 100 -c 5 http://1.1.1.1:31600/productpage?u=normal
done

```

### Load Live logs for Training

Enable the live logs for the training.

<img src="images/1-2-humio-on-1.png">
<img src="images/1-2-humio-on-2.png">
<img src="images/1-2-humio-on-3.png">
<img src="images/1-2-humio-on-4.png">

Keep in this state for 10 minutes.

### Stop Live logs

After 10 minutes, live logs can be disbled.

<img src="images/1-3-humio-off-1.png">
<img src="images/1-3-humio-off-2.png">
<img src="images/1-3-humio-off-3.png">

### Stop Load

Click on Ctrl+C to stop load script.

### Start Training

<img src="images/1-4-train-1.png">
<img src="images/1-4-train-2.png">
<img src="images/1-4-train-3.png">

Training is started.

<img src="images/1-4-train-4.png">

If you have this `Needs improvement` status then you need to load some more logs.

Need around 10K lines logs for each component/micro service of the app.

<img src="images/1-4-train-5.png">

Now the trianing status is `Good` and `Deployed`.

<img src="images/1-4-train-6.png">

The trained version is `v8`.

<img src="images/1-4-train-7.png">


## 2. Training - Event Grouping

This section explains about how to do Training of Event Grouping in Watson AIOps.

### Preparation

#### Sample Events Files for Training

The sample events data file is available here [02-noi-alerts.json](./files/02-noi-alerts.json).

#### Pushing events for Training

The script to push events into kafka topic `alerts-noi-1000-1000` for training is available here [01-post-training-events.sh](./files/01-post-training-events.sh).

```bash
oc extract secret/strimzi-cluster-cluster-ca-cert --keys=ca.crt --to=- > ca.crt
export SASL_PASSWORD=$(oc get secret token --template={{.data.password}} | base64 --decode)
export SEC="-X security.protocol=SSL -X ssl.ca.location=ca.crt -X sasl.mechanisms=SCRAM-SHA-512 -X sasl.username=token -X sasl.password=$SASL_PASSWORD"
export BROKER=$(oc get routes strimzi-cluster-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}'):443

kafkacat $SEC -b $BROKER -P -t alerts-noi-1000-1000 -l ./02-noi-alerts.json
```

To know more about how to access kafka topics refer here [800-accessing-kafka-topics](../800-accessing-kafka-topics)

### Enable Data flow for Training

<img src="images/2-1-kafka-on-1.png">
<img src="images/2-1-kafka-on-2.png">
<img src="images/2-1-kafka-on-3.png">
<img src="images/2-1-kafka-on-4.png">

### Push training events to kafka topic

Run the below command to push training events to kafka topic.

```bash
sh ./files/01-post-training-events.sh
```
### Disable Data flow

<img src="images/2-2-kafka-off-1.png">
<img src="images/2-2-kafka-off-2.png">
<img src="images/2-2-kafka-off-3.png">


### Start Training

<img src="images/2-3-Training-1.png">
<img src="images/2-3-Training-2.png">
<img src="images/2-3-Training-3.png">
<img src="images/2-3-Training-4.png">
<img src="images/2-3-Training-5.png">
<img src="images/2-3-Training-6.png">
<img src="images/2-3-Training-7.png">

## 3. Training - Similar Incidents

This section explains about how to do Training of Similar Incidents in Watson AIOps.

The article is based on the the following

- RedHat OpenShift 4.6 on IBM Cloud (ROKS)
- Watson AI-Ops 3.1.0

### Preparation

#### Sample Incidents  for Training

Atleast 5 incidents should have been created in service-now, resolved with proper resolve comments and closed.

Here are the sample incidents from service now.

<img src="images/3-service-now.png">

### Enable Data flow for Training

Make sure the following

- Data flow is on
- Historical data for Initial AI-Training
- Start Date should be past date 
- End Date could be current date 

<img src="images/3-dataflow-1.png">
<img src="images/3-dataflow-2.png">
<img src="images/3-dataflow-3.png">
<img src="images/3-dataflow-4.png">
<img src="images/3-dataflow-5.png">

### Start Training

Start the training

<img src="images/3-image-1.png">
<img src="images/3-image-2.png">
<img src="images/3-image-3.png">
<img src="images/3-image-4.png">
