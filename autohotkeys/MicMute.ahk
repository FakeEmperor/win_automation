#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
FileRead,MuteSound,*c resources\mutesound.wav
FileRead,UnmuteSound,*c resources\unmutesound.wav


SoundGet, master_mute, , mute, 9

SoundGet, master_mute_8, , mute, 8
; Control auxillary mics as well
if (master_mute != master_mute_8) {
  SoundSet, +1, MASTER, mute, 8
}

if (master_mute = "On") {
  Menu, Tray, Icon, resources\mute_alt_2.png
}
else {
  Menu, Tray, Icon, resources\unmute_alt_2.png 
}


<#C::	  ;Pause Break button is my chosen hotkey

;<---------IMPORTANT-------->
; 9 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 9's  

SoundSet, +1, MASTER, mute, 9
SoundSet, +1, MASTER, mute, 8
SoundGet, master_mute, , mute, 9

ToolTip,% "Mic " (master_mute="On"?"Off":"On") ;use a tool tip at mouse pointer to show what state mic is after toggle
SetTimer, RemoveToolTip, 1000

if (master_mute = "On") {
  ; SoundPlay *-1
  ; FilePath := "D:\dev\tools\win_automation\autohotkeys\resources\mutesound.wav"
  ; DllCall("winmm.dll\PlaySound", AStr, FilePath, uint, 0, uint, 0)
  ; SoundPlay, "resources\mutesound.mp3", WAIT
  PlaySoundAsync(MuteSound)
  Menu, Tray, Icon, D:\dev\tools\win_automation\autohotkeys\resources\mute_alt_2.png 
}
else {
  ; SoundPlay *-1
  ; FilePath := "D:\dev\tools\win_automation\autohotkeys\resources\unmutesound.wav"
  ; DllCall("winmm.dll\PlaySound", AStr, FilePath, uint, 0, uint, 0)
  ; SoundPlay, "resources\unmutesound.mp3", WAIT
  PlaySoundAsync(UnmuteSound)
  Menu, Tray, Icon, D:\dev\tools\win_automation\autohotkeys\resources\unmute_alt_2.png 
}
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return


PlaySoundAsync( ByRef Sound ) {
 Return DllCall( "winmm.dll\PlaySound" ( A_IsUnicode ? "W" : "A" ), UInt,&Sound, UInt,0, UInt, 0x7 )
}

KeyboardLED(LEDvalue, Cmd, Kbd=0)
{
  SetUnicodeStr(fn,"\Device\KeyBoardClass" Kbd)
  h_device:=NtCreateFile(fn,0+0x00000100+0x00000080+0x00100000,1,1,0x00000040+0x00000020,0)

  If Cmd= switch  ;switches every LED according to LEDvalue
   KeyLED:= LEDvalue
  If Cmd= on  ;forces all choosen LED's to ON (LEDvalue= 0 ->LED's according to keystate)
   KeyLED:= LEDvalue | (GetKeyState("ScrollLock", "T") + 2*GetKeyState("NumLock", "T") + 4*GetKeyState("CapsLock", "T"))
  If Cmd= off  ;forces all choosen LED's to OFF (LEDvalue= 0 ->LED's according to keystate)
    {
    LEDvalue:= LEDvalue ^ 7
    KeyLED:= LEDvalue & (GetKeyState("ScrollLock", "T") + 2*GetKeyState("NumLock", "T") + 4*GetKeyState("CapsLock", "T"))
    }

  success := DllCall( "DeviceIoControl"
              ,  "ptr", h_device
              , "uint", CTL_CODE( 0x0000000b     ; FILE_DEVICE_KEYBOARD
                        , 2
                        , 0             ; METHOD_BUFFERED
                        , 0  )          ; FILE_ANY_ACCESS
              , "int*", KeyLED << 16
              , "uint", 4
              ,  "ptr", 0
              , "uint", 0
              ,  "ptr*", output_actual
              ,  "ptr", 0 )

  NtCloseFile(h_device)
  return success
}

CTL_CODE( p_device_type, p_function, p_method, p_access )
{
  Return, ( p_device_type << 16 ) | ( p_access << 14 ) | ( p_function << 2 ) | p_method
}


NtCreateFile(ByRef wfilename,desiredaccess,sharemode,createdist,flags,fattribs)
{
  VarSetCapacity(objattrib,6*A_PtrSize,0)
  VarSetCapacity(io,2*A_PtrSize,0)
  VarSetCapacity(pus,2*A_PtrSize)
  DllCall("ntdll\RtlInitUnicodeString","ptr",&pus,"ptr",&wfilename)
  NumPut(6*A_PtrSize,objattrib,0)
  NumPut(&pus,objattrib,2*A_PtrSize)
  status:=DllCall("ntdll\ZwCreateFile","ptr*",fh,"UInt",desiredaccess,"ptr",&objattrib
                  ,"ptr",&io,"ptr",0,"UInt",fattribs,"UInt",sharemode,"UInt",createdist
                  ,"UInt",flags,"ptr",0,"UInt",0, "UInt")
  return % fh
}

NtCloseFile(handle)
{
  return DllCall("ntdll\ZwClose","ptr",handle)
}


SetUnicodeStr(ByRef out, str_)
{
  VarSetCapacity(out,2*StrPut(str_,"utf-16"))
  StrPut(str_,&out,"utf-16")
}