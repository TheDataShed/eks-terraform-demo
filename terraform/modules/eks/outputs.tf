locals {
  kubeconfig-aws-1-10 = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    auth-provider:
      config:
        cluster-id: ${var.cluster_name}
      name: aws
KUBECONFIG
}

output "kubeconfig-aws-1-10" {
  description = "Kubeconfig to connect to the cluster."
  value       = "${local.kubeconfig-aws-1-10}"
}

output "endpoint" {
  description = "Endpoint of the cluster."
  value       = "${aws_eks_cluster.cluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  description = "CA data for the cluster."
  value       = "${aws_eks_cluster.cluster.certificate_authority.0.data}"
}

output "cluster_id" {
  description = "The name of the cluster."
  value       = "${aws_eks_cluster.cluster.id}"
}
