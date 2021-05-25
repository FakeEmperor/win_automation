@echo off

REM Start wsl-ssh-pageant in a cmd instance that closes immediately (but the app keeps running).

START /B "" wsl-ssh-pageant-gui.exe --systray --winssh openssh-ssh-agent --wsl %USERPROFILE%\ssh-agent.sock --force
