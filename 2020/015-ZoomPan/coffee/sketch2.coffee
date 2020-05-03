logEvents = true
tpCache = []
bakgrund = '#888'

setup = ->
	createCanvas windowWidth,windowHeight/2

draw = ->
	background bakgrund
	text '15',100,100

enableLog = -> logEvents = not logEvents

log = (name, ev, printTargetIds=false) ->
	o = document.getElementsByTagName('output')[0]
	s = name + ": touches = " + touches.length # + "  ; targetTouches = " + ev.targetTouches.length + " ; changedTouches = " + ev.changedTouches.length
	o.innerHTML += s + " <br>"

	if printTargetIds
		s = ""
		for t in touches
			s += "... id = " + t.id + " <br>"
		o.innerHTML += s

clearLog = ->
	o = document.getElementsByTagName('output')[0]
	o.innerHTML = ""

update_background = (ev) ->
	log 'update_background',ev
	n = touches.length
	if n==1 then bakgrund = "yellow"
	else if n==2 then bakgrund = "pink"
	else bakgrund = "lightblue"

# This is a very basic 2-touch move/pinch/zoom handler that does not include
# error handling, only handles horizontal moves, etc.
handle_pinch_zoom = (ev) ->
	try
		console.log ev
		if touches.length == 2 and ev.changedTouches.length == 2
			# Check if the two target touches are the same ones that started
			# the 2-touch
			point1 = -1
			point2 = -1
			for i in range tpCache.length
				if tpCache[i].id == touches[0].id then point1 = i
				if tpCache[i].id == touches[1].id then point2 = i

				if point1 >=0 and point2 >= 0
					# Calculate the difference between the start and move coordinates
					diff1 = Math.abs(tpCache[point1].clientX - touches[0].clientX)
					diff2 = Math.abs(tpCache[point2].clientX - touches[1].clientX)

					# This threshold is device dependent as well as application specific
					PINCH_THRESHHOLD = ev.target.clientWidth / 10
					if diff1 >= PINCH_THRESHHOLD and diff2 >= PINCH_THRESHHOLD then bakgrund = "green"
				else
					tpCache = []
	catch e
		log "error in HPZ",e,ev

touchStarted = (ev) ->
	try
		console.log ev
		# If the user makes simultaneious touches, the browser will fire a
		# separate touchstart event for each touch point. Thus if there are
		# three simultaneous touches, the first touchstart event will have
		# targetTouches length of one, the second event will have a length
		# of two, and so on.
		ev.preventDefault()
		# Cache the touch points for later processing of 2-touch pinch/zoom
		if touches.length == 2
			for t in touches
				tpCache.push t
		if logEvents then log "touchStart", ev, true
		update_background ev
	catch e
		log "error in Started",e,ev

touchMoved = (ev) ->
	try
		console.log ev
		# Note: if the user makes more than one "simultaneous" touches, most browsers
		# fire at least one touchmove event and some will fire several touchmoves.
		# Consequently, an application might want to "ignore" some touchmoves.
		#
		# This function sets the target element's outline to "dashed" to visualy
		# indicate the target received a move event.
		#
		ev.preventDefault()
		if logEvents then log "touchMove", ev, false

		# To avoid too much color flashing many touchmove events are started,
		# don't update the background if two touch points are active
		if not touches.length == 2 # and ev.targetTouches.length == 2)
			update_background ev

		# Set the target element's outline to dashed to give a clear visual
		# indication the element received a move event.
		ev.target.style.outline = "dashed"

		# Check this event for 2-touch Move/Pinch/Zoom gesture
		handle_pinch_zoom ev
	catch 
		log "error in Moved",ev

touchEnded = (ev) ->
	try	
		console.log ev
		ev.preventDefault()
		if logEvents then log ev.type, ev, false
		if touches.length == 0
			# Restore background and outline to original values
			ev.target.style.background = "white"
			ev.target.style.outline = "1px solid black"
	catch e
		log "error in Ended",e,ev

# set_handlers = (name) ->
# 	# Install event handlers for the given element
# 	el = document.getElementById name
# 	el.ontouchstart = start_handler
# 	el.ontouchmove = move_handler
# 	# Use same handler for touchcancel and touchend
# 	el.ontouchcancel = end_handler
# 	el.ontouchend = end_handler

# init = ->
# 	set_handlers "target1"
# 	set_handlers "target2"
# 	set_handlers "target3"
# 	set_handlers "target4"
