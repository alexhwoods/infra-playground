variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "cluster_name" {
  type        = string
  default     = "emboar-020150b"
  description = "The name of the GKE cluster"
}
