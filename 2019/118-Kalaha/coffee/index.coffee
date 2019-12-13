playerTitle = ['Human','Computer']
playerComputer = [false,true]
player = 0 # 0 or 1
beans = 3
depth = 1
buttons = []
messages = '1 0'.split ' '

class Button
	constructor : (@x,@y,@value,@click=->) -> @radie=20
	draw : ->
		circle @x,@y,@radie
		textAlign CENTER,CENTER
		if @value > 0 then text @value,@x,@y
	inside : (x,y) -> @radie > dist x,y,@x,@y

setup = ->
	createCanvas 450,150
	textAlign CENTER,CENTER
	textSize 20
	for i in range 6
		do (i) ->
			buttons.push new Button 100+50*i,100,beans,() -> HouseOnClick i
	buttons.push new Button 400,75,0
	for i in range 7,13
		buttons.push new Button 100+50*(12-i),50,beans
	buttons.push new Button 50,75,0
	reset beans

xdraw = ->
	bg 0.5
	for button in buttons
		button.draw()
	textAlign CENTER,CENTER
	text messages[0],20,20
	text messages[1]+'ms',width-40,130
	textAlign LEFT,CENTER
	text messages[2],20,130

mousePressed = () ->
	for button in buttons
		if button.inside mouseX,mouseY then button.click()

reset = (b) ->
	if b > 0 then	beans = b
	for button in buttons
		button.value = beans
	buttons[6].value = 0
	buttons[13].value = 0
	if depth < 1 then depth = 1
	messages[0] = depth
	messages[1] = 0
	messages[2] = ''
	xdraw()

keyPressed = -> 
	if messages[2]=='' then return 
	index = " 1234567890".indexOf key
	if index >= 0 then reset index

ActiveComputerHouse = () -> HouseOnClick MinMaxDecisionAlphaBetaPruning depth, player # MinMaxDecisionNormal depth, player
HouseButtonActive = () -> if playerComputer[player] then ActiveComputerHouse() 

HouseOnClick = (pickedHouse) ->
	if buttons[pickedHouse].value == 0 then return 
	start = new Date()
	house = buttons.map (button) -> button.value
	again = Relocation(house, pickedHouse)
	for i in range 14
		buttons[i].value = house[i]
	if again == false then player = 1 - player
	if HasSuccessors(house)
		HouseButtonActive()
	else 
		FinalScoring(house)
		for i in range 14
			buttons[i].value = house[i]

		if house[13] > house[6]
			messages[2] = playerTitle[1] + " Win"
			depth--
		else if house[13] == house[6]
			messages[2] " Tie"
		else
			messages[2] = playerTitle[0] + " Win"
			depth++
	messages[1] = new Date() - start
	xdraw()

Relocation = (house, pickedHouse) ->
	playerShop = 6
	opponentShop = 13
	if pickedHouse > 6
		playerShop = 13
		opponentShop = 6

	index = pickedHouse
	while house[pickedHouse] > 0 
		index = (index + 1) % 14
		if index == opponentShop then continue
		house[index]++
		house[pickedHouse]--

	if index == playerShop then return true

	if house[index] == 1 and house[12 - index] != 0 and index >= (playerShop - 6) and index < playerShop
		house[playerShop] += house[12 - index]
		house[playerShop]++
		house[index] = 0
		house[12 - index] = 0
	false

FinalScoring = (house) ->
	for i in range 6
		house[6] += house[i]
		house[13] += house[7 + i]
		house[i] = house[7 + i] = 0

Evaluate = (house, player1, player2) -> house[player1] - house[player2]

HasSuccessors = (house) ->
	player1 = false
	player2 = false
	for i in range 6
		if house[i] != 0 then player1 = true
		if house[7 + i] != 0 then player2 = true
	player1 and player2
