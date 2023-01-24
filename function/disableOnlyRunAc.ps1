Param(
    [string]$taskName
)

$taskXml = [xml](schtasks /query /tn $taskName /xml)
$taskXml.Task.Settings.DisallowStartIfOnBatteries = "false"
$taskXml.Save("C:\temp\tempTask.xml")
schtasks /delete /tn $taskName /f > $null
schtasks /create /tn $taskName /xml "C:\temp\tempTask.xml" > $null
Remove-Item "C:\temp\tempTask.xml" > $null
