start "" "C:\Program Files\VeraCrypt\VeraCrypt.exe" /q /beep /a favorites /signalExit mountFinished
waitfor mountFinished
call start_pageant.bat
call start_ssh_agent.bat
start "" "C:\Program Files\KeePass Password Safe 2\KeePass.exe"