MAIL = "janchrister.nilsson@gmail.com"
SHOP = "FU Restaurang" 
CRLF = "\n"

body = null

meny = null
korg = null
send = null
rensa = null

# Svart = Closed
# Vitt = Open
# Grön = incr
# Röd = decr

# iOS visar inga radbrytningar.
# OBS: .cssText måste användas på iPhone 4s

updateTables = ->
	meny.table.remove()
	send.remove()
	korg.table.remove()

	meny.table = document.createElement "table"
	body.appendChild meny.table
	meny.traverse()

	body.appendChild send
	body.appendChild rensa 

	korg.table = document.createElement "table"
	body.appendChild korg.table
	korg.traverse()

calc = (hash) ->
	res = 0
	for key of hash
		res += hash[key]
	res 

window.onload = ->
	w = window.innerWidth
	body = document.getElementById "body"

	meny = new Menu
	meny.items = menuItems 
	meny.table = document.createElement "table"
	meny.traverse()

	korg = new Korg
	korg.table = document.createElement "table"
	korg.traverse korg.items

	send = document.createElement "input"
	send.type = 'button'
	send.value = 'Skicka'
	send.style.cssText = "font-size:200%; width:50%"
	send.onclick = -> korg.send()

	rensa = document.createElement "input"
	rensa.type = 'button'
	rensa.value = 'Rensa'
	rensa.style.cssText = "font-size:200%; width:50%"
	rensa.onclick = -> 
		korg.rensa()
		updateTables()

	body.appendChild meny.table
	body.appendChild send
	body.appendChild rensa
	body.appendChild korg.table
