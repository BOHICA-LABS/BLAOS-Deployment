ssh_authorized_keys:
- "${tf_ssh_pubkey}"
write_files:
- path: /var/lib/connman/default.config
  content: |-
    [service_eth0]
    Type=ethernet
    IPv4=${tf_appliance_ip}/${tf_cluster_netmask}/${tf_cluster_gateway}
    IPv6=off
    Nameservers=${tf_cluster_dns}
hostname: "${tf_appliance_hostname}"
init_cmd:
- "ip link set eth0 up"
boot_cmd:
- "ip link set eth0 up"
run_cmd:
- "ip link set eth0 up"
k3os:
  environment:
    K3S_TOKEN: "${tf_cluster_token}"
  labels:
    region: "${tf_label_region}"
    zone: "${tf_label_zone}"
    role: master
  k3s_args:
  - server
  - "--cluster-init"
  - "--kube-proxy-arg"
  - "ipvs-strict-arp"
  - "--disable"
  - "servicelb"
  taints:
  - CriticalAddonsOnly=true:NoExecute