#!/usr/bin/env bash

echo "Starting Prometheus Operator example stack..."
echo -e "###############################################################################\n"

# kubectl create secret generic alertmanager-example --from-file=alertmanager.yaml
kubectl create -f 200-operator/ --recursive
