nodes = {}
person = null
page = 'Town'
buttons = []
messages = []

randint = (a,b) -> int a + random(b-a)
p = (s) -> messages.push s

class Button 
	constructor : (@command,@x,@y,@w,@h) ->
	inside : (mx,my) -> @x < mx+@w/2 < @x+@w and @y < my+@h/2 < @y+@h 
	show : -> 		
		rect @x,@y,@w,@h
		text @command,@x,@y

class Node
	constructor : (@name,@commands) ->
	buy : (name,p1,p2) ->
	enter : ->
	execute : (command) ->
		page = command
		nodes[page].enter()

class Person
	constructor : (@health=100, @sword=0, @coins=100, @points=0, @ax=0) ->

class Enemy
	constructor : ->
		@name = _.sample ["Giant Spider","Zombie","Ghost","Pizza Rat"]
		@punch = randint 1,9
		@kick = 10 - @punch
		@health = randint(20,40) + person.points * 0.1

	attack : ->
		if @health > 0
			hit = randint(1,3) + randint(1,3)
			p "The #{@name} attacks You!"
			person.health -= hit
			person.points += hit
		else
			p 'You have defeated the {@name}!'
			person.points += 10
			person.coins += randint 25,50

class Market extends Node
	buy : (name,p1,p2) ->
		if person.coins >= p1
			person.coins -= p1
			person[name] += p2
		else
			p "You cant afford a #{name}"
	execute : (command) ->
		if command == 'Medicine' then @buy 'health', 10, 10
		else if command == 'Sword' then @buy 'sword', 50, 1
		else if command == 'Ax' then @buy 'ax', 100, 1
		else super command

class Place extends Node
	execute : (command) ->
		if command == 'Punch' then @punch()
		else if command == 'Kick' then @kick()
		else if command == 'Slash' then	@slash()
		else if command == 'Ax' then @ax()
		else super command

	enter : ->
		if 0 == randint 0, 1
			@enemy = new Enemy()
			p "There is an #{@enemy.name} here"
		else
			@enemy = null
			p 'There is nothing here'

	punch : -> if @enemy? then @attack 'punch',8,@enemy.punch + randint(1, 6)
	kick  : -> if @enemy? then @attack 'kick', 6, @enemy.kick + randint(1, 6)

	slash : ->
		if person.sword > 0
			@attack 'slash',10, 10 + person.sword * (randint(1, 6) + randint(1, 6))
		else
			p 'You have no sword'

	ax : ->
		if person.ax > 0
			@attack 'ax',5, 10 + person.ax * (randint(4, 6) + randint(4, 6) + randint(4, 6))
		else
			p 'You have no ax'

	attack : (weapon,n,hit) ->
		if @enemy == null
			p 'There is nothing to attack!'
			return
		@enemy.attack()
		if 1 == randint 1,n
			p "Your #{weapon} missed the #{@enemy.name}!"
		else
			@enemy.health -= hit
			person.points += hit
			p "You hit with your #{weapon}!"
			if @enemy.health <= 0
				p "The #{@enemy.name} dies"
				@enemy = null

display = ->
	bg 0.75

	messages.unshift ''
	messages.unshift "Inventory #{JSON.stringify person}"
	messages.unshift "You are in the #{nodes[page].name}"

	for message,i in messages
		text message,20,(i+4)*20

	node = nodes[page]
	commands = node.commands

	buttons = []
	push()
	textAlign CENTER,CENTER
	for command,i in commands.split ' '
		button =  new Button command, 100+i*100,30,100,30
		button.show()
		buttons.push button
	pop()

setup = ->
	createCanvas 600,600
	rectMode CENTER
	textSize 20
	person = new Person()
	nodes.Town = new Node 'Town','Market Castle Graveyard Farm'
	nodes.Market = new Market 'Market','Medicine Sword Ax Town'
	nodes.Castle = new Place 'Castle','Punch Kick Slash Ax Town'
	nodes.Graveyard = new Place 'Graveyard','Punch Kick Slash Ax Town'
	nodes.Farm = new Place 'Farm','Punch Kick Slash Ax Town'
	display()

mousePressed = ->
	messages = []
	for button in buttons
		if button.inside mouseX,mouseY
			print 'You clicked on '+ button.command
			node = nodes[page]
			node.execute button.command
	display()
