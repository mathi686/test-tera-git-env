# Input variable definitions

variable "bucket_name" {
  description = "test"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
