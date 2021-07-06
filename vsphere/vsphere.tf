# Define the Provider 
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

# Define Details about the Provider
data "vsphere_datacenter" "dc" {
  name = var.data_center
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.compute_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_vapp_container" "vapp_container_cluster" {
  name                    = var.vsphere_vapp_name
  parent_resource_pool_id = data.vsphere_resource_pool.pool.id
}

resource "vsphere_vapp_container" "vapp_container_masters" {
  name                    = "${vsphere_vapp_container.vapp_container_cluster.name}-masters"
  parent_folder_id        = vsphere_vapp_container.vapp_container_cluster.id
  parent_resource_pool_id = vsphere_vapp_container.vapp_container_cluster.id
}

resource "vsphere_vapp_container" "vapp_container_workers" {
  name                    = "${vsphere_vapp_container.vapp_container_cluster.name}-workers"
  parent_folder_id        = vsphere_vapp_container.vapp_container_cluster.id
  parent_resource_pool_id = vsphere_vapp_container.vapp_container_cluster.id
}
/*
resource "vsphere_vapp_entity" "vapp_entity_vappmasters" {
  depends_on = [
    vsphere_virtual_machine.workers,
    vsphere_virtual_machine.masters
  ]
  target_id    = vsphere_vapp_container.vapp_container_masters.id
  container_id = vsphere_vapp_container.vapp_container_cluster.id
  start_order  = 1
  start_action = "powerOn"
  stop_action  = "guestShutdown"
}

resource "vsphere_vapp_entity" "vapp_entity_vappworker" {
  depends_on = [
    vsphere_virtual_machine.workers,
    vsphere_virtual_machine.masters
  ]
  target_id    = vsphere_vapp_container.vapp_container_workers.id
  container_id = vsphere_vapp_container.vapp_container_cluster.id
  start_order  = 2
  start_action = "powerOn"
  stop_action  = "guestShutdown"
}
*/

# Define Content Library
## Create the Content Library inside vsphere

resource "vsphere_content_library" "library" {
  name            = var.vsphere_content_library_name
  storage_backing = [data.vsphere_datastore.datastore.id]
  description     = var.vsphere_content_library_description
}

## Upload the appliance OVF and return the content library ID
resource "vsphere_content_library_item" "appliance" {
  name        = format("%s-%s", var.vsphere_content_library_item_name, var.appliance_version)
  description = var.vsphere_content_library_item_description
  library_id  = vsphere_content_library.library.id
  file_url    = format("%s", var.appliance_ova)
}

## Upload ISO
/**
resource "vsphere_file" "k3os" {
  datacenter       = var.data_center
  datastore        = var.datastore
  source_file      = format("${path.module}/iso/%s", "k3os-vm-amd64.iso")
  destination_file = format("/ISO/swimlane/%s", "k3os-vm-amd64.iso")
}
**/