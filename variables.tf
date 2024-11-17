variable "ami" {
   type = string
   default = "ami-0d64bb532e0502c46"
}

variable "az" {
   type = string
   default = "eu-west-1a" 
}

variable "dbport" {
   type = number
   default = 3306 
}

variable "typeofinstance" {
   type = string
   default = "t2.small" 
}

variable "dbsize" {
   type = number
   default = 10
}

variable "keyname" {
   type = string
   default = "jenkins" 
}

