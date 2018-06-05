variable "aws_region" {
  type        = "string"
  description = "Region to deploy all resources to."
}

variable "availablilty_zones" {
  type        = "list"
  description = "AZs to deploy all resources to."
}

variable "role_arn_eks_cluster_policy" {
  description = "ARN of the default policy, AmazonEKSClusterPolicy."
  type        = "string"
}

variable "role_arn_eks_service_policy" {
  description = "ARN of the default policy, AmazonEKSServicePolicy."
  type        = "string"
}
