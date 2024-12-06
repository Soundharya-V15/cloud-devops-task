# Web App Deployment on AWS EKS

This project demonstrates how to deploy a simple static web application to a cloud-based Kubernetes solution (AWS EKS).

## Prerequisites
- AWS CLI configured with IAM permissions
- Terraform installed
- Docker installed

## Steps to Deploy

### 1. Provision AWS Infrastructure
```bash
cd terraform
terraform init
terraform apply
