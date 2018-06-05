variable "role_arn_eks_cluster_policy" {
  description = "ARN of the default policy, AmazonEKSClusterPolicy."
  type        = "string"
}

variable "role_arn_eks_service_policy" {
  description = "ARN of the default policy, AmazonEKSServicePolicy."
  type        = "string"
}
