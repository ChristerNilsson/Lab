React = require 'react'
ReactDOM = require 'react-dom'
{div,input} = require 'react-dom-factories'
Game = require './game.js'

class App extends React.Component 
	constructor : (props) ->
		super props
		@state =
			game: new Game 2

	render : =>
		div style: {fontSize: 100+'px'} ,
			div {}, @state.game.low, '-', @state.game.high
			div {}, "#{@state.game.low}-#{@state.game.high}"
			input 
				style: 
					fontSize: 100+'px'
				onKeyUp: @handleKeyUp

	handleKeyUp : (evt) =>
		if evt.key != 'Enter' then return
		if evt.target.value == '' then @state.game.init 2
		else @state.game.action evt.target.value
		evt.target.value = ''
		@setState((state) => ({game: state.game}))
	
ReactDOM.render(<App/>, document.getElementById("root"))

export default App
