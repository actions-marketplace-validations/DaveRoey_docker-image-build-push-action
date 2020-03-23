#!/bin/bash
echo "login docker start..."
echo $INPUT_PASSWORD | sudo docker login --username=$INPUT_USER_NAME $INPUT_REGISTRY_URL --password-stdin
echo "docker build start..."
docker_file=$INPUT_DOCKER_FILE
if [ "${docker_file}" = "" ]; then
    docker_file="."
fi
sudo docker build -t $INPUT_IMAGE_NAME:$INPUT_IMAGE_VERSION ${docker_file}
echo "docker tag start..."
sudo docker tag $INPUT_IMAGE_NAME:$INPUT_IMAGE_VERSION $INPUT_REGISTRY_URL/$INPUT_NAMESPACES/$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
echo "docker push start..."
sudo docker push $INPUT_REGISTRY_URL/$INPUT_NAMESPACES/$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
echo "build build and push success."