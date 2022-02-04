variable "name" {
  type = string
}

variable "schedule" {
  type    = string
  default = "* * * * *"
}

variable "trigger" {
  type    = string
  default = "cron"
  validation {
    condition     = contains(["cron", "storage"], var.trigger)
    error_message = "Valid values for var: trigger are cron or storage."
  }
}

variable "storage_trigger_resource" {
  type    = string
  default = null
}
