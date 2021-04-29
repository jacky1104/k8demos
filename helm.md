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


helm install --name dashboard --namespace kube-system  stable/kubernetes-dashboard --set rbac.clusterAdminRole=true

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

#### list

```markdown
helm ls --all-namespaces --all
helm uninstall <release-name> -n <namespace>
```

#### Install prometheus
```markdown

helm install <release-name> --namespace monitoring stable/prometheus-operator
```

#### Install metrics-server
```markdown

helm repo add bitnami https://charts.bitnami.com/bitnami

helm install metrics-server --namespace monitoring bitnami/metrics-server
```



### dashboard

```markdown
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard -n kube-system  --set=rbac.clusterAdminRole=true
```

### nginx-ingress

```markdown
// out of date
helm repo add nginx-stable https://helm.nginx.com/stable
helm install nginx-ingress nginx-stable/nginx-ingress -n kube-system --set=controller.kind=DaemonSet --set=controller.hostNetwork=true
helm install nginx-ingress nginx-stable/nginx-ingress -n kube-system --set=controller.kind=DaemonSet --set=controller.hostNetwork=true --set=controller.enableTLSPassthrough=true

// works
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx -n kube-system --set=controller.kind=DaemonSet --set=controller.hostNetwork=true --set=controller.enableTLSPassthrough=true
```



### gitlab runner

```markdown
helm repo add gitlab https://charts.gitlab.io

helm install --namespace gitlab  gitlab-runner -f values.yaml  gitlab/gitlab-runner --version 0.21.1

```
