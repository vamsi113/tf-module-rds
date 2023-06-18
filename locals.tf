locals {
  RDS_USER = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["RDS_USER"]
  RDS_PASS = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["RDS_PASS"]
}