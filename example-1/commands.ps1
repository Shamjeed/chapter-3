#Docker build command
#docker build -t <your-name-for-the-image> --file <path-to-your-Dockerfile> <path-to-project>

#Docker build command -t is for tagging
docker build -t video-streaming --file Dockerfile .

#List docker images
docker image list

#Docker run -e is for environment variable
#docker run -d -p <host-port>:<container-port> -e <name>=<value> <image-name>
docker run -d -p 3000:3000 -e PORT=3000 video-streaming

#List containers
docker container list

#Output:
#CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                    NAMES
#942f816e51b2   video-streaming   "docker-entrypoint.s…"   3 seconds ago   Up 2 seconds   0.0.0.0:3000->3000/tcp   eloquent_napier

#Check logs
#docker logs <container-id>
docker logs 942f816e51b2

#Debugging the container by logging into its shell
#docker exec -it <container-id> sh
docker exec -it 5ddd018b9c2c sh

#Stopping the container
#docker stop <container-id>
docker stop 5ddd018b9c2c

#To list all containers including the stopped one use below
docker container list --all

#After stopping our container, we can delete it like this:
#docker rm <container-id>
docker rm 5ddd018b9c2c

#Pushing docker image to private container registry
docker login msmicrobootregistry.azurecr.io --username msmicrobootregistry --password SECRET
#WARNING! Using --password via the CLI is insecure. Use --password-stdin.
docker login msmicrobootregistry.azurecr.io --username msmicrobootregistry --password-stdin

#Tag the image with the resgistry url
#docker tag <existing-image> <registry-url>/<image-name>:<version>
docker tag video-streaming msmicrobootregistry.azurecr.io/video-streaming:latest
#Output
#REPOSITORY                                       TAG              IMAGE ID       CREATED          SIZE
#video-streaming                                  latest           2a300cfd1af2   26 minutes ago   180MB
#msmicrobootregistry.azurecr.io/video-streaming   latest           2a300cfd1af2   26 minutes ago   180MB

#Push the image to the registry
#docker push <registry-url>/<image-name>:<version>
docker push msmicrobootregistry.azurecr.io/video-streaming:latest

#Remove all images from local to test image pulled from AZURE resgistry
docker container list --all
#If any container running with local images stop and remove it
#docker stop <your-container-id>
#docker rm <your-container-id>

#Check if container is running
#docker ps

#Get image list
docker image list
#Output
#REPOSITORY                                       TAG              IMAGE ID       CREATED             SIZE
#video-streaming                                  latest           2a300cfd1af2   40 minutes ago      180MB
#msmicrobootregistry.azurecr.io/video-streaming   latest           2a300cfd1af2   40 minutes ago      180MB

#Remove image with above id
#docker rmi <your-image-id> --force
docker rmi 2a300cfd1af2 --force

#Running a container directly from the registry
#docker run -d -p <host-port>:<container-port> -e <name>=<value> <registry-url>/<image-name>:<version>
docker run -d -p 3000:3000 -e PORT=3000 msmicrobootregistry.azurecr.io/video-streaming:latest








