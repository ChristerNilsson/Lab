xp = 0.6
yp = 0.9

Run, coffee.cmd -b --transpile --map -o js/ -cw coffee/
WinWait, ahk_class ConsoleWindowClass
WinActivate, ahk_class ConsoleWindowClass
WinMove A,, A_ScreenWidth*xp, 0, A_ScreenWidth*(1-xp), A_ScreenHeight*(1-yp)

Run, subl -a .
WinWait, ahk_class PX_WINDOW_CLASS
WinActivate, ahk_class PX_WINDOW_CLASS
WinMove A,, 0,0, A_ScreenWidth*xp, A_ScreenHeight

Run, C:\Python27\python -m SimpleHTTPServer

Run, http://127.0.0.1:8000
WinWait, ahk_class Chrome_WidgetWin_1
WinActivate, ahk_class Chrome_WidgetWin_1
WinMove A,, A_ScreenWidth*xp, A_ScreenHeight*(1-yp), A_ScreenWidth*(1-xp), A_ScreenHeight*yp


