variable "prefix" {
  type    = string
  default = "interview"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type    = string
  default = "${var.prefix}-rg"
}

variable "aks_node_count" {
  type    = number
  default = 2
}

variable "aks_node_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "acr_name" {
  type    = string
  default = "${var.prefix}acr"
}

# Optional: storage account for tfstate backend (if you decide to use remote backend)
variable "tf_backend_storage_account" {
  type    = string
  default = ""
}

