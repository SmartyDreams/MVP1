
**Edit a file, create a new file, and clone from Bitbucket in under 2 minutes**

When you're done, you can delete the content in this README and update the file with details for others getting started with your repository.

*We recommend that you open this README in another tab as you perform the tasks below. You can [watch our video](https://youtu.be/0ocf7u76WSo) for a full demo of all the steps in this tutorial. Open the video in a new tab to avoid leaving Bitbucket.*

---

## Pre-Requisites

		sudo apt-get remove docker docker-engine docker.io
		sudo apt-get update
		sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
		sudo apt-key fingerprint 0EBFCD88
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

---

##  Install Docker
	
		sudo apt-get update
		sudo apt-get install docker-ce
		sudo docker run hello-world


---

##  Work with docker

		--- List Docker CLI commands
			docker
			docker container --help
		--- Display Docker version and info
			docker --version
			docker version
			docker info
		--- Execute Docker image
			docker run hello-world
		--- List Docker images
			docker image ls
		--- List Docker containers (running, all, all in quiet mode)
			docker container ls
			docker container ls --all
			docker container ls -aq

		--- Containerization makes CI/CD seamless. For example:
    		applications have no system dependencies
    		updates can be pushed to any part of a distributed application
    		resource density can be optimized.
			With Docker, scaling your application is a matter of spinning up new executables, not running heavy VM hosts.

			ls
			Dockerfile		app.py			requirements.txt
			docker build -t friendlyhello .
			docker run -p 4000:80 friendlyhello

			docker login
			docker tag image username/repository:tag
			docker tag friendlyhello gordon/get-started:part2
			sudo docker push smartydreams/test:part1
			sudo docker run -p 4000:80 smartydreams/test:part1

			docker build -t friendlyhello .  # Create image using this directory's Dockerfile
			docker run -p 4000:80 friendlyhello  # Run "friendlyname" mapping port 4000 to 80
			docker run -d -p 4000:80 friendlyhello         # Same thing, but in detached mode
			docker container ls                                # List all running containers
			docker container ls -a             # List all containers, even those not running
			docker container stop <hash>           # Gracefully stop the specified container
			docker container kill <hash>         # Force shutdown of the specified container
			docker container rm <hash>        # Remove specified container from this machine
			docker container rm $(docker container ls -a -q)         # Remove all containers
			docker image ls -a                             # List all images on this machine
			docker image rm <image id>            # Remove specified image from this machine
			docker image rm $(docker image ls -a -q)   # Remove all images from this machine
			docker login             # Log in this CLI session using your Docker credentials
			docker tag <image> username/repository:tag  # Tag <image> for upload to registry
			docker push username/repository:tag            # Upload tagged image to registry
			docker run username/repository:tag                   # Run image from a registry



			sudo docker run erpintegration
			sudo docker run -p 4000:80 erpintegration


		-- Proyecto ErpIntegration.
			sudo docker build -t erpintegration .
			sudo docker run -d -p 4000:80 erpintegration






