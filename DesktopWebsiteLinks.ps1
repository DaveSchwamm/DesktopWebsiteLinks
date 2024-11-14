<#
.SYNOPSIS
    This script tests the path below and then returns "Installed" if the path exists.
#>

# Path to test
<# $PublicDesktopIcon = ( Get-Item -Path "$($ENV:PUBLIC)\Desktop\YOURLINKHERE.lnk" ) #>

# Perform detection

<# If ($null -eq $PublicDesktopIcon) {
    Write-Output 'Icon not found. Throwing detection error!'
    Exit 1
} Else {
    Write-Output 'Icon found.'
    Exit 0
} #>


<#
.SYNOPSIS
    Create a Public Desktop Internet Shortcut from embedded .ico File
#>



# This is the .ico file for the shortcut converted to Base64 in order to embed it within the script.

$FileName = '"C:\Users\david.schwammberger\Downloads\schabi.ico"'
$base64string = [Convert]::ToBase64String([IO.File]::ReadAllBytes($FileName))

# This removes the need for a Network Share to be accessible for the icons to display.
$ICOBase64 = $base64string

# Decode the icon's Base64
$ICOContent = [System.Convert]::FromBase64String($ICOBase64)

# Place the decoded icon into the Public Pictures directory so all accounts on the device can access it.
Set-Content -Path "$($ENV:PUBLIC)\Pictures\schabi.ico" -Value $ICOContent -Encoding Byte

# Set the icon file to read-only in order to prevent removal/changes without Local Administrator rights
Set-ItemProperty -Path "$($ENV:PUBLIC)\Pictures\schabi.ico" -Name IsReadOnly -Value $true

# Create the Internet Shortcut on the Public Desktop using the new icon in Public Pictures for the icon's source. Edit as-needed.
$WshShell = New-Object -ComObject WScript.Shell
# Use .lnk even if the file is .url as you cannot set ItemLocation for .url files!
$Shortcut = $WshShell.CreateShortcut("$($ENV:PUBLIC)\Desktop\schabi.lnk")
$Shortcut.TargetPath = 'https://www.schabi.ch/'
$Shortcut.IconLocation = "$($ENV:PUBLIC)\Pictures\schabi.ico"
$Shortcut.Save()