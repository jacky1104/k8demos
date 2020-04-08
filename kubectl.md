### kubectl command


cheat sheet: https://kubernetes.io/docs/reference/kubectl/cheatsheet/

```
kubectl get secret <secret name> -o jsonpath="{['data']['ca\.crt']}" | base64 --decode

```



- Log

```
kubectl logs my-pod                                 # dump pod logs (stdout)
kubectl logs -l name=myLabel                        # dump pod logs, with label name=myLabel (stdout)
kubectl logs my-pod --previous                      # dump pod logs (stdout) for a previous instantiation of a container
kubectl logs my-pod -c my-container                 # dump pod container logs (stdout, multi-container case)
kubectl logs -l name=myLabel -c my-container        # dump pod logs, with label name=myLabel (stdout)
kubectl logs my-pod -c my-container --previous      # dump pod container logs (stdout, multi-container case) for a previous instantiation of a container
kubectl logs -f my-pod                              # stream pod logs (stdout)
kubectl logs -f my-pod -c my-container              # stream pod container logs (stdout, multi-container case)
kubectl logs -f -l name=myLabel --all-containers    # stream all pods logs with label name=myLabel (stdout)
kubectl run -i --tty busybox --image=busybox -- sh  # Run pod as interactive shell
kubectl attach my-pod -i                            # Attach to Running Container
kubectl port-forward my-pod 5000:6000               # Listen on port 5000 on the local machine and forward to port 6000 on my-pod
kubectl exec my-pod -- ls /                         # Run command in existing pod (1 container case)
kubectl exec my-pod -c my-container -- ls /         # Run command in existing pod (multi-container case)
kubectl top pod POD_NAME --containers               # Show metrics for a given pod and its containers


```

### Add private docker-registry

```
kubectl create secret docker-registry regcred --docker-server=http://172.16.97.233 --docker-username=admin --docker-password=Harbor12345 --docker-email=jackyxiang@fortinet.com --namespace=sandboxdev

```



### drain node

```markdown

kubectl drain dnode1.forticloud.com
kubectl drain dnode1.forticloud.com --ignore-daemonsets --delete-local-data

```

### Get ca and token from secret

```markdown

kubectl -n kube-system get secret sa-token -o jsonpath='{.data.token}' | base64 --decode
kubectl -n kube-system get secrets tiller-token-gf965 -o jsonpath='{.data.ca\.crt}' | base64 -d

```


### Create cluster role binding

```markdown

kubectl create clusterrolebinding tiller --serviceaccount=kube-system:tiller --clusterrole=cluster-admin

```