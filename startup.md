*Recommended to use Linux or WSL*  
*Please read onboarding.md before using this document*  

Follow steps to install Terraform  
1. 
[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)  
2. [Install Cilium CLI](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli)  
3. Install Kubectl
- brew install kubectl (Mac)
- sudo apt-get install -y kubectl (WSL)

Other installions:
- brew install helm (Mac)
- curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash (WSL)
- brew install azure-cli (Mac)
- curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash (WSL)

4. In command line: `terraform init` - sets up Terraform to run your configuration by initializing the backend and installing the plugins for the providers defined in your configuration.  
5. In command line: `terraform plan` - displays what actions Terraform will perform when you apply your configuration. It doesn't make any changes to real resources but shows you a preview of what will happen.  
6. In command line: `terraform apply` - Terraform will ask you to confirm that you want to perform the actions detailed in the plan. Type `yes` to proceed. This process can take several minutes as Terraform works to set up your EKS cluster and all associated resources  
7. Once the Terraform apply is successful, you'll need to configure kubectl to interact with your new EKS cluster. You can use the AKS CLI to update your kubeconfig file with the context of your new cluster: `az aks get-credentials --resource-group RCOS-Cilium_group --name test-cilium-aks`  
8. Verify that you can connect to your Kubernetes cluster by running: `kubectl get nodes`  
9. Additional Details about the cluster: `kubectl cluster-info`

*Installation for Windows*

Terraform:
1. Click link and find install packages
2. Download 'Windows AMD64'
3. Extract file into whatever drive you want under a new folder 'terraform'
4. Add the folder to PATH in system properties

Cilium CLI:
1. Download windows version of cilium
2. Extract into folder called 'cilium' and add to PATH in system properties
3. Follow instructions to install Minikube
4. Download Docker if you don't have the driver needed (Should be an error with Minikube)
5. Run powershell in administrator mode for the rest of the steps of installing Cilium and Minikube

### IMPORTANT
`terraform destroy`  
Run this when you are finished with the cluster to avoid errant costs
In order to view the grafan output, you will have to give yourself the "grafana admin" role.
Do this with "az role assignment create --assignee "your-id" --role "Grafana Admin" --scope "/subscriptions/subscription-id/resourceGroups/your-resource-group"
You may also need to give your cli the rbac admin role if it does not have the ability to do already
Do this with "az role assignment create --assignee "cli-id" --role "Role Based Access Control Administrator" --scope "/subscriptions/subscription-id/resouceGroups/your-resource-group"

