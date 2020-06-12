### token

- For example, in gitlab, there is one page to add existing cluster page.

![](.token_images/gitlab_kubernetes_cluster.png)

There are three params necessary,

- Api Url
- CA Certificate
- Token



### Command
 
```

kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}'

```


```

kubectl get secrets, and one should named similar to default-token-xxxxx

kubectl get secret <secret name> -o jsonpath="{['data']['ca\.crt']}" | base64 --decode

```

Token - GitLab authenticates against Kubernetes using service tokens, which are scoped to a particular namespace. The token used should belong to a service account with cluster-admin privileges


```markdown
$ kubectl get serviceaccount gitlab -n gitlab -o json | jq -r '.secrets[0].name'
gitlab-token-f9zp7

# 然后根据上面的Secret找到CA证书
$ kubectl get secret gitlab-token-f9zp7 -n gitlab -o json | jq -r '.data["ca.crt"]' | base64 -d
xxxxxCA证书内容xxxxx

# 当然要找到对应的 Token 也很简单
$ kubectl get secret gitlab-token-f9zp7  -n gitlab -o json | jq -r '.data.token' | base64 -d
xxxxxxtoken值xxxx

```