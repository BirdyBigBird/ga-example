param location string = 'northeurope'
param storageName string = 'ubuntudrive1904'

param namePrefix string = 'interweb'

param dockerImage string = 'ubuntu/nginx' //'nginxdemos/hello'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

//how do consume modules
module storage 'modules/storage.bicep' = {
  name: storageName
  params: {
    storageName: storageName
    location: location
  }
}

module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: '${namePrefix}-appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location

  }
}

module deployWebsite 'modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-website'
  params: {
    location: location
    appPlanId: appPlanDeploy.outputs.planId
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
  }

}
output siteUrl string = deployWebsite.outputs.siteUrl

// param location string = 'northeurope'
// param storageName string = 'gastorage1904'


// resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
//   name: storageName
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Premium_LRS'
//   }
// }
