#!/bin/bash
set -e
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

cd /opt/elk
# Check if the network exists, if not, create it
echo "Verify network 'elastic' if it doesn't exist..."
if ! sudo docker network ls | grep -q "elastic"; then
    echo "Creating network 'elastic'..."
    sudo docker network create elastic
else
    echo "Network 'elastic' already exists. Skipping creation."
fi

#create folders for if they don't exist
echo "Verify persitent volumme directory for Elasticsearch stack..."
INIT=1
elastic_dirs=(ssl elasticsearch/data elasticsearch/logs kibana/data kibana/config kibana/logs apm-server/logs apm-server/data logstash/data)
for dir in "${elastic_dirs[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "Creating directory $ELASTIC_DIR/$dir..."
        mkdir -p "$ELASTIC_DIR/$dir"
        INIT=0
    else
        echo "Directory $dir already exists. Skipping creation."
    fi
done

# #change mode of the ssl files
# echo "Changing mode of the SSL files..."
sudo find ssl -type d -exec chmod 755 {} \;
sudo find ssl -type f -exec chmod 644 {} \;

if [ "$INIT" -eq 0 ]; then
    echo "This is the first run."
    echo "Initializing ElasticSearch..."
    docker compose --profile init up --abort-on-container-exit
    docker compose --profile down
    echo "ElasticSearch initialized successfully."
fi

echo "Starting Elastic stack..."
docker compose --profile prod up -d
echo "Elastic stack started successfully."