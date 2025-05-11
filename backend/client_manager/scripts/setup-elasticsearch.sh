#!/bin/bash

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch to be ready..."
until curl -s "http://saaster-elasticsearch:9200/_cluster/health" | grep -q '"status":"green"'; do
  sleep 5
  echo "Still waiting for Elasticsearch..."
done

echo "Elasticsearch is ready. Creating index template..."

# Create index template for client-manager-logs
curl -X PUT "http://saaster-elasticsearch:9200/_template/client-manager-logs" -H 'Content-Type: application/json' -d'
{
  "index_patterns": ["client-manager-logs*"],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "level": { "type": "keyword" },
      "msg": { "type": "text" },
      "time": { "type": "date" },
      "service": { "type": "keyword" },
      "trace_id": { "type": "keyword" },
      "span_id": { "type": "keyword" },
      "fields": { "type": "object", "dynamic": true }
    }
  }
}
'

# Create initial index
curl -X PUT "http://saaster-elasticsearch:9200/client-manager-logs-$(date +%Y.%m.%d)"

echo "Elasticsearch setup completed."
