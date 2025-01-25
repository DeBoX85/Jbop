# Custom Configuration Script for VM Instances

# Update the system
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PowerShellGet -Force -AllowClobber
Update-Module -Name PowerShellGet
Update-Module

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Set up a simple HTML page
$path = "C:\inetpub\wwwroot\index.html"
$content = @"
<html>
<head>
    <title>Welcome to Azure VM Scale Set</title>
</head>
<body>
    <h1>Congratulations! Your VM Scale Set instance is running.</h1>
</body>
</html>
"@
$content | Out-File -FilePath $path -Encoding utf8

# Restart IIS to apply changes
Restart-Service -Name 'W3SVC'
