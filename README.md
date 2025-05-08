# Deploying and Accessing a Windows VM in Azure via RDP

This PowerShell script automates the deployment of a Windows 10 Virtual Machine in Microsoft Azure and enables Remote Desktop Protocol (RDP) access.

## 🛠 What This Script Does

- Creates a resource group, virtual network, subnet, and network security group.  
- Deploys a Windows 10 VM with a static public IP.  
- Enables RDP access through NSG rule.  
- Prompts for secure admin credentials.  
- Outputs the public IP for RDP use.  

## 🚀 How to Use

1. Open PowerShell and authenticate:

    ```powershell
    Connect-AzAccount
    ```

2. Save and run the script:

    ```powershell
    .\Deploy-WindowsVM-RDP-20250508.ps1
    ```

3. Wait for deployment to complete, then use the public IP and username/password to RDP into the VM.

## 🧹 Clean Up (Optional but Recommended)

To avoid unnecessary charges for:

- Managed Disks  
- Public IPs  
- NICs, NSGs, VNet, and other attached resources  

Run the cleanup script:

```powershell
Remove-AzResourceGroup -Name "MyTestRG" -Force -AsJob
