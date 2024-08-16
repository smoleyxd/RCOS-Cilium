#configures Virtual Private Cloud (VPC) and other networking components in AWS

#creates a VPC in AWS
resource "aws_vpc" "k8s_vpc" {
  cidr_block = var.vpc_cidr #specifies IP address range for VPC

  tags = {
    Name = "k8s-vpc" #provides a name tag for the VPC to identify it in AWS management conosole
  }
}

#creates subnets within the VPC to segmnet its network
resource "aws_subnet" "k8s_subnet" {
  count = length(var.subnet_cidrs) #creates number of subnets based on number of CIDR blocks provided
  vpc_id            = aws_vpc.k8s_vpc.id #associates subnet with the VPC created earlier
  cidr_block        = element(var.subnet_cidrs, count.index) #specifies IP address range for the subnet, selected from the list of CIDR blocks provided in var.subnet_cidrs with 'element' used to get the CIDR block corresponding to the current subnet index
  availability_zone = element(data.aws_availability_zones.available.names, count.index) #provides a list of availability zones, element selects the zone based off curretn index

  tags = {
    Name = "k8s-subnet-${count.index}" #provides a name tag for each subnet, using the index to differentiate them
  }
}

#creates a security group to control inbound and outbound traffic resources in the VPC
resource "aws_security_group" "k8s_sg" {
  vpc_id = aws_vpc.k8s_vpc.id #associates the security group with the VPC created earlier

  ingress { #defines the rules for inbound traffic
    from_port   = 80 #allows HTTP traffic from any IP address
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { 
    from_port   = 443 #allows HTTPS traffic from any IP address
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #defines the rules for outbound traffic; allows all outbound traffic
    from_port   = 0 
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-security-group"
  }
}

#outputs the ID of the VPC
output "vpc_id" {
  value = aws_vpc.k8s_vpc.id
}

#outputs the IDs of the subnets created
output "subnet_ids" {
  value = aws_subnet.k8s_subnet[*].id #collects al lsubnet IDs into a list
}
