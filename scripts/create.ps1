Clear-Host
Write-Output "========================================="
Write-Output "GONZIGONZ ARM Template Deployent Script"
Write-Output "-----------------------------------------"
Write-Output "Tip, Ensure AzureRm is signed in!"

$settingsFile = [System.IO.Path]::Combine($PSScriptRoot, "settings.xml")
$templateFile = [System.IO.Path]::Combine($PSScriptRoot, "../azuredeploy.json")
Write-Host  "SettingsFile:"$settingsFile
Write-Host  "TemplateFile:"$templateFile

Write-Output ""
Write-Output "Loading settings..."
[xml]$settings = Get-Content $settingsFile
$azureSubscriptionName = $settings.ARMParams.AzureSubscriptionName
$location = $settings.ARMParams.Location
$resouceGroupName = $settings.ARMParams.ResourceGroupName
Write-Output ""
Write-Output "SETTING                VALUE"
Write-Output "-----------------------------------------"
Write-Host "AzureSubscritionName :"$azureSubscriptionName
Write-Host "Location             :"$location
Write-Host "ResourceGroupName    :"$resouceGroupName
Write-Output ""

Write-Output "Ensuring correct subscription selected..."
if ((Get-AzureRmContext).Subscription.Name -ne $azureSubscriptionName) {
    Select-AzureRmSubscription -SubscriptionName $azureSubscriptionName
}

Write-Output "Creating resource group if not exist..."
Get-AzureRmResourceGroup -Name $resouceGroupName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{
    New-AzureRmResourceGroup -Name $resouceGroupName -Location $location
}

Write-Output "Deploying template..."
$sw = [System.Diagnostics.Stopwatch]::StartNew()
New-AzureRmResourceGroupDeployment -ResourceGroupName $resouceGroupName -TemplateFile $templateFile
$sw | Format-List -Property *

Write-Output "Deployment complete!"