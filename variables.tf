variable "name" {
  type = "string"
}

variable "instance_count" {
  type = "string"
}

variable "ignition" {
  type    = "string"
  default = ""
}

variable "domain" {
  type    = "string"
}
variable "cluster" {
  type    = "string"
}

variable "datastore" {
  type = "string"
}

variable "network" {
  type = "string"
}

variable "template" {
  type = "string"
}

### Vsphere Config
variable "datacenter" {
  type = "string"
}

variable "vsphere_user" {
  type = "string"
}

variable "vsphere_password" {
  type = "string"
}

variable "vsphere_server" {
  type = "string"
}

variable "ssh_keys" {
  type = "list"
}
