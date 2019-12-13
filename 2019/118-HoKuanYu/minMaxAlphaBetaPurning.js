function MinMaxDecisionAlphaBetaPurning(depthMax, player) {
	var alpha = -1000;
	var beta = 1000;

	var house = [];

	for (var i = 0; i < 14; ++i) {
		house[i] = parseInt(document.getElementById("house" + i.toString()).innerHTML);
	}

	var playerShop = 6;
	if (player === 1)
		playerShop = 13;

	return MaxValueAlphaBetaPurning(house, depthMax, 0, alpha, beta, playerShop);
}

function MaxValueAlphaBetaPurning(house, depthMax, depth, alpha, beta, playerShop) {
	if (HasSuccessors(house) === false) {
		FinalScoring(house);
		return Evaluate(house, playerShop, (playerShop + 7) % 14);
	}
	else if (depth >= depthMax) {
		return Evaluate(house, playerShop, (playerShop + 7) % 14);
	}
	else {
		var action;
		for (var i = playerShop - 6; i < playerShop; ++i) {
			if (house[i] === 0)
				continue;

			var tempHouse = [], tempValue;
			for (var j = 0; j < 14; ++j)
				tempHouse[j] = house[j];

			if (Relocation(tempHouse, i))
				tempValue = MaxValueAlphaBetaPurning(tempHouse, depthMax, depth + 2, alpha, beta, playerShop);
			else
				tempValue = MinValueAlphaBetaPurning(tempHouse, depthMax, depth + 1, alpha, beta, playerShop);

			if (alpha < tempValue) {
				alpha = tempValue;
				action = i;
			}

			if (alpha >= beta)
				break;
		}

		if (depth === 0)
			return action;
		else
			return alpha;
	}
}

function MinValueAlphaBetaPurning(house, depthMax, depth, alpha, beta, playerShop) {
	if (HasSuccessors(house) === false) {
		FinalScoring(house);
		return Evaluate(house, playerShop, (playerShop + 7) % 14);
	}
	else if (depth >= depthMax) {
		return Evaluate(house, playerShop, (playerShop + 7) % 14);
	}
	else {
		var oppoentShop = (playerShop + 7) % 14;
		for (var i = oppoentShop - 6; i < oppoentShop; ++i) {
			if (house[i] === 0)
				continue;

			var tempHouse = [], tempValue;
			for (var j = 0; j < 14; ++j)
				tempHouse[j] = house[j];

			
			if (Relocation(tempHouse, i))
				tempValue = MinValueAlphaBetaPurning(tempHouse, depthMax, depth + 2, alpha, beta, playerShop);
			else
				tempValue = MaxValueAlphaBetaPurning(tempHouse, depthMax, depth + 1, alpha, beta, playerShop);

			if (beta > tempValue)
				beta = tempValue;

			if (alpha >= beta)
				break;
		}
		return beta;
	}
}