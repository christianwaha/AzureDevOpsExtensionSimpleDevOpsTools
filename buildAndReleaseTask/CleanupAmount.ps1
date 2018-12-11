param([string] $Value)

$resourcegroup = Get-AzureRmResourceGroup
$deployments = Get-AzureRmResourceGroupDeployment -ResourceGroupName $resourcegroup.ResourceGroupName  | Sort-Object -Descending Timestamp
$countdeployments = $deployments.Count

if ($deployments.Count -le $value)
{
	echo "nothing to delete"
}
else
{
	$toDelete = $deployments.Count - $Value 
	echo $toDelete
	echo "Deleting deployment to have only $Value left"
	$rowstodelete = $deployments | Sort-Object -Property Timestamp -Descending 
	$rowstodelete = $rowstodelete | Select-Object -Last $toDelete
	
	ForEach($row in $rowstodelete) 
	{ 
		 $deleteitem = [string]::Format("Delete now Resourcegroup:{0} Name:{1}", $resourcegroup.ResourceGroupName , $row.DeploymentName)
		 echo $deleteitem
		 Remove-AzureRmResourceGroupDeployment -ResourceGroupName $resourcegroup.ResourceGroupName -Name $row.DeploymentName 
	}

}