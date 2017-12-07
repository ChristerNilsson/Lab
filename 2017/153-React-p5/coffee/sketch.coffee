export default sketch = (p) ->
	rotation = 0
	direction = 1

	p.setup = -> p.createCanvas 200, 200

	p.draw = ->
		p.background 100
		p.translate 100,100
		p.rectMode p.CENTER
		p.rotate p.radians rotation
		p.rect 0,0,100,100 
		rotation += direction

	p.mousePressed = -> direction = -direction

