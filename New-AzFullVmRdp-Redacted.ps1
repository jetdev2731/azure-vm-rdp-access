
# Script: New-AzFullVmRdp.ps1
# Description: Automates the deployment of a Windows 10 VM in Azure with RDP access.

$resourceGroup = "MyTestRG"
$location = "westus"
$vnetName = "MyVNet"
$subnetName = "MySubnet"
$nsgName = "MyNSG"
$nicName = "MyNIC"
$publicIpName = "MyPublicIP"
$vmName = "MyVM"
$vmSize = "Standard_B1s"

# Create resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create subnet config and virtual network
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.1.0/24"
$vnet = New-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $location -AddressPrefix "10.0.0.0/16" -Subnet $subnetConfig

# Create NSG with RDP rule
$rdpRule = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Protocol "Tcp" -Direction "Inbound" -Priority 1000 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 3389 -Access "Allow"
$nsg = New-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $resourceGroup -Location $location -SecurityRules $rdpRule

# Create public IP
$publicIp = New-AzPublicIpAddress -Name $publicIpName -ResourceGroupName $resourceGroup -Location $location -AllocationMethod Static -Sku Basic

# Get subnet reference again
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet

# Create NIC
$nic = New-AzNetworkInterface -Name $nicName -ResourceGroupName $resourceGroup -Location $location -SubnetId $subnet.Id -NetworkSecurityGroupId $nsg.Id -PublicIpAddress $publicIp

# Prompt for credentials
$cred = Get-Credential -Message "Enter VM admin credentials"

# Build VM config
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmName -Credential $cred
$vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsDesktop" -Offer "Windows-10" -Skus "win10-22h2-pro" -Version "latest"
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

# Deploy VM
New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig
