terraform {
  required_version = ">= 1.5.0"

  # --- REMOTE BACKEND (COMMENTED OUT FOR PORTABILITY) ---
  # To use remote state, uncomment this block and run:
  # terraform init -backend-config="bucket=YOUR_BUCKET_NAME" ...
  # 
  # backend "s3" {}
  # ------------------------------------------------------

  # LOCAL BACKEND (Default for easy local testing)
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project_name
      ManagedBy   = "Terraform"
      Environment = "Production"
    }
  }
}