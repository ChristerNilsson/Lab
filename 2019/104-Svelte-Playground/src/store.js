import {writable} from 'svelte/store'

// import {createEventDispatcher} from 'svelte'
// const dispatch = createEventDispatcher()

// const ADD = 'ADD'
// const MUL = 'MUL'
// const DIV = 'DIV'
// const NEW = 'NEW'
// const UNDO = 'UNDO'
// const USE_TIME_MACHINE = true

// let states

const store = writable({a:17,b:1,hist:[]})
// console.log(store)

// let operation = () => {}
// const register = (oper) => {
// 	operation = oper
// }

export default {  
	subscribe : store.subscribe,
	// register : register,
	update : store.update,
	set: store.set,
	// states : states
}