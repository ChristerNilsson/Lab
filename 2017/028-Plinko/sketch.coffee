Engine = Matter.Engine
World = Matter.World
Events = Matter.Events
Bodies = Matter.Bodies

engine=null
world=null
particles = []
plinkos = []
bounds = []
cols = 22
rows = 10

setup = ->
  createCanvas 1200, 800
  #colorMode HSB
  fill 255
  stroke 255
  rectMode CENTER
  engine = Engine.create()
  world = engine.world
  world.gravity.y = 0.1;
  newParticle();
  spacing = width / cols
  for j in range rows
    for i in range cols+1
      x = i * spacing
      if j % 2 == 0 then x += spacing / 2
      y = spacing + j * spacing
      plinkos.push new Plinko x, y, 2

  bounds.push new Boundary width / 2, height + 50, width, 100

  for i in range 2*cols+1
    bounds.push new Boundary i * spacing/2, height - 100 / 2, 2, 100

newParticle = -> particles.push new Particle width/2, 0, 5

draw = ->
  background 0, 0, 0
  if frameCount % 20 == 0 then newParticle()
  Engine.update engine, 1000 / 30
  for i in range particles.length-1,-1,-1
    particle = particles[i]
    particle.show()
    if particle.isOffScreen()
      World.remove world, particle.body
      particles.splice i, 1
  plinko.show() for plinko in plinkos
  bound.show() for bound in bounds     