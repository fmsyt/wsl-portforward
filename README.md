# wsl-portforward

## Prepare

1. Copy `port.csv.example` to `port.csv` on same directory.
2. Set port number what you needed.
    e.g.) Listen SSH, HTTP, HTTPS.

   ```port.csv
   Listen,Connect
   22,22
   80,80
   443,443
   ```

## Scripts

### portforward.bat

Listen ports according to `port.csv`.

### delete_portforward.bat

Delete Listened ports according to `port.csv`.

### register.bat

Register to TaskScheduler.
It make schedule to run `startup.vbs` on startup Windows.
