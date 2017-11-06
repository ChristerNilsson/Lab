N = 6
data = []

setup = -> 
	for i in range N
		data.push [0,0,0,-1,0] # empty,rest,active,state,timestamp
	document.documentElement.webkitRequestFullScreen()
	
proc = (x) -> round 100*x

stamp = (index,st) ->
	buttons = [e0,r0,a0,d0, e1,r1,a1,d1, e2,r2,a2,d2, e3,r3,a3,d3, e4,r4,a4,d4, e5,r5,a5,d5]
	newbutton = buttons[4*index+st]
	txt = buttons[4*index+3]
	state = data[index][3]
	timestamp = data[index][4]

	if state != -1 then oldbutton = buttons[4*index+state] else oldbutton = null
	if state == -1
		timestamp = millis()
		state = st
		newbutton.style = "background-color: " + ['red','yellow','green'][st]
	else		
		if state == st # stoppa 
			data[index][state] += int(millis() - timestamp)
			timestamp = int millis()
			state = -1
			oldbutton.style = ''
		else # stoppa samt starta ny räknare
			data[index][state] += int(millis() - timestamp)
			timestamp = int millis()
			state = st
			oldbutton.style = ''
			newbutton.style = "background-color: " + ['red','yellow','green'][st]
	data[index][3] = state
	data[index][4] = timestamp

	total = data[index][0] + data[index][1] + data[index][2] + 1
	print proc(data[index][0]/total), proc(data[index][1]/total), proc(data[index][2]/total)

	txt.innerHTML = proc(data[index][0]/total) + ' ' + proc(data[index][1]/total) + ' ' + proc(data[index][2]/total)
