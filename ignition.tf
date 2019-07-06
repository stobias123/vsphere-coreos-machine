locals {
  ignition_encoded = "data:text/plain;charset=utf-8;base64,${base64encode(var.ignition)}"
}

data "ignition_file" "hostname" {
  count = "${var.instance_count}"

  filesystem = "root"
  path       = "/etc/hostname"
  mode       = "420"

  content {
    content = "${var.name}-${count.index}"
  }
}

data "ignition_file" "static_ip" {
  count = "${var.instance_count}"

  filesystem = "root"
  path       = "/etc/sysconfig/network-scripts/ifcfg-ens192"
  mode       = "420"

  content {
    content = <<EOF
TYPE=Ethernet
BOOTPROTO=none
NAME=ens192
DEVICE=ens192
ONBOOT=yes
DOMAIN=${var.domain}
DNS1=8.8.8.8
EOF
  }
}

data "ignition_systemd_unit" "restart" {
  count = "${var.instance_count}"

  name = "restart.service"

  content = <<EOF
[Unit]
ConditionFirstBoot=yes
[Service]
Type=idle
ExecStart=/sbin/reboot
[Install]
WantedBy=multi-user.target
EOF
}

data "ignition_user" "foo" {
    name = "core"
    home_dir = "/home/core/"
    shell = "/bin/bash"
    ssh_authorized_keys = ["${var.ssh_keys}"]
}

data "ignition_config" "ign" {
  count = "${var.instance_count}"

  // append {
  //   source = "${var.ignition_url != "" ? var.ignition_url : local.ignition_encoded}"
  // }

  systemd = ["${concat("${data.ignition_systemd_unit.restart.*.id[count.index]}","${var.systemd_units}")}"]

  files = [
    "${data.ignition_file.hostname.*.id[count.index]}",
    "${data.ignition_file.static_ip.*.id[count.index]}",
  ]
}
