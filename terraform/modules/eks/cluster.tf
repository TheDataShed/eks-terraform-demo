resource "aws_eks_cluster" "cluster" {
  name     = "${var.cluster_name}"
  role_arn = "${var.role_arn}"

  vpc_config {
    subnet_ids = ["${var.cluster_subnets}"]

    security_group_ids = [
      "${aws_security_group.cluster.id}",
    ]
  }
}
