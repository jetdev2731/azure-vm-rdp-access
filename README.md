# Deploy and Clean Up Azure Windows VM with RDP Access

This project includes two PowerShell scripts to help you quickly deploy and later clean up a test Windows 10 Virtual Machine in Azure.

---

## 🛠 What the Deployment Script Does (`New-AzFullVmRdp-Redacted.ps1`)
- Creates a resource group (`JetTestLabRG`)
- Builds a VNet, Subnet, and NSG (with RDP rule)
- Creates a NIC and Public IP
- Deploys a Windows 10 VM with RDP enabled
- Prompts you for admin credentials
- Outputs the assigned Public IP

---

## 🚀 How to Deploy

1. Open PowerShell and authenticate:
   ```powershell
   Connect-AzAccount
   ```

2. Navigate to your script location (e.g., Downloads):
   ```powershell
   cd "$HOME\Downloads"
   ```

3. Run the deployment script:
   ```powershell
   .\New-AzFullVmRdp-Redacted.ps1
   ```

4. After deployment, RDP into the VM using the provided Public IP and your credentials.

---

## 🧹 How to Clean Up (`Remove-AzFullVmRdp-Redacted-20250508.ps1`)

To avoid unnecessary charges, run the cleanup script to delete everything:

```powershell
.\Remove-AzFullVmRdp-20250508.ps1
```

This removes:
- The Virtual Machine
- Public IP
- NIC, NSG, VNet, Subnet
- Managed Disk and all attached resources

---

## ⚠️ Notes
- Make sure the `Az` PowerShell module is installed.
- You must have **Contributor** role permissions to deploy or delete Azure resources.

---

## 🔗 View on GitHub
[📎 View on GitHub](https://github.com/jetdev2731/azure-vm-rdp-access/tree/main)

---
© 2025 Jet Mariano. All rights reserved.

