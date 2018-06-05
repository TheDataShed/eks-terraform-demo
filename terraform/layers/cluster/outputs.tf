output "vpc_id" {
  description = "ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "kubeconfig-aws-1-10" {
  description = "Kubeconfig to connect to the cluster."
  value       = "${module.eks.kubeconfig-aws-1-10}"
}

output "endpoint" {
  description = "Endpoint of the cluster."
  value       = "${module.eks.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  description = "CA data for the cluster."
  value       = "${module.eks.kubeconfig-certificate-authority-data}"
}

output "cluster_id" {
  description = "The name of the cluster."
  value       = "${module.eks.cluster_id}"
}
