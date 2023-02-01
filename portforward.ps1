if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

if ($PSVersionTable.PSVersion.Major -ge 3) {
    $ScriptDir = $PSScriptRoot
} else {
    $ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
}

$Distro = @{}

if ((Test-Path $ScriptDir\port.csv) -eq $false) {
    Copy-Item -Path $ScriptDir\port.csv.example -Destination $ScriptDir\port.csv -Force
}

$Rows = Import-Csv $ScriptDir\port.csv -Encoding Shift-JIS
Write-Output $Rows

foreach ($Row in $Rows)
{
    if ($Distro.ContainsKey($Row.Distribution) -eq $false) {
        Start-Process -FilePath powershell.exe -ArgumentList "-executionpolicy bypass $ScriptDir\function\waitDistro.ps1 -d $($Row.Distribution)" -NoNewWindow -Wait

        $IP = wsl.exe -d $Row.Distribution hostname -I
        $Distro.add($Row.Distribution, $IP)
    } else {
        $IP = $Distro[$Row.Distribution];
    }

    netsh.exe interface portproxy delete v4tov4 listenport=$Row.Listen
    netsh.exe interface portproxy add v4tov4 listenport=$($Row.Listen) connectport=$($Row.Connect) connectaddress=$($IP)
}

netsh.exe interface portproxy show v4tov4
