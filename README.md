# Canasta-Kubernetes
Kubernetes stack template for Canasta.

## Installation

First, make sure you have a Kubernetes cluster ready, and that Kubectl works.

Then, clone the repository:

```
git clone https://github.com/CanastaWiki/Canasta-Kubernetes
```

Make necessary changes to the .env file and the files in the config and settings directory, and then call the following:

```
./start.sh
```

OR

Create the three necessary ConfigMaps with the following commands:

```
kubectl create configmap canasta-settings --from-file=./settings/
kubectl create configmap canasta-config --from-file=./config/
kubectl create configmap canasta-env --from-env-file=.env
```

Then, run the following to start all the manifest files under the Kubernetes/ directory:


```
kubectl apply -f Kubernetes/
```
