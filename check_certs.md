### Check expire date

```markdown
kubeadm certs check-expiration

kubeadm certs renew all

mv /etc/kubernetes/kubelet.conf /etc/kubernetes/kubelet.conf_bak
kubeadm init phase kubeconfig kubelet
```
