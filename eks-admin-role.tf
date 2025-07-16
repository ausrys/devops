resource "aws_iam_role" "eks_admin_assumable_role" {
  name = "eks-admin-assumable-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::186797361646:user/devops"  # Your user ARN here
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_admin_attach" {
  role       = aws_iam_role.eks_admin_assumable_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # or narrower policy if you want
}
