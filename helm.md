### helm command

```

helm install --name my-release stable/prometheus-operator

helm install --name my-release  --namespace monitoring stable/prometheus-operator

helm install --name my-release stable/prometheus-operator --set prometheusOperator.enabled=true

helm delete my-release // keep the record of the release name

helm ls -a  // you still can see the release name 

helm delete --purge my-release // delete at all, the release name will be available

```