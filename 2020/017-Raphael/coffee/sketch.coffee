boxes = []

#values that define the graphical properties of the page
p = null 
SIZE = 20

class Box 
	constructor : (x,y,w,h,name) ->

		#deal with this individual box, position it and show a status based on color
		Rect = p.rect x, y, w, h
			.attr {fill: '#aaa'}

		Text = p.text x + w / 2, y + h / 2, name
			.attr {font: '12px Arial', fill: '#000'}
				
		#create the drag icon for this box
		Rect.resizer = p.rect x + w - SIZE, y + h - SIZE, SIZE, SIZE
			.attr { fill: '#0ab', stroke: 'solid', opacity: 1}
		
		#define relations and functions for moving and positioning
		#move the boxes
		Rect.drag @move_drag, @move_start, @move_up
		Rect.boxtext = Text
		
		#resize the boxes
		Rect.resizer.drag @resize_drag, @resize_start, @resize_up
		Rect.resizer.resizer = Rect
		Rect.resizer.boxtext = Text

	#start, move, and up are the drag functions
	move_start : ->
		#storing original coordinates
		@ox = @attr 'x'
		@oy = @attr 'y'
		@attr {opacity: 0.5}
		
		#the resizer box
		@resizer.ox = @resizer.attr 'x'
		@resizer.oy = @resizer.attr 'y'
		@resizer.attr {opacity: 0.5}
		
		#the box text
		@boxtext.ox = @attr('x') + @attr('width') / 2
		@boxtext.oy = @attr('y') + @attr('height') / 2
		@boxtext.attr {opacity: 0.5}

	#visually change the box when it is being moved
	move_drag : (dx, dy) ->
		#move will be called with dx and dy
		@attr {x: @ox + dx, y: @oy + dy}

		@resizer.attr {x: @resizer.ox + dx, y: @resizer.oy + dy}
		@boxtext.attr {x: @boxtext.ox + dx, y: @boxtext.oy + dy}

	#when the user lets go of the mouse button, reset the square's properties
	move_up : ->
		#restoring the visual state
		@attr {opacity: 1}
		@resizer.attr {opacity: 1}
		@boxtext.attr {opacity: 1}
		
		#here is where you would update the box's position externally
		#...
	resize_start : ->
		#storing original coordinates
		@ox = @attr 'x'
		@oy = @attr 'y'
		
		#the resizer box
		@resizer.ow = @resizer.attr 'width'
		@resizer.oh = @resizer.attr 'height'
		
		#the box text
		@boxtext.ox = @resizer.attr('x') + @resizer.attr('width') / 2
		@boxtext.oy = @resizer.attr('y') + @resizer.attr('height') / 2

	resize_drag : (dx, dy) ->
		# move will be called with dx and dy
		@attr {x: @ox + dx, y: @oy + dy}
		@resizer.attr {width: @resizer.ow + dx, height: @resizer.oh + dy}
		@boxtext.attr {x: @boxtext.ox + (dx / 2), y: @boxtext.oy + (dy / 2)}

	resize_up : ->
		#here is where you would update the box's position externally
		#...

#the primary function of this page
startup = ->
	#initialize the main graphics object that is used to draw the box icons
	p = Raphael 'canvasdiv', window.innerWidth, window.innerHeight
	boxes.push new Box  10, 10, 70, 70, 'A'
	boxes.push new Box 110, 10, 70, 70, 'B'
	boxes.push new Box 210, 10, 80, 80, 'C'
	boxes.push new Box 310, 10, 90, 90, 'D'
