
### How to install runner in kubernetes cluster?

1 prepare the service account and namespace
```markdown
kubectl create ns gitlab

kubectl create serviceaccount forticloud-gitlab -n gitlab
kubectl create clusterrolebinding forticloud-gitlab --clusterrole=cluster-admin --serviceaccount=gitlab:forticloud-gitlab

```

2. helm install gitlab runner

```markdown
helm repo add gitlab https://charts.gitlab.io
helm search repo -l gitlab/gitlab-runner
helm pull gitlab/gitlab-runner --version 0.21.1

## start to edit the value.yaml
1. gitlabUrl: https://git.forticloud.com
2. runnerRegistrationToken: "4f7E-b8ZW8P_xsSj2izq"
3. serviceAccountName: forticloud-gitlab
4. concurrent: 50
5. tags: "sandbox_group, forticloud_group"
6. privileged: true
7. install the runner
8. runUntagged: true
helm install  forticloud-gitlab-runner   gitlab/gitlab-runner -n gitlab -f values.yaml --version 0.21.1
```
