slump = Math.floor 16 * Math.random()
gissning = -1
meddelande = "Gissa ett tal!"
while gissning != slump
	gissning = parseInt prompt meddelande
	if gissning < slump then meddelande = "H�gre!"
	else if gissning > slump then meddelande = "L�gre!"
alert "Korrekt!"