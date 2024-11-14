$FileName = 'C:\Path\To\Icon.ico'
$base64string = [Convert]::ToBase64String([IO.File]::ReadAllBytes($FileName))
