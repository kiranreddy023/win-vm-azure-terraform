variable "resource_group_name" {
  type = string
}

variable "region_name" {
  type = string
}

variable "vm_name" {
  type = string
}
variable "username" {
  type = string
}
variable "network_name" {
  type = string
}
variable "addrspace" {
  type = list(any)
}
variable "subnet_name" {
  type = string
}
variable "sub_addrspace" {
  type = list(string)
}
variable "nic_name" {
  type = string
}
variable "vm_size" {
  type = string
}

variable "admin_user_name" {
  type = string
}
variable "pub_ip_name" {
  type = string
}

variable "password" {
  type = string
}

