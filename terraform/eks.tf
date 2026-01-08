# Managed EKS Cluster with optimized compute resources
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.project_name
  cluster_version = "1.34"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # --- ACCESS & SECURITY ---
  cluster_endpoint_public_access = true

  # Professional approach: use a variable for CIDRs.
  # Default is 0.0.0.0/0 for demo portability, but can be overridden.
  cluster_endpoint_public_access_cidrs = var.access_cidrs

  enable_cluster_creator_admin_permissions = true

  enable_irsa = true

  # --- ENCRYPTION & LOGGING (Advanced Level) ---
  create_kms_key = true
  cluster_encryption_config = {
    resources = ["secrets"]
  }

  # Enabling Control Plane logging for audit and debugging
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  cluster_addons = {
    coredns            = {}
    kube-proxy         = {}
    vpc-cni            = {}
    aws-ebs-csi-driver = {}
  }

  eks_managed_node_groups = {
    backbone_nodes = {
      # Multi-instance type strategy for better SPOT availability
      instance_types = ["m7i-flex.large", "c7i-flex.large"]

      min_size     = 1
      max_size     = 8
      desired_size = 4

      capacity_type = "SPOT"

      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      # Tagging nodes for better visibility
      labels = {
        Capability = "ManagedSpotNodes"
      }
    }
  }

  # Resource tagging for cost allocation
  tags = {
    Environment = "Production"
    Framework   = "Terraform"
  }
}