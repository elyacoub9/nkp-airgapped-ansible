#!/bin/bash


# Update hosts.ini

HARBOR_IP=$(grep 'HARBOR_IP:' vars/all.yaml | awk '{print $2}' | tr -d '"')
echo -e "[bootstrap]\n$HARBOR_IP" > inventory/hosts.ini

ssh-keygen -o -f /root/.ssh/id_rsa -N "" -q

echo "inventory/hosts.ini updated"
