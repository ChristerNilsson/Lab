const assert = chai.assert.deepEqual

const testReducer = (reducers, stack) => {
	let states = []
	let errors = []
	const run = (script) => {
		const arr = script.split('\n')
		errors = []
		for (let nr=0; nr < arr.length; nr++) { 
			let line = arr[nr]
			const pos = line.lastIndexOf('#')
			if (pos >= 0) line = line.slice(0,pos)
			try {
				if (line.trim().length != 0) runTest(line, nr)
			} catch (err) {
				errors.push(err)
				break
			}
		}
		return errors
	}

	const runTest = (line, nr) => {
		const index = countTabs(line)
		line = line.trim()
		if (index === 0) return states = [JSON.parse(line)]
		stack.length = 0
		let state = states[index - 1]
		for (const cmd of line.split(' ')) {
			state = rpn(cmd, state, nr)
		}
		states[index] = state
		while (stack.length >= 2) {
			rpn('==', state, nr)
		}
		if (stack.length === 1) {
			errors.push(`Orphan in line ${nr + 1}`)
			return 
		}
	}

	const rpn = (cmd, state, nr) => {
		if (cmd === '@') {
			stack.push(state)
			return state
		}
		const key = cmd.slice(1)
		if (Object.keys(state).includes(key)) {
			stack.push(state[key])
			return state
		}
		if (Object.keys(reducers).includes(cmd)) {
			return state = reducers[cmd](state)
		}
		if (cmd === '==') {
			let x
			let y
			try {
				x = stack.pop()
				y = stack.pop()
				assert(x, y)
			} catch (error) {
				errors.push('Assert failure in line ' + (nr + 1))
				errors.push('  Actual ' + JSON.stringify(y))
				errors.push('  Expect ' + JSON.stringify(x))
			}
			return state
		}
		try {
			if (cmd == '') return state
			stack.push(JSON.parse(cmd))
		} catch (error) {
			errors.push('JSON.parse failure in line ' + (nr + 1)+ ' '+ cmd)
			errors.push('	' + cmd)
		}
		return state
	}

	const countTabs = (line) => {
		let result = 0
		for (let i=0; i < line.length; i++) {
			const ch = line[i]
			if (ch !== '\t') return result
			result++
		}
		return result
	}
	return {run}
}

export default testReducer