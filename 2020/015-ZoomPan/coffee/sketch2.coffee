logEvents = false
tpCache = []

enableLog = (ev) -> logEvents = not logEvents

log = (name, ev, printTargetIds) ->
	o = document.getElementsByTagName('output')[0]
	s = name + ": touches = " + ev.touches.length + " ; targetTouches = " + ev.targetTouches.length + " ; changedTouches = " + ev.changedTouches.length
	o.innerHTML += s + " <br>"

	if printTargetIds
		s = ""
		for t in ev.targetTouches
			s += "... id = " + t.identifier + " <br>"
		o.innerHTML += s

clearLog = (event) ->
	o = document.getElementsByTagName('output')[0]
	o.innerHTML = ""

update_background = (ev) ->
	n = ev.targetTouches.length
	if n==1 then ev.target.style.background = "yellow"
	else if n==2 then ev.target.style.background = "pink"
	else ev.target.style.background = "lightblue"

# This is a very basic 2-touch move/pinch/zoom handler that does not include
# error handling, only handles horizontal moves, etc.
handle_pinch_zoom = (ev) ->
	if ev.targetTouches.length == 2 and ev.changedTouches.length == 2
		# Check if the two target touches are the same ones that started
		# the 2-touch
		point1 = -1
		point2 = -1
		for i in range tpCache.length
			if tpCache[i].identifier == ev.targetTouches[0].identifier then point1 = i
			if tpCache[i].identifier == ev.targetTouches[1].identifier then point2 = i

			if (point1 >=0 && point2 >= 0) 
				# Calculate the difference between the start and move coordinates
				diff1 = Math.abs(tpCache[point1].clientX - ev.targetTouches[0].clientX)
				diff2 = Math.abs(tpCache[point2].clientX - ev.targetTouches[1].clientX)

				# This threshold is device dependent as well as application specific
				PINCH_THRESHHOLD = ev.target.clientWidth / 10
				if diff1 >= PINCH_THRESHHOLD and diff2 >= PINCH_THRESHHOLD then ev.target.style.background = "green"
			else
				tpCache = []

start_handler = (ev) ->
	# If the user makes simultaneious touches, the browser will fire a
	# separate touchstart event for each touch point. Thus if there are
	# three simultaneous touches, the first touchstart event will have
	# targetTouches length of one, the second event will have a length
	# of two, and so on.
	ev.preventDefault()
	# Cache the touch points for later processing of 2-touch pinch/zoom
	if ev.targetTouches.length == 2
		for t in ev.targetTouches
			tpCache.push t
	if logEvents then log "touchStart", ev, true
	update_background ev

move_handler = (ev) ->
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
	if not (ev.touches.length == 2 and ev.targetTouches.length == 2)
		update_background ev

	# Set the target element's outline to dashed to give a clear visual
	# indication the element received a move event.
	ev.target.style.outline = "dashed"

	# Check this event for 2-touch Move/Pinch/Zoom gesture
	handle_pinch_zoom ev

end_handler = (ev) ->
	ev.preventDefault()
	if logEvents then log ev.type, ev, false
	if ev.targetTouches.length == 0
		# Restore background and outline to original values
		ev.target.style.background = "white"
		ev.target.style.outline = "1px solid black"

set_handlers = (name) ->
	# Install event handlers for the given element
	el = document.getElementById name
	el.ontouchstart = start_handler
	el.ontouchmove = move_handler
	# Use same handler for touchcancel and touchend
	el.ontouchcancel = end_handler
	el.ontouchend = end_handler

init = ->
	set_handlers "target1"
	set_handlers "target2"
	set_handlers "target3"
	set_handlers "target4"
