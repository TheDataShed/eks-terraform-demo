resource "aws_security_group" "cluster" {
  name        = "${var.cluster_name}"
  description = "Security group for the EKS cluster."

  vpc_id = "${var.vpc_id}"
}
