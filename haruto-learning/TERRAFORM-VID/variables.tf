variable "instance_name" {
    description = "Value of the Name tag for the ECS instance"
    type        = string
    default     = "MyNewInstance"
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type."
  type        = string
  default     = "t2.micro"
}