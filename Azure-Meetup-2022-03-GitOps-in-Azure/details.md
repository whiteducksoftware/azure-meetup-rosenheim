# GitOps Meetup demo

## Pre-Requisites

- An existing AKS with MSI enabled
- Azure CLI config

### Azure CLI

```bash
# Register the AKS-ExtensionManager preview features
az feature register --namespace Microsoft.ContainerService -n AKS-ExtensionManager
# Register provider for cluster extensions
az provider register -n Microsoft.Kubernetes
az provider register -n Microsoft.ContainerService
az provider register -n Microsoft.KubernetesConfiguration
# Monitor the registration process.
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/AKS-ExtensionManager')].{Name:name,State:properties.state}"
az provider show -n Microsoft.Kubernetes -o table
az provider show -n Microsoft.KubernetesConfiguration -o table
az provider show -n Microsoft.ContainerService -o table
# Optional: Setup the Azure CLI extension for cluster extensions
az extension add -n k8s-configuration
az extension add -n k8s-extension
az extension list -o table
```

## Deploy

```bash
# What-if
 az deployment group what-if \
  --name BicepAksUpdate \
  --resource-group <RESOURCE_GROUP> \
  --template-file main.bicep \
  --parameters aksName=<AKS_NAME> stage=dev
# Deploy
az deployment group create \
  --name BicepAksUpdate \
  --resource-group <RESOURCE_GROUP> \
  --template-file main.bicep \
  --parameters aksName=<AKS_NAME> stage=dev
```

## Useful docs

- [Tutorial: Use GitOps with Flux v2 in AKS](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/tutorial-use-gitops-flux2)
- [Deploy and manage cluster extensions for AKS](https://docs.microsoft.com/en-us/azure/aks/cluster-extensions?tabs=azure-cli)
- [Cluster exensions - Overview](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/conceptual-extensions)
- [GitOps on Azure](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/conceptual-gitops-flux2)
- [AKS Addons vs Extensions](https://pixelrobots.co.uk/2022/02/azure-kubernetes-service-aks-addons-and-extensions-who-is-responsible/)
- [Microsoft.KubernetesConfiguration extensions](https://docs.microsoft.com/en-us/azure/templates/microsoft.kubernetesconfiguration/extensions?tabs=bicep)
- [Microsoft.KubernetesConfiguration fluxConfigurations](https://docs.microsoft.com/en-us/azure/templates/microsoft.kubernetesconfiguration/fluxconfigurations?tabs=bicep)
