CRLF = "\n"

meny = null

updateTables = ->
	meny.rensa()
	meny.traverse()

window.onload = ->
	meny = new Menu menuItems, document.getElementById "meny"
	updateTables()
