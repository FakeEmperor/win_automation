@ECHO OFF
REM Launch pageant with the ssh key I want added at startup

SETX GIT_SSH D:/dev/KiTTY/plink.exe
START pageant "L:\sec\keys\kily0@personal.ppk" "L:\sec\keys\fakeemperor@github.com.ppk" "L:\sec\keys\fakeemperor@gitlab.com.ppk"