docker build -t technox64/multi-client:latest -t technox64/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t technox64/multi-server:latest -t technox64/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t technox64/multi-worker:latest -t technox64/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push technox64/multi-client:latest
docker push technox64/multi-server:latest
docker push technox64/multi-worker:latest

docker push technox64/multi-client:$SHA
docker push technox64/multi-server:$SHA
docker push technox64/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=technox64/multi-server:$SHA
kubectl set image deployments/client-deployment client=technox64/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=technox64/multi-worker:$SHA