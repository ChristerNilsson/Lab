# Plinko

Engine = Matter.Engine
World = Matter.World
Events = Matter.Events
Bodies = Matter.Bodies

engine = null
world = null
things = []
cols = 22
rows = 12

setup = ->
	createCanvas 1200, 800
	rectMode CENTER
	engine = Engine.create()
	world = engine.world
	world.gravity.y = 0.1
	newBall()
	spacing = width / cols
	for j in range rows
		y = (j+1) * spacing
		for i in range cols+1
			x = if j % 2 == 1 then (i+0.5) * spacing else i * spacing
			things.push new Nail x, y, 2

	things.push new Boundary 0,         height/2,       10, height
	things.push new Boundary width / 2, height+50,      width, 100
	things.push new Boundary width,     height/2,       10, height

	for i in range 4*cols+1
		things.push new Boundary i * spacing/4, height - 100 / 2, 2, 100

newBall = -> things.push new Ball width/2, 0, 5

draw = ->
	background 0
	if frameCount % 20 == 0 then newBall()
	Engine.update engine, 1000 / 30
	thing.show() for thing in things