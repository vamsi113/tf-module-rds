resource "aws_security_group" "sg" {
  name        = "${var.env}-${var.name}-rds.sg"
  description = "${var.env}-${var.name}-rds.sg"
  vpc_id      = var.vpc_id

  ingress {
    description = "MYSQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr, var.BASTION_NODE]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-rds.sg"
  }
}