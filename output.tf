# Output the EKS Cluster Name
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks.name
}

# Output the EKS Cluster Endpoint
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks.endpoint
}

# Output the EKS Cluster Security Group ID
output "eks_cluster_security_group" {
  description = "The security group ID for the EKS cluster"
  value       = aws_security_group.eks_sg.id
}
