This week, I used minikube, kubectl and Docker to deploy my personal project, which created 5 replicas. For this process, I had to create a docker image, create a docker account and upload the image to the repository through the terminal. Then, I created yaml files called deployment, ingress and service, which are components that define how the Kubernetes cluster operates. I applied these files to kubernetes using kubectl and created a local production enviroment with 5 replica sets.

Commit links:
https://github.com/RPIPAL/palwebsite/commit/cd895cfdc5cf59ce5b0ba84f332155906e99faca
https://github.com/RPIPAL/palwebsite/commit/67ccb49f2f907cd66017ad9e0948f417043475b8
