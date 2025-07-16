variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "atlantis-eks-cluster"
}
variable "github_token" {
  type      = string
  sensitive = true
}

variable "webhook_secret" {
  type      = string
  sensitive = true
}

variable "github_user" {
  type = string
}

variable "github_repo" {
  type = string
}