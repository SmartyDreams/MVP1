**Edit a file, create a new file, and clone from Bitbucket in under 2 minutes**

When you're done, you can delete the content in this README and update the file with details for others getting started with your repository.

*We recommend that you open this README in another tab as you perform the tasks below. You can [watch our video](https://youtu.be/0ocf7u76WSo) for a full demo of all the steps in this tutorial. Open the video in a new tab to avoid leaving Bitbucket.*

---

## Reference

1. URL: https://medium.com/containermind/how-to-create-a-kubernetes-cluster-on-aws-in-few-minutes-89dda10354f4
2. URL: https://github.com/marandalucas/tutorial-kubernetes
3. URL: https://www.abhishek-tiwari.com/kubernetes-for-big-data-workloads/

---

## AWS Basic Infraestructure

	bucket_name=imesh-kops-state-store aws s3api create-bucket --bucket buckuber --region us-east-1
	aws s3api put-bucket-versioning --bucket buckuber --versioning-configuration Status=Enabled
	export KOPS_CLUSTER_NAME=kubcluster.smartydreams.ca
	export KOPS_STATE_STORE=s3://buckuber

---

## Instalar kops

	-- PreRequisitos 
		sudo apt-get install -y curl
		sudo apt-get update && sudo apt-get install -y apt-transport-https
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
		sudo touch /etc/apt/sources.list.d/kubernetes.list 
		echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
		sudo apt-get update
		sudo apt-get install -y kubectl

	-- Instalar
		curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
		chmod +x kops-linux-amd64
		sudo mv kops-linux-amd64 /usr/local/bin/kops

---

## Kops Configuration

	export AWS_ACCESS_KEY=AKIAJRL6QER6NTNPJE
	export AWS_SECRET_KEY=L0LOO4Lwi6OhgIHAdxGqQPB/01gY7IGAJDfy

	kops create cluster --node-count=2 --node-size=t2.medium --zones=us-east-1a --name=${KOPS_CLUSTER_NAME}
	kops edit cluster --name ${KOPS_CLUSTER_NAME}

	ssh-keygen
	kops create secret --name kubcluster.smartydreams.ca sshpublickey admin -i ~/.ssh/id_rsa.pub -- state s3://buckuber
	kops update cluster --name ${KOPS_CLUSTER_NAME} --yes

	-- Suggestions:
		 * validate cluster: kops validate cluster
		 * list nodes: kubectl get nodes --show-labels
		 * ssh to the master: ssh -i ~/.ssh/id_rsa admin@api.kubcluster.smartydreams.ca
		 * the admin user is specific to Debian. If not using Debian please use the appropriate user based on your OS.
		 * read about installing addons at: https://github.com/kubernetes/kops/blob/master/docs/addons.md.

---

## Console

 	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
 	kops get secrets kube --type secret -oplaintext       FZgMoycFuLcXu8KmX1FEA5rNEMdATdQC
 	kubectl cluster-info

 	https://<kubernetes-master-hostname>/ui

---
