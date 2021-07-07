# Getting Started

## Create answers.tfvars

Rename the answers.tfvars.tpl to answers.tfvars and populate the varables. a description of each variable can be found inside the variables.tf file

### Variables Tables

| Variable                         | Type           | Description                                                                                                                        | Example                                                  |
| -------------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| **vsphere_user**                 | String         | vsphere administrator username                                                                                                     | "administrator@ad.example.com"                           |
| **vsphere_password**             | String         | vsphere administrator password                                                                                                     | "P@ssw0rd"                                               |
| **data_center**                  | String         | The vsphere data center you want to deploy in                                                                                      | "R1"                                                     |
| **cluster**                      | String         | The vsphere cluster you want to deploy in                                                                                          | "R1UPXVSAN01"                                            |
| **datastore**                    | String         | The datastore you want to use                                                                                                      | "vsanDatastore"                                          |
| **vsphere_host**                 | String         | A host from the cluster (required for OVA deployment)                                                                              | "172.20.1.2"                                             |
| **vsphere_network**              | String         | The vsphere network to map too                                                                                                     | "LAN Network"                                            |
| **compute_pool**                 | String         | The vsphere compute pool you want to use (default pool is Cluster/Resource)                                                        | "R1UPXVSAN01/Resources"                                  |
| **vsphere_server**               | String         | The fqdn of the vpshere server                                                                                                     | "r1upmvcs01.ad.recitsols.com"                            |
| **vsphere_vapp_name**            | String         | The name of the vapp to create. best practice is to use the name of the cluster.                                                   | "Production_BLAOS"                                       |
| **appliance_version**            | String         | Version of the appliance                                                                                                           | "v1.6.0-v1.20.7-k3s1"                                    |
| **appliance_label_region**       | String         | the region the appliace resides in (this is usually the name of the datacenter)                                                    | "test_region"                                            |
| **appliance_label_zone**         | String         | the zone the appliace resides in (this is usually the name of the network segment)                                                 | "test_zone"                                              |
| **appliance_master_cpu**         | Number         | The number of cpu for master                                                                                                       | 2                                                        |
| **appliance_master_ram**         | Number         | The number of RAM for master                                                                                                       | 4096                                                     |
| **appliance_master_disk**        | Number         | The size of the disk for master                                                                                                    | 25                                                       |
| **appliance_worker_cpu**         | Number         | The number of cpu for worker                                                                                                       | 4                                                        |
| **appliance_worker_ram**         | Number         | The number of RAM for worker                                                                                                       | 16384                                                    |
| **appliance_worker_disk**        | Number         | The size of the disk for worker                                                                                                    | 250                                                      |
| **appliance_dns**                | String         | comma seperated list of dns ip addresses (applies to all hosts in cluster)                                                         | "192.168.1.10,192.168.1.12"                              |
| **appliance_gateway**            | String         | the gateway to apply to each member of the cluster                                                                                 | "192.168.1.1"                                            |
| **appliance_subnetmask**         | String         | the subnetmask to apply to each member of the cluster                                                                              | "255.255.255.0"                                          |
| **appliance_master_ipaddresses** | Array(Strings) | A ordered list of the ip addresses for each appliance master in the cluster (The first element will be the initial master)         | ["192.168.1.249","192.168.1.250","192.168.1.251"]        |
| **appliance_master_hostnames**   | Array(Strings) | A ordered list of the hostname for each appliance master in the cluster (should be in the same order as the master ip addresses)   | ["master01","master02","master03"]                       |
| **appliance_worker_ipaddresses** | Array(Strings) | A ordered list of the ip addresses for each appliance worker in the cluster                                                        | ["192.168.1.252","192.168.1.253","192.168.1.254"]        |
| **appliance_worker_hostnames**   | Array(Strings) | A ordered list of the hostname for each appliance workers in the cluster (should be in the same order as the workers ip addresses) | ["worker01","worker02","worker03"]                       |
| **appliance_ova**                | String         | The full path of the ovf/ova                                                                                                       | "C:\users\administrator\Downloads\blaos-vm-template.ova" |

## Initialize terrafrom

```powershell
terraform.exe init
```

## View the build plan

```powershell
terraform.exe plan -var-file="answers.tfvars"
```

## Standup the Platform

```powershell
terraform.exe apply -var-file="answers.tfvars"
```

## Tear Down the Platform

```powershell
terraform.exe destroy -var-file="answers.tfvars"
```
