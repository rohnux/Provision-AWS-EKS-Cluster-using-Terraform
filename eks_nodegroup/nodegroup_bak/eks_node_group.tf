#### User data for worker launch

locals {
  eks-node-private-userdata = <<USERDATA
IyEvYmluL2Jhc2gKc2V0IC1leApCNjRfQ0xVU1RFUl9DQT1MUzB0TFMxQ1JVZEpUaUJEUlZKVVNVWkpRMEZVUlMwdExTMHRDazFKU1VONVJFTkRRV0pEWjBGM1NVSkJaMGxDUVVSQlRrSm5hM0ZvYTJsSE9YY3dRa0ZSYzBaQlJFRldUVkpOZDBWUldVUldVVkZFUlhkd2NtUlhTbXdLWTIwMWJHUkhWbnBOUWpSWVJGUkpkMDFFWjNsT2FrVXhUa1JKZDA1R2IxaEVWRTEzVFVSbmVVNUVSVEZPUkVsM1RrWnZkMFpVUlZSTlFrVkhRVEZWUlFwQmVFMUxZVE5XYVZwWVNuVmFXRkpzWTNwRFEwRlRTWGRFVVZsS1MyOWFTV2gyWTA1QlVVVkNRbEZCUkdkblJWQkJSRU5EUVZGdlEyZG5SVUpCUzB4RENtNUtjVU5NVDBSd2RsZHZUbWxpY2twTk5WZElhWEJvWWtWRWIyaDZXbHBQVDBGNFluZEhNM3A1YjNGWVNVNXJjbkpZTmpZelRXUktPR3Q0WVVaaU0wZ0tWVUpXY2tsVlVUbFdSRklyTjJWc0sxbHdNR3BwVURWeVluWnFNMmMyUjFwWWFrbFlPSEZ0ZDJsSU9DdGtSMjFLYmxOMGN6Y3JOVFZtWm1OSFRtTTFUQW8xZWxCT2REZHpXV3B4VDJ4UU9FdDRjVU14TXpnM1RHaDNWM0pzY0c5UlJqWklhR1F5ZVRWcEszZGhURkppUVd0SWVXNUdjVk50V1M5alZuWlNWSFJpQ25CUFMwSkdhRlZPUkVFNE5HVnZRMEZ4VjNKemVuVTVUU3RYV1VoelUxSktkVEJyWkZOS1NHVkdiMjFEYVZWcGVXcHVZamRRWldaSllWVmhWa1JrYlhJS1EzTnFUMHhtWkVoc1YybzBabkJSVDFrclprcDZWR0pSY0ZRM1IzRXhiM2RxVGpGV1Ftd3lRM1E1U0V3NWJHOTJWVVV3UnpoVE4wbE1SbkZCYW5oa01Rb3ZPRGR5Vm13MVJTdEVNMlp3V1Voa0t6VlZRMEYzUlVGQllVMXFUVU5GZDBSbldVUldVakJRUVZGSUwwSkJVVVJCWjB0clRVRTRSMEV4VldSRmQwVkNDaTkzVVVaTlFVMUNRV1k0ZDBSUldVcExiMXBKYUhaalRrRlJSVXhDVVVGRVoyZEZRa0ZLYVhRME5ucGhSR2czTkVjclpXMU5VazU2Y2t0elZXbHBhbmdLU1M5dVowaHpaMmxtS3pWRVMyZHlTVEo1WlhRM2RVVnZWMEpsYVZGNWRtMTRjVzh5VFVNME1HcDZZVTlNTjNOVWVVTXpZbkJUVTNKMWNEZGFWRmRrVlFwSFpYVjVOM2RrVjFsMlIyVnRPSGxMY25CUkswVnBRVlV4TlZSdE0wTmpSbEE0TUhoSU4wRnNSMDFFZVdKUmJIcFdOMXB5Vm05d1dHdElaVVpSWmtOR0Nsa3habGxVU2xKU2JFeHhSMG93WW5kclRqZE1ZMFJMTkhONGVrTldSelZyZHpoV2FESnhOVzl6Ym1VNFJ5OWFaR2gzVlhSYWJETlFhUzlRWlVSeVYyY0tRM05CYml0U1lXSlVkU3QzVG1FemFtRkZSMjlvWm1KcmQwRldhMDkzUVU5dWJHbDFOMGxEVWxsd2NWZHdiSGRYV0N0eFEzRlJZME50V21aeWNXaEtjd3A1YzFwRlN6Tk5ZalFyY21ka1FtVnVaV3htY2taSVJXZFFjSFpTYlZKNVpsQTBhM2hqTVhsbWQwdHlNM0JGTkRkM1YwSm5NM0V2VFV3eVRUMEtMUzB0TFMxRlRrUWdRMFZTVkVsR1NVTkJWRVV0TFMwdExRbz0KQVBJX1NFUlZFUl9VUkw9aHR0cHM6Ly8xNDJCRTM3NDYwQjkxRDU0NEREMTAyMDg1MjMwNTZDRC5ncjcuZXUtY2VudHJhbC0xLmVrcy5hbWF6b25hd3MuY29tCi9ldGMvZWtzL2Jvb3RzdHJhcC5zaCBoZ3ctUHJvZC1FYzEtRWtzIC0ta3ViZWxldC1leHRyYS1hcmdzIC0tbm9kZS1sYWJlbHM9bm9kZS10eXBlPW9uZGVtYW5kLWluc3RhbmNlIC0tYjY0LWNsdXN0ZXItY2EgJEI2NF9DTFVTVEVSX0NBIC0tYXBpc2VydmVyLWVuZHBvaW50ICRBUElfU0VSVkVSX1VSTAo=
USERDATA
}

