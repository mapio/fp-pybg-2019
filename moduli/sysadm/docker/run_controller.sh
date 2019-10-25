#!/bin/bash

[[ $(docker ps -qa | wc -l) -gt 0 ]] && docker rm -vf $(docker ps -qa)
docker network rm fabdemo
docker network create fabdemo
docker run -it --volume "$(pwd)":/root/notebooks --publish 8080:8080 --network fabdemo --hostname controller --name controller fabdemo /bin/sh -c 'jupyter notebook --ip "*" --allow-root --no-browser --port 8080 /root/notebooks'