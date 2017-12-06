###
eslint-disable 
###

# NIM

import React, { Component } from 'react'

class TakeButton extends Component 
	render : ->
		father = @props.father
		index = parseInt @props.index
		value = father.state.board[index]
		<button disabled={value==0 or index not in father.state.enabled} onClick={() => father.handleClick index}>{father.state.board[index]}</button>

class SwapButton extends Component 
	render : ->
		father = @props.father
		<button disabled={father.state.enabled.length!=1} onClick={() => father.handleSwap()}>swap</button>

export default class App extends Component 
	constructor : ->
		super()
		@state = 
			board: Math.ceil 10*Math.random() for i in [0..2]
			player:0
			enabled : [0,1,2]
			msg:''

	handleClick : (i) ->
		board = @state.board
		if board[i] > 0 
			board[i]--
			@setState
				board: board 
				enabled: [i]
				msg: if board[0]+board[1]+board[2]==0 then "Player #{@state.player} wins!" else ''
 
	handleSwap : ->
		@setState 
			player : 1 - @state.player
			enabled : (i for i in [0..2] when @state.board[i]>0)
	
	render : ->
		<div>
			<TakeButton father={@} index='0'/>
			<TakeButton father={@} index='1'/>
			<TakeButton father={@} index='2'/>
			<SwapButton father={@}/>
			<p>Player: {@state.player}</p>
			<p>{@state.msg}</p>
		</div>