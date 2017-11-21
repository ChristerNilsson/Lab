languages = []
index = 1

setup = ->
	createCanvas 400,400

	se = []
	se.push "Öppna filen coffee/sketch.coffee"
	se.push "Ändra bakgrundsfärg till 1"
	se.push "Spara med ctrl+s"
	se.push "Gå till Chrome och utför Refresh"
	se.push ""
	se.push "Click for English!"
	languages.push se

	uk = []
	uk.push "Open the file coffee/sketch.coffee"
	uk.push "Change background color to 1"
	uk.push "Save with ctrl+s"
	uk.push "Go to Chrome and Refresh"
	uk.push ""
	uk.push "Klicka för svenska!"
	languages.push uk

	textSize 24
	sc()

draw = ->
	bg 0.5
	for rad,i in languages[index]
		if i==5 then fc 0 else fc 1,0,0
		text rad,10,160+30*i

mousePressed = -> index=1-index
keyPressed   = -> index=1-index