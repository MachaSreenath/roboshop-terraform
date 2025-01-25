variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "project_name" {
  default = "roboshop2"
}

variable "environment" {
  default = "dev"
}