import React, { Component } from  'react'
import logo from './logo.svg'
import './App.css'
import ReactDom from 'react-dom-factories' 

{div, header, img, h1, p, code} = ReactDom

# You must manually move "var App.." here

# These lines will make the empty props object ({}) unnecessary after "code" below:
# fix = (tag,...options) ->
# 	if typeof options[0] == 'object'
# 		props = options.shift() 
# 	else
# 		props = {}
# 	if options.length==0 
# 		React.createElement tag,props
# 	else
# 		React.createElement tag,props,options
# div    = -> fix 'div',...arguments
# header = -> fix 'header',...arguments
# img    = -> fix 'img',...arguments
# h1     = -> fix 'h1',...arguments
# p      = -> fix 'p',...arguments
# code   = -> fix 'code',...arguments

class App extends Component 
	render : ->
		struktur = div className:"App",
			header className:"App-header",
				img src:logo, className:"App-logo", alt:"logo" 
				h1 className:"App-title", "Christer, welcome to React!"      
			p className:"App-intro", 
				"To get started, edit " 
				code {}, "coffee/App.coffee"
				#code     "coffee/App.coffee"
				" and save to reload."
		console.log struktur
		struktur
export default App
