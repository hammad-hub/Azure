# Step 1 --> Create Certification
#Create a Self Sign Certificate on your Local Machine and Export 2 time, 
#1st without Private Key in .cer type
#2nd with Private Key in .pfx type 

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=SHERDILROOT" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

## Step 2 ----> upload certificate
## Locate certification by typing "manage user certificate" # 
# Right click on certificate SHERDILROOT--->All Task ---> Export (2) times with "name".cer & "Name.pfx"
# Upload .cer file in App registration and .pfx file in ---> Azure Automation Certificates
# Create a Connection in Azure Automation Account using Service Principal

#thumbprint# -----  ############
#Application (client) ID ---> ###############
#Directory (tenant) ID ---> ################
#Object ID --->    #########################

# Create service principal account in App registration 
###-----Certificate App Registration ---------Client secrets
#thumbprint ----->  ############
#keyvalue ----->  ################
#Client ID -----> ############



#################Run the following command off runbook data

$hsconn = @{
ApplicationId = "#########"
TenantId = "#########"
CertificateThumbprint = "#########"
SubscriptionId = "########"
}

$hsconn.ApplicationId
$hsconn.TenantId
$hsconn.CertificateThumbprint
$hsconn.SubscriptionId

Connect-AzAccount -TenantId $conn.TenantId -Subscription $conn.SubscriptionId `
-ServicePrincipal -ApplicationId $conn.ApplicationId -CertificateThumbprint $conn.CertificateThumbprint

$vmName = "B7-VM-Hammad"
$resourceGroup ="B7-RG-Test-Lab-Hammad"

Stop-AzVM -Name $vmName -ResourceGroupName $resourceGroup -Force

