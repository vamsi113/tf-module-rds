resource "null_resource" "load-schema" {
  depends_on = [aws_rds_cluster.default, aws_rds_cluster_instance.cluster_instances, aws_rds_cluster_parameter_group.default,aws_db_subnet_group.default]

  provisioner "local-exec" {
    command = <<EOF
sleep 60
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
cd /tmp
unzip -o mysql.zip
cd mysql-main
mysql -h ${aws_rds_cluster.default.endpoint} -u${local.RDS_USER} -p${local.RDS_PASS} <shipping.sql
EOF
  }
}