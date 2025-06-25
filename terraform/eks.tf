module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "nx-poc-cluster"
  cluster_version = "1.29"
  subnet_ids      = ["subnet-01035a3cc4e8c3aea", "subnet-0446eb40da96350f3", "subnet-0e387b6385a098d66", "subnet-0aea721faa5950885", "subnet-0c627f86faa525e81", "subnet-022ee25b627b01583"]
  vpc_id          = "vpc-057f7248d14054470"
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
