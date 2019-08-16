### core dns in charge of the load dns

- Debug dns

```
nslookup  kubernetes.default

```

- Core dns using configMap "core-dns" to load dns config.

  In forward module, the ip is the dns server ip.
  
  Reference doc: https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/
```
data:
  Corefile: |
    .:53 {
        errors
        health
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           upstream
           fallthrough in-addr.arpa ip6.arpa
           ttl 30
        }
        prometheus :9153
        forward . /etc/resolv.conf
        cache 30
        loop
        reload
        loadbalance
    }
    git.forticloud.com:53 {
        errors
        cache 30
        forward . 172.16.94.220 
    }

```

Note: 172.16.94.220 is an dns server

forward: Any queries that are not within the cluster domain of Kubernetes will be forwarded to predefined resolvers (/etc/resolv.conf).

```
forward .  172.16.0.1

```