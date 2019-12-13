minimax = (depthMax, player) ->
	house = buttons.map (button) -> button.value
	playerShop = 6
	if player == 1 then playerShop = 13
	mValueNormal house, depthMax, 0, playerShop

mValueNormal = (house, depthMax, depth, playerShop) ->
	if HasSuccessors(house) == false
		FinalScoring(house)
		return Evaluate(house, playerShop, (playerShop + 7) % 14)
	else if depth >= depthMax
		return Evaluate(house, playerShop, (playerShop + 7) % 14)
	else if depth % 2
		opponentShop = (playerShop + 7) % 14
		min = 1000
		for i in range opponentShop - 6, opponentShop
			if house[i] == 0 then continue

			tempHouse = house.slice()
			tempValue = null
			
			if Relocation(tempHouse, i)
				tempValue = mValueNormal(tempHouse, depthMax, depth + 2, playerShop)
			else
				tempValue = mValueNormal(tempHouse, depthMax, depth + 1, playerShop)

			if min > tempValue then min = tempValue
		return min
	else

		action = null
		max = -1000

		for i in range playerShop - 6, playerShop
			if house[i] == 0 then continue

			tempHouse = house.slice()
			tempValue = null
			
			if Relocation(tempHouse, i)
				tempValue = mValueNormal(tempHouse, depthMax, depth + 2, playerShop)
			else
				tempValue = mValueNormal(tempHouse, depthMax, depth + 1, playerShop)

			if max < tempValue
				max = tempValue
				action = i

		if depth == 0 then return action else return max
