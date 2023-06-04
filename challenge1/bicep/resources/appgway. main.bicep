@description('Name of the Application Gateway.')
@maxLength(80)
param name string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The ID(s) to assign to the resource.')
param userAssignedIdentities object = {}

@description('Authentication certificates of the application gateway resource.')
param authenticationCertificates array = []

@description('Upper bound on number of Application Gateway capacity.')
param autoscaleMaxCapacity int = -1

@description('Lower bound on number of Application Gateway capacity.')
param autoscaleMinCapacity int = -1

@description('Backend address pool of the application gateway resource.')
param backendAddressPools array = []

@description('Backend http settings of the application gateway resource.')
param backendHttpSettingsCollection array = []

@description('Custom error configurations of the application gateway resource.')
param customErrorConfigurations array = []

@description('Whether FIPS is enabled on the application gateway resource.')
param enableFips bool = false

@description('Whether HTTP2 is enabled on the application gateway resource.')
param enableHttp2 bool = false

@description('The resource ID of an associated firewall policy. Should be configured for security reasons.')
param firewallPolicyId string = ''

@description('Frontend IP addresses of the application gateway resource.')
param frontendIPConfigurations array = []

@description('Frontend ports of the application gateway resource.')
param frontendPorts array = []

@description('Subnets of the application gateway resource.')
param gatewayIPConfigurations array = []

@description('Enable request buffering.')
param enableRequestBuffering bool = false

@description('Enable response buffering.')
param enableResponseBuffering bool = false

@description('Http listeners of the application gateway resource.')
param httpListeners array = []

@description('Load distribution policies of the application gateway resource.')
param loadDistributionPolicies array = []

@description('PrivateLink configurations on application gateway.')
param privateLinkConfigurations array = []

@description('Probes of the application gateway resource.')
param probes array = []

@description('Redirect configurations of the application gateway resource.')
param redirectConfigurations array = []

@description('Request routing rules of the application gateway resource.')
param requestRoutingRules array = []

@description('Rewrite rules for the application gateway resource.')
param rewriteRuleSets array = []

@description('The name of the SKU for the Application Gateway.')
@allowed([
  'Standard_Small'
  'Standard_Medium'
  'Standard_Large'
  'WAF_Medium'
  'WAF_Large'
  'Standard_v2'
  'WAF_v2'
])
param sku string = 'WAF_Medium'

@description('The number of Application instances to be configured.')
@minValue(1)
@maxValue(10)
param capacity int = 2

@description('SSL certificates of the application gateway resource.')
param sslCertificates array = []

@description('Ssl cipher suites to be enabled in the specified order to application gateway.')
@allowed([
  'TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA'
  'TLS_DHE_DSS_WITH_AES_128_CBC_SHA'
  'TLS_DHE_DSS_WITH_AES_128_CBC_SHA256'
  'TLS_DHE_DSS_WITH_AES_256_CBC_SHA'
  'TLS_DHE_DSS_WITH_AES_256_CBC_SHA256'
  'TLS_DHE_RSA_WITH_AES_128_CBC_SHA'
  'TLS_DHE_RSA_WITH_AES_128_GCM_SHA256'
  'TLS_DHE_RSA_WITH_AES_256_CBC_SHA'
  'TLS_DHE_RSA_WITH_AES_256_GCM_SHA384'
  'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA'
  'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256'
  'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256'
  'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA'
  'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384'
  'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384'
  'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA'
  'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256'
  'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'
  'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA'
  'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384'
  'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384'
  'TLS_RSA_WITH_3DES_EDE_CBC_SHA'
  'TLS_RSA_WITH_AES_128_CBC_SHA'
  'TLS_RSA_WITH_AES_128_CBC_SHA256'
  'TLS_RSA_WITH_AES_128_GCM_SHA256'
  'TLS_RSA_WITH_AES_256_CBC_SHA'
  'TLS_RSA_WITH_AES_256_CBC_SHA256'
  'TLS_RSA_WITH_AES_256_GCM_SHA384'
])
param sslPolicyCipherSuites array = [
  'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384'
  'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'
]

@description('Ssl protocol enums.')
@allowed([
  'TLSv1_0'
  'TLSv1_1'
  'TLSv1_2'
  'TLSv1_3'
])
param sslPolicyMinProtocolVersion string = 'TLSv1_2'

