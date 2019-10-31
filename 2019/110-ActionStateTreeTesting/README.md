# Varje program tillhandahåller en RPN-tolk.
# För varje rad i testscriptet utgår man från state level angivet som första parametern. Noll innebär utgångsläge.
# == (-2 0) testar. == behöver dock ej anropas.
# Finns element kvar på stacken, testas de upprepat med ==, tills stacken är tom
# Indentering är frivilligt, numrering obligatoriskt
# Elementen på stacken kan vara 1,A,[],{} eller godtyckligt JSON

# Inledande index används för att finna förälder i trädet.
# INIT initialiserar

# Varje rad tömmer stacken. Är stacken ej tom, ska det finnas exakt jämnt antal som testas med ==

# Shortcut Operationer med Signaturer:

# INIT (-2 0) (konsumerar 2 producerar 0)
# ADD (0 0)
# MUL (0 0)
# DIV (0 0)
# STATE (0 1)
# A (0 1)
# B (0 1)
# HIST (0 1)

# INIT och STATE är obligatoriska kommandon

0 17 1 INIT A 17 B 1
	1 ADD STATE {a:19,b:1,hist:[17]}
	1 ADD A 19
	1 ADD B 1
	1 ADD HIST [17]
	1 ADD A 19 B 1
	1 ADD A 19 B 1 HIST [17]
	1 MUL STATE {a:34,b:1,hist:[17]}
		2 ADD STATE {a:36,b:1,hist:[17,34]}
	1 MUL ADD DIV A 18

# Exempel på Felmeddelanden

Line 17: Orphan element found on the stack
Line 18: Expected 17, got 19
Line 19: Stack underflow
Line 20: Illegal State Level
Line 21: Expected {a:19,b:1,hist:[17]}, got {a:19,b:1,hist:[]}