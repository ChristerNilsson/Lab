class Cell
	constructor : (@i, @j, @w) ->
		@x = @i * @w + @w/2
		@y = @j * @w + @w/2
		@neighborCount = 0
		@bee = false
		@revealed = false
		@flag = false 

	show : ->
		if @flag 
			image images.flag, @x, @y, w,w		
		else if @revealed
			if @bee
				image images.bomb, @x, @y, w,w
			else
				if @neighborCount > 0 then image images[@neighborCount], @x, @y, w,w
				else image images.tile_depressed, @x, @y, w,w
		else
			image images.tile, @x, @y, w,w

	countBees : ->
		if @bee
			@neighborCount = -1
			return

		total = 0
		for xoff in [-1,0,1]
			for yoff in [-1,0,1]
				i = @i + xoff
				j = @j + yoff
				if -1 < i < cols and -1 < j < rows
					neighbor = grid[i][j]
					if neighbor.bee then total++
		@neighborCount = total

	contains : (x, y) -> @x < x < @x + @w and @y < y < @y + @w
	toggle : -> 
		@flag = not @flag
		if @flag then count++ else count--

	reveal : ->
		@revealed = true
		count++
		if @neighborCount == 0 then	@floodFill()

	floodFill : () ->
		for xoff in [-1,0,1]
			for yoff in [-1,0,1]
				i = @i + xoff
				j = @j + yoff
				if -1 < i < cols and -1 < j < rows
					neighbor = grid[i][j]
					if not (neighbor.bee or neighbor.revealed) then neighbor.reveal()