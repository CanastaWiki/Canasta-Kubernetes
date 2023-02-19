#! /bin/bash

# Usage:
# ./init-cirrus-index.sh name-of-pod-containing-elasticsearch
# For instance:
# ./init-cirrus-index.sh canasta-4908ru902-r24ru2

elasticsearch_pod_name=$1

kubectl exec $elasticsearch_pod_name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/UpdateSearchIndexConfig.php \
&& kubectl exec $elasticsearch_pod_name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipLinks --indexOnSkip \
&& kubectl exec $elasticsearch_pod_name -it -- php /var/www/mediawiki/w/canasta-extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipParse