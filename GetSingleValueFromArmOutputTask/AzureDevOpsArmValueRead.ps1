Trace-VstsEnteringInvocation $MyInvocation
Import-VstsLocStrings "$PSScriptRoot\Task.json"



# Get inputs.

$armOutput = Get-VstsInput -Name armOutput
$searchValue = Get-VstsInput -Name searchValue
$readedValue = Get-VstsInput -Name readedValue

Write-Host $armOutput
Write-Host $searchValue
Write-Host $readedValue



