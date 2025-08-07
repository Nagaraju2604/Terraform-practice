terraform {
  backend "s3" {
    bucket = "veeranaga"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
