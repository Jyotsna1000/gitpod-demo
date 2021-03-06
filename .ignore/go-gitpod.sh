#!/usr/bin/env bash
echo "Locating required resources..."
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR

curl -s --output guru-shifu.tar.gz "https://guru-shifu-artifacts.s3.ap-south-1.amazonaws.com/Guru-Shifu-Trainee-Output/outputDev/guru-shifu-neev-dev.tar.gz" 
tar -xf guru-shifu.tar.gz

touch .env
 echo 'WORKSPACE_PATH=/workspace/gitpod' >> .env
 echo "REACT_APP_HOST_URL=https://8080-${GITPOD_WORKSPACE_URL#*//}" >> .env
echo "Loading guru-shifu images..."
docker load -i guru-shifu-images.tar.gz
echo "Starting guru-shifu..."
docker-compose -f docker-compose-gitpod.yml up -d 
sdk install gradle 6.8.3

if [ $? == 0 ]
then
  echo "Waiting for guru-shifu to start up.... "
  until $(curl --output /dev/null --silent --head --fail http://localhost:3000/); do
    printf "."
    sleep 1
  done
  echo "Guru-shifu started successfully..."
fi
cd /workspace
sudo chmod -R 777 gitpod-demo
