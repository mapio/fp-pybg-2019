#!/bin/bash

[ -n "$1" ] || { echo "Specify the slave container name"; exit 1; }
tmp=$(mktemp /tmp/output.XXXXXXXXXX) || { echo "Failed to create temp file"; exit 1; }

slave="$1"

docker run --network fabdemo --hostname "$slave" --name "$slave" -d fabdemo
docker cp controller:/root/.ssh/id_rsa.pub "$tmp"
docker cp "$tmp" "$slave:/root/.ssh/authorized_keys"
docker exec -it "$slave" /bin/sh -c 'chown root:root /root/.ssh/authorized_keys'
rm -f "$tmp"