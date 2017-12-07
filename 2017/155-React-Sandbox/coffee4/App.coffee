###
eslint-disable 
###

# CheckBox Matrix

import React, { Component } from 'react'

N = 40

class CheckBox extends Component 
	constructor : (props) ->
		super props
		@state = {father:props.father, value:props.value}

	render : -> 
		<input type="checkbox" checked={(@state.value + @state.father.state.value) % 2 == 0} onChange={() => @setState {value: 1 - @state.value}} />

export default class App extends Component 
	constructor : ->
		super()
		@state = value : 1

	render : ->
		<div> {
			for i in [0..N]
				<div> {
				for j in [0..N]
					<CheckBox value={(i+j)%2} father={@}/>
				}
				</div>
			}
			<button onClick = {() => @setState {value: 1 - @state.value}} >click</button>
		</div>
