#!/bin/bash

#@--- Function to login to docker hub ---@#
login_docker_hub() {
    docker login -p=$DOCKER_HUB_PASSWD -u=$DOCKER_HUB_USERNM
}
#@--- Function to build and push image ---@#
build_push_image() {
    echo $DOCKER_HUB_USERNM

    docker build -t $DOCKER_HUB_USERNM/$REPO_NAME:$SUPERSET_LATEST_VERSION .
    
    docker push $DOCKER_HUB_USERNM/$REPO_NAME:$SUPERSET_LATEST_VERSION   
}

#@--- Function to logout to dockerhub ---@#
logout_docker_hub() {
    docker logout
}

#@--- Main function ---@#
main() {
    
    source sample.env

    login_docker_hub

    build_push_image

    logout_docker_hub
}

main
