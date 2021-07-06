# Generate Config
data "template_file" "initial_master_cloud_config" {
  template = file("${path.module}/../resources/templates/initial-master-cfg.yaml.tpl")
  vars = {
    tf_ssh_privkey        = tls_private_key.blaos.private_key_pem
    tf_ssh_pubkey         = tls_private_key.blaos.public_key_openssh
    tf_appliance_hostname = var.appliance_master_hostnames[0]
    tf_cluster_token      = random_uuid.cluster.result
    tf_cluster_dns        = var.appliance_dns
    tf_cluster_gateway    = var.appliance_gateway
    tf_cluster_netmask    = var.appliance_subnetmask
    tf_appliance_ip       = var.appliance_master_ipaddresses[0]
    tf_label_region       = var.appliance_label_region
    tf_label_zone         = var.appliance_label_zone
  }
}

resource "local_file" "initial_master_cloud_config" {
  content         = data.template_file.initial_master_cloud_config.rendered
  filename        = format("${path.module}/artifacts/configs/%s-%s-%s-cloud_init-initial_master.yaml", var.vsphere_vapp_name, var.appliance_master_hostnames[0], var.appliance_master_ipaddresses[0])
  file_permission = "0644"
}

# Vmware Template
## Create the Virtual Machine 
resource "vsphere_virtual_machine" "initial_master" {
  count            = 1
  name             = var.appliance_master_hostnames[0]
  resource_pool_id = vsphere_vapp_container.vapp_container_masters.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.appliance_master_cpu
  memory   = var.appliance_master_ram
  guest_id = "ubuntu64Guest"

  #wait_for_guest_net_timeout = 0
  #wait_for_guest_ip_timeout  = 0

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = var.appliance_master_disk
    thin_provisioned = true
  }

  clone {
    template_uuid = vsphere_content_library_item.appliance.id
  }

  extra_config = {
    "guestinfo.userdata"          = base64encode(data.template_file.initial_master_cloud_config.rendered)
    "guestinfo.userdata.encoding" = "base64"
  }
}
