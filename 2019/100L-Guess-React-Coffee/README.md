# Combining React with coffeescipt

It is possible, but some manual labour has to be done after transpilation.

## Quirks

Do this for App.js

* Move these lines to after all imports:
```
var App, crap, div, input, stack,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };
```
* Remove the source map at the end

* Move App.js from js to src

* Stack has to be cleared in the render function.

* I have not tried to create my own Components.

* Ignore this Warning:
```
Warning: Each child in a list should have a unique "key" prop.
```

## Example code
```
	render : () =>
		stack = [[]]
		div {},[],=>
			div {}, [@state.game.low,'-',@state.game.high]
			input {onKeyUp: @handleKeyUp}
```
* The object contains properties and attributes
* The array contains values that should be visible, like text
* The fat arrow is used like the colon in Python to indicate indentation.
* This code will call React.createElement three times
