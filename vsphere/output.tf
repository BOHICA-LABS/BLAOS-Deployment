output "blaos_ssh_pubic_key" {
  value     = tls_private_key.blaos.public_key_openssh
  sensitive = true
}

output "blaos_ssh_private_key" {
  value     = tls_private_key.blaos.private_key_pem
  sensitive = true
}

output "cluster_master_count" {
  description = "Count of the masters deployed"
  value       = length(var.appliance_master_hostnames)
}

output "cluster_master_host_names" {
  description = "name of the masters deployed"
  value       = var.appliance_master_hostnames
}

output "cluster_worker_count" {
  description = "Count of the workers deployed"
  value       = length(var.appliance_worker_hostnames)
}

output "cluster_worker_host_names" {
  description = "name of the workers deployed"
  value       = var.appliance_worker_hostnames
}

output "initial_master_cloud_config" {
  value     = data.template_file.initial_master_cloud_config[*].rendered
  sensitive = true
}

output "masters_cloud_config_config" {
  value     = data.template_file.masters_cloud_config[*].rendered
  sensitive = true
}

output "workers_cloud_config_config" {
  value     = data.template_file.workers_cloud_config[*].rendered
  sensitive = true
}

output "initial_master_ip" {
  value     = var.appliance_master_ipaddresses[0]
  sensitive = false
}

output "k3s_yaml" {
  value     = data.local_file.k3s_yaml
  sensitive = true
}

output "vsphere_vapp_name" {
  value     = var.vsphere_vapp_name
  sensitive = false
}
