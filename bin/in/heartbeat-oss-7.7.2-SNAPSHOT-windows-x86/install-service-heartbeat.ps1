# Delete and stop the service if it already exists.
if (Get-Service heartbeat -ErrorAction SilentlyContinue) {
  $service = Get-WmiObject -Class Win32_Service -Filter "name='heartbeat'"
  $service.StopService()
  Start-Sleep -s 1
  $service.delete()
}

$workdir = Split-Path $MyInvocation.MyCommand.Path

# Create the new service.
New-Service -name heartbeat `
  -displayName Heartbeat `
  -binaryPathName "`"$workdir\heartbeat.exe`" -environment=windows_service -c `"$workdir\heartbeat.yml`" -path.home `"$workdir`" -path.data `"C:\ProgramData\heartbeat`" -path.logs `"C:\ProgramData\heartbeat\logs`" -E logging.files.redirect_stderr=true"

# Attempt to set the service to delayed start using sc config.
Try {
  Start-Process -FilePath sc.exe -ArgumentList 'config heartbeat start= delayed-auto'
}
Catch { Write-Host -f red "An error occured setting the service to delayed start." }
