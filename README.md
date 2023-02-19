# Canasta-Kubernetes
Kubernetes stack template for Canasta.

**This is a modified version of Canasta for Kubernetes that requires an external database and does not include Caddy or Varnish**.
It is best to use this version on a hosted Kubernetes service offered by one of the major cloud providers (i.e. AWS, Azure, or GCP).

## Installation
First, make sure you have a Kubernetes cluster ready and that kubectl works. (Minikube is a good Kubernetes control plane to start with.)

Then, clone the repository:

```
git clone https://github.com/CanastaWiki/Canasta-Kubernetes
```

Make necessary changes to the `.env` file and the files in the config and settings directory, and then call the following:

```
./start.sh
```

## Set up Elasticsearch and CirrusSearch

Add this to your `LocalSettings.php`:

```
wfLoadExtension( 'VisualEditor' );

wfLoadExtension( 'Elastica' );
wfLoadExtension( 'CirrusSearch' );
wfLoadExtension( 'AdvancedSearch' );

$wgSearchType = 'CirrusSearch';
$wgCirrusSearchServers = [ 'localhost' ];
```

Either run `./init-cirrus-index.sh`:

`./init-cirrus-index.sh name-of-pod-containing-elasticsearch`

For instance:

`./init-cirrus-index.sh canasta-4908ru902-r24ru2`


If you prefer to run things manually, run this but be sure to replace `elasticsearch-pod-name` with the actual pod name from `kubectl get pods`:
```
kubectl exec elasticsearch-pod-name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/UpdateSearchIndexConfig.php \
&& kubectl exec elasticsearch-pod-name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipLinks --indexOnSkip \
&& kubectl exec elasticsearch-pod-name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipParse
```