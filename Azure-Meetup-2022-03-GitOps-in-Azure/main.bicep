
@description('The environment of the Managed Cluster resource e.g. stg, dev, prd or demo')
@allowed([
  'stg'
  'dev'
  'prd'
])
param stage string

param aksName string

// ################################
// ############# AKS ##############
// ################################

resource aksCluster 'Microsoft.ContainerService/managedClusters@2021-09-01' existing = {
  name: aksName
}

// ################################
// ############# Flux #############
// ################################

resource flux 'Microsoft.KubernetesConfiguration/extensions@2021-09-01' = {
  name: 'flux'
  scope: aksCluster
  properties: {
    autoUpgradeMinorVersion: true
    configurationProtectedSettings: {}
    configurationSettings: {
      'helm-controller.enabled': 'true' // enabled by default
      'source-controller.enabled': 'true' // enabled by default
      'kustomize-controller.enabled': 'true' // enabled by default
      'notification-controller.enabled': 'true' // enabled by default
      'image-automation-controller.enabled': 'true' // disabled by default
      'image-reflector-controller.enabled': 'true' // disabled by default
    }
    extensionType: 'microsoft.flux'
    scope: {
      cluster: {
        releaseNamespace: 'flux-system'
      }
    }
  }
}

// ################################
// ######### Flux Config ##########
// ################################

resource fluxConfig 'Microsoft.KubernetesConfiguration/fluxConfigurations@2022-01-01-preview' = {
  name: 'flux-config'
  scope: aksCluster
  dependsOn: [
    flux
  ]
  properties: {
    scope: 'cluster'
    namespace: 'flux-system'
    sourceKind: 'GitRepository'
    suspend: false

    gitRepository: {
      url: 'https://github.com/whiteducksoftware/fluxcd-example'
      timeoutInSeconds: 600
      syncIntervalInSeconds: 600
      repositoryRef: {
        branch: 'main'
      }

    }
    kustomizations: {
      cluster: {
        path: './clusters/${stage}'
        dependsOn: []
        timeoutInSeconds: 600
        syncIntervalInSeconds: 600
        prune: true
      }
    }
  }
}
