module "eks" {
    #import module template
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
#cluster info
  name               = local.name
  kubernetes_version = "1.33"

  endpoint_public_access = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  #control plane netwrok
  control_plane_subnet_ids = module.vpc.intra_subnets

#managing the nodes in the cluster
eks_managed_node_groups = {
    eks-cluster-new = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["t3.micro"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
      capacity_type = "SPOT"
    }
  }

  tags = {
    Environment = local.env
    terraform = true
  }

}
