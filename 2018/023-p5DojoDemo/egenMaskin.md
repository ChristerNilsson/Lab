## Från p5Dojo till egen maskin

Här ger ett exempel på hur man övergår från p5Dojo.com till utveckling på egen maskin.
Detta kräver installation av coffeescript samt Mall.

* Utgå från övningen L8:Counter

```coffeescript
class Counter extends Application
  reset : ->
    super
    @counter = 0
  up : -> @counter += 1
  down : -> @counter -= 1
  draw : ->
    bg 0.5
    fc 1,1,0
    sc()
    textAlign CENTER,CENTER
    textSize 100
    text @counter,100,100
  mousePressed : (mx,my) -> @counter += if my < 100 then 1 else -1

app = new Counter "a"
```

* Skapa setup
```coffeescript
setup = ->
  createCanvas 200,200
  app = new Counter
```

* Gör app till en global variabel
```coffeescript
app = null

setup = ->
```

* Ta bort arvet till Application
```coffeescript
class Counter extends Application
```
```coffeescript
class Counter
```

* Ersätt reset med en constructor
```coffeescript
class Counter
  reset : ->
    super
    @counter = 0
```
```coffeescript
class Counter
  constructor : -> @counter = 0
```

* Lägg till anrop av draw
```coffeescript
draw = -> app.draw()
```

* Lägg till anrop av mousePressed
```coffeescript
mousePressed = -> app.mousePressed mouseX,mouseY
```

## Slutresultat

```coffeescript
app = null

setup = ->
  createCanvas 200,200
  app = new Counter

class Counter
  constructor : -> @counter = 0
  up : -> @counter++
  down : -> @counter--
  draw : ->
    bg 0.5
    fc 1,1,0
    sc()
    textAlign CENTER,CENTER
    textSize 100
    text @counter,100,100
  mousePressed : (mx,my) -> if my < 100 then @up() else @down()

draw = -> app.draw()
mousePressed = -> app.mousePressed mouseX,mouseY
```

## Slutresultat utan användande av class

```coffeescript
counter = 0

setup = ->
  createCanvas 200,200

up = ->
  counter++

down = ->
  counter--

draw = ->
  bg 0.5
  fc 1,1,0
  sc()
  textAlign CENTER,CENTER
  textSize 100
  text counter,100,100

mousePressed = ->
  if mouseY < 100
    up()
  else
    down()
```