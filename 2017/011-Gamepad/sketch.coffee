# http://luser.github.io/gamepadtest
setup = -> createCanvas 600,600

draw = ->
	bg 1
	gs = navigator.getGamepads()
	if gs and gs[0]
		for axis,i in gs[0].axes
			text "#{i} #{axis}",100,20+20*i
		for button,i in gs[0].buttons
			text "#{i} #{button.value}",50,20+20*i