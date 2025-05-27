# resource "aws_db_subnet_group" "sng_dbjampy" {
#   name = var.rds_sng_name
#   subnet_ids = [var.ec2_wordpress_subnet_id, var.ec2_wordpress_subnet_id_2]
# }

# resource "aws_security_group" "sgr_dbjampy" {
#   name = "sgr_dbjampy"
#   vpc_id = var.vpc_id
#   ingress {
#     protocol  = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port = 0
#     to_port = 0
#   }
#   egress {
#     from_port = 0
#     protocol  = "-1"
#     to_port   = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_db_instance" "dbjampy" {
#   db_name = var.rds_dbname
#   engine = var.rds_engine
#   engine_version = var.rds_engine_version
#   instance_class = var.rds_instance_class
#   db_subnet_group_name = aws_db_subnet_group.sng_dbjampy.name
#   allocated_storage = var.rds_allocated_storage
#   username = var.rds_username
#   password = var.rds_password
#   parameter_group_name = var.rds_parameter_group_name
#   vpc_security_group_ids = [aws_security_group.sgr_dbjampy.id]
#   publicly_accessible = true
#   skip_final_snapshot = true
#   depends_on = [
#     aws_security_group.sgr_dbjampy
#   ]
# }

##new RDS ####

resource "aws_db_subnet_group" "wordpress" {
  name       = var.rds_sng_name
  subnet_ids = [var.ec2_wordpress_subnet_id, var.ec2_wordpress_subnet_id_2]

  tags = {
    Name = "wordpress-db-subnet-group"
  }
}

resource "aws_db_instance" "wordpress" {
  identifier             = "wordpress-db"
  db_name                = var.rds_dbname
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = var.rds_parameter_group_name
  db_subnet_group_name   = aws_db_subnet_group.wordpress.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
}

resource "aws_security_group" "rds" {
  name        = "wordpress-rds-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}