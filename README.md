# Canasta-Kubernetes
Kubernetes stack template for Canasta

How to get started

Make sure you have a Kuberentes cluster ready and Kubectl works

Make necessary changes to the files in the config and settings directory and the .env file

```
./start.sh
```

OR

1. Create configmaps canasta-env from .env file, canasta-config from config/, canasta-settings from settings/
2. Start all the manifest files under Kubernetes/

```
kubectl create configmap canasta-settings --from-file=./settings/
kubectl create configmap canasta-config --from-file=./config/
kubectl create configmap canasta-env --from-env-file=.env

kubectl apply -f Kubernetes/
```



Current Issues:
VisualEditor works during the first deployment. But after redeploying them, VisualEditor seems to have issues connecting to the Parsoid/RESTBase server.