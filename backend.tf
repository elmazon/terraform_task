terraform {
  backend "s3" {
    bucket  = "nti-backend-terraform-state"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}
