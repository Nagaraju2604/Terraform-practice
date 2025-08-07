terraform {
  backend "s3" {
    bucket = "veeranaga1"
    key    = "terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = "true" #s3 supports this feature but terraform version should be >1.10 use of this when two persons run terraform apply it will take the fist apply unyil it completes next devloper apply wont work
    dynamodb_table = "value" # this works same as use_lockfile which is used previously for this we need to create dynamodb table with partitionkey as LockID
    encrypt = true 
  }
}