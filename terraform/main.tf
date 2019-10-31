#configura o cloud provider, que neste caso é a AWS. 
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credentials}"
  profile = "${var.aws_user_name}"
}

#cria a instância
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

#cria o Key Pair para acessar a instância com a chave pública gerada localmente na máquina (/home/helder/.ssh/id_rsa.pub)
resource "aws_key_pair" "mediawiki_key" {
  key_name = "mediawiki_key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}


#cria o secuity group, com as regras básicas de ingress e egress
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

  # porta do prometheus
  ingress {
    from_port = 9117
    to_port = 9117
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # porta do node_exporter
  ingress {
    from_port = 9100
    to_port = 9100
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

#salva o IP da instância em um arquivo de hosts e executa o ansible
resource "null_resource" "ansible-provision" {
  depends_on = ["aws_instance.mediawiki"]

  provisioner "local-exec" {
    command = "echo \"[mediawiki]\n${aws_instance.mediawiki.public_ip} ansible_user=ubuntu\n\n\n[prometheus]\n54.162.245.143 ansible_user=ubuntu\" > ../playbook/host-terra" #"echo \"[mediawiki]\" > ../playbook/host-terra"
  }

  provisioner "local-exec" {
    command = "echo \"wiki:\n  server: ${aws_instance.mediawiki.public_ip}\" > ../playbook/roles/prometheus/defaults/main.yml" #"echo \"[mediawiki]\" > ../playbook/host-terra"
  }

  # provisioner "local-exec" {
  #   command = "echo \"\n${format("%s ansible_ssh_host=%s", aws_instance.mediawiki.public_ip, "ansible_user=ubuntu")}\" >> ../playbook/host-terra&"
  # }
}


#exibe o IP da instância criada (vai ser usado para rodar o ansible)
output "public_ip" {
  value = "${aws_instance.mediawiki.public_ip}"  
}


#é possível pegar por nome público da instância
# output "example_public_dns" {
#   value = "${aws_instance.mediawiki.example_public_dns}"
# }

