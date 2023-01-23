$RG= "rg-dotnetsql"
$location= "eastus"
# Creating Resource Group
New-Azresourcegroup -Name $RG -location $location
# App Service variables
$appserviceplan= "Asp-DotNetSQL"
$tier= “Premium v2 P1V2”
# Creating App Service Plan
New-AzAppServicePlan -ResourceGroupName $RG -Name $appserviceplan -location $location -Tier $tier

# Web App Variables
$webappname= "webapp-DotNetSQL"
$Slot=”dev-DotNetSQL”
# Creating Web App and Slot

New-AzWebApp -Name $webappname -location $location -AppServicePlan $appserviceplan -Resourcegroupname $RG
New-AzWebAppSlot -Name $webappname -ResourceGroupName $RG -Slot $Slot

# Creating Application insights
$Name=”AppI-DotNetSQL”
New-AzApplicationInsights -ResourceGroupName $RG -Name $Name -location $location

# SQL Server Variables
$servername = “sqlserver-dotnetsql”
$username= “sqlserver”
$pwd =ConvertTo-SecureString “server@123” -AsPlainText -Force
$credential = New-Object system.Management.Automation.PSCredential($username,$pwd);


# Creating SQL Server
New-Azsqlserver -ResourceGroupName $RG -Location $location -ServerName $servername -SqlAdministratorCredentials $credential

# Creating SQL Databases
$database1=”sqldatabase-prod-slot”
$database2=”sqldatabase-dev-slot”
New-AzsqlDatabase -ResourceGroupName $RG -ServerName $servername –DatabaseName $database1
New-AzsqlDatabase -ResourceGroupName $RG -ServerName $servername –DatabaseName $database2
