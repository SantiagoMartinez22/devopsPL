# ############# VPC ##############

# resource "aws_vpc" "vpc_itm_wordpress" {
#   cidr_block = var.vpc_cidr
#   instance_tenancy = "default"
#   enable_dns_hostnames = true
#   enable_dns_support = true
#   tags = {
#     Name = var.vpc_name
#   }
# }

# ############# Subnets #############

# resource "aws_subnet" "subnet_itm_wordpress_1" {
#   vpc_id = aws_vpc.vpc_itm_wordpress.id
#   cidr_block = var.subnet_1_cidr
#   availability_zone = "us-east-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = var.subnet_1_name
#   }
#   depends_on = [
#     aws_vpc.vpc_itm_wordpress
#   ]
# }

# resource "aws_subnet" "subnet_itm_wordpress_2" {
#   vpc_id = aws_vpc.vpc_itm_wordpress.id
#   cidr_block = var.subnet_2_cidr
#   availability_zone = "us-east-1c"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = var.subnet_2_name
#   }
#   depends_on = [
#     aws_vpc.vpc_itm_wordpress
#   ]
# }

# ############# Internet Gateway #############

# resource "aws_internet_gateway" "ig_itm_wordpress" {
#   vpc_id = aws_vpc.vpc_itm_wordpress.id
#   depends_on = [
#       aws_vpc.vpc_itm_wordpress
#     ]
# }

# ############# Route Table #############

# resource "aws_route_table" "rt_itm_wordpress" {
#   vpc_id = aws_vpc.vpc_itm_wordpress.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.ig_itm_wordpress.id
#   }
#  depends_on = [
#       aws_internet_gateway.ig_itm_wordpress
#     ]
# }

# resource "aws_main_route_table_association" "rt_association_itm_wordpress" {
#   route_table_id = aws_route_table.rt_itm_wordpress.id
#   vpc_id         = aws_vpc.vpc_itm_wordpress.id
# }


## main tf ###

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = var.subnet_1_name
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = var.subnet_2_name
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "ec2_wordpress_subnet_id" {
  value = aws_subnet.subnet_1.id
}

output "ec2_wordpress_subnet_id_2" {
  value = aws_subnet.subnet_2.id
}