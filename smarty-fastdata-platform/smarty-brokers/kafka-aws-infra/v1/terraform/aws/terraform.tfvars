#Global Vars
aws_cluster_name = "SmartBroker"

#VPC Vars
aws_vpc_cidr_block = "10.250.192.0/18"
aws_cidr_subnets_private = ["10.250.192.0/20","10.250.208.0/20"]
aws_cidr_subnets_public = ["10.250.224.0/20","10.250.240.0/20"]
aws_avail_zones = ["us-east-1c"]

#Bastion Host
aws_bastion_ami = "ami-9887c6e7"
aws_bastion_size = "t2.medium"

#Kafka Nodes
aws_kube_master_num = 3
aws_kube_master_size = "t2.medium"
aws_cluster_ami = "ami-9887c6e7"


#Settings AWS ELB
aws_elb_api_port = 6443
k8s_secure_api_port = 6443
kube_insecure_apiserver_address = "0.0.0.0"


default_tags = {
#  Env = "devtest"
#  Product = "kafka"
}

inventory_file = "./hosts"
