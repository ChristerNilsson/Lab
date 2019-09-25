import React from 'react'
import ReactDOM from 'react-dom'
import Game from './game.js'
import _ from 'lodash'

#################################

stack = [[]]
crap = (type,props={},arr=[],f= =>) ->
	stack.push []
	f()
	children = stack.pop()
	_.last(stack).push React.createElement(type, props, ...arr, ...children)
	_.last(stack)

div   = (props,arr,f) => crap 'div',props,arr,f
input = (props,arr,f) => crap 'input',props,arr,f

#################################

class App extends React.Component 
	constructor : (props) ->
		super(props)
		@state = {game: new Game(2)}

	render : () =>
		stack = [[]]
		div {},[],=>
			div {}, [@state.game.low,'-',@state.game.high]
			input {onKeyUp: @handleKeyUp}

	handleKeyUp : (evt) =>
		if (evt.key != 'Enter') then return
		if (evt.target.value == '') then @state.game.init(2)
		else @state.game.action(evt.target.value)
		evt.target.value = ''
		@setState((state) => ({game: state.game}))
	
ReactDOM.render(<App/>, document.getElementById("root"))

export default App
