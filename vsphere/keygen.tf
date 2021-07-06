# Generate Public and Private Keys

resource "tls_private_key" "blaos" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "blaos-ssh-privkey" {
  content         = tls_private_key.blaos.private_key_pem
  filename        = format("${path.module}/artifacts/keys/%s-blaos-id_rsa.pem", var.vsphere_vapp_name)
  file_permission = "0600"

  provisioner "local-exec" {
    command = "winscp.com /keygen ${local_file.blaos-ssh-privkey.filename} /output=./artifacts/keys/${var.vsphere_vapp_name}-blaos-id_rsa.ppk"
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "Remove-Item .\\artifacts\\keys\\*-blaos-id_rsa.ppk"
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "local_file" "blaos-ssh-pubkey" {
  content         = tls_private_key.blaos.public_key_openssh
  filename        = format("${path.module}/artifacts/keys/%s-blaos-id_rsa.pub", var.vsphere_vapp_name)
  file_permission = "0644"
}

# Generate a token for the cluster
resource "random_uuid" "cluster" {}

# Copy kubectl config file
resource "null_resource" "get_kubeconfig_from_master" {
  depends_on = [
    vsphere_virtual_machine.initial_master,
  ]

  provisioner "local-exec" {
    command = "echo y | pscp -i ./artifacts/keys/${var.vsphere_vapp_name}-blaos-id_rsa.ppk rancher@${vsphere_virtual_machine.initial_master[0].default_ip_address}:/etc/rancher/k3s/k3s.yaml ./artifacts/keys/k3s.yaml"
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "Remove-Item .\\artifacts\\keys\\k3s.yaml"
    interpreter = ["PowerShell", "-Command"]
  }
}

# Fix kubectl file
resource "null_resource" "fix_kubectl_config" {
  depends_on = [
    null_resource.get_kubeconfig_from_master,
  ]

  provisioner "local-exec" {
    command     = "(Get-Content -raw .\\artifacts\\keys\\k3s.yaml) -replace 'https:\\/\\/(.*):6443','https://${vsphere_virtual_machine.initial_master[0].default_ip_address}:6443' | Out-File .\\artifacts\\keys\\k3s.yaml -Force"
    interpreter = ["PowerShell", "-Command"]
  }
}

# Load kubectl config so we can save it to state
data "local_file" "k3s_yaml" {
  depends_on = [
    null_resource.fix_kubectl_config
  ]
  filename = "${path.module}/artifacts/keys/k3s.yaml"
}