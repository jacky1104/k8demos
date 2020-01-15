### Generate client certificate
- https client and server double authentication

### Generate client certificate

```
openssl genrsa -out devops.key 2048
openssl req -new -key devops.key -out devops.csr -subj "/CN=devops"
openssl x509 -req -in devops.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out devops.crt -days 365
openssl x509 -in devops.crt -text
kubectl create rolebinding devops --user=devops --clusterrole=admin -n gitlab-managed-apps
```

### original file

```markdown
apiVersion: v1
kind: Config
preferences: {}

clusters:
- cluster:
  name: development
- cluster:
  name: scratch

users:
- name: developer
- name: experimenter
- name: devops

contexts:
- context:
  name: dev-frontend
- context:
  name: dev-storage
- context:
  name: exp-scratch

```

```
kubectl config --kubeconfig=config-demo set-cluster development --server=https://1.2.3.4 --certificate-authority=fake-ca-file
kubectl config --kubeconfig=config-demo set-credentials devops --client-certificate=devops.crt --client-key=devops.key
kubectl config --kubeconfig=config-demo set-context dev-frontend --cluster=development --namespace=frontend --user=devops
```


```markdown
export KUBECONFIG=$KUBECONFIG:config-demo
```

```markdown
kubectl config view
kubectl config --kubeconfig=config-demo view --minify
```

```markdown
kubectl config --kubeconfig=config-demo use-context dev-frontend
```
