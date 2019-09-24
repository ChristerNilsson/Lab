_ = require 'lodash'
stack = [{key:'x',children:[]}]
#stack = []

#createElement = (key, children) -> {key, children}

crap = (key='x',f= ->) ->
	stack.push {key, children:[]}
	f()
	children = stack.pop().children
	_.last(stack).children.push { key, children }
	_.last(stack).children

# crap = (key='x',f= ->) ->
# 	stack.push []
# 	f()
# 	children = stack.pop()
# 	_.last(stack).push children
# 	{key, children:_.last(stack)}

render = =>
	crap 'root', =>
		crap 'a', =>
			crap 'aa', =>
			crap 'ab',=>
		crap 'b', =>
			crap 'ba'
			crap 'bb'

console.log ''
console.log JSON.stringify render()



# console.log JSON.stringify createElement('a', createElement('b'), createElement('c'))


# import React from 'react'
# import ReactDOM from 'react-dom'
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
