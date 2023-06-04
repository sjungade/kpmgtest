// Parameters
param parInstanceNumber string = '01'
param parLocation string = resourceGroup().location
param parBase string = utcNow()


// Variables
var varNamePrefix = replace((replace(resourceGroup().name, '-rg','')),'-', '')
// Resources

// Loganalytics Workspace
module modloganalyticsWorkspace 'resources/loganalytics.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-la'
  params: {
    name: '${varNamePrefix}${parInstanceNumber}-la'
    location: parLocation
  }
}

// Nsg
resource resNsg 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: '${varNamePrefix}${parInstanceNumber}-nsg'
}


// Vnet
module modVirtualNetworks './resources/vnet.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-vnet'
  params: {
    // Required parameters
    addressPrefixes: [
      '10.5.0.0/16'
    ]
    location: parLocation
    name: '${varNamePrefix}-${parInstanceNumber}-vnet'
    lock: 'CanNotDelete'
    subnets: [
      {
        addressPrefix: '10.5.255.0/24'
        name: 'AppGway-sn'
        privateEndpointNetworkPolicies: 'Disabled'
        privateLinkServiceNetworkPolicies: 'Enabled'
      }
      {
        addressPrefix: '10.5.0.0/24'
        name: 'storage-sn'
        networkSecurityGroupId: resNsg.id
        privateEndpointNetworkPolicies: 'Disabled'
        privateLinkServiceNetworkPolicies: 'Enabled'
        serviceEndpoints: [
          {
            service: 'Microsoft.Storage'
          }
          {
            service: 'Microsoft.Sql'
          }
        ]
      }
      {
        addressPrefix: '10.5.3.0/24'
        name: 'webapp-sn'
        networkSecurityGroupId: resNsg.id
        privateEndpointNetworkPolicies: 'Disabled'
        privateLinkServiceNetworkPolicies: 'Enabled'
        serviceEndpoints: [
          {
            service: 'Microsoft.Sites'
          }
        ]
      }
      {
        addressPrefix: '10.5.6.0/24'
        name: 'Cosmos-sn'
        privateEndpointNetworkPolicies: 'Disabled'
        privateLinkServiceNetworkPolicies: 'Enabled'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      Owner: 'Test'
    }
  }
}

// kv

module modKv 'resources/kv.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-kv' 
  params: {
    name: '${varNamePrefix}-${parInstanceNumber}-kv'
    location: parLocation
    diagnosticWorkspaceId: modloganalyticsWorkspace.outputs.resourceId
  }
}

// storage 

module modStorageAccount 'resources/storage.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-saac'
  params: {
    name: '${varNamePrefix}-${parInstanceNumber}-sacc'
    location: parLocation
    diagnosticWorkspaceId: modloganalyticsWorkspace.outputs.resourceId
  }
}

// application gateway

module modApplicationGateway 'resources/appgway. main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-agw'
  params: {
    name: '${varNamePrefix}-${parInstanceNumber}-agw'
    location: parLocation
    diagnosticWorkspaceId: modloganalyticsWorkspace.outputs.resourceId
  }
}
//cosmos account

module modCosmosAccount 'resources/cosmosaccount.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-cosact'
  params: {
    location: parLocation
    locations: [ parLocation ]
    name: '${varNamePrefix}-${parInstanceNumber}-cosact'
    diagnosticWorkspaceId: modloganalyticsWorkspace.outputs.resourceId
  }
}
// cosmos database

module modCosmosDatabase 'resources/cosmosdb.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-cosdb'
  params: {
    databaseAccountName: modCosmosAccount.outputs.name 
    name: '${varNamePrefix}-${parInstanceNumber}-cosdb'
  }
}
// cosmos container

module modCosmosContainer 'resources/cosmoscontainer.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-coscontainer'
  params: {
    databaseAccountName: modCosmosAccount.outputs.name
    name: '${varNamePrefix}-${parInstanceNumber}-coscontainer'
    sqlDatabaseName: modCosmosDatabase.outputs.name
  }
}

// App service plan

module modAppServicePlan 'resources/appserviceplan.bicep' = {
  name: '${parBase}-${parInstanceNumber}-asp'
  params: {
    location: parLocation
    name: '${varNamePrefix}-${parInstanceNumber}-asp'
      sku: {
        name: 'P1v2'
        tier: 'PremiumV2'
        size: 'P1v2'
        family: 'Pv2'
        capacity: 1
    }
    diagnosticWorkspaceId: modloganalyticsWorkspace.outputs.resourceId
  }
}
// webapp 

module modWebapp 'resources/webapps.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-webapp'
  params: {
    name: '${varNamePrefix}-${parInstanceNumber}-webapp'
    kind: 'app'
    location: parLocation
    serverFarmResourceId: modAppServicePlan.outputs.resourceId
    diagnosticWorkspaceId: modloganalyticsWorkspace.outputs.resourceId 
  }
}

// Cosmos Private Endpoint
module modCosmosPep 'resources/privateendpoint.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-cospep'
  params: {
    groupIds: [ 'Cosmos' ]
    location: parLocation
    name: '${varNamePrefix}-${parInstanceNumber}-cospep'
    serviceResourceId: modCosmosAccount.outputs.resourceId
    subnetResourceId: modVirtualNetworks.outputs.subnetResourceIds[3]
  }
}
// Storage Private endpoint

module modStoragePep 'resources/privateendpoint.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-saac-pep'
  params: {
    groupIds: [ 'Blob' ]
    location: parLocation
    name: '${varNamePrefix}-${parInstanceNumber}-sacc-pep'
    serviceResourceId: modStorageAccount.outputs.resourceId 
    subnetResourceId: modVirtualNetworks.outputs.subnetResourceIds[1]
  }
}
// Webapp Private Endpoint

module modWebappPep 'resources/privateendpoint.main.bicep' = {
  name: '${parBase}-${parInstanceNumber}-webapp-pep' 
  params: {
    groupIds: [ 'Webapp']
    location: parLocation
    name: '${varNamePrefix}-${parInstanceNumber}-webapp-pep'
    serviceResourceId: modWebapp.outputs.resourceId
    subnetResourceId: modVirtualNetworks.outputs.subnetResourceIds[2]
  }
}

// Output
