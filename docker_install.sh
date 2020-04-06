#!/bin/bash


echo 'yum update'

sudo 'yum -y update'

echo 'start to uninstall docker'

sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

echo 'set up repository'

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo 'start to install docker'

sudo yum install -y  docker-ce docker-ce-cli containerd.io

echo 'start docker'

sudo systemctl start docker

echo 'enable docker'

sudo systemctl enable docker

echo 'docker version'

sudo docker version
