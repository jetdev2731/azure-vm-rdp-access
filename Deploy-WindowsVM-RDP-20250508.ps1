
# PowerShell Script to Deploy Windows 10 VM in Azure with RDP Access

# Login to Azure if not already authenticated
Connect-AzAccount

# Variables (customize before running)
$resourceGroup = "YourResourceGroup"
$location = "westus"
$vmName = "YourVMName"
$vmSize = "Standard_B1s"
$adminUser = "jetadmin"
$adminPass = ConvertTo-SecureString "YourStrongP@ssw0rd!" -AsPlainText -Force

# Create Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create Virtual Network
$vnet = New-AzVirtualNetwork -Name "$vmName-VNet" -ResourceGroupName $resourceGroup -Location $location -AddressPrefix "10.0.0.0/16"
$subnet = Add-AzVirtualNetworkSubnetConfig -Name "$vmName-Subnet" -VirtualNetwork $vnet -AddressPrefix "10.0.1.0/24"
$vnet | Set-AzVirtualNetwork

# Create Public IP Address
$pip = New-AzPublicIpAddress -Name "$vmName-PublicIP" -ResourceGroupName $resourceGroup -Location $location -AllocationMethod Static

# Create NSG and allow RDP
$nsgRule = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Protocol "Tcp" -Direction "Inbound" -Priority 1000 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 3389 -Access Allow
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location -Name "$vmName-NSG" -SecurityRules $nsgRule

# Create NIC
$subnetRef = Get-AzVirtualNetworkSubnetConfig -Name "$vmName-Subnet" -VirtualNetwork $vnet
$nic = New-AzNetworkInterface -Name "$vmName-NIC" -ResourceGroupName $resourceGroup -Location $location -SubnetId $subnetRef.Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

# VM Config
$cred = New-Object System.Management.Automation.PSCredential ($adminUser, $adminPass)
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize |
    Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred |
    Set-AzVMSourceImage -PublisherName "MicrosoftWindowsDesktop" -Offer "Windows-10" -Skus "win10-22h2-pro" -Version "latest" |
    Add-AzVMNetworkInterface -Id $nic.Id

# Create VM
New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig
