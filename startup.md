*Recommended to use Linux or WSL*  
*Please read onboarding.md before using this document*  

Follow steps to install Terraform  
1. 
[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)  
2. [Install Cilium CLI](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli)  
3. [Install Kubectl](https://discord.com/channels/@me/1186057804491014185/1229897203548684369)  
4. In command line: `terraform init` - sets up Terraform to run your configuration by initializing the backend and installing the plugins for the providers defined in your configuration.  
5. In command line: `terraform plan` - displays what actions Terraform will perform when you apply your configuration. It doesn't make any changes to real resources but shows you a preview of what will happen.  
6. In command line: `terraform apply` - Terraform will ask you to confirm that you want to perform the actions detailed in the plan. Type `yes` to proceed. This process can take several minutes as Terraform works to set up your EKS cluster and all associated resources  
7. Once the Terraform apply is successful, you'll need to configure kubectl to interact with your new EKS cluster. You can use the AKS CLI to update your kubeconfig file with the context of your new cluster: `az aks get-credentials --resource-group RCOS-Cilium_group --name test-aks`  
8. Verify that you can connect to your Kubernetes cluster by running: `kubectl get nodes`  
9. Additional Details about the cluster: `kubectl cluster-info`

### IMPORTANT
`terraform destroy`  
Run this when you are finished with the cluster to avoid errant costs

