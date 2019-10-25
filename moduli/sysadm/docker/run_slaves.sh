#!/bin/bash

tmp=$(mktemp /tmp/output.XXXXXXXXXX) || { echo "Failed to create temp file"; exit 1; }

docker cp controller:/root/.ssh/id_rsa.pub "$tmp"

for slave in slave0 slave1 slave2 slave3; do
    docker run --network fabdemo --hostname "$slave" --name "$slave" -d fabdemo
    docker cp "$tmp" "$slave:/root/.ssh/authorized_keys"
    docker exec -it "$slave" /bin/sh -c 'chown root:root /root/.ssh/authorized_keys'
done

rm -f "$tmp"