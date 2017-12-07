###
eslint-disable 
###

import React, { Component } from 'react'
import P5Wrapper from 'react-p5-wrapper'
import sketch from './sketch'

export default class App extends Component 

	render : -> <P5Wrapper sketch={sketch} />
