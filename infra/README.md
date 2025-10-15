# Infrastructure as Code

This directory is reserved for Infrastructure as Code (IaC) files for deploying Azure resources.

## Planned Resources

### Azure Resources to Deploy
- **Azure Function App**: Serverless compute for running the function app
- **Azure Storage Account**: For function app storage and CSV file uploads
- **Application Insights**: For monitoring and logging
- **App Service Plan**: Consumption plan for serverless execution

## Deployment Options

### Option 1: Azure CLI
Use Azure CLI commands to deploy resources. Example scripts will be added here.

### Option 2: Terraform
Infrastructure as Code using Terraform for reproducible deployments.

### Option 3: Bicep/ARM Templates
Azure-native IaC using Bicep or ARM templates.

### Option 4: Azure Portal
Manual deployment through Azure Portal (not recommended for production).

## Getting Started

1. Choose your preferred IaC tool
2. Create configuration files in this directory
3. Update GitHub Actions workflow to deploy infrastructure
4. Configure secrets in GitHub repository settings

## Required Secrets

For GitHub Actions deployment, configure these secrets in your repository:
- `AZURE_FUNCTIONAPP_PUBLISH_PROFILE`: Publish profile from Azure Portal
- `AZURE_CREDENTIALS`: Service Principal credentials (if using Azure CLI)
- `AZURE_SUBSCRIPTION_ID`: Your Azure subscription ID

## Next Steps

- [ ] Choose IaC tool (Terraform, Bicep, or Azure CLI)
- [ ] Create resource configuration files
- [ ] Set up Azure service principal
- [ ] Configure GitHub secrets
- [ ] Update CI/CD pipeline with deployment steps

## Example Structure (Terraform)

```
infra/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── terraform.tfvars     # Variable values (gitignored)
└── README.md           # This file
```

## Example Structure (Bicep)

```
infra/
├── main.bicep          # Main Bicep template
├── parameters.json     # Parameters file (gitignored)
└── README.md          # This file
```

## Resources

- [Azure Functions Deployment](https://learn.microsoft.com/en-us/azure/azure-functions/functions-deployment-technologies)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Bicep Documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
