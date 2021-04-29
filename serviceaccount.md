```markdown
kubectl create serviceaccount jacky -n kube-system
kubectl create clusterrolebinding jacky --clusterrole=cluster-admin --serviceaccount=kube-system:jacky
```
### get ca and token

```markdown
kubectl get serviceaccount jacky -n jacky -o json | jq -r '.secrets[0].name'
jacky-token-f9zp7

# 然后根据上面的Secret找到CA证书
kubectl get secret jacky-token-f9zp7 -n jacky -o json | jq -r '.data["ca.crt"]' | base64 -d
xxxxxCA证书内容xxxxx

# 当然要找到对应的 Token 也很简单
kubectl get secret jacky-token-f9zp7  -n jacky -o json | jq -r '.data.token' | base64 -d
xxxxxxtoken值xxxx
```


### Where to download jq tool
```markdown
wget https://stedolan.github.io/jq/download/ -o jq
```
