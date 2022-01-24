terraform {
  cloud {
    organization = "pnlabs"

    workspaces {
      name = "getting-started"
    }
  }
}