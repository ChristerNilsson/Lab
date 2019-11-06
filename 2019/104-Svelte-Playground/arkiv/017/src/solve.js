const solve = (a,b) => {
	let cands0 = [a]
	let counter = 0
	while (true) {
		if (cands0.includes(b)) return counter
		const cands1 = []
		const op = (value) => {
			if (value <= 40 && !cands1.includes(value)) cands1.push(value)
		}
		for (const cand of cands0) {
			op(cand+2)
			op(cand*2)
			if (cand%2 == 0) op(cand/2)
		}
		counter += 1
		cands0 = cands1
	}
}

module.exports = {solve}