module "name" {
  source = "../Day-7 module-source"
  ami-id = "ami-08a6efd148b1f7504"
  instance_type = "t2.micro"
  tag="dev"

}