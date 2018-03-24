Clear-Host
Write-Output "========================================="
Write-Output "GONZIGONZ Destroy Script"
Write-Output "-----------------------------------------"
Write-Output "Tip, Ensure AzureRm is signed in!"

$settingsFile = [System.IO.Path]::Combine($PSScriptRoot, "settings.xml")
Write-Host  "SettingsFile:"$settingsFile

Write-Output ""
Write-Output "Loading settings..."
[xml]$settings = Get-Content $settingsFile
$azureSubscriptionName = $settings.ARMParams.AzureSubscriptionName
$resouceGroupName = $settings.ARMParams.ResourceGroupName
Write-Output ""
Write-Output "SETTING                VALUE"
Write-Output "-----------------------------------------"
Write-Host "AzureSubscritionName :"$azureSubscriptionName
Write-Host "ResourceGroupName    :"$resouceGroupName
Write-Output ""

Write-Output "Ensuring correct subscription selected..."
if ((Get-AzureRmContext).Subscription.Name -ne $azureSubscriptionName) {
    Select-AzureRmSubscription -SubscriptionName $azureSubscriptionName
}

Write-Output "Deleting resource group..."
$sw = [System.Diagnostics.Stopwatch]::StartNew()
Remove-AzureRmResourceGroup -Name $resouceGroupName
$sw | Format-List -Property *

Write-Output "Destory task complete!"