#!/bin/bash
set -e
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

cd $AIRFLOW_DIR


#create folders if they don't exist
INIT=1
echo "Verify persistent volume directory..."
airflow_dirs=("dags" "logs" "config" "plugins" "postgres")
for dir in "${airflow_dirs[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "Creating directory $AIRFLOW_DIR/$dir..."
        mkdir -p "$AIRFLOW_DIR/$dir"
        INIT=0
    else
        echo "Directory $dir already exists. Skipping creation."
    fi
done


if [ "$INIT" -eq 0 ]; then
    echo "This is the first run."
    echo "Initializing Airflow..."
    # After run init command in container, it will exit. So, we will clean up the container
    docker compose --profile init up --abort-on-container-exit
    docker compose --profile down
    echo "Airflow initialized successfully."
fi

# Start the Airflow stack
echo "Starting Airflow stack..."
docker compose --profile production up -d
echo "Airflow stack started successfully."
