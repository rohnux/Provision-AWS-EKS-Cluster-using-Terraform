#######################################

resource "aws_iam_policy" "eks_cluster_PolicyCloudWatchMetrics" {
  name        = "${var.Project}_${var.Environment}_eks_cluster_PolicyCloudWatchMetrics"
  description = "Cloudwatch policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudwatch:PutMetricData"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}


#######################################

resource "aws_iam_policy" "ekscluster_PolicyEC2" {
  name        = "${var.Project}_${var.Environment}_ekscluster_PolicyEC2"
  description = "EC2 policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#######################################

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.Project}_${var.Environment}_ec1_eks_cluster_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
}
EOF

  tags = {
     Name                        = var.iam_name
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

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_1" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_2" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_3" {
  depends_on = [
    aws_iam_policy.eks_cluster_PolicyCloudWatchMetrics
  ]
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "${aws_iam_policy.eks_cluster_PolicyCloudWatchMetrics.arn}"
}

resource "aws_iam_role_policy_attachment" "attach_policy_role_eks_cluster_4" {
  depends_on = [
    aws_iam_policy.ekscluster_PolicyEC2
  ]
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "${aws_iam_policy.ekscluster_PolicyEC2.arn}"
}
