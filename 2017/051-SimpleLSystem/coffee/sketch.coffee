current = 'A'
count = 0
show = null
results = ''

setup = ->
  instructions = createP "<a href='#'>Click the mouse to generate.</a>"
  instructions.position 50,50
  instructions.class 'clickable'
  instructions.mousePressed generate

  results += "Generation #{count}: #{current} <br>"
  show = createP results
  show.position 50,100

generate = ->
  hash = {A:'AB', B:'A'}
  current = (hash[c] for c in current when hash[c]?).join ''
  results += "Generation #{++count}: #{current} <br>"
  show.html results