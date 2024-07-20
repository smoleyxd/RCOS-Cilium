 #Documentation file to organize Heather's learning and give new members easy access to core onboarding information; I've already written a bulk of info elsewhere, just need to transfer it

Creating Variable Sets With HCP Vault

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

