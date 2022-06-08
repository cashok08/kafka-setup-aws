terraform {
  cloud {
    organization = "cashok08-learn"

    workspaces {
      name = "kafka-aws-terraform"
    }
  }
}