output "vpc_id" {
  description = "ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "endpoint" {
  description = "Endpoint of the cluster."
  value       = "${module.eks.endpoint}"
}

output "cluster_id" {
  description = "The name of the cluster."
  value       = "${module.eks.cluster_id}"
}

### kubecfg

locals {
  kubeconfig-aws-1-10 = <<KUBECONFIG

apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.endpoint}
    certificate-authority-data: ${module.eks.kubeconfig-certificate-authority-data}
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
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: heptio-authenticator-aws
      args:
        - "token"
        - "-i"
        - "${module.eks.cluster_id}"

KUBECONFIG
}

output "kubeconfig-aws-1-10" {
  description = "Kubeconfig to connect to the cluster."
  value       = "${local.kubeconfig-aws-1-10}"
}
