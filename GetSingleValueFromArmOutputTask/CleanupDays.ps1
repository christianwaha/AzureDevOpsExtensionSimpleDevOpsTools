param([string] $Value, [string] $RessourceGroupName)

#$resourcegroup = Get-AzureRmResourceGroup
$deployments = Get-AzureRmResourceGroupDeployment -ResourceGroupName $RessourceGroupName | Sort-Object -Descending Timestamp
$countdeployments = $deployments.Count

echo "Deleting deployment older than $Value days"



$rowstodelete = $deployments | where { $_.Timestamp -lt ((get-date).AddDays(-[int]$Value)) }
ForEach($row in $rowstodelete) 
{ 
     $deleteitem = [string]::Format("Delete now Resourcegroup:{0} Name:{1}", $RessourceGroupName , $row.DeploymentName)
     echo $deleteitem
     Remove-AzureRmResourceGroupDeployment -ResourceGroupName $RessourceGroupName -Name $row.DeploymentName 
}