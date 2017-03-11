Engine = Matter.Engine
World = Matter.World
Events = Matter.Events
Bodies = Matter.Bodies

engine = null
world = null
things = []
cols = 22
rows = 10

setup = ->
  createCanvas 1200, 800
  rectMode CENTER
  engine = Engine.create()
  world = engine.world
  world.gravity.y = 0.1
  newParticle()
  spacing = width / cols
  for j in range rows
    for i in range cols+1
      x = i * spacing
      if j % 2 == 1 then x += spacing / 2
      y = spacing + j * spacing
      things.push new Plinko x, y, 2

  things.push new Boundary width / 2, height + 50, width, 100
  things.push new Boundary 0, height/2, 5, height
  things.push new Boundary width, height/2, 5, height

  for i in range 2*cols+1
    things.push new Boundary i * spacing/2, height - 100 / 2, 2, 100

newParticle = -> things.push new Particle width/2, 0, 5

draw = ->
  background 0
  if frameCount % 20 == 0 then newParticle()
  Engine.update engine, 1000 / 30
  thing.show() for thing in things