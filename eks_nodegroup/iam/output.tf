output "eks_cluster_oidc_provider" {
  value = aws_iam_openid_connect_provider.openid_connect.arn
  }
