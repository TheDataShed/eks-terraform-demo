output "role_arn_eks_basic" {
  description = "ARN of the eks-basic role."
  value       = "${aws_iam_role.eks_basic.arn}"
}
