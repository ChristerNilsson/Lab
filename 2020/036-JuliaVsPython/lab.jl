# 343 s instead of 16 in javascript. Boring.
# julia --optimize=3 sudoku.js

using CPUTime

function execute()
	primes = []
	a = 100000000
	for j in a:a+100
		i=2
		k=1
		while k!=0 && i<j
			k=j%i
			i+=1
		end
		if i==j
			push!(primes,i)
		end
	end
	println(length(primes))
end

@time @CPUtime execute()
