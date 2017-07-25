xp = 0.6
yp = 0.9

Run, coffee.cmd -M -b -o js -cw coffee
WinWait, ahk_class ConsoleWindowClass
WinActivate, ahk_class ConsoleWindowClass
WinMove A,, A_ScreenWidth*xp, 0, A_ScreenWidth*(1-xp), A_ScreenHeight*(1-yp)

Run, subl -a .
WinWait, ahk_class PX_WINDOW_CLASS
WinActivate, ahk_class PX_WINDOW_CLASS
WinMove A,, 0,0, A_ScreenWidth*xp, A_ScreenHeight

Run, file:///C:/Lab/2017/082-CalendarClock/index.html?s=1Ma083009303323;1Sv094010403218;1Fy124013502142;2En083009552324;2Ma121513251957;3Fy103511252315;3Ma121513252323;3Id135014501957;4En130014253232;4Sv143515553546;5Ma083009303434;5Fy110512001957
WinWait, ahk_class Chrome_WidgetWin_1
WinActivate, ahk_class Chrome_WidgetWin_1
WinMove A,, A_ScreenWidth*xp, A_ScreenHeight*(1-yp), A_ScreenWidth*(1-xp), A_ScreenHeight*yp


