output "cluster_name" {
  description = "EKS Cluster identifier"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "kubectl_config_command" {
  description = "Helper command to configure local kubectl access"
  value       = "aws eks update-kubeconfig --region eu-central-1 --name ${module.eks.cluster_name}"
}