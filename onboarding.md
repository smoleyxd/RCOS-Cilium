 #Documentation file to organize Heather's learning and give new members easy access to core onboarding information

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

