echo '---- #1 build & push image to hub.docker.io -----------'
cd ..
echo 'path-----> ${PWD}---------'
DOCKER_USERNAME="eventpasshub"
DOCKER_PASSWORD="@eventpass01"
DOCKER_IMGNAME="eventpasshub/evp-jaymart:latest"
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker build -t $DOCKER_IMGNAME .
docker push $DOCKER_IMGNAME
cd docker
echo '------#2--Remote to Deploy docker container-------'
echo 'path----->${PWD}-------';
export HOST=jaymart.eventpassdev.com
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=$HOST:2376
export DOCKER_CERT_PATH=${PWD}/server/
export COMPOSE_TLS_VERSION=TLSv1_2
export CURL_CA_BUNDLE=${PWD}/server/server-cert.pem
cd ..
echo ${PWD}
docker-compose pull &&  docker-compose up --force-recreate -d
docker image prune -f
docker-compose ps
docker ps
echo '------------ End ----------------'
