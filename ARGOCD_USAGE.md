# ArgoCD Usage Guide

This guide provides instructions on how to use ArgoCD with the Canasta Kubernetes stack for deployments, upgrades, and general management.

## Initial Setup & Access

### 1. Retrieve the Initial Admin Password
By default, the initial password for the `admin` user is auto-generated and stored as a secret. Retrieve it with:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

### 2. Access the UI
You can access the ArgoCD UI by port-forwarding the ArgoCD server service:

```bash
kubectl port-forward svc/argocd-server -n argocd LOCAL_PORT:443
```

Open your browser and navigate to `https://localhost:<LOCAL_PORT>`.
- **Username**: `admin`
- **Password**: (The password you retrieved in step 1)

> **Note**: It is highly recommended to change the password after the first login.

## Deployments

ArgoCD operates on a GitOps model. This means the state of your cluster is defined by the files in this repository.

### Triggering a Deployment
1. **Commit & Push**: Make changes to your Kubernetes manifests (e.g., `Kubernetes/web.yaml`, `kustomization.yaml`) and push them to the repository branch that ArgoCD is tracking (usually `main` or `master`).
2. **Auto-Sync**: If you have configured the Application to auto-sync (which is the default in our `argocd-app.yaml`), ArgoCD will automatically detect the changes and apply them to the cluster within a few minutes.
3. **Manual Sync**: You can manually trigger a sync via the ArgoCD UI or CLI if you want changes applied immediately.

## Upgrades

To upgrade Canasta or any other component:

1. **Update Image Tags**: Edit the `Kubernetes/web.yaml` (or other relevant files) to point to the new docker image version.
   ```yaml
   image: ghcr.io/canastawiki/canasta:x.y.z
   ```
2. **Update Configuration**: If the upgrade requires configuration changes (e.g., new `LocalSettings.php` parameters), update the files in `config/`.
3. **Push Changes**: Commit and push these changes to your git repository.
4. **Sync**: ArgoCD will pick up the changes and perform a rolling update of the deployments.

## Troubleshooting

- **OutOfSync**: If the application status is `OutOfSync`, click the "Sync" button in the UI to see the diff and force a synchronization.
- **Health Status**: Check the "Health" status of the application in the UI. If it is "Degraded", inspect the individual resources (Pods, Services) for errors.
