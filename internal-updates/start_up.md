### Installing Terraform  
Follow steps to install Terraform  
1. 
[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)  
2. [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  
3. [Install Kubectl](https://discord.com/channels/@me/1186057804491014185/1229897203548684369)  
4. In command line: `terraform init` - sets up Terraform to run your configuration by initializing the backend and installing the plugins for the providers defined in your configuration.  
5. In command line: `terraform plan` - displays what actions Terraform will perform when you apply your configuration. It doesn't make any changes to real resources but shows you a preview of what will happen.  
6. In command line: `terraform apply` - Terraform will ask you to confirm that you want to perform the actions detailed in the plan. Type yes to proceed. This process can take several minutes as Terraform works to set up your EKS cluster and all associated resources  


