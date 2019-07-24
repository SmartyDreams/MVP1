
---

### Run Terraform

Both Terraform and Ansible expect AWS credentials set in environment variables:
https://www.youtube.com/watch?v=IChpsAPq4Ko


```
$ sudo terraform destroy -var-file=credentials.tfvars

$ sudo ansible-playbook -i ./inventory/hosts ./cluster.yml -e ansible_user=core -b --become-user=root --flush-cache --private-key=/home/develop/Desktop/workspace/cert/fastDataPlatform.pem
$ sudo scp  -r -i ~/Desktop/workspace/cert/fastDataPlatform.pem ./ansible/* core@52.204.203.137:/tmp/ansible
$ ssh -i /home/develop/Desktop/workspace/cert/fastDataPlatform.pem core@34.230.50.239


$ sudo kubectl run webservice --image=nginx --expose=true --port=80 --replicas=5
$ sudo kubectl edit services webservice
$ sudo kubectl describe service webservice
$ sudo kubectl get services
$ sudo kubectl get pods --all-namespaces

$ ansible-playbook -i hosts.yml ./all.yml -e ansible_user=core -b --become-user=root --flush-cache --private-key=/home/develop/Desktop/workspace/cert/fastDataPlatform.pem

```
