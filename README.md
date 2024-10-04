This branch is for the migration of the terraform from AWS to Azure.
Unused or unecessary terraform will also be removed.
Any old terraform from when we used AWS will be on the "old" folder.
Current work will be on the "learn-terraform-azure" folder until further notice
# Notes

You will need a .tfvars file from me in order to run the program.
Do so with terraform init \ terraform apply -var-file="your.tfvars"
See https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-change and https://spacelift.io/blog/terraform-tfvars for more details.
ALTERNATIVELY: the secrets are set as environment variables in the Terraform HCP workspace. If you are a member of the workspace, you do not need a tfvars or need to add the -var-file flag
