param location string = 'westeurope'

param namePrefix string = 'itosx'
param appPlanId string

param dockerImage string = 'ubuntu/nginx'
param dockerImageTag string = 'latest'


resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: '${namePrefix}-site'
  location: location
  
  properties: {
    serverFarmId:appPlanId
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVICE_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
    }
    httpsOnly: true
  }
}


output siteUrl string = webApplication.properties.hostNames[0]
