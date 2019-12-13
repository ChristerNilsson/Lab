var playerTitle = [];
var playerComputer = [];
var playerDepth = [];
var playerMethod = [];
var player;

function ActivePlayerHouse() {
	var playerShop = 6, opponentShop = 13;
	if (player == 1) {
		playerShop = 13;
		opponentShop = 6;
	}

	for (var i = playerShop - 6; i < playerShop; ++i) {
		if (document.getElementById("house" + i.toString()).innerHTML != 0)
			document.getElementById("house" + i.toString()).disabled = false;
		else
			document.getElementById("house" + i.toString()).disabled = true;
	}

	for (var i = opponentShop - 6; i < opponentShop; ++i)
		document.getElementById("house" + i.toString()).disabled = true;
}

function ActiveComputerHouse() {
	for (var i = 0; i < 14; ++i) {
		if (i != 6 && i != 13)
			document.getElementById("house" + i.toString()).disabled = true;
	}

	setTimeout(function() {
		var action;
		if (playerMethod[player] == 0)
			action = MinMaxDecisionAlphaBetaPurning(playerDepth[player], player);
		else
			action = MinMaxDecisionNormal(playerDepth[player], player);
		HouseOnClick(action);
	}, 20);
}

function HouseButtonActive() {
	document.getElementById("title").innerHTML = "輪到" + playerTitle[player];

	if (playerComputer[player])
		ActiveComputerHouse();
	else
		ActivePlayerHouse();
}

function HouseOnClick(pickedHouse) {
	document.getElementById("infobox").innerHTML += '<div class="row"><label class="col-lg-5 col-form-label text-lg-right">' + playerTitle[player] + '選擇了 :</label>'
										+ '<label class="col-lg-6 col-form-label">' + pickedHouse.toString() + '</label></div>';

	var house = [];
	for (var i = 0; i < 14; ++i) {
		house[i] = parseInt(document.getElementById("house" + i.toString()).innerHTML);
	}

	var again = Relocation(house, pickedHouse);

	document.getElementById("infobox").innerHTML += '<div class="row"><label class="col-lg-5 col-form-label text-lg-right">現在狀態 :</label>'
										+ '<label class="col-lg-6 col-form-label">[' + house.toString() + ']</label></div><br>';

	for (var i = 0; i < 14; ++i) {
		document.getElementById("house" + i.toString()).innerHTML = house[i];
	}

	if (again == false)
		player = (player == 1 ? 0 : 1);

	if (HasSuccessors(house)) {
		HouseButtonActive();

		if (again == true)
			document.getElementById("title").innerHTML += "(再玩一次)";
	}
	else {
		FinalScoring(house);

		for (var i = 0; i < 14; ++i)
			document.getElementById("house" + i.toString()).innerHTML = house[i];

		for (var i = 0; i < 14; ++i)
			if (i != 6 && i != 13)
				document.getElementById("house" + i.toString()).disabled = true;

		if (house[13] > house[6])
			document.getElementById("title").innerHTML = playerTitle[1] + "獲勝";
		else if (house[13] == house[6])
			document.getElementById("title").innerHTML = "平手";
		else
			document.getElementById("title").innerHTML = playerTitle[0] + "獲勝";

		document.getElementById("back").style.display = "block";
	}

	var infobox = document.getElementById("infobox");
	infobox.scrollTop = infobox.scrollHeight;
}

function Relocation(house, pickedHouse) {
	var playerShop = 6, opponentShop = 13;
	if (pickedHouse > 6) {
		playerShop = 13;
		opponentShop = 6;
	}

	var index = pickedHouse, seeds = house[pickedHouse];
	house[index] = 0;
	while (seeds > 0) {
		index = (index + 1) % 14;
		if (index === opponentShop)
			continue;

		house[index] += 1;
		seeds -= 1;
	}

	if (index === playerShop)
		return true;

	if (house[index] == 1 && house[12 - index] != 0 && index >= (playerShop - 6) && index < playerShop) {
		house[playerShop] += house[12 - index];
		house[playerShop] += 1;
		house[index] = 0;
		house[12 - index] = 0;
	}

	return false;
}

function FinalScoring(house) {
	for (var i = 0; i < 6; ++i) {
		house[6] += house[i];
		house[13] += house[7 + i];
		house[i] = house[7 + i] = 0;
	}
}

function Evaluate(house, player1, player2) {
	return house[player1] - house[player2];
}

function HasSuccessors(house) {
	var player1 = false, player2 = false;

	for (var i = 0; i < 6; ++i) {
		if (house[i] != 0)
			player1 = true;

		if (house[7 + i] != 0)
			player2 = true;
	}

	return player1 && player2;
}

function Start() {
	for (var i = 0; i < 14; ++i) {
		if (i != 6 && i != 13)
			document.getElementById("house" + i.toString()).innerHTML = document.getElementById("seeds").value;
		else
			document.getElementById("house" + i.toString()).innerHTML = 0;
	}

	playerTitle[0] = document.getElementById("player1").value;
	playerTitle[1] = document.getElementById("player2").value;
	playerDepth[0] = parseInt(document.getElementById("depth1").value);
	playerDepth[1] = parseInt(document.getElementById("depth2").value);
	playerMethod[0] = parseInt(document.getElementById("method1").value);
	playerMethod[1] = parseInt(document.getElementById("method2").value);
	player = 0;

	if (parseInt(document.getElementById("mode").value) === 0) {
		playerComputer[0] = false;
		playerComputer[1] = false;
	}
	else if (parseInt(document.getElementById("mode").value.toString()) === 1) {
		playerComputer[0] = false;
		playerComputer[1] = true;
	}
	else if (parseInt(document.getElementById("mode").value.toString()) === 2) {
		playerComputer[0] = true;
		playerComputer[1] = false;
	}
	else {
		playerComputer[0] = true;
		playerComputer[1] = true;
	}

	document.getElementById("gametable").style.display = "block";
	document.getElementById("back").style.display = "none";
	document.getElementById("main").style.display = "none";

	var house = [];
	for (var i = 0; i < 14; ++i) {
		house[i] = parseInt(document.getElementById("house" + i.toString()).innerHTML);
	}

	document.getElementById("info").style.display = "block";

	document.getElementById("infobox").innerHTML = '<div class="row"><label class="col-lg-5 col-form-label text-lg-right">初始 :</label>'
												+ '<label class="col-lg-6 col-form-label">[' + house.toString() + ']</label></div><br>';

	HouseButtonActive();
}

function Back() {
	document.getElementById("gametable").style.display = "none";
	document.getElementById("info").style.display = "none";
	document.getElementById("main").style.display = "block";
}

function modeSelectOnChange() {
	if (document.getElementById("mode").value == 0) {
		document.getElementById("depth1").disabled = true;
		document.getElementById("depth2").disabled = true;
		document.getElementById("method1").disabled = true;
		document.getElementById("method2").disabled = true;
	}
	else if (document.getElementById("mode").value == 1) {
		document.getElementById("depth1").disabled = true;
		document.getElementById("depth2").disabled = false;
		document.getElementById("method1").disabled = true;
		document.getElementById("method2").disabled = false;
	}
	else if (document.getElementById("mode").value == 2) {
		document.getElementById("depth1").disabled = false;
		document.getElementById("depth2").disabled = true;
		document.getElementById("method1").disabled = false;
		document.getElementById("method2").disabled = true;
	}
	else {
		document.getElementById("depth1").disabled = false;
		document.getElementById("depth2").disabled = false;
		document.getElementById("method1").disabled = false;
		document.getElementById("method2").disabled = false;
	}
}