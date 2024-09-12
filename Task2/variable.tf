
variable "ami" {
  type = string
}

variable "instance_type" {
  type        = string
}


variable "tag_name" {
  type = map(any)
}