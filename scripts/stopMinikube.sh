#!/bin/bash
kubectl delete -f test.yaml
eval $(minikube docker-env -u)
minikube stop
minikube delete
