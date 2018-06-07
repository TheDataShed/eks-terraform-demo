aws_region = "us-east-1"

availability_zones = [
  "us-east-1a",
  "us-east-1c",
  "us-east-1d",
]

cluster_name = "eks-cluster"

policy_arn_eks_cluster = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

policy_arn_eks_service = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"

policy_arn_eks_worker = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

policy_arn_eks_cni = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

policy_arn_ecr_read = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
