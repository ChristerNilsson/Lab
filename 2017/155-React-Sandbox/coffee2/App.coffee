###
eslint-disable 
###

# NIM

import React, { Component } from 'react'
import _ from 'lodash'
import ReactDom from 'react-dom-factories' 
{div, header, img, h1, p, code, input, button} = ReactDom

export default class App extends Component 
	constructor : ->
		super()
		board = (Math.ceil 10*Math.random() for i in [0..2])
		@state = {board, player:0, enabled : [0,1,2], msg:''}

	handleClick : (i) ->
		board = @state.board
		if board[i]>0 
			board[i]--
			msg = if _.isEqual @state.board, [0,0,0] then "Player #{@state.player} wins!" else ''
			@setState {board, enabled:[i], msg}

	handleSwap : ->
		enabled = (i for i in [0..2] when @state.board[i]>0)
		@setState {player : 1 - @state.player, enabled}
	
	render : ->
		div {},
			button disabled: 0 not in @state.enabled,  onClick: (() => @handleClick 0), @state.board[0]
			button disabled: 1 not in @state.enabled,  onClick: (() => @handleClick 1), @state.board[1]
			button disabled: 2 not in @state.enabled,  onClick: (() => @handleClick 2), @state.board[2]
			button disabled: @state.enabled.length!=1, onClick: (() => @handleSwap()), "swap"
			p {}, "Player: #{@state.player}"
			p {}, @state.msg

		# <div>
		# 	<button disabled={0 not in @state.enabled}  onClick={() => @handleClick 0}>{@state.board[0]}</button>
		# 	<button disabled={1 not in @state.enabled}  onClick={() => @handleClick 1}>{@state.board[1]}</button>
		# 	<button disabled={2 not in @state.enabled}  onClick={() => @handleClick 2}>{@state.board[2]}</button>
		# 	<button disabled={@state.enabled.length!=1} onClick={() => @handleSwap()}>swap</button>
		# 	<p>Player: {@state.player}</p>
		# 	<p>{@state.msg}</p>
		# </div>