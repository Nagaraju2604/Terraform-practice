resource "aws_instance" "name" {
  ami = "ami-08a6efd148b1f7504"
  instance_type = "t2.nano"
  tags = {
    Name = "dev"
  }

  lifecycle {
    #prevent_destroy = true 
    # create_before_destroy = true
    ignore_changes = [ tags]

  }
}

#Notes : 3 life cycle rules
 #prevent_destroy = true 
#false/true # it will stop deleting resources if we 
#apply destroy also this acts resource wise for each resource 
#block we need to write if required

#create_before_destroy = true  by default terraform deltes the existing and create new but if we add this it will create then destroy

#ignore_changes = [ tags,] if some one modify any value for ex: tags .. if we worte this block declare what we want ignore so that chnages wont get modified