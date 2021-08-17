data "aws_region" "current" {}

# Fetch OIDC provider thumbprint for root CA
data "external" "thumbprint" {
  program = ["sh","../../../../../dt-tf-modules/eks/eks_nodegroup/iam/oidc-thumbprint.sh", data.aws_region.current.name]
}

resource "aws_iam_openid_connect_provider" "openid_connect" {
  url = var.cluster_oidc_url
  thumbprint_list = [data.external.thumbprint.result.thumbprint]

  client_id_list = [
    "sts.amazonaws.com"
  ]
  tags = {
  Name                        = var.iam_openid_connect_name
  Environment                 = var.Environment
  Project                     = var.Project
  Component                   = var.Component
  Vertical                    = var.Vertical
  Managed                     = var.Managed
  }
}

resource "aws_iam_role" "eks_openid_connect_role" {
  name = "${var.Project}_${var.Environment}_ec1_eks_cluster_openidconnect_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.openid_connect.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${aws_iam_openid_connect_provider.openid_connect.url}:aud" : "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF

  tags = {
  Name                        = var.iam_openid_connect_name
  Environment                 = var.Environment
  Project                     = var.Project
  Vertical                    = var.Vertical
  Component                   = var.Component
  Subcomponent                = var.Subcomponent
  Resource                    = var.Resource
  Managed                     = var.Managed
  }
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_openid_connect_worker" {
  depends_on = [
    aws_iam_policy.eks_worker_node_PolicyAutoScaling
  ]
  role       = aws_iam_role.eks_openid_connect_role.name
  policy_arn = aws_iam_policy.eks_worker_node_PolicyAutoScaling.arn
}
