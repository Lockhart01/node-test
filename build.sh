#! /bin/bash

#builds the image with the env var VERSION as part of the tag

docker build --tag ${DUSER}/node-app:${VERSION} .

#Logs into docker hub

docker login -u ${DUSER} -p ${DPASSWORD}

#push new container image to docker hub

docker push ${DUSER}/node-app:${VERSION}
