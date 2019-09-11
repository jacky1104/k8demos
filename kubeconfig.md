### Generate client certificate
```
openssl genrsa -out devops.key 2048
openssl req -new -key devops.key -out devops.csr -subj "/CN=devops"
openssl x509 -req -in devops.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out devops.crt -days 365
openssl x509 -in devops.crt -text


kubectl create rolebinding devops --user=devops --clusterrole=admin -n gitlab-managed-apps
```

