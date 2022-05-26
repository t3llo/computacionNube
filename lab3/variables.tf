variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.16.0.0/16"
}


# us-east-1a
variable "public_subnet1_cidr" {
  description = "IPv4 CIDR for public subnet"
  type        = string
  default     = "172.16.1.0/24"
}
# us-east-1b
variable "public_subnet2_cidr" {
  description = "IPv4 CIDR for public subnet"
  type        = string
  default     = "172.16.4.0/24"
}


variable "private_subnet_cidr" {
  description = "IPv4 CIDR for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}