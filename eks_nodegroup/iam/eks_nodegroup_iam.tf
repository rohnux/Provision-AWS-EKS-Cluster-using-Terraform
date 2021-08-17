#######################################

resource "aws_iam_policy" "eks_worker_node_PolicyALBingressController" {
  name        = "${var.Project}_${var.Environment}_ec1_eks_worker_node_PolicyALBingressController"
  description = "eks node  policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "acm:DescribeCertificate",
              "acm:ListCertificates",
              "acm:GetCertificate"
          ],
          "Resource": "*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "ec2:AuthorizeSecurityGroupIngress",
              "ec2:CreateSecurityGroup",
              "ec2:CreateTags",
              "ec2:DeleteTags",
              "ec2:DeleteSecurityGroup",
              "ec2:DescribeAccountAttributes",
              "ec2:DescribeAddresses",
              "ec2:DescribeInstances",
              "ec2:DescribeInstanceStatus",
              "ec2:DescribeInternetGateways",
              "ec2:DescribeNetworkInterfaces",
              "ec2:DescribeSecurityGroups",
              "ec2:DescribeSubnets",
              "ec2:DescribeTags",
              "ec2:DescribeVpcs",
              "ec2:ModifyInstanceAttribute",
              "ec2:ModifyNetworkInterfaceAttribute",
              "ec2:RevokeSecurityGroupIngress"
          ],
          "Resource": "*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "elasticloadbalancing:AddListenerCertificates",
              "elasticloadbalancing:AddTags",
              "elasticloadbalancing:CreateListener",
              "elasticloadbalancing:CreateLoadBalancer",
              "elasticloadbalancing:CreateRule",
              "elasticloadbalancing:CreateTargetGroup",
              "elasticloadbalancing:DeleteListener",
              "elasticloadbalancing:DeleteLoadBalancer",
              "elasticloadbalancing:DeleteRule",
              "elasticloadbalancing:DeleteTargetGroup",
              "elasticloadbalancing:DeregisterTargets",
              "elasticloadbalancing:DescribeListenerCertificates",
              "elasticloadbalancing:DescribeListeners",
              "elasticloadbalancing:DescribeLoadBalancers",
              "elasticloadbalancing:DescribeLoadBalancerAttributes",
              "elasticloadbalancing:DescribeRules",
              "elasticloadbalancing:DescribeSSLPolicies",
              "elasticloadbalancing:DescribeTags",
              "elasticloadbalancing:DescribeTargetGroups",
              "elasticloadbalancing:DescribeTargetGroupAttributes",
              "elasticloadbalancing:DescribeTargetHealth",
              "elasticloadbalancing:ModifyListener",
              "elasticloadbalancing:ModifyLoadBalancerAttributes",
              "elasticloadbalancing:ModifyRule",
              "elasticloadbalancing:ModifyTargetGroup",
              "elasticloadbalancing:ModifyTargetGroupAttributes",
              "elasticloadbalancing:RegisterTargets",
              "elasticloadbalancing:RemoveListenerCertificates",
              "elasticloadbalancing:RemoveTags",
              "elasticloadbalancing:SetIpAddressType",
              "elasticloadbalancing:SetSecurityGroups",
              "elasticloadbalancing:SetSubnets",
              "elasticloadbalancing:SetWebACL"
          ],
          "Resource": "*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "iam:CreateServiceLinkedRole",
              "iam:GetServerCertificate",
              "iam:ListServerCertificates"
          ],
          "Resource": "*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "cognito-idp:DescribeUserPoolClient"
          ],
          "Resource": "*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "waf-regional:GetWebACLForResource",
              "waf-regional:GetWebACL",
              "waf-regional:AssociateWebACL",
              "waf-regional:DisassociateWebACL"
          ],
          "Resource": "*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "tag:GetResources",
              "tag:TagResources"
          ],
          "Resource": "*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "waf:GetWebACL"
          ],
          "Resource": "*"
      }
  ]
}
EOF
}

resource "aws_iam_policy" "eks_worker_node_PolicyAutoScaling" {
  name        = "${var.Project}_${var.Environment}_ec1_eks_worker_node_PolicyAutoScaling"
  description = "EKS worker node auto scaling policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "autoscaling:DescribeAutoScalingGroups",
              "autoscaling:DescribeAutoScalingInstances",
              "autoscaling:DescribeLaunchConfigurations",
              "autoscaling:DescribeTags",
              "autoscaling:SetDesiredCapacity",
              "autoscaling:TerminateInstanceInAutoScalingGroup",
              "ec2:DescribeLaunchTemplateVersions"
          ],
          "Resource": "*",
          "Effect": "Allow"
      },
      {
          "Effect": "Allow",
          "Action": [
               "kms:Encrypt",
               "kms:Decrypt",
               "kms:ReEncrypt*",
               "kms:GenerateDataKey*",
               "kms:DescribeKey",
               "kms:CreateGrant"
          ],
          "Resource": "${var.kms_key_arn}"
      }

  ]
}
EOF
}

#######################################

resource "aws_iam_role" "eks_node_role" {
  name = "${var.Project}_${var.Environment}_ec1_eks_node_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
  Name                        = var.iam_worker_name
  Environment                 = var.Environment
  Project                     = var.Project
  Vertical                    = var.Vertical
  Component                   = var.Component
  Subcomponent                = var.Subcomponent
  Resource                    = var.Resource
  Managed                     = var.Managed
  }
}



#######################################

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_worker_1" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_worker_2" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_worker_3" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_worker_4" {
  depends_on = [
    aws_iam_policy.eks_worker_node_PolicyALBingressController
  ]
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.eks_worker_node_PolicyALBingressController.arn
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_worker_5" {
  depends_on = [
    aws_iam_policy.eks_worker_node_PolicyAutoScaling
  ]
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.eks_worker_node_PolicyAutoScaling.arn
}

resource "aws_iam_instance_profile" "eks-instance-role" {
  name = "${var.Project}_${var.Environment}_ec1_eks_instance_role"
  role = aws_iam_role.eks_node_role.name
}
