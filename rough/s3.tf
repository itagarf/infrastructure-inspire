terraform {
  backend "s3" {
    bucket = "inspire-backnd-bcket"
    key = "backend/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "backend"
  }
}