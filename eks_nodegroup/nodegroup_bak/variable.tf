variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_profile" {
  default = "dtdl-hgw"
}

variable "eks_cluster_name" {
  default = "Hgw-Perf-Ec1-Eks"
}

variable "vpc_id" {
  default = "vpc-04a19f9e30bd25c50"
}

variable "worker_launch_template_name" {
  default = "hgwPerfEks-nodegroup"
}
variable "worker_disk_size" {
  default = 100
}

variable "worker_volume_type" {
  default = "gp2"
}

variable "eks_worker_ami" {
  default = "ami-0b848077cfb4c8b66"
}

variable "worker_node_instance_type" {
  default = "m5.xlarge"
}

variable "worker_ec2_ssh_key" {
  default = "hgwK8sPerf"
}

variable "instance_initiated_shutdown_behavior" {
  default = "terminate"
}

############## Autoscaling Variables #########################

variable "worker_auto_scaling_name" {
  default = "hgwPerfEks-nodegroup-ondemand"
}

variable "worker_desired_size" {
  default = 4
}

variable "worker_min_size" {
  default = 1
}

variable "worker_max_size" {
  default = 10
}

variable "worker_health_check_grace_period" {
  default = 300
}

variable "worker_health_check_type" {
  default = "EC2"
}

variable "Environment" {
  default = "perf"
}

variable "Accesstype" {
  default = "private"
}

variable "cluster_node_subcomponent" {
  default = "EKS_Worker_Node_SG"
}

variable "shared_subcomponent" {
  default = "EKS_Cluster_Shared_SG"
}


variable "Vertical" {
  default = "operation"
}

variable "Project" {
  default = "hgw"
}

variable "Component" {
  default = "eks"
}

variable "Subcomponent" {
  default = "shared"
}

variable "Resource" {
  default = "autoscaling"
}

variable "Managed" {
  default = "terraform"
}
