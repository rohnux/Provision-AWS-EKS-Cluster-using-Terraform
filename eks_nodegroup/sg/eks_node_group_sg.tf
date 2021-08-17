#########################
resource "aws_security_group" "eks_cluster_node_group_worker_sg" {
  name        = "${var.Project}_${var.Environment}_ec1_eks_cluster_node_group_worker_sg"
  description = "Allow ssh from vpn and office instance inbound traffic"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description     = "Allow worker node to communicate all protocol"
  }

  tags = {
  Name                        = var.sg_nodegroup_name
  Environment                 = var.Environment
  Project                     = var.Project
  Vertical                    = var.Vertical
  Component                   = var.Nodegroup1_Component
  Subcomponent                = var.Subcomponent
  Resource                    = var.Resource
  Managed                     = var.Managed
  "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"

  }
}

resource "aws_security_group_rule" "allow_eks_control_plane_to_worker_https" {
  depends_on = [
    aws_security_group.eks_cluster_node_group_worker_sg
  ]
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id   = var.eks_control_plane_security_group_id
  security_group_id = aws_security_group.eks_cluster_node_group_worker_sg.id
}

resource "aws_security_group_rule" "allow_eks_control_plane_to_worker" {
  depends_on = [
    aws_security_group.eks_cluster_node_group_worker_sg
  ]
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id   = var.eks_control_plane_security_group_id
  security_group_id = aws_security_group.eks_cluster_node_group_worker_sg.id
}



resource "aws_security_group_rule" "allow_eks_control_plane_to_worker_ssh" {
  depends_on = [
    aws_security_group.eks_cluster_node_group_worker_sg
  ]
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.eks_cluster_node_group_worker_sg.id
  description       = "allow ssh to worker from vpc"
}

#### Allowed All communication from Intra security to Worker Nodes
resource "aws_security_group_rule" "allow_eks_allow_sg_intra_lb" {
  depends_on = [
    aws_security_group.eks_cluster_node_group_worker_sg
  ]
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.eks_alb_ingress_intra_sg_id
  security_group_id        = aws_security_group.eks_cluster_node_group_worker_sg.id
}

#### Allowed All communication from private security to  Worker Nodes
resource "aws_security_group_rule" "allow_eks_allow_sg_private_lb" {
  depends_on = [
    aws_security_group.eks_cluster_node_group_worker_sg
  ]
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.eks_alb_ingress_private_sg_id
  security_group_id        = aws_security_group.eks_cluster_node_group_worker_sg.id
}

#### Allowed All communication from Public security to  Worker Nodes
resource "aws_security_group_rule" "allow_eks_allow_sg_public_lb" {
  depends_on = [
    aws_security_group.eks_cluster_node_group_worker_sg
  ]
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.eks_alb_ingress_public_sg_id
  security_group_id        = aws_security_group.eks_cluster_node_group_worker_sg.id
}

##########################
#### Allowed All communication from Restricted Public security to  Worker Nodes
resource "aws_security_group_rule" "allow_eks_allow_sg_restrictedpublic_lb" {
  depends_on = [
    aws_security_group.eks_cluster_node_group_worker_sg
  ]
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.eks_alb_ingress_restricted_public_sg_id
  security_group_id        = aws_security_group.eks_cluster_node_group_worker_sg.id
}


#########################
resource "aws_security_group" "eks_cluster_shared_node_group_worker_sg" {
  name        = "${var.Project}_${var.Environment}_ec1_eks_cluster_shared_node_group_worker_sg"
  description = "Allow ssh from vpn and office instance inbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description     = "Allow worker node to communicate all protocol"
  }
  tags = {
  Name                        = var.sg_nodegroup_name
  Environment                 = var.Environment
  Project                     = var.Project
  Vertical                    = var.Vertical
  Component                   = var.Nodegroup2_Component
  Subcomponent                = var.Subcomponent
  Resource                    = var.Resource
  Managed                     = var.Managed
  }
}

resource "aws_security_group_rule" "allow_eks_worker_to_communicate_self" {
  depends_on = [
    aws_security_group.eks_cluster_shared_node_group_worker_sg
  ]
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id   = aws_security_group.eks_cluster_shared_node_group_worker_sg.id
  security_group_id = aws_security_group.eks_cluster_shared_node_group_worker_sg.id
}
