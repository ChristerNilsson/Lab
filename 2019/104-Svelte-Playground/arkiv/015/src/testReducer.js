const assert = chai.assert.deepEqual

const testReducer = function(reducers, stack) {
	var countTabs, rpn, run, runTest, states;
	var errors = []
	states = [];
	run = function(script) {
		var i, len, line, nr, ref
		ref = script.split('\n')
		errors = []
		for (nr = i = 0, len = ref.length; i < len; nr = ++i) {
			line = ref[nr];
			console.log(line)
			var pos = line.lastIndexOf('#')
			if (pos>=0) line = line.slice(0,pos)
			console.log(line)
			try {
				if (line.trim().length!=0) runTest(line, nr);
			} catch (err) {
				errors.push(err)
			}
		}
		console.log(errors)
		return errors
	}
	runTest = function(line, nr) {
		var arr, cmd, i, index, len, state;
		index = countTabs(line);
		line = line.trim();
		console.log('.',line,'.')
		if (index === 0) {
			return states = [JSON.parse(line)];
		}
		stack.length = 0;
		arr = line.split(' ');
		state = states[index - 1];
		for (i = 0, len = arr.length; i < len; i++) {
			cmd = arr[i];
			state = rpn(cmd, state, nr);
		}
		states[index] = state;
		while (stack.length >= 2) {
			rpn('==', state, nr);
		}
		if (stack.length === 1) {
			errors.push(`Orphan in line ${nr + 1}`);
			return 
		}
	};
	rpn = function(cmd, state, nr) {
		var x, y;
		if (cmd === '@') {
			stack.push(state);
			return state;
		}
		const key = cmd.slice(1)
		if (Object.keys(state).includes(key)) {
			stack.push(state[key]);
			return state;
		}
		if (Object.keys(reducers).includes(cmd)) {
			return state = reducers[cmd](state);
		}
		if (cmd === '==') {
			try {
				x = stack.pop();
				y = stack.pop();
				assert(x, y);
			} catch (error) {
				errors.push('Assert failure in line ' + (nr + 1));
				errors.push('  Actual ' + JSON.stringify(y));
				errors.push('  Expect ' + JSON.stringify(x));
			}
			return state;
		}
		try {
			if (cmd=='') return state
			stack.push(JSON.parse(cmd));
		} catch (error) {
			errors.push('JSON.parse failure in line ' + (nr + 1)+ ' '+ cmd);
			errors.push('	' + cmd);
		}
		return state;
	};
	countTabs = function(line) {
		var ch, i, len, result;
		result = 0;
		for (i = 0, len = line.length; i < len; i++) {
			ch = line[i];
			if (ch !== '\t') {
				return result;
			}
			result++;
		}
		return result;
	};
	return {run};
};

export default testReducer