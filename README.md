# EKS in Terraform

A very basic example of an EKS cluster created with Terraform.

I followed this [AWS docs page](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)
and converted the CloudFormation templates in to Terraform

## Requirements

### AWS Account

You'll need somewhere to put your EKS cluster!

### CLI Tools

The following tools must all be available on your PATH:

#### [`terraform`](https://www.terraform.io/)

Basic Terraform knowledge is assumed

#### [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

Make sure your client is v1.10 or above:

    kubectl version --client

#### [`heptio-authenticator-aws`](https://github.com/heptio/authenticator)

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

An IAM role for the EKS masters with the required two managed policies:

- AmazonEKSClusterPolicy
- AmazonEKSServicePolicy

An IAM role for the worker nodes with the required three managed policies:

- AmazonEKSWorkerNodePolicy
- AmazonEKS_CNI_Policy
- AmazonEC2ContainerRegistryReadOnly

### Security

Security groups for the EKS cluster and worker nodes

### EKS

The EKS cluster.
An empty security group for the cluster.

### Workers

An auto scaling group that provisions worker nodes.

## Creating Your Cluster

### Deployment

Currently the resources get deployed to the `us-east-1` region.
This is what is set in the `global.tfvars` file.

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

### Add Workers

Workers will not connect to your cluster unless you allow the role
on the worker nodes to authenticate with your cluster.

You will need to apply the below yaml snippet to your cluster after
you've replaced the `rolearn` line with the worker role.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: <ARN of instance role (not instance profile)>
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
```

This file is outputted by terraform, populated with the correct role.

To apply it, run:

    terraform output auth_config_map | kubectl apply -f -

### Deploy Sample Application

You can now run pods on your workers, so why not start with a
guestbook application!

You can deploy it out with the shell script provided:

```console
cd kube/examples/guestbook
./deploy-guestbook.sh
```

This will apply the six `yaml` files in the guestbook directory.

Once the guestbook service is deployed, you can get the url by running:

    kubectl get services -o wide -n guestbook

Once the external IP address is available, go to the address at port 3000.

For example: http://a7a95c2b9e69711e7b1a3022fdcfdf2e-1985673473.us-east-1.elb.amazonaws.com:3000

It may take a while for the DNS to propagate and your guestbook to be visible
in your browser.

### Clean Up

#### Sample Application

You can delete the sample application by deleting its namespace:

    kubectl delete namespace guestbook

#### Cluster
Delete the cluster and associated resources with:

    terraform destroy -var-file=../global.tfvars 

This will destroy all the resources at once and will probably fail
if you've made any manual edits to the resources.

If you've deployed any external services such as the example guestbook,
make sure you delete those first, or the AWS load balancers won't be deleted.

***TODO** apply and destroy wrapper scripts.*

## Project Structure

The project is structured to make it easy to cut out the pieces
you will need.

Each component is in its own module.

For example, if you'd like to use an existing VPC, you can remove the
`vpc.tf` file in the cluster directory and add your own VPC id in.
You'd also need to provide the subnets to put the cluster in.

## Contributing

Any comments and improvements are welcome!
