xp = 0.6
yp = 0.9

Run, coffee.cmd -M -b -o src -cw coffee5
WinWait, ahk_class ConsoleWindowClass
WinActivate, ahk_class ConsoleWindowClass
WinMove A,, A_ScreenWidth*xp, 0, A_ScreenWidth*(1-xp), A_ScreenHeight*(1-yp)

Run, subl -a .
WinWait, ahk_class PX_WINDOW_CLASS
WinActivate, ahk_class PX_WINDOW_CLASS
WinMove A,, 0,0, A_ScreenWidth*xp, A_ScreenHeight

Run, npm.cmd start
WinWait, ahk_class PX_WINDOW_CLASS
WinActivate, ahk_class PX_WINDOW_CLASS
WinMove A,, 0,0, A_ScreenWidth*xp, A_ScreenHeight
