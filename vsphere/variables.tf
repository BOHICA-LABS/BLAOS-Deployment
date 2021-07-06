# Appliance Config

variable "appliance_version" {
  description = "Version of the appliance to download"
  type        = string
  sensitive   = false
}

variable "appliance_ova" {
  description = "The full path of the ovf/ova"
  type        = string
  sensitive   = false
}

variable "appliance_user" {
  description = "The user to use for SSH"
  type        = string
  default     = "rancher"
  sensitive   = true
}

variable "appliance_dns" {
  description = "comma seperated list of dns ip addresses (applies to all hosts in cluster)"
  type        = string
  sensitive   = false
}

variable "appliance_subnetmask" {
  description = "the subnetmask to apply to each member of the cluster"
  type        = string
  default     = "255.255.255.0"
  sensitive   = false
}

variable "appliance_gateway" {
  description = "the gateway to apply to each member of the cluster"
  type        = string
  sensitive   = false
}

variable "appliance_master_cpu" {
  description = "The number of cpu for master"
  type        = number
  sensitive   = false
}

variable "appliance_master_ram" {
  description = "The number of cpu for master"
  type        = number
  sensitive   = false
}

variable "appliance_master_disk" {
  description = "The number of cpu for master"
  type        = number
  sensitive   = false
}

variable "appliance_worker_cpu" {
  description = "The number of cpu for master"
  type        = number
  sensitive   = false
}

variable "appliance_worker_ram" {
  description = "The number of cpu for master"
  type        = number
  sensitive   = false
}

variable "appliance_worker_disk" {
  description = "The number of cpu for master"
  type        = number
  sensitive   = false
}

variable "appliance_master_ipaddresses" {
  description = "a ordered list of the ip addresses for each appliance master in the cluster (The first element will be the initial master)"
  type        = list(string)
  sensitive   = false
}

variable "appliance_master_hostnames" {
  description = "a ordered list of the hostname for each appliance master in the cluster (should be in the same order as the master ip addresses)"
  type        = list(string)
  sensitive   = false
}

variable "appliance_worker_ipaddresses" {
  description = "a ordered list of the ip addresses for each appliance worker in the cluster"
  type        = list(string)
  sensitive   = false
}

variable "appliance_worker_hostnames" {
  description = "a ordered list of the hostname for each appliance workers in the cluster (should be in the same order as the workers ip addresses)"
  type        = list(string)
  sensitive   = false
}

variable "appliance_label_region" {
  description = "the region the appliace resides in (this is usually the name of the datacenter)"
  type        = string
  sensitive   = false
}

variable "appliance_label_zone" {
  description = "the zone the appliace resides in (this is usually the name of the network segment)"
  type        = string
  sensitive   = false
}

# Credential Variables 

variable "vsphere_password" {
  description = "vsphere administrator password"
  type        = string
  sensitive   = true
}

variable "vsphere_user" {
  description = "vsphere administrator username"
  type        = string
  sensitive   = true
}

# Define Infrastructure 

variable "data_center" {
  description = "The vsphere data center you want to deploy in"
  type        = string
  sensitive   = false
}

variable "cluster" {
  description = "The vsphere cluster you want to deploy in"
  type        = string
  sensitive   = false
}

variable "datastore" {
  description = "The datastore you want to use"
  type        = string
  sensitive   = false
}

variable "vsphere_host" {
  description = "A host from the cluster (required for OVA deployment)"
  type        = string
  sensitive   = false
}

variable "vsphere_network" {
  description = "The vsphere network to map too"
  type        = string
  sensitive   = false
}

variable "compute_pool" {
  description = "The vsphere compute pool you want to use (default pool is <Cluster>/Resource)"
  type        = string
  sensitive   = false
}

variable "vsphere_server" {
  description = "The fqdn of the vpshere server"
  type        = string
  sensitive   = false
}

variable "vsphere_vapp_name" {
  description = "The name of the vapp to create. best practice is to use the name of the cluster."
  type        = string
  default     = "BLAOS"
  sensitive   = false
}

variable "vsphere_content_library_name" {
  description = "The name to use for the content library"
  type        = string
  default     = "BOHICA LABS Appliance Operating System (BLAOS)"
  sensitive   = false
}

variable "vsphere_content_library_description" {
  description = "The description to use for the content library"
  type        = string
  default     = "Library containing the BLAOS platform"
  sensitive   = false
}

variable "vsphere_content_library_item_name" {
  description = "The name to use for the content library item"
  type        = string
  default     = "BLAOS"
  sensitive   = false
}

variable "vsphere_content_library_item_description" {
  description = "The description to use for the content library item"
  type        = string
  default     = "BOHICA LABS Appliance Operating System (k3OS Derivative)"
  sensitive   = false
}


# Define the kubernetes cluster configuration