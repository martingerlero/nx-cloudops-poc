module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "nx-poc-cluster"
  cluster_version = "1.29"
  subnet_ids      = ["subnet-0028faeeb77bf2ec2", "subnet-0277e053bc9717af0", "subnet-0b37d6c6eca4a0313"]
  vpc_id          = "vpc-0b56f10b2ed64aa22"
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
