resource "aws_iam_role" "eks_basic" {
  name               = "eks-basic-access"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = "${aws_iam_role.eks_basic.name}"
  policy_arn = "${var.role_arn_eks_cluster_policy}"
}

resource "aws_iam_role_policy_attachment" "eks_service" {
  role       = "${aws_iam_role.eks_basic.name}"
  policy_arn = "${var.role_arn_eks_service_policy}"
}
