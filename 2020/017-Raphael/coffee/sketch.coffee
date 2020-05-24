#define 4 boxes to draw on screen
boxes = [
	{x :  10, y : 10, w : 70, h : 70, boxname : 'Box 1'}
	{x : 110, y : 10, w : 70, h : 70, boxname : 'Box 2'}
	{x : 210, y : 10, w : 80, h : 80, boxname : 'Box 3'}
	{x : 310, y : 10, w : 90, h : 90, boxname : 'Box 4'}
]

#values that define the graphical properties of the page
p = null 
dragIconSize = 20

#the primary function of this page
startup = ->
	console.log 'startup'
	#initialize the main graphics object that is used to draw the box icons
	p = Raphael 'canvasdiv', 1000, 752
	drawBoxes()

#start, move, and up are the drag functions
move_start = ->
	console.log 'move_start'
	#storing original coordinates
	@ox = @attr 'x'
	@oy = @attr 'y'
	@attr {opacity: 0.5}
	
	#the resizer box
	@resizer.ox = @resizer.attr 'x'
	@resizer.oy = @resizer.attr 'y'
	@resizer.attr {opacity: 0.5}
	
	#the box text
	@boxtext.ox = @attr('x') + parseInt(@attr 'width') / 2
	@boxtext.oy = @attr('y') + parseInt(@attr 'height') / 2
	@boxtext.attr {opacity: 0.5}

#visually change the box when it is being moved
move_drag = (dx, dy) ->
	console.log 'move_drag'
	#move will be called with dx and dy
	@attr {x: @ox + dx, y: @oy + dy}
	@resizer.attr {x: @resizer.ox + dx, y: @resizer.oy + dy}
	@boxtext.attr {x: @boxtext.ox + dx, y: @boxtext.oy + dy}

#when the user lets go of the mouse button, reset the square's properties
move_up = ->
	console.log 'move_up'
	#restoring the visual state
	@attr {opacity: 1}
	@resizer.attr {opacity: 1}
	@boxtext.attr {opacity: 1}
	
	#here is where you would update the box's position externally
	#...

resize_start = ->
	console.log 'resize_start'
	#storing original coordinates
	@ox = @attr 'x'
	@oy = @attr 'y'
	
	#the resizer box
	@resizer.ow = @resizer.attr 'width'
	@resizer.oh = @resizer.attr 'height'
	
	#the box text
	@boxtext.ox = @resizer.attr('x') + (parseInt(@resizer.attr('width')) / 2)
	@boxtext.oy = @resizer.attr('y') + (parseInt(@resizer.attr('height')) / 2)

resize_drag = (dx, dy) ->
	console.log 'resize_drag'
	# move will be called with dx and dy
	@attr {x: @ox + dx, y: @oy + dy}
	@resizer.attr {width: @resizer.ow + dx, height: @resizer.oh + dy}
	@boxtext.attr {x: @boxtext.ox + (dx / 2), y: @boxtext.oy + (dy / 2)}

resize_up = ->
	console.log 'resize_up'
	#here is where you would update the box's position externally
	#...

#draw all of the boxes in the json object
drawBoxes = ->
	console.log 'drawBoxes'
	#working arrays
	boxList = []
	boxListText = []
	boxListDrag = []
	
	#loop through all boxes in the json object
	for box,i in boxes
		#extract the positional data from the json array
		{x,y,w,h} = box
		
		#position text in the center of the box
		textx = x + w / 2
		texty = y + h / 2

		#deal with this individual box, position it and show a status based on color
		boxList[i] = p.rect x, y, w, h
			.attr {fill: '#aaa'}
		
		boxListText[i] = p.text textx, texty, box.boxname
			.attr {font: '12px Arial', fill: '#000'}
		
		#position the drag icon
		dragBoxX = x + w - dragIconSize
		dragBoxY = y + h - dragIconSize
		
		#create the drag icon for this box
		boxListDrag[i] = p.rect(dragBoxX, dragBoxY, dragIconSize, dragIconSize)
			.attr { fill: '#0ab', stroke: 'solid', opacity: 1}
		
		#define relations and functions for moving and positioning
		#move the boxes
		boxList[i].drag move_drag, move_start, move_up
		boxList[i].resizer = boxListDrag[i]
		boxList[i].boxtext = boxListText[i]
		
		#resize the boxes
		boxListDrag[i].drag resize_drag, resize_start, resize_up
		boxListDrag[i].resizer = boxList[i]
		boxListDrag[i].boxtext = boxListText[i]
