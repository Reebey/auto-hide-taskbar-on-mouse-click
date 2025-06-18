#Requires AutoHotkey v2.0
#SingleInstance

; --- Script constant parameters ---
TaskbarHideDelay := 1000           ; Delay in milliseconds before hiding the taskbar
MouseCheckInterval := 100          ; Interval in milliseconds to check mouse position
IsAtBottomThreshold := 1           ; Threshold in pixels from the very bottom of the screen

; --- Global settings ---
Persistent                       ; Keep the script running indefinitely
DetectHiddenWindows true         ; Allow detection of hidden windows
CoordMode("Mouse", "Screen")     ; Use mouse position coordinates relative to the screeen

; --- Global variables ---
global TaskbarHeight := GetTaskbarHeight()  ; Get current taskbar height
global IsTaskBarShown := 0                    ; Flag: 1 if taskbar is visible, else 0

; --- Initialize state ---
WinShow "ahk_class Shell_TrayWnd"  ; Ensure taskbar is visible at script start
HideTaskbar()                       ; Immediately hide the taskbar to reset state

; --- Start periodic mouse position checking ---
SetTimer(CheckMouse, MouseCheckInterval)

CheckMouse() {
    global TaskbarHeight, IsTaskBarShown

    ; Get current mouse position
    MouseGetPos &x, &y

    ; Get screen height in pixels
    screenHeight := SysGet(1)

    ; Check if taskbar currently has focus
    isActive := WinActive("ahk_class Shell_TrayWnd")
    if isActive {
        ; Prevent hiding while taskbar is focused
        SetHideTaskBarTimer(0)
        WinWaitNotActive "ahk_class Shell_TrayWnd"
    }

    ; Check if mouse is over the taskbar area
    isInTaskbarZone := (y >= screenHeight - TaskbarHeight)
    if isInTaskbarZone {
        ; Check if mouse is at the very bottom edge of the screen
        isAtBottom := (y >= screenHeight - IsAtBottomThreshold)

        ; Check if left mouse button is pressed
        isLButtonDown := GetKeyState("LButton", "P")

	; Show taskbar if mouse is at bottom and left button is down
        if isAtBottom && isLButtonDown {
            ShowTaskbar()
        }

        ; Cancel any pending hide timer because mouse is over taskbar
        SetHideTaskBarTimer(0)
    } else if IsTaskBarShown {
        ; Start delayed hide if mouse moved away and taskbar is visible
        SetHideTaskBarTimer(-TaskbarHideDelay)
    }
}

SetHideTaskBarTimer(time) {
    static IsTimerOn := 0  ; Tracks if hide timer is active

    ; Avoid restarting timer if already running with non-zero delay
    if (IsTimerOn && time != 0)
        return

    SetTimer(HideTaskbar, time)
    IsTimerOn := (time != 0)
}

ShowTaskbar() {
    WinShow "ahk_class Shell_TrayWnd"
    global IsTaskBarShown := 1
}

HideTaskbar() {
    WinHide "ahk_class Shell_TrayWnd"
    global IsTaskBarShown := 0
}

GetTaskbarHeight() {
    try {
        WinGetPos ,, &w, &h, "ahk_class Shell_TrayWnd" 
        return h
    } catch {
        return 40  ; Default taskbar height for 1920x1080 screen
    }
}
