#!/usr/bin/env bash
set -e

echo "Starting example Prometheus stack..."
echo -e "###############################################################################\n"

kubectl create -f classic/ --recursive
kubectl create -f test-spring-full.yml

export PROM_PORT=$(kubectl get services/prometheus-core -n monitoring -o go-template='{{(index .spec.ports 0).nodePort}}')
export GF_PORT=$(kubectl get services/grafana -n monitoring -o go-template='{{(index .spec.ports 0).nodePort}}')
export FE_PORT=$(kubectl get services/frontend -n guestbook -o go-template='{{(index .spec.ports 0).nodePort}}')
export MH_SMTP_PORT=$(kubectl get svc/mailhog -n monitoring -o go-template='{{(index .spec.ports 0).nodePort}}')
export MH_UI_PORT=$(kubectl get svc/mailhog -n monitoring -o go-template='{{(index .spec.ports 1).nodePort}}')
export AM_PORT=$(kubectl get svc/prometheus-alertmanager -n monitoring -o go-template='{{(index .spec.ports 0).nodePort}}')
export PG_PORT=$(kubectl get svc/prometheus-pushgateway -n monitoring -o go-template='{{(index .spec.ports 0).nodePort}}')
export SB_PORT=$(kubectl get svc/test-spring -o go-template='{{(index .spec.ports 0).nodePort}}')

echo -e "\n###############################################################################"
echo "Prometheus targets: http://localhost:$PROM_PORT/targets"
echo "Grafana UI: http://localhost:$GF_PORT/"
echo "Alertmanager UI: http://localhost:$AM_PORT/"
echo "Mailhog UI: http://localhost:$MH_UI_PORT/"
echo "Guestbook frontend: http://localhost:$FE_PORT/"
echo "Spring Endpoint: http://localhost:$SB_PORT/"

echo -e "\n###############################################################################"
echo "Mailhub (internal SMTP address): mailhog.monitoring.svc.cluster.local:$MH_SMTP_PORT"
echo "Pushgateway address (for internal jobs): http://prometheus-pushgateway.monitoring.svc.cluster.local:$PG_PORT/"