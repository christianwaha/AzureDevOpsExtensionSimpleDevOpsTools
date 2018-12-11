param([string] $Value)

$resourcegroup = Get-AzureRmResourceGroup
$deployments = Get-AzureRmResourceGroupDeployment -ResourceGroupName $resourcegroup.ResourceGroupName  | Sort-Object -Descending Timestamp
$countdeployments = $deployments.Count

echo "Deleting deployment older than $Value days"
$rowstodelete = $deployments | where { $_.Timestamp -lt ((get-date).AddDays($Value)) }
ForEach($row in $rowstodelete) 
{ 
     $deleteitem = [string]::Format("Delete now Resourcegroup:{0} Name:{1}", $resourcegroup.ResourceGroupName , $row.DeploymentName)
     echo $deleteitem
     Remove-AzureRmResourceGroupDeployment -ResourceGroupName $resourcegroup.ResourceGroupName -Name $row.DeploymentName 
}