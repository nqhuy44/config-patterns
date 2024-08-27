#!/bin/bash

ELASTIC_HOST="servername"

#copy setup folder to the remote server
scp -r setup $ELASTIC_HOST:/opt

#copy the elk folder to the remote server
scp -r elk $ELASTIC_HOST:/opt

# Execute the setup scripts on the remote server
ssh -t $ELASTIC_HOST << 'EOF'
    set -e
    trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

    export ELASTIC_ROOT_DIR=/opt
    export ELASTIC_DIR=$ELASTIC_ROOT_DIR/elk
    export ELASTIC_SETUP_DIR=$ELASTIC_ROOT_DIR/setup
    export ELASTIC_ES_DIR=$ELASTIC_DIR/elasticsearch
    export ELASTIC_KIBANA_DIR=$ELASTIC_DIR/kibana
    export ELASTIC_LOGSTASH_DIR=$ELASTIC_DIR/logstash
    export ELASTIC_APM_DIR=$ELASTIC_DIR/apm-server

    cd /opt/setup
    chmod +x docker.sh elasticsearch.sh

    ./docker.sh
    ./elasticsearch.sh

    echo "All scripts executed successfully"
EOF
