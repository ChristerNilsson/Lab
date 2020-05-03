loggaEvents = false
tpCache = []
bakgrund = '#888'

setup = ->
	createCanvas windowWidth,windowHeight/2
	logga "Hej Häpp 30!"

draw = ->	background bakgrund

enableLog = -> loggaEvents = not loggaEvents

logga = (name, printTargetIds=false) ->
	if not loggaEvents then return
	o = document.getElementsByTagName('output')[0]
	o.innerHTML += "#{name}: touches = #{touches.length} <br>"
	if printTargetIds then o.innerHTML += ("... id = #{t.id}" for t in touches).join '<br>'

clearLog = ->
	o = document.getElementsByTagName('output')[0]
	o.innerHTML = ""

update_background = (ev) ->
	n = touches.length
	bakgrund = "lightblue"
	if n==1 then bakgrund = "yellow"
	if n==2 then bakgrund = "pink"
	logga "update_background #{bakgrund}"

handle_pinch_zoom = (ev) ->
	try
		logga "--HPZ #{tpCache.length} #{touches.length}"
		if touches.length == 2
			# Check if the two target touches are the same ones that started the 2-touch
			index0 = -1
			index1 = -1
			for i in range tpCache.length
				if tpCache[i].id == touches[0].id then index0 = i
				if tpCache[i].id == touches[1].id then index1 = i
			logga "----index #{index0} #{index1}"
			if index0 >=0 and index1 >= 0
				# Calculate the difference between the start and move coordinates
				diff0 = int dist tpCache[index0].x, tpCache[index0].y, touches[0].x, touches[0].y
				diff1 = int dist tpCache[index1].x, tpCache[index1].y, touches[1].x, touches[1].y

				# This threshold is device dependent as well as application specific
				PINCH_THRESHHOLD = ev.target.clientWidth / 10
				logga "----diff #{diff0} #{diff1} #{PINCH_THRESHHOLD}"
				if diff0 >= PINCH_THRESHHOLD and diff1 >= PINCH_THRESHHOLD then bakgrund = "green"
				logga "----bakgrund #{bakgrund}"
			else
				tpCache = []
	catch e
		logga "error in HPZ #{e}"

touchStarted = (ev) ->
	try
		logga 'touchStarted', true
		ev.preventDefault()
		if touches.length == 2
			for t in touches
				tpCache.push t
		update_background ev
	catch e
		logga "error in Started"

touchMoved = (ev) ->
	try
		logga 'touchMoved'
		ev.preventDefault()
		if not touches.length == 2 then update_background ev
		ev.target.style.outline = "dashed"
		handle_pinch_zoom ev
	catch 
		logga "error in Moved"

touchEnded = (ev) ->
	try	
		logga 'touchEnded'
		ev.preventDefault()
		if touches.length == 0
			# Restore background and outline to original values
			ev.target.style.background = "white"
			ev.target.style.outline = "1px solid black"
	catch e
		logga "error in Ended"
