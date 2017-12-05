###
eslint-disable 
###

# Kan visa krona/klave, tärning osv.
# Prova även print10. dvs \/

import React, {Component } from 'react'
import ReactDom from 'react-dom-factories' 
{div, header, img, h1, p, code, input, button} = ReactDom


export default class App extends Component 
	constructor : ->
		super()
		@state = {txt: '123456', result: ''}

	handleClick : ->
		s = @state.txt
		n = s.length
		result = (s[Math.floor(n*Math.random())] for i in [0..49]).join ''
		@setState {result : @state.result + result + "\n"}

	handleChange : (e) -> @setState {txt : e.target.value, result:''}

	render : ->
		div {},
			input onChange : @handleChange.bind(@), value:@state.txt
			button onClick : @handleClick.bind(@), "choose"
			p style : {fontFamily: 'courier'}, @state.result
