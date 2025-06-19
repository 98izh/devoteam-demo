variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "reviewer_principals" {
  description = "List of IAM principals to grant review/viewer roles"
  type        = list(string)
  default     = []
}