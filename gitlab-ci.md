### gitlab ci demo


```markdown

# This file is a template, and might need editing before it works on your project.
image: golang

variables:
  # Please edit to your GitLab project
  REPO_NAME: git.forticloud.com/jackyxiang/gin-demo


# The problem is that to be able to use go get, one needs to put
# the repository in the $GOPATH. So for example if your gitlab domain
# is gitlab.com, and that your repository is namespace/project, and
# the default GOPATH being /go, then you'd need to have your
# repository in /go/src/gitlab.com/namespace/project
# Thus, making a symbolic link corrects this.k
before_script:
  - cd $CI_PROJECT_DIR
#  - GO111MODULE=on
#  - go mod download

stages:
  - test
  - build
  - deploy
#  - image


#first job
test:
  stage: test
  script:
    - go fmt $(go list ./...)
    - echo 'test done'
    #    - go test -race $(go list ./... | grep -v /vendor/)
  tags:
    # runner tag
    - testcases




build_image:
  stage: build
  image: docker:19.03
  variables:
#    DOCKER_DRIVER: overlay2
    DOCKER_HOST: tcp://127.0.0.1:2375
    DOCKER_TLS_CERTDIR: ""
  services:
    - name: docker:19.03-dind
      command: ["--insecure-registry=http://172.16.97.233:80"]
  script:
    - echo $DOCKER_HOST
    - echo "start exec docker command"
    - docker info
#    - docker login -u "${CI_REGISTRY_USER}" -p "${CI_REGISTRY_PASSWORD}" http://172.16.97.233:80
    - docker login -u "${CI_REGISTRY_USER}" -p "${CI_REGISTRY_PASSWORD}" "${CI_REGISTRY_URL}"
    - docker build -t "${CI_REGISTRY_IMAGE}:latest" .
    - docker tag "${CI_REGISTRY_IMAGE}:latest" "${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME}"
#    - test ! -z "${CI_COMMIT_TAG}" && docker push "${CI_REGISTRY_IMAGE}:latest"
    - docker push "${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME}"


deploy_to_kubenetes:
#  image: bitnami/kubectl:latest
  image: dtzar/helm-kubectl
  stage: deploy
  script:
    - kubectl config set-cluster ${CLUSTER_NAME_IN_KUBE_CONFIG} --server="${CLUSTER_SERVER}"
    - kubectl config set clusters.${CLUSTER_NAME_IN_KUBE_CONFIG}.certificate-authority-data ${CERTIFICATE_AUTHORITY_DATA}
#    - kubectl config set-credentials devops --token="${USER_TOKEN}"
    - kubectl config set-credentials ${CLUSTER_USER_NAME_IN_KUBE_CONFIG} --client-certificate=developer.crt
    - kubectl config set-credentials ${CLUSTER_USER_NAME_IN_KUBE_CONFIG} --client-key=developer.key
    - kubectl config set-context ${CLUSTER_CONTEXT_NAME} --cluster=${CLUSTER_NAME_IN_KUBE_CONFIG} --user=${CLUSTER_USER_NAME_IN_KUBE_CONFIG}
    - kubectl config use-context ${CLUSTER_CONTEXT_NAME}
    - pwd
    - kubectl get pods -n gitlab-managed-apps
    - kubectl apply -f ./manifest/deployment.yaml


```


### gitlab project setting ci 500 error

```markdown

/var/log/gitlab/gitlab-rails
gitlab-rails dbconsole

SELECT current_database();

\dt;

delete from ci_runners where id in (****);

```