# Azure-Template-Windows-Dev-VM
An Azure ARM template to provision a quick Windows Visual Studio environment with dev tools

# Running from local environment
### Setup
1. Ensure you have latest Azure PowerShell
    - See docs for Windows, macOS and Linux instructions:  
    https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-5.5.0 
2. Configure settings
    - Navigate to the scripts folder.
    - Copy the `settings.sample.xml` to a new file named `settings.xml`.
    - Update the new `settings.xml` file with your settings.  
    **IMPORTANT! - The Destroy Script will DELETE ALL ITEMS from the `ResouceGroupName` defined in this settings file.**

### Sign into Azure
Before running any script ensure AzureRm has been signed into Azure:
- Start PowerShell terminal (On macOS type `pwsh`).
- Run: `Login-AzureRMAccount`

### Deploy template
To deploy the ARM template into the set **_resouce group_** run: `./scripts/create.ps1`

### Destory template
To clean up and delete all items for the set **_resouce group_** run: `./scripts/destroy.ps1`