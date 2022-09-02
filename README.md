# Canasta-Kubernetes
Kubernetes stack template for Canasta

How to get started

Make sure you have a Kuberentes cluster ready and Kubectl works

Clone the repository

```
git clone https://github.com/amalpaul54111/Canasta-Kubernetes.git
```

Make necessary changes to the .env file and the files in the config and settings directory

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
