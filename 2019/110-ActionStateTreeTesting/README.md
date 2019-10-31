# Action State Tree Testing

This is a small testing framework for Redux style reducer based applications. 

* The test scripts are language agnostic
* Tests can be based on previous states
* Based on
	* Reducers [Redux](https://redux.js.org/basics/reducers)
	* Javascript Object Notation ([JSON](https://en.wikipedia.org/wiki/JSON))
	* Reverse Polish Notation ([RPN](https://en.wikipedia.org/wiki/Reverse_Polish_notation))

## Elements allowed on the stack

	* numbers 1
	* strings A
	* arrays []
	* objects {}

# Shortcut Game

* a = 17
* b = 1

* You have three operations, affecting a: 
	* ADD +2
	* MUL *2
	* DIV /2
* Try to make a == b
* Undo is available

## Application Code

```
op = (state, value) ->
	hist = [...state.hist, state.a]
	a = value
	{...state, a, hist}

reducers = 
	ADD: (state) -> op state, state.a+2
	MUL: (state) -> op state, state.a*2
	DIV: (state) -> op state, state.a/2
	NEW: (state) -> {b:stack.pop(), a:stack.pop(), hist:[]}
	UNDO:(state) ->
		[...hist,a] = state.hist
		{...state, a, hist}	
```

## Reducers

* ADD, MUL, DIV and UNDO does not affect the stack, only the state
* NEW removes two items from the stack

## Getters

* STATE, A, B and HIST pushes one item each to the stack
* Getters are available automatically

## Sample test script

* No spaces are allowed in the JSONs
* Indentation matters
* Each line might contain zero or more reducers
* Each line might contain zero or more comparison pairs

## The stack

* Each line starts with an empty stack
* == compares the last two items on the stack
* Each == consumes two items from the stack
* Successive comparisons will be executed until the stack is empty

These lines are equivalent:
```
	A 17 ==
	17 A ==
	A 17
	17 A
```

So are these:
```
	A 17 == B 1 ==
	A 17 B 1 == ==
	A 17 B 1 ==
	A 17 B 1
	B 1 A 17
```

The script:
```
01	{"a":17,"b":1,"hist":[]}
02		A 17 B 1
03		ADD 
04			STATE {"a":19,"b":1,"hist":[17]}
05			A 19
06			B 1
07			HIST [17]
08			A 19 B 1
09			A 19 B 1 HIST [17]
10		MUL STATE {"a":34,"b":1,"hist":[17]}
11			ADD STATE {"a":36,"b":1,"hist":[17,34]}
12				UNDO STATE {"a":34,"b":1,"hist":[17]}
13		MUL ADD DIV A 18
14			17 1 NEW STATE {"a":17,"b":1,"hist":[]}
15	{"a":9,"b":8,"hist":[18]}
16		A 9 B 8
```
Indented lines are based on lines with less indentation

* line 12 is based on line 11, 10 and 01 

# Sample Error Messages

```
Orphan item found on the stack in line 18
Stack underflow in line 19
Illegal Indentation in line 20
Assertion failure in line 21
	Expect: {a:19,b:1,hist:[17]}
	Actual: {a:19,b:1,hist:[]}
```