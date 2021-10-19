variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "cluster_name" {
  type        = string
  default     = "bayleef-0195abc"
  description = "The name of the GKE cluster"
}
