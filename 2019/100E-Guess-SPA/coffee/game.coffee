class Game  
	constructor : (level) -> @init level

	init : (@level) =>
		if @level < 2 then @level = 2
		@low = 1
		@high = 2**@level - 1
		@secret = _.random @low, @high
		@hist = []
	
	action : (value) =>
		value = parseInt value
		@hist.push value
		if value < @secret and value >= @low then @low = value + 1
		if value > @secret and value <= @high then @high = value - 1
		if value == @secret 
			@init @level + if @hist.length <= @level then 1 else -1
