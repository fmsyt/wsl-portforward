Option Explicit
On Error Resume Next

Dim oShellApp
Set oShellApp = Wscript.CreateObject("Shell.Application")
if Wscript.Arguments.Count = 0 then
    oShellApp.ShellExecute "wscript.exe", WScript.ScriptFullName & " runas", "", "runas", 1
    Wscript.Quit
end if
Set oShellApp = Nothing

dim sfs
set sfs = createObject("Scripting.FileSystemObject")

Dim ws
Set ws = WScript.CreateObject("WScript.Shell")

ws.run "cmd /c " + sfs.getParentFolderName(WScript.ScriptFullName) + "\startup.bat", 0
