#!/bin/sh

userName=$1
if [ ! "$userName" ];then
  userName=devops
fi

role=$2
if [ ! "$role" ];then
  role=view
fi

contextName=$3
if [ ! "$contextName" ];then
  contextName="$userName"_"$role"_context
fi

echo 'please create role binding in cluster'
# shellcheck disable=SC2016
echo 'kubectl create clusterrolebinding "$userName"  --clusterrole="$role" --user="$userName"'
echo 'generate client key and certificate'


#get ca.crt from /etc/kubernetes/pki/ca.crt in cluster master server
#get ca.key from /etc/kubernetes/pki/ca.key in cluster master server

openssl genrsa -out $userName.key 2048
openssl req -new -key $userName.key -out $userName.csr -subj "/CN=$userName"
openssl x509 -req -in $userName.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $userName.crt -days 365
openssl x509 -in $userName.crt -text

kubectl config  set-cluster "$userName"_"$role"_cluster --server=https://172.16.97.172:6443 --certificate-authority=ca.crt
kubectl config  set-credentials $userName --client-certificate="$userName".crt --client-key="$userName".key
kubectl config  set-context $contextName --cluster="$userName"_"$role"_cluster  --user=$userName

#exec this in master node.
#kubectl create clusterrolebinding $userName  --clusterrole=$role --user=$userName


# verify
kubectl config use-context $contextName
kubectl get pods --all-namespaces