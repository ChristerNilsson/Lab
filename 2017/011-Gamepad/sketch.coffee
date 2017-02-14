# http://luser.github.io/gamepadtest

x0 = 100
y0 = 100

x1 = 500
y1 = 100

setup = -> createCanvas 600,600

draw = ->
	bg 1
	circle x0,y0,50
	circle x1,y1,50
	gs = navigator.getGamepads()
	if gs# and gs[0]
		x0 += gs[0].axes[0]
		y0 += gs[0].axes[1]
		x1 += gs[0].axes[2]
		y1 += gs[0].axes[3]