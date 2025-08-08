#creation of vpc
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    tags ={
      Name = var.vpc_name  
    }
     
    }
  

#creation of subnet-1
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr
  
}

#
  # creation of internet gateway
  resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.vpc.id
     tags={
        Name = "custom-ig"
     }
    
  }
# creation of route table
 resource "aws_route_table" "rt" {
    vpc_id= aws_vpc.vpc.id

    tags ={
        Name = "custom-rt-1"
    }
    route  {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.IG.id
    }
   
 }
 #subnet Association
 resource "aws_route_table_association" "Association" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.rt.id
   
 }
 #creation of security groups
 resource "aws_security_group" "sg" {
    tags ={
        Name = "sg-1"
    }
    vpc_id = aws_vpc.vpc.id
    description = "created from terraform"
    ingress  {
        from_port = 80
        to_port =80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress  {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
   
 }
 #creation of EC2 
 resource "aws_instance" "public-ec2" {
    ami = var.publicami
    instance_type = var.publictype
    subnet_id = aws_subnet.public.id
    security_groups = [aws_security_group.sg.id]


   
 }
 # creation elastic ip 
 resource "aws_eip" "eip" {
  #vpc_id = true  # required for EC2 in a VPC
  tags =  {
    Name = "EIP for bastion"
  }
}
# associate to ec2 
  resource "aws_eip_association" "BEIP" {
    instance_id   = aws_instance.public-ec2.id
    allocation_id = aws_eip.eip.id
}
    
 #creation of private subnet
  resource "aws_subnet" "private" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr 
    tags = {
        Name = "prvt-subnet"
    }
    
  }
  


# creation of nat ip for nat gateway
  resource "aws_eip" "EIP" {
  #vpc_id = true  # required for EC2 in a VPC
  tags =  {
    Name = "EIP for Nat Gateway"
  }
}

#creation of natgateway 
resource "aws_nat_gateway" "natgateway" {
    subnet_id = aws_subnet.public.id
    connectivity_type = "public"
    allocation_id = aws_eip.EIP.id
  
}
 
 #creation of private rt
 resource "aws_route_table" "prt" {
    vpc_id = aws_vpc.vpc.id
     tags = {
         Name ="prvt-rt"

     }
      route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.natgateway.id
      }
   
 }
 # private route table association
 resource "aws_route_table_association" "aprvt1" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.prt.id
   
 }

 # creation of secuirty groups 
 resource "aws_security_group" "psg" {
    tags = {
      Name = "private sg"
    }
   description =  "private sg test"
   vpc_id = aws_vpc.vpc.id
   ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
   }
 }

 #creation of private ec2
 resource "aws_instance" "privateec2" {
    ami = var.privateami
    instance_type = var.privatetype
    subnet_id = aws_subnet.private.id
    vpc_security_group_ids = [aws_security_group.psg.id]  
 }