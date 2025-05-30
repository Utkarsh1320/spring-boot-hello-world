terraform {
  backend "s3" {
    bucket = "kubernetes-project-pipeline"
    key    = "tf/terraform.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}

locals {
  cluster_name = "simple-eks-cluster"
  vpc_id       = "vpc-0f962a1dbb1f03a2b"

  public_subnet_ids = [
    "subnet-0ee49fa00d513402",
    "subnet-02a524a70fc5ddb5",
    "subnet-08036c981ddfee071",
    "subnet-0223ac270aaaca282",
    "subnet-085dabe203b05487e",
    "subnet-0e348f15d8bdb8b49"
  ]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = local.public_subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_attach]
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}
