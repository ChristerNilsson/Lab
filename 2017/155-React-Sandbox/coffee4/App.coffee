###
eslint-disable 
###

# CheckBox Matrix

# Tyvärr ritas alla checkboxar om. Det var inte meningen.

import React, { Component } from 'react'
import _ from 'lodash'

M = 30 # 90
N = 30 # 44

assert = console.assert
print = console.log
range = _.range

dist = (dx,dy) -> dx*dx+dy*dy
xor = (a,b) -> (a ^ b) == 1
assert false == xor false,false
assert true  == xor false,true
assert true  == xor true,false
assert false == xor true,true

matrix = (m, n) -> Array.from {length: m}, () => new Array(n).fill 0

class CheckBox extends Component 
	render : -> <input type = "checkbox" checked = {@props.value} />

export default class App extends Component 
	constructor : ->
		super()
		mat = matrix M,N
		for i in range M 
			for j in range N 
				mat[i][j] = false
		@state = 
			mat : mat
			x : M/2
			y : N/2
			vx : 1
			vy : 2
			r : 6

	next : ->
		x = @state.x
		y = @state.y
		r = @state.r
		vx = @state.vx
		vy = @state.vy
		if not (r <= x <= M-r) then vx=-vx 
		if not (r <= y <= N-r) then vy=-vy
		x += vx
		y += vy
		mat = @state.mat
		for i in range M 
			for j in range N 
				mat[i][j] = dist(x-i,y-j) < r*r 
		@setState {mat,x,y,vx,vy}

	render : ->
		<div> {
			for j in range N 
				<div> {
				for i in range N 
					<CheckBox value={@state.mat[i][j]}/>
				}
				</div>
			}
			<button onClick = {() => @next()}>click</button>
		</div>
