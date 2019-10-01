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


### configMap

```markdown
kubectl create configmap <map-name> <data-source>
```

> Example, game.properties

```markdown
enemies=aliens
lives=3
enemies.cheat=true
enemies.cheat.level=noGoodRotten
secret.code.passphrase=UUDDLRLRBABAS
secret.code.allowed=true
secret.code.lives=30
```

> - Create configMap with --from-file

```markdown
kubectl create configmap game-config --from-file=game.properties
```

> Output

```markdown
apiVersion: v1
data:
  game.properties: |
    enemies=aliens
    lives=3
    enemies.cheat=true
    enemies.cheat.level=noGoodRotten
    secret.code.passphrase=UUDDLRLRBABAS
    secret.code.allowed=true
    secret.code.lives=30
kind: ConfigMap
metadata:
  creationTimestamp: "2019-10-01T17:12:21Z"
  name: game-config
  namespace: default
  resourceVersion: "8964683"
  selfLink: /api/v1/namespaces/default/configmaps/game-config
  uid: 30e30e42-e88c-4b2f-a6ee-5cad2c76ee5c

```

> - Create configMap with --from-env-file

```markdown
kubectl create configmap game-config --from-env-file=game.properties
```

> Output

```markdown
apiVersion: v1
data:
  enemies: aliens
  enemies.cheat: "true"
  enemies.cheat.level: noGoodRotten
  lives: "3"
  secret.code.allowed: "true"
  secret.code.lives: "30"
  secret.code.passphrase: UUDDLRLRBABAS
kind: ConfigMap
metadata:
  creationTimestamp: "2019-10-01T17:13:45Z"
  name: game-config
  namespace: default
  resourceVersion: "8964832"
  selfLink: /api/v1/namespaces/default/configmaps/game-config
  uid: 749463db-7bd6-44f4-b912-7940f1cb0d1b

```

> - Create configMap with --from-literal

```markdown
kubectl create configmap special-config --from-literal=special.how=very --from-literal=special.type=charm
```

> Output

```markdown
apiVersion: v1
data:
  special.how: very
  special.type: charm
kind: ConfigMap
metadata:
  creationTimestamp: "2019-10-01T17:33:11Z"
  name: special-config
  namespace: default
  resourceVersion: "8966928"
  selfLink: /api/v1/namespaces/default/configmaps/special-config
  uid: 896b3fd1-01b1-4379-b6aa-a8929f32781d

```


> Use config map in pod via volume

```markdown
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "ls /etc/config/" ]
      volumeMounts:
      - name: config-volume
        mountPath: /etc/config
  volumes:
    - name: config-volume
      configMap:
        # Provide the name of the ConfigMap containing the files you want
        # to add to the container
        name: special-config
  restartPolicy: Never
```

> Use config map in pod via env value

```markdown
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      env:
        - name: SPECIAL_LEVEL_KEY
          valueFrom:
            configMapKeyRef:
              name: special-config
              key: special.how
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: env-config
              key: log_level
  restartPolicy: Never
```


> Use config map in pod via envFrom

```markdown
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      envFrom:
      - configMapRef:
          name: special-config
  restartPolicy: Never
```