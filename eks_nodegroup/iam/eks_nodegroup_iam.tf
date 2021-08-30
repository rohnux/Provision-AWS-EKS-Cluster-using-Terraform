#######################################

resource "aws_iam_policy" "eks_worker_node_PolicyALBingressController" {
  name        = "${var.Project}_${var.Environment}_ec1_eks_worker_node_PolicyALBingressController"
  description = "eks node  policy"

  policy = <<EOF
{

  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "VisualEditor0",
          "Effect": "Allow",
          "Action": [
              "ec2:AuthorizeSecurityGroupIngress",
              "elasticloadbalancing:ModifyListener",
              "ec2:DescribeInstances",
              "iam:ListServerCertificates",
              "elasticloadbalancing:RegisterTargets",
              "elasticloadbalancing:SetIpAddressType",
              "ec2:DescribeInternetGateways",
              "elasticloadbalancing:DeleteLoadBalancer",
              "elasticloadbalancing:SetWebACL",
              "elasticloadbalancing:SetWebAcl",
              "waf-regional:GetWebACLForResource",
              "elasticloadbalancing:DescribeLoadBalancers",
              "acm:GetCertificate",
              "waf-regional:GetWebACL",
              "elasticloadbalancing:CreateRule",
              "ec2:DescribeAccountAttributes",
              "elasticloadbalancing:AddListenerCertificates",
              "elasticloadbalancing:ModifyTargetGroupAttributes",
              "waf:GetWebACL",
              "iam:GetServerCertificate",
              "ec2:CreateTags",
              "ec2:ModifyNetworkInterfaceAttribute",
              "elasticloadbalancing:CreateTargetGroup",
              "elasticloadbalancing:DeregisterTargets",
              "ec2:RevokeSecurityGroupIngress",
              "elasticloadbalancing:DescribeLoadBalancerAttributes",
              "elasticloadbalancing:DescribeTargetGroupAttributes",
              "acm:DescribeCertificate",
              "elasticloadbalancing:ModifyRule",
              "elasticloadbalancing:AddTags",
              "elasticloadbalancing:DescribeRules",
              "ec2:DescribeSubnets",
              "elasticloadbalancing:ModifyLoadBalancerAttributes",
              "waf-regional:AssociateWebACL",
              "ec2:DescribeAddresses",
              "tag:GetResources",
              "ec2:DeleteTags",
              "elasticloadbalancing:RemoveListenerCertificates",
              "tag:TagResources",
              "elasticloadbalancing:RemoveTags",
              "elasticloadbalancing:CreateListener",
              "ec2:DescribeNetworkInterfaces",
              "elasticloadbalancing:DescribeListeners",
              "ec2:CreateSecurityGroup",
              "acm:ListCertificates",
              "elasticloadbalancing:DescribeListenerCertificates",
              "ec2:ModifyInstanceAttribute",
              "cognito-idp:DescribeUserPoolClient",
              "elasticloadbalancing:DeleteRule",
              "ec2:DescribeInstanceStatus",
              "elasticloadbalancing:DescribeSSLPolicies",
              "elasticloadbalancing:CreateLoadBalancer",
              "waf-regional:DisassociateWebACL",
              "ec2:DescribeTags",
              "elasticloadbalancing:DescribeTags",
              "elasticloadbalancing:SetSubnets",
              "elasticloadbalancing:DeleteTargetGroup",
              "ec2:DescribeSecurityGroups",
              "iam:CreateServiceLinkedRole",
              "ec2:DescribeVpcs",
              "ec2:DeleteSecurityGroup",
              "elasticloadbalancing:DescribeTargetHealth",
              "elasticloadbalancing:SetSecurityGroups",
              "elasticloadbalancing:DescribeTargetGroups",
              "elasticloadbalancing:ModifyTargetGroup",
              "elasticloadbalancing:DeleteListener"
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
