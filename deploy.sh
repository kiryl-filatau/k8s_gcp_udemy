docker build -t filatko/multi-client:latest -t filatko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t filatko/multi-server:latest -t filatko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t filatko/multi-worker:latest -t filatko/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push filatko/multi-client:latest
docker push filatko/multi-server:latest
docker push filatko/multi-worker:latest
docker push filatko/multi-client:$SHA
docker push filatko/multi-server:$SHA
docker push filatko/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=filatko/multi-server:$SHA
kubectl set image deployments/client-deployment client=filatko/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=filatko/multi-worker:$SHA