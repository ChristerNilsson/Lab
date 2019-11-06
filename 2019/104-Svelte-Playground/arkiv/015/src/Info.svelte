<style>
	pre {
		background-color:white
	}
</style>

<div style='position:absolute; left:1050px; top:10px; width:40%'>
	<h2>Reducer Based Testing</h2>
	<div>This is a compact format for testing <a href='https://redux.js.org/basics/reducers'>Reducers</a> and an alternative to:</div>
	<pre style="width:450px">
test('adds 1 + 2 to equal 3', () => {'{'}
  expect(sum(1, 2)).toBe(3);
{'}'});
	</pre>
	<div>Reducer: State + Action => State</div>
	<div>&nbsp;</div>
	<div>Each line contains zero or more actions</div>
	<div>Each line contains zero or more <a href='https://en.wikipedia.org/wiki/Assertion_(software_development)'>assertions</a></div>
	<div>&nbsp;</div>
	<div>Lines with no indentation contains initial states</div>
	<div>Indented lines are based on previous states</div>
	<div>Alternative actions have the same indentation</div>
	<div>&nbsp;</div>
	<div><a href='https://en.wikipedia.org/wiki/JSON'>JSON</a> is used to describe states</div>
	<div><a href='https://en.wikipedia.org/wiki/Reverse_Polish_notation'>RPN</a> is used for actions and getters</div>
	<div>&nbsp;</div>
	<div>Implicit assertion uses ==</div>
	<div>== deeply compares top two stack elements</div>
	<div>Implicit assertions repeats until the stack is empty</div>
	<div>Alternative assertions might be defined</div>
	<div>Actions may consume parameters</div>
	<div>&nbsp;</div>

	Actions:
	<ul>
 		<li>ADD : a = a + 2</li>
		<li>MUL : a = a * 2</li>
		<li>DIV : a = a / 2</li>
		<li>NEW</li>
		<li>UNDO</li>
	</ul>
	
	Getters: 
	<ul>
		<li>@ : The State</li>
		<li>@a : The number to be changed</li>
		<li>@b : Target number</li>
		<li>@hist : List for Undo</li>
	</ul>
	
	Known bugs:
	<ul>
		<li>Spaces are not allowed in expressions</li>
		<li>Tabs must be used for indentation</li>
	</ul>
</div>

<div style='position:absolute; left:10px; top:965px; width:80%'>
	<div>Chess example (<a href='https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation'>Forsyth–Edwards Notation</a>)</div>
	<pre style="width:1000px">
{'{'}"board":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"{'}'}
  e2e4 MOVE @board rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR
    e7e5 MOVE @board rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR
	</pre>
</div>