@description('Ssl predefined policy name enums.')
@allowed([
  'AppGwSslPolicy20150501'
  'AppGwSslPolicy20170401'
  'AppGwSslPolicy20170401S'
  'AppGwSslPolicy20220101'
  'AppGwSslPolicy20220101S'
  ''
])
param sslPolicyName string = ''

@description('Type of Ssl Policy.')
@allowed([
  'Custom'
  'CustomV2'
  'Predefined'
])
param sslPolicyType string = 'Custom'

@description('SSL profiles of the application gateway resource.')
param sslProfiles array = []

@description('Trusted client certificates of the application gateway resource.')
param trustedClientCertificates array = []

@description('Trusted Root certificates of the application gateway resource.')
param trustedRootCertificates array = []

@description('URL path map of the application gateway resource.')
param urlPathMaps array = []

@description('Application gateway web application firewall configuration. Should be configured for security reasons.')
param webApplicationFirewallConfiguration object = {}

@description('A list of availability zones denoting where the resource needs to come from.')
param zones array = []

@description('Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.')
@minValue(0)
@maxValue(365)
param diagnosticLogsRetentionInDays int = 365

@description('Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
param diagnosticStorageAccountId string = ''

@description('Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
param diagnosticWorkspaceId string = ''

@description('Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
param diagnosticEventHubAuthorizationRuleId string = ''

@description('Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
param diagnosticEventHubName string = ''

@description('The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.')
@allowed([
  'allLogs'
  'ApplicationGatewayAccessLog'
  'ApplicationGatewayPerformanceLog'
  'ApplicationGatewayFirewallLog'
])
param diagnosticLogCategoriesToEnable array = [
  'allLogs'
]

@description('The name of metrics that will be streamed.')
@allowed([
  'AllMetrics'
])
param diagnosticMetricsToEnable array = [
  'AllMetrics'
]

var identityType = !empty(userAssignedIdentities) ? 'UserAssigned' : 'None'

var identity = identityType != 'None' ? {
  type: identityType
  userAssignedIdentities: !empty(userAssignedIdentities) ? userAssignedIdentities : null
} : null

@description('The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".')
param diagnosticSettingsName string = ''

var diagnosticsLogsSpecified = [for category in filter(diagnosticLogCategoriesToEnable, item => item != 'allLogs'): {
  category: category
  enabled: true
  retentionPolicy: {
    enabled: true
    days: diagnosticLogsRetentionInDays
  }
}]

var diagnosticsLogs = contains(diagnosticLogCategoriesToEnable, 'allLogs') ? [
  {
    categoryGroup: 'allLogs'
    enabled: true
    retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
    }
  }
] : diagnosticsLogsSpecified

var diagnosticsMetrics = [for metric in diagnosticMetricsToEnable: {
  category: metric
  timeGrain: null
  enabled: true
  retentionPolicy: {
    enabled: true
    days: diagnosticLogsRetentionInDays
  }
}]

@allowed([
  ''
  'CanNotDelete'
  'ReadOnly'
])
@description('Specify the type of lock.')
param lock string = ''

@description('Resource tags.')
param tags object = {}

@description('Backend settings of the application gateway resource. For default limits, see [Application Gateway limits](https://learn.microsoft.com/en-us/azure/azure-subscription-service-limits#application-gateway-limits).')
param backendSettingsCollection array = []

@description('Listeners of the application gateway resource. For default limits, see [Application Gateway limits](https://learn.microsoft.com/en-us/azure/azure-subscription-service-limits#application-gateway-limits).')
param listeners array = []

@description('Routing rules of the application gateway resource.')
param routingRules array = []

resource applicationGateway 'Microsoft.Network/applicationGateways@2022-07-01' = {
  name: name
  location: location
  tags: tags
  identity: identity
  properties: union({
      authenticationCertificates: authenticationCertificates
      autoscaleConfiguration: autoscaleMaxCapacity > 0 && autoscaleMinCapacity >= 0 ? {
        maxCapacity: autoscaleMaxCapacity
        minCapacity: autoscaleMinCapacity
      } : null
      backendAddressPools: backendAddressPools
      backendHttpSettingsCollection: backendHttpSettingsCollection
      backendSettingsCollection: backendSettingsCollection
      customErrorConfigurations: customErrorConfigurations
      enableHttp2: enableHttp2
      firewallPolicy: !empty(firewallPolicyId) ? {
        id: firewallPolicyId
      } : null
      forceFirewallPolicyAssociation: !empty(firewallPolicyId)
      frontendIPConfigurations: frontendIPConfigurations
      frontendPorts: frontendPorts
      gatewayIPConfigurations: gatewayIPConfigurations
      globalConfiguration: {
        enableRequestBuffering: enableRequestBuffering
        enableResponseBuffering: enableResponseBuffering
      }
      httpListeners: httpListeners
      loadDistributionPolicies: loadDistributionPolicies
      listeners: listeners
      privateLinkConfigurations: privateLinkConfigurations
      probes: probes
      redirectConfigurations: redirectConfigurations
      requestRoutingRules: requestRoutingRules
      routingRules: routingRules
      rewriteRuleSets: rewriteRuleSets
      sku: {
        name: sku
        tier: endsWith(sku, 'v2') ? sku : substring(sku, 0, indexOf(sku, '_'))
        capacity: autoscaleMaxCapacity > 0 && autoscaleMinCapacity >= 0 ? null : capacity
      }
      sslCertificates: sslCertificates
      sslPolicy: sslPolicyType != 'Predefined' ? {
        cipherSuites: sslPolicyCipherSuites
        minProtocolVersion: sslPolicyMinProtocolVersion
        policyName: empty(sslPolicyName) ? null : sslPolicyName
        policyType: sslPolicyType
      } : {
        policyName: empty(sslPolicyName) ? null : sslPolicyName
        policyType: sslPolicyType
      }
      sslProfiles: sslProfiles
      trustedClientCertificates: trustedClientCertificates
      trustedRootCertificates: trustedRootCertificates
      urlPathMaps: urlPathMaps
    }, (enableFips ? {
      enableFips: enableFips
    } : {}),
    (!empty(webApplicationFirewallConfiguration) ? { webApplicationFirewallConfiguration: webApplicationFirewallConfiguration } : {})
  )
  zones: zones
}

resource applicationGateway_lock 'Microsoft.Authorization/locks@2020-05-01' = if (!empty(lock)) {
  name: '${applicationGateway.name}-${lock}-lock'
  properties: {
    level: any(lock)
    notes: lock == 'CanNotDelete' ? 'Cannot delete resource or child resources.' : 'Cannot modify the resource or child resources.'
  }
  scope: applicationGateway
}

resource applicationGateway_diagnosticSettingName 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(diagnosticStorageAccountId) || !empty(diagnosticWorkspaceId) || !empty(diagnosticEventHubAuthorizationRuleId) || !empty(diagnosticEventHubName)) {
  name: !empty(diagnosticSettingsName) ? diagnosticSettingsName : '${name}-diagnosticSettings'
  properties: {
    storageAccountId: empty(diagnosticStorageAccountId) ? null : diagnosticStorageAccountId
    workspaceId: empty(diagnosticWorkspaceId) ? null : diagnosticWorkspaceId
    eventHubAuthorizationRuleId: empty(diagnosticEventHubAuthorizationRuleId) ? null : diagnosticEventHubAuthorizationRuleId
    eventHubName: empty(diagnosticEventHubName) ? null : diagnosticEventHubName
    metrics: empty(diagnosticStorageAccountId) && empty(diagnosticWorkspaceId) && empty(diagnosticEventHubAuthorizationRuleId) && empty(diagnosticEventHubName) ? null : diagnosticsMetrics
    logs: empty(diagnosticStorageAccountId) && empty(diagnosticWorkspaceId) && empty(diagnosticEventHubAuthorizationRuleId) && empty(diagnosticEventHubName) ? null : diagnosticsLogs
  }
  scope: applicationGateway
}

@description('The name of the application gateway.')
output name string = applicationGateway.name

@description('The resource ID of the application gateway.')
output resourceId string = applicationGateway.id

@description('The resource group the application gateway was deployed into.')
output resourceGroupName string = resourceGroup().name

@description('The location the resource was deployed into.')
output location string = applicationGateway.location
