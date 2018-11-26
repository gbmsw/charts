helm delete --purge microclimate --tls
kubectl delete persistencevolumeclaim mc-home
kubectl delete persistencevolumeclaim jenkins-home
kubectl delete secret microclimate-pipeline-secret -n microclimate-pipeline-deployments