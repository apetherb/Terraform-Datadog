provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["x.x.x.x/32"]  #cannot leave open to world with DD account
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-06ce3edf0cff21f07"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = "subnet-000aa3bfe30e1a3f5"
  key_name               = "ap1"
  user_data = <<-EOF
              #!/bin/bash
              DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=xxx bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
              EOF
  tags = {
    Name = "terraform-example"
  }
}