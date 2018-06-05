module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.34.0"

  name = "eks-cluster"
  cidr = "10.0.0.0/20"

  azs            = ["${var.availablilty_zones}"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "${terraform.workspace}"
  }
}

module "iam" {
  source = "../../modules/iam"

  role_arn_eks_cluster_policy = "${var.role_arn_eks_cluster_policy}"
  role_arn_eks_service_policy = "${var.role_arn_eks_service_policy}"
}

module "eks" {
  source = "../../modules/eks"

  cluster_name = "eks-cluster"

  role_arn = "${module.iam.role_arn_eks_basic}"

  vpc_id          = "${module.vpc.vpc_id}"
  cluster_subnets = "${module.vpc.public_subnets}"
}
