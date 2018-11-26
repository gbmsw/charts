kubectl create namespace microclimatens
cloudctl login -a https://secure.bluedemos.com:8443 -u admin -p icp1nCl0ud -c id-mycluster-account -n microclimatens
kubectl create -f mycip.yaml
kubectl create secret docker-registry microclimate-registry-secret --docker-server=secure.bluedemos.com:8500 --docker-username=admin --docker-password=icp1nCl0ud --docker-email=null
HELM_HOME=/home/skytap/.helm
kubectl create secret generic microclimate-helm-secret --from-file=cert.pem=$HELM_HOME/cert.pem --from-file=ca.pem=$HELM_HOME/ca.pem --from-file=key.pem=$HELM_HOME/key.pem
kubectl create secret docker-registry microclimate-pipeline-secret --docker-server=secure.bluedemos.com:8500 --docker-username=admin --docker-password=icp1nCl0ud --docker-email=null --namespace=microclimate-pipeline-deployments
helm repo add ibm-charts https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
helm install --name microclimate --namespace microclimatens --set persistence.size=4Gi --set persistence.existingClaimName=mc-home --set jenkins.Persistence.ExistingClaim=jenkins-home --set jenkins.Pipeline.Registry.Url=secure.bluedemos.com:8500 --set global.rbac.serviceAccountName=micro-sa,jenkins.rbac.serviceAccountName=pipeline-sa,global.ingressDomain=10.0.0.1.nip.io ibm-charts/ibm-microclimate --tls