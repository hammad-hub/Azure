﻿#Create a Self Sign Certificate on your Local Machine and Export 2 time, 
#1st without Private Key in .cer type
#2nd with Private Key in .pfx type 

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=SHERDILROOT" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign


#Upload .cer file in App registration and .pfx file in Azure Automation Certificates
#Create a Connection in Azure Automation Account using Service Principal

$Conn = Get-AutomationConnection -Name myconnection
Login-AzureRmAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint




# Following script is with Hard COded Values
# Create an App registration and collect the Following 
# App ID, App Secret, Tenant ID

# Run follwoing to Authenticate
$tenantID = 'YOUR TENANT ID';
$clientID = 'YOUR APP ID';
$key = 'YOUR APP SECRET';
$SecurePassword = $key | ConvertTo-SecureString -AsPlainText -Force;
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $clientID, $SecurePassword;
Connect-AzAccount -Credential $cred -TenantId $tenantID -ServicePrincipal

# Run any desired script
Get-AzVM | Select-Object -Property Name





# Following Script is when you create Variables in Automation Account
# Create the Variables in Azure Automation Account for tenantID, appID, appSecret


# Run follwoing to Authenticate
$clientID = Get-AutomationVariable -Name client;
$key = Get-AutomationVariable -Name key;
$SecurePassword = $key | ConvertTo-SecureString -AsPlainText -Force;
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $clientID, $SecurePassword;
$tenantID = Get-AutomationVariable -Name tenant;
Connect-AzAccount -Credential $cred -TenantId $tenantID -ServicePrincipal

# Run any desired script
Get-AzVM | Select-Object -Property Name

