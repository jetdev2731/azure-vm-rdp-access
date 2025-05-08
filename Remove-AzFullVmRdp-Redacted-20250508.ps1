
# Script: Remove-AzFullVmRdp.ps1
# Description: Deletes the entire resource group and all resources within it.
# Safe for public use – no subscription IDs or sensitive information included.

$resourceGroup = "MyTestRG"

# Remove everything in the resource group
Remove-AzResourceGroup -Name $resourceGroup -Force -AsJob
