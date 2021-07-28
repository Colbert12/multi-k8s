docker build -t mudzunga/multi-client:latest -t mudzunga/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mudzunga/multi-server:latest -t mudzunga/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mudzunga/multi-worker:latest -t mudzunga/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mudzunga/multi-client:latest
docker push mudzunga/multi-server:latest
docker push mudzunga/multi-worker:latest

docker push mudzunga/multi-client:$SHA
docker push mudzunga/multi-server:$SHA
docker push mudzunga/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mudzunga/multi-server:$SHA
kubectl set image deployments/client-deployment client=mudzunga/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mudzunga/multi-worker:$SHA