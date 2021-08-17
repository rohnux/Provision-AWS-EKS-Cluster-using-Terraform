variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  default = ""
}

variable "eks_cluster_name" {
 default = ""
}

variable "eksNodeRoleArn" {
  default = ""
}

variable "node_group_name" {
   default = ""
}

variable "node_group_name_prefix" {
   default = ""
}

variable "worker_launch_template_name" {
  default = ""
}

variable "eks_node_subnet_ids" {
  default = ""
}

variable "worker_node_disk_size" {
  default = ""
}

variable "worker_node_disk_type" {
  default = ""
}

variable "worker_node_volume_type" {
  default = ""
}

variable "worker_node_instance_type" {
  default = ""
}

variable "node_desired_size" {
  default = ""
}

variable "node_max_size" {
  default = ""
}

variable "node_min_size" {
  default = ""
}

variable "worker_node_ami_id" {
  default = ""
}

variable "worker_node_ami_type" {
  default = ""
}

variable "worker_ec2_ssh_key" {
  default = ""
}

variable "source_security_group_ids" {
  default = ""
}

variable kms_key_arn {
  default = ""
}

variable "encrypted" {
 default = ""
}


variable "Environment" {
  default = ""
}

variable "Vertical" {
  default = ""
}

variable "Project" {
  default = ""
}

variable "Component" {
  default = ""
}

variable "Subcomponent" {
  default = ""
}

variable "Resource" {
  default = ""
}

variable "Managed" {
  default = ""
}
