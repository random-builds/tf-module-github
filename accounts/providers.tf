terraform {
  required_version = "~> 1.11.4"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6.0"
    }
  }
}
provider "github" {
  owner = var.GITHUB_ORGANIZATION
  app_auth {
    id              = var.APP_ID
    installation_id = var.APP_INSTALLATION_ID
    pem_file        = var.APP_PEM_FILE
  }
}