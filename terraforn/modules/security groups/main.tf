resource "aws_security_group" "k8s_node_sg" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for Kubernetes nodes"
  vpc_id      = var.vpc_id

  # Allow inbound SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.cluster_name}-node-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.cluster_name}-lb-sg"
  description = "Security group for Kubernetes Load Balancer"
  vpc_id      = var.vpc_id

  # Allow inbound HTTP and HTTPS
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.cluster_name}-lb-sg"
    Environment = var.environment
  }
}
