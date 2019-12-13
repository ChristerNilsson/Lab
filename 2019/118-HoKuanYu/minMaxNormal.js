function MinMaxDecisionNormal(depthMax, player) {

	var house = [];

	for (var i = 0; i < 14; ++i) {
		house[i] = parseInt(document.getElementById("house" + i.toString()).innerHTML);
	}

	var playerShop = 6;
	if (player === 1)
		playerShop = 13;

	return mValueNormal(house, depthMax, 0, playerShop);
}

function mValueNormal(house, depthMax, depth, playerShop) {
	if (HasSuccessors(house) === false) {
		FinalScoring(house);
		return Evaluate(house, playerShop, (playerShop + 7) % 14);
	}
	else if (depth >= depthMax) {
		return Evaluate(house, playerShop, (playerShop + 7) % 14);
	}
	else if(depth % 2){ //find min
		var oppoentShop = (playerShop + 7) % 14;
		var min = 1000
		for (var i = oppoentShop - 6; i < oppoentShop; ++i) {
			if (house[i] === 0){
				
				continue;
			}

			var tempHouse = [], tempValue;
			for (var j = 0; j < 14; ++j)
				tempHouse[j] = house[j];

			
			if (Relocation(tempHouse, i))
				tempValue = mValueNormal(tempHouse, depthMax, depth + 2, playerShop);
			else
				tempValue = mValueNormal(tempHouse, depthMax, depth + 1, playerShop);

			if (min > tempValue)
				min = tempValue;
		}
		return min;
	}
	else{

		var action;
		var max = -1000;

		for (var i = playerShop - 6; i < playerShop; ++i) {
			if (house[i] === 0){				
				continue;
			}

			var tempHouse = [], tempValue;
			for (var j = 0; j < 14; ++j)
				tempHouse[j] = house[j];

			
			if (Relocation(tempHouse, i))
				tempValue = mValueNormal(tempHouse, depthMax, depth + 2, playerShop);
			else
				tempValue = mValueNormal(tempHouse, depthMax, depth + 1, playerShop);

			if (max < tempValue){
				max = tempValue;
				action = i;
			}
		}

		if (depth === 0){
			return action;
		}
		else
			return max;
	}
}