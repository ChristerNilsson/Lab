import {writable} from 'svelte/store'

const ADD = 'ADD'
const MUL = 'MUL'
const DIV = 'DIV'
const NEW = 'NEW'
const UNDO = 'UNDO'

const store = writable({a:17, b:1, hist:[]})

const random = (a,b) => a+Math.floor((b-a+1)*Math.random())

// const op = (action) => {
// 	resetState()
// 	if (action == ADD) {
// 		hist.push(a)
// 		hist=hist
// 		a += 2
// 	} else if (action == MUL) {
// 		hist.push(a)
// 		hist=hist
// 		a *= 2
// 	} else if (action == DIV) {
// 		hist.push(a)
// 		hist=hist
// 		a /= 2
// 	} else if (action == NEW) {
// 		a = random(1,20)
// 		b = random(1,20)
// 		hist = []
// 	} else if (action == UNDO) {
// 		a = hist.pop()
// 		hist = hist 
// 	} else {
// 		console.log('Missing action: ' + action)
// 	}
// 	saveState(action)
// }

const operation = (st,action) => {
	//resetState()
	let a = st.a
	let b = st.b
	let hist = st.hist

	if (action == ADD) {
		hist.push(a)
		hist=hist
		a += 2
	} else if (action == MUL) {
		hist.push(a)
		hist=hist
		a *= 2
	} else if (action == DIV) {
		hist.push(a)
		hist=hist
		a /= 2
	} else if (action == NEW) {
		a = random(1,20)
		b = random(1,20)
		hist = []
	} else if (action == UNDO) {
		a = hist.pop()
		hist = hist 
	} else {
		console.log('Missing action: ' + action)
	}
	return {a:a, b:b, hist:hist}
	//saveState(action)
}

export default {
	subscribe : store.subscribe,
	op: (action) => store.update( st => operation(st,action) )
}