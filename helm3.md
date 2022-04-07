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
