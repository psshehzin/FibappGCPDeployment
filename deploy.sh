#!/bin/bash
docker build -t shehzin/multi-client:latest -t shehzin/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t shehzin/multi-server:latest -t shehzin/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t shehzin/multi-worker:latest -t shehzin/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push shehzin/multi-client:latest
docker push shehzin/multi-server:latest
docker push shehzin/multi-worker:latest
docker push shehzin/multi-client:$GIT_SHA
docker push shehzin/multi-server:$GIT_SHA
docker push shehzin/multi-worker:$GIT_SHA
kubectl apply -f ./k8s  
kubectl set image deployments/server-deployment server=shehzin/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=shehzin/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=shehzin/multi-worker:$GIT_SHA
