variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "ap-south-1" 
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_a_cidr_block" {
  description = "CIDR block for Public Subnet A"
  default     = "10.0.1.0/24"
}

variable "subnet_a_az" {
  description = "Availability Zone for Public Subnet A"
  default     = "ap-south-1a" 
}

variable "subnet_b_cidr_block" {
  description = "CIDR block for Public Subnet B"
  default     = "10.0.2.0/24"
}

variable "subnet_b_az" {
  description = "Availability Zone for Public Subnet B"
  default     = "ap-south-1b"  
}

variable "subnet_c_cidr_block" {
  description = "CIDR block for Private Subnet A"
  default     = "10.0.3.0/24"
}

variable "subnet_c_az" {
  description = "Availability Zone for Private Subnet A"
  default     = "ap-south-1a" 
}

variable "subnet_d_cidr_block" {
  description = "CIDR block for Private Subnet B"
  default     = "10.0.4.0/24"
}

variable "subnet_d_az" {
  description = "Availability Zone for Private Subnet B"
  default     = "ap-south-1b"  
}
