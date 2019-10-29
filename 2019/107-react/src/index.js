import React from 'react'
import ReactDOM from 'react-dom'
import { createStore } from 'redux'
import Shortcut from './components/Shortcut'
import shortcut from './reducers'

const store = createStore(shortcut,
	window.__REDUX_DEVTOOLS_EXTENSION__ && 
	window.__REDUX_DEVTOOLS_EXTENSION__()
)

const root = document.getElementById('root')

const render = () => ReactDOM.render(
	<Shortcut
		xa = {store.getState().xa}
		xb = {store.getState().xb}
		xhist = {store.getState().xhist}
		xadd = {() => store.dispatch({ type: 'ADD' })}
		xmul = {() => store.dispatch({ type: 'MUL' })}
		xdiv = {() => store.dispatch({ type: 'DIV' })}
		xnew = {() => store.dispatch({ type: 'NEW' })}
		xundo ={() => store.dispatch({ type: 'UNDO' })}
	/>,
	root
)

render()
store.subscribe(render)
