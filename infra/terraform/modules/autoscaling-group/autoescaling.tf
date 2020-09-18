 

# Set up the launch config which will initialise the ECS instances on boot
resource "aws_launch_configuration" "asg" {
  name_prefix = "${var.naming.autoscaling-group}-"
  

  # Set this to depend on the IAM role, else we might end up with instances running
  # that can't access the resources they need
  depends_on = [
    aws_iam_role_policy.asg
  ]

  iam_instance_profile = aws_iam_instance_profile.asg.id
  image_id = var.ami-id
  instance_type = var.instance-type
  key_name = var.key-name

  # Storage
  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp2"
  }

  security_groups = [
    aws_security_group.app.id
  ]

  user_data = data.template_file.tools.rendered 

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "asg" {
  name                      = var.naming.autoscaling-group

  health_check_grace_period = 60
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.asg.name
  desired_capacity          = var.size
  max_size                  = var.size
  min_size                  = "0"
  vpc_zone_identifier       = var.subnet-ids
  
  

  lifecycle {
    create_before_destroy = true
  }
  tags = [
    {
      "key" = "role"
      "value" = var.role
      "propagate_at_launch" = true
    }
  ]
} 