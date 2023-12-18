terraform {
  backend "s3" {
    bucket = "tfstate-2tier-1135"
    key    = "backend/Welcome-India.tfstate"
    region = "us-east-1"
    dynamodb_table = "test-DB"
  }
}
