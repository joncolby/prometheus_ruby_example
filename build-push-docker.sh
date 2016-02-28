#!/bin/bash

eval $(docker-machine env)
docker build --no-cache -t prometheus_example .
IMAGE_ID=$(docker images -q prometheus_example)
docker tag $IMAGE_ID jcolby/prometheus_example:latest
docker login
docker push jcolby/prometheus_example
