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

## Set up Elasticsearch
```
kubectl exec elasticsearch-pod-name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/UpdateSearchIndexConfig.php \
&& kubectl exec elasticsearch-pod-name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipLinks --indexOnSkip \
&& kubectl exec elasticsearch-pod-name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipParse
```