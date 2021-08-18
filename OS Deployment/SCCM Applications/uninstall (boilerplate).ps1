# Uninstalls SCCM Application
 
$Organization = "CHANGEME"
$SCCMAppName = "CHANGEME"
# $ShortcutName = "CHANGEME"
 
 
# Delete program folder
"Deleting program folder..."
Remove-Item `
    -Force `
    -Recurse `
    -Path "C:\Program Files\$Organization\$SCCMAppName"
"--> Done"
 
# Delete SCCM-Apps reg entry
"Deleting SCCM-Apps reg entry..."
Remove-Item `
    -Force `
    -Path "HKLM:\SOFTWARE\$Organization\SCCM-Apps\$SCCMAppName\"
"--> Done"
	
# Delete start menu entry
# "Deleting start menu entry..."
#     Remove-Item -Force `
#         -Path "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\$ShortcutName"
 
# Delete public desktop shortcut
# "Deleting desktop shortcut..."
#     Remove-Item -Force `
#         -Path "C:\Users\Public\Desktop\$ShortcutName"
 
# Uninstalls the app silently
"Uninstalling $SCCMAppName silently..."
try {
    Start-Process -Wait `
        -FilePath "" `
        -ArgumentList ""
        
    "Uninstall successful!"
}
catch {
    "Error uninstalling!"
    break
}
