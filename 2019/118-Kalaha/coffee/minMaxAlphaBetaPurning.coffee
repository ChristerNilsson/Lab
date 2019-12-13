MinMaxDecisionAlphaBetaPruning = (depthMax, player) ->
	alpha = -1000
	beta = 1000

	house = []

	for i in range 14
		house[i] = parseInt(document.getElementById("house" + i.toString()).innerHTML)

	playerShop = 6
	if player == 1 then playerShop = 13

	return MaxValueAlphaBetaPruning(house, depthMax, 0, alpha, beta, playerShop)

MaxValueAlphaBetaPruning = (house, depthMax, depth, alpha, beta, playerShop) ->
	if HasSuccessors(house) == false
		FinalScoring(house)
		return Evaluate(house, playerShop, (playerShop + 7) % 14)
	else if depth >= depthMax
		return Evaluate(house, playerShop, (playerShop + 7) % 14)
	else
		action = null
		for i in range playerShop - 6, playerShop
			if house[i] == 0 then continue

			tempHouse = []
			tempValue = null
			for j in range 14
				tempHouse[j] = house[j]

			if Relocation(tempHouse, i)
				tempValue = MaxValueAlphaBetaPruning(tempHouse, depthMax, depth + 2, alpha, beta, playerShop)
			else
				tempValue = MinValueAlphaBetaPruning(tempHouse, depthMax, depth + 1, alpha, beta, playerShop)

			if alpha < tempValue
				alpha = tempValue
				action = i

			if alpha >= beta then break

		if depth == 0
			return action
		else
			return alpha

MinValueAlphaBetaPruning = (house, depthMax, depth, alpha, beta, playerShop) ->
	if HasSuccessors(house) == false
		FinalScoring(house)
		return Evaluate(house, playerShop, (playerShop + 7) % 14)
	else if depth >= depthMax
		return Evaluate(house, playerShop, (playerShop + 7) % 14)
	else 
		opponentShop = (playerShop + 7) % 14
		for i in range opponentShop - 6, opponentShop
			if house[i] == 0 then continue

			tempHouse = []
			tempValue = null
			for j in range 14
				tempHouse[j] = house[j]
			
			if Relocation(tempHouse, i)
				tempValue = MinValueAlphaBetaPruning(tempHouse, depthMax, depth + 2, alpha, beta, playerShop)
			else
				tempValue = MaxValueAlphaBetaPruning(tempHouse, depthMax, depth + 1, alpha, beta, playerShop)

			if beta > tempValue then beta = tempValue

			if alpha >= beta then break
		return beta
