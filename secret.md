
### Secrets

- type generic

- type docker-registry


#### Create generic secret

```markdown
kubectl create secret generic kubernetes-dashboard-certs --from-file=dashboard.key --from-file=dashboard.crt

```

#### create docker-registry secret

```markdown
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>

```