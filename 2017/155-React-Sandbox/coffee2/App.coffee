###
eslint-disable 
###

# NIM

import React, { Component } from 'react'
import _ from 'lodash' 

class TakeButton extends Component 
	render : ->
		father = @props.father
		index = parseInt @props.index
		<button disabled={index not in father.state.enabled} onClick={() => father.handleClick index}>{father.state.board[index]}</button>

export default class App extends Component 
	constructor : ->
		super()
		board = (Math.ceil 10*Math.random() for i in [0..2])
		@state = {board, player:0, enabled : [0,1,2], msg:''}

	handleClick : (i) ->
		board = @state.board
		if board[i] > 0 
			board[i]--
			msg = if _.isEqual board, [0,0,0] then "Player #{@state.player} wins!" else ''
			@setState {board, enabled:[i], msg}
 
	handleSwap : ->
		enabled = (i for i in [0..2] when @state.board[i]>0)
		@setState {player : 1 - @state.player, enabled}
	
	render : ->
		<div>
			<TakeButton index='0' father={@}></TakeButton>		
			<TakeButton index='1' father={@}></TakeButton>		
			<TakeButton index='2' father={@}></TakeButton>		
			<button disabled={@state.enabled.length!=1} onClick={() => @handleSwap()}>swap</button>
			<p>Player: {@state.player}</p>
			<p>{@state.msg}</p>
		</div>