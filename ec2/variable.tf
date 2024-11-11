variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "public_sg_id" {
  description = "The ID of the public sg"
  type        = string
}

variable "private_sg_id" {
  description = "The ID of the private sg"
  type        = string
}

variable "key-name" {
  description = "The Public Key to SSH"
  type        = string
  default = "nam-huy-key"
}
