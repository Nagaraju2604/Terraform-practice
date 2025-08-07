#provider "aws" {
 # region = "us-east-1" if you add this block it wil  take latest version and terraform versiuon should be =above 1.0.0
#}

terraform {
  required_version = "~>1.12.2"     #this is terraform version in our local
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"      #if you want to upgrade to latest version add this block and run terraform init --upgrade #thisis plugin version
    }
  }
  }

   