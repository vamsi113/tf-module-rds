resource "aws_rds_cluster" "default" {
  depends_on                      = [aws_rds_cluster_parameter_group.default, aws_db_subnet_group.default]
  cluster_identifier              = "${var.env}-${var.name}-roboshop-rds"
  engine                          = var.engine
  engine_version                  = var.engine_version
  database_name                   = "mydb"
  master_username                 = local.RDS_USER
  master_password                 = local.RDS_PASS
  skip_final_snapshot             = var.skip_final_snapshot
  #db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.name
  db_subnet_group_name            = "${var.env}-${var.name}-roboshop-rds"
  vpc_security_group_ids          = [aws_security_group.sg.id]
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "${var.env}-${var.name}-roboshop-rds"
  family      = "aurora5.6"
  description = "RDS default cluster parameter group"
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.env}-${var.name}-roboshop-rds"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${var.name}-roboshop-rds"
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  for_each = var.nodes
  identifier         = "${var.env}-${var.name}-rds-${each.key}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = each.value.instance_class
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}