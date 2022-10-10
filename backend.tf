terraform {
  backend "s3" {
    bucket = "ookey"
    key = "mathi/terraform.tfstate"
    region = "us-east-2"
    access_key = "AKIASZTTQPYFNPGWZXS4"
    secret_key = "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"
    dynamodb_table = "ookey"
  }
}

