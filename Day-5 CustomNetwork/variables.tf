variable "publicami"  {
    description = "testing varibales" # this is optional 
    type= string
    default = ""
   
}
variable "publictype"  {
    description = "testing varibales" # this is optional 
    type= string
    default = ""
}

variable "privateami"  {
    description = "testing varibales" # this is optional 
    type= string
    default = ""
   
}
variable "privatetype"  {
    description = "testing varibales" # this is optional 
    type= string
    default = ""
}

variable "vpc_name" {
  description = "customvpc"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""  # Optional default
}

variable "public_subnet_cidr" {
  
  type        = string
  default = ""
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}