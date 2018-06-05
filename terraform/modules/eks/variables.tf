variable "role_arn" {
  description = "ARN of the IAM role to use for the cluster."
  type        = "string"
}

variable "vpc_id" {
  description = "ID of the VPC to deploy the cluster to."
  type        = "string"
}

variable "cluster_subnets" {
  description = "Subnets to deploy the cluster in to."
  type        = "list"
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = "string"
}
