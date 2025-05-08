# 🖥️ Deploy and Clean Up Azure Windows VM with RDP Access

This project includes two PowerShell scripts to help you quickly deploy and later clean up a Windows 10 VM in Azure.

---

## ⚙️ What the Deployment Script Does (`New-AzFullVmRdp-Redacted.ps1`)

- Creates a resource group (`MyTestRG`)
- Builds a VNet, Subnet, and NSG (with RDP rule)
- Creates a NIC and Public IP
- Deploys a Windows 10 VM with RDP enabled
- Prompts you for admin credentials
- Outputs the public IP for connection

---

## 🚀 How to Use

1. Open PowerShell and authenticate:

```powershell
Connect-AzAccount
```

2. Save and run the script:

```powershell
.\New-AzFullVmRdp-Redacted.ps1
```

3. Wait for deployment to complete, then RDP using the public IP and credentials you entered.

---

## 🧹 Clean Up to Avoid Charges

To delete all created resources and avoid billing:

```powershell
.\Remove-AzFullVmRdp-Redacted.ps1
```

This removes:
- The Virtual Machine
- Public IP
- NIC
- NSG
- VNet
- Subnet
- Managed Disk
- And everything under `MyTestRG`

---

## 📝 Notes

- Ensure the `Az` PowerShell module is installed
- You must have contributor rights in your Azure subscription

---

## 🔗 View on GitHub

[View on GitHub](https://github.com/jetdev2731/azure-vm-rdp-access)
