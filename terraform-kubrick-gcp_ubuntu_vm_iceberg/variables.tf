variable "vmid" {
  description = "Unique identifier for the VM"
  type        = number
}

# variable "prefix" {
#   description = "VM Prefixing"
#   type        = string
# }

variable "public_key_filename" {
  description = "filename for SSH public key"
  type        = string
}

variable "admin_name" {
  description = "default VM Admin user"
  type        = string
}

variable "region" {
  description = "GCP deployment region"
  type        = string
}

# variable "metadata_startup_script" {
#   description = "custom VM setup commands"
#   type        = string
# }

variable "size" {
  type        = string
  description = "VM Size"
  default     = "f1-micro"
}

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "user" {
  type        = string
  description = "End User"
}

variable "cohort" {
  type        = number
  description = "Cohort ID"
}

variable "application" {
  type        = string
  description = "Target Application"
}

variable "host" {
  type = string
  description = "host of vm, aws/azure/gcp"
}

variable "ansible_username" {
  description = "Ansible username for config"
  type        = string
  default     = "ansible"
}

variable "ansible_public_key_file" {
  type = string
}