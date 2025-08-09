resource "aws_instance" "name" {
  ami = "ami-08a6efd148b1f7504"
  instance_type = "t2.micro"
  user_data = file("test.sh")  #calls test.sh file quotes is required("test.sh")
}