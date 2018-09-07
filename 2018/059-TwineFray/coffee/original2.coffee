POTION = 10
SWORD = 50

person = {}
#enemy = {}
places = {}
messages = []

class Place
	constructor : (@name) -> @enemy = {}

	enter : ->
		person.location = @name
		inventory()
		@createEnemy()
		button 'Punch', -> 
			print 'Punch',messages.length
			if 0 == _.size @enemy 
				messages.push "You have no enemy here!"
				return 
			if 1 == rand 1,8 
				messages.push "You tried to Punch it but you missed!"
			else
				hit = value + rand 1,6
				@enemy.health -= hit
				person.points += hit
				messages.push "You Punch the #{@enemy.name}! #{-hit}"

		# if 1 == rand 1,3
		# 	@enemy = {}
		# 	Black "The #{@name} looks empty... for now. Check later."
		# else
		# 	@createEnemy()
		# 	@personAttacks()
		link "Town","Go back to Town"

	attack : ->		
		if @enemy.health <= 0
			@enemyDies()
			#enemy = {}
		else
			@enemyAttacks()
			if person.health <= 0 
				@personDies()
			else
				@personAttacks()

	createEnemy: ->
		@enemy = {}
		@enemy.name = either ["Giant Spider","Zombie","Ghost","Pizza Rat"]
		@enemy.health = 0.1 * person.points + rand 20,40 
		@enemy.punch = rand 1,9
		@enemy.kick = 10 - @enemy.punch	
		messages.push "A #{@enemy.name} crawls out of the shadows!"

	enemyAttacks : ->
		@enemy.hit = rand(1,3) + rand(1,3)
		person.health -= @enemy.hit
		person.points -= @enemy.hit
		#messages.push -> Red "The #{@enemy.name} attacks you! You lose #{@enemy.hit} points"

	enemyDies : ->
		person.points += 10
		reward = rand 25,50
		person.coins += reward
		# messages.push -> 
		# 	Black "You have defeated the #{@enemy.name}. +10 points!"
		# 	Green "+#{reward} coins!" 
		# 	@enemy = {}
		link "Continue"

	personDies : ->
		# messages.push ->
		# 	Red "You died!"
		# 	Black "Game over!"
		# 	Black "Final Score: #{person.points + person.coins}"
		link "Continue"

	attack1 : (txt,value) ->
		button txt, -> 
			if 1 == rand 1,8 
				messages.push  "You tried to #{txt} it but you missed!"
			else
				hit = value + rand 1,6
				@enemy.health -= hit
				person.points += hit
				messages.push  "You #{txt} the #{@enemy.name}! #{-hit}"

	personAttacks : ->
		@attack1 'Punch', @enemy.punch + rand 1,6
		@attack1 'Kick',  @enemy.kick + rand 1,6
		if person.sword > 0 then @attack1 'Slash', 10 + rand(1,6) + rand(1,6)
		if person.ax > 0 then @attack1 'Ax', 10 + rand(1,6) + rand(1,6)


events.Start = ->
	person.health = 10 #0
	person.sword = 0
	person.ax = 0
	person.coins = 100
	person.points = 0

	places['Castle'] = new Place 'Castle'
	places['Graveyard'] = new Place 'Graveyard'
	places['Farm'] = new Place 'Farm'

	inventory()
	link "Town"

events.Town = ->
	inventory()
	Black "Where do you want to go?"
	link "Market"
	link "Castle"
	link "Graveyard"
	link "Farm"

buy = (name,price,count=price) ->
	person[name] += count
	person.coins -= price

inventory = ->
	Black "You are at #{page}"
	Black "You have #{person.coins} coins"
	Black "You have #{person.health} health"
	Black "You have #{person.sword} sword"
	Black ""
	# for message in messages
	# 	message()
	# messages = [] 

events.Market = ->
	inventory()
	if person.coins >= POTION then button "Buy A Healing Potion For #{POTION} Coins", -> buy 'health',POTION
	if person.coins >= SWORD then button "Buy A Sword For #{SWORD} Coins", -> buy 'sword',SWORD,1
	link "Town","Return to Town"

events.Castle = -> places.Castle.enter()
events.Graveyard = -> places.Graveyard.enter()
events.Farm = -> places.Farm.enter()

#place = (name) ->

events.Continue = -> goto person.location
