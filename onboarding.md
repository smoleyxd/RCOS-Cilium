## Introduction 
 Cilium is a tool that helps manage how data moves between different applications inside a Kubernetes cluster. Kubernetes can be thought of as a traffic controller for applications, making sure apps can run smoothly on a group of nodes (called a cluster) and that they can communicate when needed. It automates the deployment, scaling, and management of containerized applications. Containerized applications are applications packaged in containers, which can be conceptualized as boxes that hold everything an application needs to run such as code, libraries, and dependencies. They ensure the app can run consistently on any machine/no matter where it's deployed (computer, server, cloud); thus, they are like isolated environments that allow apps to run independently from each other and of their platform. A kubernetes cluster works to to run and manage these containers and distributes the workload across multiple nodes.
 
 Nodes are the machines that run the applications. They can be physical machines like computers, virtual machines that run on cloud platforms such as AWS, Google Cloud, or Microsoft **Azure**, or cloud instances like EC2 instances on AWS or VM instances on Google Cloud, which act like virtual machines but are specifically managed by cloud platforms.
 
 Cilium helps manage and secure this communication between applications inside Kubernetes, controling and monitoring the traffic between apps to make sure the correct messages get through. Using Cilium with Kubernetes enhances:
 - Security: Cilium helps create rules about which applications can talk to each other, making the system more secure
 - Visibility: Cilium provides a clear view of what’s happening inside the cluster—what apps are talking, how much traffic is moving, and if anything unusual is occurring 
 - Scalability: Cilium helps Kubernetes handle lots of applications without slowing down communication

Terraform is the tool we will be using to handle the creation of the Kubernetes clusters that Cilium depends on for managing networking and security.

## Terraform
### What is Terraform?
Terraform is a powerful tool that automates infrastructure. This means it allows us to define and manage our infrastructure (like servers, networks, and storage) using code, specifically in simple configuration files written in a language called HCL (HashiCorp Configuration Language). This process is called Infrastructure as Code (IaC), where you write code to describe the infrastructure and Terraform builds it for you. Our provider for this project is **Azure Kubernetes Service (AKS);** thus, Terraform will be responsible for creating the AKS cluster where Cilium will be deployed.

### How does Terraform work?
- **Configuration files:** Terraform uses configuration files written in HashiCorp Configuration Language (HCL) to define what infrastructure you need. These files are like blueprints that describe everything Terraform needs to build your environment.
- **Providers:** Terraform interacts with different providers (like AWS, **Azure**, or Google Cloud) to create resources. In this project, we use the Azure (AKS) provider to set up our Kubernetes cluster
- **Commands:** You use simple commands in the terminal to:
  - **Initialize** Terraform (command: terraform init) – This prepares Terraform to work in your project, downloading any necessary plugins or dependencies
  - **Plan** the changes (command: terraform plan) – This shows you what changes Terraform will make based on your configuration files
  - **Apply** the changes (command: terraform apply) – This actually creates or updates the infrastructure as defined in your files. Terraform reads your code and interacts with the cloud provider to create or modify the resources
  - **Destroy** the infrastructure (command: terraform destroy) – This removes all the resources Terraform created, so you don’t leave any resources running unnecessarily. **Very important:** You MUST run "terraform destroy" every time you are done using the cluster you just created to avoid leaving resources running and incurring unnecessary costs 

## Deploying Kubernetes and Cilium with Terraform on Azure

## Breakdown of files:
- main.tf
- variables.tf
- versions.tf
- terrform.tfvars

## 1. main.tf

### Purpose:
the 'main.tf' file contains the primary configuration for deploying resources on Azure. It defines the infrastructure components, including the virtual network, subnets, and Kubernetes cluster.

### Components:
- **Resource Group Data Source**
  ```hcl
  data "azurerm_resource_group" "rg" {
    name = "RCOS-Cilium_group"
  }
This block retrieves information about an existing Azure resource group named RCOS-Cilium_group. It’s used to reference the resource group in other resource definitions.
- **Virtual Network**
  ```hcl
  resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  address_space       = ["10.0.0.0/8"]
  location            = var.RESOURCE_GROUP_LOCATION
  resource_group_name = data.azurerm_resource_group.rg.name
  }
