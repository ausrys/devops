module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5" # Latest stable as of mid-2025

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  vpc_id          = aws_vpc.main.id

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    atlantis_nodes = {
      desired_size = 1
      min_size     = 1
      max_size     = 2

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"

      tags = {
        Name = "atlantis-node-group"
      }
    }
  }

  tags = {
    Environment = "dev"
    Project     = "atlantis"
  }
}
output "eks_cluster_id" {
  value = module.eks.cluster_id
}