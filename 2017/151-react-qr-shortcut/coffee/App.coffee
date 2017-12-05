###
eslint-disable 
###

import React, { Component } from 'react'
import QrReader from 'react-qr-reader'
import _ from 'lodash'

millis = ->
	d = new Date()
	d.getTime()

export default class App extends Component 
	constructor : (props) ->
		super props
		@state = 
			delay: 500
			result: 'scan' # INIT 4 8
			A : ""
			B : ""
			C : ""
			D : ""
			INIT : "init"
			from : 0
			to : 0
			hist : []   
			bg : '#FFFFFF' 
		@handleScan = @handleScan.bind @
		@handleExecute = @handleExecute.bind @
	
	handleScan : (result) -> if result then @setState { result, bg : '#FFFF00' } 
	handleError : (err)-> console.error err
	handleExecute : ->
		arr = @state.result.split ' '
		op = arr[0]
		command = @state[op]
		newFrom == 0
		if command =='+2' then newFrom = @save @state.from+2
		if command =='*2' then newFrom = @save @state.from*2
		if command =='/2' and @state.from % 2 == 0 then newFrom = @save @state.from/2 
		if command =='undo'
			n = @state.hist.length
			if n > 0
				@setState 
					from : @state.hist[n-1]
					hist : @state.hist[0..-2]
		if command =='init' 
			commands = '+2 *2 /2 undo'.split ' '
			commands = _.shuffle commands
			@setState
				A : commands[0] 
				B : commands[1] 
				C : commands[2] 
				D : commands[3] 
				from : parseInt arr[1]
				to : parseInt arr[2]
				hist : []
				start : millis()
				operations : 0
				total : 0
				result : 'scan'
		@setState
			bg : if newFrom==@state.to then '#00FF00' else '#FFFFFF'

	save : (value) ->
		@setState 
			from : value
			hist : @state.hist.concat [@state.from]
			operations : @state.operations + 1
			total : (millis()-@state.start)/1000 + 10 * @state.operations
		value

	render : ->
		previewStyle = 
			height: 320
			width: 320

		<div style={{backgroundColor: @state.bg}}>
			<QrReader
				delay = {@state.delay}
				style = {previewStyle}
				onError = {@handleError}
				onScan = {@handleScan}
				/>
			<button onClick={@handleExecute}>{@state.result.split(' ')[0]}</button>
			<p>A: {@state.A} <br/> B: {@state.B} <br/> C: {@state.C} <br/> D: {@state.D}</p>
			<h1>{@state.from} to {@state.to}</h1>
			<p>{@state.hist.join ' '}</p>
			<p>{@state.total}</p>
		</div>
