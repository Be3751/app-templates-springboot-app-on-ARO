@minLength(5)
@maxLength(37)
@description('Provide a base name for your Azure Container Registry')
param acrName string

@description('Provide a location for the registry.')
param location string

@description('Provide a tier of your Azure Container Registry.')
param acrSku string

// Generate a unique suffix if none provided
var uniqueSuffix = uniqueString(resourceGroup().id, acrName)
var finalAcrName = '${acrName}${uniqueSuffix}'

resource acrResource 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: finalAcrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
  }
}

@description('Output the login server property for later use')
output loginServer string = acrResource.properties.loginServer
