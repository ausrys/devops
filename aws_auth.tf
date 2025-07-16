module "eks_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "20.8.5"

  depends_on = [module.eks]

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = module.eks.eks_managed_node_groups["atlantis_nodes"].iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    },
    {
      rolearn  = aws_iam_role.eks_admin_assumable_role.arn
      username = "eks-admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = aws_iam_role.eks_read_only.arn
      username = "eks-read-only"
      groups   = ["eks-read-only-group"]
    }
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::186797361646:user/devops"
      username = "devops"
      groups   = ["system:masters"]
    }
  ]
}
