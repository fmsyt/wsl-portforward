@echo off

cd /d %~dp0

if not exist %~dp0port.csv (
    copy %~dp0port.csv.example %~dp0port.csv
)

for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "Start-Process %~f0 -Verb runas"
    exit
)

for /f %%i in ('wsl exec hostname -I') do set ip=%%i

for /f "skip=1 tokens=1,2,3* delims=," %%i in (%~dp0port.csv) do (
    netsh interface portproxy delete v4tov4 listenport=%%i
    netsh interface portproxy add v4tov4 listenport=%%i connectport=%%j connectaddress=%ip%
)
