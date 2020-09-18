data "aws_iam_policy_document" "asg-assume-role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "asg" {
  statement {
    effect = "Allow"
    resources = ["arn:aws:s3:::${var.discovery-bucket}/*"]
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListObjects"
    ]
  }

  statement {
    effect = "Allow"
    resources = ["arn:aws:s3:::${var.discovery-bucket}"]
    actions = [
      "s3:ListBucket"
    ]
  }
}

#An IAM instance profile we can attach to an EC2 instance
resource "aws_iam_instance_profile" "asg" {
  name = var.naming.autoscaling-group
  role = aws_iam_role.asg.name
  
  lifecycle {
    create_before_destroy = true
  }
}

# An IAM role that we attach to the EC2 Instances in ECS.
resource "aws_iam_role" "asg" {
  name = var.naming.autoscaling-group
  assume_role_policy = data.aws_iam_policy_document.asg-assume-role.json
  
  lifecycle {
    create_before_destroy = true
  }
}


// Add user supplied permissions, if any have been set
resource "aws_iam_role_policy" "asg" {
    name = "${var.naming.autoscaling-group}-asg"
    role = aws_iam_role.asg.id
    policy = data.aws_iam_policy_document.asg.json
}