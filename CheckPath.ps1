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