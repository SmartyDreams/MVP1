**Edit a file, create a new file, and clone from Bitbucket in under 2 minutes**

When you're done, you can delete the content in this README and update the file with details for others getting started with your repository.

*We recommend that you open this README in another tab as you perform the tasks below. You can [watch our video](https://youtu.be/0ocf7u76WSo) for a full demo of all the steps in this tutorial. Open the video in a new tab to avoid leaving Bitbucket.*

---

## Create the Kubernates Cluster

	Step 1 of 3 
			Cluster up and running
			We already installed minikube for you. Check that it is properly installed, by running the minikube version command:
		minikube version
			OK, we can see that minikube is in place.
			Start the cluster, by running the minikube start command:
		minikube start
			Great! You now have a running Kubernetes cluster in your online terminal. Minikube started a virtual machine for you, and a Kubernetes cluster is now running in that VM.

	Step 2 of 3
			Cluster version
			To interact with Kubernetes during this bootcamp we’ll use the command line interface, kubectl. We’ll explain kubectl in detail in the next modules, but for now, we’re just going to look at some cluster information. To check if kubectl is installed you can run the kubectl version command:
		kubectl version
			OK, kubectl is configured and we can see both the version of the client and as well as the server. The client version is the kubectl version; the server version is the Kubernetes version installed on the master. You can also see details about the build.
			Cluster details
			Let’s view the cluster details. We’ll do that by running kubectl cluster-info:
		kubectl cluster-info
			We have a running master and a dashboard. The Kubernetes dashboard allows you to view your applications in a UI. During this tutorial, we’ll be focusing on the command line for deploying and exploring our application. To view the nodes in the cluster, run the kubectl get nodes command:
		kubectl get nodes
			This command shows all nodes that can be used to host our applications. Now we have only one node, and we can see that it’s status is ready (it is ready to accept applications for deployment).

---

## Deploy the App

	Step 1 of 3
		kubectl basics
			Like minikube, kubectl comes installed in the online terminal. Type kubectl in the terminal to see its usage. The common format of a kubectl command is: kubectl action resource. This performs the specified action (like create, describe) on the specified resource (like node, container). You can use --help after the command to get additional info about possible parameters (kubectl get nodes --help).
			Check that kubectl is configured to talk to your cluster, by running the kubectl version command:
		kubectl version
			OK, kubectl is installed and you can see both the client and the server versions.
			To view the nodes in the cluster, run the kubectl get nodes command:
	Step 2 of 3
			Deploy our app
			Let’s run our first app on Kubernetes with the kubectl run command. The run command creates a new deployment. We need to provide the deployment name and app image location (include the full repository url for images hosted outside Docker hub). We want to run the app on a specific port so we add the --port parameter:
		kubectl run kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --port=8080
			Great! You just deployed your first application by creating a deployment. This performed a few things for you:
		    	searched for a suitable node where an instance of the application could be run (we have only 1 available node)
		    	scheduled the application to run on that Node
		    	configured the cluster to reschedule the instance on a new Node when needed
		 		To list your deployments use the get deployments command:
		kubectl get deployments
				We see that there is 1 deployment running a single instance of your app. The instance is running inside a Docker container on your node.
	Step 3 of 3
			View our app
			Pods that are running inside Kubernetes are running on a private, isolated network. By default they are visible from other pods and services within the same kubernetes cluster, but not outside that network. When we use kubectl, we're interacting through an API endpoint to communicate with our application.
			We will cover other options on how to expose your application outside the kubernetes cluster in Module 4.
			The kubectl command can create a proxy that will forward communications into the cluster-wide, private network. The proxy can be terminated by pressing control-C and won't show any output while its running.
			We will open a second terminal window to run the proxy.
		kubectl proxy
			We now have a connection between our host (the online terminal) and 
			You can see all those APIs hosted through the proxy endpoint, now available at through http://localhost:8001. For example, we can query the version directly through the API using the curl command:
		curl http://localhost:8001/version
			The API server will automatically create an endpoint for each pod, based on the pod name, that is also accessible through the proxy.
			First we need to get the Pod name, and we'll store in the environment variable POD_NAME:
		export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
		echo Name of the Pod: $POD_NAME
			Now we can make an HTTP request to the application running in that pod:
		curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/

---

## Explore the App

	Step 1 of 4
			Step 1 Check application configuration
			Let’s verify that the application we deployed in the previous scenario is running. We’ll use the kubectl get command and look for existing Pods:
		kubectl get pods
			If no pods are running, list the Pods again.
			Next, to view what containers are inside that Pod and what images are used to build those containers we run the describe pods command:
		kubectl describe pods
			We see here details about the Pod’s container: IP address, the ports used and a list of events related to the lifecycle of the Pod.
			The output of the describe command is extensive and covers some concepts that we didn’t explain yet, but don’t worry, they will become 
	Step 2 of 4
			Step 2 Show the app in the terminal
			Recall that Pods are running in an isolated, private network - so we need to proxy access to them so we can debug and interact with them. To do this, we'll use the kubectl proxy command to run a proxy in a second terminal window. Click on the command below to automatically open a new terminal and run the proxy:
		kubectl proxy
			Now again, we'll get the Pod name and query that pod directly through the proxy. To get the Pod name and store it in the POD_NAME environment variable:
		export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
		echo Name of the Pod: $POD_NAME
			To see the output of our application, run a curl request.
		curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/
			The url is the route to the API of the Pod.
	Step 3 of 4
			Step 3 View the container logs
			Anything that the application would normally send to STDOUT becomes logs for the container within the Pod. We can retrieve these logs using the kubectl logs command:
		kubectl logs $POD_NAME
			Note: We don’t need to specify the container name, because we only have one container inside the pod.
	Step 4 of 4
			Step 4 Executing command on the container
			We can execute commands directly on the container once the Pod is up and running. For this, we use the exec command and use the name of the Pod as a parameter. Let’s list the environment variables:
		kubectl exec $POD_NAME env
			Again, worth mentioning that the name of the container itself can be omitted since we only have a single container in the Pod.
			Next let’s start a bash session in the Pod’s container:
		kubectl exec -ti $POD_NAME bash
			We have now an open console on the container where we run our NodeJS application. The source code of the app is in the server.js file:
		cat server.js
			You can check that the application is up by running a curl command:
		curl localhost:8080
			Note: here we used localhost because we executed the command inside the NodeJS container
			To close your container connection type exit.

---

## Exposing the App

	Step 1 of 3
			Step 1 Create a new service
			Let’s verify that our application is running. We’ll use the kubectl get command and look for existing Pods:
		kubectl get pods
			Next let’s list the current Services from our cluster:
		kubectl get services
			We have a Service called kubernetes that is created by default when minikube starts the cluster. To create a new service and expose it to external traffic we’ll use the expose command with NodePort as parameter (minikube does not support the LoadBalancer option yet).
		kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
			Let’s run again the get services command:
		kubectl get services
			We have now a running Service called kubernetes-bootcamp. Here we see that the Service received a unique cluster-IP, an internal port and an external-IP (the IP of the Node).
			To find out what port was opened externally (by the NodePort option) we’ll run the describe service command:
		kubectl describe services/kubernetes-bootcamp
			Create an environment variable called NODE_PORT that has the value of the Node port assigned:
		export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
		echo NODE_PORT=$NODE_PORT
			Now we can test that the app is exposed outside of the cluster using curl, the IP of the Node and the externally exposed port:
		curl $(minikube ip):$NODE_PORT
			And we get a response from the server. The Service is exposed.

	Step 2 of 3
			Step 2: Using labels
			The Deployment created automatically a label for our Pod. With describe deployment command you can see the name of the label:
		kubectl describe deployment
			Let’s use this label to query our list of Pods. We’ll use the kubectl get pods command with -l as a parameter, followed by the label values:
		kubectl get pods -l run=kubernetes-bootcamp
			You can do the same to list the existing services:
		kubectl get services -l run=kubernetes-bootcamp
			Get the name of the Pod and store it in the POD_NAME environment variable:
		export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
		echo Name of the Pod: $POD_NAME
			To apply a new label we use the label command followed by the object type, object name and the new label:
		kubectl label pod $POD_NAME app=v1
			This will apply a new label to our Pod (we pinned the application version to the Pod), and we can check it with the describe pod command:
		kubectl describe pods $POD_NAME
			We see here that the label is attached now to our Pod. And we can query now the list of pods using the new label:
		kubectl get pods -l app=v1

	Step 3 of 3
			Step 3 Deleting a service
			To delete Services you can use the delete service command. Labels can be used also here:
		kubectl delete service -l run=kubernetes-bootcamp
			Confirm that the service is gone:
		kubectl get services
			This confirms that our Service was removed. To confirm that route is not exposed anymore you can curl the previously exposed IP and port:
		curl $(minikube ip):$NODE_PORT
			This proves that the app is not reachable anymore from outside of the cluster. You can confirm that the app is still running with a curl inside the pod:
		kubectl exec -ti $POD_NAME curl localhost:8080
			We see here that the application is up.

---

## Scale Down

	Step 1 of 3
			Step 1: Scaling a deployment
			To list your deployments use the get deployments command: kubectl get deployments
			We should have 1 Pod. If not, run the command again. This shows:
			The DESIRED state is showing the configured number of replicas
			The CURRENT state show how many replicas are running now
			The UP-TO-DATE is the number of replicas that were updated to match the desired (configured) state
			The AVAILABLE state shows how many replicas are actually AVAILABLE to the users
			Next, let’s scale the Deployment to 4 replicas. We’ll use the kubectl scale command, followed by the deployment type, name and desired number of instances:
		kubectl scale deployments/kubernetes-bootcamp --replicas=4
			To list your Deployments once again, use get deployments:
		kubectl get deployments
			The change was applied, and we have 4 instances of the application available. Next, let’s check if the number of Pods changed:
		kubectl get pods -o wide
			There are 4 Pods now, with different IP addresses. The change was registered in the Deployment events log. To check that, use the describe command:
		kubectl describe deployments/kubernetes-bootcamp
			You can also view in the output of this command that there are 4 replicas now.

	Step 2 of 3
			Step 2: Load Balancing
			Let’s check that the Service is load-balancing the traffic. To find out the exposed IP and Port we can use the describe service as we learned in the previously Module:
		kubectl describe services/kubernetes-bootcamp
			Create an environment variable called NODE_PORT that has a value as the Node port:
		export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
		echo NODE_PORT=$NODE_PORT
			Next, we’ll do a curl to the exposed IP and port. Execute the command multiple times:
		curl $(minikube ip):$NODE_PORT
			We hit a different Pod with every request. This demonstrates that the load-balancing is working.

	Step 3 of 3
			Step 3: Scale Down
			To scale down the Service to 2 replicas, run again the scale command:
		kubectl scale deployments/kubernetes-bootcamp --replicas=2
			List the Deployments to check if the change was applied with the get deployments command:
		kubectl get deployments
			The number of replicas decreased to 2. List the number of Pods, with get pods:
		kubectl get pods -o wide
			This confirms that 2 Pods were terminated.

---

## Update your App

	Step 1 of 3
			Step 1: Update the version of the app
			To list your deployments use the get deployments command: kubectl get deployments
			To list the running Pods use the get pods command:
		kubectl get pods
			To view the current image version of the app, run a describe command against the Pods (look at the Image field):
		kubectl describe pods
			To update the image of the application to version 2, use the set image command, followed by the deployment name and the new image version:
		kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
			The command notified the Deployment to use a different image for your app and initiated a rolling update. Check the status of the new Pods, and view the old one terminating with the get pods command:
		kubectl get pods

	Step 2 of 3
			Step 2: Verify an update
			First, let’s check that the App is running. To find out the exposed IP and Port we can use describe service:
		kubectl describe services/kubernetes-bootcamp
			Create an environment variable called NODE_PORT that has the value of the Node port assigned:
		export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
		echo NODE_PORT=$NODE_PORT
			Next, we’ll do a curl to the the exposed IP and port:
		curl $(minikube ip):$NODE_PORT
			We hit a different Pod with every request and we see that all Pods are running the latest version (v2).
			The update can be confirmed also by running a rollout status command:
		kubectl rollout status deployments/kubernetes-bootcamp
			To view the current image version of the app, run a describe command against the Pods:
		kubectl describe pods
			We run now version 2 of the app (look at the Image field)

	Step 3 of 3
			Step 3: Rollback an update
			Let’s perform another update, and deploy image tagged as v10 :
		kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=gcr.io/google-samples/kubernetes-bootcamp:v10
			Use get deployments to see the status of the deployment:
		kubectl get deployments
			And something is wrong… We do not have the desired number of Pods available. List the Pods again:
		kubectl get pods
			A describe command on the Pods should give more insights:
		kubectl describe pods
			There is no image called v10 in the repository. Let’s roll back to our previously working version. We’ll use the rollout undo command:
		kubectl rollout undo deployments/kubernetes-bootcamp
			The rollout command reverted the deployment to the previous known state (v2 of the image). Updates are versioned and you can revert to any previously know state of a Deployment. List again the Pods:
		kubectl get pods
			Four Pods are running. Check again the image deployed on the them:
		kubectl describe pods
			We see that the deployment is using a stable version of the app (v2). 

---

## Test App

	https://api.kubcluster.smartydreams.ca/api/v1/namespaces/default/services/kubernetes-bootcamp/proxy/

		
