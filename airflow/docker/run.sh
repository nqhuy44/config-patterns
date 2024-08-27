#!/bin/bash

AIRFLOW_HOST="servername"

#copy setup folder to the remote server
scp -r setup $AIRFLOW_HOST:/opt

#copy the elk folder to the remote server
scp -r airflow $AIRFLOW_HOST:/opt

# Execute the setup scripts on the remote server
ssh -t $AIRFLOW_HOST << 'EOF'
    set -e
    trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

    export AIRFLOW_ROOT_DIR=/opt
    export AIRFLOW_DIR=$AIRFLOW_ROOT_DIR/airflow
    export AIRFLOW_HOST=$AIRFLOW_HOST

    cd $AIRFLOW_ROOT_DIR/setup
    chmod +x *.sh

    ./docker.sh
    ./airflow.sh

    echo "All scripts executed successfully"
EOF

# Execute the post-run script on the local machine
# ./post-run.sh
