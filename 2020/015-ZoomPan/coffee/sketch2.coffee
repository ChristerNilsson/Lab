VERSION = 3
bakgrund = '#888'
SCALE = 1
cx = 0
cy = 0
msg = VERSION
buttons = []

class Button
	constructor : (@prompt,@x,@y,@click) -> @r=50
	draw : ->
		circle @x,@y,@r
		text @prompt,@x,@y
	inside : (x,y) -> @r > dist x,y,@x,@y

setup = ->
	createCanvas windowWidth-20,windowHeight-20
	textAlign CENTER,CENTER
	textSize 50
	cx = width/2
	cy = height/2
	buttons.push new Button '+',50,50, -> 
		bakgrund = '#f00'
		SCALE *= 1.5
	buttons.push new Button '-',150,50, ->
		bakgrund = '#0f0'
		SCALE /= 1.5

draw = ->
	background bakgrund
	push()
	translate cx,cy
	scale SCALE
	circle 0,0,100
	pop()
	for button in buttons 
		button.draw()
	text msg,width/2,height/2

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.click()
	false

mouseReleased = ->


mouseDragged = (e) ->
	cx += e.movementX
	cy += e.movementY
	#msg = _.keys(e).length
	# console.log e

touchMoved = (e) ->
	msg = e.movementX
	cx += 10
	cy += 10
	#msg = JSON.stringify e

# touchStarted = (ev) ->
# 	try
# 		dump.store 'touchStarted', true
# 		ev.preventDefault()
# 		if touches.length == 2
# 			for t in touches
# 				tpCache.push t
# 		update_background ev
# 	catch e
# 		dump.store "error in Started"

# touchMoved = (ev) ->
# 	try
# 		dump.store 'touchMoved'
# 		ev.preventDefault()
# 		if not touches.length == 2 then update_background ev
# 		ev.target.style.outline = "dashed"
# 		handle_pinch_zoom ev
# 	catch 
# 		dump.store "error in Moved"

# touchEnded = (ev) ->
# 	try	
# 		dump.store 'touchEnded'
# 		ev.preventDefault()
# 		if touches.length == 1
# 			touch = touches[0]
# 			for button in buttons	
# 				if button.inside touch.x,touch.y then button.click()
# 			# Restore background and outline to original values
# 			#ev.target.style.background = "white"
# 			#ev.target.style.outline = "1px solid black"
# 	catch e
# 		dump.store "error in Ended"

#enableLog = -> loggaEvents = not loggaEvents

# logga = (name, printTargetIds=false) ->
# 	if not loggaEvents then return
# 	o = document.getElementsByTagName('output')[0]
# 	o.innerHTML += "#{name}: touches = #{touches.length} <br>"
# 	if printTargetIds then o.innerHTML += ("... id = #{t.id}" for t in touches).join '<br>'

# clearLog = ->
# 	o = document.getElementsByTagName('output')[0]
# 	o.innerHTML = ""

# update_background = (ev) ->
# 	n = touches.length
# 	bakgrund = "lightblue"
# 	if n==1 then bakgrund = "yellow"
# 	if n==2 then bakgrund = "pink"
# 	dump.store "update_background #{bakgrund}"

# handle_pinch_zoom = (ev) ->
# 	try
# 		dump.store "--HPZ #{tpCache.length} #{touches.length}"
# 		if touches.length == 2
# 			# Check if the two target touches are the same ones that started the 2-touch
# 			index0 = -1
# 			index1 = -1
# 			for i in range tpCache.length
# 				if tpCache[i].id == touches[0].id then index0 = i
# 				if tpCache[i].id == touches[1].id then index1 = i
# 			dump.store "----index #{index0} #{index1}"
# 			if index0 >=0 and index1 >= 0
# 				# Calculate the difference between the start and move coordinates
# 				diff0 = int dist tpCache[index0].x, tpCache[index0].y, touches[0].x, touches[0].y
# 				diff1 = int dist tpCache[index1].x, tpCache[index1].y, touches[1].x, touches[1].y

# 				# This threshold is device dependent as well as application specific
# 				PINCH_THRESHHOLD = ev.target.clientWidth / 10
# 				dump.store "----diff #{diff0} #{diff1} #{PINCH_THRESHHOLD}"
# 				if diff0 >= PINCH_THRESHHOLD and diff1 >= PINCH_THRESHHOLD then bakgrund = "green"
# 				dump.store "----bakgrund #{bakgrund}"
# 			else
# 				tpCache = []
# 	catch e
# 		dump.store "error in HPZ #{e}"

# class Dump
# 	constructor : ->
# 		@data = []
# 		@active = false
# 	store : (msg) ->
# 		if @active
# 			console.log msg
# 			@data.push msg
# 	get : ->
# 		result = @data.join BR
# 		@data = []
# 		result + BR + BR
# dump = new Dump()
    
# sendMail = (subject) ->
# 	mail.href = encodeURI "mailto:janchrister.nilsson@gmail.com?subject=#{subject}&body=#{dump.get()}"
# 	mail.click()

