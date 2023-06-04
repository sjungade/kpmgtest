$tenantId = "59badecb-ea66-4f7c-a698-47a034afc434"
$clientId = "9d5cd00b-953e-480f-88be-c9c92a8a44d8"
$clientSecret = "D7L8Q~UsiLGyuG8PFkyIuPAr72IrrpRj3MSiydfA"
$subscriptionId = "c0d61419-0775-44c3-9931-1a939dbd633d"
$resourceGroupName = "in-app-platf-demosj-rg"
$vmName = "demosjvm"

# Get Azure AD access token
$tokenEndpoint = "https://login.microsoftonline.com/$tenantId/oauth2/token"
$tokenBody = @{
    "grant_type" = "client_credentials"
    "client_id" = $clientId
    "client_secret" = $clientSecret
    "resource" = "https://management.azure.com/"
}
$tokenResponse = Invoke-RestMethod -Uri $tokenEndpoint -Method POST -Body $tokenBody
$accessToken = $tokenResponse.access_token

# Get VM Instance Metadata
$metadataUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Compute/virtualMachines/$vmName/instanceView?api-version=2021-03-01"
$headers = @{
    "Authorization" = "Bearer $accessToken"
}

try {
    $response = Invoke-RestMethod -Uri $metadataUrl -Headers $headers -Method GET -NoProxy
    Write-Output $response
    $jsonOutput = $response | ConvertTo-Json -Depth 10
    Write-Output $jsonOutput
}
catch {
    Write-Output $response
    Write-Output "Failed to retrieve instance metadata."
}
