module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "nx-poc-cluster"
  cluster_version = "1.29"
  subnet_ids      = [/* tus subnets aquí */]
  vpc_id          = "tu-vpc-id"
  enable_irsa     = true

  eks_managed_node_groups = {
    default = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1

      instance_types = ["t3.micro"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Owner = "Martin Gerlero"
  }
}
