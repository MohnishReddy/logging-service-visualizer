#!/bin/bash

echo "Starting..."

#Init Variable values
IMAGE_NAME_WITHOUT_TAG=logging-service-visualizer-image
IMAGE_TAG=latest
IMAGE_NAME=$IMAGE_NAME_WITHOUT_TAG:$IMAGE_TAG
CONTAINER_NAME=logging-service-visualizer

echo Container name will be "->" $CONTAINER_NAME

#Clean up
if [ "$(docker ps -qa -f name="^$CONTAINER_NAME$" )" ]; then
    echo Container $CONTAINER_NAME exists
    
    # Checking if the container is running if yes then stopping it
    if [ "$(docker ps -q -f name="^$CONTAINER_NAME$" )" ]; then
        echo Stopping container $CONTAINER_NAME...
        docker stop $CONTAINER_NAME
        echo Stopped container $CONTAINER_NAME.
    fi
    
    # Removing stopped container
    echo Removing container $CONTAINER_NAME...
    docker rm $CONTAINER_NAME
    echo Removed container $CONTAINER_NAME.
fi

echo Clean up complete.

# Creating and running the container
echo Creating and running new container $CONTAINER_NAME
docker run -d -p 9090:9090 --name $CONTAINER_NAME --mount type=bind,source="$(pwd)"/app,destination=/app $IMAGE_NAME
echo Container $CONTAINER_NAME running.

echo Completed successfully.

echo Waiting for service to be ready to serve requests...

bash health_check.sh

echo Service ready