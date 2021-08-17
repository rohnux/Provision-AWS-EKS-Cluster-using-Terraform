output "eks_cluster_control_plane_sg_id" {
  value = aws_security_group.eks_cluster_control_plane_sg.id
}
