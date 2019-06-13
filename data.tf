
data "vsphere_datacenter" "this" {
  name = "${var.datacenter}"
}

data "vsphere_datastore" "this" {
  name          = "${var.datastore}"
  datacenter_id = "${data.vsphere_datacenter.this.id}"
}

data "vsphere_compute_cluster" "this" {
  name          = "${var.cluster}"
  datacenter_id = "${data.vsphere_datacenter.this.id}"
}

data "vsphere_network" "this" {
  name          = "${var.network}"
  datacenter_id = "${data.vsphere_datacenter.this.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.template}"
  datacenter_id = "${data.vsphere_datacenter.this.id}"
}