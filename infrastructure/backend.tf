terraform {
  backend "s3" {
    bucket = "beachbay-tf-state-miami"
    key    = "beachbay-contact/terraform.tfstate"
    region = "us-east-1"

  }
}
