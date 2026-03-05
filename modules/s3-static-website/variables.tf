variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "website_folder" {
  description = "Path of website files"
  type        = string
}

variable "index_file" {
  description = "Index file name"
  type        = string
}

variable "error_file" {
  description = "Error file name"
  type        = string
}