streams = []
fadeInterval = 1.6
symbolSize = 14

setup = -> 
  createCanvas window.innerWidth, window.innerHeight
  x = 0
  for i in range width / symbolSize
    stream = new Stream()
    stream.generateSymbols x, random -2000, 0
    streams.push stream
    x += symbolSize
  textFont 'Consolas'
  textSize symbolSize

draw = ->
  bg 0
  for stream in streams
    stream.render()

class Symbol
  constructor : (@x, @y, @speed, @first, @opacity) ->	@switchInterval = round random 2, 25
  rain : -> @y = if @y >= height then 0 else @y += @speed
  setToRandomSymbol : () ->
    if frameCount % @switchInterval == 0
      if random(0, 5) > 1 then @value = String.fromCharCode 0x30A0 + round random 0, 96
      else @value = round random 0,9

class Stream
	constructor : ->
	  @symbols = []
	  @totalSymbols = round random 5, 35
	  @speed = random 5, 22
  generateSymbols :(x, y) ->
    opacity = 1
    first = 1 == round random 0, 4
    for i in range @totalSymbols
      symbol = new Symbol x,y,@speed,first,opacity
      symbol.setToRandomSymbol()
      @symbols.push symbol
      opacity -= 1 / @totalSymbols / fadeInterval 
      y -= symbolSize
      first = false
  render : () ->
    for symbol in @symbols
      if symbol.first then fc 0.55, 1, 0.67, symbol.opacity
      else fc 0, 1, 0.27, symbol.opacity
      text symbol.value, symbol.x, symbol.y
      symbol.rain()
      symbol.setToRandomSymbol()