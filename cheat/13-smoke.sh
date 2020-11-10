#!/bin/bash

# Smoke Test

## Data Encryption

kubectl create secret generic kubernetes-the-hard-way \
  --from-literal="mykey=mydata"

gcloud compute ssh controller-0 \
  --command "sudo ETCDCTL_API=3 etcdctl get \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem\
  /registry/secrets/default/kubernetes-the-hard-way | hexdump -C"

## Deployments

kubectl create deployment nginx --image=nginx

kubectl get pods -l app=nginx

### Port Forwarding

POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")
echo $POD_NAME
# nginx-f89759699-p8knv
POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")

### Logs

kubectl logs $POD_NAME

### Exec

kubectl exec -ti $POD_NAME -- nginx -v

## Services

kubectl expose deployment nginx --port 80 --type NodePort
