variable "instance_ami" {
  type    = string
  default = "ami-0778521d914d23bc1"
}

variable "ram_instance" {
  type    = string
  default = "t2.medium"
}

variable "key_file_name" {
  type    = string
  default = "vockey"
}

variable "instance_name" {
  type    = string
  default = "ssh_rsync"
}