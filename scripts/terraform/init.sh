#!/usr/bin/env bash

TF_BACKEND_TFSTATE=${TF_FOLDER##*/}.tfstate

terraform init -input=false -backend=true -backend-config="resource_group_name=${TF_BACKEND_RESOURCE_GROUP_NAME}" -backend-config="storage_account_name=${TF_BACKEND_STORAGE_ACCOUNT_NAME}" -backend-config="container_name=${TF_BACKEND_CONTAINER}" -backend-config="key=${TF_BACKEND_TFSTATE}"