resource "aws_security_group" "eks_cluster_control_plane_sg" {
  name        = "${var.Project}_${var.Environment}_ec1_eks_cluster_control_plane_sg"
  description = "Allow control plane to receive traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    ### Need to restrict
    cidr_blocks  = [var.vpc_cidr]
    description  = "Allow control plane to receive API requests from worker nodes in group m5-euc1"
  }
 egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    ### Need to restrict
    cidr_blocks     = [var.vpc_cidr]
    description     = "Allow control plane to communicate with worker nodes in group m5-euc1 (kubelet and workload TCP ports)"
  }
  egress {
     from_port       = 1025
     to_port         = 65535
     protocol        = "tcp"
     ### Need to restrict
     cidr_blocks     = [var.vpc_cidr]
     description     = "Allow control plane to communicate with worker nodes in group m5-euc1 (workloads using HTTPS port, commonly used with extension API servers)"
   }
  tags = {
        Name                        = var.sg_cluster_name
        Environment                 = var.Environment
        Project                     = var.Project
        Vertical                    = var.Vertical
        Component                   = var.Component
        Subcomponent                = var.Subcomponent
        Resource                    = var.Resource
        Managed                     = var.Managed
  }
}
