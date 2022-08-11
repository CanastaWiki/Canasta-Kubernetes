#! /bin/bash

# Delete pervious configmaps
kubectl delete configmap canasta-settings
kubectl delete configmap canasta-config
kubectl delete configmap canasta-env

# Create configmaps from the configuration files
kubectl create configmap canasta-settings --from-file=./settings/
kubectl create configmap canasta-config --from-file=config/
kubectl create configmap canasta-env --from-env-file=.env

# Create all the kuberenets deployments, services and realates objects.
cd Kubernetes/
kubectl apply -f db.yaml,web.yaml,varnish.yaml,caddy.yaml
cd ..