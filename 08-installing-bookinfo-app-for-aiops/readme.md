# Installing BookInfo app for AIOps

The article explains about the following for Watson AIOps. 

- Installing BookInfo app
- Generating Load on BookInfo App
- Configuring FluentBit to push logs of BookInfo from cluster to Humio

The article is based on the the following

- IKS (IBM Kubernetes Service)
- Watson AI-Ops 3.1.0


## 1. Install BookInfo app in Kubernetes or Openshift

This section explains about how to install BookInfo app in Kubernetes

### 1. Bookinfo app Download

1. The bookinfo app is downloaded from the link https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo.yaml

2. The images refered in the yaml is modified.

3. The `productpage` service is exposed as NodePort and value is `31010`.

4. The above modified file is available  in [./files/bookinfo.yaml](./files/bookinfo.yaml)

### 2. Create Namesapce

Create a Namespace called `bookinfo`

```
kubectl create ns bookinfo
```

### 3. Deploy Bookinfo

 Apply the yaml to install the book info app.

  ```
  kubectl apply -f ./files/bookinfo.yaml
  ```

### 4. Get EXTERNAL-IP

Get the EXTERNAL-IP to access the application

  ```
  $ kubectl get nodes -o wide

  NAME          STATUS     ROLES           AGE    VERSION           INTERNAL-IP   EXTERNAL-IP    OS-IMAGE   KERNEL-VERSION                CONTAINER-RUNTIME
  10.73.12.79   Ready      master,worker   128d   v1.17.1+c5fd4e8   10.73.12.79   1.2.3.4   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.80   NotReady   master,worker   128d   v1.17.1+c5fd4e8   10.73.12.80   1.2.3.5   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.81   Ready      master,worker   128d   v1.17.1+c5fd4e8   10.73.12.81   1.2.3.6   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.90   Ready      master,worker   128d   v1.17.1+40d7dbd   10.73.12.90   1.2.3.7   Red Hat    3.10.0-1160.6.1.el7.x86_64    cri-o://1.17.5-11.rhaos4.4.git7f979af.el7
  ```

### 5. Access the app

Access the application using the below url.

```
http://1.2.3.4:31010/productpage
```

The `productpage` looks like this.

<img src="images/01-app.png">

## 2. Generate Load for BookInfo app

1. Open the file `./files/01-create-load.sh`

2. Update the bookinfo app url `http://1.2.3.4` with the actual bookinfo app url of yours.

3. Make sure that `apache bench` is installed.

    https://httpd.apache.org/docs/2.4/programs/ab.html

4. Run the load script file 

```
sh 01-create-load.sh
```

5. This load script runs for 5 to 15 minutes.


## 3. Installing FluentBit in IKS

The FluentBit can be downloaded using the info from the url.

https://docs.humio.com/docs/ingesting-data/log-formats/kubernetes/

We have downloaded the same and available in the folder `./files-bookinfo/humio-helm-charts`

### 1. Update Override.yaml

1. Update the feld `humioHostname`

2. Update the field `humioRepoName` and `port` if required.

### 2. Update values.yaml

The `./humio-helm-charts/charts/humio-fluentbit/values.yaml` should be updated as given below.

`Path` under the section `[INPUT]`. The below config allows only the logs from bookinfo namespace to push to humio

```
        Path             /var/log/containers/*bookinfo*.log
```

### 3. Install fluentbit

#### 1. Create Namesapce

create a namespace called `fluentbit-bk` and get into the same namespace.

```
kubectl create ns fluentbit-bk
kubectl config set-context --current --namespace=fluentbit-bk
```

#### 2. Helm Install fluentbit

Run the below command after replacing the TOKEN_VALUEEE with the humion ingest token.

```
helm install humio-bookinfo-fluentbit ./humio-helm-charts --namespace fluentbit-bk --set humio-fluentbit.token=TOKEN_VALUEEE --values ./override.yaml
```

#### 3. UnInstall fluentbit

To delete the fluentbit, run the below command.

```
helm delete humio-bookinfo-fluentbit
```


