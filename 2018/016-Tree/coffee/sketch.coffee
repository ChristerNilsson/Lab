CRLF = "\n"

tree = null

window.onload = -> 
	#console.log world = generateTree 20
	tree = new Tree world

generateTree = (level,title='') ->
	if level == 0 then return {}
	hsh = {}
	for key in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
		hsh[title+key] = generateTree level-1,title+key
	hsh
