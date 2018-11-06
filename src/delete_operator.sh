#!/usr/bin/env bash

echo "Deleting Operator..."
kubectl delete -f 200-operator/ --recursive

echo "Deleting custom resources..."
for n in $(kubectl get namespaces -o jsonpath={..metadata.name}); do
  kubectl delete --all --namespace=$n prometheus,servicemonitor,alertmanager
done

echo "Deleting services..."
for n in $(kubectl get namespaces -o jsonpath={..metadata.name}); do
  kubectl delete --ignore-not-found --namespace=$n service prometheus-operated alertmanager-operated
done

# echo "Deleting CRDs...."
# kubectl delete --ignore-not-found customresourcedefinitions \
#   prometheuses.monitoring.coreos.com \
#   servicemonitors.monitoring.coreos.com \
#   alertmanagers.monitoring.coreos.com

# echo "Deleting secrets..."
# kubectl delete secrets/alertmanager-example

