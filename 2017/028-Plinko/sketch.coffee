Engine = Matter.Engine
World = Matter.World
Events = Matter.Events
Bodies = Matter.Bodies

engine=null
world=null
particles = []
plinkos = []
bounds = []
cols = 11
rows = 10

#preload = -> ding = loadSound 'ding.mp3'

setup = ->
  createCanvas 600, 700
  colorMode HSB
  engine = Engine.create()
  world = engine.world
  #world.gravity.y = 2;

  #collision = (event) ->
    #pairs = event.pairs
    #for pair in pairs 
      #labelA = pair.bodyA.label
      #labelB = pair.bodyB.label
      #if labelA == 'particle' and labelB == 'plinko' then ding.play()
      #if labelA == 'plinko' and labelB == 'particle' then ding.play()

  #Events.on engine, 'collisionStart', collision

  newParticle();
  spacing = width / cols
  for j in range rows
    for i in range cols
      x = i * spacing
      if j % 2 == 0 then x += spacing / 2
      y = spacing + j * spacing
      p = new Plinko x, y, 16
      plinkos.push p

  b = new Boundary width / 2, height + 50, width, 100
  bounds.push b

  for i in range cols
    x = i * spacing
    h = 100
    w = 10
    y = height - h / 2
    b = new Boundary x, y, w, h
    bounds.push b

newParticle = ->
  p = new Particle 300, 0, 10
  particles.push p

draw = ->
  background 0, 0, 0
  if frameCount % 20 == 0 then newParticle()
  Engine.update engine, 1000 / 30
  for particle in particles
    particle.show()
    if particle.isOffScreen()
      World.remove world, particle.body
      particles.splice i, 1
      i--
  plinko.show() for plinko in plinkos
  bound.show() for bound in bounds     