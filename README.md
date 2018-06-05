# EKS in Terraform

A very basic example of an EKS cluster created with Terraform

## Components

### VPC

A very basic VPC with only public subnets so you aren't charged
for NAT gateways.

Uses the [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/)
from the [Terraform Registry](https://registry.terraform.io/)

### IAM

An IAM role with the required two managed policies:

- AmazonEKSClusterPolicy
- AmazonEKSServicePolicy

### EKS

The EKS cluster.

## Creating Your Cluster

### Deployment

To deploy out the resources, simply run:

    cd terraform/layers/cluster

    terraform init
    
    terraform apply -var-file=../global.tfvars
    
### Connect

You can export the kubeconfig from the cluster into a file:

    echo $(terraform output kubeconfig-aws-1-10) > ~/.kube/eksconfig

Use this config file with:

    export KUBECONFIG=~/.kube/eksconfig

And check connectivity to your cluster:

    kubectl get componentstatus

## Project Structure

The project is structured to make it easy to cut out the pieces
you will need.

Each component is in its own module.

For example, if you'd like to use an existing VPC, you can remove the
`vpc.tf` file in the cluster directory and add your own VPC id in.
You'd also need to provide the subnets to put the cluster in.