resource "aws_launch_template" "eks_worker_node_ondemand_lt" {
  name = var.worker_launch_template_name
  block_device_mappings {
    device_name      = "/dev/xvda"

    ebs {
      volume_size    = var.worker_disk_size
      volume_type    = var.worker_volume_type
      delete_on_termination = true
      encrypted      = var.encrypted
      kms_key_id     = var.kms_master_key_arn
    }
  }

  iam_instance_profile {
      name          = ${var.Project}_${var.Environment}_ec1_eks_instance_role
  }
     image_id       = var.eks_worker_ami
     instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
     instance_type  = var.worker_node_instance_type
     key_name       = var.worker_ec2_ssh_key
     monitoring {
      enabled = false
     }
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.security_groups
    delete_on_termination       = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.Project}_${var.Environment}_eks_worker_node_ondemand_lt"
    }
  }

  user_data = "${local.eks-node-private-userdata}"
  lifecycle {
    create_before_destroy = true
  }
}


############# Eks ondemand worker autoscaling group

resource "aws_autoscaling_group" "aws_autoscaling_group_node_ondemand" {
  name                      = var.worker_auto_scaling_name
  max_size                  = var.worker_max_size
  min_size                  = var.worker_min_size
  desired_capacity          = var.worker_desired_size
  health_check_grace_period = var.worker_health_check_grace_period
  health_check_type         = var.worker_health_check_type
  force_delete              = false
  termination_policies      = ["NewestInstance"]
  launch_template {
    name = "${aws_launch_template.eks_worker_node_launch_template_ondemand.name}"
    version = "$Latest"
  }
  vpc_zone_identifier       = var.subnet_ids
  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Name"
    value               = "${var.worker_auto_scaling_name}"
    propagate_at_launch = true
  }
  tag {
    key                 = "kubernetes.io/cluster/${var.eks_cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/${var.eks_cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = "true"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.Environment
    propagate_at_launch = true
  }
  tag {
    key                 = "Project"
    value               = var.Project
    propagate_at_launch = true
  }
  tag {
    key                 = "Component"
    value               = var.Component
    propagate_at_launch = true
  }
  tag {
    key                 = "Resource"
    value               = var.Resource
    propagate_at_launch = true
  }
  tag {
    key                 = "Managed"
    value               = var.Managed
    propagate_at_launch = true
  }

}
