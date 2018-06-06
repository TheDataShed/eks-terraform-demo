#!/bin/bash

NAMESPACE=guestbook

# Create namespace:
kubectl apply -f namespace.yaml

# Apply redis master service:
kubectl apply -f redis-master-controller.yaml -n ${NAMESPACE}
kubectl apply -f redis-master-service.yaml -n ${NAMESPACE}

# Apply redis slave service:
kubectl apply -f redis-slave-controller.yaml -n ${NAMESPACE}
kubectl apply -f redis-slave-service.yaml -n ${NAMESPACE}

# Apply guestbook service:
kubectl apply -f guestbook-controller.yaml -n ${NAMESPACE}
kubectl apply -f guestbook-service.yaml -n ${NAMESPACE}
