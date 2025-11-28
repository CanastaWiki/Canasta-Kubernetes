# Canasta-Kubernetes
Kubernetes stack template for Canasta.

## Installation

First, make sure you have a Kubernetes cluster ready, and that Kubectl works.

Then, clone the repository:

```
git clone https://github.com/CanastaWiki/Canasta-Kubernetes
```

Make necessary changes to the `.env` file and the files in the `config` and `settings` directory.

> **Note for Fresh Installations**: If you are installing Canasta for the first time, you will need to go through the MediaWiki setup UI. After the setup is complete, download the generated `LocalSettings.php`, place it in the `config/` directory, and uncomment the `LocalSettings.php` line in `kustomization.yaml`. Then, apply the changes again.

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

## Backup Service

This stack includes a Restic-based backup service that runs daily. It backs up the database, images, and configuration.

### Configuration

Configure the backup backend by adding the following variables to your `.env` file:

**Azure:**
```bash
RESTIC_REPOSITORY=azure:container_name:/path/to/repo
RESTIC_PASSWORD=your_restic_password
AZURE_ACCOUNT_NAME=your_storage_account_name
AZURE_ACCOUNT_KEY=your_storage_account_key
```

**AWS S3:**
```bash
RESTIC_REPOSITORY=s3:s3.amazonaws.com/bucket_name
RESTIC_PASSWORD=your_restic_password
AWS_ACCESS_KEY_ID=your_access_key_id
AWS_SECRET_ACCESS_KEY=your_secret_access_key
```

**Local:**
```bash
RESTIC_REPOSITORY=/repo
RESTIC_PASSWORD=your_restic_password
```
(Note: For local backups, the data is stored in `/canasta/backups` on the host machine).

**Frequency:**
You can configure the backup frequency by adding `BACKUP_SCHEDULE` to your `.env` file. The default is `@daily`.
```bash
BACKUP_SCHEDULE="0 2 * * *" # Run at 2 AM daily
```

**Retention Policy:**
You can configure the retention policy by adding `RESTIC_RETENTION` to your `.env` file. The default is `--keep-daily 7 --keep-weekly 4 --keep-monthly 6`.
```bash
RESTIC_RETENTION="--keep-daily 14 --keep-weekly 2"
```
