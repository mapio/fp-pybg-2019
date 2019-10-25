#!/bin/bash

docker build -t fabdemo .
docker run --rm fabdemo /bin/cat /root/.ssh/id_rsa.pub > controller_rsa.pub