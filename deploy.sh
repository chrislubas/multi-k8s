docker build -t clubasaces/multi-client:latest -t clubasaces/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t clubasaces/multi-server:latest -t clubasaces/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t clubasaces/multi-worker:latest -t clubasaces/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push clubasaces/multi-client:latest
docker push clubasaces/multi-server:latest
docker push clubasaces/multi-worker:latest
docker push clubasaces/multi-client:$SHA
docker push clubasaces/multi-server:$SHA
docker push clubasaces/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=clubasaces/multi-server:$SHA
kubectl set image deployments/client-deployment client=clubasaces/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=clubasaces/multi-worker:$SHA
