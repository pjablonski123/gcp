variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-east1"
}
variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "[us-east1-x]"
}
variable "project_id" {
  description = "GCP project_id"
  type        = string
  default     = "[PROJECT_ID]"
}
