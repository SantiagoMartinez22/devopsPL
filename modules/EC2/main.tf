
# ############# Security Group #############

# resource "aws_security_group" "sgr_itm_wordpress" {
#   name = "sgr_itm_wordpress"
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

# ############# EC2 Wordpress Instance #############
# resource "aws_instance" "ec2_itm_wordpress" {
#   ami = var.ec2_wordpress_ami
#   instance_type = var.ec2_wordpress_type
#   count = var.ec2_wordpress_quantity
#   subnet_id = var.ec2_wordpress_subnet_id
#   key_name = var.aws_keypair
#   security_groups = [aws_security_group.sgr_itm_wordpress.id]
#   user_data = var.ec2_wordpress_user_data
#   tags = {
#     Name = var.ec2_wordpress_name
#   }
#   } 


  
  #### New Modulo EC2 ######

resource "aws_instance" "wordpress" {
  count         = var.ec2_wordpress_quantity
  ami           = var.ec2_wordpress_ami
  instance_type = var.ec2_wordpress_type
  subnet_id     = var.ec2_wordpress_subnet_id
  key_name      = var.aws_keypair
  user_data     = var.ec2_wordpress_user_data

  vpc_security_group_ids = [
    aws_security_group.wordpress.id
  ]

  tags = {
    Name = "${var.ec2_wordpress_name}-${count.index}"
  }
}

resource "aws_security_group" "wordpress" {
  name        = "wordpress-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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