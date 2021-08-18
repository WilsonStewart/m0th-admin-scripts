#Info for regkeys
$Organization = "CHANGEME"
$SCCMAppName = "CHANGEME"
$SCCMAppVersion = "CHANGEME"
 
# Checks for the program folder and creates it if it doesn’t exist
"Testing for $SCCMAppName program folder..."
if (Test-Path -Path "C:\Program Files\$Organization\$SCCMAppName") {
    "Folder exists!"
}
else {
    "Folder not found. Creating now.."
    New-Item -Force `
        -ItemType Directory `
        -Path "C:\Program Files\$Organization\$SCCMAppName"
    "Folder created!"
}
 
# Function to set standard SCCM App reg keys
function Set-SCCMAppkeys {
    "--> Testing if 'HKLM:\SOFTWARE\$Organization\SCCM-Apps\$SCCMAppName\' already exists..."
    If (Test-Path -Path "HKLM:\SOFTWARE\$Organization\SCCM-Apps\$SCCMAppName") {
        "--> It sure does, boss! Skipping this step."
    }
    Else {
        "--> Nope, it don't! Creating key '$SCCMAppName' in 'HKLM:\SOFTWARE\$Organization\SCCM-Apps\', along with the necessary parent subkeys..."
        New-Item -Force -Path "HKLM:\SOFTWARE\$Organization\SCCM-Apps\$SCCMAppName"
        "--> Key created."
    }
 
    "--> Creating/Updating 'SCCM-App_Name' value with $SCCMAppName..."
    New-ItemProperty -Force -Path "HKLM:\SOFTWARE\$Organization\SCCM-Apps\$SCCMAppName" -Name "SCCM-App_Name" -Value $SCCMAppName
    "--> Value created/Updated."
 
    "--> Creating/Updating 'SCCM-App_Version' value with $SCCMAppVersion..."
    New-ItemProperty -Force -Path "HKLM:\SOFTWARE\$Organization\SCCM-Apps\$SCCMAppName" -Name "SCCM-App_Version" -Value $SCCMAppVersion
    "--> Value created/Updated."
 
    "--> All done!"
}
 
# Calls the function
Set-SCCMAppKeys
 
# Installs the app silently
"Installing $SCCMAppName silently..."
try {
    Start-Process -Wait `
        -FilePath "" `
        -ArgumentList ""
        
    "Install successful!"
}
catch {
    "Error installing!"
    break
}
 
