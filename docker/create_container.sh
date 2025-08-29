#!/bin/bash

# Docker image name
IMAGE_NAME=${IMAGE_NAME:-zettascaletech/roscon2025_workshop}
# Docker container name
CONTAINER_NAME=${CONTAINER_NAME:-roscon2025_workshop}

# Zenoh exposed port
ZENOH_PORT=${ZENOH_PORT:-7447}

# Get absolute path to base directory (roscon2025_workshop/ dir)
BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)

if docker container ls -a -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Container already exists
    echo "Error: Container $CONTAINER_NAME already exists."
else
    # Run in background a container named $CONTAINER_NAME from image $IMAGE_NAME.
    # Configured with:
    #  - port forwarding for Zenoh
    #  - port forwarding for web browser access to VNC (6080:80)
    #  - a volume mounting host's roscon2025_workshop/zenoh_confs/ to /ros_ws/zenoh_confs
    docker run -it --init -d \
        --name "$CONTAINER_NAME" \
        -p $ZENOH_PORT:$ZENOH_PORT/tcp \
        -p $ZENOH_PORT:$ZENOH_PORT/udp \
        -p 6080:80 \
        -v "$BASE_DIR/zenoh_confs:/ros_ws/zenoh_confs" \
        --security-opt seccomp=unconfined --shm-size=512m \
        "$IMAGE_NAME"
fi
