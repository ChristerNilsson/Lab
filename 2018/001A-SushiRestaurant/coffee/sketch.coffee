CRLF = "\n"

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

updateTables = (removeHelp=true) ->
	if removeHelp then document.getElementById("help").innerHTML = ''
	meny.rensa()
	meny.traverse()
	korg.rensa()
	korg.traverse()
	korg.updateTotal()

window.onload = ->
	meny = new Menu menuItems
	meny.table = document.getElementById "meny"

	korg = new Korg
	korg.table = document.getElementById "korg"

	send = document.getElementById "send"
	send.onclick = -> korg.send()

	clear = document.getElementById "clear"
	clear.onclick = -> 
		meny.clear()
		korg.clear()
		updateTables()

	updateTables false