This block creates an Azure Virtual Network (VNet) with a specified address space. It’s used to host the subnets for Kubernetes.
- **Subnets**
  ```hcl
  resource "azurerm_subnet" "subnet" {
  name                 = "test-subnet"
  address_prefixes     = ["10.240.0.0/16"]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  }

  resource "azurerm_subnet" "podsubnet" {
    name                 = "pod-subnet"
    resource_group_name  = data.azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.241.0.0/16"]
  }
These blocks create subnets within the VNet. test-subnet is for general use, and pod-subnet is specifically for Kubernetes pods.
- **Kubernetes Cluster**
  ```hcl
  resource "azurerm_kubernetes_cluster" "default" {
  name                = "test-cilium-aks"
  location            = var.RESOURCE_GROUP_LOCATION
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "test-cilum-k8s"
  kubernetes_version  = "1.29.4"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_A2_v2"
    os_disk_size_gb = 30
    vnet_subnet_id  = azurerm_subnet.subnet.id
    pod_subnet_id   = azurerm_subnet.podsubnet.id
  }

  service_principal {
    client_id     = var.CLIENT_ID
    client_secret = var.CLIENT_SECRET
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin  = "azure"
    ebpf_data_plane = "cilium"
  }
  }
This block sets up an Azure Kubernetes Service (AKS) cluster with Cilium as the networking plugin. It includes settings for the node pool, service principal, and network profile

## 2. variables.tf
### purpose:
The 'variables.tf' file defines the variables used in the Terraform configuration. Variables allow you to customize and parameterize the deployment
### components
- **Client Secret**
  ```hcl
  variable "CLIENT_SECRET" {
  type        = string
  description = "Password for the azure cli user"
  }
 Defines the password for the Azure CLI user
- **Client ID**
  ```hcl
  variable "CLIENT_ID" {
  type        = string
  description = "appId for the azure cli user"
  }
 Specifies the application ID for the Azure CLI user
 - **Tenant ID**
   ```hcl
   variable "TENANT_ID" {
   type        = string
   description = "tenant id for the rcos-cilium_group resource group"
   }
 The tenant ID for the resource group
 - **Subscription ID**
   ```hcl
   variable "SUBSCRIPTION_ID" {
   type        = string
   description = "subscription id for the rcos-cilium_group resource group"
   }
  The Azure subscription ID for the resource group
 - **Resource Group Location**
   ```hcl
   variable "RESOURCE_GROUP_LOCATION" {
   type        = string
   description = "location for the rcos-cilium resource group"
   }
  Specifies the location where the resource group and resources will be deployed
## 3. versions.tf
### Purpose:
The 'versions.tf' file specifies the Terraform provider versions and Terraform version requirements

### Components:
- **Provider Requirements**
  ```hcl
  terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.67.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.14.0"
    }
  }

  required_version = ">= 1.1.0"
  }
This block defines the providers required for the configuration (azapi, azurerm, and helm) and their versions, as well as the minimum Terraform version required
- **Provider Congifuration**
  ```hcl
  provider "azurerm" {
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
  features {}
  }
Configures the Azure provider with credentials and subscription details



   






 

## Creating Variable Sets With HCP Vault

You can configure variables directly via terraform.io or via command line. 

To configure on web app:

1. Open terraform.io in browser
2. Select the "Try HCP Terraform" box
3. When redirected to Organizations page, select your organization ("RCOS-Cilium") and navigate to the left-hand side "Variables" tab;
   
   or, navigate to the following link: https://app.terraform.io/app/RCOS-Cilium/settings/varsets/new. Here, you can create a new variable set.
4. Configure Settings:
   - Name: the name of your variable set
   - Optional description: may include purpose, scope, context, security considerations, maintenance instructions, etc.
5. Variable Set Scope
   - When to select "Apply globally":
     - If the variables in the set are to be used across multiple Terraform projects or workspaces within the organization; e.g. organization-wide credentials for cloud providers
     - If you need to enforce consistent configurations or credentials across various projects
     - If security risks or the handling of sensitive information is not of high priority
   - When to select "Apply to specific projects and workspaces":
     - If the variables are specific to a particular project or set of projects and are not applicable or necessary for other projects
     - If different projects have unique requirements and configurations that shouldn't be applied universally
     - If the variables contain sensitive information and you want to limit access to specific teams or projects
6. Variable set priority
   - determines how conflicting variable values are resolved when multiple variable sets are applied to a workspace; values in priority variable sets overwrite any variables with the same key set at more specific scopes
   - "Prioritize the variable values in this variable set" if:
     - the variables in this set are critical and should always take precedence over variables defined in other sets/variable overlaps
     - If you need to ensure that certain values are consistently applied across different workspaces or projects, even if other variable sets are defined with more specific scopes
7. Variables
   - Terraform variable:
     - defined within Terraform configuration (.tf) files, typically "variables.tf"
     - Set via terraform.tfvars files and referenced with the "var." prefix
     - Used for configuration values that are part of the Terraform infrastructure code itself and for variables that need to be referenced within Terraform configuration files, allowing for parameterizing and managing your infrastructure as code
   - Environment variables:
     - prefixed with "TF_VAR_" followed by its name
     - Set in your operating system or CI/CD pipeline
     - Used for sensitive or system-specific values, e.g. credentials, access tokens, and configuration settings that should not be hard-coded in your Terraform files

