#! /bin/bash

docker service update --image medraut/node-app:$1 node-app

