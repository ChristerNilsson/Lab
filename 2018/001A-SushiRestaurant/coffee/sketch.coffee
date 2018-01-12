MAIL = "janchrister.nilsson@gmail.com"
SHOP = "FU Restaurang" 
CRLF = "\n"

body = null

meny = null
korg = null
send = null
clear = null

# Svart = Closed
# Vitt = Open
# Grön = incr
# Röd = decr
# Gul = valbar maträtt

# iOS visar inga radbrytningar.
# OBS: .cssText måste användas på iPhone 4s

updateTables = ->
	myNode = document.getElementById "help"
	myNode.innerHTML = ''

	meny.table.remove()
	korg.table.remove()

	meny.table = document.createElement "table"
	body.appendChild meny.table
	meny.traverse()

	body.appendChild send
	body.appendChild clear 

	korg.table = document.createElement "table"
	body.appendChild korg.table
	korg.traverse()

calc = (hash) ->
	res = 0
	for key of hash
		res += hash[key]
	res 

window.onload = ->
	body = document.getElementById "body"
	meny = new Menu
	meny.items = menuItems 
	meny.table = document.createElement "table"

	korg = new Korg
	korg.table = document.createElement "table"

	send = makeButton "Send"
	send.style.cssText = "font-size:200%; width:50%"
	send.onclick = -> korg.send()

	clear = makeButton "Clear"
	clear.style.cssText = "font-size:200%; width:50%"
	clear.onclick = -> 
		korg.clear()
		updateTables()

	updateTables()
