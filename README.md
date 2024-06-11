This branch is for the migration of the terraform from AWS to Azure.
Unused or unecessary terraform will also be removed.
Any old terraform from when we used AWS will be on the "old" folder.

# Notes

You will need a .tfvars file from me in order to run the program.
Do so with terraform init \ terraform apply -var-file="your.tfvars"
See https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-change and https://spacelift.io/blog/terraform-tfvars for more details.

