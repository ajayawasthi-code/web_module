provider "aws" {
  region     = var.web_region
}
module "jhook-webserver-1" {
  source = ".//module-1"
}

module "jhooq-webserver-2" {

  source = ".//module-2"
}

