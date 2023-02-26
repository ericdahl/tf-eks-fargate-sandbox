provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Name = "tf-eks-fargate-sandbox"
    }
  }
}

data "aws_default_tags" "default" {}

locals {
  cluster_name = data.aws_default_tags.default.tags["Name"]
}

resource "aws_eks_cluster" "cluster" {
  name = local.cluster_name

  role_arn = aws_iam_role.cluster.arn
  vpc_config {
    subnet_ids = [for s in aws_subnet.public : s.id]
  }
}

