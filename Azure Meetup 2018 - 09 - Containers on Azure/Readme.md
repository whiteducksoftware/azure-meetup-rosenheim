# Container on Azure Kubernetes Services

- Setup Azure Container Registry (ACR)
- Setup Azure Kubernetes Services (AKS)
- Setup Visual Studio Team Services (VSTS)

Uses Azure Command Line Interface (https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

## Setup Container Registry (ACR)
Docs: https://docs.microsoft.com/en-us/cli/azure/acr?view=azure-cli-latest#az-acr-create  
Create Container Registry
```
az create \
    -n <<name>> \
    -g <<resource group>> \
    --sku <<Basic | Classic | Premium | Standard>>
```

Login into Registry
```
az acr login \
    -n <<NAME>>
```

If you work with multiple subscriptions, you may have to set your default subscription first. e. g. :
```
az account list
az account set --subscription <<subscriptionid from above cmd>>
```

Create Service Principal for communication between ACR and AKS
```
az ad sp create-for-rbac \
    --skip-assignment
```

Output of Command
```json
{
  "appId": "e7596ae3-6864-4cb8-94fc-20164b1588a9",
  "displayName": "azure-cli-2018-06-29-19-14-37",
  "name": "http://azure-cli-2018-06-29-19-14-37",
  "password": "52c95f25-bd1e-4314-bd31-d8112b293521",
  "tenant": "72f988bf-86f1-41af-91ab-2d7cd011db48"
}
```

Get Container Registry Id (acrId)
```
az acr show \
    -g <<resource group>> \
    -n <<acr name>> \
    --query "id" \
    -o tsv
```

Create Role assignemnt for access to ACR
```
az role assignment create \
    --assignee <<appId>> \
    --scope <<acrId>> \
    --role Reader
```

Get Container Registry URL
```
az acr list \
    -g <<resource group>> \
    --query "[].{acrUrl:loginServer}" \
    -o table
```

Build image and push it
```
az acr login -n <<acr name>>
```
```
docker build -t <<acr url>>/<<image name>>:<<tag>> <<context>>
docker push <<acr url>>/<<image name>>:<<tag>> <<context>>
```

## Setup Azure Kubernetes Services (AKS)
Docs: https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster  
Create AKS Cluster (single node)
```
az aks create \
    -g <<resource group>> \
    -n <<name>> \
    --node-count 1 \
    --service-principal <<sp appId>> \
    --client-secret <<sp password>> \
    --generate-ssh-keys
```

Install Kubernetes CLI (kubectl) and authenticate
```
az aks install-cli
```
```
az aks get-credentials
    -g <<resource group>>
    -n <<name>>
```

You can now access the dashboard using
```
az aks browse -n <<aksname>> -g <<resourcegroup_name>>
```

### Initially deploy images from Demo-repo  
(Replace `<<ACR URL>>` with azure container registry url in `kubernetes/deployment.yaml`)  
- Build and push frontend and backend images to the Azure Container Registry 
- Apply kubernetes configuration files
- View public IP of the `frontend` LoadBalancer

Step 1:
```
cd frontend
docker build -t <<acr url>>/container.demo.frontend .
cd ../backend
docker build -t <<acr url>>/container.demo.backend .

docker push <<acr url>>/container.demo.frontend
docker push <<acr url>>/container.demo.frontend
```

Step 2:
```
kubectl apply -f backend/kubernetes/service.yaml
kubectl apply -f backend/kubernetes/deployment.yaml
kubectl apply -f frontend/kubernetes/service.yaml
kubectl apply -f frontend/kubernetes/deployment.yaml
```

Step 3:
```
kubectl get services -w
```
Wait until `external address` changes from `<pending>` to some ip within the `whiteduck-loadbalancer`.  
Now the project is running in the Cluster and public reachable.

## Setup Visual Studio Team Services (VSTS)
Import repositories
- Import `repositories/frontend` as `container.demo.frontend`
- Import `repositories/backend` as `container.demo.backend`

Link your Azure Subscription with VSTS.

### Build configuration (Frontend & Backend):
```
Subscription: <<Linked Azure Subscription>>
Container registry type: Azure Container Registry
Container Registry: <<acr name>>
```
```
Template: Docker
Step 1: "Build Image"
    Command: build
    Dockerfile: <<Select Dockerfile from Repo>>
    Use default build context: true
    Image name: $(Build.Repository.Name):$(Build.BuildId)
    Include latest tag: true
Step 2 (Optional, for debuging): "List images"
    Command: images
Step 3: "Push Image"
    Command: push
    Image name: $(Build.Repository.Name):$(Build.BuildId)
``` 

### Deployment configuration (Frontend & Backend):
```
Subscription: <<Linked Azure Subscription>>
Container registry type: Azure Container Registry
Container Registry: <<acr name>>
```
```
Template: Docker
Artifacts
    Source: <<FRONTEND CI>> or <<BACKEND CI>>
    Trigger: true
Stage "Deploy to Kubernetes"
    Job: Kubernetes
    Command: set
    Arguments (Fronend): image deployment/whiteduck-frontend frontend=<<acr url>>/container.demo.frontend:$(Build.BuildId)
    Arguments (Backend): image deployment/whiteduck-backend api=<<acr url>>/container.demo.backend:$(Build.BuildId)
``` 
