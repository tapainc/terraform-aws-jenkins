terraform {
  required_version = ">= 0.13.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
