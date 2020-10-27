#!/bin/bash
sudo chown ubuntu:ubuntu -R .
sudo chown ubuntu:ubuntu -R *
git reset --hard
git pull
docker build -t limweb/evp-jaymart .
docker login
docker push limweb/evp-jaymart
# docker-compose up -d --build