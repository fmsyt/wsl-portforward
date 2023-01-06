@echo off
cd /d %~dp0
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "Start-Process %~f0 -Verb runas"
    exit
)

for /f %%i in ('wsl exec hostname -I') do set ip=%%i

for /f "skip=1 tokens=1,2* delims=," %%i in (%~dp0port.csv) do (
    netsh interface portproxy delete v4tov4 listenport=%%i
)
