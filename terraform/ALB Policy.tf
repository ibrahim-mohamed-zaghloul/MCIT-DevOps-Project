# New ALB Policy
resource "aws_iam_policy" "alb_policy" {
  name        = "ALBControllerPolicy"
  description = "IAM policy for AWS Load Balancer Controller"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:*",
          "ec2:Describe*",
          "iam:ListRoles",
          "iam:ListInstanceProfiles",
          "iam:ListRolePolicies",
          "iam:GetRole",
          "iam:GetInstanceProfile",
          "tag:GetResources"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nodes-ALBControllerPolicy" {
  policy_arn = aws_iam_policy.alb_policy.arn
  role       = aws_iam_role.nodes.name
}