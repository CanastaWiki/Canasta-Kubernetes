#! /bin/bash

# Delete previous ConfigMaps
kubectl delete configmap canasta-settings
kubectl delete configmap canasta-config
kubectl delete configmap canasta-env

# Create ConfigMaps from the configuration files
kubectl create configmap canasta-settings --from-file=./settings/
kubectl create configmap canasta-config --from-file=./config/
kubectl create configmap canasta-env --from-env-file=.env

# Create all the Kubernetes deployments, services and related objects
kubectl apply -f Kubernetes/
