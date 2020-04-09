### Generate client certificate
- https client and server double authentication

### Generate client certificate

There are two kinds of user
- In cluster, service account
- Out cluster, normal user

When create client certificate with k8 cluster root ca, the CN is the user name.

```
openssl genrsa -out devops.key 2048
openssl req -new -key devops.key -out devops.csr -subj "/CN=devops"  //devops is the user name
openssl x509 -req -in devops.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out devops.crt -days 365
openssl x509 -in devops.crt -text
// if create rolebinding, use clusterrole=admin
// if create clusterrolebind, use clusterrole=cluster-admin 
kubectl create rolebinding devops --user=devops --clusterrole=admin -n gitlab-managed-apps // grant rights to the user

### this is for service account, and authentication with token
kubectl create rolebinding jacky --serviceaccount=default:jacky  --clusterrole=admin
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

### get fake-ca-file from /etc/kubernetes/pki/ca.crt
```
kubectl config --kubeconfig=config-demo set-cluster development --server=https://1.2.3.4 --certificate-authority=fake-ca-file
kubectl config --kubeconfig=config-demo set-credentials devops --client-certificate=devops.crt --client-key=devops.key
kubectl config --kubeconfig=config-demo set-context dev-frontend --cluster=development --namespace=frontend --user=devops


# set credentials with token 
# this token can be queries from servic account, secret, then token.
 kubectl config --kubeconfig=config-demo set-credentials jacky --token=jacky-token
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

kubectl get pods --context=devops@wilson-cluster --kubeconfig=config-demo
```


```markdown

use --kubeconfig flag, if specified
use KUBECONFIG environment variable, if specified
use $HOME/.kube/config file


kubectl get pods --kubeconfig=file1
kubectl get pods --kubeconfig=file2

# or:

KUBECONFIG=file1 kubectl get pods
KUBECONFIG=file2 kubectl get pods
```