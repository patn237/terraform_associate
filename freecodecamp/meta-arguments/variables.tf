variable "location" {
  type    = string
  default = "eastus"
}

variable "subnets" {
  type = list(string)
  default = [
    "10.0.0.0/24"
  ]
}