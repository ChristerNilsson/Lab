###
eslint-disable 
###

import React, { Component } from 'react'
import QrReader from 'react-qr-reader'
import _ from 'lodash'
import P5Wrapper from 'react-p5-wrapper'

millis = -> Date.now()
button = null
released = true 
myState = 
	delay: 500
	result: 'scan' # INIT 4 8
	A    : ""
	B    : ""
	C    : ""
	D    : ""
	INIT : 'init'
	from : 0
	to   : 0
	hist : []   
	bg   : '#808080' 
	total : 0

handleError = (err)-> console.error err
handleScan = (result) -> 
	if result 
		goal = myState.from == myState.to
		console.log goal, result.indexOf('INIT')
		if goal and result.indexOf('INIT') != 0 then return 
		myState.result = result
		myState.bg = '#FFFF00'
		button.title = result.split(' ')[0]

handleExecute = ->
	arr = myState.result.split ' '
	op = arr[0]
	command = myState[op]
	newFrom == 0
	if command =='+2' then newFrom = save myState.from+2
	if command =='*2' then newFrom = save myState.from*2
	if command =='/2' and myState.from % 2 == 0 then newFrom = save myState.from/2 
	if command =='undo' and myState.hist.length > 0 then myState.from = myState.hist.pop()
	if command =='init' 
		console.log myState.result
		commands = '+2 *2 /2 undo'.split ' '
		commands = _.shuffle commands
		myState =
			A : commands[0] 
			B : commands[1] 
			C : commands[2] 
			D : commands[3] 
			INIT : 'init'
			from : parseInt arr[1]
			to : parseInt arr[2]
			hist : []
			start : millis()
			operations : 0
			total : 0
			result : 'scan'
			sida : 0
	button.title = 'scan'
	myState.bg = if newFrom == myState.to then '#00FF00' else '#FFFFFF'

save = (value) ->
	myState.hist.push myState.from
	myState.from = value
	myState.operations++
	myState.total = ((millis()-myState.start)/1000 + 10 * myState.operations).toFixed(3)
	value

class Button 
	constructor : (@p,@x,@y,@r,@title,@f) ->
	draw : ->
		@p.fill 255
		@p.ellipse @x,@y,@r
		@p.fill 0
		@p.text @title,@x,@y
	mousePressed : (mx,my) -> if @p.dist(@x,@y,mx,my) < @r then @f()

export default class App extends Component 
	render : ->
		w = Math.max document.documentElement.clientWidth, window.innerWidth || 0
		h = Math.max document.documentElement.clientHeight, window.innerHeight || 0
		sida = if w<h then w/2 else h/2
		myState.previewStyle = 
			height: sida
			width: sida

		<div style = {{backgroundColor:'#808080'}}> 
			<table style = {width : w} > 
				<tbody style = {width : w}>
				<tr>
					<td style = {width : (w-sida)/2}></td>
					<td>
						<QrReader
							delay = {myState.delay}
							style = {myState.previewStyle}
							onError = {handleError}
							onScan = {handleScan}
						/>
					</td>
				</tr>
				</tbody>
			</table>
			<P5Wrapper sketch={sketch} />
		</div>

sketch = (p) ->

	p.setup = -> 
		p.createCanvas p.windowWidth-5, p.windowHeight/2-5
		p.textAlign p.CENTER,p.CENTER
		button = new Button p,0.5*p.width,0.2*p.height,0.35*p.height,"scan", handleExecute

	p.draw = ->
		p.background myState.bg
		button.title = myState.result.split(' ')[0]

		p.rectMode p.CENTER
		p.textSize 40
		button.draw p
		p.fill 0
		for i in [0..3]
			littera = 'A B C D'.split(' ')[i]
			x = p.lerp 0.2*p.width,0.4*p.width,i
			p.text littera,x,0.45*p.height
			p.text myState[littera],x,0.6*p.height
		p.text myState.from,0.4*p.width,0.75*p.height
		p.text myState.to,  0.6*p.width,0.75*p.height
		p.textSize 20
		p.text myState.hist.join(' '),p.width/2,0.85*p.height
		p.text myState.total,p.width/2,0.95*p.height

	p.mouseReleased = -> # to make Android work 
		released = true 
		false

	p.mousePressed = ->
		if !released then return # to make Android work 
		released = false
		button.mousePressed p.mouseX,p.mouseY
		false 