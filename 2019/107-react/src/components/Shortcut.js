import React, { Component } from 'react'
import PropTypes from 'prop-types' 

class Shortcut extends Component {
	render() {
		const { xa,xb,xhist, xadd,xmul,xdiv,xnew,xundo } = this.props
		const done = xa === xb
		return (
			<div>
				<div class='col2 t40 center red'>{xa}</div>
				<div class='col2 t40 center green'>{xb}</div>
				{' '}<button class='col3' onClick={xadd} disabled = {done}> +2 </button>
				{' '}<button class='col3' onClick={xmul} disabled = {done}> *2 </button>
				{' '}<button class='col3' onClick={xdiv} disabled = {done}> /2 </button>
				{' '}<button class='col2' onClick={xnew} disabled = {!done}> New </button>
				{' '}<button class='col2' onClick={xundo} disabled = {xhist.length === 0}> Undo </button>
			</div>
		)
	}
}

Shortcut.propTypes = {
	xa: PropTypes.number.isRequired,
	xb: PropTypes.number.isRequired,
	xhist: PropTypes.array.isRequired,
	xadd: PropTypes.func.isRequired,
	xmul: PropTypes.func.isRequired,
	xdiv: PropTypes.func.isRequired,
	xnew: PropTypes.func.isRequired,
	xundo: PropTypes.func.isRequired,
}

export default Shortcut
