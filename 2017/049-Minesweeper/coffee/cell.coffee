class Cell
	constructor : (@i, @j, @w) ->
		@x = @i * @w + @w/2
		@y = @j * @w + @w/2
		@neighborCount = 0
		@bee = false
		@revealed = false

	show : ->
		sc 0
		fc()
		rect @x, @y, @w, @w
		if @revealed
			if @bee
				fc 0.5
				circle @x, @y , @w * 0.25
			else
				fc 0.75
				rect @x, @y, @w, @w
				if @neighborCount > 0
					fc 0
					#fill cc @neighborCount
					text @neighborCount, @x, @y

	countBees : ->
		if @bee
			@neighborCount = -1
			return

		total = 0
		for xoff in range -1,2
			for yoff in range -1,2
				i = @i + xoff
				j = @j + yoff
				if -1 < i < cols and -1 < j < rows
					neighbor = grid[i][j]
					if neighbor.bee then total++
		@neighborCount = total

	contains : (x, y) -> @x < x < @x + @w and @y < y < @y + @w

	reveal : ->
		@revealed = true
		if @neighborCount == 0 then	@floodFill()

	floodFill : () ->
		for xoff in range -1,2
			for yoff in range -1,2
				i = @i + xoff
				j = @j + yoff
				if -1 < i < cols and -1 < j < rows
					neighbor = grid[i][j]
					if not (neighbor.bee or neighbor.revealed) then neighbor.reveal()