#!/usr/bin/env bash

cd /tmp

wget -O terraform.zip "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip"
unzip terraform.zip
chmod +x terraform
sudo mv --force terraform /usr/local/bin
terraform --version
rm terraform.zip