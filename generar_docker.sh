#!/bin/sh

VERSION=0.0.1
NAME=myApp

echo compilando ${NAME} version ${VERSION}
ng build
echo Creando imagen docker
sudo docker build -t "${NAME}:${VERSION}" -f ./Dockerfile ./
echo Ejecutando imagen docker
sudo docker-compose -f docker-compose.yml up -d