slump = Math.floor 16 * Math.random()
gissning = -1
meddelande = "Gissa ett tal!"
while gissning != slump
	gissning = parseInt prompt meddelande
	if gissning < slump then meddelande = "Högre!"
	else if gissning > slump then meddelande = "Lägre!"
alert "Korrekt!"