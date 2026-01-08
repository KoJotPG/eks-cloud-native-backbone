variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project and cluster name"
  type        = string
  default     = "eks-cloud-native-backbone"
}

variable "access_cidrs" {
  description = "Allowed CIDR blocks to access the EKS API"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Open for demo, can be overridden by user
}