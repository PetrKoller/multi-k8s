docker build -t petrkoller/multi-client:latest -t petrkoller/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t petrkoller/multi-server:latest -t petrkoller/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t petrkoller/multi-worker:latest -t petrkoller/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push petrkoller/multi-client:latest
docker push petrkoller/multi-server:latest
docker push petrkoller/multi-worker:latest

docker push petrkoller/multi-client:$SHA
docker push petrkoller/multi-server:$SHA
docker push petrkoller/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=petrkoller/multi-server:$SHA
kubectl set image deployments/client-deployment client=petrkoller/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=petrkoller/multi-worker:$SHA