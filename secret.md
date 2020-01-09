
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

kubectl create secret tls forticloud-two-container-secret --key star_forticloud_com-privkey.key  --cert star_forticloud_com-chained.crt  -n sandboxdev

```