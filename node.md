### How to delete kubernetes node
```markdown
1.
kubectl drain <node name>

or

kubectl drain <node-name> --ignore-daemonsets --delete-local-data

2. kubectl uncordon <node name>
3. kubectl delete node <node-name>

```

### show labels of node

```
kubectl get nodes --show-labels
```

### add label for some node
```
kubectl label nodes <your-node-name> disktype=ssd
```

### delete label for some node

```
kubectl label nodes <your-node-name> disktype-
```


```markdown
To prevent a node from scheduling new pods use:

kubectl cordon <node-name>

To tell is to resume scheduling use:

kubectl uncordon <node-name>
```

### Add node to cluster
```
1. kubeadm token create --print-join-command
2. kubeadm join 172.16.97.172:6443 --token u3ykgd.a17b3kqio8xipciu     --discovery-token-ca-cert-hash sha256:b372c29da39a892e8f45b03a748605007338a27589a85653c797276c03068389
```
