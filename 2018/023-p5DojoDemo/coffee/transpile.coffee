assert = (a,b=true) -> if not _.isEqual(a, b) then print JSON.stringify(a) + " != " + JSON.stringify(b)

spacesToTabs = (line) ->
	if line.indexOf('  ') == 0  then return '\t' + spacesToTabs line.substring 2
	if line.indexOf('\t') == 0  then return '\t' + spacesToTabs line.substring 1
	if line.indexOf(' \t') == 0 then return '\t' + spacesToTabs line.substring 2
	line
assert spacesToTabs('    '), '\t\t'
assert spacesToTabs('\t  '), '\t\t'
assert spacesToTabs('  \t'), '\t\t'
assert spacesToTabs(' \t  '),'\t\t'

transpile = (code) ->
	lines = code.split '\n'
	temp = (spacesToTabs(line) for line in lines)
	code = temp.join '\n'
	CoffeeScript.compile code, {bare: true}
