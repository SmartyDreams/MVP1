variable control_cidr {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
  default = "0.0.0.0/0"
}

variable default_keypair_public_key {
  description = "Public Key of the default keypair"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcOlJf4phbHez+mHAOfCFxcTwhppjs5av7jfyX6csxviAyVipLFoh3kmRX/+i3caxEHlsWkf+fdxrmWWG2tmeqc4F0B57WPj8re74MU642/h9OucerrRu4pgtE9vuv8ec3YCEJtBHUdaVqtnNVgHAqH7twm6F2LGyEE4z9hnNPXJNZI/vmp26kO7SPcUvzkWKriNtLVkPTgndGHZzwFAKDM7WjyJiBsBid+hS7HF/2/iOF6BKfULD/5KltpleSJzu07/vivHHLnxlonjWWtfpBZv+hX9eLZtqGKUssaQwQmt8+YNlFhfuGzuIiVDy5jRCBRzhhqYoCClHudFEZ3Hdx"
}
variable default_keypair_name {
  description = "Name of the KeyPair used for all nodes"
  default = "fastDataPlatform"
}
variable vpc_name {
  description = "Name of the VPC"
  default = "kubernetes"
}
variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  default = "kubernetes"
}
variable owner {
  default = "Kubernetes"
}
variable ansibleFilter {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  default = "Kubernetes01" # IF YOU CHANGE THIS YOU HAVE TO CHANGE instance_filters = tag:ansibleFilter=Kubernetes01 in ./ansible/hosts/ec2.ini
}

# Networking setup
variable region {
  default = "us-east-1"
}
variable zone {
  default = "us-east-1c"
}

### VARIABLES BELOW MUST NOT BE CHANGED ###
variable vpc_cidr {
  default = "10.43.0.0/16"
}
variable kubernetes_pod_cidr {
  default = "10.200.0.0/16"
}
# Instances Setup
variable amis {
  description = "Default AMIs to use for nodes depending on the region"
  type = "map"
  default = {
    ap-northeast-1 = "ami-0567c164"
    ap-southeast-1 = "ami-a1288ec2"
    cn-north-1 = "ami-d9f226b4"
    eu-central-1 = "ami-8504fdea"
    eu-west-1 = "ami-0d77397e"
    sa-east-1 = "ami-e93da085"
    us-east-1 = "ami-40d28157"
    us-west-1 = "ami-6e165d0e"
    us-west-2 = "ami-a9d276c9"
  }
}
variable default_instance_user {
  default = "ubuntu"
}
variable etcd_instance_type {
  default = "t2.small"
}
variable controller_instance_type {
  default = "t2.small"
}
variable worker_instance_type {
  default = "t2.small"
}
variable kubernetes_cluster_dns {
  default = "10.31.0.1"
}
