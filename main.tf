terraform {
  required_ersion = "~> 0.11.0"
}
resource "vsphere_virtual_machine" "vm" {
  count = "${var.instance_count}"

  name             = "${var.name}-${count.index}"
  resource_pool_id     = "${data.vsphere_compute_cluster.this.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.this.id}"
  num_cpus         = "4"
  memory           = "16384"
  guest_id         = "other26xLinux64Guest"
  enable_disk_uuid = "true"

  wait_for_guest_net_timeout  = "0"
  wait_for_guest_net_routable = "false"

  network_interface {
    network_id = "${data.vsphere_network.this.id}"
  }

  disk {
    label            = "disk0"
    size             = 60
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
  }

  vapp {
    properties {
      "guestinfo.ignition.config.data"          = "${base64encode(data.ignition_config.ign.*.rendered[count.index])}"
      "guestinfo.ignition.config.data.encoding" = "base64"
    }
  }
}
