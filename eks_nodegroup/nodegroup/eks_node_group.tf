resource "aws_launch_template" "eks_worker_node_ondemand_lt" {
  name               = var.worker_launch_template_name
  block_device_mappings {
    device_name      = "/dev/xvda"

    ebs {
      volume_size    = var.worker_node_disk_size
      delete_on_termination = true
      encrypted      = var.encrypted
      kms_key_id     = var.kms_key_arn
    }
  }
     instance_type  = var.worker_node_instance_type
     key_name       = var.worker_ec2_ssh_key
     monitoring {
      enabled = false
     }
   vpc_security_group_ids = var.source_security_group_ids # mention SG in launch template only not in Nodegroup

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.Project}-${var.Environment}-Ec1-Eks-Worker-Node"
      Environment                 = var.Environment
      Project                     = var.Project
      Vertical                    = var.Vertical
      Component                   = var.Component
      Subcomponent                = var.Subcomponent
      Resource                    = var.Resource
      Managed                     = var.Managed
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
##############################
resource "aws_eks_node_group" "eks_worker_node" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.node_group_name
# node_group_name_prefix = var.node_group_name_prefix
  node_role_arn   = var.eksNodeRoleArn
  subnet_ids      = var.eks_node_subnet_ids

#  disk_size       = var.worker_node_disk_size # Can we used either in template or in node group not in both
#  instance_types  = [var.worker_node_instance_type]

  ami_type        = var.worker_node_ami_type

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [scaling_config.0.desired_size]
  }

 ### If using customized launch_template
  launch_template {
    id      = "${aws_launch_template.eks_worker_node_ondemand_lt.id}"
    version = "$Latest"
    }

tags = {
    Name                        = var.node_group_name
    Environment                 = var.Environment
    Project                     = var.Project
    Vertical                    = var.Vertical
    Component                   = var.Component
    Subcomponent                = var.Subcomponent
    Resource                    = var.Resource
    Managed                     = var.Managed
 }
}
