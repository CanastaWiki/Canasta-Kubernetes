# Canasta-Kubernetes
Kubernetes stack template for Canasta

Note: Currently the secrets are default and hardcoded into the yaml files

How to get started

Make sure you have a Kuberentes cluster ready and Kubectl works

Apply the init-job

After it is completed apply the remaining files to get a Canasta Kuberenetes deployment ready.

```
kubectl apply -f init-job.yaml
kubectl apply -f db.yaml,web.yaml,varnish.yaml,caddy.yaml
```

How it works

Currently the config files are saved on the Kubernetes Node and shared with the pods using hostPath, which is not preferred for production but allows easy management of the different files and 3rd party extensions/skins.

Init job clones the required files to the folder /canasta/config-data and they are served to different pods. This could be skiped if you already have the required config files in the /canasta/config-data folder on your node.