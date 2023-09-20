@minLength(5)
@maxLength(24)
@description('StorageName must have min 5 chars and a max of 24 chars')

param storageName string
param location string = 'northeurope'


resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
