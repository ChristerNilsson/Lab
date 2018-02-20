
fixColor = (args) ->
  n = args.length
  r=0
  g=0
  b=0
  a=1
  if n == 1
    r = args[0]
    g = r
    b = r
  else if n == 3
    r = args[0]
    g = args[1]
    b = args[2]
  else if n==4
    r = args[0]
    g = args[1]
    b = args[2]
    a = args[3]    
  return color 255 * r, 255 * g, 255 * b, 255 * a

bg = ->
  fill fixColor arguments
  rect 0, 0, 200, 200

fc = ->
  n = arguments.length
  if n == 0
    noFill()
  else
    fill fixColor arguments

sc = (r, g, b) ->
  n = arguments.length
  if n == 0
    noStroke()
  else
    stroke fixColor arguments

sw = (n) -> strokeWeight n

circle = (x,y,r) -> ellipse x,y,2*r,2*r
rd = (vinkel) -> rotate radians vinkel
print = console.log
range = _.range

fraction = (x) -> x %% 1
