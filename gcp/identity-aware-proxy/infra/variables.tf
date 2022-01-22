variable "region" {
  type = string
}

variable "project" {
  type = string
}


variable "cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "network" {
  type = string
}


variable "subnet" {
  type    = string
  default = "default"
}

