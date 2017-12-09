###
eslint-disable 
###

# SVG

import React, { Component } from 'react'
print = console.log

class Circle extends Component
	constructor : (props) ->
		super props
		@state = fill: "yellow", x:@props.x, y:@props.y, vx:1, vy:1,r:@props.r
		setInterval (() => @move()), 50
	move : ->
		{x,y,vx,vy,r} = @state
		if not (r<x<200-r) then vx=-vx
		if not (r<y<300-r) then vy=-vy
		x+=vx
		y+=vy
		@setState {x,y,vx,vy}
		
	render : ->
		<circle 
			cx={@state.x} 
			cy={@state.y} 
			r ={@state.r} 
			stroke={@props.stroke} 
			strokeWidth={@props.strokeWidth} 
			fill={@state.fill} 
			onMouseEnter={() => @setState fill : "red"} 
			onMouseLeave={() => @setState fill : "yellow"} 
		/>

export default class App extends Component 
	constructor : ->
		super()
		@state = {x:100, y:100}
	render : ->
		<div> 
			<svg width='200' height='300' onMouseMove={(e)=> @setState x:e.clientX, y:e.clientY}>
				<Circle x={@state.x} y={@state.y} r={40} stroke="rgb(0,0,0)" strokeWidth="1" fill="yellow"  />
			 </svg>			
		</div>
