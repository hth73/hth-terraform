# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM MODULE VARIABLES
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_region" {}     # eu-west-1
variable "aws_azs" {         # eu-west-1a, eu-west-1b, eu-west-1c
  type = list(string)
} 
variable "vpc_name" {}       # tst-hth
variable "env_name" {}       # tst-hth
variable "stage" {}          # tst
variable "name" {}           # tst-hth
variable "billing_tag" {}    # tst-hth
variable "vpc_id" {}
variable "public-subnet" {
  type = list(string)
} 

locals {
  standard_tags = {
    "Name"    = var.env_name
    "Stage"   = var.stage
    "Billing" = var.billing_tag
  }
}
