
### Secrets

- type generic

- type docker-registry

- type tls


#### Create generic secret

```markdown
kubectl create secret generic kubernetes-dashboard-certs --from-file=dashboard.key --from-file=dashboard.crt

```

#### create docker-registry secret

```markdown
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>

```


#### create tls secret

```markdown
openssl req -newkey rsa:2048 -nodes -keyout domain.key -x509 -days 365 -out domain.crt
kubectl create secret tls ingress-secret --key domain.key  --cert domain.crt  -n kube-system

```
