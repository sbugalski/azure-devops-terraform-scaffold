#!/usr/bin/env bash

# variables
TAGS=('owner=Terraform' 'Terraform=Backend')

# create Resource Group for Backend Storage
az group create --location "${TF_BACKEND_REGION}" --name "${TF_BACKEND_RESOURCE_GROUP_NAME}" --tags ${TAGS[@]}

# create Read Access Geo and Zone Redundant Storage
az storage account create --kind StorageV2 --location "${TF_BACKEND_REGION}" --name "${TF_BACKEND_STORAGE_ACCOUNT_NAME}" --resource-group "${TF_BACKEND_RESOURCE_GROUP_NAME}" --sku Standard_RAGZRS --https-only true --encryption-services blob --tags "${TAGS[@]}"

# enable blob soft delete
az storage blob service-properties delete-policy update --account-name "${TF_BACKEND_STORAGE_ACCOUNT_NAME}" --days-retained 365 --enable true --auth-mode login

# create storage container
az storage container create --account-name "${TF_BACKEND_STORAGE_ACCOUNT_NAME}" --name "$TF_BACKEND_CONTAINER" --auth-mode login