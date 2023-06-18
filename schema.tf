#resource "null_resource" "load-schema" {
#  depends_on = [aws_rds_cluster.default]
#
#  provisioner "local-exec" {
#    command = <<EOF
#curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
#cd /tmp
#unzip -o mysql.zip
#cd mysql-main
#curl -L -O https://truststore.pki.rds.amazonaws.com/us-east-1/us-east-1-bundle.pem
#mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile us-east-1-bundle.pem --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < catalogue.js
#mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile us-east-1-bundle.pem --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < users.js
#EOF
#  }
#}