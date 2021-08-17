resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.eks_cluster_name
  enabled_cluster_log_types = var.cluster_enabled_cluster_log_types
  version                   = var.cluster_version
  role_arn                  = var.eksClusterRoleArn

  vpc_config {
    subnet_ids              = var.eks_subnet_ids
    security_group_ids      = var.eks_additional_security_group
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }
  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = var.kms_key_arn
    }
  }
  # We explicitly prevent destruction using terraform. Remove this only if you really know what you're doing.
  lifecycle {
    prevent_destroy = true
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  tags = {
      Name                        = var.eks_cluster_name
      Environment                 = var.Environment
      Project                     = var.Project
      Vertical                    = var.Vertical
      Component                   = var.Component
      Subcomponent                = var.Subcomponent
      Resource                    = var.Resource
      Managed                     = var.Managed
  }
}
