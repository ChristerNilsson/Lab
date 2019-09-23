import React from 'react'
import ReactDOM from 'react-dom'
import Game from './game.js'
 
class App extends React.Component {
	constructor(props) {
		super(props)
		this.state = {game: new Game(2)}
		this.handleKeyUp = this.handleKeyUp.bind(this)
	}
  render() {
		return <div>
			<div>{this.state.game.low}-{this.state.game.high}</div>
			<input onKeyUp={this.handleKeyUp}></input>
		</div>
	}

	handleKeyUp(evt) {
		if (evt.key === 'Enter') {
			if (evt.target.value === '') {
				this.state.game.init(2)
			} else {
				this.state.game.action(evt.target.value)
			}
			evt.target.value = ''
			this.setState(state => ({game: state.game}))
		}
	}
}

ReactDOM.render(<App />, document.getElementById("root"))

export default App
