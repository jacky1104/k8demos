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



### Secret

> Create secret with --from-file

```markdown
echo -n 'admin' > ./username.txt
echo -n '1f2d1e2e67df' > ./password.txt

kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt

```

```markdown
apiVersion: v1
data:
  password.txt: MWYyZDFlMmU2N2Rm
  username.txt: YWRtaW4=
kind: Secret
metadata:
  creationTimestamp: "2019-10-01T18:43:03Z"
  name: db-user-pass
  namespace: default
  resourceVersion: "8974448"
  selfLink: /api/v1/namespaces/default/secrets/db-user-pass
  uid: df8956d1-dd8d-4414-8f16-f9402ff7adac
type: Opaque

```


> Create secret with --from-literal
```markdown
kubectl create secret generic dev-db-secret --from-literal=username=devuser --from-literal=password='S!B\*d$zDsb'
```

```markdown
apiVersion: v1
data:
  password: UyFCXCpkJHpEc2I=
  username: ZGV2dXNlcg==
kind: Secret
metadata:
  creationTimestamp: "2019-10-01T18:45:11Z"
  name: dev-db-secret
  namespace: default
  resourceVersion: "8974680"
  selfLink: /api/v1/namespaces/default/secrets/dev-db-secret
  uid: 8cc2b179-bc00-4793-b78e-40ec57850b0d
type: Opaque

```


> Load secret via volume
```markdown
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: mypod
    image: redis
    volumeMounts:
    - name: foo
      mountPath: "/etc/foo"
      readOnly: true
  volumes:
  - name: foo
    secret:
      secretName: mysecret
```
> Load secret via env values
```markdown
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
spec:
  containers:
  - name: mycontainer
    image: redis
    env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: mysecret
            key: username
      - name: SECRET_PASSWORD
        valueFrom:
          secretKeyRef:
            name: mysecret
            key: password
  restartPolicy: Never
```