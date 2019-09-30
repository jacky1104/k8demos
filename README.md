# k8demos
 Some tips and yaml config

 ### node, taint & toleration
 [taint and toleration](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/)
 
 ```markdown
kubectl describe node master
// mark taint
kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule
kubectl taint nodes master node-role.kubernetes.io/master:PreferNoSchedule

// remove taint
kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule-
```
 
### service

```markdown
// access service
http://service.namespace
```