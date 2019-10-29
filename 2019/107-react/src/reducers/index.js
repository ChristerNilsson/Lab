export default (state = {xa:17, xb:1, xhist:[]}, action) => {
	let {xa,xb,xhist} = state
	const op = (value) => {	
		xhist = [...xhist,xa]
		xa = value
	}
	if (action.type === 'ADD') op(xa + 2)
	if (action.type === 'MUL') op(xa * 2)
	if (action.type === 'DIV') op(xa / 2)
	if (action.type === 'NEW') {
		const random = (a,b) => a+Math.floor((b-a+1)*Math.random())
		xa = random(1,20)
		xb = random(1,20)
		xhist = []
	}
	if (action.type === 'UNDO') xa = xhist.pop()
	return {xa,xb,xhist}
}
