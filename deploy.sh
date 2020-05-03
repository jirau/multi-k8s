docker build -t ajirau/multi-client:latest -t ajirau/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajirau/multi-server:latest -t ajirau/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajirau/multi-worker:latest -t ajirau/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ajirau/multi-client:latest
docker push ajirau/multi-server:latest
docker push ajirau/multi-worker:latest

docker push ajirau/multi-client:$SHA
docker push ajirau/multi-server:$SHA
docker push ajirau/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajirau/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajirau/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajirau/multi-worker:$SHA