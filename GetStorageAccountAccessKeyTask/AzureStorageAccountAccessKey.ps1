[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
Import-VstsLocStrings "$PSScriptRoot\Task.json"



# Get inputs.

$ConnectedServiceName = Get-VstsInput -Name ConnectedServiceName
$resourceGroupName = Get-VstsInput -Name resourceGroupName
$storageAccount  = Get-VstsInput -Name StorageAccountRM
$outputStorageKey =  Get-VstsInput -Name outputStorageKey



# Import RemoteDeployer
Import-Module $PSScriptRoot\ps_modules\RemoteDeployer

# Initialize Azure.
Import-Module $PSScriptRoot\ps_modules\VstsAzureHelpers_

$endpoint = Get-VstsEndpoint -Name $connectedServiceName -Require
if (Get-Module Az.Accounts -ListAvailable){
   Initialize-AzModule -Endpoint $endpoint
}
else{
    Initialize-AzureRMModule -Endpoint $endpoint
}


# Load all dependent files for execution
. "$PSScriptRoot\Utility.ps1"

#### MAIN EXECUTION OF AZURE TASK BEGINS HERE ####

try {
    # Importing required version of azure cmdlets according to azureps installed on machine
    $azureUtility = Get-AzureUtility

    Write-Verbose -Verbose "Loading $azureUtility"
    . "$PSScriptRoot/$azureUtility"

    # Getting storage key for the storage account
    $storageKey = Get-StorageKey -storageAccountName $storageAccount -endpoint $endpoint 



   
    
    if(-not [string]::IsNullOrEmpty($storageKey))
    {
        if(-not [string]::IsNullOrEmpty($outputStorageKey))
        {
            Write-Host "##vso[task.setvariable variable=$outputStorageKey;]$storageKey"
        }
    }


}
finally {
    Disconnect-AzureAndClearContext -authScheme $endpoint.Auth.Scheme -ErrorAction SilentlyContinue
}