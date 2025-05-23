#!/usr/bin/env bash

# Copyright (c) 2024-2025 Accenture, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

APISERVER=https://kubernetes.default.svc
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)
TOKEN=$(cat ${SERVICEACCOUNT}/token)
CACERT=${SERVICEACCOUNT}/ca.crt

npm install
node keycloak.mjs
SECRET=$(cat client-jenkins.json | jq -r ".secret")
DOMAIN_BS=$(echo $DOMAIN | sed 's:/:\\/:g')
sed -i "s/##DOMAIN##/${DOMAIN_BS}/g" ./secret.json
sed -i "s/##SECRET##/${SECRET}/g" ./secret.json

curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X DELETE ${APISERVER}/api/v1/namespaces/jenkins/secrets/jenkins-keycloak
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -H 'Accept: application/json' -H 'Content-Type: application/json' -X POST ${APISERVER}/api/v1/namespaces/jenkins/secrets -d @secret.json
