### How to delete kubernetes node
```markdown
1.
kubectl drain <node name>

or

kubectl drain <node-name> --ignore-daemonsets --delete-local-data

2. kubectl uncordon <node name>
3. kubectl delete node <node-name>

```