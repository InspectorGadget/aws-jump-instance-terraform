variable "vpc_id" {
  description = "The VPC ID to deploy the resources into"
  type        = string
}

variable "public_subnet_id" {
  description = "The public subnet ID to deploy the resources into"
  type        = string
}

variable "ssh_keyname" {
  description = "The SSH keyname to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the instances"
  type        = string
  default     = "t2.micro"
}
