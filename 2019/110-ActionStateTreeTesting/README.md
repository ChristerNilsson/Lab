# Varje program tillhandahåller en RPN-tolk.
# För varje rad i testscriptet utgår man från state level angivet som första parametern. Noll innebär utgångsläge.
# == (-2 0) testar. == behöver dock ej anropas.
# Finns element kvar på stacken, testas de upprepat med ==, tills stacken är tom
# Indentering är frivilligt, numrering obligatoriskt
# Elementen på stacken kan vara 1,A,[],{} eller godtyckligt JSON

# Inledande index används för att finna förälder i trädet.
# INIT initialiserar

# Varje rad tömmer stacken. Är stacken ej tom, ska det finnas exakt jämnt antal som testas med ==

# Shortcut Game:

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

# Reducing commands
* NEW (-2 0) (consumes produces)
* ADD (0 0)
* MUL (0 0)
* DIV (0 0)

# Other commands
* STATE (0 1)
* A (0 1)
* B (0 1)
* HIST (0 1)

# Sample test script

* First line contains state 0
* Indentation is not mandatory
* First number is the state level
* State 1 is based on state 0
* No spaces are allowed in the JSONs

```
{"a":17,"b":1,"hist":[]}
0 A 17 B 1
0 ADD 
	1 STATE {"a":19,"b":1,"hist":[17]}
	1 A 19
	1 B 1
	1 HIST [17] 
	1 A 19 B 1
	1 A 19 B 1 HIST [17]
0 MUL STATE {"a":34,"b":1,"hist":[17]}
	1 ADD STATE {"a":36,"b":1,"hist":[17,34]}
		2 UNDO STATE {"a":34,"b":1,"hist":[17]}
0 MUL ADD DIV A 18
	1 INIT STATE {"a":17,"b":1,"hist":[]}
```

# Sample Error Messages

* Line 17: Orphan element found on the stack
* Line 18: Expected 17, got 19
* Line 19: Stack underflow
* Line 20: Illegal State Level
* Line 21: Expected {a:19,b:1,hist:[17]}, got {a:19,b:1,hist:[]}