resource "aws_instance" "k8s_master" {
  ami               = var.ami_id
  instance_type     = var.master_instance_type
  subnet_id         = var.subnet_id
  key_name          = var.key_name
  security_groups   = [var.security_group_name]

  tags = {
    Name = "k8s_master-${terraform.workspace}"
  }
}

resource "aws_instance" "k8s_worker" {
  count             = var.worker_count
  ami               = var.ami_id
  instance_type     = var.worker_instance_type
  subnet_id         = var.subnet_id
  key_name          = var.key_name
  security_groups   = [var.security_group_name]

  tags = {
    Name = "k8s_worker-${count.index}-${terraform.workspace}"
  }
}
