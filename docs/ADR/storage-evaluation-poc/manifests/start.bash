#!/bin/bash
set -e
minikube delete;
minikube start --memory=4384 --cpus=8  --disk-size 25GB
kubectl apply -k .

#kubectl get pods  --namespace=security-metric-analyzer-grafana | grep deployment
sleep 16
pod=$(kubectl get pods --namespace=security-metric-analyzer-prometheus | awk '{print $1}' | grep -v NAME)
kubectl exec --namespace=security-metric-analyzer-prometheus $pod  -- promtool tsdb create-blocks-from openmetrics /metric-data/metric-data.txt /prometheus/data/
kubectl delete pod --namespace=security-metric-analyzer-prometheus  $pod # restart to load metric data


minikube service grafana --namespace=security-metric-analyzer-grafana
minikube service prometheus-service --namespace=security-metric-analyzer-prometheus
