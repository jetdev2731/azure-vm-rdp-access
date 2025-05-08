# Script: Remove-AzFullVmRdp-20250508.ps1
# Description: Deletes the entire resource group and all resources within it.

$resourceGroup = "JetTestLabRG"

# Remove everything
Remove-AzResourceGroup -Name $resourceGroup -Force -AsJob
