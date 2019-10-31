variable "aws_user_name" {default = "terraform"}
variable "aws_region" {default = "us-east-1"}
variable "aws_credentials" {default = ".aws/credentials"}


variable "aws_ami" {
  default = "ami-0d5ae5525eb033d0a"
}

variable "aws_type" {
  default = "t2.micro"
}

variable "ssh_user_name" {
  default = "ubuntu"
}
