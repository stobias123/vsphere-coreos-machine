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

variable "ignition_url" {
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

variable "machine_cidr" {
  type = "string"
}


### Vsphere Config
variable "datacenter" {
  type = "string"
}
