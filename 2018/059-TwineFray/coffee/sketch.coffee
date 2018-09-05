POTION = 10
SWORD = 50

events.Start = ->
	t "Valhalla V: Odin's Revenge"
	t "by Mr. Riley"
	button "Town","CLICK HERE TO START"
	person.health = 100
	person.sword = 0
	person.ax = 0
	person.coins = 100
	person.points = 0

events.Town = ->
	t "You are standing in the middle of town."
	t "Where do you want to go?"
	button "Market"
	button "Castle"
	button "Graveyard"
	button "Farm"

events.Market = ->
	if person.coins >= POTION then button "Potion", "Buy A Healing Potion For #{POTION} Coins"
	else t "Healing potions cost #{POTION}, but you only have #{person.coins}"
	if person.coins >= SWORD then button "Sword", "Buy A Sword For #{SWORD} Coins"
	else t "Swords cost #{SWORD}, but you only have #{person.coins}"
	button "Town","Return to Town"

events.Potion = ->
	person.health += POTION
	person.coins -= POTION
	t "+10 health!"
	t "You now have #{person.health} health!"
	t "-10 coins."
	t "You now have #{person.coins} coins"
	display "Market"

events.Sword = ->
	person.sword++
	person.coins -= SWORD
	t "+1 sword!"
	t "You now have a Level #{person.sword} sword!"
	t "-#{SWORD} coins."
	t "You now have #{person.coins} coins."
	display "Market"

events.Castle = -> place "Castle"
events.Graveyard = -> place "Graveyard"
events.Farm = -> place "Farm"
place = (name) ->
	if 1 == rand 1,5
		person.location = name
		display 'fightEnemy'
	else
		t "The #{name} looks empty... for now. Check later."
		button "Town","Go back to Town"

events.fightEnemy = ->
	t "You are at the #{person.location}"
	enemy.name = _.sample ["Giant Spider","Zombie","Ghost","Pizza Rat"]
	t "A #{enemy.name} crawls out of the shadows!"
	enemy.health = rand(20,40) + person.points * .1
	enemy.punch = rand 1,10
	enemy.kick = 10 - enemy.punch
	display 'enemyHitsYou'

events.enemyHitsYou = ->
	if enemy.health > 0
		enemy.hit = rand(1,3) + rand(1,3)
		t "The #{enemy.name} ATTACKS YOU! #{-enemy.hit}"
		person.health -= enemy.hit
		person.points += enemy.hit
		t "You have #{person.health} health"
		if person.health > 0 then display 'useWeapon'
		else display 'youDied'
	else
		t "You have defeated the #{enemy.name}. +10 pts!"
		person.points += 10
		randomCoins = rand 25,50
		person.coins += randomCoins
		t "+#{randomCoins} coins! You now have #{person.coins} coins"
		t "You have #{person.health} health"
		button "Continue"

events.Continue = -> goto person.location

events.useWeapon = ->
	button 'Punch'
	button 'Kick'
	if person.sword > 0 then button 'useSword','Use Sword'
	if person.ax > 0 then button "Use Ax"

events.Punch = -> helper enemy.punch, 'PUNCH'
events.Kick = -> helper enemy.kick, 'KICK'
helper = (value,txt) ->
	hit = value + rand 1,6
	if 1 == rand 1,8 then t "You tried to #{txt} it but you missed!"
	else
		enemy.health -= hit
		person.points += hit
		t "You #{txt} the #{enemy.name}! #{-hit}"
	display 'enemyHitsYou'

events.useSword = -> 
	hit = 10 + rand(1,6) + rand(1,6)
	if rand(1,10) == 1
		t "You tried to SLASH it with your sword but you missed!"
	else
		enemy.health -= hit
		person.points += hit
		t "You SLASH the #{enemy.name} with your sword! #{hit}"
	display 'enemyHitsYou'

events.youDied = ->
	t "You died!"
	t "GAME OVER"
	person.points += person.coins
	t "Final Score: #{person.points}"
