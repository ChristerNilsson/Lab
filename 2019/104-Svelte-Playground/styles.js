const getStyler = (obj = {}) => {

	const classes = {
		'fs' : 'font-size $1',
		'br':  'border-radius $1',
		'clear' : 'clear $1',
		'align' : 'text-align $1',
		'float' : 'float $1',
		'bg' : 'background-color $1 calcColor',
		'tc' : 'color $1 calcColor',
	}

	const colors = {
		'red': '#f44336',
		'pink': '#e91e63',
		'purple': '#9c27b0',
		'deep-purple': '#673ab7',
		'indigo': '#3f51b5',
		'blue': '#2196f3',
		'light-blue': '#03a9f4',
		'cyan': '#00bcd4',
		'teal': '#009688',
		'green': '#4caf50',
		'light-green': '#8bc34a',
		'lime': '#cddc39',
		'yellow': '#ffeb3b',
		'amber': '#ffc107',
		'orange': '#ff9800',
		'deep-orange': '#ff5722',
		'brown': '#795548',
		'grey': '#9e9e9e',
		'blue-grey': '#607d8b',
		'black': '#000000',
		'white': '#ffffff',
	}
	
	const calcS = (stack) => {
		const a = stack.pop()
		const b = stack.pop()
		const c = stack.pop()
		return c+`:${(100-2*b*12/a)*(a/12)}%`
	}

	const calcColor = (stack) => {
		const a = stack.pop()
		const b = stack.pop()
		return b + ":" + colors[a]
	}

	Object.assign(classes,obj)
	return (line) => {
		const arr = line.split(' ')
		if (arr.length==0) return

		const result = []
		for (const word of arr) {
			const stack = []
			const params = word.split(':')
			const verb = params[0]

			if (! verb in classes) {
				console.log("ERROR: missing " + verb)
				return
			}

			const commands = classes[verb]
			for (const command of commands.split(' ')) {
				for (const cmd of command.split(':')) {

					if (cmd == 'calcS') { 
						result.push(calcS(stack))
					} else if (cmd == 'calcColor') { 
						result.push(calcColor(stack))
					} else if (cmd == '$1') {
						stack.push(params[1])
					} else if (cmd == '$2') {
						stack.push(params[2])
					} else {
						stack.push(cmd)
					}
				}
			}

			if (stack.length==1) {
				result.push(stack.pop())
			} else if (stack.length==2) {
				const a = stack.pop()
				const b = stack.pop()
				result.push(b + ':' + a)
			}
		}
		
		return result.join('; ')
	}
}

module.exports = {getStyler}
