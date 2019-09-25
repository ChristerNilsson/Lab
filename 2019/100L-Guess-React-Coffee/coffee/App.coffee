import React from 'react'
import ReactDOM from 'react-dom'
import Game from './game.js'
import _ from 'lodash'

stack = [{element : null, children:[]}]
crap = (type='x',props,arr,f= ->) ->
	stack.push {element: React.createElement(type, props, ...arr), children:[]}
	f()
	children = stack.pop().children
	_.last(stack).children.push {element:React.createElement(type, props, ...arr, ...children)} 
	_.last(stack).children

# p     = (props,arr,f= =>) => crap 'p',props,arr,f
div   = (props={},arr=[],f= =>) => crap 'div',props,arr,f
input = (props={},arr=[],f= =>) => crap 'input',props,arr,f

class App extends React.Component 
	constructor : (props) ->
		super(props)
		this.state = {game: new Game(2)}
		this.handleKeyUp = this.handleKeyUp.bind(this)
	
	render : () ->
		div {},[4712],->
			#div {}, [this.state.game.low,'-',this.state.game.high]
			#input {onKeyUp:this.handleKeyUp},[]

	handleKeyUp : (evt) ->
		if (evt.key != 'Enter') then return
		if (evt.target.value == '') then this.state.game.init(2)
		else this.state.game.action(evt.target.value)
		evt.target.value = ''
		this.setState((state) => ({game: state.game}))
	
ReactDOM.render(<App/>, document.getElementById("root"))

export default App




# import React from 'react'
# import ReactDOM from 'react-dom'
#React = require 'react'
#ReactDOM = require 'react-dom'

#stack = []

#createElement = (type, props, ...children) -> {type, props, children}

# stack = [{element : null, children:[]}]
# crap = (type='x',props,arr,f= ->) ->
# 	stack.push {element: React.createElement(type, props, ...arr), children:[]}
# 	f()
# 	children = stack.pop().children
# 	_.last(stack).children.push {element:React.createElement(type, props, ...arr, ...children)} 
# 	_.last(stack).children

# p     = (props,arr,f= =>) => crap 'p',props,arr,f
# div   = (props,arr,f= =>) => crap 'div',props,arr,f
# input = (props,arr,f= =>) => crap 'input',props,arr,f

# render = =>
# 	div {}, [], =>
# 		div {}, [1,'-',3]
# 		input {onKeyUp : 'handleKeyUp'}, []

# console.log ''
# console.log JSON.stringify render()


# console.log JSON.stringify createElement('a', createElement('b'), createElement('c'))


# import Game from './game.js'

# createAndAppend = (type, parent, attributes = {}) =>
# 	elem = document.createElement type
# 	parent.appendChild elem
# 	elem[key] = value for key,value of attributes
# 	elem

# stack = []

# crap = (attributes, f, type) =>
# 	if typeof type == 'object' then stack.push type
# 	else stack.push createAndAppend type, _.last(stack), attributes
# 	f()
# 	stack.pop()

# class App extends React.Component 
# 	constructor : (props={}) ->
# 		super props
# 		this.state = {game: new Game 2 }
# 		console.log this.state
# 		this.handleKeyUp = this.handleKeyUp.bind this

# 	render : =>
# 		x = div {}, [], =>
# 			div {}, [1,'-',3], =>
# 			input {onKeyUp : this.handleKeyUp}, [], =>
# 		console.log x
# 		x

# 	handleKeyUp : (evt) =>
# 		if evt.key != 'Enter' then return
# 		if evt.target.value == '' then this.state.game.init 2
# 		else this.state.game.action evt.target.value
# 		evt.target.value = ''
# 		this.setState((state) => {game: state.game})

# ReactDOM.render(<App />, document.getElementById("root"))

# export default App
