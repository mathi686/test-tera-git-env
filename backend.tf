terraform {
  backend "s3" {
    bucket = "ookey"
    key = "mathi/terraform.tfstate"
    region = "us-east-2"
    access_key = "AKIASZTTQPYFA3GUI2XV"
    secret_key = "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"
    dynamodb_table = "ookey"
  }
}