#!/bin/bash

mkdir -p certs

# admin
openssl genrsa -out certs/admin-user.key 2048
openssl req -new -key certs/admin-user.key -out certs/admin-user.csr -subj "/CN=admin-user/O=system:masters"
openssl x509 -req -in certs/admin-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out certs/admin-user.crt -days 365

# client-dev-user
openssl genrsa -out certs/client-dev-user.key 2048
openssl req -new -key certs/client-dev-user.key -out certs/client-dev-user.csr -subj "/CN=client-dev-user/O=development"
openssl x509 -req -in certs/client-dev-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out certs/client-dev-user.crt -days 365

# client-manager
openssl genrsa -out certs/client-manager-user.key 2048
openssl req -new -key certs/client-manager-user.key -out certs/client-manager-user.csr -subj "/CN=client-manager-user/O=management"
openssl x509 -req -in certs/client-manager-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out certs/client-manager-user.crt -days 365

# bi-analyst
openssl genrsa -out certs/bi-analyst-user.key 2048
openssl req -new -key certs/bi-analyst-user.key -out certs/bi-analyst-user.csr -subj "/CN=bi-analyst-user/O=analytics"
openssl x509 -req -in certs/bi-analyst-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out certs/bi-analyst-user.crt -days 365

# tenant-developer
openssl genrsa -out certs/tenant-dev-user.key 2048
openssl req -new -key certs/tenant-dev-user.key -out certs/tenant-dev-user.csr -subj "/CN=tenant-dev-user/O=development"
openssl x509 -req -in certs/tenant-dev-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out certs/tenant-dev-user.crt -days 365

kubectl config set-credentials admin-user --client-certificate=certs/admin-user.crt --client-key=certs/admin-user.key
kubectl config set-credentials client-dev-user --client-certificate=certs/client-dev-user.crt --client-key=certs/client-dev-user.key
kubectl config set-credentials client-manager-user --client-certificate=certs/client-manager-user.crt --client-key=certs/client-manager-user.key
kubectl config set-credentials bi-analyst-user --client-certificate=certs/bi-analyst-user.crt --client-key=certs/bi-analyst-user.key
kubectl config set-credentials tenant-dev-user --client-certificate=certs/tenant-dev-user.crt --client-key=certs/tenant-dev-user.key

kubectl config set-context admin-context --cluster=minikube --user=admin-user
kubectl config set-context client-dev-context --cluster=minikube --user=client-dev-user
kubectl config set-context client-manager-context --cluster=minikube --user=client-manager-user
kubectl config set-context bi-analyst-context --cluster=minikube --user=bi-analyst-user
kubectl config set-context tenant-dev-context --cluster=minikube --user=tenant-dev-user
