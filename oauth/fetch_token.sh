#!/usr/bin/env bash

export TOKEN=$(http --ignore-stdin --form --follow --timeout 3600 POST $AUTH_API \
    'grant_type'='client_credentials' \
    'scope'="${SCOPES}" \
    'client_id'=$CLIENT_ID \
    'client_secret'=$CLIENT_SECRET \
    Content-Type:'application/x-www-form-urlencoded' | jq -r .access_token)

echo "Status Code from token flow: ${$?}"
echo "Setting HTTPIE token auth to..."
echo $TOKEN

