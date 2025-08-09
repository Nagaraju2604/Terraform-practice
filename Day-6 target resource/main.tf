resource "aws_instance" "name" {
  ami = "ami-08a6efd148b1f7504"
  instance_type = "t2.nano"
  tags = {
    Name = "dev"
  }
}

resource "aws_s3_bucket" "name" {
    bucket = "nagatestterraform"
    
}


#Notes 
# if we have multiple resource blocks as above ec2 s3 if we want to create only one resource then we use 
# --target=aws_s3_bucket.name
#terraform apply -auto-approve --target=aws_s3_bucket.name we can use to destroy aslo
#terraform plan --target=aws_s3_bucket.name
# terraform destroy --target=aws_s3_bucket.name