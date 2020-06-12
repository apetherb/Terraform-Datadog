resource "aws_security_group" "ecs-securitygroup" {
  vpc_id      = "vpc-xxx"
  name        = "ecs"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.myapp-elb-securitygroup.id]
  }
    ingress {
    from_port       = 8125
    to_port         = 8125
    protocol        = "tcp"
    security_groups = [aws_security_group.myapp-elb-securitygroup.id]
  }
    ingress {
    from_port       = 8126
    to_port         = 8126
    protocol        = "tcp"
    security_groups = [aws_security_group.myapp-elb-securitygroup.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["x.x.x.x/32"]
  }
  tags = {
    Name = "ecs"
  }
}

resource "aws_security_group" "myapp-elb-securitygroup" {
  vpc_id      = "vpc-xxx"
  name        = "myapp-elb"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["x.x.x.x/32"]
  }
  tags = {
    Name = "myapp-elb"
  }
}

resource "aws_security_group" "dd-agent-elb-securitygroup" {
  vpc_id      = "vpc-xxx"
  name        = "dd-agent-elb"
  description = "security group for dd-agent"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port       = 8125
    to_port         = 8125
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs-securitygroup.id]
  }
    ingress {
    from_port       = 8126
    to_port         = 8126
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs-securitygroup.id]
  }
  tags = {
    Name = "dd-agent-elb"
  }
}
