resource "aws_instance" "name" {
  ami = "ami-08a6efd148b1f7504"
  instance_type = "t2.nano"
  tags = {
    Name = "dev"
  }
  depends_on = [ aws_s3_bucket.name ] # if we write this block  we are saying create ec2 after s3 creation only
}

resource "aws_s3_bucket" "name" {
    bucket = "nagatestterraform"
    
}