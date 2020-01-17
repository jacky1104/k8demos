### helm command examples


```
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo udpate
```


#### Install dashboard
```

helm install --name my-release stable/kubernetes-dashboard

helm install --name my-release  --namespace kube-system stable/kubernetes-dashboard

helm install --name my-release stable/kubernetes-dashboard --set rbac.clusterAdminRole=true

helm delete my-release // keep the record of the release name

helm ls -a  // you still can see the release name 

helm delete --purge my-release // delete at all, the release name will be available

```



#### Install nginx-ingress
```

helm install --name my-release stable/nginx-ingress

helm install --name my-release  --namespace kube-system stable/nginx-ingress

helm install --name my-release stable/nginx-ingress --set controller.kind=DaemonSet

// use this command
helm install --namespace kube-system  stable/nginx-ingress --set=controller.kind=DaemonSet --set=controller.hostNetwork=true

helm delete my-release // keep the record of the release name

helm ls -a  // you still can see the release name 

helm delete --purge my-release // delete at all, the release name will be available

```





#### Install prometheus
```

helm install --name my-release stable/prometheus-operator

helm install --name my-release  --namespace monitoring stable/prometheus-operator

helm install --name my-release stable/prometheus-operator --set prometheusOperator.enabled=true

helm delete my-release // keep the record of the release name

helm ls -a  // you still can see the release name 

helm delete --purge my-release // delete at all, the release name will be available

```



### Helm generate template

```markdown

helm create mychart

helm install ./mychart

helm install --debug --dry-run ./mychart //only rendering

```



### Repo


```markdown
helm repo list

helm ls //installed charts
```



#### helm 3


