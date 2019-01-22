Trace-VstsEnteringInvocation $MyInvocation
Import-VstsLocStrings "$PSScriptRoot\Task.json"



# Get inputs.

$armOutput = Get-VstsInput -Name armOutput
$searchValue = Get-VstsInput -Name searchValue
$outputReadedValue = Get-VstsInput -Name outputReadedValue

$armObjectFromJson = ConvertFrom-Json $armOutput
$searchObject = Select-Object -InputObject $armObjectFromJson -Property $searchValue
$value = $searchObject.Value 

Write-Host $armOutput
Write-Host $searchValue
Write-Host $value

Write-Host "##vso[task.setvariable variable=$outputReadedValue;]$value"

