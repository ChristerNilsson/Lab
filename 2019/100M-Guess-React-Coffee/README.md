# Combining React with coffeescipt

This is the correct way. Forget about 100L

## Quirks

App.coffee: 

* Use require instead of import

Do this for App.js:

* Move App.js from js to src

There are several ways of coding the attributes and visibles:
```
	render : =>
		div style: {fontSize: 100+'px'} ,
			div {}, @state.game.low, '-', @state.game.high
			div {}, "#{@state.game.low}-#{@state.game.high}"
			input 
				style: 
					fontSize: 100+'px'
				onKeyUp: @handleKeyUp
```

