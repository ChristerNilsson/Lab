CRLF = "\n"

meny = null

window.onload = -> 
	#world = generateTree 3
	meny = new Menu world

generateTree = (level) ->
	if level == 0 then return {}
	hsh = {}
	for key in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
		hsh[key+Math.random(10)] = generateTree level-1
	hsh

#console.log generateTree 3