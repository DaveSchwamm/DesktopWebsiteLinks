<#
.SYNOPSIS
    Create a Public Desktop Internet Shortcut from embedded .ico File
#>



# This is the .ico file for the shortcut converted to Base64 in order to embed it within the script.

# This removes the need for a Network Share to be accessible for the icons to display.
$ICOBase64 = ''

# Decode the icon's Base64
$ICOContent = [System.Convert]::FromBase64String($ICOBase64)

# Place the decoded icon into the Public Pictures directory so all accounts on the device can access it.
Set-Content -Path "$($ENV:PUBLIC)\Pictures\THEICON.ico" -Value $ICOContent -Encoding Byte

# Set the icon file to read-only in order to prevent removal/changes without Local Administrator rights
Set-ItemProperty -Path "$($ENV:PUBLIC)\Pictures\THEICON.ico" -Name IsReadOnly -Value $true

# Create the Internet Shortcut on the Public Desktop using the new icon in Public Pictures for the icon's source. Edit as-needed.
$WshShell = New-Object -ComObject WScript.Shell
# Use .lnk even if the file is .url as you cannot set ItemLocation for .url files!
$Shortcut = $WshShell.CreateShortcut("$($ENV:PUBLIC)\Desktop\THEWEBSITENAME.lnk")
$Shortcut.TargetPath = 'WEBSEITE'
$Shortcut.IconLocation = "$($ENV:PUBLIC)\Pictures\THEICON.ico"
$Shortcut.Save()