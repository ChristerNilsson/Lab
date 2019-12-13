playerTitle = []
playerComputer = []
playerDepth = []
playerMethod = []
player = 0

ActivePlayerHouse = () ->
	playerShop = 6
	opponentShop = 13
	if player == 1
		playerShop = 13
		opponentShop = 6

	for i in range playerShop - 6, playerShop 
		document.getElementById("house" + i.toString()).disabled = document.getElementById("house" + i.toString()).innerHTML == 0

	for i in range opponentShop - 6, opponentShop
		document.getElementById("house" + i.toString()).disabled = true

ActiveComputerHouse = () ->
	for i in range 14
		if i != 6 and i != 13
			document.getElementById("house" + i.toString()).disabled = true

	f = () ->
		action = null
		if playerMethod[player] == 0
			action = MinMaxDecisionAlphaBetaPruning(playerDepth[player], player)
		else
			action = MinMaxDecisionNormal(playerDepth[player], player)
		HouseOnClick(action)

	setTimeout f,20

HouseButtonActive = () ->
	document.getElementById("title").innerHTML = " Turn" + playerTitle[player]
	if playerComputer[player] then ActiveComputerHouse() else ActivePlayerHouse()

HouseOnClick = (pickedHouse) ->
	document.getElementById("infobox").innerHTML += '<div class="row"><label class="col-lg-5 col-form-label text-lg-right">' + playerTitle[player] + ' chosen :</label>' + '<label class="col-lg-6 col-form-label">' + pickedHouse.toString() + '</label></div>'

	house = []
	for i in range 14
		house[i] = parseInt(document.getElementById("house" + i.toString()).innerHTML)

	again = Relocation(house, pickedHouse)

	document.getElementById("infobox").innerHTML += '<div class="row"><label class="col-lg-5 col-form-label text-lg-right">Current Status :</label>' + '<label class="col-lg-6 col-form-label">[' + house.toString() + ']</label></div><br>'

	for i in range 14
		document.getElementById("house" + i.toString()).innerHTML = house[i]

	if again == false then player = 1 - player

	if HasSuccessors(house)
		HouseButtonActive()
		if again then document.getElementById("title").innerHTML += "(play again)"
	else 
		FinalScoring(house)

		for i in range 14
			document.getElementById("house" + i.toString()).innerHTML = house[i]

		for i in range 14
			if i != 6 and i != 13
				document.getElementById("house" + i.toString()).disabled = true

		if house[13] > house[6]
			document.getElementById("title").innerHTML = playerTitle[1] + " Win"
		else if house[13] == house[6]
			document.getElementById("title").innerHTML = " Tie"
		else
			document.getElementById("title").innerHTML = playerTitle[0] + " Win"

		document.getElementById("back").style.display = "block"

	infobox = document.getElementById("infobox")
	infobox.scrollTop = infobox.scrollHeight

Relocation = (house, pickedHouse) ->
	playerShop = 6
	opponentShop = 13
	if pickedHouse > 6
		playerShop = 13
		opponentShop = 6

	index = pickedHouse
	seeds = house[pickedHouse]
	house[index] = 0
	while seeds > 0 
		index = (index + 1) % 14
		if index == opponentShop then continue
		house[index]++
		seeds--

	if index == playerShop then return true

	if house[index] == 1 and house[12 - index] != 0 and index >= (playerShop - 6) and index < playerShop
		house[playerShop] += house[12 - index]
		house[playerShop] += 1
		house[index] = 0
		house[12 - index] = 0
	return false

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

Start = () ->
	for i in range 14
		if i != 6 and i != 13
			document.getElementById("house" + i.toString()).innerHTML = document.getElementById("seeds").value
		else
			document.getElementById("house" + i.toString()).innerHTML = 0

	playerTitle[0] = document.getElementById("player1").value
	playerTitle[1] = document.getElementById("player2").value
	playerDepth[0] = parseInt(document.getElementById("depth1").value)
	playerDepth[1] = parseInt(document.getElementById("depth2").value)
	playerMethod[0] = parseInt(document.getElementById("method1").value)
	playerMethod[1] = parseInt(document.getElementById("method2").value)
	player = 0

	if (parseInt(document.getElementById("mode").value) == 0) 
		playerComputer[0] = false
		playerComputer[1] = false
	else if (parseInt(document.getElementById("mode").value.toString()) == 1) 
		playerComputer[0] = false
		playerComputer[1] = true
	else if (parseInt(document.getElementById("mode").value.toString()) == 2) 
		playerComputer[0] = true
		playerComputer[1] = false
	else 
		playerComputer[0] = true
		playerComputer[1] = true

	document.getElementById("gametable").style.display = "block"
	document.getElementById("back").style.display = "none"
	document.getElementById("main").style.display = "none"

	house = []
	for i in range 14
		house[i] = parseInt(document.getElementById("house" + i.toString()).innerHTML)

	document.getElementById("info").style.display = "block"

	document.getElementById("infobox").innerHTML = '<div class="row"><label class="col-lg-5 col-form-label text-lg-right"> Initial :</label>' + '<label class="col-lg-6 col-form-label">[' + house.toString() + ']</label></div><br>'

	HouseButtonActive()

Back = () ->
	document.getElementById("gametable").style.display = "none"
	document.getElementById("info").style.display = "none"
	document.getElementById("main").style.display = "block"

modeSelectOnChange = () ->
	if (document.getElementById("mode").value == 0) 
		document.getElementById("depth1").disabled = true
		document.getElementById("depth2").disabled = true
		document.getElementById("method1").disabled = true
		document.getElementById("method2").disabled = true
	else if (document.getElementById("mode").value == 1) 
		document.getElementById("depth1").disabled = true
		document.getElementById("depth2").disabled = false
		document.getElementById("method1").disabled = true
		document.getElementById("method2").disabled = false
	else if (document.getElementById("mode").value == 2) 
		document.getElementById("depth1").disabled = false
		document.getElementById("depth2").disabled = true
		document.getElementById("method1").disabled = false
		document.getElementById("method2").disabled = true
	else 
		document.getElementById("depth1").disabled = false
		document.getElementById("depth2").disabled = false
		document.getElementById("method1").disabled = false
		document.getElementById("method2").disabled = false
