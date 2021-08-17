variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  default = ""
}

variable "eks_cluster_name" {
 default = ""
}

variable "cluster_enabled_cluster_log_types" {
  description = "List of log types to be enabled, availabe log types are - api, audit, authenticator, controllerManager, scheduler"
  default     = ""
}

variable "cluster_version" {
  default = ""
}

variable "eksClusterRoleArn" {
  default = ""
}

variable "eks_subnet_ids" {
  default = ""
}

variable "eks_additional_security_group" {
  default = ""
}


variable "cluster_endpoint_private_access" {
  default = ""
}

variable "cluster_endpoint_public_access" {
  default = ""
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  default     = ""
}

variable kms_key_arn {
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
