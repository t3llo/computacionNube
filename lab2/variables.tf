variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "IPv4 CIDR for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "IPv4 CIDR for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}