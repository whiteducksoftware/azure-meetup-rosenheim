# Meetup preparation

## 03.02.2020 Azure Rückblick 2019 und was 2020 auf uns wartet

Agenda: - The biggest Announcements of 2019 - What we are waiting for in 2020 - How to stay up to date

```PowerShell
$announcements = for($i=1; $i -le 12; $i++) {
      $month = "{0:d2}" -f $i

      for($n=1; $n -le 100; $n++) {
          $result = Invoke-RestMethod -Method Get -Uri ('https://azure.microsoft.com/en-us/updates/2019/{0}/?Page={1}' -f $month, $n)
            if ($result -match 'No updates match this query.') {
                break
            }
            [regex]::Matches($result, 'text-body2.*href="(.+)">(.+)<\/a>') |
                ForEach-Object {
                    [PsCustomObject]@{
                        Announcement = $_.Groups[2]
                        Link = 'https://azure.microsoft.com{0}' -f $_.Groups[1]
                    }
                }
      }
}
```

## Most important Azure announcements for developers in 2019

### Januar

- [General availability: Azure Data Box Disk](https://azure.microsoft.com/en-us/updates/generally-available-azure-data-box-disk/)

### February

- [General availability: Azure Lab Services](https://azure.microsoft.com/en-us/updates/announcing-the-general-availability-of-azure-lab-services/)
- [Azure Functions, Java Support GA](https://azure.microsoft.com/en-us/updates/azure-functions-java-support-ga/)
- [New features are now generally available in Event Grid](https://azure.microsoft.com/en-us/updates/new-features-are-now-generally-available-in-event-grid/)
- [Azure Monitor status blog is now available](https://azure.microsoft.com/en-us/updates/azure-monitor-status-blog-is-now-available/)
- [Azure PowerShell – Cross-platform “Az” module replacing “AzureRM”](https://azure.microsoft.com/en-us/blog/azure-powershell-cross-platform-az-module-replacing-azurerm/)
- [Azure Automation supports the Azure PowerShell Az module](https://azure.microsoft.com/en-us/updates/azure-automation-supports-the-azure-powershell-az-module/)
- [General Availability: Azure Data Explorer](https://azure.microsoft.com/en-us/updates/general-availability-azure-data-explorer/)
- [Azure Cost Management is now generally available for EA customers](https://azure.microsoft.com/en-us/updates/azure-cost-management-is-now-generally-available-for-ea-customers/)

### March

- [Azure premium blob storage is now generally available](https://azure.microsoft.com/en-us/updates/azure-premium-blob-storage-is-now-generally-available/)
- [Azure Resource Manager template language additions](https://azure.microsoft.com/en-us/updates/azure-resource-manager-template-language-additions/)

### April

- [Azure Front Door Service is now available](https://azure.microsoft.com/en-us/updates/azure-front-door-service-is-now-available/)
- [App Service Migration Assistant for ASP.NET applications is now available](https://azure.microsoft.com/en-us/updates/app-service-migration-assistant-for-asp-net-applications-is-now-available/)

## May

- [Advanced filtering generally available in Event Grid](https://azure.microsoft.com/en-us/updates/advanced-filtering-generally-available-in-event-grid/)
- [General Availability: Azure Dev Spaces](https://azure.microsoft.com/en-us/updates/general-availability-azure-dev-spaces/)
- [Azure Red Hat OpenShift now available](https://azure.microsoft.com/en-us/updates/azure-red-hat-openshift-now-available/)
- [Microsoft Authentication Library for Javascript](https://azure.microsoft.com/en-us/updates/microsoft-authentication-library-for-javascript/)
- [Azure now supports GitHub identity single sign-on](https://azure.microsoft.com/en-us/updates/azure-now-supports-github-identity-single-sign-on/)
- [User-defined network policy in Azure Kubernetes Service (AKS) is now available](https://azure.microsoft.com/en-us/updates/user-defined-network-policy-in-azure-kubernetes-service-aks-is-now-available/)
- [Azure Kubernetes Service (AKS) virtual node is now available](https://azure.microsoft.com/en-us/updates/azure-kubernetes-service-aks-virtual-node-is-now-available/)
- [Azure Container Registry content trust is now available](https://azure.microsoft.com/en-us/updates/azure-container-registry-content-trust-is-now-available/)
- [Azure Container Registry tag locking policy is now generally available](https://azure.microsoft.com/en-us/updates/azure-container-registry-tag-locking-policy-is-now-generally-available/)

## June

- [Azure Premium Files is now generally available](https://azure.microsoft.com/en-us/updates/azure-premium-files-is-now-generally-available/)

## July

- [Azure Resource Graph is now generally available](https://azure.microsoft.com/en-us/updates/azure-resource-graph-is-now-generally-available/)
- [Introducing the Microsoft Cloud Adoption Framework for Azure](https://azure.microsoft.com/en-us/updates/introducing-the-microsoft-cloud-adoption-framework-for-azure/)
- [Introducing Azure Lighthouse](https://azure.microsoft.com/en-us/updates/introducing-azure-lighthouse/)

## August

- [Azure Function Consumption plan for Linux is now available](https://azure.microsoft.com/en-us/updates/azure-function-consumption-plan-for-linux-is-now-available/)
- [Python support in Azure Functions is now available](https://azure.microsoft.com/en-us/updates/python-support-in-azure-functions-is-now-available/)
- [General availability of Managed Identity for Linux in App Service and Functions](https://azure.microsoft.com/en-us/updates/general-availablility-of-managed-identity-for-linux-in-app-service-and-functions/)
- [General availability of user-assigned managed identities for App Service and Azure Functions](https://azure.microsoft.com/en-us/updates/general-availability-of-user-assigned-managed-identities-for-app-service-and-azure-functions/)
- [Custom OpenID Connect identity providers for user flows in Azure AD B2C](https://azure.microsoft.com/en-us/updates/custom-openid-connect-identity-providers-for-user-flows-in-azure-ad-b2c/)
- [Microsoft Azure Ultra Disks now generally available](https://azure.microsoft.com/en-us/updates/microsoft-azure-ultra-disks-general-availability/)

## September

- [Egress lockdown in Azure Kubernetes Service (AKS) is now generally available](https://azure.microsoft.com/en-us/updates/egress-lockdown-in-azure-kubernetes-service-aks-is-now-generally-available/)
- [New Azure ExpressRoute sites now available](https://azure.microsoft.com/en-us/updates/new-azure-expressroute-sites-now-available/)
- [Microsoft Azure available from new cloud regions in Germany](https://azure.microsoft.com/en-us/updates/microsoft-azure-available-from-new-cloud-regions-in-germany/)

## October

- [Variable retention for Azure Monitor Application Insights is now generally available](https://azure.microsoft.com/en-us/updates/variable-retention-for-azure-monitor-application-insights-is-now-generally-available/)
- [Key Vault references in App Service and Azure Functions are now available](https://azure.microsoft.com/en-us/updates/general-availability-of-key-vault-references-in-app-service-and-azure-functions/)
- [Azure DNS private zones is now generally available](https://azure.microsoft.com/en-us/updates/azure-dns-private-zones-is-now-generally-available/)
- [Standard Load Balancers in Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/updates/standard-load-balancers-in-azure-kubernetes-service-aks/)

## November

- [GitHub Actions for Azure are now generally available](https://azure.microsoft.com/en-us/updates/github-actions-for-azure-are-now-generally-available/)
- [Azure Private Link is now available in all regions](https://azure.microsoft.com/en-us/updates/azure-private-link-is-now-available-in-all-regions/)
- [Azure Monitor Workbooks is now generally available](https://azure.microsoft.com/en-us/updates/azure-monitor-workbooks-is-now-generally-available/)
- [Generally Available: AKS cluster autoscaler](https://azure.microsoft.com/en-us/updates/generally-available-aks-cluster-autoscaler/)
- [General availability: Azure Container Registry OCI artifact support](https://azure.microsoft.com/en-us/updates/general-availability-azure-container-registry-oci-artifact-support/)
- [Generally available: Azure Data Share](https://azure.microsoft.com/en-us/updates/now-available-azure-data-share/)
- [Support for multiple node pools in Azure Kubernetes Service is now available](https://azure.microsoft.com/en-us/updates/support-for-multiple-node-pools-in-azure-kubernetes-service-is-now-available/)
- [Azure SQL Database serverless is now generally available](https://azure.microsoft.com/en-us/updates/azure-sql-database-serverless-is-now-generally-available/)
- [Azure Kubernetes Service (AKS) support for Azure Availability Zones is now available](https://azure.microsoft.com/en-us/updates/azure-kubernetes-service-aks-support-for-azure-availability-zones-is-now-available/)
- [Azure Bastion is now generally available](https://azure.microsoft.com/en-us/updates/azure-bastion-is-now-generally-available/)
- [PowerShell support in Azure Functions is now generally available](https://azure.microsoft.com/en-us/updates/powershell-support-in-azure-functions-is-now-generally-available/)
- [Azure Functions Premium plan is now generally available](https://azure.microsoft.com/en-us/updates/azure-functions-premium-plan-is-now-generally-available/)

## December

- [Azure Dedicated Hosts now generally available](https://azure.microsoft.com/en-us/updates/azure-dedicated-hosts-now-generally-available/)
- [Proximity placement groups are now available](https://azure.microsoft.com/en-us/updates/proximity-placement-groups-are-now-available/)
- [Azure Functions 3.0 go-live release is now available](https://azure.microsoft.com/en-us/updates/announcing-go-live-release-for-azure-functions-v3/)
- [Use GitHub Actions to trigger a run in Azure Pipelines](https://azure.microsoft.com/en-us/updates/use-github-actions-to-trigger-a-run-in-azure-pipelines/)
- [Azure Active Directory B2C is deprecating login.microsoftonline.com](https://azure.microsoft.com/en-us/updates/b2c-deprecate-msol/)

## Januar 2020

- [Azure Functions runtime 3.0 is now generally available](https://azure.microsoft.com/en-us/updates/azure-functions-runtime-30-is-now-available/)
