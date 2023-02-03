#!/bin/bash

# Fait échouer le script en cas d'erreur d'exécution d'une commande
set -euo pipefail

docker build -t myjenkins-blueocean:2.332.3-1 .

# Verifie si le network exist sinon le creer
network_exists=$(docker network ls | awk '{print $2}' | grep jenkins)
if [ -z "$network_exists" ]; then
    docker network create jenkins
fi

docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --publish 8080:8080 --publish 50000:50000 myjenkins-blueocean:2.332.3-1

docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword > pwd

# Sécuriser le fichier de mot de passe en changeant les autorisations
chmod 600 pwd
