###
eslint-disable 
###

import React, { Component } from 'react'
import QrReader from 'react-qr-reader'
import _ from 'lodash'
import P5Wrapper from 'react-p5-wrapper'

print = console.log 

millis = -> Date.now()
button = null
released = true 
myState = 
	delay: 500
	result: 'scan' # INIT 1
	A    : ""
	B    : ""
	C    : ""
	D    : ""
	INIT : 'init'
	from : 0
	to   : 0
	hist : []   
	level : 0
	bg   : '#808080' 
	total : 0

handleError = (err)-> console.error err
handleScan = (result) -> 
	if not result then return  
	goal = myState.from == myState.to
	if goal and result.indexOf('INIT') != 0 then return 
	myState.result = result
	myState.bg = '#FFFF00'
	button.title = result.split(' ')[0]

handleExecute = ->
	myState.result = myState.result.replace "  "," "
	arr = myState.result.split ' '
	op = arr[0]
	command = myState[op]
	newFrom == 0
	if command =='+2' then newFrom = save myState.from+2
	if command =='*2' then newFrom = save myState.from*2
	if command =='/2' and myState.from % 2 == 0 then newFrom = save myState.from/2 
	if command =='undo' and myState.hist.length > 0 then myState.from = myState.hist.pop()
	if command =='init' 
		commands = '+2 *2 /2 undo'.split ' '
		commands = _.shuffle commands
		level = parseInt arr[1]
		[from,to] = createProblem level
		myState =
			A : commands[0] 
			B : commands[1] 
			C : commands[2] 
			D : commands[3] 
			INIT : 'init'
			from : from
			to : to
			hist : []
			start : millis()
			operations : 0
			total : 0
			result : 'scan'
			sida : 0
			level : level
	button.title = 'scan'
	myState.bg = if newFrom == myState.to then '#00FF00' else '#FFFFFF'

save = (value) ->
	myState.hist.push myState.from
	myState.from = value
	myState.operations++
	myState.total = ((millis()-myState.start)/1000 + 10 * myState.operations).toFixed(3)
	value

createProblem = (level) ->
	n = Math.floor Math.pow 2, 4+level/3 # nodes
	a = Math.floor _.random 1,n/2
	lst = [a]
	tree = [a]
	lst2 = []
	save1 = (item) ->
		if Math.floor(item) == item and item <= n
			if item not in tree
				lst2.push item
				tree.push item
	for j in _.range level
		lst2 = []
		for item in lst
			save1 item+2 
			save1 item*2
			if item%2==0 then save1 item/2
		lst = lst2
	b = _.sample lst 
	[a,b]

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
		button = new Button p,0.5*p.width,0.2*p.height,0.3*p.height,"scan", handleExecute

	p.draw = ->
		s = myState
		p.background s.bg
		op = s.result.split(' ')[0]
		if op != 'scan'
			button.title = s[op]

		p.rectMode p.CENTER
		p.textSize 0.1*p.height
		button.draw p
		p.fill 0
		for i in [0..3]
			littera = 'A B C D'.split(' ')[i]
			x = p.lerp 0.2*p.width,0.4*p.width,i
			p.text littera,x,0.45*p.height
			p.text s[littera],x,0.6*p.height

		p.textSize 0.25*p.height 
		p.text s.from,0.2*p.width,0.2*p.height
		p.text s.to,  0.8*p.width,0.2*p.height

		p.textSize 0.08*p.height
		p.textAlign p.RIGHT,p.CENTER
		p.text s.hist.join(' '),0.95*p.width,0.75*p.height

		p.textAlign p.CENTER,p.CENTER
		p.text s.level-s.hist.length,0.2*p.width,0.9*p.height
		p.text s.total,0.8*p.width,0.9*p.height

	p.mouseReleased = -> # to make Android work 
		released = true 
		false

	p.mousePressed = ->
		if !released then return # to make Android work 
		released = false
		button.mousePressed p.mouseX,p.mouseY
		false 