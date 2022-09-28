#!/bin/bash

echo "========== Bringing up the CA docker containers =========="
cd ./docker/
docker-compose -f docker-compose-ca.yaml up -d --remove-orphans
sleep 5


echo "------------- Creating Certificate --------------"
cd ..
sudo ./create_certs.sh
sleep 5


echo "------------  Creating Artifacts   --------------"
sudo ./create_artifacts.sh
sleep 5

cd ./docker
echo "========== Bringing up the docker containers =========="
docker-compose -f docker-compose.yaml up -d --remove-orphans
sleep 5

cd ..

sudo ./create_channel.sh
sleep 5

echo "-------------   Chaincode Lifecycle   --------------"
sudo ./chaincode_lifecycle.sh

