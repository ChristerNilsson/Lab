###
eslint-disable import/first
###

# ChessBoard

# Tyvärr ritas alla checkboxar om. Det var inte meningen.
# shouldComponentUpdate förhindrar det.
# Dock, denna onödiga uppdatering gäller bara Virtual DOM.
# Så, troligen onödig optimering att bry sig.

import React, { Component } from 'react'
print = console.log
N = 8

class CheckBox extends Component 
	shouldComponentUpdate : (nextProps, nextState) -> @props.value != nextProps.value
	render : ->	<input type = "checkbox" readOnly checked = {@props.value} />

export default class App extends Component 
	constructor : ->
		super()
		@state = i:0

	next : -> @setState {i : (@state.i+1) % N}

	render : ->
		<div> 
			{[0...N].map (i) => <CheckBox key={i} value={i==@state.i}/>}
			<button onClick = {() => @next()}>move</button>
		</div>
