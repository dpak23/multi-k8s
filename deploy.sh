#SHA comes from .travis.yml file. 
docker build -t deepaktyagi/multi-client:latest -t deepaktyagi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deepaktyagi/multi-server:latest -t deepaktyagi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deepaktyagi/multi-worker:latest -t deepaktyagi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deepaktyagi/multi-client:latest
docker push deepaktyagi/multi-server:latest
docker push deepaktyagi/multi-worker:latest

docker push deepaktyagi/multi-client:$SHA
docker push deepaktyagi/multi-server:$SHA
docker push deepaktyagi/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=deepaktyagi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=deepaktyagi/multi-worker:$SHA
kubectl set image deployments/client-deployment client=deepaktyagi/multi-client:$SHA