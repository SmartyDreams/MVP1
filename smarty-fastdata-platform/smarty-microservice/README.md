**Edit a file, create a new file, and clone from Bitbucket in under 2 minutes**

When you're done, you can delete the content in this README and update the file with details for others getting started with your repository.

*We recommend that you open this README in another tab as you perform the tasks below. You can [watch our video](https://youtu.be/0ocf7u76WSo) for a full demo of all the steps in this tutorial. Open the video in a new tab to avoid leaving Bitbucket.*

---

## AWS Basic Infraestructure

This is the basic commands to configure AWS VPC with a kubernates cluster, this commands will create a s3 bucket, 3 instance EC2, Cluster Name with load balancer.

 
1. bucket_name=imesh-kops-state-store aws s3api create-bucket --bucket buckuber --region us-east-1
2. aws s3api put-bucket-versioning --bucket buckuber --versioning-configuration Status=Enabled
3. export KOPS_CLUSTER_NAME=kubcluster.smartydreams.ca
4. export KOPS_STATE_STORE=s3://buckuber


---

## Instalar kops

Next, you’ll add a new file to this repository.

1. sudo apt-get install -y curl
2. sudo apt-get update && sudo apt-get install -y apt-transport-https
3. curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
4. sudo touch /etc/apt/sources.list.d/kubernetes.list 
5. echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
6. sudo apt-get update
7. sudo apt-get install -y kubectl
8. curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
9. chmod +x kops-linux-amd64
10. sudo mv kops-linux-amd64 /usr/local/bin/kops


---

## Clone a repository

Use these steps to clone from SourceTree, our client for using the repository command-line free. Cloning allows you to work on your files locally. If you don't yet have SourceTree, [download and install first](https://www.sourcetreeapp.com/). If you prefer to clone from the command line, see [Clone a repository](https://confluence.atlassian.com/x/4whODQ).

1. export AWS_ACCESS_KEY=AKIAJRL6QER6NTNPJEUQ
2. export AWS_SECRET_KEY=L0LOO4Lwi6OhgIHAdxGqQPB/01gY7IGAJDfyEw

3. kops create cluster --node-count=2 --node-size=t2.medium --zones=us-east-1a --name=${KOPS_CLUSTER_NAME}
4. kops edit cluster --name ${KOPS_CLUSTER_NAME}

5. ssh-keygen
6. kops create secret --name kubcluster.smartydreams.ca sshpublickey admin -i ~/.ssh/id_rsa.pub -- state s3://buckuber
7. kops update cluster --name ${KOPS_CLUSTER_NAME} --yes

---

## Console

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

1. kops get secrets kube --type secret -oplaintext       FZgMoycFuLcXu8KmX1FEA5rNEMdATdQC
2. kubectl cluster-info
3. https://<kubernetes-master-hostname>/ui
