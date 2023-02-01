Param(
    [string]$d
)

do {
$WslLaunchInteractive = @'
[DllImport("wslapi.dll")]
public static extern uint WslLaunchInteractive(
  [MarshalAs(UnmanagedType.LPWStr)]string DistributionName,
  [MarshalAs(UnmanagedType.LPWStr)]string Command,
  [MarshalAs(UnmanagedType.U1)]bool UseCurrentWorkingDirectory,
  out uint ExitCode
);
'@;

$wslapi = Add-Type -MemberDefinition $WslLaunchInteractive -Name 'WslApi' -Namespace 'Win32' -PassThru;
$exitcode=256;
$wslapi::WslLaunchInteractive($d, 'exit', $false, [ref]$exitcode);

} while($false)
