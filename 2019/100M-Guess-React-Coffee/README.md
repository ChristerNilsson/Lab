# Combining React with coffeescipt

This is the correct way to do it!

## Quirks

App.coffee: 

* Use require instead of import

Do this for App.js:

* Move App.js from js to src. This step can be eliminated.

There are several ways of coding the attributes and visibles:

## Coffeescript
```
	render : =>
		div style: {fontSize: 100+'px'} ,
			div {}, @state.game.low, '-', @state.game.high
			input style: {fontSize: 100+'px'}, onKeyUp: @handleKeyUp
```

## JSX
```
	render : =>
		<div style={fontSize:100+'px'}> 
			<div>{@state.game.low}-{@state.game.high}</div>
			<input style={fontSize:100+'px'} onKeyUp={@handleKeyUp}></input>
		</div>
```
