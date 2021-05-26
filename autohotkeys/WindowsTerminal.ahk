#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force

SwitchToWindowsTerminal()
{
  windowHandleId := WinExist("ahk_exe WindowsTerminal.exe")
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready = true)
  {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive)
    {
      ; Minimize the window.
      WinMinimize, "ahk_id %windowHandleId%"
    }
    else
    {
      ; Put the window in focus.
      WinActivate, "ahk_id %windowHandleId%"
      WinShow, "ahk_id %windowHandleId%"
    }
  }
  ; Else it's not already open, so launch it.
  else
  {

    ; The *RunAs will launch the Windows Terminal as Admin. If you don’t want it launched as an elevated command prompt, then remove the *RunAs
    Run, wt
  }
}

; Hotkey to use Ctrl+Shift+T to launch/restore the Windows Terminal.
^!t::SwitchToWindowsTerminal()
