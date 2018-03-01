#!/bin/bash
kubectl delete -f ./zm_nfs.yaml
kubectl delete -f ./zm_db.yaml
kubectl delete -f ./zm_server.yaml

rm -rf ./zm_db.yaml
rm -rf ./zm_nfs.yaml
rm -rf ./zm_server.yaml

kubectl get svc,pod -o wide
