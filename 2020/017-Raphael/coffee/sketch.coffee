boxes = []

#values that define the graphical properties of the page
p = null 

class Box 
	constructor : (x,y,w,h,name) ->

		#deal with this individual box, position it and show a status based on color
		Rect = p.rect x, y, w, h
			.attr {fill: '#aaa'}

		Text = p.text x + w / 2, y + h / 2, name
			.attr {font: '40px Arial', fill: '#000'}

		image = p.image "skarpnäck.png", 0, 0, w,h
				
		#create the drag icon for this box
		# SIZE = h*0.5
		# Rect.resizer = p.rect x + w - SIZE, y + h - SIZE, SIZE, SIZE
		# 	.attr { fill: '#0ab', stroke: 'solid', opacity: 1}
		
		#define relations and functions for moving and positioning
		#move the boxes
		Rect.drag @move_drag, @move_start, @move_up
		Rect.boxtext = Text
		Rect.image = image
		
		#resize the boxes
		# Rect.resizer.drag @resize_drag, @resize_start, @resize_up
		# Rect.resizer.resizer = Rect
		# Rect.resizer.boxtext = Text

	#start, move, and up are the drag functions
	move_start : ->
		#storing original coordinates
		@ox = @attr 'x'
		@oy = @attr 'y'
		@attr {opacity: 0.5}
		 
		#the resizer box
		# @resizer.ox = @resizer.attr 'x'
		# @resizer.oy = @resizer.attr 'y'
		# @resizer.attr {opacity: 0.5}
		
		#the box text
		@boxtext.ox = @attr('x') + @attr('width') / 2
		@boxtext.oy = @attr('y') + @attr('height') / 2
		@boxtext.attr {opacity: 0.5}

		@image.ox = @attr('x') + @attr('width') / 2
		@image.oy = @attr('y') + @attr('height') / 2
		#@boxtext.attr {opacity: 0.5}

	#visually change the box when it is being moved
	move_drag : (dx, dy) ->
		#move will be called with dx and dy
		@attr {x: @ox + dx, y: @oy + dy}

		# @resizer.attr {x: @resizer.ox + dx, y: @resizer.oy + dy}
		@boxtext.attr {x: @boxtext.ox + dx, y: @boxtext.oy + dy}
		@image.attr {x: @image.ox + dx, y: @image.oy + dy}

	#when the user lets go of the mouse button, reset the square's properties
	move_up : ->
		#restoring the visual state
		@attr {opacity: 1}
		# @resizer.attr {opacity: 1}
		@boxtext.attr {opacity: 1}
		
	# resize_start : ->
	# 	#storing original coordinates
	# 	@ox = @attr 'x'
	# 	@oy = @attr 'y'
		
	# 	#the resizer box
	# 	@resizer.ow = @resizer.attr 'width'
	# 	@resizer.oh = @resizer.attr 'height'
		
	# 	#the box text
	# 	@boxtext.ox = @resizer.attr('x') + @resizer.attr('width') / 2
	# 	@boxtext.oy = @resizer.attr('y') + @resizer.attr('height') / 2

	# resize_drag : (dx, dy) ->
	# 	# move will be called with dx and dy
	# 	@attr {x: @ox + dx, y: @oy + dy}
	# 	@resizer.attr {width: @resizer.ow + dx, height: @resizer.oh + dy}
	# 	@boxtext.attr {x: @boxtext.ox + (dx / 2), y: @boxtext.oy + (dy / 2)}

	# resize_up : ->
	# 	#here is where you would update the box's position externally
	# 	#...

startup = ->
	p = Raphael 'canvasdiv', window.innerWidth, window.innerHeight
	p.rect 0, 0, window.innerWidth, window.innerHeight
		.attr {fill: '#ff0'}
	boxes.push new Box 100, 100, 1000, 1000, 'A004'
	# boxes.push new Box 200, 200, 200, 200, 'B'
	# boxes.push new Box 400, 400, 300, 300, 'C'
	# boxes.push new Box 700, 700, 400, 400, 'D'
