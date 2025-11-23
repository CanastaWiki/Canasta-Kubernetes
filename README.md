# Canasta-Kubernetes
Kubernetes stack template for Canasta.

## Installation

First, make sure you have a Kubernetes cluster ready, and that Kubectl works.

Then, clone the repository:

```
git clone https://github.com/CanastaWiki/Canasta-Kubernetes
```

Make necessary changes to the `.env` file and the files in the `config` and `settings` directory.

### Option 1: Manual Deployment (Kustomize)

You can deploy directly using `kubectl` with Kustomize:

```bash
kubectl apply -k .
```

This replaces the old `./start.sh` script.

### Option 2: GitOps (ArgoCD)

This repository is ready for ArgoCD.

1. Install ArgoCD on your cluster if you haven't already:

   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```
2. Apply the Application manifest:

```bash
kubectl apply -f argocd-app.yaml
```

This will create an ArgoCD application named `canasta` that syncs this repository to the `default` namespace.

For detailed instructions on accessing the UI, managing deployments, and performing upgrades, see [ArgoCD Usage Guide](ARGOCD_USAGE.md).
