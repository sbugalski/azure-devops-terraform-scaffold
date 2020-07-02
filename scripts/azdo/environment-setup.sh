#!/usr/bin/env bash

echo "##vso[task.setvariable variable=AZURE_CLIENT_ID;issecret=true]${servicePrincipalId}"
echo "##vso[task.setvariable variable=AZURE_CLIENT_SECRET;issecret=true]${servicePrincipalKey}"
echo "##vso[task.setvariable variable=AZURE_SUBSCRIPTION_ID;issecret=false]$(az account show --query 'id' -o tsv)"
echo "##vso[task.setvariable variable=AZURE_TENANT_ID;issecret=true]${tenantId}"
echo "##vso[task.setvariable variable=TF_BACKEND_CONTAINER]$BUILD_SOURCEBRANCHNAME"