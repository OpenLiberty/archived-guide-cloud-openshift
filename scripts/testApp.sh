#!/bin/bash
set -euxo pipefail

##############################################################################
##
##  GH actions CI test script
##
##############################################################################

mvn -q package

docker pull openliberty/open-liberty:kernel-java8-openj9-ubi

docker build -t system:test system/.
docker build -t inventory:test inventory/.

kubectl apply -f ../scripts/test.yaml

sleep 120

kubectl get pods

GUIDE_IP=$(minikube ip)
GUIDE_SYSTEM_PORT=$(kubectl get service system-service -o jsonpath="{.spec.ports[0].nodePort}")
GUIDE_INVENTORY_PORT=$(kubectl get service inventory-service -o jsonpath="{.spec.ports[0].nodePort}")

curl http://$GUIDE_IP:$GUIDE_SYSTEM_PORT/system/properties

curl http://$GUIDE_IP:$GUIDE_INVENTORY_PORT/inventory/systems/system-service

SYSTEM_IP=$GUIDE_IP:$GUIDE_SYSTEM_PORT
INVENTORY_IP=$GUIDE_IP:$GUIDE_INVENTORY_PORT

mvn verify -Ddockerfile.skip=true -Dsystem.ip=$SYSTEM_IP -Dinventory.ip=$INVENTORY_IP

kubectl logs $(kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}' | grep system)
kubectl logs $(kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}' | grep inventory)
