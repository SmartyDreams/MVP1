# Retrieve AWS credentials from env variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
provider "aws" {
  access_key = "AKIAIJV7FGJ2GVQRYEBQ"
  secret_key = "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"
  region = "${var.region}"
}
