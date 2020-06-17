#!/usr/bin/env bash

if [ "${TF_DESTROY,,}" = "false" ]; then
  echo "##[command]Terraform Plan: terraform plan -input=false -out ${BUILD_BUILDNUMBER}.tfplan"

  terraform refresh -input=false
  terraform plan -input=false -out ${BUILD_BUILDNUMBER}.tfplan
fi

if [ "${TF_DESTROY,,}" == "true" ]; then
  echo "##vso[task.logissue type=warning]Terraform Destroy Plan: terraform -destroy plan -input=false -out ${BUILD_BUILDNUMBER}.tfplan"

  terraform refresh -input=false
  terraform plan -destroy -input=false -out ${BUILD_BUILDNUMBER}.tfplan
fi

rm .terraform -rf