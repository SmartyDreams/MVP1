[all]
${connection_strings_master}
${public_ip_address_bastion}

[bastion]
${public_ip_address_bastion}

[kube-master]
${list_master}

[k8s-cluster:children]
kube-master

[k8s-cluster:vars]
${elb_api_fqdn}
