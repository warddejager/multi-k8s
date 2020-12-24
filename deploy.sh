docker build -t warddejager/multi-client:latest -t warddejager/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t warddejager/multi-server:latest -t warddejager/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t warddejager/multi-worker:latest -t warddejager/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push warddejager/multi-client:latest
docker push warddejager/multi-server:latest
docker-push warddejager/multi-worker:latest

docker push warddejager/multi-client:$SHA
docker push warddejager/multi-server:$SHA
docker-push warddejager/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=warddejager/multi-server:$SHA
kubectl set image deployments/client-deployment client=warddejager/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=warddejager/multi-worker:$SHA