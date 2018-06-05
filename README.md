# EKS in Terraform

A very basic example of an EKS cluster created with Terraform.

## Requirements

The following tools must all be available on your PATH:

### [`terraform`](https://www.terraform.io/)

### [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

Make sure your client is v1.10 or above:

    kubectl version --client

### [`heptio-authenticator-aws`](https://github.com/heptio/authenticator)

Linux:

    curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws

MacOS:

    curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/darwin/amd64/heptio-authenticator-aws

## Components

### VPC

A very basic VPC with only public subnets so you aren't charged
for NAT gateways.

Uses the [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/)
from the [Terraform Registry](https://registry.terraform.io/).

### IAM

An IAM role with the required two managed policies:

- AmazonEKSClusterPolicy
- AmazonEKSServicePolicy

### EKS

The EKS cluster.
An empty security group for the cluster.

## Creating Your Cluster

### Deployment

To deploy out the resources, simply run:

    cd terraform/layers/cluster

    terraform init
    
    terraform apply -var-file=../global.tfvars
    
### Connect

You can export the kubeconfig from the cluster into a file:

    terraform output kubeconfig-aws-1-10 > ~/.kube/eksconfig

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

## Contributing

Any comments and improvements welcomed!
