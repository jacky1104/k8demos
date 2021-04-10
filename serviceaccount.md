```markdown
kubectl create serviceaccount jacky -n kube-system
kubectl create clusterrolebinding jacky --clusterrole=cluster-admin --serviceaccount=kube-system:jacky
```
