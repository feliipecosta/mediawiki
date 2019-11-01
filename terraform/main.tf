#Configure provider 
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credentials}"
  profile = "${var.aws_user_name}"
}

#Create Instance - Ubuntu 18.04 LTS
resource "aws_instance" "mediawiki" {
  ami = "${var.aws_ami}"
  instance_type = "${var.aws_type}"
  key_name = "${aws_key_pair.mediawiki_key.key_name}"
  security_groups = ["${aws_security_group.mediawiki_sec.name}"]
  tags = {
    Name = "mediawiki"
  }
  associate_public_ip_address = true
}

#Create key-pair (using local machine key)
resource "aws_key_pair" "mediawiki_key" {
  key_name = "mediawiki_key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}


#Create security group
resource "aws_security_group" "mediawiki_sec" {
  name = "mediawiki_sec"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]    
  }
}

#Create ansible hosts file (if you're not using ubuntu ami change ansible_user)
resource "null_resource" "ansible-provision" {
  depends_on = ["aws_instance.mediawiki"]

  provisioner "local-exec" {
    command = "echo \"[mediawiki]\n${aws_instance.mediawiki.public_ip} ansible_user=ubuntu\" > ../playbook/host-terra"
  }
}

# Gives public ip output
output "public_ip" {
  value = "${aws_instance.mediawiki.public_ip}"  
}