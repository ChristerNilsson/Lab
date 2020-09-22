using CPUTime

function execute()
	primes = []
	a = 100000000
	limit = 10001
	for j in a+1:2:a+10000
		prime = true
		for k in 3:2:limit
			if j % k == 0
				prime = false
				break
			end
		end	
		if prime
			push!(primes,j)
		end
	end
	println(length(primes))
end
@time @CPUtime execute()
