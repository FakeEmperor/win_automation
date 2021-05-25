@echo off

REM Start wsl-ssh-pageant in a cmd instance that closes immediately (but the app keeps running).
SETX SSH_AUTH_SOCK \\.\pipe\ssh-pageant
START /B "" wsl-ssh-pageant-gui.exe --systray --winssh ssh-pageant --wsl %USERPROFILE%\ssh-agent.sock --force
