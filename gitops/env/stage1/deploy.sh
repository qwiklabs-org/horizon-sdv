#!/bin/bash

ES_NS=external-secrets
ES_NAME=external-secrets
ES_CHART=external-secrets
ES_PATH=external-secrets
ES_VERSION=0.10.4
ES_VALUES=external-secrets-values.yaml

ARGOCD_NS=argocd
ARGOCD_NAME=argocd
ARGOCD_CHART=argo-cd
ARGOCD_PATH=argocd
ARGOCD_VERSION=7.6.12
ARGOCD_VALUES=argocd-values.yaml

helm repo add argocd https://argoproj.github.io/argo-helm
helm repo add external-secrets https://charts.external-secrets.io
helm repo update

deploy() {
  D_NS=$1
  D_NAME=$2
  D_CHART=$3
  D_PATH=$4
  D_VERSION=$5
  D_VALUES=$6

  D_STATUS=$(helm list -n $D_NS | grep $D_CHART-$D_VERSION | awk '{print $1 " " $2 " " $8 " " $9}')
  if [ "$D_STATUS" == "$D_NAME $D_NS deployed $D_CHART-$D_VERSION" ]; then
    D_DIFF=$(helm diff upgrade $D_NAME $D_PATH/$D_CHART --namespace $D_NS --version $D_VERSION)
    if [ "$D_DIFF" != "" ]; then
      helm upgrade $D_NAME $D_PATH/$D_CHART -n $D_NS --create-namespace --values $D_VALUES --version $D_VERSION
    fi
  else
    helm install $D_NAME $D_PATH/$D_CHART -n $D_NS --create-namespace --values $D_VALUES --version $D_VERSION
  fi
}

deploy $ES_NS $ES_NAME $ES_CHART $ES_PATH $ES_VERSION $ES_VALUES
kubectl apply -f argocd-secrets.yaml
deploy $ARGOCD_NS $ARGOCD_NAME $ARGOCD_CHART $ARGOCD_PATH $ARGOCD_VERSION $ARGOCD_VALUES

kubectl apply -f argocd-config.yaml
